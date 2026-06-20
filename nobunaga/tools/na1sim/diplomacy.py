"""Faithful NA1 diplomacy commands.

Player-initiated (cost gold + 1 drive, ~1/const_two success, persists until a war
resets the relation):
  - try_pact     driver_pact $9C4F + prompt_diplomacy_pact $E3A4 -> relations 70
  - try_marriage marry driver + marriage_pact_handler $E315      -> relations 90

AI-initiated (the idle-AI offers a neighbouring PLAYER a pact and PAYS them gold):
  - ai_offer_pact  ai_scan_idle_fiefs_run_diplomacy_action $9B12 /
                   driver_diplomacy_gold_transfer $9AAC

Relations are NEVER decayed -- only set (70/90) or reset to 0 by a war commit. So a
landed pact is a lasting investment.  The war commit bails on relations_rng_predicate
($8271): rng(100) < relations  ->  a 70/90 relation blocks ~70/90% of that neighbour's
attacks.
"""
from . import memmap as M, vmprims as P


def enemy_neighbors(m, idx):
    return [j for j in m.neighbor_rows.get(idx, [])
            if j != idx and m.province_ai_state(j) == M.AI_HOME and m.fief_owner(j) == j]


def relation(m, a, b):
    """What relations_rng_predicate reads for an a-vs-b attack (fief level, idx 0)."""
    return m.relations_matrix_get(a, b, 0)


def _set_relation(m, a, b, v):
    lo, hi = (a, b) if a < b else (b, a)
    m.w8(M.RELATIONS_MATRIX + lo * M.RELATIONS_STRIDE + hi, v)


def _is_weak(m, idx):
    """fief_owner_weakness proxy -- the planner sets daimyo_weakness_flag from health."""
    return m.r8(M.DAIMYO_WEAKNESS_FLAG + idx) != 0


def _ai_willing(m, idx, rng):
    """prompt_diplomacy_pact / marriage AI branch gate: ~1/const_two, and a WEAK asker
    only clears the extra !weak||1/3 gate a third of the time (the AI is least willing
    to pact the weakling who needs it most)."""
    ct = max(1, m.r16(M.CONST_TWO))
    if rng.randrange(ct) != 0:
        return False
    if _is_weak(m, idx) and rng.randrange(3) != 0:
        return False
    return True


def _pay(m, idx, target, demand):
    gold = m.r16(m.fief(idx) + M.F_GOLD)
    if gold < demand:
        return False
    m.w16(m.fief(idx) + M.F_GOLD, gold - demand)
    m.w16(m.fief(target) + M.F_GOLD, m.r16(m.fief(target) + M.F_GOLD) + demand)
    return True


def try_pact(m, idx, target, rng):
    """driver_pact: costs 1 drive; on willing the target demands
    pct(gold,50)+pct(gold,rng50)+20; pay -> relations 70.  Returns True if the action
    (the turn) was consumed -- even on refusal/can't-afford."""
    d = m.fief_daimyo(idx)
    drive = m.r8(d + M.D_DRIVE)
    if drive < 1:
        return False
    m.w8(d + M.D_DRIVE, drive - 1)
    if not _ai_willing(m, idx, rng):
        return True
    gold = m.r16(m.fief(idx) + M.F_GOLD)
    demand = P.pct_op(gold, 50) + P.pct_op(gold, rng.randrange(50)) + 20
    if _pay(m, idx, target, demand):
        _set_relation(m, idx, target, 70)
    return True


def try_marriage(m, idx, target, rng):
    """marriage_pact_handler: requires gold>200 to even ask; demand
    pct(gold,rng30+50)+200; pay -> relations 90.  Returns True if the turn was used."""
    gold = m.r16(m.fief(idx) + M.F_GOLD)
    if gold <= 200:
        return False
    d = m.fief_daimyo(idx)
    drive = m.r8(d + M.D_DRIVE)
    if drive < 1:
        return False
    m.w8(d + M.D_DRIVE, drive - 1)
    if not _ai_willing(m, idx, rng):
        return True
    demand = P.pct_op(gold, rng.randrange(30) + 50) + 200
    if _pay(m, idx, target, demand):
        _set_relation(m, idx, target, 90)
    return True


def ai_offer_pact(m, ai_idx, rng):
    """driver_diplomacy_gold_transfer via ai_scan_idle ($9B12): an idle AI capital
    offers a neighbouring PLAYER a pact, PAYING them ~half the player's gold+20; the
    player (always wanting free protection + gold) accepts -> relations 70.  A strong,
    rich player thus gets PAID to be left alone."""
    for j in m.neighbor_rows.get(ai_idx, []):
        if j == ai_idx or m.province_ai_state(j) != M.PLAYER_DIRECT:
            continue
        if relation(m, ai_idx, j) >= 70:
            continue
        # offer amount = prompt_diplomacy_pact(target=AI) on the PLAYER's gold
        pgold = m.r16(m.fief(j) + M.F_GOLD)
        if rng.randrange(max(1, m.r16(M.CONST_TWO))) != 0:
            continue                                   # AI not in the mood this scan
        offer = P.pct_op(pgold, 50) + P.pct_op(pgold, rng.randrange(50)) + 20
        m.w16(m.fief(j) + M.F_GOLD, pgold + offer)      # player GAINS gold
        m.w16(m.fief(ai_idx) + M.F_GOLD, max(0, m.r16(m.fief(ai_idx) + M.F_GOLD) - offer))
        _set_relation(m, ai_idx, j, 70)
        return True
    return False
