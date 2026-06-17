"""pages.py — render one HTML page per fief and per daimyo (both scenarios).

The template mirrors the in-game fief/daimyo status screen (see assets/Saves/playerturn.png),
which mixes both on one screen; we split it into two pages along the game's own colour logic:

    DAIMYO  — green (#45e082): clan name + the personal stats (Age/Hlth/Driv/Luck/Char/IQ).
              Adds the portrait, the combat banner, and a link to the starting fief.
              ('Sick'/status is intentionally omitted.)
    FIEF    — white title (#fffeff), PURPLE stat labels (#c676ff) + WHITE values: the
              province stats (Gold..Arms) exactly as the game lists them, the 1-based fief
              number, a link to the starting daimyo, and the battle map.

Colours, labels, and order are taken straight from the screenshot. The font is the game's
own CHR font shipped as a @font-face (assets/fonts/nobunaga.ttf).

Output (flat dir; assets referenced as ../assets/...):
    <out>/fief-<sc>-<NN>.html
    <out>/daimyo-<sc>-<NN>.html
"""
from __future__ import annotations

import html
from pathlib import Path

from .data import load_scenario

ROOT = Path(__file__).resolve().parent.parent.parent  # .../nobunaga
DEFAULT_OUT = ROOT / "wikipages-out"

# Asset paths relative to a page in the (flat) output dir.
FONT_REL = "../assets/fonts/nobunaga.ttf"
def _portrait_rel(sc, i): return f"../assets/portraits/{sc}/daimyo-{i:02d}.png"
def _banner_rel(sc, i):   return f"../assets/banners/{sc}/banner-{i:02d}.png"
def _map_rel(sc, i):      return f"../assets/maps/fiefs/{sc}/fief-{i:02d}.png"
def _fief_href(sc, i):    return f"fief-{sc}-{i:02d}.html"
def _daimyo_href(sc, i):  return f"daimyo-{sc}-{i:02d}.html"
def _daimyo_index_href(sc): return f"daimyo-{sc}.html"
def _fief_index_href(sc):   return f"fief-{sc}.html"

# Scenarios whose clickable fief-index map is built (so nav/home link to it).
# 50 is a PLACEHOLDER: its hotspots/links are correct, but the map terrain is still
# misaligned (chained-shear compounding) pending the global least-squares solve.
FIEF_INDEX_SCENARIOS = {17, 50}

# Battle-map native resolution (11x5 cells * 32px); the PNG ships at 3x this.
# MAP_SCALE 3 == the PNG's own resolution: exact 1:1, no resampling (sharpest).
MAP_NATIVE_W = 352
MAP_SCALE = 3            # display the map at MAP_NATIVE_W * MAP_SCALE px wide

# In-game labels -> data column, in the game's on-screen order.
FIEF_ROWS = [("Gold", "gold"), ("Debt", "debt"), ("Town", "town"), ("Rice", "rice"),
             ("Output", "output"), ("Dams", "dams"), ("Lylty", "loyalty"),
             ("Wealth", "wealth"), ("Men", "men"), ("Morale", "morale"),
             ("Skill", "skill"), ("Arms", "arms")]
DAIMYO_ROWS = [("Age", "age"), ("Hlth", "health"), ("Driv", "drive"), ("Luck", "luck"),
               ("Char", "charisma"), ("IQ", "iq")]

# Sampled straight from assets/Saves/playerturn.png.
C_BG = "#000000"
C_TITLE = "#fffeff"     # title bar / fief stat values
C_DAIMYO = "#45e082"    # daimyo name + stats (green)
C_HOME = "#e4e594"      # "Home fief" label (pale yellow)
C_LABEL = "#c676ff"     # fief stat labels (purple)

