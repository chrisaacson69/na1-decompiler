#!/usr/bin/env python3
"""Render the illustrated NES STRATEGIC MAP (the Map command's pannable overview)
straight from ROM bytes — no PPU/emulation needed.

This is the *art* map (terrain tiles drawn by the cartridge), NOT the schematic
adjacency graphs that render-strategic-atlas.py / render-strategic-50.py draw,
and NOT the tactical battle grid that render-rom-to-map.py builds.

How it works (decoded 2026-06-02, see ROADMAP "PULL THE REAL STRATEGIC MAP"):
  - The Map command (driver_map $AF38) calls ui_helper_cd20 to set palette + upload
    the map CHR, then map_helper_e5f2(section) blits one 28x16 tilemap SECTION to
    the nametable. There are 9 sections (a pannable map); arrows switch sections.
  - Tilemap : bank 4 $8D5C, 0x1C0 (=448=28x16) bytes/section x 9 sections.
  - Attrs   : bank 4 $9D1C, 0x20 (=32) bytes/section (BG sub-palette per 16x16 quad).
  - CHR     : bank 4, the map tileset uploaded to PT1 $15B0 (= tile $5B = 91), so a
              tilemap cell value V indexes CHR-RAM[$1000 + V*16], and the uploaded
              block starts at bank4 $845C for tile 91 -> CHR addr = $845C + (V-91)*16.
  - Palette : bank 15 $F67A (4 colors/sub-palette, stored as words w/ 0 high byte).
              Map BG palette 0 ~ [$3E,$12,$29,$30] = backdrop / sea / land / coast.

Tiles 8-17 are the game font's digits (0-9) overlaid as fief-number labels — drawn
on a different CHR region; here they render from the same contiguous block (close
enough for the terrain read) unless --font is added later.

Usage:
  py render-strategic-map.py                 # contact sheet of all 9 sections (3x3)
  py render-strategic-map.py --section N      # one section, big
  py render-strategic-map.py --scale 3 --out assets/maps/strategic/strategic-map.png
"""
import sys, importlib.util
from pathlib import Path
HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from na1dream.nobunaga_vm import NobunagaVM
from PIL import Image, ImageDraw

# render-text.py (hyphenated) holds the game-font glyph decoder. Font tiles 0..80
# live in PT1 alongside the map terrain (tiles 91..234), so a tilemap cell value
# <= 80 is a FONT glyph (fief-number digits, region labels) and >= 81 is terrain.
_spec = importlib.util.spec_from_file_location("render_text", HERE / "render-text.py")
_rt = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_rt)
FONT_MAX_TILE = 80

# Full NES master palette (same table as run-animation.py).
NES_PALETTE = [
    (124,124,124),(0,0,252),(0,0,188),(68,40,188),(148,0,132),(168,0,32),(168,16,0),(136,20,0),
    (80,48,0),(0,120,0),(0,104,0),(0,88,0),(0,64,88),(0,0,0),(0,0,0),(0,0,0),
    (188,188,188),(0,120,248),(0,88,248),(104,68,252),(216,0,204),(228,0,88),(248,56,0),(228,92,16),
    (172,124,0),(0,184,0),(0,168,0),(0,168,68),(0,136,136),(0,0,0),(0,0,0),(0,0,0),
    (248,248,248),(60,188,252),(104,136,252),(152,120,248),(248,120,248),(248,88,152),(248,120,88),(252,160,68),
    (248,184,0),(184,248,24),(88,216,84),(88,248,152),(0,232,216),(120,120,120),(0,0,0),(0,0,0),
    (252,252,252),(164,228,252),(184,184,248),(216,184,248),(248,184,248),(248,164,192),(240,208,176),(252,224,168),
    (248,216,120),(216,248,120),(152,248,176),(176,248,204),(156,252,240),(248,212,252),(0,0,0),(0,0,0),
]

