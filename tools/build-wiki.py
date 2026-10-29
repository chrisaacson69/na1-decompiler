#!/usr/bin/env python3
"""
build-wiki.py — generate the GitHub Wiki (the game concept/formula reference)
from nobunaga/commands/*.md, then commit & push it.

The wiki is the markdown reference half of the three-way split (README hub /
Pages analysis / Wiki reference). It clones na1-decompiler.wiki.git, regenerates
Home + _Sidebar + one page per command (front matter stripped, links rewritten
for the wiki context), and pushes. Re-run any time the command sources change.

Links are rewritten three ways:
  ../<chapter|appendix|decompiler>.md -> the Pages analysis site (.html)
  ../<other>.md                       -> the repo source (blob)
  ./README.md                         -> the wiki "Commands" index page
  ./<cmd>.md                          -> the sibling wiki page (Capitalized)
  ./<cmd>.html                        -> the rich animated page on Pages

Run from anywhere:  py nobunaga/tools/build-wiki.py
"""
import re
import subprocess
import sys
import tempfile
from pathlib import Path

SCRIPT = Path(__file__).resolve()
SRC = SCRIPT.parent.parent                  # nobunaga/
CMDS = SRC / "commands"

OWNER, REPO = "chrisaacson69", "na1-decompiler"
PAGES = f"https://{OWNER}.github.io/{REPO}"
BLOB = f"https://github.com/{OWNER}/{REPO}/blob/main/nobunaga"
WIKI_URL = f"https://github.com/{OWNER}/{REPO}.wiki.git"

PAGES_STEM = re.compile(r"^(\d|appendix-|decompiler-)")


def sh(args, cwd=None, check=True):
    r = subprocess.run(args, cwd=cwd, text=True, capture_output=True)
    if check and r.returncode != 0:
        sys.exit(f"$ {' '.join(args)}\n{r.stdout}\n{r.stderr}")
    return r


def cap(stem):
    return stem[:1].upper() + stem[1:]


def rewrite_target(t):
    t, _, anchor = t.partition("#")
    anchor = ("#" + anchor) if anchor else ""
    if t.startswith("http"):
        return t + anchor
    if t.startswith("../"):
        name = t[3:]
        if name == "README.md":
            return PAGES + "/" + anchor
        if name.endswith(".md"):
            stem = name[:-3]
            if PAGES_STEM.match(stem):
                return f"{PAGES}/{stem}.html{anchor}"
            return f"{BLOB}/{name}{anchor}"
        return f"{BLOB}/{name}{anchor}"
    if t.startswith("./"):
        name = t[2:]
        if name == "README.md":
            return "Commands" + anchor
        if name.endswith(".html"):
            return f"{PAGES}/commands/{name}{anchor}"
        if name.endswith(".md"):
            return cap(name[:-3]) + anchor
    return t + anchor


LINK_RE = re.compile(r"(\]\()([^)]+)(\))")


def rewrite_links(text):
    return LINK_RE.sub(lambda m: m.group(1) + rewrite_target(m.group(2)) + m.group(3), text)


def parse(md):
    m = re.match(r"^---\r?\n(.*?)\r?\n---\r?\n", md, re.DOTALL)
    fm = {}
    if m:
        for ln in m.group(1).splitlines():
            if ":" in ln:
                k, v = ln.split(":", 1)
                fm[k.strip()] = v.strip()
        body = md[m.end():]
    else:
        body = md
    return fm, body


