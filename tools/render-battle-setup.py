#!/usr/bin/env python3
"""Render a battle's deployment: the fief's true-colour tactical map with both armies on it.

The terrain is render-fief-truecolor.py's (ROM path: map_populate $8903, the combat CHR, the
per-fief attribute table). The units are stamped the way draw_unit_count_digits $89DF draws
them, the bottom half of the cell, 4x2 tiles from unit_count_digit_tiles $6FE5 + side*9:

    [lead / slot] [flag] [flag] [flag]        lead: 178 ($B2) daimyo-led, 179 ($B3) a general,
    [thousands] [hundreds] [tens] [ones]      on slot 0; slots 1-4 show their number
                                                     (traces: $6FE5 holds 178/179 or 10-13)

Flags are tiles $51-$53 (attacker) / $54-$56 (defender), the per-fief upload. Men are capped at
9999 and printed without leading zeros. Optional marks: the attacker's entry strip
(set_combat_arena_rect_by_approach $9675); battle-entry-atlas.py adds placeable / banned cells.

Inputs: a Mesen SRAM dump (.dmp, 8 KB of $6000-$7FFF), or, as a library, a na1sim Memory
(`render_memory`). A unit at column 200 is off the map (absent or dead).

Usage:
  py -3.14 tools/render-battle-setup.py traces/b2-startbattle.dmp --out assets/maps/battles/b2-start.png
  py -3.14 tools/render-battle-setup.py <dump> --strip       # tint the attacker's entry strip
"""
import sys, struct, importlib.util
from pathlib import Path
from PIL import Image, ImageDraw

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
_spec = importlib.util.spec_from_file_location("render_fief_truecolor", HERE / "render-fief-truecolor.py")
rft = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(rft)

UNIT_COL, UNIT_ROW, UNIT_MEN = 0x6FD0, 0x6FDA, 0x6FBC   # memmap.py UNIT_COL_BASE / ROW / STRENGTH
WAR_SIDE_FLAG = 0x6F65                                  # bit 7: the side is led by its daimyo
ARENA = 0x6FF6                                          # x_min, y_min, x_max, y_max (words)
DEFENDING, SCENARIO = 0x6F63, 0x6D9D
SUBPAL = (3, 0)          # attacker / defender sub-palette for the unit half (visual choice; see README)
CELL = 32


def digits(men):
    """thousands, hundreds, tens, ones as tiles: blank (1) for leading zeros, digit d = tile d + 8."""
    s = f"{min(men, 9999):4d}"
    return [1 if ch == " " else 8 + int(ch) for ch in s]


def unit_tiles(side, slot, men, daimyo_led):
    lead = (178 if daimyo_led else 179) if slot == 0 else 8 + slot + 1
    th, hu, te, on = digits(men)
    return [lead, 0x51 + side * 3, 0x52 + side * 3, 0x53 + side * 3, th, hu, te, on][:4] + [1, hu, te, on] if th == 1 else \
           [lead, 0x51 + side * 3, 0x52 + side * 3, 0x53 + side * 3, th, hu, te, on]


def units_from(r8, r16):
    """[(side, slot, col, row, men, daimyo_led)] for every unit on the map."""
    out = []
    for side in (0, 1):
        led = bool(r8(WAR_SIDE_FLAG + side) & 0x80)
        for slot in range(5):
            col, row = r8(UNIT_COL + side * 5 + slot), r8(UNIT_ROW + side * 5 + slot)
            if col <= 10 and row <= 4:
                out.append((side, slot, col, row, r16(UNIT_MEN + side * 10 + slot * 2), led))
    return out


def cell_box(col, row, scale):
    x, y = col * CELL, row * CELL + (CELL // 2 if col & 1 else 0)
    return [x * scale, y * scale, (x + CELL) * scale - 1, (y + CELL) * scale - 1]


def draw(province, units, rect=None, scenario=17, scale=3, strip=False, corners=None, title=None, out=None,
         valid=None, banned=None):
    """valid / banned: cell sets to tint (the attacker's placeable strip cells / its strip cells it may
    not use). Without them, strip=True tints the whole arena rect."""
    overlay = {(c, r): (unit_tiles(sd, sl, men, led), SUBPAL[sd]) for sd, sl, c, r, men, led in units}
    img = _render(province, scenario, overlay, scale)
    if valid is None and strip and rect and rect != (0, 0, 10, 4):
        valid = {(c, r) for c in range(rect[0], rect[2] + 1) for r in range(rect[1], rect[3] + 1)}
    if valid or banned or corners:
        layer = Image.new("RGBA", img.size, (0, 0, 0, 0)); d = ImageDraw.Draw(layer)
        w = max(1, scale // 2)
        for c, r in valid or ():
            d.rectangle(cell_box(c, r, scale), fill=(255, 60, 40, 46), outline=(255, 90, 60, 170), width=w)
        for c, r in banned or ():
            b = cell_box(c, r, scale)
            d.rectangle(b, fill=(0, 0, 0, 90))
            d.line([b[0], b[1], b[2], b[3]], fill=(255, 255, 255, 120), width=w)
            d.line([b[0], b[3], b[2], b[1]], fill=(255, 255, 255, 120), width=w)
        for c, r in corners or ():
            d.rectangle(cell_box(c, r, scale), outline=(255, 230, 40, 255), width=scale)
        img = Image.alpha_composite(img.convert("RGBA"), layer).convert("RGB")
    if title:
        bar = Image.new("RGB", (img.width, 14 * scale), (16, 16, 22)); ImageDraw.Draw(bar).text((4 * scale, 2 * scale), title, fill=(235, 235, 235))
        both = Image.new("RGB", (img.width, img.height + bar.height)); both.paste(bar, (0, 0)); both.paste(img, (0, bar.height)); img = both
    if out:
        Path(out).parent.mkdir(parents=True, exist_ok=True); img.save(out); print(f"-> {out}")
    return img


def _render(province, scenario, overlay, scale):
    """render-fief-truecolor.render without its file write."""
    import io, contextlib
    with contextlib.redirect_stdout(io.StringIO()):
        return rft.render(province, scenario, overlay=overlay, scale=scale, out_path=Path(HERE / "_battles" / "_last.png"))


def render_memory(m, **kw):
    """A na1sim Memory, after deployment."""
    rect = tuple(m.r16(ARENA + 2 * i) for i in range(4))
    return draw(m.defending, units_from(m.r8, m.r16), rect=rect, **kw)


def render_dump(path, **kw):
    d = Path(path).read_bytes()
    r8 = lambda a: d[a - 0x6000]
    r16 = lambda a: struct.unpack_from("<H", d, a - 0x6000)[0]
    rect = tuple(r16(ARENA + 2 * i) for i in range(4))
    scen = r16(SCENARIO) or 17
    return draw(r16(DEFENDING), units_from(r8, r16), rect=rect, scenario=scen, **kw)


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("dump")
    ap.add_argument("--out", required=True)
    ap.add_argument("--strip", action="store_true")
    ap.add_argument("--scale", type=int, default=3)
    ap.add_argument("--title", default=None)
    a = ap.parse_args()
    render_dump(a.dump, out=a.out, strip=a.strip, scale=a.scale, title=a.title)
