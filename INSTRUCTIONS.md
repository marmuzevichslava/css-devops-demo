
# Next Session — What To Do

## Status as of 2026-05-20

All core pipeline scripts written and tested locally. Ready to push and test on real runners.

### Done
- `scripts/itt_check.py` — validates ITT:[number] in every PR commit message
- `scripts/diff_analysis.py` — maps changed files to module IDs
- `scripts/classify_modules.py` — classifies modules by type (C_PROJECT, COBOL, etc.)
- `scripts/resolve_build_sequence.py` — topological sort → compilation waves
- `scripts/build_manifest.py` — generates build_manifest.json after compile
- `.github/workflows/pr-validation.yml` — runs ITT check on every PR (compile runner)
- `.github/workflows/build.yml` — runs after merge to main (compile runner)
- `.github/workflows/deploy.yml` — manual deploy with approval gate (deploy runner)
- `build-sequence-rules.json` — compilation order rules
- Runner labels added in GitHub: compile (azuse-cssdapp01), deploy (azuse-cssdapp02)

### Placeholders (need Alan's input)
- MSBuild flags for BUILD vs SVT compilation
- FCP tooling path on azuse-cssdapp01
- Exact DLL path on cssapp share (`\\azuse-cssdapp02\cssapp\BUILD\client\???`)
- AGS modules — exact location in repo (pulled out of client/ags — where are they now?)
- host/batch — final location after restructure

---

## Step 1 — Push scripts to repo

```bash
cd /Users/homefolder/Downloads/analyse-sync/css-devops-demo

git add .github/workflows/pr-validation.yml \
        .github/workflows/build.yml \
        .github/workflows/deploy.yml \
        scripts/itt_check.py \
        scripts/diff_analysis.py \
        scripts/classify_modules.py \
        scripts/resolve_build_sequence.py \
        scripts/build_manifest.py \
        build-sequence-rules.json

git commit -m "Add PR validation workflow and core pipeline scripts"
git push origin analyze-sync
```

---

## Step 2 — Test PR validation on real runner

1. Create a new branch in css-devops-demo
2. Make a small change to any file (e.g. add a comment to a script)
3. Open a PR — this triggers `pr-validation.yml`

**Test 1 — should FAIL (no ITT in commit):**
```bash
git checkout -b test/itt-check-fail
echo "# test" >> scripts/itt_check.py
git add scripts/itt_check.py
git commit -m "test commit without ITT reference"
git push origin test/itt-check-fail
# Open PR → expect workflow to fail with exit code 1
```

**Test 2 — should PASS (ITT present):**
```bash
git checkout -b test/itt-check-pass
echo "# test" >> scripts/itt_check.py
git add scripts/itt_check.py
git commit -m "test commit

ITT:[9999]"
git push origin test/itt-check-pass
# Open PR → expect workflow to pass
```

---

## Step 3 — Check servers via CyberArk

Run Server Inspection Checklist on both servers.
File: `project/Server_Inspection_Checklist_v2.docx`

**Compile server (azuse-cssdapp01):**
- Find FCP tooling path
- Confirm MSBuild works
- Find .vcxproj files if any

**Deploy server (azuse-cssdapp02):**
- Find ktcdtupd.exe and mapload.exe paths
- Check cssapp share structure
- Confirm SSH to AIX works

**AIX (ssh fcp@10.187.68.22):**
- Check /tmp_work/_devops/ exists
- Confirm cob compiler works
- Check /css/software/pvcs/ksh/ scripts

---

## Step 4 — Fill in placeholders

Once server inspection results are available, update:
- `build.yml` steps 7a and 7b — real MSBuild command
- `deploy.yml` deploy step — real cssapp share path
- `deploy.yml` COBOL step — real AIX paths and cob command

---

## Key contacts
- Alan Chin — CSS architect (CI-CD-Strategy author)
- Suryasish — server access, CyberArk, runner setup

## Key info
- Runners: both Idle, labels compile/deploy added
- AIX SSH: `ssh fcp@10.187.68.22` (fcp account)
- cssapp share: `\\azuse-cssdapp02\cssapp\`
- Test module: `client/dialog/azcd01` (simplest — Windows only, no SSH needed)
