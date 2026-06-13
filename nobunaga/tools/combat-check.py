#!/usr/bin/env python3
"""Offline analyzer for the combat-certify.lua v6 thin recorder ("log now, calc later").

Parses the B/W CSV log, reconstructs per-write deltas from the men time-series,
classifies each write (casualty / deploy / gain), checks per-side men conservation
(to explain the mystery +1), pairs melee exchanges, reads terrain from the ROM, and
scores each exchange against THREE terrain models so the data picks the rule:

  flat : no terrain in S
  sym  : terrain added to BOTH units' S (symmetric strength term)
  def  : each unit's OWN terrain boosts its S only when it is the one being hit
         (asymmetric/defensive — can reproduce "deal a lot, take little" on a castle)

Low-fidelity (<=2-man) and deploy-poisoned exchanges are flagged, not trusted.

Usage:  py combat-check.py <log.txt>
"""
import sys, re
from pathlib import Path

ROM = (Path(__file__).parent / "Nobunaga's Ambition (USA).nes").read_bytes()[16:]
def _b(bank, addr): return bank*0x4000 + (addr - 0x8000)
def _b15(addr): return 15*0x4000 + (addr - 0xC000)

STAT_W    = [5,10,10,5,20, 10,25,15]      # hp,dr,lk,ch,iq, mor,skl,arm
TERR_MULT = {0:90, 1:20, 2:10, 3:0}        # class 0=castle 1=forest 2=town 3=plains/imp
TNAME     = {0:"CAS", 1:"for", 2:"TWN", 3:"."}

