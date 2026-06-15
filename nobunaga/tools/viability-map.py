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

MORALE_REVOLT = 45          # exact revolt cutoff: square_over_2025 needs morale<45 ($9D86/$9E21)


def revolt_elig_pct(morale):
    """Per-check revolt eligibility from morale: square_roll(morale) passes with
    P=(2024-min(morale,50)^2)/2025; 0 at morale>=45. (Charisma gives a second
    path, not modelled here; per-SEASON chance is this x the ~0.75 uprising
    branch x the handler/variant constants — see appendix-events.md.)"""
    m = min(morale, 50)
    return max(0, (2024 - m * m) * 100 // 2025) if morale < MORALE_REVOLT else 0


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


def budget(d):
    # attacker deployable force cap ($9046): min(2*rice, men, gold)
    return min(2 * d["rice"], d["men"], d["gold"])


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
        # human playability: a neighbour is a REAL turn-1 threat only if it clears
        # BOTH gates — stage-1 grudge men-share (>47%, ~0.89x you) AND stage-2
        # logistics ($9046): its gold/rice-capped attack_budget must cover your
        # min(rice,men), or it aborts at commit. (DRIVE/relations skip-gate never
        # fires at start: every daimyo has drive>=50.)
        def_min = min(fd["rice"], fd["men"])
        r["human_threats"] = sum(
            1 for n in nbrs
            if share(fiefs[n]["men"], fd["men"]) > 47
            and budget(fiefs[n]) >= 5
            and def_min <= budget(fiefs[n]))
        r["play"] = ("PLAYABLE" if r["human_threats"] == 0
                     else "hard" if r["human_threats"] <= 2 else "UNPLAYABLE")
        # revolt overlay: if a low-morale revolt (men/2) opens a human threat that
        # isn't there at full strength, the start can still die by RNG (Noto).
        half = fd["men"] // 2
        dmin_h = min(fd["rice"], half)
        rt = sum(1 for n in nbrs
                 if share(fiefs[n]["men"], half) > 47
                 and budget(fiefs[n]) >= 5 and dmin_h <= budget(fiefs[n]))
        r["revolt_threats"] = rt
        # only a real RNG-death risk if morale is low enough to actually revolt.
        # MORALE_REVOLT is approximate, pending the event-trigger walk.
        r["revolt_risk"] = r["human_threats"] == 0 and rt > 0 and fd["morale"] < MORALE_REVOLT
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
        rev = (f"REVOLT&rarr;dies (~{revolt_elig_pct(r['morale'])}% elig)" if r["revolt_risk"]
               else ("&mdash;" if r["human_threats"] else "no"))
        revc = "a" if r["revolt_risk"] else ""
        rows.append(
            f"<tr><td>{r['name']}</td><td class=n>{r['men']}</td><td class=n>{r['morale']}</td>"
            f"<td class=n>{r['ndeg']}</td><td>{tgt}</td><td class=n>{r['atk_share']}%</td>"
            f"<td>{r['atk']}</td><td class={dclass[r['def_status']]}>{r['def_status']}</td>"
            f"<td class=n>{r['m_safe']}</td>"
            f"<td class=n>{r['human_threats']}</td><td class={pclass[r['play']]}>{r['play']}</td>"
            f"<td class={revc}>{rev}</td></tr>")
    unplay = [r["name"] for r in R.values() if r["play"] == "UNPLAYABLE"]
    head = ("<tr><th>fief</th><th>men</th><th>morale</th><th>nbrs</th><th>weakest target</th>"
            "<th>atk&nbsp;share</th><th>AI&nbsp;attack?</th><th>AI&nbsp;defense</th><th>m_safe</th>"
            "<th>human&nbsp;threats</th><th>playable?</th><th>revolt&nbsp;risk</th></tr>")
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
<b>grudge gate</b> (share&nbsp;&gt;&nbsp;47% &asymp; only <b>0.89&times;</b> you). But a neighbour is only a
<i>real</i> threat if it ALSO clears the <b>stage-2 logistics gate</b> (<code>$9046</code>): its gold/rice-capped
<code>attack_budget = min(2&middot;rice, men, gold)</code> must cover your <code>min(rice,men)</code>, or it aborts at
commit. Attacker budgets are gold-capped (~40&ndash;70 at start), so a high-men, well-supplied fief
(e.g. Mikawa) makes most "threats" abort. "human threats" counts neighbours clearing <i>both</i> gates:
<span style="background:#f3d4d4">UNPLAYABLE</span> = 3+, <span style="background:#f6eccb">hard</span> = 1&ndash;2,
<span style="background:#dce8d4">PLAYABLE</span> = 0. (DRIVE/relations skip-gate never fires at start &mdash;
every daimyo has drive&nbsp;&ge;&nbsp;50.)<br>
<b>revolt&nbsp;risk</b> &mdash; a PLAYABLE start can still die by RNG: a troop revolt halves men
(<code>MEN/2</code>) and may open a threat absent at full strength. Revolt eligibility is exact
(<code>$9E21</code>): a fief qualifies when <code>min(morale,50)&sup2; &lt; rng(2025)</code> &mdash; impossible at
<b>morale&nbsp;&ge;&nbsp;45</b>, then rising as <code>(2024&minus;morale&sup2;)/2025</code> ("elig" shown). The per-season
chance is that &times; the ~75% uprising branch &times; handler/variant constants (a low-charisma daimyo adds a
second path). Noto is the case &mdash; safe at 48 men, but morale 23 (&asymp;74% eligible).</p>
{body}
<div class="footer">Generated by <code>tools/viability-map.py</code> from the scenario starting stats +
ROM adjacency. See the analysis chapters and the <a href="https://github.com/chrisaacson69/na1-decompiler/wiki">wiki</a>.</div>
</body></html>
"""


def why(name, fiefs, adj):
    f = next((k for k, v in fiefs.items() if v["name"].lower() == name.lower()), None)
    if f is None:
        return
    fd = fiefs[f]
    dmin = min(fd["rice"], fd["men"])
    print(f"\n  {fd['name']}: men={fd['men']} rice={fd['rice']} gold={fd['gold']} "
          f"-> stage-2 bar min(rice,men)={dmin}")
    for n in adj.get(f, []):
        if n not in fiefs:
            continue
        nd = fiefs[n]
        s = share(nd["men"], fd["men"])
        b = budget(nd)
        g1 = s > 47
        g2 = b >= 5 and dmin <= b
        verdict = "THREAT" if (g1 and g2) else ("blocked@stage2" if g1 else "blocked@stage1")
        print(f"    {nd['name']:<10} men={nd['men']:>3} budget={b:>3}  "
              f"share={s:>2}%{'(>47)' if g1 else '(<=47)':<6}  vs bar {dmin}: {'ok' if g2 else 'abort'}  -> {verdict}")


def main():
    if "--why" in sys.argv:
        name = sys.argv[sys.argv.index("--why") + 1]
        for sc, ff, af in SCENARIOS[:1]:
            why(name, load_fiefs(SRC / ff), load_adj(SRC / af))
        return
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
