#!/usr/bin/env python3
"""Offline analyzer for the combat-certify.lua v7 thin recorder ("log now, calc later").

The recorder's write-address label desyncs from the actual men-array change during
combat bursts, so this analyzer trusts ONLY the full men[10]/col[10]/row[10] arrays:
it DIFFs consecutive snapshots to find every casualty/gain, reads terrain from the
ROM at each unit's logged position, checks per-side conservation (the mystery +N),
pairs melee exchanges, and scores each against flat / sym / def terrain models.

Usage:  py combat-check.py <log.txt>
"""
import sys
from pathlib import Path

ROM = (Path(__file__).parent / "Nobunaga's Ambition (USA).nes").read_bytes()[16:]
def _b(bank, addr): return bank*0x4000 + (addr - 0x8000)
def _b15(addr): return 15*0x4000 + (addr - 0xC000)
STAT_W = [5,10,10,5,20, 10,25,15]
TERR_MULT = {0:90, 1:20, 2:10, 3:0}
TNAME = {0:"CAS", 1:"for", 2:"TWN", 3:"."}

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
    return min(pct_op(men, pct) + (1 if pct >= 50 else 0), men)

def Sterms(men, is_def, slot, oslot, W, mom_o, tclass, use_terr):
    """Return (total_S, {term: value}) — every factor broken out."""
    t = {
        "base":  men,
        "home":  men if is_def else 0,                          # DEFENDER home bonus (situational)
        "rank":  men if wrap(slot) > wrap(oslot) else 0,        # unit-type ladder Rifles>Cav>Inf (situational)
        "stat8": pct_op(pct_op(men, 40), W) + men,              # the 8-factor term (men + men*0.4*W/100)
        "mom":   pct_op(men, mom_o * 20),                       # momentum +20%/prior contest (situational)
        "terr":  pct_op(men, TERR_MULT[tclass]) * 3 if use_terr else 0,  # DEFENSIVE terrain (situational)
    }
    return sum(t.values()), t

def Sfn(*a):
    return Sterms(*a)[0]

