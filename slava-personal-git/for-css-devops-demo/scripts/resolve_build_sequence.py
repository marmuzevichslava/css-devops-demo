"""
resolve_build_sequence.py — Build Order Resolver

BLOCK 1 — Purpose
Receives classified modules from classify_modules.py and rules from build-sequence-rules.json.
Determines the order in which modules should be compiled using topological sort.

Problem it solves:
    AGS base library  ← must be compiled first
        ↓
    comwin DLL        ← depends on AGS base
        ↓
    dialog EXE        ← depends on comwin DLL

If compiled in the wrong order → linker errors, missing symbols.

Input (from classify_modules.py + build-sequence-rules.json):
    [{"module_id": "client/dialog/azcd01", "type": "C_PROJECT", "subtype": "dialog"}]

Output (to build pipeline / MSBuild):
    {
      "waves": [
        {"wave": 1, "modules": ["client/ags/cugbase"]},
        {"wave": 2, "modules": ["client/comwin/cuar01cw"]},
        {"wave": 3, "modules": ["client/dialog/azcd01"]}
      ]
    }

What is a Wave:
    - All modules within one wave are independent → can be compiled in parallel
    - Wave N starts only after Wave N-1 is complete
    - A cycle in the dependency graph = fatal error → pipeline fails

Source: CI-CD-Strategy.md — section "Build Sequence Rules" and "Compilation Waves"
"""

import argparse
import json
import sys
from collections import defaultdict, deque


# =============================================================================
# BLOCK 2 — matches_selector()
# Checks whether a module matches a selector from the rules file.
#
# Three selector types:
#
#   TYPE selector:    {"type": "C_PROJECT"}
#       → matches all modules of the given type
#
#   MODULE selector:  {"module": "client/ags/cugbase"}
#       → matches only one specific module (exact match)
#
#   PATTERN selector: {"pattern": "client/comwin/*"}
#       → matches all modules whose path starts with the given prefix
# =============================================================================
def matches_selector(selector: dict, module: dict) -> bool:
    """Return True if the module matches the given selector."""

    if 'type' in selector:
        # TYPE: match all modules of a given type
        return module['type'] == selector['type']

    if 'module' in selector:
        # MODULE: match one specific module by exact ID
        return module['module_id'] == selector['module']

    if 'pattern' in selector:
        # PATTERN: match modules whose path starts with given prefix
        # "client/comwin/*" → prefix = "client/comwin"
        prefix = selector['pattern'].rstrip('/*')
        return module['module_id'].startswith(prefix + '/')

    raise ValueError(f'Unknown selector key: {list(selector.keys())}')


# =============================================================================
# BLOCK 3 — build_dependency_graph()
# Builds a directed dependency graph from the rules file.
#
# For each rule {"before": X, "after": Y}:
#   - find all modules matching X (before)
#   - find all modules matching Y (after)
#   - add edge: before_module → after_module
#
# Example rule:
#   {"before": {"module": "client/ags/cugbase"}, "after": {"pattern": "client/comwin/*"}}
#   means: cugbase must compile before all comwin modules
#
# Result:
#   cugbase → cuar01cw
#   cugbase → cuar02cw
#
# BLOCK 3A — edges (adjacency list)
#   edges["cugbase"] = {"cuar01cw", "cuar02cw"}
#   means: cugbase must be compiled before cuar01cw and cuar02cw
#
# BLOCK 3B — in_degree
#   Counts how many dependencies each module has.
#   in_degree["dialog"] = 1  → waiting for 1 dependency to be compiled first
#   in_degree["cugbase"] = 0 → no dependencies → can compile first (Wave 1)
#
# BLOCK 3C — Add graph edges
#   edges[b].add(a) + in_degree[a] += 1
#   means: b (before) must be compiled before a (after)
# =============================================================================
def build_dependency_graph(rules: list, modules: list) -> tuple[dict, dict]:
    """
    Build a directed graph from the ordering rules.
    Returns: edges (adjacency list), in_degree (dependency count per module)
    """
    ids = [m['module_id'] for m in modules]

    # BLOCK 3A: edges — adjacency list
    edges = defaultdict(set)       # before → {after, ...}

    # BLOCK 3B: in_degree — number of unresolved dependencies per module
    in_degree = {mid: 0 for mid in ids}

    # BLOCK 3C: build edges from each rule
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
                    in_degree[a] += 1   # a now waits for b

    return edges, in_degree


