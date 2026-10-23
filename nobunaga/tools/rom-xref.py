"""
rom-xref.py - who references which ROM DATA pointer, and what is it. The ROM-side twin of data-xref.py.
ROM tables & strings are reached as IMMEDIATE-WORD POINTERS ($8A loadA / $8C loadB / $8E push).

Moved to emu-harness (its MIGRATION.md row K): a thin CLI over `emu_harness.vm.koei.nes.dataxref na1`,
whose ROM views are this tool's (classification code / str / tbl, jump-table check, slugs, toml
emission). Named differences:
  - each pointer is decoded in the bank that OWNS the byte (the window model), not the bank of the
    referencing sub: a fixed-bank string is one asset, not one row per referencing bank, and a
    $8000-$BFFF pointer from fixed-bank code has no single owner (it read bank 15's bytes);
  - every bytecode bank is read (bank 10's `jumptab_8617`, play_audio_by_id's, appears);
  - two labels on one byte resolve to the first, as the shared registry reader does.

Commands:
  frontier [--unlabeled] [--class str|tbl|code] [--bank N] [--min N]
  refs <addr> [--bank N]      detail for one pointer (which subs, which sites)
  strings [--toml] [--bank N] all str-class pointers; --toml emits paste-ready labels
  tables [--toml] [--bank N]  non-string tables named by provenance (combat geometry deferred)
  stats                       class/region breakdown
"""
import sys

from emu_harness.vm.koei.nes import dataxref

DEFER = "quadrant,render_combat_map"   # NA1's combat-geometry tables: a focused session, not this pass

if __name__ == "__main__":
    args = sys.argv[1:]
    if args and args[0] == "refs":
        args[0] = "ptr-refs"
    if args and args[0] == "tables":
        args += ["--defer", DEFER]
    sys.exit(dataxref.main([sys.argv[0], "na1", *args]))
