"""na1_regen.py - regenerate NA1's bytecode source tiers from the shared engine (emu-harness).

The walks' apply steps (label-walk-apply, var-walk-apply) regenerate after writing names, then guard
the diff. They used to run tools/decompile-all.py, which the graduation to the shared engine removed,
so a batch could not complete. This is source/README.md's recipe, for every bytecode bank, so the
guard also sees a name that leaks into ANOTHER bank:

  2-asm-vm/bank_NN_vm.asm   disasm na1 N
  4-c/bank_NN.c             decompile na1 N        (structured)
  3-c-basic/bank_NN.raw.c   decompile na1 N --raw  (goto form)

One process per step: the decompiler keeps its structuring switches in module globals, so a raw run
would leave later banks unstructured. Needs py -3.14 with emu-harness installed.
(all_banks.c, the merged view, has no generator any more; see emu-harness MIGRATION.md revisits.)
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "source"
BANKS = (0, 1, 2, 10, 14, 15)


def regen(banks=BANKS):
    """Regenerate every tier of `banks`; -> [] or the failing steps' messages."""
    errs = []
    for b in banks:
        bb = f"{b:02d}"
        asm = SRC / "2-asm-vm" / f"bank_{bb}_vm.asm"
        for args in (["disasm", "na1", str(b), str(asm)],
                     ["decompile", "na1", str(b), str(asm), str(SRC / "4-c" / f"bank_{bb}.c")],
                     ["decompile", "na1", str(b), str(asm), str(SRC / "3-c-basic" / f"bank_{bb}.raw.c"), "--raw"]):
            r = subprocess.run([sys.executable, "-m", "emu_harness.vm.koei.nes.titles", *args],
                               cwd=ROOT, capture_output=True, text=True)
            if r.returncode != 0:
                errs.append(f"{' '.join(args)}: {r.stdout[-400:]}{r.stderr[-400:]}")
    return errs


if __name__ == "__main__":
    e = regen()
    print("\n".join(e) if e else f"regenerated banks {', '.join(map(str, BANKS))}")
    sys.exit(1 if e else 0)
