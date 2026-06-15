#!/usr/bin/env python3
"""
viability-map.py — starting-fief invasion viability ("who gets eaten turn 1").

Grounds the deterrence-frontier thesis (synthesis-frontier #32). At game start
every fief is its own daimyo, so ALL adjacencies are hostile (no possession
check). Each AI fief scans its neighbours, picks the weakest by men, and invades
iff the men-share check passes. We treat ALL fiefs as AI (no human), so the
AI-vs-AI threshold applies:

  share(atk,tgt) = floor(100*men(atk)/(men(atk)+men(tgt)))      # math32_2arg / $939D
  attack iff  share - 10 - rng(0..2*const_two) > 60   (+1% random; ignored here)
    -> share > 72  : INVADES (clears even rng=2)
    -> 70 < s <= 72: invades?  (rng-dependent band)
    -> share <= 70 : safe (1% fluke only)

Stage-2 logistics ($9046): attack_budget = min(2*rice, men, gold); the attacker
also aborts if min(tgt.rice, tgt.men) > attack_budget. We flag that too.

Run:  py nobunaga/tools/viability-map.py
"""
import re
from pathlib import Path

SRC = Path(__file__).resolve().parent.parent


def load_fiefs(path):
    fiefs = {}
    for ln in path.read_text(encoding="utf-8").splitlines():
        p = ln.split()
        if len(p) < 15 or not p[0].isdigit():
            continue
        idx = int(p[0])
        name = " ".join(p[1:-13])
        gold, rice, men = int(p[-12]), int(p[-9]), int(p[-4])
        fiefs[idx] = dict(name=name, gold=gold, rice=rice, men=men)
    return fiefs


def load_adj(path):
    # Two formats: 17-fief has "N: ... [hex]" on one line; 50-fief has a
    # "N Name : ..." header then a separate "raw: [hex]" line. Track current fief.
    adj = {}
    cur = None
    for ln in path.read_text(encoding="utf-8").splitlines():
        hm = re.search(r"\[([0-9A-Fa-f ]+)\]", ln)
        nm = re.match(r"\s*(\d+)[\s:]", ln)
        if nm and "raw:" not in ln:
            cur = int(nm.group(1)) - 1                   # leading number is 1-based
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


def verdict(s):
    if s > 72:
        return "INVADES"
    if s > 70:
        return "invades?"
    return "-"


def analyze(fiefs, adj):
    rows = {}
    for f, fd in fiefs.items():
        nbrs = [n for n in adj.get(f, []) if n in fiefs]
        if not nbrs:
            rows[f] = dict(target=None, share=0, v="(no neighbours)", logi=True)
            continue
        tgt = min(nbrs, key=lambda n: fiefs[n]["men"])
        s = share(fd["men"], fiefs[tgt]["men"])
        budget = min(2 * fd["rice"], fd["men"], fd["gold"])
        logi = budget >= 5 and min(fiefs[tgt]["rice"], fiefs[tgt]["men"]) <= budget
        rows[f] = dict(target=tgt, share=s, v=verdict(s), logi=logi, budget=budget)
    # patsy: who is actually targeted-and-attacked this turn
    attacked = {}
    for f, r in rows.items():
        if r["target"] is not None and r["v"] != "-" and r["logi"]:
            attacked.setdefault(r["target"], []).append(f)
    # latent exposure: how many neighbours could clear >70 vs me if they targeted me
    latent = {}
    for f in fiefs:
        latent[f] = [n for n in adj.get(f, []) if n in fiefs and share(fiefs[n]["men"], fiefs[f]["men"]) > 70]
    return rows, attacked, latent


def report(title, fief_path, adj_path):
    fiefs = load_fiefs(fief_path)
    adj = load_adj(adj_path)
    rows, attacked, latent = analyze(fiefs, adj)
    print(f"\n===== {title} : {len(fiefs)} fiefs =====")
    print(f"{'#':>3} {'fief':<12} {'men':>4} {'nbrs':>4}  {'weakest target':<16} {'share':>5}  {'verdict':<9} {'logi':<4} {'eaten-by':>8} {'latent':>6}")
    print("-" * 96)
    for f in sorted(fiefs, key=lambda x: fiefs[x]["men"]):
        r = rows[f]
        tgt = f"{fiefs[r['target']]['name']}({fiefs[r['target']]['men']})" if r["target"] is not None else "-"
        eat = len(attacked.get(f, []))
        lat = len(latent.get(f, []))
        logi = "" if r["v"] == "—" or r.get("logi", True) else "BLK"
        print(f"{f:>3} {fiefs[f]['name']:<12} {fiefs[f]['men']:>4} {len(adj.get(f,[])):>4}  "
              f"{tgt:<16} {r['share']:>4}%  {r['v']:<9} {logi:<4} "
              f"{('<-'+str(eat)) if eat else '':>8} {lat:>6}")
    invaders = [f for f in fiefs if rows[f]["v"] != "-" and rows[f].get("logi", True) and rows[f]["target"] is not None]
    patsies = sorted(attacked, key=lambda t: -len(attacked[t]))
    print(f"\n  aggressors turn-1 (clear threshold + logistics): {len(invaders)}/{len(fiefs)}"
          f"  -> {', '.join(fiefs[f]['name'] for f in invaders) or 'none'}")
    patsy_str = ", ".join("{}(x{})".format(fiefs[t]["name"], len(attacked[t])) for t in patsies)
    print("  patsies (attacked turn-1): " + (patsy_str or "none"))


if __name__ == "__main__":
    report("17-FIEF", SRC / "17fief.txt", SRC / "adjacency.txt")
    report("50-FIEF", SRC / "50Fief.txt", SRC / "adjacency-50.txt")