BANK_MAP = 4
TILEMAP = 0x8D5C       # 0x1C0 bytes/section
ATTR    = 0x9D1C       # 0x20 bytes/section
RECORDS = 0x9E3C       # 34 bytes/section: (col, row, fief_id) triples, 0xFF-terminated
CHR_BASE = 0x845C      # bank4 byte addr that uploads to PT1 tile 91 ($15B0)
CHR_TILE0 = 91         # tile index that CHR_BASE corresponds to
SEC_W, SEC_H = 28, 16  # tiles
N_SEC = 9
PAL_TABLE = 0xF67A     # bank 15 (fixed)


# The strategic map's 4 BG sub-palettes, captured from a live PPU dump taken on the
# Map screen (traces/17fiefmapAPPU.dmp, $3F00-$3F1F). These are AUTHORITATIVE.
#
# Why not read them from ROM: repaint_screen ($CD20) only loads sub-palette 0 from
# strategic_map_bg_palette ($F67A); sub-palettes 1-3 are inherited ambient PPU state set
# by earlier screens, so there is no ROM table for them. (The old loader read the 8 bytes
# at $F682 = the TITLE-SCREEN palette [$3E,$16,$38,$30], stored just before the
# "Control"/"(Y/N)" strings, as sub-pal 1 and copied it into 2/3 -- the bogus RED.)
# The palette is scenario-independent (same Map display code), so this covers 17 and 50.
MAP_BG_PALETTE = [
    [0x3E, 0x12, 0x29, 0x30],   # sub-pal0: backdrop / sea / land / white
    [0x3E, 0x02, 0x12, 0x21],   # sub-pal1: deep-sea depth gradient
    [0x3E, 0x18, 0x29, 0x30],   # sub-pal2: gold-brown earth / green / white (dominant land)
    [0x3E, 0x18, 0x01, 0x30],   # sub-pal3: gold-brown / dark-blue / white (mountain/coast)
]


def load_palettes(vm):
    """The strategic map's 4 BG sub-palettes (authoritative; see MAP_BG_PALETTE). `vm`
    is accepted for signature compatibility but unused -- the palette is a PPU capture,
    not a ROM read."""
    return [[NES_PALETTE[c] for c in s] for s in MAP_BG_PALETTE]


def decode_tile(vm, tile_idx, rom):
    """Return 8x8 list of palette-index (0-3) for a tilemap cell value.
    Cells <= 80 are game-font glyphs (PT1 tiles uploaded from bank0 $B2BA);
    cells >= 81 are map terrain (bank4 block, tile 91 -> $845C)."""
    if tile_idx <= FONT_MAX_TILE:
        # font glyph: 1bpp ink mask -> draw ink as palette color 3, else color 0
        bmp = _rt._tile_bitmap(rom, tile_idx)
        return [[3 if bmp[y][x] else 0 for x in range(8)] for y in range(8)]
    addr = CHR_BASE + (tile_idx - CHR_TILE0) * 16
    rows = []
    for y in range(8):
        p0 = vm.read_banked(BANK_MAP, addr + y)
        p1 = vm.read_banked(BANK_MAP, addr + y + 8)
        row = [((p0 >> (7 - x)) & 1) | (((p1 >> (7 - x)) & 1) << 1) for x in range(8)]
        rows.append(row)
    return rows


