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
# The opening's two choices. Each fief has its own best opening (Chris, 2026-11-04), so these are
# switches: the tax in one move or in steps of 15, emergency gifts from gold or from rice.
# The picker is a tool for now, not the default: buying to a computed line loses to spending the gold
# (na1sim.reaction). `forecast` and `baseline` are its variants, `keep_rice` holds rice at the men.
OPENING = {"tax_jump": True, "gold_gift": True, "picker": False, "picker_slack": 0,
           "forecast": 0, "baseline": False, "keep_rice": False, "upkeep_rice": False,
           "extend_x": 0, "extend_stop": 1, "extend_floor": 1}   # tactical._extend_won_defence
UPKEEP_MARGIN = 5


def _upkeep_rice(m, idx):
    """Summer, before the harvest (Chris, 2026-11-09): the upkeep takes men/2 from gold AND rice, and
    when the smaller cannot cover it, it takes all of that one and men fall to twice it
    (consume_province_army_upkeep $A15B). Rice at 0 opens both gates (picked: provisioned men 0;
    paid: shield 0). Gold is in neither, so buy rice with all the gold it takes: if gold is then the
    short one, the upkeep zeroes the gold and trims men, and the rice survives. Saito, 300 seeds
    paired: skill 1 alive at year 6 2 -> 13 (11 saved, 0 lost), skill 2 1 -> 5 (4 / 0).
    -> True if it took the season's action."""
    f = m.fief(idx)
    need = m.r16(f + M.F_MEN) // 2 + UPKEEP_MARGIN
    rice, gold = m.r16(f + M.F_RICE), m.r16(f + M.F_GOLD)
    if rice >= need or gold <= 1:
        return False
    spend = min(-(-(need - rice) * m.r16(M.GOLD_RICE_EXCHANGE) // 10) + 1, gold - 1)
    buy_rice(m, idx, spend)
    return True


class _Floor:                               # the harvest's income rolls at their lowest
    def randrange(self, n):
        return 0


def harvest_after(m, idx, spend=0):
    """Buy rice with `spend` gold now, then run the Fall harvest itself (`game.harvest_fief`: income,
    debt, upkeep, cap) with every income roll at 0. -> (rice now, gold, rice, men after the harvest).
    Memory and the RNG are put back: asking must not change the game. Rough: the season's drift and
    the high-tax penalty between Summer's command and the harvest are not in it."""
    from . import game
    snap, state = bytes(m.m), m.rng.getstate()
    try:
        if spend:
            buy_rice(m, idx, spend)
        f = m.fief(idx)
        now = m.r16(f + M.F_RICE)
        game.harvest_fief(m, idx, _Floor())
        return now, m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MEN)
    finally:
        m.m[:] = snap
        m.rng.setstate(state)


def _rice_slack(m, idx, targeted, spend=0, sustain=False):
    """How much rice could go and still pass the check (negative: short). Chris, 2026-11-10: a target
    holds rice >= men before AND after the harvest, so the shield min(rice, men) is the men; anyone
    else only needs the upkeep, read after the harvest, not to zero the rice (`sustain`: and to cover
    next year's upkeep too, since an army fed for one Fall starves at the next)."""
    now, _, rice, men = harvest_after(m, idx, spend)
    if targeted:
        return min(now - m.r16(m.fief(idx) + M.F_MEN), rice - men)
    return rice - (men // 2 if sustain else 0) - 1


def buy_rice_to(m, idx, slack):
    """Buy the least rice that makes `slack(spend) >= 0`, all the gold if none does; nothing if it
    already passes. Buying moves gold to rice, so when gold is then the short one the upkeep cuts
    the army to what it can pay: the dismissal (Chris, #40). -> True if it bought."""
    gold = m.r16(m.fief(idx) + M.F_GOLD)
    if gold <= 1 or slack(0) >= 0:
        return False
    lo, hi = 1, gold - 1
    if slack(hi) >= 0:
        while lo < hi:
            mid = (lo + hi) // 2
            if slack(mid) >= 0:
                hi = mid
            else:
                lo = mid + 1
    buy_rice(m, idx, hi)
    return True


def _gate_rice(m, idx):
    """upkeep_rice=2, Summer, the last command before the harvest. Chris, 2026-11-10: off target,
    tax/give is the standard and this does nothing unless the upkeep would starve the army; a target
    whose men did not lift it out of range buys rice to the men, to shut the gate, and sees to the
    economy after the harvest. The least gold that passes; all of it if none does.
    -> True if it took the season's action."""
    targeted = bool(hunted_by(m, idx))
    return buy_rice_to(m, idx, lambda s: _rice_slack(m, idx, targeted, s))
SKILL_CAP = 200


# ---------------------------------------------------------------------------
# player command primitives (flat; the driver debits the resource, runs effect)
# ---------------------------------------------------------------------------
def give_men(m, idx, amount, gold=False):  # rice (or gold) -> morale
    m.selected = idx
    if amount >= 1:
        P.driver_give(m, False, gold, amount)


def give_peasants(m, idx, amount, gold=False):   # rice (or gold) -> loyalty AND wealth
    m.selected = idx
    if amount >= 1:
        P.driver_give(m, True, gold, amount)


def set_tax(m, idx, new_tax):              # driver_tax $999A: a raise drains, a cut gives back
    """loyalty and wealth through effect_tax (econ.tax_effect, the oracle's tax_drain case); charisma
    +1 on a cut, -1 on a raise unless already 0 ($9A1B). The prompt takes 1-100 (30 for Honganji)."""
    from . import econ
    f = m.fief(idx)
    cur = m.r8(M.FIEF_TAX_RATE + idx)
    if new_tax == cur or new_tax < 1 or new_tax > 100:
        return
    delta = cur - new_tax
    m.w16(f + M.F_LOYALTY, econ.tax_effect(m.r16(f + M.F_LOYALTY), delta))
    m.w16(f + M.F_WEALTH, econ.tax_effect(m.r16(f + M.F_WEALTH), delta))
    m.w8(M.FIEF_TAX_RATE + idx, new_tax)
    d = m.fief_daimyo(idx)
    cha = m.r8(d + M.D_CHARISMA)
    if delta > 0 or cha >= 1:
        m.w8(d + M.D_CHARISMA, cha + (1 if delta > 0 else -1))


def hire_men(m, idx, spend):               # gold -> men at the market rate
    m.selected = idx
    f = m.fief(idx)
    spend = min(spend, m.r16(f + M.F_GOLD))
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    gained = (spend * 10) // rate
    if spend < 1 or gained < 1:
        return
    P.effect_hire_men(m, f, gained)


def buy_rice(m, idx, spend):                # effect_buy_rice $A068: gold -> rice at the exchange rate
    m.selected = idx
    if spend >= 1:
        P.effect_buy_rice(m, m.fief(idx), spend * 10 // m.r16(M.GOLD_RICE_EXCHANGE))


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
    P.driver_train(m)


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


def hunted_by(m, idx):
    """The AI neighbours that would pick this fief, by the ROM's own selection (ai_try_war_attack):
    the grudge path (it is the list's refined target and their share of men passes 47) or the normal
    one (it is their weakest and their share clears the commit gate at its most generous). A
    second-order question: it turns on who else each neighbour could hit. The 1-in-100 attack is left
    out. RAM and the RNG are put back: asking must not change the game."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    sel, state = m.r16(M.SELECTED_PROVINCE), m.rng.getstate()
    keep = bytes(m.m[M.DEDUPED_OWNER_LIST:M.DEDUPED_OWNER_LIST + 16])
    me, out = m.fief_owner(idx), []
    for nb in m.neighbor_rows.get(idx, []):
        if nb >= n or m.province_ai_state(nb) != 0 or m.fief_owner(nb) == me:
            continue
        m.selected = nb
        ai_vm.compact_relation_list(m)
        ai_vm.filter_province_list_by_owner(m, 0)
        weakest = ai_vm.pick_weakest_men_fief(m, M.DEDUPED_OWNER_LIST)
        if weakest == 0xFF:
            continue
        alt = ai_vm.pick_ai_attack_target_fief(m, M.DEDUPED_OWNER_LIST)
        if alt == idx and ai_vm.fief_men_ratio_pct(m, nb, alt) > 47:
            out.append(nb)
        elif weakest == idx and ai_vm.fief_men_ratio_pct(m, nb, idx) > 70:
            out.append(nb)
    m.m[M.DEDUPED_OWNER_LIST:M.DEDUPED_OWNER_LIST + 16] = keep
    m.w16(M.SELECTED_PROVINCE, sel)
    m.rng.setstate(state)
    return out


def picker_line(m, idx, forecast=0):
    """Chris's rule: you need not be the strongest, you just cannot be the weakest (grudged). The
    fewest men at which no neighbour would pick this fief, among what the fief can pay for at the
    market's live rate; if none, what it can pay for, since fewer hunters beat more. Rechecked every
    turn: the answer moves when a neighbour's neighbour does. `forecast` asks it of next year: every
    AI fief with that many more men (their high-end yearly drift is about 30)."""
    if forecast:
        n = m.r16(M.SCENARIO_FIEF_COUNT)
        ais = [i for i in range(n) if m.province_ai_state(i) == 0]
        kept = [m.r16(m.fief(i) + M.F_MEN) for i in ais]
        for i, v in zip(ais, kept):
            m.w16(m.fief(i) + M.F_MEN, v + forecast)
        try:
            return picker_line(m, idx)
        finally:
            for i, v in zip(ais, kept):
                m.w16(m.fief(i) + M.F_MEN, v)
    f = m.fief(idx)
    men = m.r16(f + M.F_MEN)
    if not hunted_by(m, idx):
        return men
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    most = men + min(m.r16(f + M.F_GOLD) * 10 // rate, m.r16(f + M.F_HEADER) - men)
    line = most
    for v in range(men + 2, most + 1, 2):
        m.w16(f + M.F_MEN, v)
        if not hunted_by(m, idx):
            line = v
            break
    m.w16(f + M.F_MEN, men)
    return line


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
def _guards(m, idx):
    """Steps 1-3 of every policy: morale / loyalty cliffs, not being a border's weakest, and the
    tax opening. -> True if one of them took the season's action."""
    f = m.fief(idx)
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
    # An emergency gift must not starve the army: Gold gives like rice, and rice below a season of
    # upkeep (men/2) costs men at the harvest (Hatakeyama: rice 40 to 1, then men 56 to 28).
    spare_rice = max(0, rice - men // 2 - 1)
    use_gold = OPENING["gold_gift"] and gold > 1
    if not OPENING["gold_gift"]:
        spare_rice = rice_free                  # the June form: the rice goes, down to 1
    gift = (lambda give, amount: give(m, idx, min(60, gold - 1), gold=True) if use_gold
            else give(m, idx, min(60, amount)))
    if morale < CLIFF and (use_gold or spare_rice > 0):
        gift(give_men, spare_rice); return True
    if loyalty < CLIFF and (use_gold or spare_rice > 0):
        gift(give_peasants, spare_rice); return True

    # 2. DON'T BE ANY BORDER'S WEAKEST PREY (the opening hire). A fief like Uesugi
    #    STARTS as a border's weakest, and the human is attacked via the pick_ai_
    #    attack_target_fief ratio>47 override the moment it's the weakest (not just
    #    the normal 2.3x gate). Get above each border's next-weakest prey so the
    #    selector routes the attacker elsewhere. When morale/loyalty are fine (the
    #    common turn-1 case) this fires first anyway. [Turn-ORDER deaths -- attacked
    #    before our action runs -- are irreducible; factor them out of the metric.]
    if OPENING["picker"]:
        line = picker_line(m, idx, OPENING["forecast"])
        if line > men or hunted_by(m, idx):    # a neighbour hires after you: margin above the line
            line = line * (100 + OPENING["picker_slack"]) // 100
        if OPENING["baseline"]:                # the older target as a floor, hunted or not
            old = _safe_men_target(m, idx)
            line = max(line, old + old // 5 + 6)
        if men < line and _hire_up_to(m, idx, line):
            return True
    else:
        target = _safe_men_target(m, idx)
        target += target // 5 + 6
        if men < target and gold > 12:
            hire_men(m, idx, gold - 6); return True

    # 3. OPENING (year 1-2): raise tax toward 55 -- only when loyalty can absorb the
    #    |dtax|% drain; else restore the lower of loyalty/morale first. Worse fiefs
    #    spend year 1-2 fixing this before they can go on autopilot.
    if tax < 55:
        # The Tax command takes any rate in one turn: the most this fief's loyalty can bear, up to 55.
        most = 55 - tax if OPENING["tax_jump"] else min(15, 55 - tax)
        step = next((s for s in range(most, 0, -1)
                     if loyalty - P.pct_op(loyalty, s) >= CLIFF - 1), 0)   # 45: the roll cannot fail
        step = step if OPENING["tax_jump"] or step == most else 0
        if step:
            set_tax(m, idx, tax + step); return True
        if rice_free > 0:                   # WEALTH is the prize -> give_peasants by default
            (give_men if morale < CLIFF + 12 else give_peasants)(m, idx, min(60, rice_free)); return True
    return False


def hida_policy(m, idx, rng):
    """The June rotation: develop town and output with gold, give rice in Summer."""
    if _guards(m, idx):
        return
    f = m.fief(idx)
    season = getattr(m, "season", 0)
    gold, rice, morale = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MORALE)
    output, dams = m.r16(f + M.F_OUTPUT), m.r16(f + M.F_DAMS)
    rice_free = max(0, rice - 1)

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


def peasant_policy(m, idx, rng):
    """Chris's shortcut (2026-11-04): leave town and output alone and give gold and rice to the
    peasants. The harvest's base term holds wealth and loyalty and feeds BOTH gold and rice, where
    town feeds only gold and output only rice. One Give raises loyalty and wealth together, twice
    the gain each, at no cost to any other stat and +1 charisma; Grow and Build each cut a stat, and
    their price rises with the stat itself.

    Timing: the harvest reads the marks, set at the START of Summer and only ever lowered, so a gift
    pays this year only if it lands before that. The harvest is at the start of Fall, before Fall's
    command. So Fall gives the gold, Winter the rice, and Spring and Summer are free: two seasons
    for what took three, and the rest train."""
    if _guards(m, idx):
        return
    f = m.fief(idx)
    season = getattr(m, "season", 0)
    gold, rice = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE)
    if season == 2 and gold > 1:                # FALL: the harvest has just landed
        give_peasants(m, idx, gold - 1, gold=True)
    elif season == 3 and rice > 1:              # WINTER: keep the 1 rice
        give_peasants(m, idx, rice - 1)
    else:
        train(m, idx)


def _grudge_line(m, idx):
    """The men that keep this fief off the AI's grudge path ($952E): it attacks a human neighbour
    when its share of the two fiefs' provisioned men passes 47%, and men are all it counts. So stay
    above 53/47 of the strongest neighbour."""
    enemies = [m.fief_men_if_provisioned(j) for j in _enemy_neighbors(m, idx)]
    return (max(enemies) * 53) // 47 + 1 if enemies else 0


def _hire_up_to(m, idx, line, budget=None):
    """Hire toward `line`, spending only what it costs, and no more than `budget` gold if given.
    -> True if it hired."""
    f = m.fief(idx)
    gold = m.r16(f + M.F_GOLD)
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    need = min(line, m.r16(f + M.F_HEADER)) - m.r16(f + M.F_MEN)
    if budget is not None:
        need = min(need, budget * 10 // rate)
    if need < 1 or gold < rate:
        return False
    m.selected = idx
    return bool(P.effect_hire_men(m, f, need))


def _season_plan(m, idx, rng, expand=False, slack=0, big_buy=False, gold_season=0):
    """One season for one fief. The knobs (Chris, 2026-11-04): `slack` is the percent held over the
    grudge line, because a neighbour hires after you do; `big_buy` spends all the gold on men once
    under the line, against buying just enough each year; `gold_season` is when the gold is given.
    Over all 17 starts at skill 2 (100 seeds each): Spring beat Fall (survival 40.7% against 36.2%,
    1.33 fiefs at year 30 against 0.99); slack cost growth for no survival; big buy was a wash."""
    season = getattr(m, "season", 0)
    rule = _gate_rice if OPENING["upkeep_rice"] == 2 else _upkeep_rice
    if OPENING["upkeep_rice"] and season == 1 and rule(m, idx):   # before the guards: an emergency
        return                                  # gift would spend the gold the harvest needs
    if _guards(m, idx):
        return
    f = m.fief(idx)
    gold, rice, morale = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MORALE)
    men, cap = m.r16(f + M.F_MEN), m.r16(f + M.F_HEADER)
    capped = (m.r16(f + M.F_WEALTH) + m.r16(f + M.F_LOYALTY)) // 2 >= cap
    enemies = _enemy_neighbors(m, idx)
    keep = men if OPENING["keep_rice"] else 0   # the attack gate reads min(rice, men): hold the shield
    if OPENING["upkeep_rice"] == 2:             # a target holds the shield; Summer's gift keeps
        targeted = bool(hunted_by(m, idx))      # the harvest check passing
        if targeted:
            keep = max(keep, men)
        if season == 1:
            keep = max(keep, rice - max(0, _rice_slack(m, idx, targeted)))
    elif OPENING["upkeep_rice"]:                # and never give away what the harvest's upkeep needs
        keep = max(keep, men // 2 + UPKEEP_MARGIN)

    if expand and capped and enemies:
        if season in (3, 0):                    # a war needs gold, men and rice in hand
            targets = [j for j in enemies if _can_take(m, idx, j)]
            if targets:
                _player_war(m, idx, min(targets, key=lambda j: m.fief_men_if_provisioned(j)), rng)
                return
        if season == 2:                         # a capital defends at 3x: out-buy the weakest,
            weakest = min(m.fief_men_if_provisioned(j) for j in enemies)   # half the gold, no more
            if _hire_up_to(m, idx, weakest * 4, budget=gold // 2):
                return
    line = _grudge_line(m, idx) * (100 + slack) // 100
    if season == 2 and men < line:              # FALL: a neighbour in reach means men first
        if big_buy and gold > 12:
            hire_men(m, idx, gold - 6)
            return
        if _hire_up_to(m, idx, line):
            return
    if season == gold_season and not capped and gold > 1:
        give_peasants(m, idx, gold - 1, gold=True)
    elif season == 1 and rice > keep + 1:       # SUMMER: rice out, and the harvest is next
        (give_men if capped else give_peasants)(m, idx, rice - keep - 1)
    elif season == 0 and morale < 100 and rice > keep + 2:
        give_men(m, idx, min(rice // 2, rice - keep - 1))   # SPRING: morale, as the old sequence did
    else:
        train(m, idx)


def make_policy(**knobs):
    return lambda m, idx, rng: _season_plan(m, idx, rng, **knobs)


def summer_policy(m, idx, rng):
    """Chris's sequence (2026-11-04): Fall hires to the grudge line, Spring gives the gold to the
    peasants, Summer gives the rice, so the army keeps its rice through every season but the one
    before the harvest; a Summer gift pays from next year, which costs one year once. Fall and
    Winter otherwise train."""
    _season_plan(m, idx, rng)


def expand_policy(m, idx, rng):
    """summer_policy until the peasants top out, then the signal is Chris's: buy men and expand. A
    war's budget is min(2*rice, men, gold), so the gold has to last: half buys men, the rest fights."""
    _season_plan(m, idx, rng, expand=True)


# ---------------------------------------------------------------------------
# Opening plans: the first turns as a script, then a policy (Chris, 2026-11-04: each fief has its
# own best opening, fixing its own weakness first).
# ---------------------------------------------------------------------------
def _tax_max(m, idx):                       # the Tax command, one move (Honganji is held to 30)
    set_tax(m, idx, 30 if m.fief_owner(idx) == 3 else 55)


def _all_but_one(give, gold):
    def act(m, idx):
        f = m.fief(idx)
        give(m, idx, m.r16(f + (M.F_GOLD if gold else M.F_RICE)) - 1, gold=gold)
    return act


OPENING_ACTIONS = {
    "auto": None,                           # the tail policy decides
    "tax": _tax_max,
    "gold>peasants": _all_but_one(give_peasants, True),
    "rice>peasants": _all_but_one(give_peasants, False),
    "gold>men": _all_but_one(give_men, True),
    "rice>men": _all_but_one(give_men, False),
    "hire": lambda m, idx: hire_men(m, idx, m.r16(m.fief(idx) + M.F_GOLD) - 1),
    "rice": lambda m, idx: buy_rice(m, idx, m.r16(m.fief(idx) + M.F_GOLD) - 1),
    "train": train,
}


def plan_policy(fief, plan, tail=expand_policy):
    """Play `plan` (names from OPENING_ACTIONS) on the fief's first turns, then `tail`. One per game:
    it counts the fief's turns."""
    turn = [0]

    def play(m, idx, rng):
        act = None
        if idx == fief and turn[0] < len(plan):
            act = OPENING_ACTIONS[plan[turn[0]]]
            turn[0] += 1
        if act is None:
            tail(m, idx, rng)
        else:
            m.selected = idx
            m.turn_rng = rng                # for an action that falls back to a policy
            act(m, idx)
    return play
