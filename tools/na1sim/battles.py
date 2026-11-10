"""The battle harness: save the start of every battle the human defends, then replay it.

Whole games are a slow way to measure a combat policy: 300 seeds of Saito give about 360 battles,
and every other decision in the game rides along. This module cuts the battle out. `capture` runs
the games (deaths.play, so the same games #41/#42 measured) and pickles the machine at the entry of
`tactical.run_tactical_battle` whenever the defender is a human fief. `replay` runs one saved start
again; `verify` checks that a plain replay reproduces the captured battle bit for bit (outcome,
memory and both RNGs afterwards) before any policy is tried on it.

A START is the whole sim state at battle entry: the Memory (work RAM, the battle RNG `m.rng`, the
neighbour rows and the Python-side extras) plus the game RNG the driver passes for the conquest.
The record is self-contained, so a battle generator can later mint the same records without a
game behind them (Chris, 2026-11-10: the 3-year games make realistic battles; random ones next).

Run from tools/:  py -3.14 -m na1sim.battles capture --fief 8 --skill 1 --years 3
                  py -3.14 -m na1sim.battles verify  _battles/<file>.pkl.gz
                  py -3.14 -m na1sim.battles summary _battles/<file>.pkl.gz
"""
import argparse
import collections
import gzip
import hashlib
import pickle
import random
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

from . import memmap as M, policy, tactical as T

OUT = Path(__file__).resolve().parent.parent / "_battles"
REBELS = 50                     # spawn_uprising_force puts the rebels in province slot 50
_ORIG = T.run_tactical_battle   # the engine's own driver, kept unwrapped for replay
_SINK = None                    # the list a capturing process appends to (None: not capturing)
_GAME = {}                      # the game the captured battles come from (seed, year, season)


def _is_human_defence(m):
    return m.province_ai_state(m.defending) == M.PLAYER_DIRECT


def fingerprint(m, rng):
    """Everything a battle can leave behind: memory and both RNGs."""
    h = hashlib.sha1(bytes(m.m))
    h.update(repr(m.rng.getstate()).encode())
    h.update(repr(rng.getstate()).encode())
    return h.hexdigest()


def held(m, rec):
    """The defence held: the fief has the owner it had at battle entry (a retreat, a conquest and a
    rebel daimyo all change it; the engine's own winner flag names the DEFENDING province when the
    attacker wins, apply_conquest_outcome $E03C)."""
    return m.fief_owner(rec["defender"]) == rec["def_owner"] and m.province_ai_state(rec["defender"]) != M.EMPTY


def describe(m):
    """Battle-entry facts for slicing results: who attacks, with what, and how long it can eat."""
    a, d = m.side_resource_ptr(0), m.fief(m.defending)
    men, rice = m.r16(a + M.SR_MEN), m.s16(a + M.SR_RICE)
    return dict(attacker=m.selected, attacker_owner=m.fief_owner(m.selected) if m.selected != REBELS else REBELS,
                defender=m.defending, def_owner=m.fief_owner(m.defending), kind="rebels" if m.selected == REBELS else "invasion",
                atk_men=men, atk_rice=rice, atk_gold=m.r16(a + M.SR_GOLD),
                atk_days=rice * 30 // men if men else 99,      # consume_daily_battle_rice: men/30 a day
                def_men=m.r16(d + M.F_MEN), def_rice=m.r16(d + M.F_RICE), def_gold=m.r16(d + M.F_GOLD),
                def_morale=m.r16(d + M.F_MORALE))


def _capturing(m, rng):
    """run_tactical_battle, recording a human defence: the start, then what the engine made of it."""
    if _SINK is None or not _is_human_defence(m):
        return _ORIG(m, rng)
    from . import deaths
    rec = dict(_GAME, year=deaths.LOG.year if deaths.LOG else 0, season=getattr(m, "season", 0), **describe(m), opening=dict(policy.OPENING),
               start=pickle.dumps((m, rng), protocol=pickle.HIGHEST_PROTOCOL))
    rec["outcome"] = _ORIG(m, rng)
    rec["won"] = held(m, rec)
    rec["after"] = fingerprint(m, rng)
    _SINK.append(rec)
    return rec["outcome"]


def replay(rec, opening=None):
    """Run a saved start again -> (outcome, defender won, fingerprint, the Memory afterwards).
    `opening` overrides policy.OPENING knobs on top of the captured ones (restored after)."""
    m, rng = pickle.loads(rec["start"])
    saved = dict(policy.OPENING)
    policy.OPENING.update(rec["opening"])
    policy.OPENING.update(opening or {})
    try:
        outcome = _ORIG(m, rng)
    finally:
        policy.OPENING.clear()
        policy.OPENING.update(saved)
    return outcome, held(m, rec), fingerprint(m, rng), m