# =============================================================================
# BLOCK 4 — topological_waves() — Kahn's Algorithm
# BFS-based topological sort → produces compilation waves.
#
# Core idea:
#   Modules with in_degree == 0 have no dependencies → can be built immediately.
#
# BLOCK 4A — Initial queue
#   Take all modules with in_degree == 0.
#   They don't depend on anything → go into Wave 1.
#   Example: AGS base libraries, common DLLs.
#
# BLOCK 4B — Current wave
#   Everything currently in the queue → one wave.
#   Modules within a wave are independent → can be compiled in parallel.
#   Example: {"wave": 1, "modules": ["client/ags/cugbase", "host/common/base"]}
#
# BLOCK 4C — Reduce dependencies
#   After completing a wave:
#   For each module that depended on a compiled module:
#     in_degree -= 1
#   If in_degree reaches 0 → dependency satisfied → add to queue.
#   This module will go into the next wave.
#   Example: cugbase compiled → in_degree[dialog] -= 1 → dialog enters next wave
# =============================================================================
def topological_waves(edges: dict, in_degree: dict, all_ids: list) -> list[list[str]]:
    """
    Kahn's BFS topological sort → compilation waves.
    Modules within a wave are independent and can be compiled in parallel.
    """
    # BLOCK 4A: Initial queue — modules with no dependencies (in_degree == 0)
    queue = deque(mid for mid in all_ids if in_degree[mid] == 0)
    waves = []
    visited = set()

    while queue:
        # BLOCK 4B: Current wave — everything in queue right now is independent
        current_wave = sorted(queue)   # sorted for deterministic output
        waves.append(current_wave)
        visited.update(current_wave)
        queue.clear()

        # BLOCK 4C: Reduce dependencies — decrease in_degree for dependent modules
        for node in current_wave:
            for neighbour in edges.get(node, []):
                in_degree[neighbour] -= 1
                if in_degree[neighbour] == 0:
                    queue.append(neighbour)  # ready for next wave

    return waves, visited


# =============================================================================
# BLOCK 5 — detect_cycle()
# Safety check — detects cycles in the dependency graph.
#
# If A depends on B and B depends on A:
#   both will wait for each other forever
#   topological sort will never process them
#   they remain unvisited (not in visited) after the sort
#
# If a cycle is found → pipeline fails with exit code 1 (fatal error).
# Cannot determine build order → compilation is impossible.
# =============================================================================
def detect_cycle(all_ids: list, visited: set) -> list[str]:
    """
    If any module was not visited after topological sort → it's in a cycle.
    Returns list of module IDs involved in the cycle.
    """
    return [mid for mid in all_ids if mid not in visited]


# =============================================================================
# BLOCK 6 — main()
# Main flow:
#   1. Load classified modules (from classify_modules.py)
#   2. Load rules (build-sequence-rules.json)
#   3. Build dependency graph
#   4. Topological sort → waves
#   5. Check for cycles → if found, pipeline fails
#   6. Output JSON with waves
# =============================================================================
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--modules-json', required=True,
                        help='Path to classified modules JSON (output of classify_modules.py)')
    parser.add_argument('--rules', required=True,
                        help='Path to build-sequence-rules.json')
    args = parser.parse_args()

    # Load classified modules from classify_modules.py
    with open(args.modules_json) as f:
        modules = json.load(f)

    # Load dependency rules from build-sequence-rules.json
    with open(args.rules) as f:
        rules = json.load(f)

    all_ids = [m['module_id'] for m in modules]

    # Build dependency graph (BLOCK 3)
    edges, in_degree = build_dependency_graph(rules, modules)

    # Topological sort → compilation waves (BLOCK 4)
    waves, visited = topological_waves(edges, in_degree, all_ids)

    # Cycle check — if cycle found → fatal error (BLOCK 5)
    cycle_nodes = detect_cycle(all_ids, visited)
    if cycle_nodes:
        print('ERROR: cycle detected in build-sequence-rules — cannot determine compile order.',
              file=sys.stderr)
        print(f'Modules in cycle: {cycle_nodes}', file=sys.stderr)
        sys.exit(1)

    # ==========================================================================
    # BLOCK 7 — Final Output
    # Each wave = list of modules that can be compiled in parallel.
    # Waves execute sequentially (Wave 2 only after Wave 1 is complete).
    #
    # Example:
    # {"waves": [
    #   {"wave": 1, "modules": ["client/ags/cugbase"]},    ← no dependencies
    #   {"wave": 2, "modules": ["client/comwin/cuar01cw"]}, ← waited for cugbase
    #   {"wave": 3, "modules": ["client/dialog/azcd01"]}    ← waited for comwin
    # ]}
    # ==========================================================================
    output = {
        'waves': [
            {'wave': i + 1, 'modules': wave}
            for i, wave in enumerate(waves)
        ]
    }

    print(json.dumps(output, indent=2))


if __name__ == '__main__':
    main()
