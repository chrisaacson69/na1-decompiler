#!/usr/bin/env python3
"""Parse the combat trace and reconstruct nametable writes + bulk uploads.

Trace format (filtered):
  PC  MNEMONIC  ...  A:NN X:NN Y:NN  S:NN  P:flags  Fr:NNNN  Cycle:NNNN  BC:bytes

Lines are parsed by emu-harness (backends.mesen.tracelog: any Mesen column layout, .gz
transparent); the NA1-specific part is which routines are which: row uploader $C480, bulk
uploader $C293. For the routine-free view of the same uploads, see emu-harness
machines/nes/trace (PPU registers only). py -3.14.
"""
import sys

from emu_harness.backends.mesen import debugger_dir
from emu_harness.backends.mesen.tracelog import read_tracelog

# Default = Mesen's live trace; pass a path (incl. an archived traces/*.txt[.gz]) to decode that instead.
DEFAULT_TRACE = debugger_dir() / "Nobunaga's Ambition (USA).txt"
TRACE = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_TRACE

# Group events into "row uploads" each starting with $C480
events = []
current_row = None
bulk_blocks = []
current_bulk = None

for st in read_tracelog(TRACE):
    pc = f"{st.pc:04X}"
    a_val, fr = st.a, st.frame
    eq, addr = st.old, st.addr

    if pc == 'C480':
        # Start of a new row upload — save the previous one first
        if current_row is not None:
            events.append(current_row)
        current_row = {'fr_start': fr, 'ppu_hi': None, 'ppu_lo': None, 'bytes': [], 'sources': []}
        # The trace shows "LDA $0068 = $XX" where $XX is the value read into A
        if eq is not None:
            current_row['ppu_hi'] = eq
    elif pc == 'C486':
        if eq is not None and current_row is not None:
            current_row['ppu_lo'] = eq
    elif pc == 'C49A':
        # LDA ($5C,X) [$XXXX] — source address resolved
        if addr is not None and current_row is not None:
            current_row['sources'].append(addr)
    elif pc == 'C4B5':
        # The byte being written = A register
        if a_val is not None and current_row is not None:
            current_row['bytes'].append(a_val)
    elif pc == 'C293':
        if current_bulk is not None:
            bulk_blocks.append(current_bulk)
        current_bulk = {'fr_start': fr, 'ppu_hi': None, 'ppu_lo': None, 'bytes': [], 'sources': []}
        if eq is not None:
            current_bulk['ppu_hi'] = eq
    elif pc == 'C299':
        if eq is not None and current_bulk is not None:
            current_bulk['ppu_lo'] = eq
    elif pc == 'C29F':
        if addr is not None and current_bulk is not None:
            current_bulk['sources'].append(addr)
    elif pc == 'C2A1':
        if a_val is not None and current_bulk is not None:
            current_bulk['bytes'].append(a_val)

# Flush
if current_row is not None: events.append(current_row)
if current_bulk is not None: bulk_blocks.append(current_bulk)

print(f"Parsed {len(events)} row uploads and {len(bulk_blocks)} bulk blocks")
print()

# Group row uploads into "scenes" — a scene is a sequence of row uploads with
# no big frame gaps (or no bulk uploads breaking them up).
print("=== Row uploads, summary ===")
print(f"{'#':>4} {'Fr':>6} {'PPU':>6} {'Len':>4} {'Mode':>5}  {'src start':>10}  bytes (first 16)")
for i, e in enumerate(events):
    if e['ppu_hi'] is None or e['ppu_lo'] is None: continue
    ppu = (e['ppu_hi'] << 8) | e['ppu_lo']
    n = len(e['bytes'])
    mode = "IDX" if e['sources'] else "FILL"
    src = f"${e['sources'][0]:04X}" if e['sources'] else "—"
    head = ' '.join(f"{b:02X}" for b in e['bytes'][:16])
    fr = '—' if e['fr_start'] is None else e['fr_start']   # traces logged without the Fr column
    print(f"{i:>4} {fr:>6} ${ppu:04X} {n:>4} {mode:>5}  {src:>10}  {head}")

print()
print("=== Bulk blocks, summary ===")
print(f"{'#':>4} {'Fr':>6} {'PPU':>6} {'Len':>5}  {'src start':>10}")
for i, b in enumerate(bulk_blocks):
    if b['ppu_hi'] is None or b['ppu_lo'] is None: continue
    ppu = (b['ppu_hi'] << 8) | b['ppu_lo']
    n = len(b['bytes'])
    src = f"${b['sources'][0]:04X}" if b['sources'] else "—"
    fr = '—' if b['fr_start'] is None else b['fr_start']
    print(f"{i:>4} {fr:>6} ${ppu:04X} {n:>5}  {src:>10}")
