#!/usr/bin/env py -3
"""bank-ground-order.py — emit a bank's FULL leaves-first verification worklist.

The grounding pass moved from "sweep the address-tagged stubs" to FULL re-verification:
every sub gets read against its bytecode, because clean names proved wrong too
(unit_record_ptr -> side_resource_ptr — the "+4 = hp" note was actually "men"; a confident
name AND a prior [HIGH CONFIRMED] tag, both wrong). To read a top-level routine against
ALREADY-grounded callees, you must walk the bank BOTTOM-UP.

This lists every sub in bank N ordered LEAVES-FIRST by call-graph depth, so a sub appears
only after the in-bank subs it calls — annotated with its current grounding state.

  Universe  = every `// $ADDR name` sub header in source/4-c/bank_NN.c (e.g. 131 for bank 2).
  Edges     = native-call-index's fused graph (native jsr/jmp + bytecode host_call + ROM tables).
  depth(a)  = 0 if a calls no OTHER in-bank sub (calls only grounded other-bank helpers, e.g.
              bank 15, or nothing) else 1 + max(depth(in-bank callee)); cycle back-edges = 0.
  order     = (depth, -inbound_fanout, addr) — deepest leaves first, highest-leverage within a band.

Status per sub (heuristic; the bytecode read is still the real gate):
  SUSPECT   name is address-tagged (`_<4hex>` suffix) — self-confessed low fidelity, do first.
  dated     comment carries a 2026 grounding date — verified this pass (or a recent one).
  todo      descriptive name, no grounding date — inherited from the breadth pass, NOT re-verified.

Usage:
  py -3 tools/bank-ground-order.py <bank>            # full worklist, leaves-first
  py -3 tools/bank-ground-order.py <bank> --todo     # only SUSPECT + todo (hide dated)
  py -3 tools/bank-ground-order.py <bank> --json
"""
import argparse
import json
import re
from importlib import import_module
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CDIR = ROOT / "source" / "4-c"

_HEADER = re.compile(r"^//\s*\$([0-9A-Fa-f]{4,5})\s+(\S+)\s*$", re.M)
_ADDR_TAG = re.compile(r"_[0-9a-f]{4}$")
_DATE = re.compile(r"20\d\d-\d\d-\d\d")


def bank_subs(bank):
    """(addr, name) for every sub defined in this bank's structured-C oracle — ground truth
    for 'all subs in the bank'. The decompiler emits `// $ADDR name` above each `word` def."""
    text = (CDIR / f"bank_{bank:02d}.c").read_text(encoding="utf-8")
    out = {}
    for a, nm in _HEADER.findall(text):
        # the line right after a header is `// (body @ $XXXX)`; only real sub headers carry a name token
        if nm.startswith("(") or nm == "PRG":
            continue
        out[int(a, 16)] = nm
    return out


def depth_order(bank, addrs, outbound):
    """Leaves-first by call-graph depth, restricted to the in-bank sub set `addrs`."""
    inbank = set(addrs)
    memo = {}

    def depth(a, stack):
        if a in memo:
            return memo[a]
        if a in stack:
            return 0                      # cycle back-edge: don't recurse
        stack.add(a)
        d = 0
        for dst, _kind in outbound.get(a, []):
            if dst in inbank and dst != a:
                d = max(d, 1 + depth(dst, stack))
        stack.discard(a)
        memo[a] = d
        return d

    return {a: depth(a, set()) for a in addrs}


def main():
    ap = argparse.ArgumentParser(description="Bank verification worklist, leaves-first.")
    ap.add_argument("bank", type=lambda x: int(x, 0), help="bank number (0,1,2,15)")
    ap.add_argument("--todo", action="store_true", help="only SUSPECT + un-dated subs (hide dated)")
    ap.add_argument("--json", action="store_true", help="emit JSON instead of a summary")
    a = ap.parse_args()

    subs = bank_subs(a.bank)                                  # addr -> name (the universe)
    nci = import_module("native-call-index")
    _name, _lab_bank, _defs, _entries, inbound, outbound = nci.build()
    labels = {lab.addr: lab for lab in import_module("mesen-labels").parse_toml()}

    depths = depth_order(a.bank, list(subs), outbound)
    inbank = set(subs)

    def callee_n(a_):
        return len({d for d, _k in outbound.get(a_, []) if d in inbank and d != a_})

    def status(addr, nm):
        if _ADDR_TAG.search(nm) and not nm.startswith("sub_"):
            return "SUSPECT"
        c = labels[addr].comment if addr in labels else ""
        return "dated" if _DATE.search(c or "") else "todo"

    rows = []
    for addr, nm in subs.items():
        rows.append({
            "addr": addr, "name": nm, "depth": depths[addr],
            "inbound": len(inbound.get(addr, [])), "callees": callee_n(addr),
            "status": status(addr, nm),
        })
    rows.sort(key=lambda r: (r["depth"], -r["inbound"], r["addr"]))

    if a.todo:
        rows = [r for r in rows if r["status"] != "dated"]

    if a.json:
        print(json.dumps(rows))
        return

    n = len(subs)
    by = {"SUSPECT": 0, "dated": 0, "todo": 0}
    for addr, nm in subs.items():
        by[status(addr, nm)] += 1
    done = by["dated"]
    print(f"bank_{a.bank:02d}: {n} subs | grounded(dated) {done} | todo {by['todo']} | "
          f"SUSPECT {by['SUSPECT']}  ({100*done//n if n else 0}% dated)")
    print(f"{'depth':>5} {'in':>3} {'out':>3}  {'status':<7} addr    name")
    for r in rows:
        print(f"{r['depth']:>5} {r['inbound']:>3} {r['callees']:>3}  {r['status']:<7} "
              f"${r['addr']:04X}  {r['name']}")


if __name__ == "__main__":
    main()
