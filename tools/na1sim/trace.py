"""One game, season by season, every fief: the board and each of the player's decisions, for stepping
through where the empire stalls (Chris, 2026-11-17: "I want to step through some games").

  py -3.14 -m na1sim.trace FIEF SEED OUT.json [--skill 2] [--years 70] [long_game flags...]

Reuses long_game.one unchanged (the same player, flags and setup), wrapping expand.expand_policy to
record, at each of the player's turns:
  - the board at the start of the season: every fief's owner, men, gold, rice, wealth, loyalty, town,
    output, header, morale;
  - for the fief whose turn it is: its state (SAFE/HUNTABLE/COMING), its own line (own_need), whether
    the economy has topped out (capped), the command it took and which rule took it (attack, assign,
    stage/combine/depot move or send, strike/gate/topped hire, else the reader's season: grow, hire,
    other), and its cheapest target: the men sent to take it and hold it (hold-sized, as #62/#63), the
    line with its own line on top, the shortfall in men, and the gold to close it (hire + the War gold).
The output is one JSON file; `trace_view.html` (or any reader) steps through it.
"""
import argparse
import json

from . import long_game as L, expand as X, memmap as M, loader, deaths

FIELDS = (M.F_MEN, M.F_GOLD, M.F_RICE, M.F_WEALTH, M.F_LOYALTY, M.F_TOWN, M.F_OUTPUT, M.F_HEADER, M.F_MORALE)


def _board(m):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    out = []
    for i in range(n):
        if m.province_ai_state(i) == M.EMPTY:
            out.append(None)
            continue
        f = m.fief(i)
        out.append([m.fief_owner(i)] + [m.r16(f + k) for k in FIELDS] + [int(m.is_capital(i))])
    return out


def _cheapest(m, idx):
    """(target, send, line, short, gold) for the cheapest target to take and hold, or None."""
    me = m.fief_owner(idx)
    f = m.fief(idx)
    men = m.r16(f + M.F_MEN)
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    best = None
    for t in X.targets(m, idx):
        send, line = X._stage_line(m, idx, t, me)
        short = max(0, line - men)
        gold = short * rate // 10 + send
        if best is None or gold < best[4]:
            best = (t, send, line, short, gold)
    return best


def _blockers(m, idx):
    """{target: why no attack on it passes}: ok, no-win (no split of the war cap wins the forecast),
    prize-<state>, other-<fief>-<state>, capital, rice-shield. Each target's least-bad reason."""
    from . import forecast
    me = m.fief_owner(idx)
    order = ["ok", "rice-shield", "capital", "other", "prize", "no-win"]
    out = {}
    for mv in X.candidates(m, idx):
        t = mv[0]
        with forecast.held(m):
            if not X.player_war(m, idx, *mv):
                why = "no-win"
            else:
                st = X.empire(m, me)
                tol = X.RANK[X.tolerance(m, me)]
                bad = [(i, s) for i, s in st.items() if X.RANK[s] > (tol if i == t else 0)]
                fh = m.fief(idx)
                if any(i == t for i, _ in bad):
                    why = "prize-" + st[t]
                elif bad:
                    why = "other-%d-%s" % bad[0]
                elif not X.capital_ok(m, me):
                    why = "capital"
                elif m.r16(fh + M.F_RICE) < m.r16(fh + M.F_MEN):
                    why = "rice-shield"
                else:
                    why = "ok"
        k = lambda w: order.index(w.split("-")[0] if not w.startswith("rice") else "rice-shield")
        if t not in out or k(why) < k(out[t]):
            out[t] = why
    for t in X.targets(m, idx):
        out.setdefault(t, "no-cap" if not X.war_cap(m, idx) else "no-min")
    return out


def _act(logs0, logs1, f0, f1):
    """Which rule took the turn, from the logs that grew and the fief's own change."""
    names = ("attack", "assign", "stage", "combine", "depot", "hire")
    grew = {k: logs1[k] - logs0[k] for k in names}
    if grew["attack"]:
        return "attack", None
    if grew["assign"]:
        return "assign", None
    if grew["stage"]:
        return "stage", None
    if grew["combine"]:
        return "combine", None
    if grew["depot"]:
        return "depot", None
    if grew["hire"]:
        tag = X.HIRES[-1][3] if len(X.HIRES[-1]) > 3 else None
        return "hire", tag if isinstance(tag, str) else "topped"
    men, wealth, loyalty, town, output = (f1[k] - f0[k] for k in (0, 3, 4, 5, 6))
    if men > 0:
        return "hire", "capital/reader"
    if wealth > 0 or loyalty > 0 or town > 0 or output > 0:
        return "grow", None
    return "other", None


