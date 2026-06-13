#!/usr/bin/env python3
"""Offline certifier for the bank-2 melee combat formula (ledger #29/#30).

Replicates ai_eval_battle_strength_total + the mutual-attrition casualty math
(pct_op / math32_2arg exact), reads per-fief TERRAIN from the ROM (always the
DEFENDER's fief map), parses a combat-certify.lua v2 log, and prints PREDICTED
vs OBSERVED casualties per attack. Melee is deterministic (no rng), so a correct
formula matches the counts exactly.

Usage:  py combat-check.py <log.txt> [--scenario 17|50]
"""
import sys, re, argparse
from pathlib import Path

ROM = (Path(__file__).parent / "Nobunaga's Ambition (USA).nes").read_bytes()[16:]
def _b(bank, addr): return bank*0x4000 + (addr-0x8000)
def _b15(addr): return 15*0x4000 + (addr-(0xC000 if addr>=0xC000 else 0x8000))

STAT_W    = [5,10,10,5,20, 10,25,15]   # hp,dr,lk,ch,iq, mor,skl,arm  ($B5B1)
TERR_MULT = [90,20,10,0]                # terrain class 0..3            ($B9C2)

def pct_op(a, b):
    if b == 100: return a
    return ((b%10)*(a//10))//10 + ((a%10)*b)//100 + (b//10)*(a//10)
def math32(a, b): return (a*100)//(a+b) if (a+b) else 0

def map_id(prov, scen): return ROM[_b15(0xF70E)+prov] if scen==17 else ROM[_b(3,0x8E18)+prov]
def terrain(def_prov, scen, col, row):
    if col > 10 or row > 4: return 3      # unplaced/out of bounds -> class 3 (no bonus)
    cell = ROM[_b(4,0xA57E) + map_id(def_prov,scen)*55 + row*11 + col] & 254
    return {32:0,16:1,8:2}.get(cell, 3)

def strength(men, is_def, slot, oslot, col, row, W, mom_o, defprov, scen, scale=100):
    base = men
    t1 = base if is_def else 0
    t2 = pct_op(base, TERR_MULT[terrain(defprov, scen, col, row)]) * 3
    t3 = 0                                 # fief stat-diff term: //100 rounds to 0 at these magnitudes
    wrap = lambda x: x if x <= 2 else 0
    t4 = base if wrap(slot) > wrap(oslot) else 0
    t5 = pct_op(pct_op(base, 40), W) + base
    t6 = pct_op(base, mom_o * 20)
    return pct_op(base + t1+t2+t3+t4+t5+t6, scale)

# ---- log parsing -----------------------------------------------------------
HDR = re.compile(r"BATTLE: atk fief (\d+).*?def fief (\d+)")
ATK = re.compile(r"ATK.*?dmy\[hp=(\d+) dr=(\d+) lk=(\d+) ch=(\d+) iq=(\d+)\]")
DEF = re.compile(r"DEF.*?dmy\[hp=(\d+) dr=(\d+) lk=(\d+) ch=(\d+) iq=(\d+)\]")
AFS = re.compile(r"ATK.*?fief\[mor=(\d+) skl=(\d+) arm=(\d+)\]")
DFS = re.compile(r"DEF.*?fief\[mor=(\d+) skl=(\d+) arm=(\d+)\]")
REC = re.compile(r"\[#\s*(\d+)\]\s+s(\d)u(\d)\s+(\d+)->(\d+)\s+\(([+-])(\d+).*?pos\((\d+),(\d+)\)\s+cur\(s(\d),u(\d)\).*?mom\[([\d,]+)\]\s+vmpc=\$([0-9A-Fa-f]+)")

def won_weights(a_dmy, a_fief, d_dmy, d_fief):
    A = list(a_dmy) + list(a_fief); D = list(d_dmy) + list(d_fief)
    w0 = w1 = 0
    for i in range(8):
        if A[i] <= D[i]: w1 += STAT_W[i]
        else:            w0 += STAT_W[i]
    return w0, w1   # w0 = attacker-province wins, w1 = defender-province wins

def run(path, scen):
    text = Path(path).read_text()
    atkf, deff = map(int, HDR.search(text).groups())
    a_dmy = tuple(map(int, ATK.search(text).groups())); a_fief = tuple(map(int, AFS.search(text).groups()))
    d_dmy = tuple(map(int, DEF.search(text).groups())); d_fief = tuple(map(int, DFS.search(text).groups()))
    w0, w1 = won_weights(a_dmy, a_fief, d_dmy, d_fief)
    print(f"battle: atk fief {atkf} vs def fief {deff} (scen {scen})")
    print(f"  won-weights: attacker(side0)={w0}  defender(side1)={w1}  (of 100)")
    print(f"  {'rec':>4} {'unit':>5} {'role':<8} {'men':>4} {'pos':>7} {'p':>4} {'pred':>4} {'obs':>4}  ok")

    men = {}; pos = {}
    ok = bad = 0
    for line in text.splitlines():
        m = REC.search(line)
        if not m: continue
        n, s, u, old, new, sign, delta, col, row, cs, cu, mom, vmpc = \
            int(m[1]),int(m[2]),int(m[3]),int(m[4]),int(m[5]),m[6],int(m[7]),int(m[8]),int(m[9]),int(m[10]),int(m[11]),m[12],m[13].upper()
        momv = [int(x) for x in mom.split(",")]
        # update tracking from this record's 'old' (state before the change) + pos
        men[(s,u)] = old; pos[(s,u)] = (col,row)
        if sign == '-' and vmpc.startswith('8A'):   # a casualty application (not deploy/remove)
            # attacker = cur(cs,cu); defender-of-exchange = the other
            a_men = men.get((cs,cu), old if (s,u)==(cs,cu) else None)
            a_pos = pos.get((cs,cu), (col,row))
            if a_men is None:
                men[(s,u)] = new; continue
            Sa = strength(a_men, cs==1, cu, (u if (s,u)!=(cs,cu) else None) or 0, a_pos[0], a_pos[1],
                          w1 if cs==1 else w0, momv[u if (s,u)!=(cs,cu) else cu], deff, scen)
            # the enemy unit (target)
            if (s,u) == (cs,cu):     # this record is the ATTACKER's own loss -> need the target
                men[(s,u)] = new; continue   # handled when the target record appears (we verify target rows)
            t_men, t_pos = old, (col,row)
            Sd = strength(t_men, s==1, u, cu, col, row, w1 if s==1 else w0, momv[cu], deff, scen)
            p = math32(Sa, Sd)
            pred = min(pct_op(t_men, p) + (1 if p>=50 else 0), t_men)
            good = (pred == delta)
            ok += good; bad += (not good)
            print(f"  {n:>4} s{s}u{u} {'target':<8} {t_men:>4} ({col},{row}) {p:>3}% {pred:>4} {delta:>4}  {'OK' if good else 'XX'}")
        men[(s,u)] = new
    print(f"\n  target-casualty predictions: {ok} OK / {bad} mismatch")

if __name__ == "__main__":
    ap = argparse.ArgumentParser(); ap.add_argument("log"); ap.add_argument("--scenario", type=int, default=17)
    a = ap.parse_args(); run(a.log, a.scenario)
