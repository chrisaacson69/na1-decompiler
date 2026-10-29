"""
policy.py -- the tuned Hida player, encoding Chris's actual optimal-play playbook,
ported to the flat memory model (memmap.Memory) + the validated primitives.

GROUNDED facts it exploits:
  * 1 rice == FULL provisioned men ($9382 is binary: rice==0 -> 0 men, else full).
    So you can dump almost all rice every Summer (-> morale/loyalty) and the Fall
    harvest refills it, at zero defensive cost. KEEP >=1 rice always.
  * MORALE is the bigger bite: a morale revolt flips/loses the fief = game over.
    Hold morale >= 45 (square_roll eligibility is 0 at >=45) via give-men.
  * Hold loyalty >= 45 too (riots dock loyalty + the harvest gates on loyalty>0).
  * Tax ~55 is the income optimum, but slamming it turn-1 drains loyalty and can
    trigger a riot -> raise it in steps only when loyalty can absorb the |dtax|%.
  * The AI re-randomizes its own tax 35-64 every turn (random riots); a stable 55
    is a pure player edge.

The player gets ONE action per fief per season -> after the opening it's a fixed
seasonal ROTATION: Fall=train, Winter=build(1/2 gold), Spring=grow(1/2 gold),
Summer=give-rice (down to 1). Emergencies (morale/loyalty cliff, weakest, soft
target) override the rotation. Develops on the SUBLINEAR sqrt curve but wins on
the action-economy edge: minimal upkeep, one focused move.
"""

from . import memmap as M
from . import vmprims as P
from . import ai_vm

CLIFF = 46          # keep morale/loyalty >= 45 (revolt/riot eligibility is 0 at >=45)
SKILL_CAP = 200


# ---------------------------------------------------------------------------
# player command primitives (flat; the driver debits the resource, runs effect)
# ---------------------------------------------------------------------------
def _dev_gain(m, amount, stat, comp):
    return 2 * ((amount * (6 - m.skill)) // P.sqrt_int((stat + comp) // 2 + amount))


def give_men(m, idx, amount):              # rice -> morale (develop-family pair)
    f = m.fief(idx)
    if amount < 1 or m.r16(f + M.F_RICE) < amount:
        return
    m.w16(f + M.F_RICE, m.r16(f + M.F_RICE) - amount)
    g = _dev_gain(m, amount, m.r16(f + M.F_MEN), m.r16(f + M.F_MORALE))
    m.w16(f + M.F_MORALE, min(100, m.r16(f + M.F_MORALE) + g))


def give_peasants(m, idx, amount):         # rice -> loyalty + wealth
    f = m.fief(idx)
    if amount < 1 or m.r16(f + M.F_RICE) < amount:
        return
    m.w16(f + M.F_RICE, m.r16(f + M.F_RICE) - amount)
    lg = _dev_gain(m, amount, m.r16(f + M.F_OUTPUT), m.r16(f + M.F_LOYALTY))
    wg = _dev_gain(m, amount, m.r16(f + M.F_TOWN), m.r16(f + M.F_WEALTH))
    m.w16(f + M.F_LOYALTY, min(100, m.r16(f + M.F_LOYALTY) + lg))
    m.w16(f + M.F_WEALTH, min(100, m.r16(f + M.F_WEALTH) + wg))


def set_tax(m, idx, new_tax):              # drains loyalty + wealth by |dtax|%
    f = m.fief(idx)
    cur = m.r8(M.FIEF_TAX_RATE + idx)
    if new_tax == cur or new_tax < 0 or new_tax > 100:
        return
    delta = abs(new_tax - cur)
    m.w16(f + M.F_LOYALTY, m.r16(f + M.F_LOYALTY) - P.pct_op(m.r16(f + M.F_LOYALTY), delta))
    m.w16(f + M.F_WEALTH, m.r16(f + M.F_WEALTH) - P.pct_op(m.r16(f + M.F_WEALTH), delta))
    m.w8(M.FIEF_TAX_RATE + idx, new_tax)
    d = m.fief_daimyo(idx)
    m.w8(d + M.D_CHARISMA, max(0, m.r8(d + M.D_CHARISMA) - 1))


def hire_men(m, idx, spend):               # gold -> men at the market rate
    m.selected = idx
    f = m.fief(idx)
    spend = min(spend, m.r16(f + M.F_GOLD))
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    gained = (spend * 10) // rate
    if spend < 1 or gained < 1:
        return
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - spend)
    P.apply_hire_unit_stats(m, f, gained)


def grow_output(m, idx, amount):
    m.selected = idx
    f = m.fief(idx)
    amount = min(amount, m.r16(f + M.F_GOLD))
    if amount < 1 or m.r16(f + M.F_OUTPUT) >= m.r16(f + M.F_HEADER):
        return
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - amount)
    P.effect_grow(m, f, amount)


