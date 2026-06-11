#!/usr/bin/env python3
"""value-oracle.py — the value-golden oracle for the NA1 decompiler.

Runs any VM subroutine from the REAL ROM via the 6502 emulator (na1dream.cpu6502
+ nobunaga_vm), so the result is ground truth by construction — it IS the game's
code executing. This is the certifier the decompiler value-bugs need: DREAM's
4-c is "correct" only where it matches this oracle.

Core:  oracle_run(body, bank, args, ...) -> (return_value, mem_deltas)
Proven 2026-06-10: math32_muladddiv(7,3) -> 3 (real (7*3+9)/10), while DREAM's
ext-op stub returns 7. The divergence is the bug, certified.

CLI:   py -3 value-oracle.py certify-extop   # certify the 5 ext-op subs' formulas
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from na1dream.nobunaga_vm import NobunagaVM


def oracle_run(body, bank, args, frame_off=-16, max_ops=20000, sram=None):
    """Execute a VM sub from the real ROM. Returns (regL, {addr: (old,new)} deltas).

    args go into frame slots fp+0x0B, fp+0x0D, ... (the VM calling convention,
    matching run-effect.py). frame_off allocates locals below fp (negative)."""
    vm = NobunagaVM()
    vm.switch_bank(bank)
    if sram:
        vm.load_sram(sram)
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = (fp + frame_off) & 0xFFFF
    for i, a in enumerate(args):
        vm.mem.write_word(fp + 11 + 2 * i, a & 0xFFFF)
    vm.vm_pc = body
    vm.cpu.pc = vm.DISPATCHER_ADDR
    vm.run_until_outermost_return(max_ops=max_ops)
    return vm.regL


# The 5 ext-op subs (bug 1.3): DREAM emits `// ext_op ...` + a stub return.
# (name, body, bank, n_args, candidate formula as a python lambda)
# Formulas CERTIFIED against the real ROM 2026-06-10 (oracle == these for the whole grid).
EXTOP_SUBS = [
    ("math32_muladddiv",     0x8308, 1, 2, lambda a: (a[0]*a[1] + 9) // 10),
    ("scale_div10_capcheck", 0x832C, 1, 3, lambda a: 0xFFFF if (a[0]*a[1])//10 >= a[2] else (a[0]*a[1])//10),
    ("ratio_times10_capped", 0x835C, 1, 3, lambda a: min((a[0]*10)//a[1], a[2]) if a[1] else 0),
    ("math32_3arg",          0xD6BD, 15, 3, lambda a: (a[0]*a[1])//a[2] if a[2] else 0),
    ("math32_2arg",          0xD6E3, 15, 2, lambda a: (a[0]*100)//(a[0]+a[1]) if (a[0]+a[1]) else 0),
]

INPUT_GRID = [
    (50, 80, 30), (10, 10, 5), (7, 3, 100), (100, 45, 40),
    (255, 12, 9), (3, 7, 2), (1, 1, 1), (200, 200, 50), (33, 9, 1000),
]


def certify_extop():
    print("=== value-oracle: certifying the 5 ext-op subs against the real ROM ===\n")
    for name, body, bank, nargs, formula in EXTOP_SUBS:
        ok = True
        rows = []
        for g in INPUT_GRID:
            a = list(g[:nargs])
            got = oracle_run(body, bank, a)
            exp = formula(a)
            match = (got == (exp & 0xFFFF))
            ok = ok and match
            rows.append((a, got, exp, match))
        status = "CONFIRMED" if ok else "FORMULA MISMATCH (revise lambda)"
        print(f"{name} (${body:04X} bank {bank}) -- {status}")
        for a, got, exp, match in rows:
            flag = "" if match else "   <-- MISMATCH"
            print(f"    args={a}  oracle={got:>6}  formula={exp & 0xFFFF:>6}{flag}")
        print()


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "certify-extop"
    if cmd == "certify-extop":
        certify_extop()
    else:
        print(__doc__)