def attr_palette(attr_bytes, tx, ty):
    """Which BG sub-palette (0-3) applies at section-local tile (tx,ty). NES attribute
    layout: 1 byte per 32x32px (4x4 tile) area; 2 bits per 16x16 (2x2 tile) quadrant.

    The section is blitted to screen cols 2-29, rows 4-19, and its 32-byte attribute table
    is uploaded to PPU $23C8 (the attribute byte for screen rows 4-7). Rows land on a 4-tile
    attribute-cell boundary (row 4), so ty maps straight through -- but COLUMNS start at
    screen col 2, which is MID-cell. So we must decode at screen col (tx+2); using the raw
    section-local tx puts every other quad-column in the wrong cell, swapping sub-palettes
    on adjacent quads (lakes/mountains flip colour). The table is 8 bytes/row (32 tiles)."""
    sx = tx + 2                                   # section col 0 -> screen col 2
    cell_x, cell_y = sx // 4, ty // 4
    idx = cell_y * 8 + cell_x
    if idx >= len(attr_bytes):
        return 0
    b = attr_bytes[idx]
    quad = ((ty % 4) // 2) * 2 + ((sx % 4) // 2)  # 0 TL,1 TR,2 BL,3 BR
    return (b >> (quad * 2)) & 3


def render_section(vm, sec, pals, scale=2, rom=None):
    rom = rom if rom is not None else _rt._rom()
    tm = [vm.read_banked(BANK_MAP, TILEMAP + sec * 0x1C0 + i) for i in range(0x1C0)]
    at = [vm.read_banked(BANK_MAP, ATTR + sec * 0x20 + i) for i in range(0x20)]
    img = Image.new("RGB", (SEC_W * 8, SEC_H * 8), (0, 0, 0))
    px = img.load()
    for ty in range(SEC_H):
        for tx in range(SEC_W):
            v = tm[ty * SEC_W + tx]
            pal = pals[attr_palette(at, tx, ty)]
            tile = decode_tile(vm, v, rom)
            for yy in range(8):
                for xx in range(8):
                    px[tx * 8 + xx, ty * 8 + yy] = pal[tile[yy][xx]]
    if scale != 1:
        img = img.resize((img.width * scale, img.height * scale), Image.NEAREST)
    return img


def _tilemap(vm, sec):
    return [vm.read_banked(BANK_MAP, TILEMAP + sec * 0x1C0 + i) for i in range(0x1C0)]


def best_offset(A, B):
    """Best (dx, dy, score): placing section B at (dx,dy) relative to A, matching
    on terrain tiles (>=81) only (labels/sea move/repeat and add noise)."""
    def cell(S, x, y): return S[y * SEC_W + x]
    best = (0.0, 0, 0, 0)
    for dy in range(-12, 13):
        for dx in range(-(SEC_W - 1), SEC_W):
            n = t = 0
            for y in range(SEC_H):
                for x in range(SEC_W):
                    x1, y1 = x - dx, y - dy
                    if 0 <= x1 < SEC_W and 0 <= y1 < SEC_H:
                        a, b = cell(A, x, y), cell(B, x1, y1)
                        if a >= 81 and b >= 81:
                            t += 1
                            n += (a == b)
            if t >= 60 and n / t > best[0]:
                best = (n / t, t, dx, dy)
    return best


def auto_layout(vm, sections, seed=0, thresh=0.5):
    """Greedy spanning tree: place `seed` at (0,0), attach each remaining section at
    the absolute offset that best aligns it to an already-placed section. Returns
    {section: (ax, ay)} in tile coords (may be negative; caller normalizes)."""
    maps = {s: _tilemap(vm, s) for s in sections}
    placed = {seed: (0, 0)}
    remaining = [s for s in sections if s != seed]
    while remaining:
        best = None  # (score, sec, ax, ay)
        for s in remaining:
            for p, (px_, py_) in placed.items():
                sc, t, dx, dy = best_offset(maps[p], maps[s])
                if sc >= thresh and (best is None or sc > best[0]):
                    best = (sc, s, px_ + dx, py_ + dy)
        if best is None:
            print(f"  (no section aligns above {thresh}; leaving {remaining} unplaced)")
            break
        sc, s, ax, ay = best
        placed[s] = (ax, ay)
        remaining.remove(s)
        print(f"  placed sec {s} at ({ax},{ay})  score={sc:.2f}")
    return placed


def render_stitch(vm, pals, sections, scale=2, seed=0):
    rom = _rt._rom()
    placed = auto_layout(vm, sections, seed=seed)
    minx = min(x for x, y in placed.values())
    miny = min(y for x, y in placed.values())
    maxx = max(x + SEC_W for x, y in placed.values())
    maxy = max(y + SEC_H for x, y in placed.values())
    W = (maxx - minx) * 8
    H = (maxy - miny) * 8
    canvas = Image.new("RGB", (W, H), (0, 0, 0))
    # paste sections; later (higher section #) on top so labels stay legible
    for s in sorted(placed, reverse=True):
        ax, ay = placed[s]
        img = render_section(vm, s, pals, 1, rom)
        canvas.paste(img, ((ax - minx) * 8, (ay - miny) * 8))
    if scale != 1:
        canvas = canvas.resize((canvas.width * scale, canvas.height * scale), Image.NEAREST)
    return canvas


def contact_sheet(vm, pals, sections, cols, scale=2):
    rom = _rt._rom()
    cells = [render_section(vm, s, pals, scale, rom) for s in sections]
    cw, ch = cells[0].size
    pad = 8
    rows = (len(cells) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * cw + (cols + 1) * pad, rows * ch + (rows + 1) * pad), (40, 40, 40))
    d = ImageDraw.Draw(sheet)
    for i, c in enumerate(cells):
        r, col = divmod(i, cols)
        x, y = pad + col * (cw + pad), pad + r * (ch + pad)
        sheet.paste(c, (x, y))
        d.text((x + 2, y + 2), f"sec {sections[i]}", fill=(255, 255, 0))
    return sheet


