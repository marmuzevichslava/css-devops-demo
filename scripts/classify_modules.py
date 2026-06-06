"""
classify_modules.py — Module Type Classifier

BLOCK 1 — Purpose
Receives a list of module IDs from diff_analysis.py and classifies each module
by type and subtype. The type determines which toolchain to use for build/deploy.

Input (from diff_analysis.py):
    ["client/dialog/azcd01", "host/batch/abc01", "db/codestable/SOMTBL"]

Output (to resolve_build_sequence.py):
    [
      {"module_id": "client/dialog/azcd01", "type": "C_PROJECT", "subtype": "dialog"},
      {"module_id": "host/batch/abc01",     "type": "COBOL",     "subtype": "batch"},
      {"module_id": "db/codestable/SOMTBL", "type": "CODES_TABLE"}
    ]

Module types and their toolchains:
    C_PROJECT   → Windows runner / MSBuild / Visual Studio
    AGS_MODULE  → Windows runner / MSBuild (deployed to AGS servers)
    COBOL       → AIX COBOL compiler (BUILD/SVT) or IBM COBOL mainframe (CTST+)
    HOST_C      → AIX C compiler via SSH
    CODES_TABLE → FCP utility (ktcdtupd.exe) → KCOD → WCOD on AIX
    XLT_MAP     → FCP utility (mapload.exe)  → KCOD → WCOD on AIX
    UNKNOWN     → type could not be determined

Usage:
    python scripts/classify_modules.py --modules client/dialog/azcd01
    python scripts/classify_modules.py --from-json modules.json
    echo '["client/dialog/azcd01"]' | python scripts/classify_modules.py --stdin

Source: CI-CD-Strategy.md — section "Module Types and Repository Conventions"
"""

# =============================================================================
# BLOCK 2 — Imports
# argparse — parse command line arguments (--modules, --from-json, --stdin)
# json     — read and print JSON
# sys      — stdin, exit codes
# Path     — file path manipulation
# =============================================================================
import argparse
import json
import sys
from pathlib import Path


