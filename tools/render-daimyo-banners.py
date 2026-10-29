#!/usr/bin/env python3
"""Daimyo banner (crest / 家紋) chart, decoded from ROM.

Each daimyo's battlefield banner is a 3-tile CHR block at bank 5 $9C25 + idx*49
(idx = the daimyo's home-fief map-id), with its own palette from the attribute
byte at $9C24 + idx*49. The game uploads it per side in render_combat_map_screen
(upload_map_cell_tiles) and draws it next to the O/X leader marker.

Renders one labeled chart per scenario (17 + 50) so we can compare whether the
banners differ between scenarios.

Usage:  py render-daimyo-banners.py
"""
import importlib.util
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

HERE = Path(__file__).parent
_s = importlib.util.spec_from_file_location("rftc", HERE / "render-fief-truecolor.py")
rftc = importlib.util.module_from_spec(_s); _s.loader.exec_module(rftc)
ROM, NES, prg, tile_pixels = rftc.ROM, rftc.NES, rftc.prg, rftc.tile_pixels

PAL = rftc.combat_palette()

FIEF17 = ["Noto","Echigo","Musashi","Kaga","Echizen","Hida","Suruga","Mikawa","Mino",
          "Yamato","Omi","Iga","Iseshima","Yamashir","Settsu","Shinano","Owari"]
FIEF50 = ["Ezo","Mutsu","Morioka","Iwasaki","Ugo","Rikuzen","Uzen","Iwaki","Iwashiro",
          "Echigo","Hitachi","Shimotsu","Awa(E)","Musashi","Shinano","Noto","Ecchu","Hida",
          "Kiso","Suruga","Kaga","Echizen","Mino","Mikawa","Owari","Iseshima","Omi","Iga",
          "Tango","Tanba","Yamashir","Yamato","Settsu","Kii","Inaba","Harima","Izumo","Sanbi",
          "Aki","Sanuki","Awa(S)","Iyo","Tosa","Nakamura","Buzen","Chikuhi","Bungo","Higo",
          "Hiyuga","Satuma"]

def banner_index(daimyo, scenario):
    """The banner source index, mirroring fief_to_mapid($DC66):
    50-fief -> daimyo index directly; 17-fief -> province_to_mapid_table[daimyo]."""
    if scenario == 50:
        return daimyo
    return ROM[prg(15, 0xF70E) + daimyo]

def banner_img(idx, scale=6):
    """3-tile banner for source index idx, in its own attribute-byte palette."""
    attr = ROM[prg(5, 0x9C24) + idx*49]
    sub = attr & 3
    pal = PAL[sub*4: sub*4+4]; bg = PAL[0]
    chr_base = prg(5, 0x9C25) + idx*49
    im = Image.new("RGB", (24, 8), NES[bg & 0x3F])
    for t in range(3):
        tp = tile_pixels(ROM[chr_base + t*16: chr_base + t*16 + 16])
        for y in range(8):
            for x in range(8):
                v = tp[y][x]
                im.putpixel((t*8 + x, y), NES[(bg if v == 0 else pal[v]) & 0x3F])
    return im.resize((24*scale, 8*scale), Image.NEAREST)

def chart(scenario, names):
    n = len(names)
    cols = 3 if scenario == 17 else 5
    rows = (n + cols - 1) // cols
    CW, CH = 230, 70
    img = Image.new("RGB", (cols*CW, rows*CH + 30), (24, 24, 28))
    d = ImageDraw.Draw(img)
    try: font = ImageFont.truetype("arial.ttf", 14); tfont = ImageFont.truetype("arial.ttf", 18)
    except Exception: font = tfont = ImageFont.load_default()
    d.text((8, 6), f"Nobunaga's Ambition — daimyo banners ({scenario}-fief scenario)",
           fill=(255,255,255), font=tfont)
    for i, name in enumerate(names):
        cx = (i % cols) * CW + 10
        cy = (i // cols) * CH + 34
        idx = banner_index(i, scenario)
        img.paste(banner_img(idx, 5), (cx, cy + 14))
        d.text((cx, cy), f"{i:2d} {name}  (idx {idx})", fill=(220,220,230), font=font)
    out = HERE.parent / "assets" / "maps" / "fiefs" / f"daimyo-banners-{scenario}.png"
    out.parent.mkdir(parents=True, exist_ok=True)
    img.save(out)
    print(f"{scenario}-fief: {n} banners -> {out.name}")
    return [banner_index(i, scenario) for i in range(n)]

if __name__ == "__main__":
    m17 = chart(17, FIEF17)
    m50 = chart(50, FIEF50)
