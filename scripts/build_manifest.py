"""
This script produces build_manifest.json — the central artifact of the build pipeline that
records everything compiled in a given build run. It combines classified module metadata,
build results, changed source file paths, and ITT ticket references into a single structured
document. C projects get two entries each (BUILD binary and SVT binary compiled separately);
COBOL and HOST_C modules get one entry marked STAGED, since they are compiled at deploy time
on AIX or mainframe.

Business logic: the manifest is the handoff document between the build and deploy pipelines.
The deploy workflow reads it to know what to copy to which network share, what to compile on
AIX, and which ITT tickets are associated with this change — satisfying the audit trail
requirement. Input: classified.json from classify_modules.py, optional build results JSON,
ITT ticket numbers, changed file list, and GitHub Actions environment variables. Output:
build_manifest.json written to disk and uploaded via actions/upload-artifact for the deploy
workflow to consume.

Build Manifest Generator: produces build_manifest.json after compilation.

Reads classified modules + build results and writes the manifest that will
be stored on the pipeline-state branch and used by all downstream deploy steps.

Usage:
    python scripts/build_manifest.py \
        --classified-json classified.json \
        --changed-files file1 file2 ... \
        --build-results results.json \
        --itt-tickets 123 456 \
        --output build_manifest.json

GitHub Actions env vars read automatically:
    GITHUB_RUN_ID      → build_run_id (e.g. "GHA-12345678")
    GITHUB_SHA         → source_commit_sha
    GITHUB_REF_NAME    → source_branch
    PR_NUMBER          → included in trigger field when present

Build results JSON schema (--build-results):
    {
      "client/dialog/azcd01": {"BUILD": "SUCCESS", "SVT": "SUCCESS"},
      "host/batch/PROG01":    {"ALL": "STAGED"}
    }

Output manifest follows CI-CD-Strategy build_manifest schema.
C_PROJECT modules get TWO entries (BUILD env + SVT env binaries compiled separately).
COBOL modules get ONE entry with status STAGED (compiled at deploy time).
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path


# Artifact output paths on the compile server
ARTIFACT_ROOT = 'artifacts'

# Module types that compile on Windows — produced as BUILD and SVT binaries
WINDOWS_COMPILED_TYPES = {'C_PROJECT', 'AGS_MODULE'}

# Module types compiled at deploy time — only source is staged here
DEPLOY_TIME_TYPES = {'COBOL', 'HOST_C'}


def artifact_path(module_id: str, env_target: str, module_type: str) -> str:
    """Return the expected artifact path for a compiled module."""
    name = Path(module_id).name

    if module_type in WINDOWS_COMPILED_TYPES:
        # C projects produce a DLL or EXE — extension depends on subtype but we
        # use .dll as placeholder (MSBuild sets the real extension via .vcxproj)
        return f'{ARTIFACT_ROOT}/{env_target}/{name}.dll'

    if module_type == 'COBOL':
        return f'{ARTIFACT_ROOT}/COBOL/{name}.cbl'

    # Codes table / XLT map — raw file staged as-is
    if module_type == 'CODES_TABLE':
        return f'{ARTIFACT_ROOT}/codestable/{name}.dat'
    if module_type == 'XLT_MAP':
        return f'{ARTIFACT_ROOT}/xltmap/{name}.xlt'

    return f'{ARTIFACT_ROOT}/other/{name}'


def source_files_for_module(module_id: str, changed_files: list[str]) -> list[str]:
    """Return the subset of changed_files that belong to this module."""
    return [f for f in changed_files if f.startswith(module_id + '/') or f.startswith(module_id)]


def build_compiled_modules(
    classified: list[dict],
    changed_files: list[str],
    build_results: dict,
    itt_tickets: list[int],
) -> list[dict]:
    """
    Produce the compiled_modules list for the manifest.

    C_PROJECT and AGS_MODULE → two entries each (BUILD target + SVT target).
    COBOL / HOST_C           → one entry with status STAGED.
    CODES_TABLE / XLT_MAP    → one entry with status STAGED.
    """
    entries = []

    for mod in classified:
        module_id  = mod['module_id']
        mod_type   = mod['type']
        src_files  = source_files_for_module(module_id, changed_files)
        mod_results = build_results.get(module_id, {})

        if mod_type in WINDOWS_COMPILED_TYPES:
            # Compiled twice: once with BUILD env source, once with SVT env source
            for env_target in ('BUILD', 'SVT'):
                status = mod_results.get(env_target, 'UNKNOWN')
                entries.append({
                    'module_id':    module_id,
                    'type':         mod_type,
                    'subtype':      mod.get('subtype'),
                    'env_target':   env_target,
                    'trigger':      'source_change',
                    'artifact':     artifact_path(module_id, env_target, mod_type),
                    'source_files': src_files,
                    'itt_tickets':  itt_tickets,
                    'status':       status,
                })

        elif mod_type in DEPLOY_TIME_TYPES:
            # Source staged here; actual compilation happens at deploy time on AIX/mainframe
            entries.append({
                'module_id':    module_id,
                'type':         mod_type,
                'subtype':      mod.get('subtype'),
                'env_target':   'ALL',
                'trigger':      'source_change',
                'artifact':     artifact_path(module_id, 'ALL', mod_type),
                'source_files': src_files,
                'itt_tickets':  itt_tickets,
                'status':       mod_results.get('ALL', 'STAGED'),
                'note':         'Compiled at deploy time. AIX for BUILD/SVT; IBM COBOL mainframe for CTST-STAG.',
            })

        elif mod_type in ('CODES_TABLE', 'XLT_MAP'):
            entries.append({
                'module_id':    module_id,
                'type':         mod_type,
                'env_target':   'ALL',
                'trigger':      'source_change',
                'artifact':     artifact_path(module_id, 'ALL', mod_type),
                'source_files': src_files,
                'itt_tickets':  itt_tickets,
                'status':       mod_results.get('ALL', 'STAGED'),
                'note':         'Uploaded to KCOD at deploy time using FCP utility.',
            })

    # Remove None subtype values to keep the JSON clean
    for e in entries:
        if e.get('subtype') is None and 'subtype' in e:
            del e['subtype']

    return entries


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--classified-json', required=True,
                        help='Output of classify_modules.py')
    parser.add_argument('--changed-files', nargs='*', default=[],
                        help='List of changed source files in this build')
    parser.add_argument('--build-results', default=None,
                        help='JSON file with per-module build status')
    parser.add_argument('--itt-tickets', nargs='*', type=int, default=[],
                        help='ITT ticket numbers associated with this build')
    parser.add_argument('--output', default='build_manifest.json',
                        help='Output path for the manifest file')
    args = parser.parse_args()

    # Load classified modules
    with open(args.classified_json) as f:
        classified = json.load(f)

    # Load build results (default: all SUCCESS for C projects, STAGED for COBOL)
    if args.build_results:
        with open(args.build_results) as f:
            build_results = json.load(f)
    else:
        # No results file — assume SUCCESS for Windows types, STAGED for rest
        build_results = {}
        for mod in classified:
            if mod['type'] in WINDOWS_COMPILED_TYPES:
                build_results[mod['module_id']] = {'BUILD': 'SUCCESS', 'SVT': 'SUCCESS'}
            else:
                build_results[mod['module_id']] = {'ALL': 'STAGED'}

    # Read GitHub Actions context from environment
    run_id     = os.environ.get('GITHUB_RUN_ID', 'local')
    commit_sha = os.environ.get('GITHUB_SHA', 'unknown')
    branch     = os.environ.get('GITHUB_REF_NAME', 'unknown')
    pr_number  = os.environ.get('PR_NUMBER', '')

    # BUILD_RUN_ID is set by build.yml as yyyyMMdd.run_number.run_attempt.PRxx
    # Falls back to GHA-{numeric_run_id} if env var not present (local runs).
    build_run_id = os.environ.get('BUILD_RUN_ID') or f'GHA-{run_id}'
    trigger = f'PR #{pr_number}' if pr_number else f'commit {commit_sha[:8]}'

    # Assemble the manifest
    manifest = {
        'build_run_id':        build_run_id,
        'trigger':             trigger,
        'source_commit_sha':   commit_sha,
        'timestamp':           datetime.now(timezone.utc).isoformat(),
        'source_branch':       branch,
        'itt_tickets':         args.itt_tickets,
        'changed_source_files': args.changed_files,
        'override_modules':    [],
        'compiled_modules':    build_compiled_modules(
                                   classified,
                                   args.changed_files,
                                   build_results,
                                   args.itt_tickets,
                               ),
    }

    with open(args.output, 'w') as f:
        json.dump(manifest, f, indent=2)

    print(f'Manifest written to {args.output}')
    print(f'  build_run_id:     {build_run_id}')
    print(f'  modules compiled: {len(classified)}')
    print(f'  entries total:    {len(manifest["compiled_modules"])}  (C projects count twice: BUILD + SVT)')


if __name__ == '__main__':
    main()
