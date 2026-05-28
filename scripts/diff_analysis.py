"""
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

Diff Analysis: maps changed file paths to module identifiers.

A module is the immediate parent folder of the changed file, resolved
against known module root paths in the repository.

Usage (called by GitHub Actions, not directly):
    python scripts/diff_analysis.py --files <file1> [<file2> ...]
    python scripts/diff_analysis.py --from-git <base_sha> <head_sha>

Output: JSON list of unique module paths, e.g.
    ["client/dialog/azcd01", "client/app/dzba01"]
"""

import argparse
import json
import os
import subprocess
import sys
from pathlib import Path

# Folders that are NOT modules themselves — changes inside them bubble up
# to the parent folder (or are ignored if they have no owning module).
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

# Top-level paths that contain flat artifacts (each file = one module)
FLAT_ARTIFACT_PATHS = {
    'db/codestable',   # each .dat file is its own module
    'client/xltmap',   # each .xlt file is its own module
}


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


def resolve_module(changed_file: str) -> str | None:
    """
    Given a changed file path (relative to repo root), return the module ID.
    Returns None for files that don't belong to any module (e.g. copybooks).
    """
    parts = Path(changed_file).parts  # e.g. ('client', 'dialog', 'azcd01', 'azcd001x.c')

    # Special case: flat artifact folders — each individual file is its own module
    # e.g. db/codestable/SOMTBL.dat  →  module id = db/codestable/SOMTBL
    for flat in FLAT_ARTIFACT_PATHS:
        flat_parts = Path(flat).parts
        if parts[:len(flat_parts)] == flat_parts and len(parts) == len(flat_parts) + 1:
            return str(Path(flat) / Path(parts[-1]).stem)

    # Skip files in non-module folders (copybooks, headers, bitmaps, etc.)
    for non_mod in NON_MODULE_PATHS:
        non_parts = Path(non_mod).parts
        if parts[:len(non_parts)] == non_parts:
            return None

    # General rule: the module is the immediate parent folder of the changed file
    # e.g. client/dialog/azcd01/azcd001x.c  →  client/dialog/azcd01
    if len(parts) >= 2:
        return str(Path(*parts[:-1]))

    return None


def changed_files_from_git(base_sha: str, head_sha: str) -> list[str]:
    # Uses three-dot diff to get files changed between base and head of the PR
    result = subprocess.run(
        ['git', 'diff', '--name-only', f'{base_sha}...{head_sha}'],
        capture_output=True, text=True, check=True,
    )
    return [line.strip() for line in result.stdout.splitlines() if line.strip()]


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--files', nargs='+', help='Explicit list of changed files')
    group.add_argument('--from-git', nargs=2, metavar=('BASE_SHA', 'HEAD_SHA'),
                       help='Derive changed files from git diff')
    args = parser.parse_args()

    if args.files:
        changed = args.files
    else:
        changed = changed_files_from_git(*args.from_git)

    source_modules: list[str] = []
    override_modules: list[str] = []
    skipped: list[str] = []

    for f in changed:
        parts = Path(f).parts
        # _recompiled/*.lst — read the file and collect override module IDs
        if len(parts) == 2 and parts[0] == '_recompiled' and parts[1].endswith('.lst'):
            lst_overrides = read_lst_file(f)
            print(f'[diff_analysis] Override .lst: {f} → {lst_overrides}', file=sys.stderr)
            for mod in lst_overrides:
                if mod not in override_modules:
                    override_modules.append(mod)
            continue

        # Normal file → resolve to module ID
        mod = resolve_module(f)
        if mod and mod not in source_modules:
            source_modules.append(mod)
        elif mod is None:
            skipped.append(f)

    if skipped:
        print(f'[diff_analysis] Skipped (non-module paths): {skipped}', file=sys.stderr)

    # Union: source-triggered modules + override modules (deduped)
    all_modules = list(source_modules)
    for mod in override_modules:
        if mod not in all_modules:
            all_modules.append(mod)

    if override_modules:
        print(f'[diff_analysis] Override modules added: {override_modules}', file=sys.stderr)
    print(f'[diff_analysis] Total modules: {len(all_modules)} '
          f'({len(source_modules)} source, {len(override_modules)} override)', file=sys.stderr)

    # Output is consumed by classify_modules.py in the next pipeline step
    print(json.dumps(all_modules, indent=2))
    return all_modules


if __name__ == '__main__':
    main()