# ---------------------------------------------------------------------------- capture
def _capture_chunk(job):
    global _SINK
    fief, s0, s1, years, skill, tail, opening = job
    from . import deaths, reaction
    T.run_tactical_battle = _capturing          # game.py reads T.run_tactical_battle at call time
    policy.OPENING.update(opening)
    pol = {"reaction": reaction.reaction_policy, "reader": reaction.reader_policy}.get(tail, policy.expand_policy)
    out = []
    _SINK = out
    for seed in range(s0, s1):
        _GAME.clear()
        _GAME.update(seed=seed, fief=fief, skill=skill, tail=tail)
        deaths.play(fief, seed, years, ("auto",), tail=pol, skill=skill)
    _SINK = None
    return out


def capture(fief, first, seeds, years, skill, tail, opening, procs=6):
    jobs = [(fief, s, min(s + 25, first + seeds), years, skill, tail, opening)
            for s in range(first, first + seeds, 25)]
    recs = []
    with ProcessPoolExecutor(procs) as ex:
        for part in ex.map(_capture_chunk, jobs):
            recs.extend(part)
    return recs


def save(recs, path):
    path.parent.mkdir(parents=True, exist_ok=True)
    with gzip.open(path, "wb") as f:
        pickle.dump(recs, f, protocol=pickle.HIGHEST_PROTOCOL)


def load(path):
    with gzip.open(path, "rb") as f:
        return pickle.load(f)


# ---------------------------------------------------------------------------- verify / summary
def _verify_one(rec):
    outcome, won, after, _ = replay(rec)
    return outcome == rec["outcome"] and won == rec["won"] and after == rec["after"]


def verify(recs, procs=6):
    with ProcessPoolExecutor(procs) as ex:
        ok = list(ex.map(_verify_one, recs, chunksize=16))
    bad = [(r["seed"], r["attacker"]) for r, k in zip(recs, ok) if not k]
    print(f"replay reproduces {sum(ok)} of {len(recs)} battles bit for bit")
    if bad:
        print("diverged (seed, attacker):", bad[:20])
    return not bad


def summary(recs):
    kinds = collections.Counter(r["kind"] for r in recs)
    print(f"{len(recs)} battles from {len({r['seed'] for r in recs})} games: " +
          ", ".join(f"{k} {n} (won {sum(r['won'] for r in recs if r['kind'] == k)})" for k, n in kinds.items()))
    inv = [r for r in recs if r["kind"] == "invasion"]
    print("invasions by attacker men:  band  won / battles")
    for lo, hi in ((0, 40), (40, 60), (60, 80), (80, 120), (120, 9999)):
        b = [r for r in inv if lo <= r["atk_men"] < hi]
        print(f"  {lo:>3}-{hi if hi < 9999 else '':<4} {sum(r['won'] for r in b):4} / {len(b)}")
    print("invasions by attacker days of food:")
    for lo, hi in ((0, 10), (10, 20), (20, 30), (30, 9999)):
        b = [r for r in inv if lo <= r["atk_days"] < hi]
        print(f"  {lo:>3}-{hi if hi < 9999 else '':<4} {sum(r['won'] for r in b):4} / {len(b)}")
    print("outcome codes:", dict(sorted(collections.Counter(r["outcome"] for r in recs).items())))


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="verb", required=True)
    c = sub.add_parser("capture")
    c.add_argument("--fief", type=int, default=8)
    c.add_argument("--first", type=int, default=3000)
    c.add_argument("--seeds", type=int, default=300)
    c.add_argument("--years", type=int, default=3)
    c.add_argument("--skill", type=int, default=1)
    c.add_argument("--tail", default="expand", help="expand, reaction or reader")
    c.add_argument("--opening", default="", help="policy.OPENING overrides: no_retreat=1")
    c.add_argument("--out")
    for verb in ("verify", "summary"):
        sub.add_parser(verb).add_argument("path")
    a = ap.parse_args()
    if a.verb == "capture":
        opening = {k: int(v) for k, v in (kv.split("=") for kv in a.opening.split(",") if kv)}
        recs = capture(a.fief, a.first, a.seeds, a.years, a.skill, a.tail, opening)
        path = Path(a.out) if a.out else OUT / f"f{a.fief}-k{a.skill}-y{a.years}-{a.tail}-s{a.first}x{a.seeds}.pkl.gz"
        save(recs, path)
        print(f"saved {len(recs)} battle starts -> {path}")
        summary(recs)
    elif a.verb == "verify":
        raise SystemExit(0 if verify(load(Path(a.path))) else 1)
    else:
        summary(load(Path(a.path)))


if __name__ == "__main__":
    main()