# =============================================================================
# BLOCK 3 — classify()
# Core method. Accepts one module_id → returns classified dict.
# Classification is done by path pattern (priority) or by files in folder (fallback).
#
# Input:  "client/dialog/azcd01"
# Output: {"module_id": "client/dialog/azcd01", "type": "C_PROJECT", "subtype": "dialog"}
# =============================================================================
def classify(module_id: str, repo_root: str = '.') -> dict:
    """Classify a single module by path pattern and file presence."""
    parts = Path(module_id).parts
    module_path = Path(repo_root) / module_id

    # --- BLOCK 4: Flat artifacts — identified by path prefix only ---
    # These types have no subfolders with modules — the file itself is the module.

    # db/codestable/SOMTBL → CODES_TABLE
    # Loaded via FCP utility ktcdtupd.exe → KCOD → WCOD on AIX
    if len(parts) >= 2 and parts[0] == 'db' and parts[1] == 'codestable':
        return _result(module_id, 'CODES_TABLE', None)

    # client/xltmap/somemap → XLT_MAP
    # Translation maps. Loaded via FCP utility mapload.exe → KCOD → WCOD
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'xltmap':
        return _result(module_id, 'XLT_MAP', None)

    # host/copy/msg/<name> → XLT_MAP (translation maps in the FCP copy area)
    # compileConfig: ^host\copy\msg\([^\\]+\.xlt) → addXlt.bat
    # diff_analysis strips the .xlt extension, leaving host/copy/msg/<name>
    if len(parts) >= 3 and parts[0] == 'host' and parts[1] == 'copy' and parts[2] == 'msg':
        return _result(module_id, 'XLT_MAP', None)

    # --- BLOCK 5: Windows C modules (C_PROJECT) ---
    # All compiled on Compile Server via MSBuild (VS 2019 Build Tools).
    # Produce EXE or DLL. Deployed to Network Share (cssapp\[env]\client).

    # client/dialog/<module> — Windows EXE dialogs (FCP .gnd + C source)
    # This is the main CSS application visible to call center users.
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'dialog':
        result = _result(module_id, 'C_PROJECT', 'dialog')
        # compileConfig: ^client\dialog\<proj>\*.map → addCsrmap.bat at deploy time
        if module_path.exists() and any(module_path.glob('*.map')):
            result['has_csrmap'] = True
        return result

    # client/comwin/<module>cw — Windows DLL common-window modules
    # Shared DLL libraries used by dialog modules.
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'comwin':
        result = _result(module_id, 'C_PROJECT', 'comwin')
        # compileConfig: ^client\comwin\<proj>\*.map → addCsrmap.bat at deploy time
        if module_path.exists() and any(module_path.glob('*.map')):
            result['has_csrmap'] = True
        return result

    # client/common/<module> — shared Windows DLL libraries (no .gnd)
    # Lowest-level dependencies — compiled first (Wave 1).
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'common':
        return _result(module_id, 'C_PROJECT', 'common')

    # client/app/<module> — Windows DevOps tools (dz* names)
    # CSS utility tools (MigTrax, Workbench, etc.)
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'app':
        return _result(module_id, 'C_PROJECT', 'devops_win')

    # --- BLOCK 6: AGS modules ---
    # AGS = Application Gateway Service.
    # Middleware between web/external systems and CSS Mainframe.
    # Compiled as DLL via MSBuild. Deployed to AGS servers (ngusappndc165/166).
    # NOTE: Alan confirmed AGS location is still being finalised — path may change.
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'ags':
        return _result(module_id, 'AGS_MODULE', 'ags')

    # --- BLOCK 7: COBOL modules ---
    # COBOL = CSS backend business logic (~3560 programs).
    # BUILD/SVT: compiled on AIX server (USNY7-CSSADV01) via SSH.
    # CTST+:     compiled on Mainframe via IBM COBOL.
    # PROD:      NOT deployed through this pipeline.
    COBOL_SUBTYPES = {'batch', 'service', 'io', 'report', 'common', 'table'}
    if len(parts) >= 2 and parts[0] == 'host' and parts[1] in COBOL_SUBTYPES:
        return _result(module_id, 'COBOL', parts[1])

    # --- BLOCK 8: Host C / AIX-specific modules ---
    # C programs specific to AIX platform (not Windows).
    # Compiled on AIX via xlc (IBM C compiler) through SSH.

    # host/app/<module> — AIX C executables (not COBOL)
    if len(parts) >= 2 and parts[0] == 'host' and parts[1] == 'app':
        return _result(module_id, 'HOST_C', 'app')

    # host/aix/lib/<module> — AIX shared libraries
    if len(parts) >= 3 and parts[0] == 'host' and parts[1] == 'aix' and parts[2] == 'lib':
        return _result(module_id, 'HOST_C', 'aix_lib')

    # aix/host/<module> — AIX DevOps tools (in css-devops-demo repo)
    if len(parts) >= 2 and parts[0] == 'aix' and parts[1] == 'host':
        return _result(module_id, 'HOST_C', 'aix_devops')

    # --- BLOCK 8b: host-win Windows C projects (HOST_WIN_C) ---
    # compileConfig: ^host-win\common\<proj>\* → buildHostVcxProj.bat
    #                ^host-win\service\<proj>\* → buildHostVcxProj.bat
    # Windows C projects on the host side. Different from client-side C_PROJECT.
    # Note: flat .pco files in host-win/ (module_id depth = host-win/common/SOMFILE)
    # fall through to _classify_by_files() which detects COBOL via .pco extension.
    if len(parts) >= 2 and parts[0] == 'host-win' and parts[1] == 'common':
        return _result(module_id, 'HOST_WIN_C', 'common_win')

    if len(parts) >= 2 and parts[0] == 'host-win' and parts[1] == 'service':
        return _result(module_id, 'HOST_WIN_C', 'service_win')

    # --- BLOCK 8c: DDE modules ---
    # compileConfig: ^client\dde\* → addDde.bat
    # DDE (Dynamic Data Exchange) modules. Deployed via addDde.bat at deploy time.
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'dde':
        return _result(module_id, 'DDE_MODULE', None)

    # --- BLOCK 8d: FSD projects ---
    # compileConfig: fsd\<proj>\* → buildFsdProj.bat
    # FSD (Full Screen Display) projects. Compiled via buildFsdProj.bat.
    if len(parts) >= 1 and parts[0] == 'fsd':
        return _result(module_id, 'FSD_MODULE', None)

    # --- BLOCK 9: Fallback — determine type by files inside the folder ---
    # If path did not match any rule above — inspect file extensions.
    return _classify_by_files(module_id, module_path)


