#!/usr/bin/env python3
"""
build-site.py — assemble the GitHub Pages site (repo-root /docs) from nobunaga/.

Division of labor (see README): **Pages** hosts the AI-co-authored analysis &
stories (markdown, Jekyll-rendered) plus the generated standalone HTML pages
(served as-is); the **Wiki** holds the markdown command/concept reference.

docs/ is fully generated and owned by this script — edit sources in nobunaga/,
then re-run. Jekyll renders the .md (front matter injected here); the
jekyll-relative-links plugin rewrites .md cross-links to .html.

Run from anywhere:  py nobunaga/tools/build-site.py
"""
import json
import re
import shutil
from pathlib import Path

SCRIPT = Path(__file__).resolve()
SRC = SCRIPT.parent.parent              # nobunaga/
ROOT = SRC.parent                       # repo root
OUT = ROOT / "docs"

BASEURL = "/na1-decompiler"

CONFIG_YML = """\
title: "Nobunaga's Ambition (NES) — Decompiled & Analyzed"
description: "A bytecode-VM decompiler, chapter-by-chapter analysis, verified game formulas, and never-before-seen data from the 1989 Koei strategy classic."
baseurl: "{baseurl}"
plugins:
  - jekyll-relative-links
relative_links:
  enabled: true
  collections: false
defaults:
  - scope:
      path: ""
    values:
      layout: default
""".format(baseurl=BASEURL)

# generated standalone HTML served as-is (no front matter -> Jekyll static copy)
HTML_PAGES = sorted(SRC.glob("turn-loop*.html")) + [SRC / "ai.html"]
# fonts + banners added for the fief/daimyo atlas (docs/atlas/, generated below).
ASSET_DIRS = ["maps", "portraits", "screens", "animations", "fonts", "banners"]


def meta(md_text):
    """Return (title, summary) from a chapter's body."""
    m = re.match(r"^---\r?\n(.*?)\r?\n---\r?\n", md_text, re.DOTALL)
    body = md_text[m.end():] if m else md_text
    t = re.search(r"^#\s+(.+?)\s*$", body, re.M)
    s = re.search(r"^>\s+(.+?)\s*$", body, re.M)
    title = t.group(1).strip() if t else "Untitled"
    summary = s.group(1).strip() if s else ""
    return title, summary


def emit_md(path, title):
    """Copy a chapter into docs/, ensuring front matter has layout + title."""
    text = path.read_text(encoding="utf-8")
    m = re.match(r"^---\r?\n(.*?)\r?\n---\r?\n", text, re.DOTALL)
    fm = m.group(1) if m else ""
    body = text[m.end():] if m else text
    lines = [ln for ln in fm.splitlines()] if fm else []
    keys = {ln.split(":", 1)[0].strip() for ln in lines if ":" in ln}
    if "layout" not in keys:
        lines.append("layout: default")
    if "title" not in keys:
        lines.append("title: " + json.dumps(title))
    out = "---\n" + "\n".join(lines) + "\n---\n" + body
    (OUT / path.name).write_text(out, encoding="utf-8")


def card(items):
    li = "\n".join(
        f'      <li><a href="{href}">{t}</a>{(" &mdash; " + s) if s else ""}</li>'
        for href, t, s in items
    )
    return li