def pct_op(a, b):
    if b == 100: return a
    return ((b%10)*(a//10))//10 + ((a%10)*b)//100 + (b//10)*(a//10)
def math32(a, b): return (a*100)//(a+b) if (a+b) else 0
def wrap(x): return x if x <= 2 else 0

def map_id(prov, scen): return ROM[_b15(0xF70E)+prov] if scen == 17 else ROM[_b(3,0x8E18)+prov]
def terr_class(defprov, scen, col, row):
    if col > 10 or row > 4: return 3
    cell = ROM[_b(4,0xA57E) + map_id(defprov,scen)*55 + row*11 + col] & 254
    return {32:0, 16:1, 8:2}.get(cell, 3)

def cas(men, pct):
    c = pct_op(men, pct) + (1 if pct >= 50 else 0)
    return min(c, men)

class Battle:
    def __init__(self, b):
        f = list(map(int, b))
        self.scen, self.atk, self.atkown, self.dfn, self.dfnown = f[0:5]
        self.aF = f[5:8];  self.aD = f[8:13]      # atk fief mor/skl/arm ; daimyo hp/dr/lk/ch/iq
        self.dF = f[13:16]; self.dD = f[16:21]
        # won-weights: A = daimyo(hp,dr,lk,ch,iq)+fief(mor,skl,arm)
        A = self.aD + self.aF; D = self.dD + self.dF
        self.w0 = sum(STAT_W[i] for i in range(8) if A[i] >  D[i])   # attacker-won
        self.w1 = sum(STAT_W[i] for i in range(8) if A[i] <= D[i])   # defender-won

def S(men, is_def, slot, oslot, W, mom_o, tclass, use_terr):
    s = men
    s += men if is_def else 0
    s += men if wrap(slot) > wrap(oslot) else 0
    s += pct_op(pct_op(men, 40), W) + men
    s += pct_op(men, mom_o * 20)
    if use_terr: s += pct_op(men, TERR_MULT[tclass]) * 3
    return s

def analyze(path):
    lines = Path(path).read_text().splitlines()
    bt = None; writes = []
    for ln in lines:
        ln = ln.strip()
        if ln.startswith("B,"):
            bt = Battle(ln[2:].split(","))
        elif ln.startswith("W,"):
            p = ln[2:].split(",")
            writes.append(dict(seq=int(p[0]), vmpc=p[1].lstrip("$").upper(),
                chS=int(p[2]), chU=int(p[3]), new=int(p[4]), cs=int(p[5]), cu=int(p[6]),
                men=[int(x) for x in p[7:17]],
                chCol=int(p[17]), chRow=int(p[18]), curCol=int(p[19]), curRow=int(p[20]),
                mom=[int(x) for x in p[21:26]], atkMor=int(p[26]), defMor=int(p[27])))
    if not bt:
        print("no B (battle header) line found"); return
    print(f"battle: atk fief {bt.atk}(own {bt.atkown}) vs def fief {bt.dfn}(own {bt.dfnown}) "
          f"scen {bt.scen}  won-wt atk={bt.w0} def={bt.w1}")

    # reconstruct deltas + conservation
    run = [0]*10
    for w in writes:
        w["delta"] = w["new"] - run[w["chS"]*5 + w["chU"]]
        run = list(w["men"])
        w["atkTot"] = sum(w["men"][0:5]); w["defTot"] = sum(w["men"][5:10])

    # classify + report the mystery gains (conservation)
    print("\n-- non-casualty gains (the +N mystery): conservation check --")
    prevA = prevD = None
    for w in writes:
        if w["delta"] > 0 and not w["vmpc"].startswith("92"):   # a gain outside the deploy-splitter
            dA = "" if prevA is None else f"{w['atkTot']-prevA:+d}"
            dD = "" if prevD is None else f"{w['defTot']-prevD:+d}"
            print(f"  seq{w['seq']:>3} s{w['chS']}u{w['chU']} +{w['delta']} vmpc${w['vmpc']}  sideTot Δ(atk {dA}, def {dD})")
        prevA, prevD = w["atkTot"], w["defTot"]

    # pair casualty exchanges (consecutive '-' at $9D, same cur)
    casw = [w for w in writes if w["delta"] < 0 and w["vmpc"].startswith("9D")]
    print(f"\n-- {len(casw)} casualty applications; exchanges scored flat / sym / def --")
    # pre-exchange men: men_before = new - delta
    for w in casw: w["before"] = w["new"] - w["delta"]
    # group consecutive casw sharing cur
    i = 0
    while i < len(casw):
        grp = [casw[i]]; j = i+1
        while j < len(casw) and casw[j]["cs"]==casw[i]["cs"] and casw[j]["cu"]==casw[i]["cu"]:
            grp.append(casw[j]); j += 1
        ex = grp[0]; cs, cu = ex["cs"], ex["cu"]
        tgt = next((g for g in grp if not (g["chS"]==cs and g["chU"]==cu)), None)
        own = next((g for g in grp if g["chS"]==cs and g["chU"]==cu), None)
        if tgt:
            tcCur = terr_class(bt.dfn, bt.scen, ex["curCol"], ex["curRow"])
            tcTgt = terr_class(bt.dfn, bt.scen, tgt["chCol"], tgt["chRow"])
            cur_men, tgt_men = (own["before"] if own else ex["men"][cs*5+cu]), tgt["before"]
            Wc = bt.w1 if cs==1 else bt.w0
            Wt = bt.w1 if tgt["chS"]==1 else bt.w0
            momC, momT = tgt["mom"][tgt["chU"]], tgt["mom"][cu]
            lowfi = (cur_men <= 2 or tgt_men <= 2)
            def predict(model):
                if model == "def":
                    # each unit's own terrain boosts its S only when it is the victim
                    pT = math32(S(cur_men,cs==1,cu,tgt["chU"],Wc,momC,tcCur,False),
                                S(tgt_men,tgt["chS"]==1,tgt["chU"],cu,Wt,momT,tcTgt,True))
                    pC = math32(S(cur_men,cs==1,cu,tgt["chU"],Wc,momC,tcCur,True),
                                S(tgt_men,tgt["chS"]==1,tgt["chU"],cu,Wt,momT,tcTgt,False))
                    return cas(tgt_men, pT), cas(cur_men, 100-pC)
                ut = (model == "sym")
                p = math32(S(cur_men,cs==1,cu,tgt["chU"],Wc,momC,tcCur,ut),
                           S(tgt_men,tgt["chS"]==1,tgt["chU"],cu,Wt,momT,tcTgt,ut))
                return cas(tgt_men, p), cas(cur_men, 100-p)
            obsT, obsC = -tgt["delta"], (-own["delta"] if own else None)
            row = f"  EXCH cur(s{cs}u{cu})@{TNAME[tcCur]} x{cur_men} -> s{tgt['chS']}u{tgt['chU']}@{TNAME[tcTgt]} x{tgt_men} | obs tgt-{obsT}" + (f" own-{obsC}" if obsC is not None else "")
            if lowfi: row += "  [LOW-FI]"
            print(row)
            for model in ("flat","sym","def"):
                pt, pc = predict(model)
                mark = lambda pred,obs: "OK" if (obs is not None and pred==obs) else "x"
                print(f"      {model:>4}: tgt-{pt} {mark(pt,obsT)}" + (f"  own-{pc} {mark(pc,obsC)}" if obsC is not None else ""))
        i = j

if __name__ == "__main__":
    if len(sys.argv) < 2: print(__doc__); sys.exit(1)
    analyze(sys.argv[1])
