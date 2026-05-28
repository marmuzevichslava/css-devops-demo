"""
This script takes a list of module IDs and classifies each one into a typed category
(C_PROJECT, AGS_MODULE, COBOL, HOST_C, CODES_TABLE, XLT_MAP) based on the repository path
conventions used in the CSS codebase. Classification drives which compiler, toolchain, and
deployment step is used for each module downstream. If path-based rules are inconclusive,
the script falls back to inspecting file extensions inside the module folder.

Business logic: the CSS codebase contains Windows C code, AIX COBOL, AIX C libraries, and
flat data files — each requires a different build and deploy path. This classification step
is the single source of truth for routing modules through the correct pipeline. Input: a
JSON list of module IDs (output of diff_analysis.py). Output: a JSON list of classified
module objects with type and subtype fields, consumed by resolve_build_sequence.py and
build_manifest.py.

Module Classification: takes a list of module paths and classifies each one
by type based on path pattern and file contents in the repository.

Usage:
    python scripts/classify_modules.py --modules <mod1> [<mod2> ...]
    python scripts/classify_modules.py --from-json modules.json
    echo '["client/dialog/azcd01"]' | python scripts/classify_modules.py --stdin

Output: JSON list of classified module objects, e.g.
    [{"module_id": "client/dialog/azcd01", "type": "C_PROJECT", "subtype": "dialog"}]

Module types (from CI-CD-Strategy):
    C_PROJECT   subtype: dialog | comwin | common | devops_win
    AGS_MODULE  subtype: ags
    COBOL       subtype: batch | service | io | report | common | table
    HOST_C      subtype: app | aix_lib | aix_devops
    CODES_TABLE subtype: -
    XLT_MAP     subtype: -
"""

import argparse
import json
import os
import sys
from pathlib import Path


def classify(module_id: str, repo_root: str = '.') -> dict:
    """Classify a single module by path pattern and file presence."""
    parts = Path(module_id).parts
    module_path = Path(repo_root) / module_id

    # --- Flat artifacts: identified by path prefix alone, no folder to inspect ---
    if len(parts) >= 2 and parts[0] == 'db' and parts[1] == 'codestable':
        return _result(module_id, 'CODES_TABLE', None)

    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'xltmap':
        return _result(module_id, 'XLT_MAP', None)

    # --- Path-based classification: type is determined by where the module lives ---

    # client/dialog/<module> — Windows EXE dialogs (FCP .gnd + C source)
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'dialog':
        return _result(module_id, 'C_PROJECT', 'dialog')

    # client/comwin/<module>cw — Windows DLL common-window modules
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'comwin':
        return _result(module_id, 'C_PROJECT', 'comwin')

    # client/ags/<module> — AGS DLL modules (name starts 'cug')
    # NOTE: Alan confirmed AGS location is being finalised — update path when confirmed
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'ags':
        return _result(module_id, 'AGS_MODULE', 'ags')

    # client/common/<module> — shared Windows DLL libraries (no .gnd)
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'common':
        return _result(module_id, 'C_PROJECT', 'common')

    # client/app/<module> — DevOps Windows tools (dz* names, css-devops-demo)
    if len(parts) >= 2 and parts[0] == 'client' and parts[1] == 'app':
        return _result(module_id, 'C_PROJECT', 'devops_win')

    # host/batch|service|io|report|common|table — COBOL programs
    # Compiled on AIX (BUILD/SVT) or mainframe (CTST+) at deploy time
    COBOL_SUBTYPES = {'batch', 'service', 'io', 'report', 'common', 'table'}
    if len(parts) >= 2 and parts[0] == 'host' and parts[1] in COBOL_SUBTYPES:
        return _result(module_id, 'COBOL', parts[1])

    # host/app/<module> — host-side C modules (compiled on AIX via SSH)
    if len(parts) >= 2 and parts[0] == 'host' and parts[1] == 'app':
        return _result(module_id, 'HOST_C', 'app')

    # host/aix/lib/<module> — AIX shared libraries
    if len(parts) >= 3 and parts[0] == 'host' and parts[1] == 'aix' and parts[2] == 'lib':
        return _result(module_id, 'HOST_C', 'aix_lib')

    # aix/host/<module> — AIX DevOps tools (css-devops-demo repo structure)
    if len(parts) >= 2 and parts[0] == 'aix' and parts[1] == 'host':
        return _result(module_id, 'HOST_C', 'aix_devops')

    # Fallback: path not recognised — inspect actual files on disk
    return _classify_by_files(module_id, module_path)


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


def _result(module_id: str, type_: str, subtype: str | None, note: str = '') -> dict:
    r = {'module_id': module_id, 'type': type_}
    if subtype:
        r['subtype'] = subtype
    if note:
        r['note'] = note
    return r


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

    results = [classify(m, args.repo_root) for m in modules]
    print(json.dumps(results, indent=2))


if __name__ == '__main__':
    main()