def main():
    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)
    (OUT / "_config.yml").write_text(CONFIG_YML, encoding="utf-8")
    # custom Jekyll layout (replaces the theme) so md chapters get the site nav + CSS
    (OUT / "_layouts").mkdir(parents=True, exist_ok=True)
    (OUT / "_layouts" / "default.html").write_text(JEKYLL_LAYOUT, encoding="utf-8")

    chapters = sorted(SRC.glob("[0-9]*.md"))
    appendices = sorted(SRC.glob("appendix-*.md"))
    decompiler = sorted(SRC.glob("decompiler-*.md"))

    sections = {"chapters": [], "appendices": [], "decompiler": []}
    for group, files in (("chapters", chapters), ("appendices", appendices), ("decompiler", decompiler)):
        for f in files:
            title, summary = meta(f.read_text(encoding="utf-8"))
            emit_md(f, title)
            sections[group].append((f.stem + ".html", title, summary))

    # generated standalone HTML (commands/, turn-loop*, ai)
    cmd_src = SRC / "commands"
    if cmd_src.exists():
        shutil.copytree(cmd_src, OUT / "commands",
                        ignore=shutil.ignore_patterns("*.md", "README*"))
    for h in HTML_PAGES:
        if h.exists():
            shutil.copy2(h, OUT / h.name)

    # assets (presentational subset; skip Saves and _-prefixed diagnostics)
    for d in ASSET_DIRS:
        src = SRC / "assets" / d
        if src.exists():
            shutil.copytree(src, OUT / "assets" / d,
                            ignore=shutil.ignore_patterns("_*", "*.coords.json"))

    # generated data pages (#5) — viability map, emitted by viability-map.py
    import importlib.util
    spec = importlib.util.spec_from_file_location("viability_map", SCRIPT.parent / "viability-map.py")
    vm = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(vm)
    (OUT / "data").mkdir(parents=True, exist_ok=True)
    (OUT / "data" / "viability.html").write_text(vm.build_html(SRC), encoding="utf-8")

    # interactive fief & daimyo atlas (wikipages package) -> docs/atlas/.
    # Its pages reference ../assets/... which, one level deep, resolves to docs/assets/.
    import sys as _sys
    if str(SCRIPT.parent) not in _sys.path:
        _sys.path.insert(0, str(SCRIPT.parent))
    from wikipages import pages as wpages
    n_atlas = wpages.build_all(OUT / "atlas")

    write_index(sections)
    write_sections(sections)
    n_html = len(list((OUT / "commands").glob("*.html"))) if (OUT / "commands").exists() else 0
    print(f"Built docs/ : {len(chapters)} chapters, {len(appendices)} appendices, "
          f"{len(decompiler)} decompiler pages, {n_html} command HTML, "
          f"{len(HTML_PAGES)} turn-loop/ai pages, {n_atlas} atlas pages.")


NAV_LINKS = [("Home", "index.html"), ("Atlas", "atlas/"), ("Reference", "reference.html"),
             ("Synthesis", "synthesis.html"), ("Papers", "papers.html")]


def nav(active=""):
    out = []
    for label, path in NAV_LINKS:
        cls = ' class="active"' if label == active else ''
        out.append(f'<a href="{path}"{cls}>{label}</a>')
    return '<nav class="topbar">' + "".join(out) + "</nav>"


def footer():
    return ('<div class="footer">Built from bytecode &mdash; everything here was recovered from the ROM. '
            f'Generated by <code>tools/build-site.py</code>. <a href="index.html">Home</a></div>')


