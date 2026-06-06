"""
Diff Analysis: maps changed file paths to module identifiers.

This script is the first step in the GitHub Actions build pipeline that translates raw git
diff output into a structured list of CSS module identifiers. It inspects each changed file
path and maps it to the owning module folder using path-pattern rules specific to the CSS
repository structure (e.g. client/dialog/azcd01/azcd001x.c → module client/dialog/azcd01).
Special cases handle flat artifacts like codestables and xltmaps; shared non-module paths
like copybooks and headers are filtered out entirely.

Also scans _recompiled/*.lst files that appear in the changed file list — each .lst file
lists additional module IDs to compile regardless of whether their source changed. These
override modules are unioned with the source-triggered modules in the output.

Business logic: ensures that only the correct modules are rebuilt in response to a code
change — prevents unnecessary recompilation and guarantees that shared infrastructure files
(copybooks, headers) don't incorrectly trigger module builds. Input: a list of changed file
paths from git diff, or a base/head SHA pair. Output: a deduplicated JSON list of module
IDs passed to classify_modules.py.

A module is the immediate parent folder of the changed file, resolved
against known module root paths in the repository.

Usage (called by GitHub Actions, not directly):
    python scripts/diff_analysis.py --files <file1> [<file2> ...]
    python scripts/diff_analysis.py --from-git <base_sha> <head_sha>

Output: JSON list of unique module paths, e.g.
    ["client/dialog/azcd01", "client/app/dzba01"]
"""

# =============================================================================
# BLOCK 1 — Imports
# argparse   — parse command line arguments
# json       — output result as JSON
# subprocess — run git commands
# sys        — exit codes and stderr output
# Path       — convenient file path manipulation
# =============================================================================
import argparse
import json
import subprocess
import sys
from pathlib import Path


# =============================================================================
# BLOCK 2 — NON_MODULE_PATHS
# Shared folders that are NOT modules themselves.
# If a file inside these folders changes — it is IGNORED.
# Reason: these are shared infrastructure files (copybooks, headers, bitmaps).
# They are used by many modules simultaneously and are not compiled on their own.
# The developer must manually specify affected modules via _recompiled/*.lst file.
# =============================================================================
NON_MODULE_PATHS = {
    'client/include',
    'client/bitmaps',
    'client/help',
    'host/copy',
    'host/copy/msg',
    'host/copy/code',
    'host/copy/cuv',
    'host/copy/lib',
    'host/copy/io',
    'host/copy/table',
}


# =============================================================================
# BLOCK 3 — FLAT_ARTIFACT_PATHS
# Special folders where each FILE = one MODULE (not the folder itself).
# db/codestable/STATBL.dat  → module: db/codestable/STATBL
# client/xltmap/somemap.xlt → module: client/xltmap/somemap
# These files are not compiled — they are loaded into KCOD via FCP utility.
# =============================================================================
FLAT_ARTIFACT_PATHS = {
    'db/codestable',   # each .dat file is its own module
    'client/xltmap',   # each .xlt file is its own module
}


# =============================================================================
# BLOCK 4A (helper) — read_lst_file()
# Reads a _recompiled/*.lst file and returns the list of module IDs inside it.
# Lines starting with # are comments and are ignored.
# Source: CI-CD-Strategy.md — "override modules" mechanism.
# =============================================================================
def read_lst_file(lst_path: str) -> list[str]:
    """Read a _recompiled/*.lst override file and return module IDs listed inside it."""
    modules = []
    try:
        with open(lst_path) as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and line not in modules:
                    modules.append(line)
    except FileNotFoundError:
        print(f'[diff_analysis] WARNING: .lst file not found on disk: {lst_path}', file=sys.stderr)
    return modules


# =============================================================================
# BLOCK 4 — resolve_module()
# Core method. Accepts one changed file path → returns module ID or None.
# Three branches:
#   4A: flat artifact (db/codestable, client/xltmap) → file stem = module
#   4B: shared folder (host/copy, client/include)    → return None (ignore)
#   4C: regular file                                  → parent folder = module
# =============================================================================
def resolve_module(changed_file: str) -> str | None:
    """
    Given a changed file path (relative to repo root), return the module ID.
    Returns None for files that don't belong to any module (e.g. copybooks).
    """
    parts = Path(changed_file).parts  # e.g. ('client', 'dialog', 'azcd01', 'azcd001x.c')

    # --- BLOCK 4A-pre: Special cases that must be checked before NON_MODULE_PATHS ---

    # host/copy/msg/*.xlt → XLT_MAP flat artifact (stem = module ID)
    # compileConfig: ^host\copy\msg\([^\\]+\.xlt) → addXlt.bat
    # host/copy/msg is in NON_MODULE_PATHS to ignore copybooks there,
    # but .xlt files in that folder ARE modules — they need an explicit early check.
    if (len(parts) == 4 and parts[0] == 'host' and parts[1] == 'copy'
            and parts[2] == 'msg' and parts[3].endswith('.xlt')):
        return str(Path('host/copy/msg') / Path(parts[3]).stem)

    # host-win/common/*.pco → flat COBOL file (Windows-side COBOL)
    # host-win/service/*.pco → flat COBOL file
    # compileConfig: ^host-win\common\([^\\]+\.pco) → buildCobolFile.bat
    # These are flat .pco files directly in the folder (not in a sub-project).
    # Sub-projects (host-win/common/<proj>/*.c) are handled by the catch-all below.
    if (len(parts) == 3 and parts[0] == 'host-win'
            and parts[1] in ('common', 'service') and parts[2].endswith('.pco')):
        return str(Path(parts[0]) / parts[1] / Path(parts[2]).stem)

    # --- BLOCK 4A: Flat artifact folders — each file is its own module ---
    # db/codestable/SOMTBL.dat  →  module id = db/codestable/SOMTBL
    for flat in FLAT_ARTIFACT_PATHS:
        flat_parts = Path(flat).parts
        if parts[:len(flat_parts)] == flat_parts and len(parts) == len(flat_parts) + 1:
            return str(Path(flat) / Path(parts[-1]).stem)

    # --- BLOCK 4B: Skip shared folders (copybooks, headers, bitmaps) ---
    # These are NOT modules — changes here don't directly trigger builds
    for non_mod in NON_MODULE_PATHS:
        non_parts = Path(non_mod).parts
        if parts[:len(non_parts)] == non_parts:
            return None

    # --- BLOCK 4C: General rule — module = immediate parent folder ---
    # client/dialog/azcd01/azcd001x.c  →  client/dialog/azcd01
    if len(parts) >= 2:
        return str(Path(*parts[:-1]))

    return None


