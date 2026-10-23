"""
data-xref.py - who reads / writes / points at a data address. The variable-side twin of
native-call-index.py: name a sub by behavior, then ask "who touches X?" to recover a DATA item's role.

Moved to emu-harness (its MIGRATION.md row K): a thin CLI over `emu_harness.vm.koei.nes.dataxref na1`.
The index is read from the decoded bytecode of every bank (not the committed listing), each operand
classified by the shared opcode table's semantics. Named differences from this tool's own table:
$A7 is `ldC.b` (a byte READ into regC), not address-of; `ADD_imm2` ($90) is an arithmetic constant,
not a pointer (bank 1's `ADD_imm2 $F9E9` is -1559, a year offset); and a $8000-$BFFF pointer from
fixed-bank code has no single owning bank (it was keyed to bank 15, i.e. the wrong byte).

Commands (addr accepts 6FF6 / 0x6FF6 / $6FF6 / a label name):
  refs <addr|name>         every ref, grouped by sub (= C function), kind + site
  hot [--min N]            RAM/SRAM vars ranked by ref count (naming priority)
      [--unlabeled]        ... restricted to addresses with NO toml name yet
      [--lo HEX --hi HEX]  ... restricted to a window (default 0x6000-0x7FFF)
  hot --rom [--min N]      ROM ASSETS ranked by pointer-ref count, per (bank,addr)
      [--unlabeled]
"""
import sys

from emu_harness.vm.koei.nes import dataxref

if __name__ == "__main__":
    sys.exit(dataxref.main([sys.argv[0], "na1", *sys.argv[1:]]))
