#!/usr/bin/env python3
"""Render a fief's current visible screen from its PPU memory dump.

Replaces the 16 near-identical render-<fief>-from-ppu.py scripts (which differed
only in the hardcoded input/output paths). Consolidated 2026-05-29.

Usage:
    py -3.14 render-fief-from-ppu.py <fief>          # e.g. echigo, mino, mikawa
    py -3.14 render-fief-from-ppu.py <fief> --no-analysis
    py -3.14 render-fief-from-ppu.py --list          # list available PPU dumps

Input : traces/<fief>-ppu-memory.dmp   (16 KB PPU memory dump from Mesen)
Output: assets/maps/fiefs/<fief>-ppu-render.png  +  assets/maps/fiefs/<fief>-ppu-render-2x.png

PPU memory layout (16 KB = 4x $1000):
  $0000-$0FFF : pattern table 0 (BG, unused in NA1 combat)
  $1000-$1FFF : pattern table 1 (active CHR for the current scene)
  $2000-$23BF : nametable 0 (32x30 tile indices)
  $23C0-$23FF : attribute table 0
  $3F00-$3F1F : palettes

The pixels (tile decode, attribute quads, backdrop rule, RGB table) are the shared library's
(emu_harness machines.nes.ppu + the KOEI asset layer's MASTER); this tool keeps the dump layout.
"""
import os
import sys
import glob
from collections import Counter
from PIL import Image

from emu_harness.machines.nes import ppu as NR
from emu_harness.vm.koei.nes.assets import MASTER

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.dirname(HERE)
TRACES = os.path.join(PROJ, 'traces')
ATLAS = os.path.join(PROJ, 'atlas')

# The NES master palette (index -> RGB): the KOEI asset layer's one table (render-fief-truecolor
# imports it from here). Was nes-render's cool default until 2026-10-23.
NES_MASTER = MASTER

CHR_BASE = 0x1000   # BG pattern table base for combat (chapter 16)
NT_BASE  = 0x2000
ATTR_BASE = 0x23C0
PAL_BASE = 0x3F00


def list_dumps():
    dumps = sorted(glob.glob(os.path.join(TRACES, '*-ppu-memory.dmp')))
    print("Available PPU dumps:")
    for d in dumps:
        name = os.path.basename(d).replace('-ppu-memory.dmp', '')
        print(f"  {name}")


def decode_tile(ppu, idx):
    return NR.decode_tile(ppu, idx, CHR_BASE)


def attr_palette_index(attr_table, tile_col, tile_row):
    return NR.attr_subpalette(attr_table, tile_col, tile_row)


def render(fief, analysis=True):
    ppu_path = os.path.join(TRACES, f'{fief}-ppu-memory.dmp')
    if not os.path.exists(ppu_path):
        print(f"ERROR: no PPU dump for '{fief}' at {ppu_path}\n")
        list_dumps()
        sys.exit(1)

    with open(ppu_path, 'rb') as f:
        ppu = f.read()

    palette_16 = list(ppu[PAL_BASE:PAL_BASE + 16])
    attr_table = list(ppu[ATTR_BASE:ATTR_BASE + 64])
    print(f"[{fief}] palette: {' '.join(f'{b:02X}' for b in palette_16)}")

    WIDTH, HEIGHT = 32 * 8, 30 * 8
    img = NR.render_tiles(ppu, list(ppu[NT_BASE:NT_BASE + 960]), palette_16, cols=32, rows=30,
                          attr=attr_table, chr_base=CHR_BASE, master=NES_MASTER)

    os.makedirs(ATLAS, exist_ok=True)
    out_path = os.path.join(ATLAS, f'{fief}-ppu-render.png')
    img.save(out_path)
    img.resize((WIDTH * 2, HEIGHT * 2), Image.NEAREST).save(out_path.replace('.png', '-2x.png'))
    print(f"[{fief}] wrote {out_path} (+ -2x)")

    if analysis:
        nt_bytes = list(ppu[NT_BASE:NT_BASE + 960])
        print(f"[{fief}] top tile indices: " +
              ', '.join(f'${i:02X}x{c}' for i, c in Counter(nt_bytes).most_common(15)))


def main():
    args = [a for a in sys.argv[1:]]
    if not args or args[0] in ('-h', '--help'):
        print(__doc__)
        return
    if args[0] == '--list':
        list_dumps()
        return
    fief = args[0]
    analysis = '--no-analysis' not in args
    render(fief, analysis=analysis)


if __name__ == '__main__':
    main()
