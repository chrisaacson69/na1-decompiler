#!/usr/bin/env python3
"""
viability-map.py — starting-fief invasion viability ("who survives the opening").

Grounds synthesis-frontier #32. The AI's invade decision is a MEN-COUNT share
(fief_men_ratio_pct = math32_2arg = 100*men(a)/(men(a)+men(b)); $939D/$949A) —
NOT the 8-stat combat strength. Two thresholds:

  * AI-vs-AI:  attack iff share > ~70  (attacker > ~2.3x target)  -> the map is
    mostly frozen; only a fief with a single >=2.3x neighbour gets eaten.
  * vs a PLAYER (grudge path $952E): attack iff share > 47 (attacker > ~0.89x
    you) -> the AI is FAR more aggressive toward the human. A fief safe in the
    all-AI map can be unplayable for a human.

At game start every fief is its own daimyo, so every adjacency is hostile (no
possession check). Revolt (low morale -> MEN/2, appendix-events) can drop a
"safe" fief below its threshold -> the event system feeds the war system.

Run:  py nobunaga/tools/viability-map.py            # text report
      py nobunaga/tools/viability-map.py --html out.html   # write the data page
"""
import re
import sys
from pathlib import Path

SRC = Path(__file__).resolve().parent.parent

SCENARIOS = [("17-fief", "17fief.txt", "adjacency.txt"),
             ("50-fief", "50Fief.txt", "adjacency-50.txt")]


def load_fiefs(path):
    fiefs = {}
    for ln in path.read_text(encoding="utf-8").splitlines():
        p = ln.split()
        if len(p) < 15 or not p[0].isdigit():
            continue
        fiefs[int(p[0])] = dict(name=" ".join(p[1:-13]), gold=int(p[-12]),
                                rice=int(p[-9]), men=int(p[-4]), morale=int(p[-3]))
    return fiefs


def load_adj(path):
    adj, cur = {}, None
    for ln in path.read_text(encoding="utf-8").splitlines():
        nm = re.match(r"\s*(\d+)[\s:]", ln)
        if nm and "raw:" not in ln:
            cur = int(nm.group(1)) - 1
        hm = re.search(r"\[([0-9A-Fa-f ]+)\]", ln)
        if hm and cur is not None:
            nbrs = []
            for h in hm.group(1).split():
                v = int(h, 16)
                if v == 0xFF:
                    break
                nbrs.append(v)
            adj[cur] = nbrs
    return adj


def share(a, b):
    return (a * 100) // (a + b) if (a + b) else 0


def m_safe(nbr_men, line):
    if not nbr_men:
        return 0
    M = 0
    while any(share(n, M) > line for n in nbr_men):
        M += 1
    return M


def analyze(fiefs, adj):
    R = {}
    for f, fd in fiefs.items():
        nbrs = [n for n in adj.get(f, []) if n in fiefs]
        nm = [fiefs[n]["men"] for n in nbrs]
        r = dict(fd, idx=f, ndeg=len(nbrs))
        # offense: weakest neighbour + AI threshold
        if nbrs:
            tgt = min(nbrs, key=lambda n: fiefs[n]["men"])
            s = share(fd["men"], fiefs[tgt]["men"])
            r.update(target_idx=tgt, target=fiefs[tgt]["name"], target_men=fiefs[tgt]["men"],
                     atk_share=s, atk=("INVADES" if s > 72 else "invades?" if s > 70 else "-"))
        else:
            r.update(target_idx=None, target=None, target_men=0, atk_share=0, atk="-")
        # AI-rules defense (2.3x) + revolt exposure
        ms = m_safe(nm, 70)
        r["m_safe"] = ms
        r["men2"] = fd["men"] // 2
        r["def_status"] = ("VULNERABLE" if fd["men"] < ms
                           else "revolt->VULN" if r["men2"] < ms else "safe")
        # human playability (47% grudge line): how many neighbours can come at YOU
        r["human_threats"] = sum(1 for n in nbrs if share(fiefs[n]["men"], fd["men"]) > 47)
        r["play"] = ("PLAYABLE" if r["human_threats"] == 0
                     else "hard" if r["human_threats"] <= 2 else "UNPLAYABLE")
        R[f] = r
    # who gets eaten turn-1 under AI rules
    for r in R.values():
        r["eaten_by"] = 0
    for f, r in R.items():
        if r["target_idx"] is not None and r["atk"] != "-":
            R[r["target_idx"]]["eaten_by"] += 1
    return R


# ---------- text report ----------
def text_report(title, fiefs, adj):
    R = analyze(fiefs, adj)
    print(f"\n===== {title} : {len(fiefs)} fiefs =====")
    print(f"{'fief':<12} {'men':>4} {'mor':>4} {'deg':>3}  {'AI-atk':<9} {'AI-def':<13} "
          f"{'play':<10} {'threats':>7} {'eaten':>5}")
    print("-" * 78)
    for f in sorted(fiefs, key=lambda x: R[x]["play"] == "PLAYABLE"):
        r = R[f]
        print(f"{r['name']:<12} {r['men']:>4} {r['morale']:>4} {r['ndeg']:>3}  "
              f"{r['atk']:<9} {r['def_status']:<13} {r['play']:<10} "
              f"{r['human_threats']:>7} {('<-'+str(r['eaten_by'])) if r['eaten_by'] else '':>5}")
    unplay = [r["name"] for r in R.values() if r["play"] == "UNPLAYABLE"]
    print("  UNPLAYABLE human starts: " + (", ".join(unplay) or "none"))


