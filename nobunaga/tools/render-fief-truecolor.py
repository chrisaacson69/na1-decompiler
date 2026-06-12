#!/usr/bin/env python3
"""True full-color tactical fief map, rendered from the DECODED ROM path (no capture).

Unlike render-from-sram.py (which pseudo-colors the 6 terrain types as flat letters),
this assembles the REAL pixels the game would draw, straight from ROM:

  nametable : $7BFD, produced by running map_populate ($8903) headless
              (reuse render-rom-to-map.populate_from_rom -- byte-verified vs SaveRam)
  CHR       : the combat tile graphics the game uploads in render_combat_map_screen:
                base   = bank 4 $9F6E, 97 tiles  -> PT1 slot 0x57  (the terrain tiles)
                per-fief = bank 5 $9C25+map_id*49, 3 tiles/side -> PT1 slot 0x51/0x54
  palette   : combat_map_palette ($B55A, bank 2), 16 bytes (4 sub-palettes)
  layout    : 11x5 cells, each a 4x4 metatile (32x32 px), odd columns staggered down
              half a cell (map_populate's `if (x&1) local7 += 2`).

Usage:  py render-fief-truecolor.py <province> [--scenario 17|50] [--sub 0..3]
                                    [--label "..."] [--out name.png]
"""
import sys, importlib.util
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from PIL import Image

# reuse the verified populate + the NES master palette
_rrm = importlib.util.spec_from_file_location("render_rom_to_map", HERE / "render-rom-to-map.py")
rrm = importlib.util.module_from_spec(_rrm); _rrm.loader.exec_module(rrm)
_rfp = importlib.util.spec_from_file_location("render_fief_from_ppu", HERE / "render-fief-from-ppu.py")
rfp = importlib.util.module_from_spec(_rfp); _rfp.loader.exec_module(rfp)
NES = rfp.NES_MASTER

ROM = (HERE / "Nobunaga's Ambition (USA).nes").read_bytes()

def prg(bank, addr):          # CPU addr -> .nes file offset (MMC1: $C000+ = fixed bank 15)
    if addr >= 0xC000:
        return 0x10 + 15 * 0x4000 + (addr - 0xC000)
    return 0x10 + bank * 0x4000 + (addr - 0x8000)

def tile_pixels(chr16):       # 16-byte 2bpp NES tile -> 8x8 of 0..3
    out = [[0]*8 for _ in range(8)]
    for y in range(8):
        lo, hi = chr16[y], chr16[y+8]
        for x in range(8):
            b = 7-x
            out[y][x] = ((lo>>b)&1) | (((hi>>b)&1)<<1)
    return out

def build_pattern_table(map_id):
    """256 tiles (each 8x8 of 0..3 values), filled exactly as render_combat_map_screen uploads."""
    pt = [[[0]*8 for _ in range(8)] for _ in range(256)]
    base = prg(4, 0x9F6E)
    for i in range(97):
        pt[0x57+i] = tile_pixels(ROM[base+i*16: base+i*16+16])
    fief = prg(5, 0x9C25 + map_id*49)
    for side in range(2):
        for i in range(3):                     # 3 tiles/side at PT slot 0x51 (side0) / 0x54 (side1)
            slot = 0x51 + side*3 + i
            off  = fief + i*16
            pt[slot] = tile_pixels(ROM[off: off+16])
    return pt

def combat_palette():
    p = prg(2, 0xB55A)
    return list(ROM[p: p+16])

MAPID = None
def map_id_for(province, scenario):
    # province_to_mapid_table $F70E (bank 15)
    base = prg(15, 0xF70E) + (0 if scenario == 17 else 50)
    return ROM[base + province]

def render(province, scenario=17, sub=None, label=None, out=None, out_path=None):
    sram = rrm.populate_from_rom(province, scenario)[0]        # (sram, ok, todo) -> full $6000-$7FFF
    nt   = sram[0x1BFD:]                                       # $7BFD onward (11 cols x 88)
    mid  = map_id_for(province, scenario)
    pt   = build_pattern_table(mid)
    pal16 = combat_palette()
    subs = [sub] if sub is not None else [0,1,2,3]            # render each sub-palette for comparison

    CELL = 32  # 4x4 tiles * 8px
    cols, rows = 11, 5
    panels = []
    for sp in subs:
        palette = pal16[sp*4: sp*4+4]
        bg = pal16[0]
        W = cols*CELL
        H = rows*CELL + CELL//2                  # extra half-cell for the stagger
        img = Image.new("RGB", (W, H), NES[bg & 0x3F])
        for col in range(cols):
            col_base = col*88
            stagger  = 8 if (col & 1) else 0      # byte stagger in $7BFD
            ypx_off  = (CELL//2) if (col & 1) else 0
            for row in range(rows):
                cell = nt[col_base + stagger + row*16: col_base + stagger + row*16 + 16]
                if len(cell) < 16: continue
                for ty in range(4):
                    for tx in range(4):
                        idx = cell[ty*4+tx]
                        tp  = pt[idx]
                        ox = col*CELL + tx*8
                        oy = row*CELL + ypx_off + ty*8
                        for py in range(8):
                            for px in range(8):
                                v = tp[py][px]
                                nesc = bg if v == 0 else palette[v]
                                img.putpixel((ox+px, oy+py), NES[nesc & 0x3F])
        panels.append((sp, img.resize((W*3, H*3), Image.NEAREST)))

    if len(panels) == 1:
        final = panels[0][1]
    else:                                          # stack the 4 sub-palette guesses to pick the right one
        pw, ph = panels[0][1].size
        final = Image.new("RGB", (pw, ph*4 + 4*3), (20,20,20))
        for i,(sp,im) in enumerate(panels):
            final.paste(im, (0, i*(ph+4)))
    if out_path is not None:
        Path(out_path).parent.mkdir(parents=True, exist_ok=True)
        final.save(out_path)
        print(f"province {province} (map_id {mid}) -> {out_path}")
    else:
        name = out or f"fief-{province}-truecolor.png"
        dst = (HERE.parent / "assets" / "maps" / "fiefs") if (HERE.parent/"assets"/"maps"/"fiefs").exists() else HERE
        final.save(dst / name)
        print(f"province {province} (map_id {mid}) palette {' '.join(f'{b:02X}' for b in pal16)} -> {name}")
    return final

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("province", type=int)
    ap.add_argument("--scenario", type=int, default=17)
    ap.add_argument("--sub", type=int, default=None)
    ap.add_argument("--label", default=None)
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    render(a.province, a.scenario, a.sub, a.label, a.out)