def build_town(m, idx, amount):
    m.selected = idx
    f = m.fief(idx)
    amount = min(amount, m.r16(f + M.F_GOLD))
    if amount < 1 or m.r16(f + M.F_TOWN) >= m.r16(f + M.F_HEADER):
        return
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - amount)
    P.effect_build(m, f, amount)


def build_dam(m, idx, amount_gold):
    m.selected = idx
    f = m.fief(idx)
    out, dams, gold = m.r16(f + M.F_OUTPUT), m.r16(f + M.F_DAMS), m.r16(f + M.F_GOLD)
    if out == 0 or dams >= 100 or gold == 0:
        return
    sq = P.sqrt_int(out)
    spend = min(amount_gold, gold, (100 - dams) * sq // 2)
    if spend < 1:
        return
    m.w16(f + M.F_GOLD, gold - spend)
    m.w16(f + M.F_DAMS, min(100, dams + max(1, (2 * spend) // sq)))


def train(m, idx):
    m.selected = idx
    if m.r16(m.fief(idx) + M.F_MEN) > 0:
        P.effect_train(m)


def _enemy_neighbors(m, idx):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    me = m.fief_owner(idx)
    return [j for j in m.neighbor_rows.get(idx, [])
            if j < n and m.province_ai_state(j) != M.EMPTY and m.fief_owner(j) != me]


def _prov_men(m, idx):                     # provisioned men (0 if no rice)
    f = m.fief(idx)
    return m.r16(f + M.F_MEN) if m.r16(f + M.F_RICE) else 0


def _safe_men_target(m, idx):
    """Men needed to be SAFE from every border -- CAPITAL-AWARE (Chris 2026-06-19:
    "162 was wrong at every level"). You're safe from a border N if EITHER:
      (a) you're not N's weakest prey -- some OTHER enemy-neighbour of N is weaker
          than you, so N hunts THAT one (target = just above N's weakest other prey); OR
      (b) N can't break your CAPITAL even at full commit -- an attacker won't empty its
          own capital for a fight it loses. Capital defends at 3x men; N commits ~0.6x
          its men at 2x -> you repel once 3*you > 1.2*N_men, i.e. men > ~0.4*N_men.
    Take the EASIER (min) of the two per border, then the hardest border (max). This
    lets a strong-but-not-largest fief (Mikawa: capital repels weak Imagawa) TURTLE
    instead of panic-hiring, while a fief whose attacker CAN break its capital (Uesugi
    vs Hojo) still must hire. [repel factor 0.4 ignores attacker QUALITY -- pad later.]"""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    fi = m.fief(idx)
    my_q = m.r16(fi + M.F_ARMS) + m.r16(fi + M.F_SKILL) + m.r16(fi + M.F_MORALE)
    target = 0
    for nb in _enemy_neighbors(m, idx):
        nb_owner = m.fief_owner(nb)
        nb_men = _prov_men(m, nb)
        others = [k for k in m.neighbor_rows.get(nb, [])
                  if k != idx and k < n and m.province_ai_state(k) != M.EMPTY
                  and m.fief_owner(k) != nb_owner]
        # INSURANCE rank (Chris): not just "not N's weakest" but "3rd-lowest" -- sit
        # above N's 2nd-weakest prey, so a plague/dip that knocks you one rank still
        # leaves someone below you (the bottom hires up -> the NEXT guy is bottom, not
        # you). Falls back to weakest (1 prey) or the ratio gate (sole prey).
        prey = sorted(_prov_men(m, k) for k in others)
        if len(prey) >= 2:
            not_weakest = prey[1] + 2      # above 2nd-weakest -> you're 3rd-lowest
        elif prey:
            not_weakest = prey[0] + 2
        else:                              # I'm N's only prey -> stay off its ratio gate
            not_weakest = nb_men * 45 // 100
        # capital (3x) repel INCL quality (resolve_siege formula): repel N's ~0.6 commit
        # if 3*me + my_quality > 1.2*nb_men + nb_quality  ->  me > (1.2*nb + nb_q - my_q)/3
        nbf = m.fief(nb)
        nb_q = m.r16(nbf + M.F_ARMS) + m.r16(nbf + M.F_SKILL) + m.r16(nbf + M.F_MORALE)
        repel = max(0, (nb_men * 12 // 10 + nb_q - my_q) // 3)
        repel = repel * 15 // 10           # pad x1.5: attacker skill SNOWBALLS + can
                                           # hire up before it strikes (tuned 2026-06-19)
        target = max(target, min(not_weakest, repel))
    return target


def _can_take(m, idx, tgt):
    """Would our ~60%-budget commit win the off-screen battle vs tgt (with margin)?
    Mirrors resolve_siege's strength formula."""
    f, t = m.fief(idx), m.fief(tgt)
    budget = min(2 * m.r16(f + M.F_RICE), m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD))
    if budget < 5:
        return False
    commit = (budget * 60) // 100
    atk = commit * 2 + ((m.r16(f + M.F_ARMS) // 2) + (m.r16(f + M.F_SKILL) // 2)) * 2 + m.r16(f + M.F_MORALE)
    dmult = 3 if m.is_capital(tgt) else 2
    dfn = m.r16(t + M.F_MEN) * dmult + ((m.r16(t + M.F_ARMS) // 2) + (m.r16(t + M.F_SKILL) // 2)) * 2 + m.r16(t + M.F_MORALE)
    return atk > dfn + dfn // 10


def _player_war(m, idx, tgt, rng):
    """Launch a player war: faithful commit (ai_commit_attack_deduct_resources) +
    the validated resolve_siege at the $8DFD boundary."""
    from . import game
    m.selected, m.defending = idx, tgt
    ai_vm.ai_commit_attack_deduct_resources(m, lambda mm: game.resolve_siege(mm, rng))


# ---------------------------------------------------------------------------
# the tuned Hida policy
# ---------------------------------------------------------------------------
def hida_policy(m, idx, rng):
    f = m.fief(idx)
    season = getattr(m, "season", 0)
    gold, men, rice = m.r16(f + M.F_GOLD), m.r16(f + M.F_MEN), m.r16(f + M.F_RICE)
    morale, loyalty = m.r16(f + M.F_MORALE), m.r16(f + M.F_LOYALTY)
    output, dams = m.r16(f + M.F_OUTPUT), m.r16(f + M.F_DAMS)
    tax = m.r8(M.FIEF_TAX_RATE + idx)
    # THE 1-RICE TRICK: 0 rice == unprovisioned (0 men for war targeting), but >=1
    # rice == FULL army. So give almost all rice every Summer (the Fall harvest
    # refills it) -> the wealth/loyalty/morale bump accelerates growth at no
    # defensive cost. Keep exactly 1.
    rice_free = max(0, rice - 1)

    # 1. EMERGENCY (morale FIRST -- the worse cliff): morale<45 risks a REBELLION
    #    (lose the fief); loyalty<45 risks a peasant riot (income dock, recoverable).
    #    Both preempt everything -- fixing loyalty is broadly worth more than a turn
    #    of hiring (the harvest gates on loyalty; riots compound).
    if morale < CLIFF and rice_free > 0:
        give_men(m, idx, min(60, rice_free)); return
    if loyalty < CLIFF and rice_free > 0:
        give_peasants(m, idx, min(60, rice_free)); return

    # 2. DON'T BE ANY BORDER'S WEAKEST PREY (the opening hire). A fief like Uesugi
    #    STARTS as a border's weakest, and the human is attacked via the pick_ai_
    #    attack_target_fief ratio>47 override the moment it's the weakest (not just
    #    the normal 2.3x gate). Get above each border's next-weakest prey so the
    #    selector routes the attacker elsewhere. When morale/loyalty are fine (the
    #    common turn-1 case) this fires first anyway. [Turn-ORDER deaths -- attacked
    #    before our action runs -- are irreducible; factor them out of the metric.]
    target = _safe_men_target(m, idx)
    target += target // 5 + 6
    if men < target and gold > 12:
        hire_men(m, idx, gold - 6); return

    # 3. OPENING (year 1-2): raise tax toward 55 -- only when loyalty can absorb the
    #    |dtax|% drain; else restore the lower of loyalty/morale first. Worse fiefs
    #    spend year 1-2 fixing this before they can go on autopilot.
    if tax < 55:
        step = min(15, 55 - tax)
        if loyalty - P.pct_op(loyalty, step) >= CLIFF + 6:
            set_tax(m, idx, tax + step); return
        if rice_free > 0:                   # WEALTH is the prize -> give_peasants by default
            (give_men if morale < CLIFF + 12 else give_peasants)(m, idx, min(60, rice_free)); return

    # 4. DAM FLOOR (not chase): keep dams above ~80 for rice income, but DON'T
    #    re-dam 95->100 after every grow nicks it -- that wastes actions for almost
    #    nothing. Only patch when it falls through the floor. [formula TBD]
    if dams < 80 and output > 40 and gold > 12:
        build_dam(m, idx, gold - 6); return

    # 5. AUTOPILOT ROTATION (one action/season): Train, Build(1/2), Grow(1/2), Give-rice.
    #    The Fall train (>=1x/yr) keeps skill from falling too far behind the AI.
    half = max(1, gold // 2)
    if season == 2:                         # FALL: train, then the harvest hits
        train(m, idx)
    elif season == 3:                       # WINTER: build town, 1/2 gold
        build_town(m, idx, half)
    elif season == 0:                       # SPRING: grow output, 1/2 gold
        grow_output(m, idx, half)
    else:                                   # SUMMER: dump rice (refilled Fall). WEALTH is the
        if rice_free > 0:                   # prize -> give_peasants; give_men only if morale soft.
            (give_men if morale < CLIFF + 12 else give_peasants)(m, idx, rice_free)
