#!/usr/bin/env python3
"""The battle-entry atlas as a site page: every fief, every side it can be invaded from, where the AI
attacker may deploy and where its commander and two guards land. The pictures and the table come from
tools/battle-entry-atlas.py (assets/maps/battles/entries/, atlas.json); this only lays them out.
build-site.py calls build_html() and writes data/battle-entries.html.

Run alone:  py -3 tools/battle-entry-page.py [out.html]   (images resolve from ../assets/maps/battles/)
"""
import json, html, sys
from pathlib import Path

FULL = {"Yamashir": "Yamashiro"}
nm = lambda s: FULL.get(s, s)
order = ["north", "south", "west", "east"]
STD = {"north": {(0, 0), (10, 0)}, "south": {(0, 2), (10, 2)}, "west": {(0, 0), (0, 4)}}


def kind(e):
    o = e["outcomes"]
    if not o[0]["placed"]:
        return "random"
    return "corner" if {tuple(x["placed"][0]) for x in o} == STD[e["edge"]] else "terrain"


def note(e):
    o, k = e["outcomes"], kind(e)
    if k == "random":
        return f"No scan. All five units drop at random on the {o[0]['open_cells']} open cells."
    if k == "corner":
        return "The commander lands in one of the two scan corners."
    got = sorted({tuple(x["placed"][0]) for x in o})
    return "Terrain pushes the landing off the corner: " + ", ".join(f"({c[0]},{c[1]})" for c in got) + "."