SITE_CSS = ("@font-face { font-family:'NA'; src:url('assets/fonts/nobunaga.ttf') format('truetype'); }\n" + """
:root { --bg:#fbf8f2; --text:#1a1a1a; --muted:#5a534a; --accent:#7a2e2e; --border:#ddd6c8; --card:#fff; --ink:#0a0a12; --grn:#45e082; }
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:Georgia,'Times New Roman',serif; color:var(--text); background:var(--bg); line-height:1.7; }
.topbar { background:var(--ink); display:flex; justify-content:center; gap:4px; flex-wrap:wrap; padding:9px 12px; position:sticky; top:0; z-index:20; border-bottom:2px solid var(--grn); }
.topbar a { color:#cfcfe0; font-family:'NA',monospace; font-size:15px; text-decoration:none; padding:6px 13px; border-radius:4px; }
.topbar a:hover { color:#fff; background:rgba(255,255,255,.08); }
.topbar a.active { color:var(--grn); }
.hero { background:var(--ink); text-align:center; padding:32px 20px 42px; border-bottom:3px solid var(--grn); }
.hero-art { display:block; margin:0 auto; width:100%; max-width:512px; image-rendering:pixelated; }
.hero-menu { display:flex; justify-content:center; gap:54px; margin-top:24px; font-family:'NA',monospace; }
.hm-col { text-align:left; }
.hm-h { display:block; color:#fffeff; font-size:23px; letter-spacing:2px; margin-bottom:8px; }
.hero-menu a { display:block; color:var(--grn); font-size:20px; margin:5px 0; text-decoration:none; }
.hero-menu a:hover { text-decoration:underline; }
.hero-tag { max-width:620px; margin:22px auto 0; color:#9a9ab0; font-style:italic; }
.content { max-width:860px; margin:0 auto; padding:44px 36px; }
h1 { font-size:2.0em; color:var(--accent); line-height:1.18; margin:0 0 8px; }
.subtitle { font-size:1.08em; color:var(--muted); font-style:italic; margin-bottom:20px; padding-bottom:16px; border-bottom:2px solid var(--accent); }
.lead { font-size:1.08em; margin-bottom:12px; }
h2 { font-size:1.32em; color:var(--accent); margin:34px 0 13px; padding-bottom:5px; border-bottom:1px solid var(--border); }
h3 { font-size:1.1em; color:var(--accent); margin:18px 0 8px; }
p { margin-bottom:12px; }
a { color:var(--accent); text-decoration:none; border-bottom:1px solid transparent; }
.content a:hover { border-bottom-color:var(--accent); }
.muted { color:var(--muted); font-size:0.95em; }
ul, ol { margin:0 0 12px; list-style:none; }
.content li { margin-bottom:6px; }
.linklist li { padding-left:1.15em; text-indent:-1.15em; }
.linklist li::before { content:"\\2192 "; color:var(--accent); }
.pillars { display:grid; grid-template-columns:repeat(auto-fit,minmax(230px,1fr)); gap:16px; margin:26px 0; }
.pillar { background:var(--card); border:1px solid var(--border); border-radius:8px; padding:18px 20px; }
.pillar h3 { margin-top:0; }
.pillar p { color:var(--muted); font-size:0.95em; margin-bottom:0; }
.prose ul, .prose ol { padding-left:1.4em; list-style:revert; margin-bottom:14px; }
.prose li { margin-bottom:5px; }
.prose li::before { content:none; }
.prose blockquote { border-left:4px solid var(--grn); background:#f3efe6; padding:10px 16px; margin:14px 0; color:var(--muted); font-style:italic; }
.prose code { font-family:Consolas,monospace; background:#efeae0; padding:1px 5px; border-radius:3px; font-size:0.92em; }
.prose pre { background:#1f2430; color:#e6e6ee; padding:14px 16px; border-radius:6px; overflow:auto; margin:14px 0; }
.prose pre code { background:none; color:inherit; padding:0; }
.prose table { border-collapse:collapse; margin:14px 0; width:100%; font-size:0.94em; display:block; overflow:auto; }
.prose th, .prose td { border:1px solid var(--border); padding:6px 10px; text-align:left; }
.prose th { background:#f1ece2; }
.prose img { max-width:100%; height:auto; }
.prose hr { border:none; border-top:1px solid var(--border); margin:24px 0; }
.footer { max-width:860px; margin:46px auto 0; padding:18px 36px 40px; border-top:1px solid var(--border); font-size:0.85em; color:var(--muted); text-align:center; }
@media (max-width:640px) { .hero-menu { gap:28px; } .content { padding:30px 18px; } }
""")


def page(title, body, active=""):
    return ('<!DOCTYPE html>\n<html lang="en">\n<head>\n<meta charset="UTF-8">\n'
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
            f"<title>{title}</title>\n<style>{SITE_CSS}</style>\n</head>\n<body>\n"
            + nav(active) + "\n" + body + "\n</body>\n</html>\n")


