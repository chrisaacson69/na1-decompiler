"""font.py — build a scalable web @font-face from the game's own CHR text font.

render-text.py already locates the font in CHR and maps ASCII -> glyph bitmap:
    char_to_tile(ch)        ASCII -> font tile index (char_classify $CDCA)
    _tile_bitmap(rom, tile) -> 8x8 ink mask (list of 8 rows of 8 bools)

We turn each 8x8 bitmap into a real TrueType glyph: every lit pixel becomes a filled
square contour. The result is a pixel-exact, infinitely scalable @font-face — the
in-game font, not an approximation. The grid is monospace (8px advance), which matches
the game's grid-aligned status screens.

    py -3 -m wikipages.font   # writes assets/fonts/nobunaga.ttf
"""
from __future__ import annotations

import importlib.util
from pathlib import Path

from fontTools.fontBuilder import FontBuilder
from fontTools.pens.ttGlyphPen import TTGlyphPen

ROOT = Path(__file__).resolve().parent.parent.parent  # .../nobunaga
TOOLS = ROOT / "tools"

PIXEL = 128                 # font units per source pixel
EM = 8 * PIXEL              # 1024 units/em, an 8px cell fills the em
FAMILY = "NobunagaFont"
OUT = ROOT / "assets" / "fonts" / "nobunaga.ttf"


def _render_text_mod():
    spec = importlib.util.spec_from_file_location("na1_render_text", TOOLS / "render-text.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def _square(pen, col, row):
    """Append one filled pixel square (row 0 = top) wound consistently for nonzero fill."""
    x0, x1 = col * PIXEL, (col + 1) * PIXEL
    # row 0 is the top of the cell; font y is up with the baseline at 0
    y0, y1 = (7 - row) * PIXEL, (8 - row) * PIXEL
    pen.moveTo((x0, y0))
    pen.lineTo((x1, y0))
    pen.lineTo((x1, y1))
    pen.lineTo((x0, y1))
    pen.closePath()


def build_font(out: Path = OUT) -> Path:
    rt = _render_text_mod()
    rom = rt._rom()

    # Which codepoints the game font can render (space + anything char_to_tile maps).
    codepoints = [cp for cp in range(32, 127)
                  if cp == 32 or rt.char_to_tile(chr(cp)) is not None]

    glyph_order = [".notdef", "space"]
    cmap = {32: "space"}
    glyphs = {}
    advances = {".notdef": EM, "space": EM}

    # .notdef: a hollow box so missing glyphs are visible, not invisible.
    notdef = TTGlyphPen(None)
    for c in range(8):
        _square(notdef, c, 0); _square(notdef, c, 7)
    for r in range(8):
        _square(notdef, 0, r); _square(notdef, 7, r)
    glyphs[".notdef"] = notdef.glyph()
    glyphs["space"] = TTGlyphPen(None).glyph()

    for cp in codepoints:
        if cp == 32:
            continue
        ch = chr(cp)
        name = f"uni{cp:04X}"
        tile = rt.char_to_tile(ch)
        bmp = rt._tile_bitmap(rom, tile)
        pen = TTGlyphPen(None)
        for row in range(8):
            for col in range(8):
                if bmp[row][col]:
                    _square(pen, col, row)
        glyphs[name] = pen.glyph()
        advances[name] = EM
        glyph_order.append(name)
        cmap[cp] = name

    fb = FontBuilder(EM, isTTF=True)
    fb.setupGlyphOrder(glyph_order)
    fb.setupCharacterMap(cmap)
    fb.setupGlyf(glyphs)
    fb.setupHorizontalMetrics({g: (advances[g], 0) for g in glyph_order})
    fb.setupHorizontalHeader(ascent=EM, descent=0)
    fb.setupNameTable({
        "familyName": FAMILY,
        "styleName": "Regular",
        "fullName": f"{FAMILY} Regular",
        "psName": f"{FAMILY}-Regular",
        "version": "1.0",
        "uniqueFontIdentifier": f"{FAMILY}-1.0",
    })
    fb.setupOS2(sTypoAscender=EM, sTypoDescender=0, usWinAscent=EM, usWinDescent=0)
    fb.setupPost()
    out.parent.mkdir(parents=True, exist_ok=True)
    fb.save(str(out))
    print(f"wrote {out.relative_to(ROOT)}  ({len(glyph_order)} glyphs, "
          f"codepoints {min(cmap)}-{max(cmap)})")
    return out


if __name__ == "__main__":
    build_font()
