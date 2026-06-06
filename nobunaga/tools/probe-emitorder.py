"""
tools/probe-emitorder.py — emit-order (atom-5 / approach-B) working probe.

For one sub: dump the bytecode CFG, V1's structured layout, V2's structured layout +
LAST_BAIL, and (the crux) the per-block ADDRESS-next leader vs the EMITTED-next block —
so an address-INVERTED fall edge (the wall) is visible at a glance.

Usage:  py -3 tools/probe-emitorder.py 0xAD38 [--bank 1]
"""
import argparse
import importlib.util
import io
import re
import sys
import tempfile
from pathlib import Path
from contextlib import redirect_stdout

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))

import vm_cfg
import vm_decompile
import vm_reduce
_da = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da)
_da.loader.exec_module(decompile_all)

CODE_BANKS = [0, 1, 2, 15]
_GOTO = re.compile(r'\bgoto L_[0-9A-Fa-f]{4};')


def _collect(banks, v2):
    saved = vm_decompile.STRUCTURE_V2
    vm_decompile.STRUCTURE_V2 = v2
    out = {}
    try:
        with tempfile.TemporaryDirectory() as td:
            for bank in banks:
                def on_sub(stub, collect, _bank=bank):
                    out[(_bank, stub)] = collect
                with redirect_stdout(io.StringIO()):
                    decompile_all.bank_subs(bank, Path(td), on_sub=on_sub)
    finally:
        vm_decompile.STRUCTURE_V2 = saved
    return out


def _fmt_cfg(cfg):
    out = []
    for L in sorted(cfg, key=lambda x: (x is vm_cfg.EXIT, x)):
        s = ",".join(x if x is vm_cfg.EXIT else f"${x:04X}"
                     for x in sorted(cfg[L], key=lambda y: (y is vm_cfg.EXIT, y)))
        out.append(f"    ${L:04X} -> {{{s}}}")
    return "\n".join(out)


def _render(lines):
    return "\n".join(f"{'    '*i}{t}" for _a, i, t in lines)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("sub")
    ap.add_argument("--bank", type=int)
    args = ap.parse_args()
    target = int(args.sub, 0)
    banks = [args.bank] if args.bank is not None else CODE_BANKS

    v1 = _collect(banks, v2=False)
    v2 = _collect(banks, v2=True)
    key = next((k for k in v1 if k[1] == target), None)
    if key is None:
        print(f"sub ${target:04X} not found in banks {banks}")
        return
    bank, stub = key
    c1, c2 = v1[key], v2[key]
    instrs = c1['instructions']
    bc, leaders = vm_cfg.bytecode_cfg(instrs)

    print(f"=== bank {bank} ${stub:04X} ===\n")
    print(f"bytecode CFG ({len(leaders)} blocks):")
    print(_fmt_cfg(bc))

    # preds, to flag shared (>=2-pred) blocks (cross-jump merge targets)
    preds = {}
    for u, ss in bc.items():
        for s in ss:
            preds.setdefault(s, set()).add(u)
    shared = sorted(L for L in leaders if len(preds.get(L, ())) >= 2)
    print(f"\nshared (>=2-pred) blocks: {', '.join(f'${L:04X}' for L in shared) or '(none)'}")
    sinks = sorted(L for L in leaders if bc.get(L) == frozenset({vm_cfg.EXIT}))
    print(f"EXIT sinks: {', '.join(f'${L:04X}' for L in sinks) or '(none)'}")

    g1 = sum(1 for _a, _i, t in c1['structured'] if _GOTO.search(t))
    print(f"\n--- V1 templates (gotos {g1}) ---")
    print(_render(c1['structured']))

    vm_reduce.reduce(c2['raw'], c2['instructions'])
    g2 = sum(1 for _a, _i, t in c2['structured'] if _GOTO.search(t))
    print(f"\n--- V2 reducer (gotos {g2}, fallback={c2.get('gated_fallback')}, "
          f"LAST_BAIL={vm_reduce.LAST_BAIL}) ---")
    print(_render(c2['structured']))


if __name__ == "__main__":
    main()