def write_index(sections):
    hero = (
        '<header class="hero">'
        f'<img class="hero-art" src="assets/screens/title-home.png" alt="Nobunaga\'s Ambition (NES)">'
        '<nav class="hero-menu">'
        f'<div class="hm-col"><span class="hm-h">Fiefs</span>'
        f'<a href="atlas/fief-17.html">17-fief map</a>'
        f'<a href="atlas/fief-50.html">50-fief map</a></div>'
        f'<div class="hm-col"><span class="hm-h">Daimyo</span>'
        f'<a href="atlas/daimyo-17.html">17-fief lords</a>'
        f'<a href="atlas/daimyo-50.html">50-fief lords</a></div>'
        '</nav>'
        '<p class="hero-tag">Click the map &mdash; every province and lord, with stats, portraits, '
        'banners and battle maps, rendered from the ROM in the game\'s own font.</p>'
        '</header>')
    pillars = (
        '<div class="pillars">'
        f'<div class="pillar"><h3><a href="atlas/">🗺️ Atlas</a></h3>'
        '<p>Every province and lord &mdash; clickable strategic maps, stats, portraits, banners, battle maps. Both scenarios.</p></div>'
        f'<div class="pillar"><h3><a href="reference.html">📖 Reference</a></h3>'
        '<p>The player\'s manual: every command, what it does and when to use it, the formulas in plain terms.</p></div>'
        f'<div class="pillar"><h3><a href="synthesis.html">⚔️ Synthesis</a></h3>'
        '<p>Where data meets mechanics: who can take whom, fief viability, and the dominance frontier.</p></div>'
        '</div>')
    intro = (
        '<h1>Play, then go deeper</h1>'
        '<p class="subtitle">The 1989 Koei strategy classic &mdash; mapped, measured, and explained from the ROM up.</p>'
        '<p class="lead">The maps and stats above are the front door. The three guides below are for playing the '
        'game; the two <em>papers</em> beneath them are the deep story of how it was all decoded.</p>')
    papers = (
        '<h2>The Papers</h2>'
        '<p class="muted">The hidden research &mdash; two long-form stories, with the technical appendices.</p>'
        '<div class="pillars">'
        f'<div class="pillar"><h3><a href="journey.html">📜 The Journey</a></h3>'
        '<p>The engine decoded chapter by chapter &mdash; boot, the turn loop, combat, the AI, the economy.</p></div>'
        f'<div class="pillar"><h3><a href="decompiler.html">🔬 The Decompiler</a></h3>'
        '<p>The DREAM story: lifting stack-VM bytecode to readable C, and the toolchain that did it.</p></div>'
        '</div>')
    body = hero + '<main class="content">' + intro + pillars + papers + '</main>' + footer()
    (OUT / "index.html").write_text(
        page("Nobunaga's Ambition (NES) — Decompiled & Analyzed", body, "Home"), encoding="utf-8")


