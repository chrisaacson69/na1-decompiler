#!/usr/bin/env py -3
"""cluster-anon-subs.py — group a bank's anonymous decompiled subs into address-proximity
clusters for the label-walk pipeline.

This is the GENERALIZATION of the hand-coded CLUSTERS list in the bank01-label-walk Workflow
(the one piece that was bank-specific). Pass it any bank; it reads the committed
`decompiled/bank_<NN>.c`, finds every still-anonymous `word sub_XXXX(` definition, and buckets
them by sorted address into clusters of ~N. Deterministic: same C -> same clusters.

Address proximity is a good proxy because the assembler emits related routines contiguously
(call-graph community detection is a possible v2). A cluster becomes one PROPOSER agent's batch
in the Workflow (scan -> symbol-table stage); see ROADMAP "label-walk skill".

Ordering:
  default        — address order (assembler emits related routines contiguously).
  --by-callgraph — LEAVES-FIRST: order by call-graph depth so a sub is clustered AFTER
                   the in-bank anon subs it calls. Roots (turn loop, AI planner) land in
                   the last batches, read against already-named callees ([[ROADMAP]]
                   "regen-between-batches = the fixpoint loop"). Depth via native-call-index's
                   fused graph; tie-break by address (deterministic). Cross-bank addr
                   ambiguity in the $8000-$BFFF window only perturbs ordering, never
                   correctness — the bytecode verifier remains the gate.

Usage:
  py -3 tools/cluster-anon-subs.py <bank> [--size N]            # human summary (default N=7)
  py -3 tools/cluster-anon-subs.py <bank> --by-callgraph        # leaves-first summary
  py -3 tools/cluster-anon-subs.py <bank> --json                # JSON for the Workflow `args`
"""
import argparse
import json
import re
from importlib import import_module
from pathlib import Path

ROOT = Path(__file__).parent.parent


def anon_addrs(bank):
    # source/4-c is the canonical structured-C oracle (was decompiled/ before the 2026-06
    # oracle reorg; see na1dream/ARCHITECTURE.md).
    p = ROOT / "source" / "4-c" / f"bank_{bank:02d}.c"
    text = p.read_text(encoding="utf-8")
    return sorted({int(a, 16) for a in re.findall(r'^word sub_([0-9A-Fa-f]+)\(', text, re.M)})


def suspect_targets(bank, by_fanout=False):
    """GROUNDING-pass cursor (vs anon_addrs's first-pass cursor). The first pass named every
    sub, so `sub_XXXX` is now empty; the grounding pass re-grounds the still-address-suffixed
    `<role>_<addr>` labels (self-confessed low-fidelity).

    Default order is LEAVES-FIRST (bottom-up): `depth` = how many un-grounded subs deep this
    one sits (0 = a true root/leaf — calls no other still-suspect sub, so it is groundable NOW;
    >0 = sits on un-grounded callees, ground those first). High-fanout is only the tiebreak
    *within* a depth band (do the highest-leverage groundable leaf first). The $E80C lesson:
    fanout-first picks impactful NON-leaves you can't actually ground yet.

    `by_fanout=True` flips to fanout-primary (the old order) for when you explicitly want the
    leverage view. Leaf-ness is judged against the GLOBAL suspect set (all code banks), so a
    bank-15 sub that calls an un-grounded sub in any bank is correctly NOT depth 0.

    Returns [(addr, label, n_sites, depth)] for subs in `bank`'s window. Data tables fall out
    (no inbound CALL edge). Deterministic: same labels + same ROM -> same order."""
    nci = import_module("native-call-index")
    name, _lab_bank, _defs, entry_targets, inbound, outbound = nci.build()

    def is_suspect(a):
        lbl = name.get(a, "")
        return bool(re.search(r"_[0-9a-f]{4}$", lbl)) and not lbl.startswith("sub_")

    sset = {a for a in name if is_suspect(a)}      # global: leaf-ness spans banks
    memo = {}

    def depth(a, stack):
        if a in memo:
            return memo[a]
        if a in stack:
            return 0                                # cycle back-edge
        stack.add(a)
        d = 0
        for dst, _kind in outbound.get(a, []):
            if dst in sset and dst != a:
                d = max(d, 1 + depth(dst, stack))
        stack.discard(a)
        memo[a] = d
        return d

    lo, hi = (0xC000, 0xFFFF) if bank == 15 else (0x8000, 0xBFFF)
    listed = [a for a in sset if lo <= a <= hi and (inbound.get(a) or a in entry_targets)]
    if by_fanout:
        listed.sort(key=lambda a: (-len(inbound.get(a, [])), depth(a, set()), a))
    else:
        listed.sort(key=lambda a: (depth(a, set()), -len(inbound.get(a, [])), a))
    return [(a, name[a], len(inbound.get(a, [])), depth(a, set())) for a in listed]


def callgraph_order(bank, addrs):
    """Reorder addrs leaves-first by call-graph depth. depth(a) = 0 if a calls no other
    in-bank anon sub, else 1 + max(depth(callee)). Back-edges (cycles) contribute 0.
    Stable tie-break by address keeps it deterministic (same C + same graph -> same order)."""
    nci = import_module("native-call-index")
    _, _, _, _, _, outbound = nci.build()
    anon = set(addrs)
    memo = {}

    def depth(a, stack):
        if a in memo:
            return memo[a]
        if a in stack:
            return 0                      # cycle back-edge: don't recurse
        stack.add(a)
        d = 0
        for dst, _kind in outbound.get(a, []):
            if dst in anon and dst != a:
                d = max(d, 1 + depth(dst, stack))
        stack.discard(a)
        memo[a] = d
        return d

    return sorted(addrs, key=lambda a: (depth(a, set()), a))


def cluster(addrs, size):
    out = []
    for i in range(0, len(addrs), size):
        chunk = addrs[i:i + size]
        out.append({"name": f"g_{chunk[0]:04X}_{chunk[-1]:04X}",
                    "addrs": [f"{a:04X}" for a in chunk]})
    return out


def main():
    ap = argparse.ArgumentParser(description="Cluster a bank's anonymous subs for the label-walk.")
    ap.add_argument("bank", type=lambda x: int(x, 0), help="bank number (0,1,2,15)")
    ap.add_argument("--size", type=int, default=7, help="target subs per cluster (default 7)")
    ap.add_argument("--by-callgraph", action="store_true",
                    help="order leaves-first by call-graph depth (roots land last)")
    ap.add_argument("--json", action="store_true", help="emit JSON (for Workflow args) instead of a summary")
    a = ap.parse_args()

    addrs = anon_addrs(a.bank)
    if a.by_callgraph:
        addrs = callgraph_order(a.bank, addrs)
    clusters = cluster(addrs, a.size)
    if a.json:
        print(json.dumps(clusters))
    else:
        order = "leaves-first (call-graph depth)" if a.by_callgraph else "address order"
        print(f"bank_{a.bank:02d}: {len(addrs)} anon subs -> {len(clusters)} clusters (~{a.size} each), {order}")
        for c in clusters:
            print(f"  {c['name']:<16} ({len(c['addrs'])}): {' '.join('$'+x for x in c['addrs'])}")


if __name__ == "__main__":
    main()