# ---------- HTML data page ----------
def html_table(title, fiefs, adj):
    R = analyze(fiefs, adj)
    rows = []
    pclass = {"PLAYABLE": "g", "hard": "a", "UNPLAYABLE": "r"}
    dclass = {"safe": "g", "revolt->VULN": "a", "VULNERABLE": "r"}
    for f in sorted(fiefs, key=lambda x: (R[x]["play"] != "UNPLAYABLE", R[x]["men"])):
        r = R[f]
        tgt = f"{r['target']} ({r['target_men']})" if r["target"] else "&mdash;"
        rows.append(
            f"<tr><td>{r['name']}</td><td class=n>{r['men']}</td><td class=n>{r['morale']}</td>"
            f"<td class=n>{r['ndeg']}</td><td>{tgt}</td><td class=n>{r['atk_share']}%</td>"
            f"<td>{r['atk']}</td><td class={dclass[r['def_status']]}>{r['def_status']}</td>"
            f"<td class=n>{r['m_safe']}</td>"
            f"<td class=n>{r['human_threats']}</td><td class={pclass[r['play']]}>{r['play']}</td></tr>")
    unplay = [r["name"] for r in R.values() if r["play"] == "UNPLAYABLE"]
    head = ("<tr><th>fief</th><th>men</th><th>morale</th><th>nbrs</th><th>weakest target</th>"
            "<th>atk&nbsp;share</th><th>AI&nbsp;attack?</th><th>AI&nbsp;defense</th><th>m_safe</th>"
            "<th>human&nbsp;threats</th><th>playable?</th></tr>")
    return (f"<h2>{title}</h2>\n<p class=note><b>UNPLAYABLE human starts:</b> "
            f"{', '.join(unplay) or 'none'}.</p>\n<table>\n{head}\n" + "\n".join(rows) + "\n</table>")


def build_html(src):
    parts = [html_table(name, load_fiefs(src / ff), load_adj(src / af))
             for name, ff, af in SCENARIOS]
    return PAGE_TMPL.format(body="\n".join(parts))


PAGE_TMPL = """\
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Starting-Fief Viability — Nobunaga's Ambition (NES)</title>
<style>
 body{{font-family:Georgia,serif;color:#1a1a1a;background:#fbf8f2;line-height:1.6;max-width:1000px;margin:0 auto;padding:48px 28px;}}
 h1{{color:#7a2e2e;}} h2{{color:#7a2e2e;border-bottom:1px solid #ddd6c8;padding-bottom:5px;margin-top:38px;}}
 a{{color:#7a2e2e;}} .lead{{font-size:1.08em;}} .note{{color:#5a534a;font-size:.95em;}}
 table{{border-collapse:collapse;width:100%;font-size:.86em;margin:10px 0 4px;}}
 th,td{{border:1px solid #ddd6c8;padding:4px 8px;text-align:left;}}
 th{{background:#efe7d6;color:#7a2e2e;}} td.n{{text-align:right;}}
 td.g{{background:#dce8d4;}} td.a{{background:#f6eccb;}} td.r{{background:#f3d4d4;font-weight:bold;}}
 .key{{font-size:.9em;color:#5a534a;}} code{{background:#eee;padding:1px 4px;border-radius:3px;}}
 .footer{{margin-top:40px;border-top:1px solid #ddd6c8;padding-top:14px;font-size:.85em;color:#5a534a;}}
</style></head><body>
<p><a href="index.html">&larr; Home</a></p>
<h1>Starting-Fief Viability — who survives the opening</h1>
<p class="lead">Which clans are doomed from turn one? The engine's <b>invade decision is a pure men-count
ratio</b> (<code>fief_men_ratio_pct = 100&middot;men(atk)/(men(atk)+men(def))</code>, <code>$949A</code>) &mdash;
<i>not</i> the 8-stat combat strength, which only resolves who <i>wins</i> a battle once started. Derived
from the bytecode; every number below is computed from the scenario's starting stats.</p>
<p class="key">
<b>AI&nbsp;attack?</b> &mdash; will this fief invade its weakest neighbour under the AI-vs-AI gate
(share&nbsp;&gt;&nbsp;~70% &asymp; <b>2.3&times;</b> the target). <code>INVADES</code> = certain, <code>invades?</code> = rng band.<br>
<b>AI&nbsp;defense</b> / <b>m_safe</b> &mdash; <code>m_safe</code> is the men level at which no neighbour clears
2.3&times; you; <span style="background:#f3d4d4">VULNERABLE</span> = below it now,
<span style="background:#f6eccb">revolt&rarr;VULN</span> = a low-morale revolt (men&nbsp;/2) drops you under it.<br>
<b>human&nbsp;threats</b> / <b>playable?</b> &mdash; against a <b>human</b> the AI uses the harsher
<b>grudge gate</b> (share&nbsp;&gt;&nbsp;47% &asymp; only <b>0.89&times;</b> you), so it attacks at near parity.
"human threats" counts neighbours that clear it; <span style="background:#f3d4d4">UNPLAYABLE</span> = 3+
(swamped even moving first), <span style="background:#f6eccb">hard</span> = 1&ndash;2,
<span style="background:#dce8d4">PLAYABLE</span> = 0.</p>
{body}
<div class="footer">Generated by <code>tools/viability-map.py</code> from the scenario starting stats +
ROM adjacency. See the analysis chapters and the <a href="https://github.com/chrisaacson69/na1-decompiler/wiki">wiki</a>.</div>
</body></html>
"""


def main():
    if "--html" in sys.argv:
        out = Path(sys.argv[sys.argv.index("--html") + 1])
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(build_html(SRC), encoding="utf-8")
        print(f"wrote {out}")
        return
    for name, ff, af in SCENARIOS:
        text_report(name, load_fiefs(SRC / ff), load_adj(SRC / af))


if __name__ == "__main__":
    main()