# ---------------------------------------------------------------------------
# FAITHFUL stitch: align sections by their per-section fief RECORD LIST ($9E3C),
# merge onto an unbounded virtual tilemap (first-writer-wins dedups boundary
# labels), then nearest-neighbour-fill the notch corners with adjacent terrain.
# ---------------------------------------------------------------------------
def read_records(vm, sec):
    """{fief_id: (tx, ty)} in tilemap coords, from the section's record list.
    Records are screen-space (col 0-27, row 4-19); ty = row-4."""
    base = RECORDS + sec * 34
    recs = {}
    for i in range(11):
        c = vm.read_banked(BANK_MAP, base + i * 3)
        if c == 0xFF:
            break
        r = vm.read_banked(BANK_MAP, base + i * 3 + 1)
        fid = vm.read_banked(BANK_MAP, base + i * 3 + 2)
        recs[fid] = (c, r - 4)
    return recs


def _section_tiles(vm, sec):
    tm = [vm.read_banked(BANK_MAP, TILEMAP + sec * 0x1C0 + i) for i in range(0x1C0)]
    at = [vm.read_banked(BANK_MAP, ATTR + sec * 0x20 + i) for i in range(0x20)]
    return tm, at


def _record_offset(ra, rb):
    """Placement of section b relative to a (tilemap-cell delta), from the median
    of (pos_a - pos_b) over fiefs both record lists share. None if no shared fief."""
    shared = set(ra) & set(rb)
    if not shared:
        return None
    dxs = sorted(ra[f][0] - rb[f][0] for f in shared)
    dys = sorted(ra[f][1] - rb[f][1] for f in shared)
    m = len(shared) // 2
    return dxs[m], dys[m]


def faithful_layout(vm, sections, seed=0):
    """{section: (ax, ay)} by chaining record offsets from the seed (spanning tree)."""
    recs = {s: read_records(vm, s) for s in sections}
    placed = {seed: (0, 0)}
    remaining = [s for s in sections if s != seed]
    progress = True
    while remaining and progress:
        progress = False
        for s in list(remaining):
            for p, (px_, py_) in placed.items():
                off = _record_offset(recs[p], recs[s])
                if off is not None:
                    placed[s] = (px_ + off[0], py_ + off[1])
                    remaining.remove(s)
                    progress = True
                    print(f"  placed sec {s} at {placed[s]} (record-aligned to {p})")
                    break
    if remaining:
        print(f"  (no shared-fief link for sections {remaining}; left unplaced)")
    return placed


def _interp_by_row(anchors, n=SEC_H):
    """anchors {section_row: dx} -> list[n] of int dx, linearly interpolated + clamped.
    Models the vertical shear between two pannable map pages (x-offset varies by row)."""
    pts = sorted(anchors.items())
    out = []
    for ty in range(n):
        if ty <= pts[0][0]:
            out.append(pts[0][1])
        elif ty >= pts[-1][0]:
            out.append(pts[-1][1])
        else:
            for (r0, d0), (r1, d1) in zip(pts, pts[1:]):
                if r0 <= ty <= r1:
                    out.append(round(d0 + (d1 - d0) * (ty - r0) / (r1 - r0)))
                    break
    return out