def command_page(path):
    fm, body = parse(path.read_text(encoding="utf-8"))
    stem = path.stem
    # metadata + "see it in action" line, inserted after the summary blockquote
    bits = []
    if fm.get("menu_index"):
        bits.append(f"**Menu #{fm['menu_index']}**")
    if fm.get("driver"):
        bits.append(f"driver `{fm['driver']}`")
    if fm.get("effect"):
        bits.append(f"effect `{fm['effect']}`")
    bits.append(f"▶ [See it in action (animated)]({PAGES}/commands/{stem}.html)")
    meta_line = " · ".join(bits)

    body = rewrite_links(body).strip()
    # inject meta line after the first blockquote summary (the `> ...` line)
    lines = body.splitlines()
    out, injected = [], False
    for i, ln in enumerate(lines):
        out.append(ln)
        if not injected and ln.startswith(">"):
            out.append("")
            out.append(meta_line)
            injected = True
    if not injected:
        out.insert(1, "\n" + meta_line + "\n")
    return "\n".join(out) + "\n"


def main():
    cmd_files = sorted(f for f in CMDS.glob("*.md") if f.name != "README.md")
    names = [cap(f.stem) for f in cmd_files]

    tmp = Path(tempfile.mkdtemp(prefix="na1-wiki-"))
    wiki = tmp / "wiki"
    token = sh(["gh", "auth", "token"]).stdout.strip()
    auth_url = WIKI_URL.replace("https://", f"https://x-access-token:{token}@")
    print("Cloning wiki…")
    sh(["git", "clone", "--depth", "1", auth_url, str(wiki)])

    # wipe existing markdown (keep .git), regenerate
    for p in wiki.glob("*.md"):
        p.unlink()

    # per-command pages
    for f in cmd_files:
        (wiki / f"{cap(f.stem)}.md").write_text(command_page(f), encoding="utf-8")

    # Commands index (from commands/README.md)
    if (CMDS / "README.md").exists():
        _, body = parse((CMDS / "README.md").read_text(encoding="utf-8"))
        (wiki / "Commands.md").write_text(rewrite_links(body).strip() + "\n", encoding="utf-8")

    # Home
    cmd_links = " · ".join(f"[{n}]({n})" for n in names)
    home = f"""# Nobunaga's Ambition (NES) — Game Reference

> The concept &amp; formula reference for the [na1-decompiler]({PAGES}) project.
For the full chapter-by-chapter analysis, the decompiler story, and **animated**
command walkthroughs, see the **[analysis site]({PAGES}/)**.

This wiki is the linkable markdown reference: one page per command, with the
bytecode-verified mechanics and formulas.

## Commands
{cmd_links}

See **[Commands](Commands)** for the overview, or the sidebar for the full list.

---
*This wiki is generated by `nobunaga/tools/build-wiki.py` — edit the sources in
`nobunaga/commands/`, not here.*
"""
    (wiki / "Home.md").write_text(home, encoding="utf-8")

    # Sidebar
    sidebar = "### Reference\n\n- [Home](Home)\n- [Commands](Commands)\n\n### Per-command\n\n" + \
        "\n".join(f"- [{n}]({n})" for n in names) + \
        f"\n\n---\n\n- [📖 Analysis site]({PAGES}/)\n- [🔧 Repo](https://github.com/{OWNER}/{REPO})\n"
    (wiki / "_Sidebar.md").write_text(sidebar, encoding="utf-8")

    # commit + push
    sh(["git", "-c", "user.name=Chris.Isaacson", "-c", "user.email=chrisaacson@gmail.com",
        "add", "-A"], cwd=wiki)
    status = sh(["git", "status", "--porcelain"], cwd=wiki).stdout.strip()
    if not status:
        print("Wiki already up to date — nothing to push.")
        return
    sh(["git", "-c", "user.name=Chris.Isaacson", "-c", "user.email=chrisaacson@gmail.com",
        "commit", "-m", "Regenerate wiki reference from nobunaga/commands/ (build-wiki.py)"], cwd=wiki)
    print("Pushing wiki…")
    sh(["git", "push", "origin", "HEAD"], cwd=wiki)
    print(f"Done: {len(cmd_files)} command pages + Home + Commands + _Sidebar pushed.")
    print(f"  -> https://github.com/{OWNER}/{REPO}/wiki")


if __name__ == "__main__":
    main()
