# CI/CD Architecture & Deployment Strategy
### Build, Tracking & Promotion Specification

---

## Table of Contents

1. [Overview](#overview)
2. [Application Landscape](#application-landscape)
3. [Repository Structure Conventions](#repository-structure-conventions)
4. [Work Item Tracking](#work-item-tracking)
5. [Environment Model](#environment-model)
6. [Build Pipeline Architecture](#build-pipeline-architecture)
   - [Build Sequence Rules](#build-sequence-rules)
7. [Deployment Pipeline Architecture](#deployment-pipeline-architecture)
8. [KCOD / WCOD Synchronization](#kcod--wcod-synchronization)
9. [Partial Promotion](#partial-promotion)
10. [Rollback](#rollback)
11. [Impact Report](#impact-report)
12. [Glob Report](#glob-report)
13. [Approval Gates](#approval-gates)
14. [Artifact Lifecycle](#artifact-lifecycle)
15. [Environment Branch Tracking](#environment-branch-tracking)
16. [Architecture Diagram](#architecture-diagram)

---

## Overview

This document defines the architecture and operational strategy for a CI/CD pipeline supporting a mixed-technology codebase (Visual Studio C projects and COBOL programs). The pipeline is designed to handle **delta-based builds** (only recompile changed modules), **selective artifact promotion** across seven sequential environments, and **full impact traceability** from source commit through to production deployment.

The pipeline does **not** perform full solution rebuilds. It identifies modified modules per commit or PR, compiles only those modules, and maintains precise records of which artifacts — and which ITT tickets they resolve — are present in each environment at any point in time.

Prior to every environment deployment, approvers are provided two pre-deployment reports:

- **Impact Report** — what will be deployed and what it replaces.
- **Glob Report** — whether this deployment will combine changes from different ITT tickets on the same module, and the risk that entails.

When only a subset of modules from a build run needs to move forward independently, a **Partial Promotion** workflow creates a derived build run scoped to those modules under a new ITT ticket, without recompilation.

When a deployment needs to be reversed, a **Rollback** re-deploys the previously recorded state of the affected modules in an environment, using the provenance data held in the environment manifest.

---

## Application Landscape

| Component Type | Compiler / Toolchain | Compiled In | Notes |
|---|---|---|---|
| Visual Studio C Projects | MSVC via VS 2019 | BUILD and SVT | Compiled with environment-specific source; BUILD binary used in BUILD, SVT binary promoted through SVT and all subsequent environments |
| AGS Modules | MSVC via VS 2019 | BUILD and SVT | Non-FCP DLL projects (name starts `cug`) under `client/ags/`; bundled separately from the CSS client runtime and deployed to AGS application Windows servers via OpenSSH. SVT and STAG have no AGS servers. |
| COBOL Programs (BUILD, SVT) | AIX COBOL compiler | AIX server via OpenSSH | Compiled at deploy time on the target AIX server |
| COBOL Programs (CTST–STAG) | IBM COBOL compiler | Mainframe | Compiled at deploy time on the target mainframe; source copied via OpenSSH |
| COBOL Programs (PROD) | — | Not compiled | COBOL artifacts are not deployed to PROD via this pipeline |
| Codes Tables | FCP utility (upload) | Deployment server (Windows) | `.dat` files under `db/codestable/`; uploaded to environment KCOD database at deploy time using FCP proprietary utility |
| Translation Maps | FCP utility (upload) | Deployment server (Windows) | `.xlt` files under `client/xltmap/`; uploaded to environment KCOD database at deploy time using FCP proprietary utility |

### Key Constraints

- **C Projects**: Compiled on the Windows self-hosted runner using environment-specific source code. Separate builds are produced for BUILD and SVT. The BUILD binary is deployed to BUILD only. The SVT binary is deployed to SVT and then promoted through all remaining environments (CTST, CSTG, PTST, STAG, PROD).
- **COBOL Programs**: Compiled on AIX at **build time** as a PR validation check — changed modules are compiled in an isolated AIX area via OpenSSH; failure blocks PR progression before merge. This build-time compilation is validation-only and does not produce deployment artifacts. Deployment uses a separate compile step at deploy time. The deploy-time compiler platform differs by environment tier:
  - **BUILD and SVT**: Source is copied to the target AIX server via OpenSSH and compiled there using the AIX COBOL compiler.
  - **CTST through STAG**: Source is transferred to the mainframe and compiled using the IBM COBOL compiler.
  - **PROD**: COBOL programs are not deployed through this pipeline.
- **Large codebase**: Full recompilation is not feasible. Only modules whose source files were modified (or that appear in an override list) are compiled per pipeline run.
- **Two dedicated Windows self-hosted runners:** A **Compile server** (`[self-hosted, windows, compile]`) handles the majority of the build pipeline — diff analysis, MSBuild compilation, codes table/XLT staging, and build manifest generation. A **Deployment server** (`[self-hosted, windows, deploy]`) handles the COBOL build-time validation job (requires SSH to AIX), all deployment pipelines — report generation, artifact deployment, KCOD/WCOD sync, AGS deployment, environment manifest updates, and environment branch updates. The Deployment server requires OpenSSH access to AIX servers, mainframe, and AGS servers; the Compile server does not.
- **AGS Modules**: Compiled on the Compile server alongside standard C projects (BUILD and SVT binaries). The AGS DLL bundle is deployed separately from the CSS client runtime to AGS application Windows servers using OpenSSH. Deployment requires stopping IIS and the AGS host process before copying binaries and restarting afterwards. The AGS host process must run within a Windows user session — this requires a user session to be active on the AGS server and a mechanism (e.g. a scheduled task or a session-resident service launcher) to start the process within it. **SVT and STAG do not have AGS servers** — AGS artifacts are skipped for those environments.
- **Configurable compilation sequence:** A `build-sequence-rules.json` configuration file governs the order in which modules are compiled. Rules support type-to-type ordering (e.g., AGS DLL modules before C EXE modules), module-to-type ordering (a specific module before all modules of a given type), and module-to-module ordering (module A before module B). Rules apply to C/AGS compilation in the build workflow and to COBOL source compilation order at deploy time. A cycle in the rule graph is a fatal error.

---

## Repository Structure Conventions

Module identity is derived entirely from the folder path within the repository. The pipeline infers which modules to compile from the paths of changed files.

### `css` Repository Structure

```
css/
├── _recompiled/                  # Manual override .lst files
│
├── client/
│   ├── dialog/                   # FCP EXE modules (.gnd + EXE output)
│   │   └── <module>/             # module folder = module identifier
│   │       ├── *.c / *.h
│   │       ├── *.gnd
│   │       └── *.vcxproj
│   ├── comwin/                   # FCP DLL modules (.gnd + DLL + name ends cw)
│   │   └── <module>cw/
│   ├── ags/                      # AGS DLL modules (name starts cug, no .gnd)
│   │   └── <module>/
│   ├── common/                   # Shared DLL libraries (no .gnd): archfunc, cssfunc, etc.
│   │   └── <module>/
│   ├── include/                  # Shared C headers (NOT compiled as a module)
│   ├── bitmaps/                  # Bitmap resources
│   ├── help/                     # Help content
│   └── xltmap/                   # .xlt translation maps (build artifact → KCOD upload)
│       └── <name>.xlt
│
├── host/
│   ├── batch/                    # COBOL: Batch programs (flat — *.cbl / *.pco directly here; no per-program subfolder)
│   ├── service/                  # COBOL: Service programs
│   ├── io/                       # COBOL: I/O programs
│   ├── report/                   # COBOL: Report programs
│   ├── common/                   # COBOL: Common programs
│   ├── table/                    # COBOL: Table programs
│   ├── app/                      # Host-side C modules (genSer, etc.)
│   │   └── <module>/
│   ├── aix/                      # AIX-only code (not deployed to mainframe envs)
│   │   ├── lib/                  # AIX shared libs: olDb, kxcompUX, libC1Arch, swarch, rsam
│   │   ├── control/              # AIX JCL and schedule scripts
│   │   ├── rts/                  # AIX runtime support (rtsBAE, rtsBATCH)
│   │   └── arctl/                # AIX-only control code
│   ├── mvs/                      # MVS/mainframe-only code
│   │   └── service/
│   └── copy/                     # COBOL copybooks — NOT deployed as individual modules
│       ├── msg/                  # Message copybooks (name ends I or O) — *.cpy
│       ├── code/                 # Copybooks containing COBOL code — *.cpy
│       ├── cuv/                  # CUV copybooks (88-level, CUV prefix) — *.cpy
│       ├── lib/                  # Library/general copybooks incl. FCP-generated — *.cpy
│       ├── io/                   # I/O copybooks — *.cpy
│       └── table/                # Table copybooks — *.cpy
│
└── db/
    ├── codestable/               # Codes table .dat files (build artifact → KCOD upload)
    │   └── <name>.dat
    └── oracle/
        └── ddl/                  # Oracle DDL scripts
```

### `css-devops` Repository Structure (Preliminary)

```
css-devops/
├── client/
│   ├── app/                      # Windows dz* tools
│   │   ├── dzba01/
│   │   ├── dzct00/ .. dzct05/
│   │   ├── dzdt00/ .. dzdt04/
│   │   ├── dzio01/
│   │   ├── dzlm01/
│   │   ├── dzsf01/  dzsf02/
│   │   ├── dzsm01/
│   │   ├── dzsr00/
│   │   └── dzio_Win32/
│   └── templates/
│       └── archshel/             # Sample code templates for dialog and comwin projects
└── host/
    └── aix/                      # AIX devops tools
        ├── dzlm51/
        ├── envchk/
        └── fndCode/
```

### Module Naming Convention

- A **module** is the folder that directly contains the file(s) that define it. The folder name is the canonical module identifier used everywhere — manifests, reports, and override lists.
- Nested sub-folders within a module do not create sub-modules.
- Module types and their defining files:

| Module Type | Defining File(s) | Typical Path | Repo |
|---|---|---|---|
| C Project (dialog) | `*.vcxproj` + `*.gnd` (EXE output) | `client/dialog/<module>/` | `css` |
| C Project (comwin) | `*.vcxproj` + `*.gnd` (DLL output, name ends `cw`) | `client/comwin/<module>cw/` | `css` |
| AGS Module | `*.vcxproj`, no `.gnd`, name starts `cug` | `client/ags/<module>/` | `css` |
| C Project (shared lib) | `*.vcxproj`, no `.gnd` | `client/common/<module>/` | `css` |
| DevOps tool (Windows) | `*.vcxproj` (dz* name) | `client/app/<module>/` | `css-devops` |
| DevOps templates | Source templates (archshel) | `client/templates/archshel/` | `css-devops` |
| COBOL Program | `*.cbl`, `*.cob`, or `*.pco` | `host/<category>/<MODULE>/` | `css` |
| Host C Module | `*.c`/`*.h`, no `.vcxproj` | `host/app/<module>/` or `host/aix/lib/<module>/` | `css` |
| DevOps tool (AIX) | `*.c`/`*.h` or scripts (dz*/envchk/fndCode) | `host/aix/<module>/` | `css-devops` |
| Codes Table | `*.dat` | `db/codestable/` (flat — each `.dat` is a module) | `css` |
| Translation Map | `*.xlt` | `client/xltmap/` (flat — each `.xlt` is a module) | `css` |
| COBOL Copybook | `*.cpy` | `host/copy/<type>/` (NOT a module — not deployed) | `css` |

### `_recompiled` Override Folder

New or updated `.lst` files placed in `_recompiled/` trigger additional modules to be compiled regardless of whether their source files changed in the current commit.

**Format of a `.lst` file:**

```
# Lines starting with # are comments
ModuleGroup/CProjectFolder
ModuleGroup/CobolProgramFolder
AnotherGroup/AnotherModule
```

This mechanism supports forced recompilation after environment-level changes (e.g., shared library updates) and manual hotfix triggers without requiring source file edits.

---

## Work Item Tracking

Every change promoted through the pipeline is associated with one or more **ITT tickets** — work items managed in the internal **ITT (Issue Tracking Tool)** system. This association is the foundation for Glob Report logic and full audit traceability from source change to production deployment.

### ITT Reference Format

ITT ticket references must appear in each **commit description** (the body of the commit message, not the subject line) using the following format:

```
ITT:[<number>]
ITT:[<number>, <number>, ...]
```

**Examples:**

| Scenario | Example commit description text |
|---|---|
| Single ticket | `ITT:[123]` |
| Multiple tickets | `ITT:[123, 456]` |

**Rules:**
- The prefix `ITT:` is case-insensitive (`itt:`, `Itt:`, `ITT:`, etc. are all accepted).
- Ticket numbers are integers, comma-separated, enclosed in square brackets.
- Whitespace around commas within the brackets is permitted.
- At least one ITT reference is required on every commit that is part of a PR. Commits without an ITT reference will fail the PR validation check (see below).

### PR Validation — ITT Reference Check

A required **PR validation workflow** runs on every pull request (on `opened`, `synchronize`, and `reopened` events). It inspects every commit in the PR and enforces the following rule:

> **Every commit in the PR must contain at least one valid `ITT:[...]` reference in its commit description.**

**Validation logic:**

```
For each commit in the PR:
  1. Fetch the full commit message (subject + body).
  2. Search the message body for the pattern: ITT:\[(\d+(?:,\s*\d+)*)\]
  3. If no match is found → mark commit as INVALID.

If any commit is INVALID:
  → Fail the check with a report listing the offending commits and their SHAs.
  → Block merge until all commits are corrected (via rebase/amend or new fixup commit).

If all commits are VALID:
  → Pass the check.
  → Extracted ITT numbers are surfaced in the check summary for visibility.
```

**Extraction regex (case-insensitive flag enabled):**

```
(?i)ITT:\[(\d+(?:,\s*\d+)*)\]
```

This matches `ITT:[123]`, `ITT:[123, 456]`, `ITT:[1,2,3]`, etc. The capture group yields the raw comma-separated ticket list, which is then split and trimmed to produce individual ticket numbers.

**GitHub Actions implementation note:** This check must be configured as a **required status check** on the target branch protection rules so that it cannot be bypassed without administrator override.

### ITT Reference Extraction at Build Time

When a PR is merged and a build is triggered, the pipeline re-parses all commit messages in the build's commit range to extract ITT references. These are stored in the build manifest at both run level and per-module level.

The per-module ITT association is derived by matching the source files changed in each commit (and their resolved module) against the ITT references in that same commit's description.

### Build Manifest — Work Item Fields

Each build manifest records which ITT tickets are associated with the build run and, at module level, which tickets drove each individual module's compilation.

```json
{
  "build_run_id": "GHA-1234",
  "itt_tickets": [123, 456],
  "compiled_modules": [
    {
      "module_id": "ModuleGroup/ModuleA",
      "itt_tickets": [123]
    },
    {
      "module_id": "ModuleGroup/ModuleB",
      "itt_tickets": [456]
    }
  ]
}
```

A module may be associated with multiple ITT tickets if commits from different tickets touched the same module within the same build run.

---

## Environment Model

Changes are promoted sequentially through seven environments. Promotions are **not strictly FIFO** — a deployment may be triggered out of order relative to other pending build runs. An environment therefore contains a **composite snapshot**: artifacts from potentially many different build runs and ITT tickets.

```
BUILD → SVT → CTST → CSTG → PTST → STAG → PROD
  [✓]   [✓]   [✓]    [✓]    [✓]    [✓]    [✓]
```

> **[✓]** = Approval gate required before deployment into this environment.

| Environment | Purpose | C Projects | AGS Modules | COBOL Compile Platform |
|---|---|---|---|---|
| BUILD | Initial integration; first deployment target after a successful build | BUILD binary (env-specific source) | BUILD binary — deployed to AGS servers | AIX server (OpenSSH) |
| SVT | System Verification Testing | SVT binary (env-specific source) | **No AGS servers** — skipped | AIX server (OpenSSH) |
| CTST | Component / integration testing | SVT binary promoted | SVT binary — deployed to AGS servers | Mainframe (IBM COBOL) |
| CSTG | Component staging / pre-integration staging | SVT binary promoted | SVT binary — deployed to AGS servers | Mainframe (IBM COBOL) |
| PTST | Performance / regression testing | SVT binary promoted | SVT binary — deployed to AGS servers | Mainframe (IBM COBOL) |
| STAG | Pre-production staging | SVT binary promoted | **No AGS servers** — skipped | Mainframe (IBM COBOL) |
| PROD | Production | SVT binary promoted | SVT binary — deployed to AGS servers | Not compiled / deployed |

### Environment Composition Model

Because only delta artifacts are promoted, each environment holds a composite mix of artifacts from different build runs and potentially different work items. The environment manifest records the full provenance of every deployed module, including its originating build run, associated ITT tickets, and deployment timestamp.

**Environment branch tracking:** A dedicated Git branch exists for each environment (`build`, `svt`, `ctst`, `cstg`, `ptst`, `stag`, `prod`) in the **`css-environments`** repository. After every deployment or rollback, the Deployment server pushes an annotated commit to the environment branch recording the build run ID, source commit SHA, ITT tickets, operator, and timestamp. This provides a git-native, linear audit trail of every deployment into each environment. See [Environment Branch Tracking](#environment-branch-tracking).

---

## Build Pipeline Architecture

### Trigger Conditions

The build pipeline triggers on:
- Pull Request creation or update (PR-based diff)
- Direct push to a tracked branch (commit-based diff)
- New or modified `.lst` files in `_recompiled/`

### Build Step Sequence

```
┌──────────────────────────────────────────────────────┐
│              TRIGGER (PR / Push)                     │
│  • Extract work item references from PR / commits    │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│            1. DIFF ANALYSIS                          │
│  Runs on: Compile server                             │
│  • Get list of changed files (PR diff or git diff)   │
│  • Scan _recompiled/ for new/modified .lst files     │
│  • Map changed file paths → module identifiers       │
│  • Union of source-triggered + override modules      │
│  • Map each module → associated ITT ticket(s)        │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│            2. MODULE CLASSIFICATION                  │
│  Runs on: Compile server                             │
│  • Separate resolved modules into:                   │
│    - AGS Modules    (client/ags/, name starts cug)   │
│    - C Projects     (contains .vcxproj, non-AGS)     │
│    - COBOL Programs (contains .cbl/.cob/.pco)        │
│    - Codes Tables  (contains .dat under              │
│      db/codestable/)                                 │
│    - Translation Maps  (contains .xlt under          │
│      client/xltmap/)                                 │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         2b. COMPILATION SEQUENCE RESOLUTION          │
│  Runs on: Compile server                             │
│  • Load build-sequence-rules.json                    │
│  • Apply rules to the classified module list         │
│  • Topological sort → ordered compilation waves      │
│  • Detect cycles → fatal abort with details          │
│  • Emit ordered module list per type                 │
│    (C/AGS for build workflow;                        │
│     COBOL for build-time validation + deploy order)  │
└──────────────────────────┬───────────────────────────┘
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
┌─────────────────────────┐   ┌──────────────────────────┐
│  3a. BUILD C PROJECTS   │   │  3b. COBOL VALIDATE+STAGE │
│  Compile server         │   │  Deployment server (SSH)  │
│  VS 2019 / MSVC         │   │  1. VALIDATE: compile     │
│                         │   │     changed modules on    │
│  Built TWICE:           │   │     AIX (isolated area)   │
│  • Once with BUILD env  │   │     Failure = fatal (PR   │
│    specific source      │   │     blocked from merging) │
│  • Once with SVT env    │   │     Artifact discarded    │
│    specific source      │   │  2. STAGE: package source │
│                         │   │     for deploy-time comp: │
│  BUILD binary → BUILD   │   │     BUILD/SVT → AIX       │
│  SVT binary → SVT and   │   │     CTST–STAG → Mainframe │
│  all subsequent envs    │   │     PROD → not deployed   │
└──────────┬──────────────┘   └────────────┬─────────────┘
           │                               │
           └──────────────┬────────────────┘
                          │
                          ▼
┌──────────────────────────────────────────────────────┐
│  3c. STAGE CODES TABLE / XLT ARTIFACTS               │
│  Runs on: Compile server                             │
│  • Detect changed .dat files (db/codestable/)        │
│  • Detect changed .xlt files (client/xltmap/)        │
│  • Package as build artifacts:                       │
│    - type: CODES_TABLE  (per .dat file)              │
│    - type: XLT_MAP      (per .xlt file)              │
│  • Included in build manifest alongside COBOL        │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  3d. BUILD AGS MODULES                               │
│  Compile server / VS 2019 / MSVC                     │
│  • Detect modules under client/ags/ with changed     │
│    source (or appearing in .lst override)            │
│  • Compiled TWICE (BUILD env + SVT env source)       │
│  • AGS artifact bundle packaged separately from      │
│    the CSS client runtime artifact:                  │
│    - type: AGS_MODULE  (per module, per env_target)  │
│  • BUILD binary → BUILD (if AGS servers present)     │
│  • SVT binary → CTST, CSTG, PTST, PROD              │
│    (SVT and STAG skipped — no AGS servers)           │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         4. BUILD MANIFEST GENERATION                 │
│  Runs on: Compile server                             │
│  • Commit SHA / PR number / source_commit_sha        │
│  • Work items associated with this run               │
│  • Source files changed (per module)                 │
│  • Modules compiled, trigger reason, artifact path   │
│  • Per-module ITT ticket associations                │
│  → Stored as build manifest on pipeline-state branch │
└──────────────────────────────────────────────────────┘
```

### Build Manifest Schema

The manifest records all compiled modules. C project entries include the target environment (`BUILD` or `SVT`) since each is compiled separately with environment-specific source. COBOL entries record the staged source artifact — the actual compilation occurs at deploy time.

```json
{
  "build_run_id": "GHA-1234",
  "trigger": "PR #56 | commit abc1234",
  "source_commit_sha": "abc1234ef5678...",
  "timestamp": "2025-06-01T14:22:00Z",
  "source_branch": "feature/fix-module-a",
  "itt_tickets": [123, 456],
  "changed_source_files": [
    "ModuleGroup/ModuleA/foo.c",
    "ModuleGroup/ModuleB/bar.cbl"
  ],
  "override_modules": ["ModuleGroup/ModuleC"],
  "compiled_modules": [
    {
      "module_id": "ModuleGroup/ModuleA",
      "type": "C_PROJECT",
      "env_target": "BUILD",
      "trigger": "source_change",
      "artifact": "artifacts/BUILD/ModuleA.dll",
      "source_files": ["ModuleGroup/ModuleA/foo.c"],
      "itt_tickets": [123],
      "status": "SUCCESS"
    },
    {
      "module_id": "ModuleGroup/ModuleA",
      "type": "C_PROJECT",
      "env_target": "SVT",
      "trigger": "source_change",
      "artifact": "artifacts/SVT/ModuleA.dll",
      "source_files": ["ModuleGroup/ModuleA/foo.c"],
      "itt_tickets": [123],
      "status": "SUCCESS"
    },
    {
      "module_id": "ModuleGroup/ModuleB",
      "type": "COBOL",
      "env_target": "ALL",
      "trigger": "source_change",
      "artifact": "artifacts/COBOL/ModuleB.cbl",
      "source_files": ["ModuleGroup/ModuleB/bar.cbl"],
      "itt_tickets": [456],
      "status": "STAGED",
      "note": "Compiled at deploy time. AIX for BUILD/SVT; IBM COBOL mainframe for CTST-STAG."
    },
    {
      "module_id": "db/codestable/SOMTBL",
      "type": "CODES_TABLE",
      "env_target": "ALL",
      "trigger": "source_change",
      "artifact": "artifacts/codestable/SOMTBL.dat",
      "source_files": ["db/codestable/SOMTBL.dat"],
      "itt_tickets": [456],
      "status": "STAGED",
      "note": "Uploaded to KCOD at deploy time using FCP utility; KCOD then synced to WCOD."
    },
    {
      "module_id": "client/xltmap/SOMXLT",
      "type": "XLT_MAP",
      "env_target": "ALL",
      "trigger": "source_change",
      "artifact": "artifacts/xltmap/SOMXLT.xlt",
      "source_files": ["client/xltmap/SOMXLT.xlt"],
      "itt_tickets": [456],
      "status": "STAGED",
      "note": "Uploaded to KCOD at deploy time using FCP utility; KCOD then synced to WCOD."
    },
    {
      "module_id": "ModuleGroup/ModuleC",
      "type": "C_PROJECT",
      "env_target": "BUILD",
      "trigger": "override_lst",
      "artifact": "artifacts/BUILD/ModuleC.dll",
      "source_files": [],
      "itt_tickets": [],
      "status": "SUCCESS"
    },
    {
      "module_id": "ModuleGroup/ModuleC",
      "type": "C_PROJECT",
      "env_target": "SVT",
      "trigger": "override_lst",
      "artifact": "artifacts/SVT/ModuleC.dll",
      "source_files": [],
      "itt_tickets": [],
      "status": "SUCCESS"
    }
  ]
}
```

### Build Sequence Rules

Compilation order is governed by `build-sequence-rules.json`, a JSON array of ordering rules. Each rule specifies a `before` selector and an `after` selector; any module matching `before` must be compiled in an earlier wave than any module matching `after` when both appear in the same build run.

**Selectors** (exactly one key per selector object):

| Key | Matches |
|---|---|
| `"type": "<TYPE>"` | All modules of the given type (`C_PROJECT`, `AGS_MODULE`, `COBOL`, etc.) |
| `"module": "<id>"` | The single named module (exact module identifier) |
| `"pattern": "<prefix>/*"` | All modules whose ID begins with the given prefix |

**Rule schema:**

```json
[
  {
    "comment": "AGS DLL modules compile before all C_PROJECT (comwin/dialog) modules",
    "before": { "type": "AGS_MODULE" },
    "after":  { "type": "C_PROJECT" }
  },
  {
    "comment": "Comwin DLL modules compile before dialog EXE modules",
    "before": { "pattern": "client/comwin/*" },
    "after":  { "pattern": "client/dialog/*" }
  },
  {
    "comment": "Base shared AGS module must compile before all other AGS modules",
    "before": { "module": "client/ags/cugbase" },
    "after":  { "type": "AGS_MODULE" }
  },
  {
    "comment": "COBOL service programs compile before batch programs at deploy time",
    "before": { "pattern": "host/service/*" },
    "after":  { "pattern": "host/batch/*" }
  }
]
```

**Scope:**
- Rules referencing C/AGS module types or paths apply to the **build workflow** (compilation wave ordering).
- Rules referencing COBOL module types or `host/*` paths apply to both the **build-time validation compilation order** on AIX and the **deploy-time compilation order** (AIX for BUILD/SVT, mainframe for CTST–STAG).
- A rule may cross types; the pipeline enforces the ordering only when both the `before` and `after` modules are present in the same build run (or deploy).

**Resolution algorithm:**

1. Match each rule's `before` and `after` selectors against the classified module list.
2. Build a directed dependency graph: an edge from every matched `before` module to every matched `after` module.
3. Topological sort the graph to produce **compilation waves** — groups of modules that have no ordering dependency on each other and can compile in parallel within the wave.
4. **Cycle detection**: if a cycle is detected, abort with a fatal error listing the modules and rules involved. Do not generate a partial compilation order.

**Output:** An ordered list of compilation waves, e.g.:
```
Wave 1 (parallel): [client/ags/cugbase]
Wave 2 (parallel): [client/ags/cugfoo, client/ags/cugbar]
Wave 3 (parallel): [client/comwin/cuar01cw, client/comwin/cuar02cw]
Wave 4 (parallel): [client/dialog/cuar01, client/dialog/cuar02]
```

Modules not covered by any rule are placed in the earliest wave consistent with the constraints (or wave 1 if unconstrained).

The `resolve-build-sequence.py` script (see Implementation Guide) consumes the module list and rules and outputs the wave grouping as JSON for use by the GitHub Actions matrix.

---

## Deployment Pipeline Architecture

### Deployment Trigger

Deployment to a target environment is triggered manually (workflow dispatch with environment selector). Every deployment requires approval regardless of target environment.

### Deployment Step Sequence

```
┌──────────────────────────────────────────────────────┐
│         SELECT BUILD RUN TO DEPLOY                   │
│  (references a specific build_run_id / manifest)     │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         GENERATE IMPACT REPORT                       │
│  Runs on: Deployment server                          │
│  • Modules and source files to be deployed           │
│  • Work items associated with this deployment        │
│  • What is currently deployed in the target env      │
│  • Delta: NEW modules vs REPLACING existing          │
│  → Attached to workflow run as downloadable artifact │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         GENERATE GLOB REPORT                         │
│  Runs on: Deployment server                          │
│  • Per module: check if target env already has a     │
│    deployed version from a DIFFERENT work item       │
│  • If yes AND that prior version has not yet been    │
│    promoted into the NEXT environment → GLOB FLAG    │
│  • If both versions share the same work item → CLEAR │
│  → Attached to workflow run as downloadable artifact │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│              APPROVAL GATE                           │
│  Required for ALL environments                       │
│  • Named approver(s) notified                        │
│  • Approver reviews Impact Report and Glob Report    │
│  • Approver approves or rejects in GitHub UI         │
│  • Pipeline halts until explicit approval received   │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│              DEPLOY ARTIFACTS                        │
│  Runs on: Deployment server                          │
│                                                      │
│  C Projects (BUILD):                                 │
│    → Copy BUILD-specific binary to BUILD environment │
│                                                      │
│  C Projects (SVT and beyond):                        │
│    → Copy SVT-specific binary to environment share   │
│    → Same SVT binary promoted through CTST–PROD      │
│                                                      │
│  COBOL (BUILD, SVT):                                 │
│    → Compile in order prescribed by                  │
│      build-sequence-rules.json (wave-by-wave)        │
│    → Copy source to AIX server via OpenSSH           │
│    → Invoke AIX COBOL compiler remotely              │
│                                                      │
│  COBOL (CTST, CSTG, PTST, STAG):                     │
│    → Same sequence order; transfer source to MF      │
│    → Invoke IBM COBOL compiler remotely              │
│                                                      │
│  COBOL (PROD):                                       │
│    → Not deployed via this pipeline                  │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│   AGS MODULE DEPLOY  (if AGS_MODULE artifacts        │
│   present AND environment has AGS servers)           │
│  Runs on: Deployment server (OpenSSH to AGS servers) │
│                                                      │
│  Skipped entirely for: SVT, STAG                     │
│                                                      │
│  For all other environments (BUILD, CTST, CSTG,      │
│  PTST, PROD):                                        │
│    1. SSH to each AGS server (OpenSSH from runner)   │
│    2. Stop IIS on AGS server                         │
│    3. Stop AGS host process                          │
│       ⚠ AGS host process runs within a Windows user  │
│         session — stopping requires session-aware    │
│         mechanism (e.g. scheduled task or session    │
│         helper service triggered via SSH command)    │
│    4. Copy DLL artifact(s) to AGS install directory  │
│    5. Restart AGS host process                       │
│    6. Restart IIS                                    │
│    7. Verify service health before proceeding        │
│  ✖ Any failure is a deployment failure condition     │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│   KCOD / WCOD SYNC  (if CODES_TABLE or XLT_MAP       │
│   artifacts present in this deployment)              │
│  Runs on: Deployment server (FCP utility + OpenSSH)  │
│                                                      │
│  1. Upload changed .dat / .xlt files to target       │
│     environment's KCOD using FCP utility             │
│  2. Export KCOD to FCP transfer format               │
│  3. Transfer export file to host platform            │
│  4. Load into WCOD:                                  │
│     • BUILD / SVT  → AIX database (OpenSSH)          │
│     • CTST – PROD  → VSAM file on mainframe          │
│  5. Verify KCOD / WCOD sync completed successfully   │
│  ✖ Any failure is a deployment failure condition     │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         UPDATE ENVIRONMENT MANIFEST                  │
│  Runs on: Deployment server                          │
│  • Record deployed modules with build_run_id         │
│  • Record work items now present in this env         │
│  • Append deployment event to audit log              │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│         UPDATE ENVIRONMENT BRANCH                    │
│  Runs on: Deployment server                          │
│  Repository: css-environments                        │
│  • Checkout env branch for this environment          │
│    (create orphan branch if first deployment)        │
│  • git commit --allow-empty                          │
│    (--allow-empty required: css-environments has no  │
│     source files; commits exist solely as audit log  │
│     entries — git rejects no-change commits by       │
│     default; --allow-empty overrides this)           │
│  • Commit message: build_run_id, source_commit_sha,  │
│    ITT tickets, operator, timestamp                  │
│  • Push to css-environments origin                   │
│  • Rollback variant: message lists each module and   │
│    its restored build_run_id, plus rollback reason   │
└──────────────────────────────────────────────────────┘
```

### Environment Manifest Schema

```json
{
  "environment": "CTST",
  "last_updated": "2025-06-03T09:00:00Z",
  "deployed_modules": [
    {
      "module_id": "ModuleGroup/ModuleA",
      "type": "C_PROJECT",
      "build_run_id": "GHA-1234",
      "deployed_at": "2025-06-01T16:00:00Z",
      "artifact": "artifacts/ModuleA.dll",
      "source_files": ["ModuleGroup/ModuleA/foo.c"],
      "itt_tickets": [123]
    },
    {
      "module_id": "ModuleGroup/ModuleB",
      "type": "COBOL",
      "build_run_id": "GHA-1198",
      "deployed_at": "2025-05-28T11:30:00Z",
      "artifact": "artifacts/ModuleB.cbl",
      "source_files": ["ModuleGroup/ModuleB/bar.cbl"],
      "itt_tickets": [99]
    }
  ],
  "deployment_history": [
    {
      "event": "deploy",
      "build_run_id": "GHA-1234",
      "modules": ["ModuleGroup/ModuleA"],
      "itt_tickets": [123],
      "timestamp": "2025-06-01T16:00:00Z",
      "approved_by": "jsmith"
    }
  ]
}
```

---

## KCOD / WCOD Synchronization

### Overview

Two linked databases hold codes table and translation map content that must stay in sync across every environment:

| Database | Platform | Location |
|---|---|---|
| **KCOD** | MS Access `.mdb` | Windows deploy host, one per environment |
| **WCOD (BUILD/SVT)** | AIX database | AIX host server |
| **WCOD (CTST–PROD)** | VSAM file | Mainframe |

### What Triggers a Sync

A KCOD/WCOD sync is required whenever one or more `CODES_TABLE` (`.dat`) or `XLT_MAP` (`.xlt`) artifacts are included in a deployment. If no such artifacts are present, the sync step is skipped.

### Sync Process

1. **Upload to KCOD** — FCP proprietary utility uploads the changed `.dat` and `.xlt` files into the target environment's KCOD database.
2. **Export KCOD** — KCOD content is exported to an FCP transfer format file.
3. **Transfer to host** — The export file is copied to the host platform.
4. **Load into WCOD** — The export is loaded into the WCOD for that environment:
   - **BUILD and SVT**: loaded into the AIX database via OpenSSH.
   - **CTST through PROD**: loaded into the VSAM file on the mainframe.
5. **Verify sync** — The pipeline confirms load success before proceeding to the manifest update step.

### Failure Handling

A failed KCOD/WCOD sync is a **deployment failure condition**. The deployment pipeline must not proceed to the manifest update step if the sync fails. The environment manifest will not reflect the deployment until the sync is confirmed.

### Key Constraints

- FCP utility is a Windows-only executable; the upload step always runs on the Windows self-hosted runner.
- KCOD and WCOD must remain in sync per environment at all times. Manual fixes to KCOD without a corresponding WCOD update will cause discrepancies that may only surface at runtime.
- The pipeline does not currently perform KCOD/WCOD diff checking before deployment — it uploads all staged `.dat`/`.xlt` artifacts regardless of whether the environment already holds that version.

---

## Partial Promotion

A **partial promotion** allows a subset of modules from an existing build run to be split off, re-associated with a new ITT ticket, and promoted independently — without recompilation. The remaining modules stay associated with the original build run and ITT ticket and continue through the pipeline on their own schedule.

### When to Use

- A subset of modules from a build run is needed urgently under a different ITT ticket while the rest are not yet ready to promote.
- QA or a release manager determines that only certain fixes within a build run should advance to the next environment.
- Modules from a build run need to be re-scoped to a different ITT ticket for tracking or approval purposes.

### How It Works

A partial promotion creates a **derived build run** — a new, first-class manifest entry that references the original build run as its source. No compilation occurs. Artifacts are referenced directly from the original build run's artifact store.

```
┌──────────────────────────────────────────────────────┐
│         PARTIAL PROMOTION WORKFLOW                   │
│                                                      │
│  Inputs:                                             │
│  • Source build run ID                               │
│  • Selected module subset                            │
│  • New ITT ticket number(s)                          │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  1. VALIDATE MODULE SELECTION                        │
│  • All selected modules must exist in source run     │
│  • At least one module must be selected              │
│  • New ITT ticket(s) must be provided                │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  2. CREATE DERIVED BUILD RUN MANIFEST                │
│  • New build_run_id generated (e.g. GHA-1234-P1)    │
│  • source_build_run_id references original run       │
│  • Includes only the selected module subset          │
│  • ITT tickets set to the new ticket(s)              │
│  • Artifacts point to originals — no recompilation   │
│  • derivation_reason recorded for audit trail        │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  3. DERIVED RUN ENTERS DEPLOYMENT PIPELINE           │
│  • Treated identically to a standard build run       │
│  • Impact Report and Glob Report generated           │
│  • Approval gate required as normal                  │
│  • Only the selected modules are deployed            │
└──────────────────────────────────────────────────────┘
```

The **original build run remains valid**. Its remaining modules (those not selected for the partial promotion) are unaffected and can still be deployed independently under their original ITT ticket.

### Derived Build Run Manifest Schema

```json
{
  "build_run_id": "GHA-1234-P1",
  "derived_from": {
    "source_build_run_id": "GHA-1234",
    "derivation_reason": "Partial promotion — subset of modules split to ITT-789",
    "derived_at": "2025-06-05T11:00:00Z",
    "derived_by": "jsmith"
  },
  "trigger": "partial_promotion",
  "timestamp": "2025-06-05T11:00:00Z",
  "itt_tickets": [789],
  "compiled_modules": [
    {
      "module_id": "ModuleGroup/ModuleA",
      "type": "C_PROJECT",
      "env_target": "BUILD",
      "trigger": "partial_promotion",
      "artifact": "artifacts/BUILD/ModuleA.dll",
      "source_files": ["ModuleGroup/ModuleA/foo.c"],
      "itt_tickets": [789],
      "status": "SUCCESS",
      "note": "Artifact sourced from GHA-1234. No recompilation performed."
    },
    {
      "module_id": "ModuleGroup/ModuleA",
      "type": "C_PROJECT",
      "env_target": "SVT",
      "trigger": "partial_promotion",
      "artifact": "artifacts/SVT/ModuleA.dll",
      "source_files": ["ModuleGroup/ModuleA/foo.c"],
      "itt_tickets": [789],
      "status": "SUCCESS",
      "note": "Artifact sourced from GHA-1234. No recompilation performed."
    }
  ]
}
```

### Glob Report Behaviour for Derived Runs

A derived build run participates in Glob Report evaluation identically to any other build run. Because it carries a new ITT ticket, it may itself trigger a glob flag if the target environment already contains a version of the same module from a different ticket. The approver must review this as they would any other deployment.

Additionally, the **original build run's remaining modules** may now be at glob risk if the derived run is promoted ahead of them into subsequent environments. This is expected and visible in the Glob Report when those remaining modules are later deployed.

### Constraints and Considerations

- A partial promotion can only be initiated against modules that exist in the **source build run's manifest**. It cannot introduce modules from other build runs.
- Partial promotions are **not recursive** — a derived run cannot itself be the source of another partial promotion.
- The derived run is a permanent audit record. It cannot be deleted or modified after creation.
- If the new ITT ticket is later determined to be incorrect, a new partial promotion must be created with the correct ticket; the original derived run remains in the audit history.

---

## Rollback

A rollback reverses the effect of a deployment by re-deploying the previously recorded state of one or more modules in a target environment. Because each environment manifest holds full provenance — which build run and which artifacts were deployed per module — the pipeline always has the information needed to restore a prior state without requiring a new build.

### Scope of Rollback

Rollback operates at the **module level**, not at the environment level. A full environment rollback (reverting every module simultaneously) is a special case of module-level rollback where all modules are selected.

| Rollback Type | Description |
|---|---|
| Single module | Revert one module to its previously deployed version |
| Multi-module | Revert a selected set of modules in a single approved operation |
| Full environment | Revert all modules in an environment to their state before the last deployment event |

### Mechanism

The environment manifest records a `deployment_history` log for each environment. Each history entry captures the full pre-deployment state of every module that was replaced. A rollback reads the relevant history entry and re-deploys the prior artifacts from their original build run, exactly as a normal deployment would — including the approval gate.

```
┌──────────────────────────────────────────────────────┐
│         ROLLBACK WORKFLOW                            │
│                                                      │
│  Inputs:                                             │
│  • Target environment                                │
│  • Module(s) to roll back                            │
│  • Target history entry (defaults to previous)       │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  1. RESOLVE PRIOR STATE                              │
│  • Read environment manifest deployment_history      │
│  • Identify the build_run_id and artifact that was   │
│    deployed for each selected module before the      │
│    most recent deployment                            │
│  • If no prior state exists for a module → error     │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  2. GENERATE ROLLBACK IMPACT REPORT                  │
│  • Shows current state and what it will revert to    │
│  • Flags any modules with no prior state available   │
│  • Notes ITT tickets being removed from environment  │
│  → Attached to workflow run as downloadable artifact │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  3. APPROVAL GATE                                    │
│  Required — same gate rules as forward deployments   │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  4. RE-DEPLOY PRIOR ARTIFACTS                        │
│  • Artifacts sourced from original build run store   │
│  • Same deployment mechanism as forward deploy       │
│    (C binary copy / COBOL SSH compile)               │
│  • No recompilation                                  │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│  5. UPDATE ENVIRONMENT MANIFEST                      │
│  • Restore prior module entries                      │
│  • Append rollback event to deployment_history       │
│    with rollback flag, operator, and timestamp       │
└──────────────────────────────────────────────────────┘
```

### Environment Manifest — Rollback History Entry

```json
{
  "event": "rollback",
  "rolled_back_build_run_id": "GHA-1234",
  "restored_build_run_id": "GHA-1190",
  "modules": ["ModuleGroup/ModuleA"],
  "itt_tickets_removed": [123],
  "itt_tickets_restored": [99],
  "timestamp": "2025-06-10T14:00:00Z",
  "approved_by": "jsmith",
  "reason": "ModuleA causing downstream failures in CTST"
}
```

### Constraints and Considerations

- **Rollback depth:** The manifest history records every deployment event, so rollback can target any prior state — not just the immediately preceding one. The operator selects the target history entry at rollback initiation.
- **No rollback to BUILD or SVT from CTST+:** A rollback restores modules within the same environment. It does not reverse promotion to a prior environment — that requires a separate deployment decision in the prior environment.
- **COBOL rollback recompiles:** Because COBOL is compiled at deploy time, a rollback re-runs the compile step on the AIX server or mainframe using the source from the prior build run. The source artifact must still be available in the build run store.
- **C project rollback:** The prior binary is re-copied from the original build run artifact store. No recompilation.
- **Glob implications:** After a rollback, the environment's module state may differ from the next environment in the chain. The next forward deployment will reflect this correctly via the Glob Report.
- **Approval required:** Rollbacks are not exempt from the approval gate. The rollback impact report serves as the pre-gate artefact for approver review.
- **Artifact retention:** Build run artifacts must be retained long enough to support rollback. Artifact expiry policy should account for the maximum rollback window required by the team.
- **Module-scope only (R1):** Rollback affects only the explicitly selected modules. No cascading to other modules from the same historical build run. Example: if rolling back build run GHA-1300 (which contained ModuleB and ModuleC), and the prior version of ModuleB came from GHA-1200 (which also contained ModuleA), ModuleA is NOT affected — it remains at its current deployed version.
- **No prior state (R2):** If a module's first-ever deployment in the environment was part of the build run being rolled back, there is no prior state to restore. The module is flagged `NO_PRIOR_STATE` in the rollback impact report and EXCLUDED from rollback scope. The pipeline does not support module removal. The operator must exclude the module or abort.
- **Artifact availability validated before approval gate (R3):** Prior binaries (C projects, AGS modules) and prior source packages (COBOL) must still exist in the artifact store. The pre-gate job validates artifact availability for each selected module. Modules with expired/purged artifacts are flagged `ARTIFACT_UNAVAILABLE` and excluded from rollback scope.
- **SUPERSEDED_ROLLBACK flag (R4, Scenario 1):** If a module's current version is from a MORE RECENT build run than the one being rolled back, the impact report flags it as `SUPERSEDED_ROLLBACK`. For example: GHA-1100 deploys ModuleA v1, GHA-1200 deploys ModuleA v2, GHA-1300 deploys ModuleA v3 (current). Rolling back to before GHA-1200 restores ModuleA to v1 and also implicitly undoes GHA-1300. The report shows: current version, rollback target run, what will actually be restored, and all intermediate deployments being skipped. Non-blocking — the approver decides.
- **No recursive rollback (R6):** Rollback events in `deployment_history` (entries where `event == "rollback"`) are skipped when resolving prior state. Prior state is resolved by walking backwards through `deploy` events only.
- **Cross-environment isolation (R8):** Rollback in environment X has no effect on X-1 or X+1. The next forward deployment from X to X+1 will reflect the rolled-back state; the Glob Report will detect and flag any version discrepancies.
- **Environment branch updated on rollback:** The `css-environments` env branch is updated with an annotated empty commit after the manifest update: `rollback: restore <ENV> | <module>→GHA-<prior_id> [, ...] | reason: <reason> | approved by <operator> | <timestamp>`. Forward-only — no force-push.

---

## Impact Report

The Impact Report is generated before every deployment and made available to approvers before the gate decision. It answers: **"What exactly will change in this environment if this deployment proceeds?"**

### Report Contents

| Section | Description |
|---|---|
| Build Summary | Build run ID, trigger (PR/commit), branch, timestamp |
| ITT Tickets | All ITT ticket numbers associated with this deployment |
| Modules to Deploy | Module ID, type (C/COBOL), trigger reason (source change / override) |
| Source File Inventory | Source files per module included in this deployment |
| Current Environment State | What build run and ITT ticket(s) are currently deployed per module |
| Delta Analysis | Per module: **NEW** (not yet in env) or **REPLACING** (superseding existing) |

### Delta Classification

| Status | Meaning |
|---|---|
| `NEW` | Module is not currently present in the target environment |
| `REPLACING` | Module exists in target env; this deployment will overwrite it |

The report is persisted as a file artifact attached to the GitHub Actions deployment workflow run and is accessible via the GitHub UI prior to the approval gate decision.

---

## Glob Report

The Glob Report is generated alongside the Impact Report before every deployment. It answers: **"Does deploying this build run cause changes from different ITT tickets to be merged ('globbed') together in this environment?"**

### Definition of a Glob

A **glob** occurs when all of the following are true:

1. A module is being deployed from build run **B**, associated with ITT ticket **T-new**.
2. The target environment already has that module deployed from a prior build run **A**, associated with ITT ticket **T-prev**.
3. **T-prev** and **T-new** are **different ITT tickets** (no overlap).
4. The version from build run **A** has **not yet been promoted** into the next environment in the chain.

When all four conditions are met, deploying build run **B** will silently absorb the prior ticket's changes — meaning **T-prev** can no longer be independently evaluated or promoted from this environment.

A glob is **not flagged** when both changes share the same ITT ticket, even if they come from different build runs or commits.

### Glob Detection Logic (per module)

```
For each module M in the incoming deployment (build run B, ITT tickets T_new):

  1. Look up the currently deployed version of M in the target environment.
     If M is not deployed → Status = CLEAR (no prior version to collide with).

  2. Let A       = build run currently deployed for M in this environment.
     Let T_prev  = ITT tickets associated with A.

  3. If T_prev ∩ T_new is non-empty → Status = CLEAR (same ITT ticket, not a glob).

  4. Check whether M from build run A is already present in the NEXT environment.
     If yes → Status = CLEAR (T_prev already promoted, no longer at risk).

  5. Otherwise → Status = GLOB ⚠️
     Record: module, incoming ITT ticket(s), existing ITT ticket(s), next environment.
```

### Glob Report Schema

```json
{
  "report_type": "GLOB",
  "generated_at": "2025-06-04T10:00:00Z",
  "deployment": {
    "build_run_id": "GHA-1234",
    "target_environment": "CTST",
    "next_environment": "CSTG"
  },
  "module_results": [
    {
      "module_id": "ModuleGroup/ModuleA",
      "status": "GLOB",
      "incoming_build_run": "GHA-1234",
      "incoming_itt_tickets": [123],
      "existing_build_run": "GHA-1190",
      "existing_itt_tickets": [99],
      "existing_promoted_to_next": false,
      "notes": "ITT-99 changes in CTST have not reached CSTG. Deploying will combine with ITT-123."
    },
    {
      "module_id": "ModuleGroup/ModuleB",
      "status": "CLEAR",
      "incoming_build_run": "GHA-1234",
      "incoming_itt_tickets": [123],
      "existing_build_run": "GHA-1190",
      "existing_itt_tickets": [123],
      "existing_promoted_to_next": false,
      "notes": "Same ITT ticket — not a glob."
    },
    {
      "module_id": "ModuleGroup/ModuleC",
      "status": "CLEAR",
      "incoming_build_run": "GHA-1234",
      "incoming_itt_tickets": [],
      "existing_build_run": null,
      "existing_itt_tickets": [],
      "existing_promoted_to_next": null,
      "notes": "Module not previously deployed to this environment."
    }
  ],
  "summary": {
    "total_modules": 3,
    "glob_count": 1,
    "clear_count": 2,
    "glob_modules": ["ModuleGroup/ModuleA"]
  }
}
```

### Glob Report — Approver Guidance

The Glob Report does **not** automatically block a deployment. It is a transparency and risk-awareness tool. The approver decides whether to proceed given the flagged globs.

| Glob Count | Suggested Approver Action |
|---|---|
| 0 globs | Proceed normally |
| 1+ globs | Review affected ITT tickets; confirm it is acceptable to combine them in this environment at this time |
| Critical module globbed | Consider deferring one deployment or coordinating with both ITT ticket owners before approving |

---

## Approval Gates

An approval gate is required **before deployment into every environment**, including BUILD.

| Deployment Target | Approval Required | Notes |
|---|---|---|
| → BUILD | Yes | First gate after a successful build run |
| → SVT | Yes | |
| → CTST | Yes | |
| → CSTG | Yes | |
| → PTST | Yes | |
| → STAG | Yes | |
| → PROD | Yes | Typically requires senior / release approver |

### Approver Workflow

1. Deployment pipeline generates the **Impact Report** and **Glob Report**.
2. Both reports are attached as downloadable artifacts to the GitHub Actions workflow run.
3. Pipeline pauses at the approval gate via GitHub Environment protection rules.
4. Approver is notified (GitHub notification or team channel).
5. Approver navigates to the workflow run and downloads and reviews both reports.
6. Approver approves or rejects the deployment in the GitHub Environments UI.
7. On approval: pipeline resumes and proceeds to deploy.
8. On rejection: pipeline stops; the rejection reason (comment) is captured in the deployment history.

### GitHub Environments Setup

Each of the seven environments should be configured in GitHub repository settings under **Environments** with:
- **Required reviewers** — named users or teams authorized to approve deployment into that environment.
- **Wait timer** (optional) — minimum delay between gate trigger and earliest allowed approval.
- **Deployment branch restriction** — restrict deployments to expected source branches only.

---

## Artifact Lifecycle

```
[PR / Commit]
  • Each commit description must contain ITT:[<number(s)>] — validated before merge
  • ITT ticket references extracted from commit descriptions at build time
        │
        ▼
[Build Run]
  • Diff analysis identifies changed modules
  • C projects compiled on Compile server — TWICE (BUILD-specific and SVT-specific binaries)
  • C project artifacts scoped to BUILD and SVT only; not promoted further
  • AGS modules compiled TWICE alongside C projects — bundled as a separate AGS artifact
  • COBOL source staged for per-environment compilation at deploy time
  • Codes Table (.dat) and XLT Map (.xlt) files staged as CODES_TABLE / XLT_MAP artifacts
  • Build Manifest generated (modules + artifacts + ITT tickets)
        │
        ├──────────────────────────────────────────────┐
        │                                              │
        ▼                                              ▼ (optional)
[Standard deployment path]               [Partial Promotion]
                                           • Select module subset
                                           • Assign new ITT ticket(s)
                                           • Derived build run created
                                           • No recompilation
                                           • Enters deployment pipeline
                                             as a first-class build run
        │                                              │
        └──────────────────────────────────────────────┘
                               │
                               ▼
[For each target environment — in sequence]

  ┌─────────────────────────────────────────────────────┐
  │  Generate Impact Report  (what deploys / replaces)  │
  │  Generate Glob Report    (ITT collision check)      │
  │  ↓                                                   │
  │  Approval Gate  ── rejected ──► Stop / Log          │
  │  ↓ approved                                          │
  │  Deploy Artifacts                                    │
  │    C Projects (BUILD)                                │
  │      → deploy BUILD-specific binary                  │
  │    C Projects (SVT → PROD)                           │
  │      → deploy SVT-specific binary (same for all)    │
  │    AGS Modules (BUILD, CTST, CSTG, PTST, PROD)      │
  │      → OpenSSH → stop services → copy DLL           │
  │      → restart services [SVT/STAG: skipped]         │
  │    COBOL (BUILD/SVT)                                 │
  │      → SSH to AIX, copy source, compile              │
  │    COBOL (CTST–STAG)                                 │
  │      → transfer to mainframe, IBM COBOL compile      │
  │    COBOL/C (PROD) → not deployed via pipeline        │
  │  Update Environment Manifest  (Deployment server)    │
  │    → composite state: modules + build runs + ITT tickets │
  │  Update Environment Branch  (Deployment server)     │
  │    → git commit --allow-empty on css-environments   │
  │    → records build_run_id, source_commit_sha, ITT   │
  └──────────────────────┬──────────────────────────────┘
                         │
          ┌──────────────┴──────────────┐
          ▼                             ▼ (if rollback required)
  [Continue to next env]        [Rollback Workflow]
                                  • Select module(s) + target
                                    prior history entry
                                  • Generate Rollback Impact Report
                                    (includes SUPERSEDED_ROLLBACK,
                                     NO_PRIOR_STATE, ARTIFACT_UNAVAILABLE
                                     flags — see Rollback section)
                                  • Approval Gate
                                  • Re-deploy prior artifacts
                                    (no recompilation for C/AGS;
                                     COBOL recompiled from
                                     prior source on AIX/mainframe)
                                  • Update Environment Manifest
                                    → rollback event logged
                                  • Update Environment Branch
                                    → git commit --allow-empty
                                      on css-environments
        │
        ▼  (repeat for each successive environment)
  BUILD → SVT → CTST → CSTG → PTST → STAG → PROD
```

**Key point:** The environment manifest at every stage captures the full composite state — which build run and which ITT tickets produced each deployed module, even across non-contiguous and out-of-order promotions. This is the data source for both the Impact Report and the Glob Report at each subsequent promotion step.

---

## Environment Branch Tracking

### Repository

A dedicated **`css-environments`** repository holds one branch per environment. This keeps deployment audit history separate from source code and serves as a unified audit trail for deployments spanning both `css` and `css-devops`.

### Branch Naming

| Branch | Environment |
|---|---|
| `build` | BUILD |
| `svt` | SVT |
| `ctst` | CTST |
| `cstg` | CSTG |
| `ptst` | PTST |
| `stag` | STAG |
| `prod` | PROD |

### Purpose

Each branch holds a linear history of annotated commits — one per deployment or rollback event. The branch is not a buildable snapshot of the codebase (deployments are delta-based and each adds only the changed modules). It is a git-native audit log that lets any developer run `git log --oneline build` to see every deployment into BUILD in chronological order.

### Update Mechanism — `git commit --allow-empty`

All updates use `git commit --allow-empty` with a structured commit message. `--allow-empty` is required because no source files are modified in `css-environments` — the repository exists solely as an audit log. By default, git rejects commits that introduce no file changes; `--allow-empty` overrides this so that each deployment or rollback is recorded as a commit.

Both forward deployments and rollbacks use the same mechanism. Cross-repo merges (`git merge <sha-from-css-or-css-devops>`) are not supported by git and cannot be used.

**Commit message formats:**

| Event | Format |
|---|---|
| Deployment | `deploy: GHA-<id> → <ENV> \| src: <source_commit_sha> \| ITT:[<tickets>] \| approved by <operator> \| <timestamp>` |
| Rollback | `rollback: restore <ENV> \| <module>→GHA-<id> [, ...] \| reason: <reason> \| approved by <operator> \| <timestamp>` |
| Partial promotion | `deploy(partial): GHA-<id>-P1 (from GHA-<id>) → <ENV> \| src: <source_commit_sha> \| ITT:[<tickets>] \| approved by <operator>` |

The `src:` field records the source commit SHA from the `css` or `css-devops` repository. Developers can look it up in the appropriate source repo to see exactly what code was compiled for that deployment.

### Bootstrapping

On the first deployment to an environment, the branch does not yet exist. The pipeline creates it as an orphan branch (`git checkout --orphan <env>`), removes any working directory content, and pushes the first annotated commit. No pre-seeding is required.

### Rollback and Multi-Build-Run Events

When a rollback restores modules from different build runs (e.g., ModuleB from GHA-1200, ModuleC from GHA-1100), all restored modules are listed in a single commit message. No source SHA merge is attempted — the commit message provides the full audit record.

### Branch Protection

In `css-environments`, configure the following for all branches:
- Block direct pushes and force pushes.
- Allow push only from the pipeline's `ENV_BRANCH_TOKEN` service account (GitHub App or PAT with `contents: write` on `css-environments`).
- No PR review required — the deployment pipeline must be able to push directly.

### Concurrency and Retry

Env-branch updates are serialized by the same per-environment `concurrency: deploy-<environment>` group that controls the rest of the deploy workflow. Because only one deploy job per environment runs at a time, push conflicts cannot occur. No exponential-backoff retry is needed (unlike the `pipeline-state` manifest branch).

### Relationship to `pipeline-state`

The `pipeline-state` branch (JSON manifests) remains in the `css` source repository and is unchanged by this feature. The `css-environments` branches and `pipeline-state` are complementary: manifests provide machine-readable provenance; env branches provide human-readable git history.

---

## Architecture Diagram

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                            SOURCE REPOSITORY                                 │
│  ┌─────────────┐   ┌───────────────────┐   ┌──────────────────────────────┐ │
│  │  C Projects │   │  COBOL Programs   │   │  _recompiled/*.lst           │ │
│  │  (*.vcxproj)│   │  (*.cbl / *.cob)  │   │  (manual override lists)     │ │
│  └──────┬──────┘   └────────┬──────────┘   └────────────┬─────────────────┘ │
│         │   PR / Push + ITT ticket refs extracted           │                   │
└─────────┴───────────────────┴────────────────────────────┴───────────────────┘
                              │
                              ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│           COMPILE SERVER  [self-hosted, windows, compile]                    │
│              (Windows Server, VS 2019 Build Tools)                           │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  BUILD WORKFLOW                                                       │   │
│  │  [Diff Analysis + ITT Ticket Extraction]                              │   │
│  │    → [Module Classification: AGS | C Projects | COBOL | ...]         │   │
│  │        → [C Build + AGS Build via MSVC — built TWICE each]           │   │
│  │              • BUILD env-specific binaries  ──────────────────────┐  │   │
│  │              • SVT   env-specific binaries  ──────────────────────┤  │   │
│  │        → [COBOL source staged for deploy-time compilation]  ──────┤  │   │
│  │                                                                    │  │   │
│  │  [Build Manifest: modules + source_commit_sha + ITT tickets] ◄────┘  │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  PARTIAL PROMOTION WORKFLOW  (optional, on demand)                   │   │
│  │  [Select source build run + module subset + new ITT ticket(s)]       │   │
│  │    → [Validate selection]                                             │   │
│  │    → [Create derived build run manifest — no recompilation]          │   │
│  │    → [Derived run enters deploy pipeline as first-class build run]   │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│          DEPLOYMENT SERVER  [self-hosted, windows, deploy]                   │
│     (Windows Server, VS 2019 Build Tools + OpenSSH to AIX / MF / AGS)       │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  DEPLOY WORKFLOW  (runs per target environment)                      │   │
│  │                                                                       │   │
│  │  [Select Build Run (standard or derived)]                             │   │
│  │    → [Impact Report] ──────────────────────► attached to run         │   │
│  │    → [Glob Report]   ──────────────────────► attached to run         │   │
│  │    → [Approval Gate] ◄── approver reviews both reports               │   │
│  │         │ approved                                                    │   │
│  │         ▼                                                             │   │
│  │  C Projects  (BUILD)                                                 │   │
│  │    → deploy BUILD-specific binary                                    │   │
│  │  C Projects  (SVT → PROD)                                            │   │
│  │    → deploy SVT-specific binary (same binary for all)               │   │
│  │  AGS Modules  (BUILD, CTST, CSTG, PTST, PROD)                       │   │
│  │    → OpenSSH to each AGS server                                      │   │
│  │    → stop IIS + AGS host process (session-aware)                    │   │
│  │    → copy DLL → restart services → verify health                    │   │
│  │    [SVT and STAG skipped — no AGS servers]                          │   │
│  │  COBOL  (BUILD / SVT)                                                │   │
│  │    → SSH to AIX server → copy source → AIX COBOL compile            │   │
│  │  COBOL  (CTST / CSTG / PTST / STAG)                                 │   │
│  │    → transfer to mainframe → IBM COBOL compile                      │   │
│  │  COBOL / C  (PROD) → not deployed via this pipeline                 │   │
│  │  CODES_TABLE / XLT_MAP  (if present in deployment)                  │   │
│  │    → FCP utility uploads .dat / .xlt to KCOD                        │   │
│  │    → Export KCOD → transfer to host → load into WCOD                │   │
│  │      • BUILD/SVT: WCOD = AIX database                               │   │
│  │      • CTST–PROD: WCOD = VSAM file on mainframe                     │   │
│  │  [Update Env Manifest]  → composite state + ITT ticket provenance   │   │
│  │  [Update Env Branch]    → git commit --allow-empty                  │   │
│  │                           on css-environments/<env-branch>          │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────┘

   BUILD → SVT → CTST → CSTG → PTST → STAG → PROD
    [✓]    [✓]   [✓]    [✓]    [✓]    [✓]    [✓]   ← Approval gate at EVERY env

   Compile server:  BUILD + AGS modules built TWICE (BUILD + SVT env source)
                    COBOL source staged; Codes Table / XLT artifacts staged
                    Build Manifest written to pipeline-state branch (css repo)
   C Projects:   BUILD binary → BUILD only
                 SVT binary   → SVT and promoted through CTST, CSTG, PTST, STAG, PROD
   AGS Modules:  BUILD binary → BUILD (AGS servers only)
                 SVT binary   → CTST, CSTG, PTST, PROD (AGS servers only)
                 SVT + STAG   → skipped (no AGS servers in these environments)
                 Deploy: OpenSSH → stop IIS + AGS host process → copy → restart
   COBOL:        compiled at deploy time in BUILD–STAG; not deployed to PROD
                   BUILD/SVT  → AIX server via OpenSSH
                   CTST–STAG  → mainframe via IBM COBOL

   Pre-gate approver artifacts (generated per deployment):
     ├── impact-report.json   what deploys, what it replaces, ITT tickets
     └── glob-report.json     per-module ITT ticket collision detection

   Glob flag conditions (ALL must be true):
     1. Module already exists in target env (from a prior build run)
     2. Prior version is associated with a DIFFERENT ITT ticket
     3. Prior version has NOT yet been promoted to the next environment

   css-environments repo:  one branch per environment (build, svt, ctst, …)
     → git commit --allow-empty after every deployment and rollback
     → commit message records build_run_id, source_commit_sha, ITT tickets,
       operator, and timestamp
```

---

## Version History

| Version | Date | Author | Summary of Changes |
|---|---|---|---|
| 0.01 | 2026-03-12 | Alan Chin | Draft |
| 0.02 | 2026-03-17 | Alan Chin | Added AGS module type: Application Landscape table, Module Naming table, environment model (SVT/STAG have no AGS servers), Build Step Sequence (3d), Deployment Step Sequence (AGS deploy step with service stop/restart notes), Artifact Lifecycle, Architecture Diagram |
| 0.03 | 2026-03-17 | Alan Chin | Two-runner split (Compile server / Deployment server); Environment Branch Tracking section (css-environments repo, annotated empty commits, rollback restrictions R1–R9, SUPERSEDED_ROLLBACK / NO_PRIOR_STATE / ARTIFACT_UNAVAILABLE statuses); source_commit_sha added to Build Manifest Schema; Architecture Diagram split into Compile/Deployment server boxes |
| 0.04 | 2026-03-17 | Alan Chin | Build Sequence Rules: new subsection with rule schema (type/module/pattern selectors), wave-based topological sort, cycle detection; step 2b (Compilation Sequence Resolution) added to Build Step Sequence diagram; COBOL deploy step notes sequence ordering; Key Constraints bullet added |
| 0.05 | 2026-03-18 | Alan Chin | COBOL build-time validation: step 3b in Build Step Sequence diagram updated to VALIDATE+STAGE (validate on AIX at PR time, failure blocks PR, artifact discarded; stage source for deploy-time compilation); Key Constraints COBOL bullet clarified; two-runner bullet updated to note deploy server handles COBOL validation job (requires SSH); compilation sequence resolver note updated; sequence rules COBOL scope note updated |

---

*Document version: 0.05 | Status: Draft*
