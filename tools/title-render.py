#!/usr/bin/env python3
"""Render the title screen straight from ROM: the four title-scene blocks in bank 0
(nametable, attribute table, CHR, palette), drawn by the shared library.

  $A88A  960 B  nametable          -> PPU $2000
  $A84A   64 B  attribute table    -> PPU $23C0
  $AC4A   4 KB  CHR (256 tiles)    -> PPU $1000
  $B862   16 B  BG palette         -> PPU $3F00 (via the $0700 shadow)

The nametable used to come from a trace extract (assets/data/nametable_bytes.txt); the ROM's
$A88A block equals it on all 960 bytes, so no capture is needed. The pixels are emu-harness's
(machines.nes.ppu, the KOEI asset layer's MASTER); this tool keeps the layout and the outputs.

Usage:  py -3.14 tools/title-render.py
Writes  assets/screens/title-screen.png, title-screen-2x.png and assets/data/title-screen-ascii.txt.
"""
from pathlib import Path

from PIL import Image

from emu_harness.machines.nes import ppu as NR
from emu_harness.vm.koei.nes.assets import MASTER

NOB = Path(__file__).resolve().parent.parent
ROM = (NOB / "Nobunaga's Ambition (USA).nes").read_bytes()[16:]
OUT = NOB / "assets" / "screens"

TITLE_ATTR_CPU = 0xA84A
TITLE_NT_CPU   = 0xA88A
TITLE_CHR_CPU  = 0xAC4A
TITLE_PAL_CPU  = 0xB862


def bank0(cpu_addr, n):
    o = cpu_addr - 0x8000
    return list(ROM[o:o + n])


def main():
    nt = bank0(TITLE_NT_CPU, 960)
    img = NR.render_tiles(bytes(bank0(TITLE_CHR_CPU, 0x1000)), nt, bank0(TITLE_PAL_CPU, 16),
                          cols=32, rows=30, attr=bank0(TITLE_ATTR_CPU, 64), master=MASTER)
    OUT.mkdir(parents=True, exist_ok=True)
    img.save(OUT / "title-screen.png")
    img.resize((img.width * 2, img.height * 2), Image.NEAREST).save(OUT / "title-screen-2x.png")

    # ASCII art: each pixel's brightness in four buckets
    chars = " .+#"
    px = img.load()
    lines = []
    for y in range(img.height):
        row = "".join(chars[min(sum(px[x, y]) // 3 // 64, 3)] for x in range(img.width))
        lines.append(row if row.strip() else "")
    (NOB / "assets" / "data" / "title-screen-ascii.txt").write_text("\n".join(lines) + "\n")
    print(f"wrote {OUT / 'title-screen.png'} (+ -2x) and title-screen-ascii.txt from ROM "
          f"(nametable ${TITLE_NT_CPU:04X}, CHR ${TITLE_CHR_CPU:04X})")


if __name__ == "__main__":
    main()