TEMPLATE_CSS = """
@font-face {
  font-family: 'NobunagaFont';
  src: url('%(font)s') format('truetype');
}
* { box-sizing: border-box; }
body {
  margin: 0; padding: 32px 16px;
  background: %(bg)s; color: %(title)s;
  font-family: 'NobunagaFont', monospace;
  image-rendering: pixelated;
  -webkit-font-smoothing: none;
  font-size: 24px; line-height: 1.35;
}
a { text-decoration: none; }
a:hover { text-decoration: underline; }
.panel { max-width: 640px; margin: 0 auto; }
.row { display: flex; gap: 28px; flex-wrap: wrap; align-items: flex-start; }
img { image-rendering: pixelated; display: block; }
.portrait { width: 192px; height: 192px; }
.banner   { width: 192px; height: auto; margin-top: 12px; }
/* full-bleed: let the map escape the narrow panel and span the viewport */
.mapwrap  { width: 100vw; position: relative; left: 50%%; transform: translateX(-50%%);
            margin-top: 28px; text-align: center; }
.battlemap{ height: auto; max-width: 100%%; display: inline-block;
            image-rendering: pixelated; }

/* stat block: label left, value right-aligned, like the in-game column */
.stats { width: 260px; }
.stat { display: flex; justify-content: space-between; }
.stat .v { padding-left: 24px; }

/* daimyo page (green) */
.name { color: %(daimyo)s; font-size: 40px; letter-spacing: 2px; margin-bottom: 8px; }
.home { color: %(home)s; margin-bottom: 14px; }
.home a { color: %(daimyo)s; }
.stats.daimyo .stat, .stats.daimyo .k, .stats.daimyo .v { color: %(daimyo)s; }

/* fief page (white title, purple labels, white values) */
.title { color: %(title)s; font-size: 36px; letter-spacing: 2px; margin-bottom: 8px; }
.lord { color: %(label)s; margin-bottom: 14px; }
.lord a { color: %(daimyo)s; }
.stats.fief .k { color: %(label)s; }
.stats.fief .v { color: %(title)s; }

/* nav back to the indexes */
.nav { font-size: 18px; margin-bottom: 22px; }
.nav a { color: %(daimyo)s; }
.nav .sep { color: #555; padding: 0 8px; }

/* index pages: a clickable grid of portrait tiles */
.panel.wide { max-width: 1040px; }
.ix-title { color: %(title)s; font-size: 36px; letter-spacing: 2px; margin-bottom: 18px; }
.grid { display: flex; flex-wrap: wrap; gap: 16px; justify-content: center; }
.cell { width: 148px; text-align: center; }
.cell img { width: 112px; height: 112px; image-rendering: pixelated; margin: 0 auto; }
.cell .clan { color: %(daimyo)s; font-size: 16px; margin-top: 6px; display: block;
              white-space: nowrap; }
.cell .num { color: #6a6a80; font-size: 13px; display: block; white-space: nowrap; }
.cell a { color: inherit; display: block; }
.cell .dlink:hover .clan { text-decoration: underline; }
.cell .flink:hover .num { text-decoration: underline; }

/* homepage: title art banner + a menu of index links */
.home-banner { text-align: center; }
.home-banner img { max-width: 100%%; image-rendering: pixelated; margin: 0 auto; }
.menu { text-align: center; margin-top: 34px; font-size: 26px; }
.menu .col { display: inline-block; vertical-align: top; margin: 0 36px; }
.menu .head { color: %(title)s; margin-bottom: 10px; letter-spacing: 2px; }
.menu a { color: %(daimyo)s; display: block; margin: 5px 0; }
.menu .soon { color: #555; display: block; margin: 5px 0; }

/* clickable strategic-map index: hotspots overlaid on the map image */
.map-index { position: relative; display: inline-block; max-width: 100%%; line-height: 0; }
.map-index img { display: block; width: 100%%; height: auto; image-rendering: pixelated; }
.hot { position: absolute; transform: translate(-50%%, -50%%); width: 5.2%%; height: 8%%;
       border: 2px solid transparent; border-radius: 3px; }
.hot:hover { border-color: %(home)s; background: rgba(228,229,148,0.28); }
.hot .tip { position: absolute; left: 50%%; bottom: 112%%; transform: translateX(-50%%);
            white-space: nowrap; background: #000; color: %(daimyo)s; font-size: 16px;
            line-height: 1.1; padding: 3px 6px; border: 1px solid %(daimyo)s; display: none; }
.hot:hover .tip { display: block; }
"""

PAGE = """<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>%(title)s</title>
<style>%(css)s</style>
</head><body><div class="panel%(panel_class)s">
%(body)s
</div></body></html>
"""