def write_sections(sections):
    # --- GAMEPLAY: Reference (the player's manual; chapters + appendices are NOT here) ---
    ref = (
        '<main class="content">'
        '<h1>Reference</h1>'
        '<p class="subtitle">The player\'s manual &mdash; every command, what it does and when to use it.</p>'
        '<p class="lead">Rich per-command walkthroughs with the formula and an embedded from-ROM animation. '
        '<span class="muted">(Rework in progress: presenting these by the in-game menu and trimming the engineer-level '
        'detail &mdash; the deep math lives in the <a href="papers.html">paper appendices</a>.)</span></p>'
        '<h2>Commands</h2><ul class="linklist">'
        f'<li><a href="commands/index.html">Command index</a> &mdash; all 21 verbs</li>'
        f'<li><a href="turn-loop.html">The turn loop</a> &mdash; what a round looks like</li>'
        f'<li><a href="ai.html">The daimyo AI</a> &mdash; the decision engine</li></ul>'
        '</main>' + footer())
    (OUT / "reference.html").write_text(page("Reference — Nobunaga's Ambition (NES)", ref, "Reference"), encoding="utf-8")

    # --- PAPERS: landing for the two stories + the technical appendices ---
    pap = (
        '<main class="content">'
        '<h1>The Papers</h1>'
        '<p class="subtitle">The hidden research &mdash; two long-form stories, plus the technical appendices.</p>'
        '<div class="pillars">'
        f'<div class="pillar"><h3><a href="journey.html">📜 The Journey</a></h3>'
        '<p>The engine decoded chapter by chapter: boot, the turn loop, combat, the AI, the economy.</p></div>'
        f'<div class="pillar"><h3><a href="decompiler.html">🔬 The Decompiler</a></h3>'
        '<p>The DREAM story: stack-VM bytecode lifted to readable C, and the toolchain that did it.</p></div>'
        '</div>'
        '<h2>Technical Appendices</h2><p class="muted">The bytecode-verified formulas with direct code references &mdash; '
        'the ground truth the gameplay pages distill.</p><ul class="linklist">' + card(sections["appendices"]) + '</ul>'
        '</main>' + footer())
    (OUT / "papers.html").write_text(page("The Papers — Nobunaga's Ambition (NES)", pap, "Papers"), encoding="utf-8")

    # --- PAPER 1: The Journey (the engine chapters) ---
    jrn = (
        '<main class="content">'
        '<h1>The Journey</h1>'
        '<p class="subtitle">The main story &mdash; the game\'s engine, decoded chapter by chapter.</p>'
        '<p class="lead">From the boot vectors to the AI: how a 1989 cartridge actually runs, recovered one '
        'subsystem at a time from the bytecode.</p>'
        '<h2>Chapters</h2><ul class="linklist">' + card(sections["chapters"]) + '</ul>'
        '</main>' + footer())
    (OUT / "journey.html").write_text(page("The Journey — Nobunaga's Ambition (NES)", jrn, "Papers"), encoding="utf-8")

    # --- PAPER 2: The Decompiler (the DREAM/RE story) ---
    dec = (
        '<main class="content">'
        '<h1>The Decompiler</h1>'
        '<p class="subtitle">How the game\'s logic was recovered: stack-VM bytecode lifted to readable C.</p>'
        '<p class="lead">The story of building the decompiler, the goto&rarr;structure engine (DREAM), and the '
        'toolchain that turned a cartridge into source you can read.</p>'
        '<h2>How It Came About</h2><ul class="linklist">' + card(sections["decompiler"]) + '</ul>'
        '<div class="pillars">'
        '<div class="pillar"><h3><a href="https://github.com/chrisaacson69/na1-decompiler">🔧 The Code</a></h3>'
        '<p>The decompiler, the tools, and the full source.</p></div>'
        '<div class="pillar"><h3><a href="https://github.com/chrisaacson69/na1-decompiler/wiki">📚 Game Wiki</a></h3>'
        '<p>The command/concept reference in linkable markdown.</p></div></div>'
        '</main>' + footer())
    (OUT / "decompiler.html").write_text(page("The Decompiler — Nobunaga's Ambition (NES)", dec, "Papers"), encoding="utf-8")

    # --- GAMEPLAY: Synthesis (strategy / dominance) ---
    syn = (
        '<main class="content">'
        '<h1>Synthesis</h1>'
        '<p class="subtitle">Where the data meets the mechanics &mdash; the strategy layer.</p>'
        '<p class="lead">The <a href="atlas/">Atlas</a> tells you who holds what; the '
        '<a href="reference.html">Reference</a> tells you how the rules work. <strong>Synthesis</strong> '
        'is the crossover &mdash; turning both into strategic conclusions: who can conquer whom, which clans survive, '
        'and the dominance frontier. Much of this is woven through the chapters; this page gathers it.</p>'
        '<h2>Generated Strategy Data</h2><ul class="linklist">'
        f'<li><a href="data/viability.html">Starting-Fief Viability</a> &mdash; which clans survive the '
        'opening (both scenarios; AI-vs-AI map + human playability, straight from the bytecode invade predicate)</li></ul>'
        '<h2>Strategy Threads</h2><ul class="linklist">'
        f'<li><a href="ai.html">The AI is monomorphic</a> &mdash; the dominance thesis: every AI fief runs '
        'one brain, every turn; the player\'s whole edge is choosing the single move per fief that matters most.</li>'
        f'<li><a href="reference.html#">Combat &amp; conquest</a> &mdash; the mutual-attrition melee model, '
        'terrain as a defensive multiplier, and how a battle resolves (Reference, chapters 14&ndash;17).</li>'
        '</ul>'
        '<h2>The Counter-Graph Capstone</h2>'
        '<p class="muted">The full <em>&ldquo;bytecode &rarr; strategy counter-graph / dominance frontier&rdquo;</em> '
        'writeup &mdash; combining every fief\'s economy and army with the combat and AI rules into a who-beats-whom '
        'map of the whole board &mdash; lands here. <em>(In progress.)</em></p>'
        '</main>' + footer())
    (OUT / "synthesis.html").write_text(page("Synthesis — Nobunaga's Ambition (NES)", syn, "Synthesis"), encoding="utf-8")


# Jekyll layout for the markdown chapters/appendices (replaces the theme so the
# nav + styling match the standalone pages). {{ }} kept literal for Liquid.
JEKYLL_LAYOUT = ('<!DOCTYPE html>\n<html lang="en">\n<head>\n<meta charset="UTF-8">\n'
                 '<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
                 '<title>{{ page.title }}</title>\n<style>' + SITE_CSS + '</style>\n</head>\n<body>\n'
                 + nav() + '\n<main class="content prose">\n{{ content }}\n</main>\n'
                 + footer() + '\n</body>\n</html>\n')




if __name__ == "__main__":
    main()