def analyze(path):
    B = None; rows = []
    for ln in Path(path).read_text().splitlines():
        ln = ln.strip()
        if ln.startswith("B,"):
            B = list(map(int, ln[2:].split(",")))
        elif ln.startswith("W,"):
            p = ln[2:].split(",")
            rows.append(dict(seq=int(p[0]), vmpc=p[1].lstrip("$").upper(), cs=int(p[2]), cu=int(p[3]),
                men=[int(x) for x in p[4:14]], col=[int(x) for x in p[14:24]], row=[int(x) for x in p[24:34]],
                mom=[int(x) for x in p[34:39]], atkMor=int(p[39]), defMor=int(p[40])))
    if not B: print("no B header line"); return
    scen, atk, atkown, dfn, dfnown = B[0:5]
    A8 = B[8:13] + B[5:8]; D8 = B[16:21] + B[13:16]      # hp,dr,lk,ch,iq,mor,skl,arm
    w0 = sum(STAT_W[i] for i in range(8) if A8[i] >  D8[i])
    w1 = sum(STAT_W[i] for i in range(8) if A8[i] <= D8[i])
    print(f"battle: atk fief {atk}(own {atkown}) vs def fief {dfn}(own {dfnown}) scen {scen}  won-wt atk={w0} def={w1}")
    SN = ["hp","dr","lk","ch","iq","mor","skl","arm"]
    print("  8-factor contest (stat: atk vs def -> winner xWeight):")
    print("   " + "  ".join(f"{SN[i]}:{A8[i]}v{D8[i]}{'A' if A8[i]>D8[i] else 'D'}{STAT_W[i]}" for i in range(8)))

    # dedup consecutive identical men arrays, then diff to find real changes
    kept = []
    for r in rows:
        if not kept or r["men"] != kept[-1]["men"]:
            kept.append(r)
    prev = [0]*10
    events = []   # each real change: unit, delta, before, attacker(cs,cu), pos, terr, vmpc, mom, line
    for r in kept:
        for u in range(10):
            d = r["men"][u] - prev[u]
            if d != 0:
                events.append(dict(u=u, d=d, before=prev[u], cs=r["cs"], cu=r["cu"],
                    col=r["col"][u], row=r["row"][u], vmpc=r["vmpc"], mom=r["mom"], r=r))
        prev = r["men"]

    # conservation: classify gains
    print("\n-- gains (mystery +N) - conservation -")
    for e in events:
        if e["d"] > 0 and not e["vmpc"].startswith("92"):   # gain outside deploy-splitter
            tot = sum(e["r"]["men"][(e["u"]//5)*5:(e["u"]//5)*5+5])
            leader = " <- COMMANDER (slot0): bribe-defection signature" if e["u"]%5 == 0 else ""
            print(f"  s{e['u']//5}u{e['u']%5} +{e['d']} vmpc${e['vmpc']} sideTot={tot}{leader}")

    cas_ev = [e for e in events if e["d"] < 0 and e["vmpc"].startswith("9D")]
    print(f"\n-- {len(cas_ev)} casualties; exchanges scored flat / sym / def --")
    # pair: consecutive casualties sharing the attacker (cs,cu) = one exchange (target loss + cur own loss)
    i = 0
    while i < len(cas_ev):
        grp = [cas_ev[i]]; j = i+1
        while j < len(cas_ev) and cas_ev[j]["cs"]==cas_ev[i]["cs"] and cas_ev[j]["cu"]==cas_ev[i]["cu"]:
            grp.append(cas_ev[j]); j += 1
        cs, cu = grp[0]["cs"], grp[0]["cu"]; curU = cs*5+cu
        tgt = next((g for g in grp if g["u"]//5 != cs), None)   # target = OPPOSITE side from cur
        own = next((g for g in grp if g["u"] == curU), None)
        if tgt:
            tcCur = terr_class(dfn, scen, grp[0]["r"]["col"][curU], grp[0]["r"]["row"][curU])
            tcTgt = terr_class(dfn, scen, tgt["col"], tgt["row"])
            cur_men = own["before"] if own else grp[0]["r"]["men"][curU]
            tgt_men = tgt["before"]
            Wc = w1 if cs==1 else w0; Wt = w1 if tgt["u"]//5==1 else w0
            momC, momT = tgt["mom"][tgt["u"]%5], tgt["mom"][cu]
            lowfi = cur_men <= 2 or tgt_men <= 2
            obsT = -tgt["d"]; obsC = -own["d"] if own else None
            hdr = (f"  EXCH cur(s{cs}u{cu})@{TNAME[tcCur]} x{cur_men} -> s{tgt['u']//5}u{tgt['u']%5}@{TNAME[tcTgt]} x{tgt_men}"
                   f" | obs tgt-{obsT}" + (f" own-{obsC}" if obsC is not None else "") + ("  [LOW-FI]" if lowfi else ""))
            print(hdr)
            for model in ("flat","sym","def"):
                if model == "def":
                    pT = math32(Sfn(cur_men,cs==1,cu,tgt['u']%5,Wc,momC,tcCur,False), Sfn(tgt_men,tgt['u']//5==1,tgt['u']%5,cu,Wt,momT,tcTgt,True))
                    pC = math32(Sfn(cur_men,cs==1,cu,tgt['u']%5,Wc,momC,tcCur,True),  Sfn(tgt_men,tgt['u']//5==1,tgt['u']%5,cu,Wt,momT,tcTgt,False))
                else:
                    ut = model == "sym"
                    p = math32(Sfn(cur_men,cs==1,cu,tgt['u']%5,Wc,momC,tcCur,ut), Sfn(tgt_men,tgt['u']//5==1,tgt['u']%5,cu,Wt,momT,tcTgt,ut))
                    pT = pC = p
                pt = cas(tgt_men, pT); pc = cas(cur_men, 100-pC)
                mk = lambda pred,obs: "OK" if (obs is not None and pred==obs) else "x"
                print(f"      {model:>4}: tgt-{pt} {mk(pt,obsT)}" + (f"  own-{pc} {mk(pc,obsC)}" if obsC is not None else ""))
            # term breakdown under the confirmed DEF model (cur attacks w/o terrain; tgt defends w/ terrain)
            Sc, tc = Sterms(cur_men, cs==1, cu, tgt['u']%5, Wc, momC, tcCur, False)
            St, tt = Sterms(tgt_men, tgt['u']//5==1, tgt['u']%5, cu, Wt, momT, tcTgt, True)
            fmt = lambda d: " ".join(f"{k}={v}" for k,v in d.items() if v)
            print(f"      terms cur S={Sc} [{fmt(tc)}]")
            print(f"      terms tgt S={St} [{fmt(tt)}]")
        i = j

if __name__ == "__main__":
    if len(sys.argv) < 2: print(__doc__); sys.exit(1)
    analyze(sys.argv[1])