def _esc(v):
    return html.escape(str(v))


def _statrows(row, pairs):
    out = []
    for label, key in pairs:
        out.append(f'<div class="stat"><span class="k">{_esc(label)}</span>'
                   f'<span class="v">{_esc(row[key])}</span></div>')
    return "".join(out)


def _shell(title, body, panel_class=""):
    css = TEMPLATE_CSS % {"font": FONT_REL, "bg": C_BG, "title": C_TITLE,
                          "daimyo": C_DAIMYO, "home": C_HOME, "label": C_LABEL}
    pc = f" {panel_class}" if panel_class else ""
    return PAGE % {"title": _esc(title), "css": css, "body": body, "panel_class": pc}


def _nav(sc: int) -> str:
    """Back-links to the scenario's index pages (fief index added once it's built)."""
    links = [f'<a href="{_daimyo_index_href(sc)}">All daimyo</a>']
    if sc in FIEF_INDEX_SCENARIOS:
        links.insert(0, f'<a href="{_fief_index_href(sc)}">All fiefs</a>')
    sep = '<span class="sep">&middot;</span>'
    return f'<div class="nav">{sep.join(links)} <span class="sep">|</span> {sc}-fief</div>'


def render_daimyo_page(sc: int, entry) -> str:
    i, fief_name, d = entry.idx, entry.name, entry.daimyo
    clan = d["clan"]
    title = f"{clan} - {sc}-fief - Nobunaga's Ambition"
    art = (f'<div class="art">'
           f'<img class="portrait" src="{_portrait_rel(sc, i)}" alt="{_esc(clan)} portrait">'
           f'<img class="banner" src="{_banner_rel(sc, i)}" alt="{_esc(clan)} banner">'
           f'</div>')
    info = (f'<div class="info">'
            f'<div class="name">{_esc(clan)}</div>'
            f'<div class="home">Home fief <a href="{_fief_href(sc, i)}">{_esc(fief_name)}</a></div>'
            f'<div class="stats daimyo">{_statrows(d, DAIMYO_ROWS)}</div>'
            f'</div>')
    body = f'{_nav(sc)}<div class="row">{art}{info}</div>'
    return _shell(title, body)


def render_fief_page(sc: int, entry, map_scale: int = MAP_SCALE) -> str:
    i, name, f, d = entry.idx, entry.name, entry.fief, entry.daimyo
    title = f"{name} - {sc}-fief - Nobunaga's Ambition"
    head = (f'<div class="title">Fief {i + 1} {_esc(name)}</div>'
            f'<div class="lord">Daimyo <a href="{_daimyo_href(sc, i)}">{_esc(d["clan"])}</a></div>')
    stats = f'<div class="stats fief">{_statrows(f, FIEF_ROWS)}</div>'
    map_w = MAP_NATIVE_W * map_scale
    art = (f'<div class="mapwrap">'
           f'<img class="battlemap" style="width:{map_w}px" '
           f'src="{_map_rel(sc, i)}" alt="{_esc(name)} battle map">'
           f'</div>')
    body = f'{_nav(sc)}{head}{stats}{art}'
    return _shell(title, body)


def render_daimyo_index(sc: int) -> str:
    s = load_scenario(sc)
    title = f"Daimyo - {sc}-fief - Nobunaga's Ambition"
    cells = []
    for e in s.entries:
        clan = e.daimyo["clan"]
        cells.append(
            f'<div class="cell">'
            f'<a class="dlink" href="{_daimyo_href(sc, e.idx)}">'
            f'<img src="{_portrait_rel(sc, e.idx)}" alt="{_esc(clan)}">'
            f'<span class="clan">{_esc(clan)}</span></a>'
            f'<a class="flink" href="{_fief_href(sc, e.idx)}">'
            f'<span class="num">{e.idx + 1} {_esc(e.name)}</span></a>'
            f'</div>')
    nav = (f'<div class="nav"><a href="{_daimyo_index_href(50 if sc == 17 else 17)}">'
           f'{50 if sc == 17 else 17}-fief daimyo</a></div>')
    body = (f'{nav}<div class="ix-title">Daimyo &mdash; {sc}-fief scenario '
            f'({len(s.entries)})</div>'
            f'<div class="grid">{"".join(cells)}</div>')
    return _shell(title, body, panel_class="wide")