def build_html(root, img="../assets/maps/battles/"):
    a = json.loads((Path(root) / "assets" / "maps" / "battles" / "entries" / "atlas.json").read_text(encoding="utf-8"))
    fiefs = {}
    for e in a:
        fiefs.setdefault((e["fief"], nm(e["name"])), []).append(e)
    sec = []
    for (fid, name), es in sorted(fiefs.items()):
        es.sort(key=lambda e: order.index(e["edge"]))
        rows = []
        for e in es:
            cards = []
            for o in e["outcomes"]:
                land = "Random drop" if not o["placed"] else f"Commander ({o['placed'][0][0]},{o['placed'][0][1]})"
                cards.append(
                    f'<figure class="map"><img src="{img}entries/{o["png"]}" alt="{html.escape(name)} attacked from the {e["edge"]}: {land}" '
                    f'loading="lazy" width="704" height="380"><figcaption><span>{land}</span>'
                    f'<span class="odds">{o["chance"]} of the coin flips</span></figcaption></figure>')
            k = kind(e)
            rows.append(
                f'<div class="entry" data-edge="{e["edge"]}">'
                f'<div class="entry-head"><span class="edge {k}">{e["edge"].title()}</span>'
                f'<span class="from">from {", ".join(map(nm, e["attackers"]))}</span></div>'
                f'<p class="note">{note(e)} <span class="dim">{e["outcomes"][0]["open_cells"]} open, '
                f'{e["outcomes"][0]["banned_cells"]} banned strip cells.</span></p>'
                f'<div class="maps">{"".join(cards)}</div></div>')
        sec.append(f'<section class="fief" id="fief-{fid}"><h2><span class="idx">{fid:02d}</span>{html.escape(name)}</h2>{"".join(rows)}</section>')

    nav = "".join(f'<a href="#fief-{fid}">{html.escape(name)}</a>' for (fid, name) in sorted(fiefs))
    n_terrain = sum(1 for e in a if kind(e) == "terrain")
    n_east = sum(1 for e in a if kind(e) == "random")

    CSS = """
/* Layout: a NES cartridge manual. One dark column of fief chapters, maps at native pixel scale. */
:root {
  color-scheme: dark;
  --bg: #121318; --panel: #1b1d25; --line: #2c2f3b; --fg: #e8e6df; --dim: #9a9cab;
  --atk: #6f8dff; --def: #ff7a5c; --gold: #f2c94c; --terrain: #7fd18b; --ink: #15130b;
  --display: "Silkscreen", "Courier New", monospace;
  --body: "IBM Plex Sans", system-ui, sans-serif;
  --mono: "IBM Plex Mono", ui-monospace, monospace;
}
body { background: var(--bg); color: var(--fg); font: 15px/1.55 var(--body); }
body::before { content: ""; position: fixed; inset: 0 0 auto; height: env(safe-area-inset-top, 0px); z-index: 10; background: var(--bg); }
.wrap { max-width: 1180px; margin: 0 auto; padding-block: 40px 80px; padding-left: max(16px, env(safe-area-inset-left, 0px)); padding-right: max(16px, env(safe-area-inset-right, 0px)); }
h1 { font: 700 clamp(28px, 5vw, 44px)/1.05 var(--display); letter-spacing: .02em; margin: 0 0 14px; text-wrap: balance; }
h1 small { display: block; font: 400 13px var(--mono); color: var(--gold); letter-spacing: .12em; text-transform: uppercase; margin-bottom: 10px; }
.lead { max-width: 68ch; margin: 0 0 28px; }
.grid2 { display: grid; grid-template-columns: minmax(0, 1fr) minmax(0, 1fr); gap: 28px; margin-bottom: 32px; }
@media (max-width: 860px) { .grid2 { grid-template-columns: minmax(0, 1fr); } }
.box { background: var(--panel); border: 1px solid var(--line); border-radius: 6px; padding: 18px 20px; min-width: 0; }
.box h3 { font: 700 13px var(--display); letter-spacing: .06em; margin: 0 0 12px; color: var(--gold); }
.box ul { margin: 0; padding-left: 18px; display: grid; gap: 8px; }
.legend { display: grid; gap: 9px; }
.legend div { display: grid; grid-template-columns: 34px minmax(0, 1fr); gap: 10px; align-items: center; }
.sw { width: 30px; height: 18px; border-radius: 2px; }
.sw.open { background: rgba(255,60,40,.35); outline: 1px solid rgba(255,90,60,.8); }
.sw.ban { background: repeating-linear-gradient(45deg, var(--line) 0 3px, var(--bg) 3px 6px); }
.sw.atk { background: var(--atk); } .sw.def { background: var(--def); }
.sw.men { background: var(--panel); outline: 1px solid var(--line); }
.real { margin: 0 0 32px; }
.real img { image-rendering: pixelated; width: 100%; height: auto; border-radius: 3px; display: block; }
.real figcaption { font-size: 13px; color: var(--dim); margin-top: 8px; }
.toolbar { position: sticky; top: env(safe-area-inset-top, 0px); z-index: 5; background: var(--bg); padding-block: 12px; border-bottom: 1px solid var(--line); display: flex; flex-wrap: wrap; gap: 8px 16px; align-items: center; }
.filters { display: flex; gap: 6px; flex-wrap: wrap; }
.filters button { font: 500 13px var(--mono); color: var(--fg); background: var(--panel); border: 1px solid var(--line); border-radius: 999px; padding: 5px 13px; cursor: pointer; }
.filters button[aria-pressed="true"] { background: var(--gold); color: var(--ink); border-color: var(--gold); }
.filters button:focus-visible, nav a:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
nav { display: flex; flex-wrap: wrap; gap: 4px 12px; font: 13px var(--mono); min-width: 0; }
nav a { color: var(--dim); text-decoration: none; } nav a:hover { color: var(--fg); }
.fief { padding-top: 34px; scroll-margin-top: 90px; }
.fief h2 { font: 700 22px var(--display); margin: 0 0 6px; display: flex; gap: 12px; align-items: baseline; }
.idx { font: 500 13px var(--mono); color: var(--dim); }
.entry { border-top: 1px solid var(--line); padding-block: 16px; }
.entry-head { display: flex; flex-wrap: wrap; gap: 6px 12px; align-items: baseline; }
.edge { font: 700 12px var(--display); letter-spacing: .08em; text-transform: uppercase; padding: 3px 9px; border-radius: 3px; background: var(--line); }
.edge.random { background: var(--def); color: var(--ink); }
.edge.terrain { background: var(--terrain); color: var(--ink); }
.from { color: var(--dim); font-size: 14px; }
.note { margin: 6px 0 12px; max-width: 75ch; }
.dim { color: var(--dim); font-size: 13px; }
.maps { display: grid; grid-template-columns: repeat(auto-fill, minmax(min(100%, 420px), 1fr)); gap: 16px; }
.map { margin: 0; min-width: 0; }
.map img { image-rendering: pixelated; width: 100%; height: auto; display: block; border-radius: 3px; border: 1px solid var(--line); }
.map figcaption { display: flex; justify-content: space-between; flex-wrap: wrap; gap: 4px 10px; font: 13px var(--mono); margin-top: 6px; }
.odds { color: var(--dim); }
code { font: 13px var(--mono); color: var(--gold); }
.tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 4px; }
footer { margin-top: 48px; color: var(--dim); font-size: 13px; max-width: 80ch; }
@media (prefers-reduced-motion: no-preference) { html { scroll-behavior: smooth; } }
"""

    page = f"""<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Battle Entry Atlas — Nobunaga's Ambition (NES)</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap">
<style>{CSS}</style>
</head><body>
<div class="wrap">
<header>
  <h1><small>Nobunaga's Ambition &middot; NES &middot; 17-fief scenario</small>Battle Entry Atlas</h1>
  <p class="lead">Where an AI invader may deploy on every fief, and where its commander and two guards land. Each map is drawn with the game's own tiles from the ROM. The placement comes from the sim's transcription of the ROM's deployment code, run once for each coin outcome, against a defender whose commander sits alone on the castle seat.</p>
</header>
<div class="grid2">
  <div class="box">
    <h3>What the atlas shows</h3>
    <ul>
      <li><b>North, south and west:</b> the commander takes the first open cell in a scan that starts from one of two corners, picked by a coin flip. His two guards take the first free cells beside him.</li>
      <li><b>East:</b> the scan reads the strip mirrored (columns 3 to 0), never finds a cell, and all five units drop at random. That holds for all {n_east} east entries.</li>
      <li><b>Terrain matters.</b> On {n_terrain} entries, water, mountains or the castle ring cover a corner and push the commander along the scan.</li>
      <li>Slots 3 and 4 always drop at random on the open cells, so they are left off these maps.</li>
      <li>A human defender places first. Any of your units next to a scan cell makes the commander skip it, so you can push the landing further.</li>
    </ul>
    <div class="tags" style="margin-top:14px"><span class="edge corner">Corner</span><span class="edge terrain">Terrain-shifted</span><span class="edge random">Random drop</span></div>
  </div>
  <div class="box">
    <h3>Key</h3>
    <div class="legend">
      <div><span class="sw open"></span><span>Strip cells the attacker may deploy on</span></div>
      <div><span class="sw ban"></span><span>Strip cells it may not use: blocked terrain, or the six cells around the castle seat (crossed out on the map)</span></div>
      <div><span class="sw atk"></span><span>Attacker. The &#x2715; tile marks a general's commander; a digit is the unit's slot</span></div>
      <div><span class="sw def"></span><span>Defender. The &#x25CB; tile marks a daimyo-led commander, here on the castle seat</span></div>
      <div><span class="sw men"></span><span>The lower number is the unit's men, set to 20 on every unit here</span></div>
    </div>
  </div>
</div>
<figure class="box real">
  <h3>A real battle start, for comparison</h3>
  <img src="{img}b2-startbattle.png" alt="A captured battle start at Mino, attacked from the east" width="1056" height="570" loading="lazy">
  <figcaption>From the SRAM dump <code>traces/b2-startbattle.dmp</code>: an attack on Mino from the east. All five attackers are scattered, as the east rule predicts. The red units are the human defender's own placement.</figcaption>
</figure>
<div class="toolbar">
  <div class="filters" role="group" aria-label="Filter by entry side">
    <button type="button" id="f-all" data-f="all" aria-pressed="true">All</button>
    <button type="button" id="f-north" data-f="north" aria-pressed="false">North</button>
    <button type="button" id="f-south" data-f="south" aria-pressed="false">South</button>
    <button type="button" id="f-west" data-f="west" aria-pressed="false">West</button>
    <button type="button" id="f-east" data-f="east" aria-pressed="false">East</button>
  </div>
  <nav aria-label="Fiefs">{nav}</nav>
</div>
{"".join(sec)}
<footer>Generated by <code>tools/battle-entry-atlas.py</code> and <code>tools/render-battle-setup.py</code> in na1-decompiler. Sources: <code>set_combat_arena_rect_by_approach</code> $9675, <code>rng_search_combat_rect_for_unit_cell</code> $9954 (the mirrored scan is in the bytecode at $9998), <code>tile_blocked_for_placement</code> $9735, and <code>draw_unit_count_digits</code> $89DF for the unit tiles.</footer>
</div>
<script>
const btns = document.querySelectorAll(".filters button");
btns.forEach(b => b.addEventListener("click", () => {{
  const f = b.dataset.f;
  btns.forEach(x => x.setAttribute("aria-pressed", String(x === b)));
  document.querySelectorAll(".entry").forEach(e => {{ e.hidden = f !== "all" && e.dataset.edge !== f; }});
  document.querySelectorAll(".fief").forEach(s => {{ s.hidden = !s.querySelector(".entry:not([hidden])"); }});
}}));
</script>
</body></html>
"""
    return page


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else root / "_build" / "battle-entries.html"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(build_html(root), encoding="utf-8")
    print("wrote", out)
