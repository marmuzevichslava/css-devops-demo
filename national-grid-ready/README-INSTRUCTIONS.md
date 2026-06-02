# National Grid — Pipeline Deployment Instructions
## DELETE THIS FOLDER after completing all steps

---

## What you're deploying

Two files go into TWO repos. That's it.

```
css-demo repo         ← one tiny caller file (5 lines of logic)
css-devops-demo repo  ← all pipeline logic (scripts + workflows)
```

When a developer opens a PR in css-demo:
- caller triggers → reusable workflow in css-devops-demo runs
- ITT check + diff analysis results appear in the PR Checks tab
- Developer sees ✅ or ❌ directly in their PR

---

## STEP 1 — Verify runners are online

```
github.com/nationalgrid-customer/css-devops-demo
  → Settings → Actions → Runners
```

Must see TWO runners with status **Idle**:
- `azuse-cssdapp01` — labels: `self-hosted, windows, compile`
- `azuse-cssdapp02` — labels: `self-hosted, windows, deploy`

If **Offline** → RDP into server via CyberArk → run:
```powershell
Get-Service -Name 'actions.runner.*' | Start-Service
```

---

## STEP 2 — Verify Python is installed on azuse-cssdapp01

RDP into azuse-cssdapp01 via CyberArk → PowerShell:
```powershell
python --version
```
Must show Python 3.14 (or 3.12 minimum).

If not installed → Python installer is at `E:\devops\software\` (Alan downloaded it).
Install with:
```powershell
E:\devops\software\python-3.14-amd64.exe /quiet InstallAllUsers=1 PrependPath=1
```
Then restart runner:
```powershell
Restart-Service -Name 'actions.runner.*'
```

---

## STEP 3 — Create GitHub PAT token

You have admin rights → generate from your own NG GitHub account.

1. github.com → your avatar → **Settings**
2. **Developer settings** → **Personal access tokens** → **Tokens (classic)**
3. **Generate new token (classic)**
4. Note: `css-pipeline-token`
5. Expiration: 90 days
6. Scope: tick only **`repo`**
7. **Generate token** → COPY IMMEDIATELY (shown once only)

---

## STEP 4 — Add secrets to BOTH repos

**In css-demo:**
```
github.com/nationalgrid-customer/css-demo
  → Settings → Secrets and variables → Actions → New repository secret

Name:  CSS_REPO_TOKEN
Value: <token from step 3>
```

**In css-devops-demo:**
```
github.com/nationalgrid-customer/css-devops-demo
  → Settings → Secrets and variables → Actions → New repository secret

Name:  CSS_REPO_TOKEN
Value: <same token>
```

Both repos → same token → same name `CSS_REPO_TOKEN`.

---

## STEP 5 — Add files to css-demo

Add ONE file to `nationalgrid-customer/css-demo`:

```
.github/workflows/pr-validation-caller.yml
```

File is in: `national-grid-ready/for-css-demo/.github/workflows/pr-validation-caller.yml`

Do via GitHub UI:
1. Open `github.com/nationalgrid-customer/css-demo`
2. Click **Add file** → **Create new file**
3. Name: `.github/workflows/pr-validation-caller.yml`
4. Paste content from the file above
5. Commit to main

---

## STEP 6 — Add files to css-devops-demo

Create branch `feature/add-pipeline` in css-devops-demo and add:

```
from national-grid-ready/for-css-devops-demo/

.github/workflows/pr-validation-reusable.yml   ← REQUIRED (reusable workflow)
.github/workflows/build.yml                    ← build pipeline
.github/workflows/deploy.yml                   ← deploy pipeline
scripts/itt_check.py
scripts/diff_analysis.py
scripts/classify_modules.py
scripts/resolve_build_sequence.py
scripts/build_manifest.py
build-sequence-rules.json
```

Commit message: `feat: add pipeline workflows and scripts ITT:[your-ITT-number]`

Create PR → merge to main.

---

## STEP 7 — Test it

1. Open `github.com/nationalgrid-customer/css-demo`
2. Create new branch `ITT-[number]` from `build` branch
3. Change any file in `client/dialog/` or `host/batch/`
4. Commit message MUST contain `ITT:[number]` — example: `fix: update dialog ITT:[12345]`
5. Open PR: `ITT-[number]` → `build`

Check result:
```
github.com/nationalgrid-customer/css-demo → PR → Checks tab
```
Must see:
```
✅ PR Validation / call-pipeline / ITT Reference Check
✅ PR Validation / call-pipeline / Diff Analysis + Classify + Build Sequence
```

---

## STEP 8 — If something fails

**"pwsh: command not found"**
→ build.yml uses `shell: powershell` (already fixed) — not an issue

**"python: can't open file"**
→ Python not installed or not in PATH
→ Check `python --version` on azuse-cssdapp01

**ITT check fails**
→ Commit message missing `ITT:[number]`
→ Must be in the LAST commit of the PR

**Workflow doesn't trigger**
→ Check css-demo has `pr-validation-caller.yml` in `.github/workflows/`
→ Check `CSS_REPO_TOKEN` secret exists in css-demo

**Runner offline**
→ `Get-Service -Name 'actions.runner.*' | Start-Service` on azuse-cssdapp01

---

## What to tell Alan tomorrow

> "PR Validation is working end-to-end on personal GitHub using reusable workflow pattern.
> css-demo has a 5-line caller — no pipeline logic in css-demo history.
> All pipeline code lives in css-devops-demo.
> Ready to deploy to National Grid. Need:
> 1. Python installed on azuse-cssdapp01 (SNOW ticket submitted)
> 2. CSS_REPO_TOKEN secret added to both repos
> Then I can demo the full PR flow: developer opens PR → checks appear automatically."

---

## DELETE THIS FOLDER when done