STRATEGIC_DIR = ROOT / "assets" / "maps" / "strategic"
def _strat_map_rel(sc): return f"../assets/maps/strategic/strategic-map-{sc}-stitched.png"
def _strat_coords(sc):  return STRATEGIC_DIR / f"strategic-map-{sc}-stitched.coords.json"


def render_fief_index(sc: int) -> str:
    """Clickable strategic-map index: the stitched map with one hotspot per fief
    (positioned from the render's coords manifest) linking to that fief's page."""
    import json
    coords = json.loads(_strat_coords(sc).read_text(encoding="utf-8"))
    iw, ih = coords["size"]
    s = load_scenario(sc)
    names = {e.idx: e.name for e in s.entries}        # 0-based idx -> fief name
    title = f"Fiefs - {sc}-fief - Nobunaga's Ambition"
    nav = (f'<div class="nav"><a href="{_daimyo_index_href(sc)}">All daimyo</a>'
           f'<span class="sep">|</span> {sc}-fief</div>')
    hots = []
    for num_str, (cx, cy) in coords["fiefs"].items():
        idx = int(num_str) - 1                        # coords keys are 1-based fief numbers
        name = names.get(idx, num_str)
        hots.append(
            f'<a class="hot" style="left:{cx / iw * 100:.2f}%;top:{cy / ih * 100:.2f}%" '
            f'href="{_fief_href(sc, idx)}">'
            f'<span class="tip">{int(num_str)} {_esc(name)}</span></a>')
    body = (f'{nav}<div class="ix-title">Fiefs &mdash; {sc}-fief scenario '
            f'({len(s.entries)})</div>'
            f'<div class="map-index"><img src="{_strat_map_rel(sc)}" alt="{sc}-fief map">'
            f'{"".join(hots)}</div>')
    return _shell(title, body, panel_class="wide")


def _menu_col(head: str, links) -> str:
    rows = "".join(links)
    return f'<div class="col"><div class="head">{head}</div>{rows}</div>'


def render_home() -> str:
    """Site homepage: the cropped title-screen art over a menu of the index pages."""
    title = "Nobunaga's Ambition - decompiled fief & daimyo wiki"
    banner = ('<div class="home-banner">'
              '<img src="../assets/screens/title-home.png" alt="Nobunaga\'s Ambition">'
              '</div>')
    fiefs = [(f'<a href="{_fief_index_href(sc)}">{sc}-fief</a>' if sc in FIEF_INDEX_SCENARIOS
              else f'<span class="soon">{sc}-fief (soon)</span>') for sc in (17, 50)]
    daimyo = [f'<a href="{_daimyo_index_href(sc)}">{sc}-fief</a>' for sc in (17, 50)]
    menu = (f'<div class="menu">{_menu_col("Fiefs", fiefs)}'
            f'{_menu_col("Daimyo", daimyo)}</div>')
    return _shell(title, banner + menu, panel_class="wide")


def build_scenario(sc: int, out: Path) -> int:
    s = load_scenario(sc)
    out.mkdir(parents=True, exist_ok=True)
    n = 0
    for e in s.entries:
        (out / _fief_href(sc, e.idx)).write_text(render_fief_page(sc, e), encoding="utf-8")
        (out / _daimyo_href(sc, e.idx)).write_text(render_daimyo_page(sc, e), encoding="utf-8")
        n += 2
    (out / _daimyo_index_href(sc)).write_text(render_daimyo_index(sc), encoding="utf-8")
    n += 1
    if sc in FIEF_INDEX_SCENARIOS:
        (out / _fief_index_href(sc)).write_text(render_fief_index(sc), encoding="utf-8")
        n += 1
    return n


def build_all(out: Path = DEFAULT_OUT) -> int:
    total = sum(build_scenario(sc, out) for sc in (17, 50))
    out.mkdir(parents=True, exist_ok=True)
    (out / "index.html").write_text(render_home(), encoding="utf-8")
    total += 1
    try:
        loc = out.relative_to(ROOT)
    except ValueError:
        loc = out
    print(f"wrote {total} pages -> {loc}/")
    return total


if __name__ == "__main__":
    build_all()
