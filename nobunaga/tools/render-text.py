"""
render-text.py — render arbitrary text in Nobunaga's Ambition's OWN built-in font,
pulled straight from the ROM (no emulator). The font the game uses for nearly all
nametable text.

How it was found (see ROADMAP):
  The text pipeline is  format_string ($CFFC)  ->  redraw_window ($CEC9) /
  char_advance_width ($CE81)  ->  char_classify ($CDCA)  which maps an ASCII byte
  to a pattern-table tile index as  tile = ascii - 40  (digits '0'=48 -> tile 8,
  'A'=65 -> 25, 'a'=97 -> 57). The glyph BITMAPS are CHR-RAM, uploaded by
  render_boot_title_screens ($88AC) just before the first menu text is drawn:
      ppu_upload_block_wrap(81,  $1000, $B2BA, bank 0)   # tiles  0..80
      ppu_upload_block_wrap(177, $14D0, $8264, bank 6)   # tiles 77..253
  So glyph for char c lives at  FONT0 + (c-40)*16  in bank 0  (c-40 <= 80), and the
  high tiles (lowercase tail etc.) at  FONT6 + (tile-77)*16  in bank 6. 2bpp, the
  ink is any non-zero pixel.

Usage:
  py -3.14 tools/render-text.py "NOBUNAGA"  --out assets/screens/text.png
  py -3.14 tools/render-text.py "Lord  3" --scale 6 --fg f0b429 --bg 15151c
  py -3.14 tools/render-text.py --atlas assets/screens/font-atlas.png      # dump the whole glyph set

Importable:  from render_text import render_text, FontError
             img = render_text("ATTACK", scale=4, fg=(240,180,41))

The font itself (where it lives, char_classify, the 2bpp decode) is the shared library's
(emu_harness.vm.koei.nes.assets.text, machines.nes.ppu); this tool keeps NA1's RGB presentation.
"""
import sys, argparse
from pathlib import Path
from PIL import Image

from emu_harness.machines.nes import ppu as NR
from emu_harness.vm.koei.nes.assets import text as KT

ROOT = Path(__file__).resolve().parent.parent
ROM = ROOT / "Nobunaga's Ambition (USA).nes"
HDR = 16
TILE_W = TILE_H = 8

class FontError(Exception):
    pass

def _rom():
    if not ROM.exists():
        raise FontError(f"ROM not found: {ROM}")
    return ROM.read_bytes()

_FONT = {}

def _tile_bitmap(rom, tile):
    """Return the 8x8 ink mask (list of 8 rows of 8 bools) for a font tile index."""
    key = (len(rom), hash(rom))
    if key not in _FONT:
        _FONT[key] = KT.assemble_font_chr(rom[HDR:])[0]
    return [[v != 0 for v in row] for row in NR.decode_tile(_FONT[key], tile)]

def char_to_tile(ch):
    """char_classify: ASCII -> font tile index (None = render blank)."""
    return KT.char_to_tile(ch)

def render_text(text, scale=4, fg=(255, 255, 255), bg=None, tracking=0):
    """Render a single line of text in the game font. bg=None -> transparent."""
    rom = _rom()
    n = len(text)
    cw = TILE_W + tracking
    W, H = max(1, n * cw - (tracking if n else 0)), TILE_H
    mode = "RGB" if bg else "RGBA"
    base = bg if bg else (0, 0, 0, 0)
    img = Image.new(mode, (W * scale, H * scale), base)
    px = img.load()
    inkpix = fg if bg else (fg[0], fg[1], fg[2], 255)
    for i, ch in enumerate(text):
        tile = char_to_tile(ch)
        if tile is None:
            continue
        bmp = _tile_bitmap(rom, tile)
        ox = i * cw
        for y in range(8):
            for x in range(8):
                if bmp[y][x]:
                    for sy in range(scale):
                        for sx in range(scale):
                            px[(ox + x) * scale + sx, y * scale + sy] = inkpix
    return img

def render_font_atlas(out, scale=5):
    """Dump the whole glyph set with ASCII labels, for verification."""
    rom = _rom()
    chars = [chr(c) for c in range(40, 123)]
    cols = 16
    rows = (len(chars) + cols - 1) // cols
    cell = 10
    img = Image.new("RGB", (cols * cell * scale, rows * cell * scale), (40, 40, 55))
    px = img.load()
    for idx, ch in enumerate(chars):
        tile = char_to_tile(ch)
        if tile is None:
            continue
        bmp = _tile_bitmap(rom, tile)
        cx, cy = (idx % cols) * cell * scale, (idx // cols) * cell * scale
        for y in range(8):
            for x in range(8):
                c = (200, 200, 255) if bmp[y][x] else (15, 15, 25)
                for sy in range(scale):
                    for sx in range(scale):
                        px[cx + x * scale + sx, cy + y * scale + sy] = c
    Path(out).parent.mkdir(parents=True, exist_ok=True)
    img.save(out)
    print(f"wrote {out}  ({len(chars)} glyphs, ASCII 40-122)")

def _hexcolor(s):
    s = s.lstrip("#")
    return tuple(int(s[i:i+2], 16) for i in (0, 2, 4))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("text", nargs="?")
    ap.add_argument("--out", default=None)
    ap.add_argument("--scale", type=int, default=4)
    ap.add_argument("--fg", default="ffffff")
    ap.add_argument("--bg", default=None)
    ap.add_argument("--tracking", type=int, default=0, help="extra px between glyphs")
    ap.add_argument("--atlas", default=None, help="dump the full glyph set to this PNG")
    a = ap.parse_args()
    if a.atlas:
        render_font_atlas(a.atlas)
        return
    if not a.text:
        ap.error("provide TEXT or --atlas")
    img = render_text(a.text, scale=a.scale, fg=_hexcolor(a.fg),
                      bg=_hexcolor(a.bg) if a.bg else None, tracking=a.tracking)
    out = a.out or "assets/screens/text.png"
    Path(out).parent.mkdir(parents=True, exist_ok=True)
    img.save(out)
    print(f"wrote {out}  ({img.width}x{img.height})")

if __name__ == "__main__":
    main()
