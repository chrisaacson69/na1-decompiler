#!/usr/bin/env python3
"""Reconstruct CHR-RAM ($1000-$1FFF) from a Mesen trace.

Originally followed NA1's bulk uploader ($C293 high, $C29C low, $C2A1 data). Since emu-harness
row Q it follows the PPU registers themselves (machines/nes/trace: $2006 address, $2007 data),
so a CHR byte written by any routine counts. On the Debugger trace of 2026-05-27 the result is
identical to the old routine-based extraction (4096/4096 bytes). py -3.14.

  py -3.14 extract-chr-from-trace.py [trace.txt[.gz]]
"""
import os
import sys

from emu_harness.backends.mesen import debugger_dir
from emu_harness.backends.mesen.tracelog import read_tracelog
from emu_harness.machines.nes.trace import PPUWrites

TRACE = sys.argv[1] if len(sys.argv) > 1 else debugger_dir() / "Nobunaga's Ambition (USA).txt"

chr_data = PPUWrites().feed_all(read_tracelog(TRACE)).vram

# Save to a file the renderer can read
here = os.path.dirname(os.path.abspath(__file__))
out = os.path.join(here, '..', 'assets', 'data', 'title-chr.bin')
with open(out, 'wb') as f:
    # Save the PPU $1000-$1FFF range (4 KB)
    f.write(chr_data[0x1000:0x2000])
print(f"Wrote {out}  (4096 bytes from PPU $1000-$1FFF reconstructed from trace)")

# Sanity check — how many bytes got written
written = sum(1 for b in chr_data[0x1000:0x2000] if b != 0)
print(f"  {written} of 4096 bytes are non-zero")
