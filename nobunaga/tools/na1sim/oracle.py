"""
oracle.py — ground na1sim's economy against the REAL ROM via the na1dream
emulator (Chris's "test it against the emulator"). Runs effect_grow ($87F0) in
the emulator on a real SRAM state and compares the deltas to na1sim.econ.grow
on the same state. The definitive check on the develop formula.

Run:  py -3 -m na1sim.oracle [sram.dmp] [amount ...]
"""

import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
sys.path.insert(0, str(REPO / "tools"))
from na1dream.nobunaga_vm import NobunagaVM        # noqa: E402

from . import econ                                  # noqa: E402
from .state import Province                         # noqa: E402

DEFAULT_SRAM = REPO / "traces" / "aftertax.dmp"
GROW = {"body": 0x87F5, "frame_off": -4, "bank": 1}
F = ["gold", "_", "town", "rice", "output", "dams", "loyalty",
     "wealth", "men", "morale", "skill", "arms", "header"]


def _read_fief(vm, sel):
    base = 0x7001 + sel * 26
    return {f: vm.mem.read_word(base + i * 2) for i, f in enumerate(F) if f != "_"}


def rom_grow(sram, amount):
    vm = NobunagaVM()
    vm.load_sram(str(sram))
    sel = vm.mem.read(0x6F5F)
    const_two = vm.mem.read(0x6D63)
    pre = _read_fief(vm, sel)
    base = 0x7001 + sel * 26
    vm.switch_bank(1)
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = fp + GROW["frame_off"]
    vm.mem.write_word(fp + 11, base)        # arg1 = record ptr
    vm.mem.write_word(fp + 13, amount)      # arg2 = amount
    vm.vm_pc = GROW["body"]
    vm.cpu.pc = vm.DISPATCHER_ADDR
    try:
        vm.run_until_outermost_return(max_ops=2000)
    except Exception:
        pass        # benign end-of-run trap (run-effect.py wraps it too)
    post = _read_fief(vm, sel)
    deltas = {k: post[k] - pre[k] for k in pre if post[k] != pre[k]}
    return sel, const_two, pre, deltas


def py_grow(pre, amount, const_two):
    econ.SKILL = const_two
    p = Province(idx=0, name="t", header=pre["header"], gold=pre["gold"], debt=0,
                 town=pre["town"], rice=pre["rice"], output=pre["output"], dams=pre["dams"],
                 loyalty=pre["loyalty"], wealth=pre["wealth"], men=pre["men"],
                 morale=pre["morale"], skill=pre["skill"], arms=pre["arms"],
                 lm=0, wm=0, om=0, dm=0, owner=0, tax=20)
    econ.grow(p, amount)
    return {"gold": p.gold - pre["gold"], "output": p.output - pre["output"],
            "loyalty": p.loyalty - pre["loyalty"], "dams": p.dams - pre["dams"]}


def main():
    sram = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_SRAM
    amounts = [int(a) for a in sys.argv[2:]] or [30, 60, 120]
    print(f"=== oracle: econ.grow vs ROM effect_grow ($87F0) | {sram.name} ===")
    for amt in amounts:
        sel, c2, pre, rom = rom_grow(sram, amt)
        py = py_grow(pre, amt, c2)
        rom_n = {k: rom.get(k, 0) for k in ("output", "gold", "loyalty", "dams")}
        py_n = {k: py.get(k, 0) for k in ("output", "gold", "loyalty", "dams")}
        match = "MATCH" if rom_n == py_n else "DIFF"
        print(f"  fief {sel} skill={c2} amount={amt} "
              f"(out={pre['output']} loy={pre['loyalty']} dams={pre['dams']})")
        print(f"    ROM: {rom_n}")
        print(f"    py : {py_n}   -> {match}")


if __name__ == "__main__":
    main()