def _pair_shear(ra, rb):
    """Align section b onto section a from shared-fief records (tilemap coords).
    Returns (dy:int, dx_by_row:list[SEC_H]) -- a constant row shift + a per-row x shift."""
    shared = set(ra) & set(rb)
    dys = sorted(ra[f][1] - rb[f][1] for f in shared)
    dy = dys[len(dys) // 2]
    anchors = {rb[f][1]: ra[f][0] - rb[f][0] for f in shared}   # b's row -> x offset
    return dy, _interp_by_row(anchors)


def faithful_layout_sheared(vm, sections, seed=0, shear=False):
    """{section: (dy, dx_by_row)} via a spanning tree from the seed.

    With shear=False (CANONICAL) each section gets a CONSTANT x-offset = its mid-row
    alignment (for 17-fief that is -16, the version we settled on); the per-row shear it
    interpolates is kept but collapsed. With shear=True it keeps the full per-row x shift
    (experimental: removes the seam squish but adds artifacts elsewhere -- parked).
    Chained links (the 50-fief case) compose with the parent's mid dx -- a proper global
    least-squares solve is the planned 50-fief fix."""
    recs = {s: read_records(vm, s) for s in sections}
    placed = {seed: (0, [0] * SEC_H)}
    remaining = [s for s in sections if s != seed]
    progress = True
    while remaining and progress:
        progress = False
        for s in list(remaining):
            for p, (pdy, pdx) in placed.items():
                if set(recs[p]) & set(recs[s]):
                    dy, dxby = _pair_shear(recs[p], recs[s])
                    base = pdx[SEC_H // 2]                  # parent mid-row dx (0 for seed)
                    row_dx = [base + d for d in dxby]
                    if not shear:
                        row_dx = [row_dx[SEC_H // 2]] * SEC_H   # collapse to a constant
                    placed[s] = (pdy + dy, row_dx)
                    remaining.remove(s)
                    progress = True
                    print(f"  placed sec {s}: dy={pdy + dy}, dx {row_dx[0]}..{row_dx[-1]} "
                          f"({'shear' if shear else 'constant'} to {p})")
                    break
    if remaining:
        print(f"  (no shared-fief link for {remaining}; unplaced)")
    return placed


def _gauss(A, b):
    """Solve A x = b for a small dense system (Gaussian elimination, partial pivot)."""
    n = len(b)
    M = [row[:] + [b[i]] for i, row in enumerate(A)]
    for col in range(n):
        piv = max(range(col, n), key=lambda r: abs(M[r][col]))
        M[col], M[piv] = M[piv], M[col]
        d = M[col][col] or 1e-9
        for r in range(n):
            if r != col:
                f = M[r][col] / d
                for k in range(col, n + 1):
                    M[r][k] -= f * M[col][k]
    return [M[i][n + 1 - 1] / (M[i][i] or 1e-9) for i in range(n)]


def faithful_layout_global(vm, sections, seed=0):
    """GLOBAL least-squares section placement. Each shared fief between two sections
    contributes a constraint (A_a - A_b = pos_b - pos_a) per axis; we solve all section
    offsets simultaneously (graph-Laplacian normal equations, gauge-fixed at the seed)
    so the residual shear error is DISTRIBUTED across the map rather than CHAINED from a
    seed (which compounds across the 50-fief map's 9 sections). Returns {s: (dy, [dx]*H)}
    -- a constant offset per section, the format render_faithful_stitch consumes."""
    recs = {s: read_records(vm, s) for s in sections}
    idx = {s: i for i, s in enumerate(sections)}
    n = len(sections)

    def solve(axis):                                   # axis 0 = x (col), 1 = y (row)
        L = [[0.0] * n for _ in range(n)]
        c = [0.0] * n
        for a in sections:
            for b in sections:
                if a >= b:
                    continue
                for f in set(recs[a]) & set(recs[b]):
                    d = recs[b][f][axis] - recs[a][f][axis]   # A_a - A_b = d
                    ia, ib = idx[a], idx[b]
                    L[ia][ia] += 1; L[ib][ib] += 1
                    L[ia][ib] -= 1; L[ib][ia] -= 1
                    c[ia] += d; c[ib] -= d
        si = idx[seed]                                 # gauge: pin seed at 0
        L[si] = [1.0 if j == si else 0.0 for j in range(n)]
        c[si] = 0.0
        return _gauss(L, c)

    xs, ys = solve(0), solve(1)
    placed = {}
    for s in sections:
        ax, ay = round(xs[idx[s]]), round(ys[idx[s]])
        placed[s] = (ay, [ax] * SEC_H)
        print(f"  sec {s}: ({ax},{ay})  [global LS]")
    return placed


def _nn_fill(grid, x0, y0, x1, y1):
    """Fill any cell in the bbox missing from grid with its nearest set neighbour."""
    import collections
    missing = [(x, y) for y in range(y0, y1) for x in range(x0, x1) if (x, y) not in grid]
    for (x, y) in missing:
        for radius in range(1, max(x1 - x0, y1 - y0)):
            found = None
            for dy in range(-radius, radius + 1):
                for dx in range(-radius, radius + 1):
                    if (x + dx, y + dy) in grid:
                        found = grid[(x + dx, y + dy)]
                        break
                if found:
                    break
            if found:
                grid[(x, y)] = found
                break


def _draw_label(px, W, H, lx, ly, text):
    """Draw `text` as white font glyphs on a 1px black box, top-left at native px (lx,ly)."""
    bw, bh = len(text) * 8 + 2, 10
    for yy in range(-1, bh - 1):
        for xx in range(-1, bw - 1):
            x, y = lx + xx, ly + yy
            if 0 <= x < W and 0 <= y < H:
                px[x, y] = (0, 0, 0)                 # box backdrop
    for i, ch in enumerate(text):
        tile = _rt.char_to_tile(ch)
        if tile is None:
            continue
        bmp = _rt._tile_bitmap(_rt._rom(), tile)
        for yy in range(8):
            for xx in range(8):
                if bmp[yy][xx]:
                    x, y = lx + i * 8 + xx, ly + yy
                    if 0 <= x < W and 0 <= y < H:
                        px[x, y] = (255, 255, 255)


def render_faithful_stitch(vm, pals, sections, scale=2, seed=0, placed=None, shear=False):
    """Record-aligned virtual-tilemap stitch:
      - place sections by their fief-record offsets onto an unbounded canvas;
      - keep TERRAIN tiles only (skip baked font/number tiles, v<=80) so boundary
        fiefs don't double; lower section number wins on overlap;
      - nearest-neighbour fill the notch corners + the stripped label cells;
      - redraw each fief's number ONCE from the record list, at its true position.

    `placed` overrides the layout with explicit {section: (dy, dx_by_row)}.
    Returns (img, fief_px) where fief_px = {fief_id: (cx, cy)} is each fief number's
    centre in OUTPUT (scaled) pixels -- the anchor for clickable hotspots."""
    rom = _rt._rom()
    if placed is None:
        placed = (faithful_layout_sheared(vm, sections, seed=seed, shear=True) if shear
                  else faithful_layout_global(vm, sections, seed=seed))
    recs = {s: read_records(vm, s) for s in placed}
    grid = {}  # (vx, vy) -> (tile_value, sub_palette); terrain only
    for s in sorted(placed):                         # section order = overlap priority
        dy, dxby = placed[s]
        tm, at = _section_tiles(vm, s)
        for ty in range(SEC_H):
            dx = dxby[ty]                            # per-row x shift (the page shear)
            for tx in range(SEC_W):
                v = tm[ty * SEC_W + tx]
                if v <= FONT_MAX_TILE:               # baked number -> leave a hole
                    continue
                key = (tx + dx, ty + dy)
                if key not in grid:                  # first writer wins
                    grid[key] = (v, attr_palette(at, tx, ty))
    xs = [x for x, y in grid]; ys = [y for x, y in grid]
    x0, x1, y0, y1 = min(xs), max(xs) + 1, min(ys), max(ys) + 1
    _nn_fill(grid, x0, y0, x1, y1)                    # notch/shear gaps + stripped labels
    W, H = (x1 - x0) * 8, (y1 - y0) * 8
    img = Image.new("RGB", (W, H), (0, 0, 0))
    px = img.load()
    for (vx, vy), (v, p) in grid.items():
        tile = decode_tile(vm, v, rom)
        ox, oy = (vx - x0) * 8, (vy - y0) * 8
        for yy in range(8):
            for xx in range(8):
                px[ox + xx, oy + yy] = pals[p][tile[yy][xx]]
    # one number per fief, at its record position (priority = lowest placed section)
    fief_pos = {}
    for s in sorted(placed):
        dy, dxby = placed[s]
        for fid, (tx, ty) in recs[s].items():
            fief_pos.setdefault(fid, (tx + dxby[ty], ty + dy))
    fief_px = {}
    for fid, (vx, vy) in fief_pos.items():
        text = str(fid + 1)
        lx = min(max(0, (vx - x0) * 8), W - (len(text) * 8 + 2))
        ly = min(max(1, (vy - y0) * 8), H - 10)      # keep the box on-canvas
        _draw_label(px, W, H, lx, ly, text)
        # 1-based fief number -> centre of the label box, in output (scaled) pixels
        fief_px[fid + 1] = ((lx + len(text) * 4) * scale, (ly + 4) * scale)
    if scale != 1:
        img = img.resize((W * scale, H * scale), Image.NEAREST)
    return img, fief_px


def main():
    args = sys.argv[1:]
    scale = int(args[args.index("--scale") + 1]) if "--scale" in args else 2
    out = args[args.index("--out") + 1] if "--out" in args else None
    vm = NobunagaVM()
    pals = load_palettes(vm)
    print("BG sub-palettes (NES idx):",
          [[hex(vm.read_banked(15, PAL_TABLE + i * 2) & 0x3F) for i in range(j*4, j*4+4)] for j in range(2)])
    # 17-fief scenario shows sections 0-1 (verified: $FED8 province->section is all
    # 0/1, and the daimyo-select cycle wraps at 4 -> sections {0,1}); 50-fief uses
    # all 9 (cycle wraps at 9). The Map command flips between these as discrete
    # pages (map_helper_af10 prints "Arrows: other sections / A: menu") -- they are
    # NOT a single scrolling map (edge-match + scroll-overlap both ~0.1).
    scenario = int(args[args.index("--scenario") + 1]) if "--scenario" in args else 50
    sections = [0, 1] if scenario == 17 else list(range(N_SEC))
    fief_px = None
    if "--section" in args:
        sec = int(args[args.index("--section") + 1])
        img = render_section(vm, sec, pals, scale)
        out = out or f"assets/maps/strategic/strategic-section-{sec}.png"
    elif "--faithful" in args:
        shear = "--shear" in args                       # default: constant offset (canonical)
        print(f"Record-aligned faithful stitch, scenario-{scenario} sections {sections} "
              f"({'shear' if shear else 'constant'})...")
        img, fief_px = render_faithful_stitch(vm, pals, sections, scale=scale, shear=shear)
        out = out or f"assets/maps/strategic/strategic-map-{scenario}-stitched.png"
    elif "--stitch" in args:
        print(f"Auto-stitching scenario-{scenario} sections {sections}...")
        img = render_stitch(vm, pals, sections, scale=scale)
        out = out or f"assets/maps/strategic/strategic-map-{scenario}-stitched.png"
    else:
        img = contact_sheet(vm, pals, sections, cols=(2 if scenario == 17 else 3), scale=scale)
        out = out or f"assets/maps/strategic/strategic-map-{scenario}.png"
    Path(out).parent.mkdir(parents=True, exist_ok=True)
    img.save(out)
    print(f"wrote {out}  ({img.width}x{img.height})")
    if fief_px is not None:                             # coords manifest for clickable hotspots
        import json
        coords = {"image": Path(out).name, "size": [img.width, img.height],
                  "fiefs": {str(k): list(v) for k, v in sorted(fief_px.items())}}
        cpath = Path(out).with_suffix(".coords.json")
        cpath.write_text(json.dumps(coords, indent=1), encoding="utf-8")
        print(f"wrote {cpath.name}  ({len(fief_px)} fief hotspots)")


if __name__ == "__main__":
    main()