def record(job):
    seasons = []
    cur = {}
    orig = X.expand_policy

    def lens():
        return dict(attack=len(X.LOG), assign=len(X.ASSIGNS), stage=sum(1 for e in X.STAGE_LOG if e[2] in ("move", "send", "hire")),
                    combine=len(X.COMBINE_LOG), depot=len(X.DEPOT_LOG), hire=len(X.HIRES))

    def wrapped(m, idx, rng):
        key = (m.r16(M.CURRENT_GAME_YEAR), m.season)
        if cur.get("key") != key:
            cur["key"] = key
            cur["row"] = dict(y=key[0], s=key[1], board=_board(m), turns={})
            seasons.append(cur["row"])
        me = m.fief_owner(idx)
        f = m.fief(idx)
        f0 = [m.r16(f + k) for k in FIELDS]
        tgt = _cheapest(m, idx)
        info = dict(state=X.fief_state(m, idx), need=X.own_need(m, idx), capped=bool(X.capped(m, idx)),
                    allsafe=all(s == X.SAFE for s in X.empire(m, me).values()), tgt=tgt)
        if info["allsafe"] and m.season in X.SEASONS:
            info["block"] = _blockers(m, idx)
            info["warcap"] = X.war_cap(m, idx)
        l0 = lens()
        nconq = len(X.CONQ)
        orig(m, idx, rng)
        f1 = [m.r16(f + k) for k in FIELDS]
        act, _ = _act(l0, lens(), f0, f1)
        info["act"] = act
        if act == "hire":
            info["tag"] = X.HIRES[-1][3] if len(X.HIRES) and l0["hire"] < len(X.HIRES) else "capital/reader"
            if not isinstance(info["tag"], str):
                info["tag"] = "topped"
        if act == "attack" and len(X.CONQ) > nconq:
            c = X.CONQ[-1]
            info["war"] = dict(tgt=c[3], men=c[4], won=c[5], prize=c[6])
        if act == "stage":
            e = [x for x in X.STAGE_LOG if x[2] in ("move", "send", "hire")][-1]
            info["tag"] = e[2]
            info["to"] = e[4]
        if act in ("depot", "combine"):
            e = (X.DEPOT_LOG if act == "depot" else X.COMBINE_LOG)[-1]
            info["tag"] = e[3]
            info["to"] = e[4]
        info["after"] = f1
        cur["row"]["turns"][idx] = info

    X.expand_policy = wrapped
    try:
        res = L.one(job)
    finally:
        X.expand_policy = orig
    return res, seasons


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fief", type=int)
    ap.add_argument("seed", type=int)
    ap.add_argument("out")
    ap.add_argument("--skill", type=int, default=2)
    ap.add_argument("--years", type=int, default=70)
    ap.add_argument("--strike", type=int, default=8)
    ap.add_argument("--stage", type=int)
    ap.add_argument("--combine", type=int)
    ap.add_argument("--capital-first", type=int)
    a = ap.parse_args()
    job = (a.fief, a.seed, a.years, None, None, None, 0, None, a.skill, False, None, 0, None, None, [],
           a.strike, 100, 1, None, None, a.combine, a.stage, a.capital_first)
    res, seasons = record(job)
    fief, seed, fatal, yearly = res[:4]
    provs = {p.idx: getattr(p, "name", str(p.idx)) for p in loader.load_provinces()}
    from . import setup
    m = setup.build_board(skill=a.skill, seed=a.seed, player_fief=a.fief)
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    m_nb = {i: [b for b in m.neighbor_rows.get(i, []) if b < n] for i in range(n)}
    out = dict(fief=fief, seed=seed, skill=a.skill, flags=dict(strike=a.strike, stage=a.stage, combine=a.combine, capital_first=a.capital_first),
               fatal=fatal, unified=L.unified_year(yearly), player=m.fief_owner(a.fief),
               names=[provs.get(i, str(i)) for i in range(n)], clans=deaths.NAMES,
               neighbors=m_nb, fields=["owner", "men", "gold", "rice", "wealth", "loyalty", "town", "output",
                                       "header", "morale", "capital"],
               seasons=seasons)
    json.dump(out, open(a.out, "w"), separators=(",", ":"), default=str)
    print(f"{provs.get(fief)} seed {seed} skill {a.skill}: {len(seasons)} seasons, unified {out['unified']}, fatal {fatal}")


if __name__ == "__main__":
    main()
