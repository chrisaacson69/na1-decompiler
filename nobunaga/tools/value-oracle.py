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


def certify_extop():
    """Superseded 2026-10-27. The June lambdas here were unsigned and dropped the guards, and the
    9-point grid had no input on a branch edge, so they "certified" wrong formulas. The models now
    live with the C they describe (emu-harness vm_decompile._EXTOP_OVERRIDES_NA1), and cfg_gate
    checks them against the ROM over an edge grid; this delegates to that check."""
    from emu_harness.vm.koei.nes import vm_decompile as VC
    from emu_harness.vm.koei.nes.gates.cfg_gate import override_value_check
    VC.set_schema("na1")
    bad = 0
    for stub in VC._EXTOP_OVERRIDE:
        diffs = override_value_check(stub)
        bad += bool(diffs)
        print(f"${stub:04X}: {'CONFIRMED' if not diffs else f'{len(diffs)} DISAGREE, e.g. {diffs[:3]}'}")
    return 1 if bad else 0


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "certify-extop"
    if cmd == "certify-extop":
        sys.exit(certify_extop())
    else:
        print(__doc__)