# =============================================================================
# BLOCK 5 — changed_files_from_git()
# Gets the list of changed files between two commits using git diff.
# Used when pipeline passes base_sha and head_sha (from PR event).
# Three-dot diff (...) = all files changed in the PR relative to base branch.
# =============================================================================
def changed_files_from_git(base_sha: str, head_sha: str) -> list[str]:
    # Uses three-dot diff to get files changed between base and head of the PR
    result = subprocess.run(
        ['git', 'diff', '--name-only', f'{base_sha}...{head_sha}'],
        capture_output=True, text=True, check=True,
    )
    return [line.strip() for line in result.stdout.splitlines() if line.strip()]


# =============================================================================
# BLOCK 6 — main()
# Main flow of the script.
# =============================================================================
def main():

    # --- BLOCK 6A: Parse arguments ---
    # Two mutually exclusive modes:
    #   Mode 1: --files a.c b.c       (explicit file list)
    #   Mode 2: --from-git base head  (git diff between SHAs)
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--files', nargs='+', help='Explicit list of changed files')
    group.add_argument('--from-git', nargs=2, metavar=('BASE_SHA', 'HEAD_SHA'),
                       help='Derive changed files from git diff')
    args = parser.parse_args()

    # --- BLOCK 6B: Build changed files list ---
    if args.files:
        changed = args.files
    else:
        changed = changed_files_from_git(*args.from_git)

    source_modules: list[str] = []   # modules directly affected (git diff)
    override_modules: list[str] = [] # modules from _recompiled/*.lst (override)
    skipped: list[str] = []          # files that were ignored

    # --- BLOCK 6C: Analyze each changed file ---
    for f in changed: 
        if f.startswith(".github"):
                continue

        parts = Path(f).parts

        # Branch 1: _recompiled/*.lst — override file
        # Read its contents and add module IDs to override_modules list.
        # Source: CI-CD-Strategy.md "override modules" mechanism.
        if len(parts) == 2 and parts[0] == '_recompiled' and parts[1].endswith('.lst'):
            lst_overrides = read_lst_file(f)
            print(f'[diff_analysis] Override .lst: {f} → {lst_overrides}', file=sys.stderr)
            for mod in lst_overrides:
                if mod not in override_modules:
                    override_modules.append(mod)
            continue

        # Branch 2: regular file → determine module ID via resolve_module()
        mod = resolve_module(f)
        if mod and mod not in source_modules:
            source_modules.append(mod)
        elif mod is None:
            skipped.append(f)   # file in NON_MODULE_PATH — ignore

    # --- BLOCK 6D: Log skipped files ---
    # Log what was ignored (copybooks, headers, etc.)
    if skipped:
        print(f'[diff_analysis] Skipped (non-module paths): {skipped}', file=sys.stderr)

    # --- BLOCK 6E: Union — source modules + override modules (deduped) ---
    # If the same module appears in both git diff and .lst — keep only once.
    all_modules = list(source_modules)
    for mod in override_modules:
        if mod not in all_modules:
            all_modules.append(mod)

    if override_modules:
        print(f'[diff_analysis] Override modules added: {override_modules}', file=sys.stderr)
    print(f'[diff_analysis] Total modules: {len(all_modules)} '
          f'({len(source_modules)} source, {len(override_modules)} override)', file=sys.stderr)

    # --- BLOCK 6F: Output JSON ---
    # Passed to classify_modules.py as stdin or file.
    # Example: ["client/dialog/azcd01", "host/batch/PROGA"]
    
    if not all_modules:
        print('[diff_analysis] No modules detected — returning empty list', file=sys.stderr)
        print('[]')
        return []

    print(json.dumps(all_modules, indent=2))
    return all_modules


if __name__ == '__main__':
    main()