# =============================================================================
# BLOCK 9 (helper) — _classify_by_files()
# Fallback: if path is not recognised — look inside the module folder on disk.
# Determine type by file extensions.
# If nothing matches — return UNKNOWN with explanation note.
# =============================================================================
def _classify_by_files(module_id: str, module_path: Path) -> dict:
    """Last resort: inspect file extensions inside the module folder."""
    if not module_path.exists():
        return _result(module_id, 'UNKNOWN', None, f'path not found: {module_path}')

    files = list(module_path.iterdir())
    exts = {f.suffix.lower() for f in files if f.is_file()}

    if '.cbl' in exts or '.cob' in exts or '.pco' in exts:
        return _result(module_id, 'COBOL', 'unknown')
    if '.vcxproj' in exts or '.gnd' in exts:
        return _result(module_id, 'C_PROJECT', 'unknown')
    if '.dat' in exts:
        return _result(module_id, 'CODES_TABLE', None)
    if '.xlt' in exts:
        return _result(module_id, 'XLT_MAP', None)

    return _result(module_id, 'UNKNOWN', None, f'cannot determine type from files: {exts}')


# =============================================================================
# BLOCK 10 — _result()
# Helper method. Assembles the final JSON object for one module.
# If subtype=None — field is not included in output (clean JSON).
# If note is present — added as a warning (for UNKNOWN cases).
# =============================================================================
def _result(module_id: str, type_: str, subtype: str | None, note: str = '') -> dict:
    r = {'module_id': module_id, 'type': type_}
    if subtype:
        r['subtype'] = subtype
    if note:
        r['note'] = note
    return r


# =============================================================================
# BLOCK 11 — main()
# Reads input in one of three ways and runs classify() for each module.
#
# Option 1: --modules client/dialog/azcd01 host/batch/abc01
# Option 2: --from-json modules.json
# Option 3: echo '[...]' | python classify_modules.py --stdin
# =============================================================================
def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--modules', nargs='+', help='Module IDs to classify')
    group.add_argument('--from-json', help='Path to JSON file with module list')
    group.add_argument('--stdin', action='store_true', help='Read module list JSON from stdin')
    parser.add_argument('--repo-root', default='.', help='Repo root for file inspection fallback')
    args = parser.parse_args()

    if args.modules:
        modules = args.modules
    elif args.from_json:
        with open(args.from_json) as f:
            modules = json.load(f)
    else:
        modules = json.load(sys.stdin)

    # --- BLOCK 12: Output JSON ---
    # Call classify() for each module_id and print the result.
    # Passed to resolve_build_sequence.py.
    results = [classify(m, args.repo_root) for m in modules]

    # --- BLOCK 13: Fail on UNKNOWN modules ---
    # Silently dropping unknown modules is dangerous — they would not be compiled or deployed.
    # Alan Chin (meeting 05 June 2026): "Unknown is bad if you just silently drop it."
    # Every module must have an explicit classification. If a new path appears in the repo,
    # a developer must either add a rule here or add the module to _recompiled/*.lst.
    unknowns = [r for r in results if r['type'] == 'UNKNOWN']
    if unknowns:
        for u in unknowns:
            note = u.get('note', 'no matching rule found')
            print(f"[CLASSIFY ERROR] '{u['module_id']}' — {note}", file=sys.stderr)
            print(f"  Fix: add a classification rule in classify_modules.py, "
                  f"or list the module explicitly in _recompiled/*.lst.", file=sys.stderr)
        sys.exit(1)

    print(json.dumps(results, indent=2))


if __name__ == '__main__':
    main()
