"""
This script determines the order in which modules must be compiled by performing a
topological sort over a rule-based dependency graph. Rules are defined in
build-sequence-rules.json and describe "module X must be compiled before module Y"
relationships using type, exact ID, or path-pattern selectors. The output groups modules
into sequential compilation waves — all modules within a single wave are independent and
can theoretically be built in parallel.

Business logic: the CSS codebase has shared libraries (AGS base modules, common Windows
DLLs) that must exist before dependent dialog or application modules can link against them.
Compiling in the wrong order causes linker failures. This script enforces correct ordering
automatically so no developer has to remember dependency rules manually. Input: classified
modules JSON from classify_modules.py and build-sequence-rules.json. Output: a JSON waves
array where each wave lists the module IDs to compile in that round.

Build Sequence Resolver: given a list of classified modules and a rules file,
produces an ordered list of compilation waves using topological sort.

Usage:
    python scripts/resolve_build_sequence.py \
        --modules-json classified.json \
        --rules build-sequence-rules.json

Input (--modules-json): output of classify_modules.py, e.g.
    [{"module_id": "client/dialog/azcd01", "type": "C_PROJECT", "subtype": "dialog"}, ...]

Rules file schema: array of ordering rules, each with a "before" and "after" selector.
    Selector types: {"type": "C_PROJECT"} | {"module": "client/ags/cugbase"} | {"pattern": "client/comwin/*"}

Output: JSON with ordered compilation waves, e.g.
    {
      "waves": [
        {"wave": 1, "modules": ["client/ags/cugbase"]},
        {"wave": 2, "modules": ["client/ags/cugfoo"]},
        {"wave": 3, "modules": ["client/comwin/cuar01cw"]},
        {"wave": 4, "modules": ["client/dialog/azcd01"]}
      ]
    }
"""

import argparse
import json
import sys
from collections import defaultdict, deque
from pathlib import Path


# ---------------------------------------------------------------------------
# Selector matching
# ---------------------------------------------------------------------------

def matches_selector(selector: dict, module: dict) -> bool:
    """Return True if the module matches the given selector."""

    if 'type' in selector:
        # Match all modules of a given type (C_PROJECT, AGS_MODULE, COBOL, etc.)
        return module['type'] == selector['type']

    if 'module' in selector:
        # Match one specific module by exact ID
        return module['module_id'] == selector['module']

    if 'pattern' in selector:
        # Match modules whose ID starts with the given prefix (e.g. "client/comwin/*")
        prefix = selector['pattern'].rstrip('/*')
        return module['module_id'].startswith(prefix + '/')

    raise ValueError(f'Unknown selector key: {list(selector.keys())}')


# ---------------------------------------------------------------------------
# Graph construction
# ---------------------------------------------------------------------------

def build_dependency_graph(rules: list, modules: list) -> tuple[dict, dict]:
    """
    Build a directed graph from the ordering rules.

    For each rule  { "before": X, "after": Y }:
      - find all modules matching X  → set of "before" nodes
      - find all modules matching Y  → set of "after" nodes
      - add an edge  before_node → after_node  (before must compile first)

    Returns:
      edges     : {module_id: [module_id, ...]}  — adjacency list
      in_degree : {module_id: int}               — number of incoming edges
    """
    ids = [m['module_id'] for m in modules]
    edges = defaultdict(set)       # before → {after, ...}
    in_degree = {mid: 0 for mid in ids}

    for rule in rules:
        before_sel = rule.get('before')
        after_sel = rule.get('after')
        if not before_sel or not after_sel:
            continue

        before_modules = [m['module_id'] for m in modules if matches_selector(before_sel, m)]
        after_modules  = [m['module_id'] for m in modules if matches_selector(after_sel,  m)]

        for b in before_modules:
            for a in after_modules:
                if a != b and a not in edges[b]:
                    edges[b].add(a)
                    in_degree[a] += 1

    return edges, in_degree


# ---------------------------------------------------------------------------
# Topological sort → compilation waves (Kahn's algorithm)
# ---------------------------------------------------------------------------

def topological_waves(edges: dict, in_degree: dict, all_ids: list) -> list[list[str]]:
    """
    Kahn's BFS-based topological sort.

    Each iteration of the outer loop produces one wave: all modules whose
    in-degree has dropped to zero (no remaining uncompiled dependencies).
    Modules within a wave can be compiled in parallel.

    If nodes remain after the sort, there is a cycle — caller handles that.
    """
    queue = deque(mid for mid in all_ids if in_degree[mid] == 0)
    waves = []
    visited = set()

    while queue:
        # Everything currently in the queue has no pending dependencies → one wave
        current_wave = sorted(queue)   # sorted for deterministic output
        waves.append(current_wave)
        visited.update(current_wave)
        queue.clear()

        # Reduce in-degree for every node that depends on something in this wave
        for node in current_wave:
            for neighbour in edges.get(node, []):
                in_degree[neighbour] -= 1
                if in_degree[neighbour] == 0:
                    queue.append(neighbour)

    return waves, visited


def detect_cycle(all_ids: list, visited: set, edges: dict, in_degree: dict) -> list[str]:
    """
    If any module was not visited after the topological sort, it is part of a cycle.
    Returns the list of module IDs involved.
    """
    return [mid for mid in all_ids if mid not in visited]


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--modules-json', required=True,
                        help='Path to classified modules JSON (output of classify_modules.py)')
    parser.add_argument('--rules', required=True,
                        help='Path to build-sequence-rules.json')
    args = parser.parse_args()

    # Load inputs
    with open(args.modules_json) as f:
        modules = json.load(f)

    with open(args.rules) as f:
        rules = json.load(f)

    all_ids = [m['module_id'] for m in modules]

    # Build the dependency graph from the rules
    edges, in_degree = build_dependency_graph(rules, modules)

    # Topological sort → ordered waves
    waves, visited = topological_waves(edges, in_degree, all_ids)

    # Cycle check — fatal: a cycle means we cannot determine compile order
    cycle_nodes = detect_cycle(all_ids, visited, edges, in_degree)
    if cycle_nodes:
        print('ERROR: cycle detected in build-sequence-rules — cannot determine compile order.',
              file=sys.stderr)
        print(f'Modules in cycle: {cycle_nodes}', file=sys.stderr)
        sys.exit(1)

    # Format output: one object per wave with wave number and module list
    output = {
        'waves': [
            {'wave': i + 1, 'modules': wave}
            for i, wave in enumerate(waves)
        ]
    }

    print(json.dumps(output, indent=2))


if __name__ == '__main__':
    main()
