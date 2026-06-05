"""Pin the AI war-target SELECTION direction against the ROM, killing the
reverse-push ambiguity in the decompiled C.

Two questions, two oracles:

(1) fief_men_ratio_pct ($939D) semantics — which arg's men is the numerator?
    Decompiled: math32_2arg(men(arg2), men(arg1)) = 100*men(arg2)/(men(arg1)+men(arg2)).
    We set arg1@FP+0x0B = fiefA, arg2@FP+0x0D = fiefB with known men, read regL.

(2) pick_fief_with_most_men ($93B3) — does it return the candidate with the
    MOST men (name) or the FEWEST? We build a real FF-terminated candidate list,
    set distinct men per fief, run it, and read the returned fief id.
    (Arg offset for the list pointer is discovered empirically.)

A fief with zero rice reads as zero provisioned men (fief_men_if_provisioned $9382),
so we give every test fief rice>0.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

SEED = str(Path(__file__).resolve().parent.parent / "traces" / "b2-startbattle.dmp")
FP = 0x05FF
PROV = 0x7001
LISTADDR = 0x6F4F            # deduped_owner_list scratch

RATIO_BODY, RATIO_RET = 0x93A2, 0x93B2
PICK_BODY, PICK_RET = 0x93B8, 0x93DC


def set_fief(vm, fief, men, rice=99):
    base = PROV + fief * 26
    vm.mem.write_word(base + 16, men)
    vm.mem.write_word(base + 6, rice)


def run_to(vm, body, ret, fp=FP):
    vm.vm_fp = fp
    vm.vm_sp = fp - 10
    vm.vm_pc = body
    vm.cpu.pc = vm.DISPATCHER_ADDR
    for _ in range(20000):
        if vm.cpu.pc == vm.DISPATCHER_ADDR and vm.vm_pc == ret:
            return vm.regL & 0xFFFF
        if vm.step_one_vm_op() is None:
            break
    return None


def probe_ratio(fiefA_men, fiefB_men):
    vm = NobunagaVM(); vm.load_sram(SEED); vm.switch_bank(1)
    set_fief(vm, 3, fiefA_men); set_fief(vm, 4, fiefB_men)
    vm.mem.write_word(FP + 0x0B, 3)   # arg1 = fiefA
    vm.mem.write_word(FP + 0x0D, 4)   # arg2 = fiefB
    return run_to(vm, RATIO_BODY, RATIO_RET)


def probe_pick(fiefs_men, arg_off):
    """fiefs_men: dict fief->men. Returns the fief id pick returns."""
    vm = NobunagaVM(); vm.load_sram(SEED); vm.switch_bank(1)
    for f, m in fiefs_men.items():
        set_fief(vm, f, m)
    # write FF-terminated candidate list
    ids = list(fiefs_men.keys())
    for i, f in enumerate(ids):
        vm.mem.write(LISTADDR + i, f)
    vm.mem.write(LISTADDR + len(ids), 0xFF)
    vm.mem.write_word(FP + arg_off, LISTADDR)
    return run_to(vm, PICK_BODY, PICK_RET)


def main():
    print("=" * 74)
    print("AI war-target SELECTION direction — asking the ROM (bank 1)")
    print("=" * 74)

    print("\n(1) fief_men_ratio_pct(arg1=fief3, arg2=fief4): which men is numerator?")
    print(f"    {'menA(arg1)':>10} {'menB(arg2)':>10} {'ratio':>6}   interpretation")
    for a, b in [(200, 50), (50, 200), (100, 100), (30, 90)]:
        r = probe_ratio(a, b)
        note = ""
        if r is not None:
            if abs(r - 100 * b // (a + b)) <= 1:
                note = f"= arg2 share ({100*b//(a+b)}%)"
            elif abs(r - 100 * a // (a + b)) <= 1:
                note = f"= arg1 share ({100*a//(a+b)}%)"
        print(f"    {a:>10} {b:>10} {str(r):>6}   {note}")

    print("\n(2) pick_fief_with_most_men over fiefs {3:men200, 4:men50, 5:men120}")
    print("    -> returns the fief with MOST men (3) or FEWEST (4)?")
    fiefs = {3: 200, 4: 50, 5: 120}
    for off in (0x0B, 0x0C, 0x0D):
        r = probe_pick(fiefs, off)
        tag = ""
        if r == 3: tag = "MOST men  (name correct)"
        elif r == 4: tag = "FEWEST men (name backwards)"
        elif r in fiefs: tag = f"men={fiefs[r]}"
        print(f"    arg_off FP+0x{off:02X}:  returns fief {r}   {tag}")

    print("\n(2b) reversed men order {3:men50, 4:men200, 5:men120} (control):")
    fiefs2 = {3: 50, 4: 200, 5: 120}
    # use whichever arg_off returned a valid fief above; default 0x0B
    for off in (0x0B, 0x0C, 0x0D):
        r = probe_pick(fiefs2, off)
        if r in fiefs2:
            tag = "MOST" if fiefs2[r] == 200 else ("FEWEST" if fiefs2[r] == 50 else f"men={fiefs2[r]}")
            print(f"    arg_off FP+0x{off:02X}:  returns fief {r} (men={fiefs2[r]}) -> {tag}")


if __name__ == "__main__":
    main()
