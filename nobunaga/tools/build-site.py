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
theme: jekyll-theme-cayman
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
ASSET_DIRS = ["maps", "portraits", "screens", "animations"]


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

    # assets (presentational subset; skip Saves)
    for d in ASSET_DIRS:
        src = SRC / "assets" / d
        if src.exists():
            shutil.copytree(src, OUT / "assets" / d)

    write_index(sections)
    n_html = len(list((OUT / "commands").glob("*.html"))) if (OUT / "commands").exists() else 0
    print(f"Built docs/ : {len(chapters)} chapters, {len(appendices)} appendices, "
          f"{len(decompiler)} decompiler pages, {n_html} command HTML, "
          f"{len(HTML_PAGES)} turn-loop/ai pages.")


def write_index(sections):
    html = INDEX_TMPL.format(
        chapters=card(sections["chapters"]),
        decompiler=card(sections["decompiler"]),
        appendices=card(sections["appendices"]),
    )
    (OUT / "index.html").write_text(html, encoding="utf-8")


INDEX_TMPL = """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Nobunaga's Ambition (NES) — Decompiled &amp; Analyzed</title>
<style>
  :root {{ --bg:#fbf8f2; --text:#1a1a1a; --muted:#5a534a; --accent:#7a2e2e; --border:#ddd6c8; --card:#fff; }}
  * {{ margin:0; padding:0; box-sizing:border-box; }}
  body {{ font-family:Georgia,'Times New Roman',serif; color:var(--text); background:var(--bg);
         line-height:1.7; max-width:860px; margin:0 auto; padding:56px 36px; }}
  h1 {{ font-size:2.1em; color:var(--accent); line-height:1.15; margin-bottom:6px; }}
  .subtitle {{ font-size:1.1em; color:var(--muted); font-style:italic; margin-bottom:24px;
              padding-bottom:18px; border-bottom:2px solid var(--accent); }}
  .lead {{ font-size:1.1em; margin-bottom:8px; }}
  h2 {{ font-size:1.35em; color:var(--accent); margin-top:38px; margin-bottom:14px;
       padding-bottom:5px; border-bottom:1px solid var(--border); }}
  ul {{ list-style:none; }}
  li {{ margin-bottom:7px; }}
  li::before {{ content:"\\2192 "; color:var(--accent); }}
  a {{ color:var(--accent); text-decoration:none; border-bottom:1px solid transparent; }}
  a:hover {{ border-bottom-color:var(--accent); }}
  .muted {{ color:var(--muted); font-size:0.95em; }}
  .nav-cards {{ display:grid; grid-template-columns:1fr 1fr 1fr; gap:14px; margin:18px 0 8px; }}
  .nav-cards a {{ display:block; background:var(--card); border:1px solid var(--border);
                 border-radius:6px; padding:14px 16px; border-bottom:1px solid var(--border); }}
  .nav-cards a:hover {{ border-color:var(--accent); }}
  .nav-cards strong {{ color:var(--accent); }}
  @media (max-width:640px) {{ .nav-cards {{ grid-template-columns:1fr; }} body {{ padding:30px 18px; }} }}
  .footer {{ margin-top:48px; padding-top:18px; border-top:1px solid var(--border);
            font-size:0.85em; color:var(--muted); text-align:center; }}
</style>
</head>
<body>

<h1>Nobunaga's Ambition (NES)</h1>
<p class="subtitle">A bytecode-VM decompiler, chapter-by-chapter analysis, and verified game formulas for the 1989 Koei strategy classic.</p>

<p class="lead">This site is the reader-facing companion to the
<a href="https://github.com/chrisaacson69/na1-decompiler">na1-decompiler</a> project &mdash;
the game's logic was lifted from stack-VM bytecode to C, then mined for how the engine
actually works.</p>

<div class="nav-cards">
  <a href="#chapters"><strong>📖 Analysis</strong><br><span class="muted">chapter-by-chapter</span></a>
  <a href="https://github.com/chrisaacson69/na1-decompiler/wiki"><strong>📚 Game Wiki</strong><br><span class="muted">concepts &amp; formulas</span></a>
  <a href="https://github.com/chrisaacson69/na1-decompiler"><strong>🔧 The Code</strong><br><span class="muted">decompiler &amp; tools</span></a>
</div>

<h2 id="chapters">Chapter-by-Chapter Analysis</h2>
<ul>
{chapters}
</ul>

<h2 id="decompiler">The Decompiler &mdash; How It Came About</h2>
<ul>
{decompiler}
</ul>

<h2 id="appendices">Appendices &amp; Verified Formulas</h2>
<ul>
{appendices}
</ul>

<h2 id="reference">Command Reference</h2>
<p class="muted">Rich per-command walkthroughs (driver flow + bytecode-validated formula + embedded
from-ROM animation). The <a href="https://github.com/chrisaacson69/na1-decompiler/wiki">Wiki</a>
holds the same reference in linkable markdown form.</p>
<ul>
  <li><a href="commands/index.html">Command index</a> &mdash; all 21 verbs</li>
  <li><a href="turn-loop.html">The turn loop</a> &mdash; what a round looks like</li>
  <li><a href="ai.html">The daimyo AI</a> &mdash; the decision engine</li>
</ul>

<div class="footer">Built from bytecode. Generated by <code>tools/build-site.py</code>.</div>

</body>
</html>
"""


if __name__ == "__main__":
    main()
