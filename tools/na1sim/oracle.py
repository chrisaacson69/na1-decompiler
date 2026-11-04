"""
oracle.py — the formula check: na1sim's economy models (appendix-formulas.md written as code)
against the ROM's own routines, over a grid of inputs.

Each case runs one ROM routine on a real SRAM image with the fief's fields set to a grid point
(the na1dream VM, through oracle_vm.run_rom_ret) and the matching na1sim.econ model on the same
values, and compares the fields the routine writes. A capture checks one point; a formula that fits
one point can still be wrong (Give-Men, 2026-11-02: men 62 ~ morale 66 hid a missing men term and a
spurious 2x), so the grid crosses each input with edges: the stat at and past stat_cap, a partner
far from the stat, amounts from 1 up, every skill_level.

A command whose driver is pure logic (Grow, Build, Dam) runs as the player issues it: the
driver, with its guards (Grow and Build refuse at stat_cap, which the effect handler alone does not:
the AI calls effect_grow unguarded), and number_input answering with the amount clamped to the
prompt's own [min, max]. Give runs its effect handlers, which do not debit the source resource (the
driver does), so that case compares only the fields they write. The cutscene and the frame delay are stubbed out.
Frame offsets are read from the VM listing, not typed in.

RULES cases run the sim's own vmprims function against the ROM routine it transcribes, with rng_mod
scripted on both sides (see that block): Train, Hire, upkeep, the luck drift, the period driver, the
uprising roll, the revolt's loyal arm, Spring, the auction, the bribe.

--plant NAME swaps in a known-wrong model; the run must then fail (exit 1), which is the check
that a case can fail at all.

Run:  py -3.14 -m na1sim.oracle [-v] [--case NAME ...] [--plant NAME]
"""

import argparse
import itertools
import re
import sys
from functools import lru_cache
from math import isqrt
from pathlib import Path

from . import econ
from . import game
from . import memmap as M
from . import oracle_vm as O
from . import vmprims as P
from .state import Province

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
SRAM = REPO / "traces" / "aftertax.dmp"
FIEF = 7                                           # Mikawa
REC = 0x7001 + FIEF * 26
SKILL_LEVEL = 0x6D63                               # skill_level: the 1-5 difficulty, set at new game
SELECTED_PROVINCE = 0x6F5F
NUMBER_INPUT = 0xD5E9
TRIGGER_CUTSCENE = 0xE80C
RNG_MOD = 0xCA52
OFF = {"gold": 0, "debt": 2, "town": 4, "rice": 6, "output": 8, "dams": 10, "loyalty": 12,
       "wealth": 14, "men": 16, "morale": 18, "skill": 20, "arms": 22, "header": 24}


@lru_cache(maxsize=None)
def frame(bank, stub):
    """(body, frame_off) for a sub, from its header line in the committed VM listing."""
    lst = REPO / "source" / "2-asm-vm" / f"bank_{bank:02d}_vm.asm"
    m = re.search(rf"; sub \${stub:04X}\s+\(frame_off=([+-]\d+), body @ \$([0-9A-F]{{4}})\)",
                  lst.read_text(encoding="utf-8"))
    if not m:
        raise SystemExit(f"no sub ${stub:04X} in {lst.name}")
    return int(m.group(2), 16), int(m.group(1))


class Image:
    """The $6000-$7FFF SRAM image oracle_vm's runners take (they read .m[0x6000:0x8000])."""
    def __init__(self, fields, skill):
        self.m = bytearray(0x10000)
        self.m[0x6000:0x8000] = SRAM.read_bytes()
        for k, v in fields.items():
            self.w16(REC + OFF[k], v)
        self.m[SKILL_LEVEL] = skill
        self.w16(SELECTED_PROVINCE, FIEF)

    def w16(self, a, v):
        self.m[a] = v & 0xFF
        self.m[a + 1] = (v >> 8) & 0xFF


def r16(buf, a):
    return buf[a - 0x6000] | (buf[a - 0x6000 + 1] << 8)


def prompt(amount):
    """A number_input(min, max) stub: the player types `amount`, which the prompt holds to its
    range; a range that cannot hold a number is a cancel (0)."""
    def answer(vm):
        lo, hi = vm.mem.read_word(vm.vm_sp), vm.mem.read_word(vm.vm_sp + 2)
        return 0 if hi < lo else max(lo, min(amount, hi))
    return answer


def rom(fields, skill, calls, stubs=()):
    """Run (bank, stub, args) in sequence on one image; -> (record after, last return value)."""
    stubs = [(TRIGGER_CUTSCENE, lambda vm: 0), *stub_of("delay_loop"), *stubs]
    img, ret = Image(fields, skill), None
    for bank, stub, args in calls:
        body, frame_off = frame(bank, stub)
        post, ret = O.run_rom_ret(img, body, frame_off, bank, args=args, stubs=stubs)
        img.m[0x6000:0x8000] = post
    return {k: r16(img.m[0x6000:0x8000], REC + o) for k, o in OFF.items()}, ret


def province(fields, skill):
    econ.SKILL = skill
    rec, _ = rom(fields, skill, [])                # the record as the image holds it
    return Province(idx=FIEF, name="t", header=rec["header"], gold=rec["gold"], debt=rec["debt"],
                    town=rec["town"], rice=rec["rice"], output=rec["output"], dams=rec["dams"],
                    loyalty=rec["loyalty"], wealth=rec["wealth"], men=rec["men"],
                    morale=rec["morale"], skill=rec["skill"], arms=rec["arms"],
                    lm=0, wm=0, om=0, dm=0, owner=0)


# ---- cases: (name, ROM calls for an amount, model, fields compared, grid) ---------------------
SKILLS = (1, 2, 5)
CAPS = (120, 1640)
STATS = (0, 3, 40, 99, 250)
PARTNERS = (0, 62, 200, 900)
AMOUNTS = (1, 9, 50, 300)
RICH = 30000                                       # enough gold / rice for any amount


def develop_grid(stat_field, partner_field, source, partners=PARTNERS):
    for skill, cap, stat, partner, amt in itertools.product(SKILLS, CAPS, STATS, partners, AMOUNTS):
        yield skill, amt, {"header": cap, stat_field: stat, partner_field: partner, source: RICH}


CASES = {
    "grow": dict(
        calls=lambda amt: [(1, 0x9D3D, ())],                     # driver_grow
        stubs=lambda amt: [(NUMBER_INPUT, prompt(amt))],
        model=lambda p, amt: econ.grow(p, amt),
        compare=("output", "loyalty", "dams", "gold"),
        grid=lambda: ((s, a, {**f, "loyalty": 70, "dams": 45})
                      for s, a, f in develop_grid("output", "town", "gold", partners=(0,)))),
    "build": dict(
        calls=lambda amt: [(1, 0xA853, ())],                     # driver_build
        stubs=lambda amt: [(NUMBER_INPUT, prompt(amt))],
        model=lambda p, amt: econ.build(p, amt),
        compare=("town", "wealth", "gold"),
        grid=lambda: ((s, a, {**f, "wealth": 70})
                      for s, a, f in develop_grid("town", "output", "gold", partners=(0,)))),
    "give_peasants": dict(
        calls=lambda amt: [(1, 0x891D, (REC, amt)), (1, 0x896F, (REC, amt))],
        model=lambda p, amt: econ.give_peasants(p, amt),
        compare=("loyalty", "wealth"),
        grid=lambda: ((s, a, {**f, "wealth": f["loyalty"], "town": f["output"]})
                      for s, a, f in develop_grid("loyalty", "output", "rice"))),
    "give_men": dict(
        calls=lambda amt: [(1, 0x89C1, (REC, amt))],
        model=lambda p, amt: econ.give_men(p, amt),
        compare=("morale",),
        grid=lambda: develop_grid("morale", "men", "rice")),
    "dam": dict(
        calls=lambda amt: [(1, 0x9B7E, ())],                     # driver_dam
        stubs=lambda amt: [(NUMBER_INPUT, prompt(amt))],
        model=lambda p, amt: econ.dam(p, amt),
        compare=("dams", "gold"),
        grid=lambda: ((s, a, {"output": o, "dams": d, "gold": g})
                      for s, a, o, d, g in itertools.product(
                          (2,), (1, 9, 50, 424, 5000), (1, 15, 254, 900), (0, 39, 99, 100), (0, 30, 500)))),
}

# Pure helpers: ROM return value vs the model, over (a, b).
PURE = {
    "pct_op": dict(stub=0xD70D, bank=15, model=econ.pct_op,
                   grid=lambda: itertools.product((0, 1, 9, 10, 55, 99, 100, 255, 999, 1640, 9999),
                                                  (0, 1, 5, 9, 10, 20, 33, 50, 99, 100))),
    "tax_drain": dict(stub=0x82D6, bank=1,
                      model=lambda stat, d: econ.tax_effect(stat, d),
                      grid=lambda: itertools.product((0, 1, 40, 99, 250, 1640),
                                                     (1, 5, 10, 33, 50, 99, 0xFFFF, 0xFFF6))),
}

# Known-wrong models: each must make the run fail.
PLANTS = {
    "give_men_doubled": ("give_men", lambda p, amt: _plant_give_men_doubled(p, amt)),
    "develop_no_partner": ("give_peasants", lambda p, amt: _plant_no_partner(p, amt)),
    "pct_op_naive": ("pct_op", lambda b, p: b * p // 100),
    "dam_no_cap": ("dam", lambda p, amt: _plant_dam_no_cap(p, amt)),
    "tax_always_drains": ("tax_drain", lambda stat, d: stat - econ.pct_op(stat, abs(d))),
}


def _plant_give_men_doubled(p, amt):                # the appendix's Give-Men before 2026-11-02
    gain = max(1, (amt * econ._dev_mult()) // isqrt((p.men + p.morale) // 2 + amt))
    p.morale += 2 * min(gain, p.header - p.morale)
    return p


def _plant_no_partner(p, amt):                      # the Give-Men memory's form, on loyalty/wealth
    for f in ("loyalty", "wealth"):
        s = getattr(p, f)
        gain = min(max(1, (amt * econ._dev_mult()) // isqrt(s + amt)), p.header - s)
        setattr(p, f, s + 2 * gain)
    return p


def _plant_dam_no_cap(p, amt):
    if p.output == 0 or p.dams >= 100 or p.gold == 0 or amt < 1:
        return p
    sq = isqrt(p.output)
    amount = min(amt, p.gold)
    p.gold -= amount
    p.dams += max(1, (2 * amount) // sq)
    return p


# ---- rules: the sim's own code against the ROM, draw for draw -----------------------------------
# A RULES case runs a ROM routine and the vmprims function the sim calls from one image, with
# rng_mod scripted on both sides: the script reaches every draw's edges, where the free-running
# stand-in RNG would reach few, and the moduli asked for are compared too, so a wrong rng_mod(n) or
# a reordered draw fails even when the values agree. A run that does not reach its RETURN raises.
class Draws:
    """A scripted rng_mod: cycles `seq` (each value taken mod n), logging every modulus."""
    def __init__(self, seq):
        self.seq, self.i, self.asked = tuple(seq) or (0,), 0, []

    def randrange(self, n):
        self.asked.append(n)
        v = self.seq[self.i % len(self.seq)] % n
        self.i += 1
        return v

    def stub(self, vm):
        n = vm.mem.read_word(vm.vm_sp)
        return self.randrange(n) if 0 < n < 0x8000 else 0


@lru_cache(maxsize=None)
def labels():
    """name -> (bank, stub), from the headers of the committed C."""
    out = {}
    for bank in (0, 1, 2, 15):
        text = (REPO / "source" / "4-c" / f"bank_{bank:02d}.c").read_text(encoding="utf-8")
        for a, name in re.findall(r"^// \$([0-9A-F]{4}) (\w+)$", text, re.M):
            out.setdefault(name, (bank, int(a, 16)))
    return out


UI = ("confirm_prompt", "message_display", "draw_message", "redraw_window", "open_message_window", "delay_loop")


def stub_of(*names, value=0):
    return [(labels()[n][1], lambda vm, v=value: v) for n in names]


REGIONS = (("fief", 0x7001, 51 * 26), ("daimyo", M.DAIMYO_TABLE, 53 * 7), ("ai_state", M.PROVINCE_AI_STATE, 51),
           ("capital", M.FIEF_IS_CAPITAL, 51), ("owner", M.FIEF_TO_DAIMYO_MAP, 51),
           ("market", M.MARKET_RATE_TABLE, 10), ("unit_pct", M.PROVINCE_UNIT_TYPE_PCT, 51 * 5),
           ("units", M.UNIT_STRENGTH_BASE, 20), ("sides", M.SIDE_RESOURCE_BASE, 12),
           ("bribe_gate", M.COMBAT_CASUALTY_SKIP, 1), ("owners", M.DEDUPED_OWNER_LIST, 6),
           ("marks", M.MARKS_TABLE, 51 * 8))


def rule_image(pt):
    m = M.Memory(rng=Draws(()))
    m.m[0x6000:0x8000] = SRAM.read_bytes()
    m.w8(M.SKILL_LEVEL, pt.get("skill", 2))
    m.w16(SELECTED_PROVINCE, FIEF)
    m.w16(M.CURRENT_GAME_YEAR, 1565)
    for k, v in pt.get("fields", {}).items():
        m.w16(REC + OFF[k], v)
    if pt.get("set"):
        pt["set"](m)
    return m


def daimyo_stats(m, fief=FIEF, **stats):
    for k, v in stats.items():
        m.w8(m.fief_daimyo(fief) + getattr(M, "D_" + k.upper()), v)


def set_state(fief, state):
    return lambda m: m.w8(M.PROVINCE_AI_STATE + fief, state)


def train_grid():
    for skill, men, (luck, iq), draws in itertools.product(
            (0, 100, 1000, 1639, 1640), (0, 10), ((40, 40), (45, 45), (45, 46), (60, 60)),
            ((0, 0), (19, 9), (10, 0), (5, 5))):
        yield dict(fields={"skill": skill, "men": men, "header": 1640}, draws=draws,
                   set=lambda m, l=luck, q=iq: daimyo_stats(m, luck=l, iq=q))


def hire_grid():
    for men, cap, gold, rate, amount, stats, draws in itertools.product(
            (0, 10, 100), (120, 1640), (5, 100, 9999), (7, 33), (1, 50, 5000),
            ((0, 0, 0), (111, 590, 70)), ((0, 0, 0), (19, 19, 9))):
        def setup(m, rate=rate):
            m.w16(M.GOLD_MEN_HIRE_RATE, rate)
            m.w8(M.PROVINCE_UNIT_TYPE_PCT + FIEF * 5 + 2, 60)
        yield dict(fields={"men": men, "header": cap, "gold": gold, "morale": stats[0],
                           "skill": stats[1], "arms": stats[2]},
                   draws=draws, amount=amount, set=setup)


def give_grid():
    for peasants, gold, stat, partner, amount, skill, cap in itertools.product(
            (True, False), (True, False), (0, 40, 250, 1630), (0, 200), (1, 50, 900), (1, 2, 5), (120, 1640)):
        yield dict(skill=skill, peasants=peasants, gold=gold, amount=amount,
                   fields={"loyalty": stat, "wealth": stat, "morale": min(stat, 100), "output": partner,
                           "town": partner, "men": partner, "gold": 700, "rice": 300, "header": cap})
    yield dict(peasants=True, gold=True, amount=9, fields={"morale": 200, "header": 120, "gold": 50})
    yield dict(peasants=True, gold=True, amount=9, fields={"gold": 0, "output": 50, "morale": 40})


def give_stubs(pt):
    answers = iter((1 if pt["peasants"] else 0, 1 if pt["gold"] else 0))
    return [(labels()["prompt_ab_window"][1], lambda vm: next(answers)), (NUMBER_INPUT, prompt(pt["amount"]))]


def harvest_grid():
    for loyalty, wealth, debt, men, tax, human, seq in itertools.product(
            (0, 60, 900), (0, 70, 1600), (0, 50), (0, 40, 500), (20, 55), (0, 5), ((0,), (1, 3, 7), (9, 1, 5, 2))):
        def setup(m, tax=tax, human=human, loyalty=loyalty, wealth=wealth):
            m.w8(M.FIEF_TAX_RATE + FIEF, tax)
            m.w8(M.PROVINCE_AI_STATE + FIEF, human)
            mk = m.mark(FIEF)
            m.w16(mk + M.MK_LOYALTY, loyalty // 2)  # the mark below live: income reads the mark
            m.w16(mk + M.MK_WEALTH, wealth + 5)     # above live: the ratchet pulls it down
        yield dict(draws=seq, set=setup,
                   fields={"loyalty": loyalty, "wealth": wealth, "debt": debt, "men": men, "gold": 300, "rice": 200})


def harvest_model(m, pt):
    for i in range(m.r16(M.SCENARIO_FIEF_COUNT)):
        game.harvest_fief(m, i, m.rng)


def upkeep_grid():
    for men, gold, rice in itertools.product((0, 1, 2, 3, 99, 100, 1000), (0, 1, 49, 50, 51, 9000),
                                             (0, 1, 49, 50, 51, 9000)):
        yield dict(fields={"men": men, "gold": gold, "rice": rice})


def luck_grid():
    for luck, draw in itertools.product((0, 2, 4, 5, 100, 205, 210), (0, 4, 5, 6, 10)):
        yield dict(draws=(draw,), set=lambda m, l=luck: daimyo_stats(m, luck=l))


def period_grid():
    for skill, tax, draw in itertools.product((1, 2, 5), (30, 84, 85, 87, 88, 89, 90), (0, 5, 10)):
        def setup(m, tax=tax):
            m.w8(M.FIEF_TAX_RATE + FIEF, tax)
            m.w16(M.CURRENT_SEASON, 3)
        yield dict(skill=skill, fields={"loyalty": 77}, draws=(draw,), set=setup)


def uprising_grid():
    for men, morale, cha, r in itertools.product((1, 2, 10, 99, 100, 1000), (0, 50, 99, 100, 101, 250),
                                                 (0, 100, 199, 200, 201, 255), (0, 15, 30)):
        yield dict(fields={"men": men, "morale": morale}, draws=(r, 0),
                   set=lambda m, c=cha: daimyo_stats(m, charisma=c))
    for tie_breaker in (0, 1):                      # 30 + 0 + 10 + 10 = 50 percent of 100: a tie
        yield dict(fields={"men": 100, "morale": 100}, draws=(10, tie_breaker),
                   set=lambda m: daimyo_stats(m, charisma=0))


def revolt_grid():
    for morale, men, draws in itertools.product((0, 40, 300), (1, 90, 1000),
                                                ((0, 0, 0), (9, 29, 19), (5, 7, 3))):
        yield dict(fields={"morale": morale, "men": men}, draws=draws,
                   set=lambda m: (m.w8(M.EVENT_AFFECTED_FIEF_LIST, FIEF),
                                  m.w8(M.EVENT_AFFECTED_FIEF_LIST + 1, 0xFF)))


def spring_grid():
    for skill, seq, human, low in itertools.product(
            (1, 2, 3, 5), ((0,), (1,), (1, 7, 33), (3, 2, 5, 9, 1)), (0, 5), (False, True)):
        yield dict(skill=skill, draws=seq, set=set_state(FIEF, human),
                   fields={"loyalty": 0, "wealth": 1, "morale": 0, "men": 30} if low else
                          {"loyalty": 60, "wealth": 50, "morale": 70, "men": 30})
    for state, count in itertools.product((0, 5), (17, 50)):       # the 1560 branch
        def setup(m, state=state, count=count):
            m.w16(M.CURRENT_GAME_YEAR, 1560)
            m.w16(M.SCENARIO_FIEF_COUNT, count)
            m.w8(M.PROVINCE_AI_STATE + 16, state)
            m.w8(M.PROVINCE_AI_STATE + 24, state)
        yield dict(draws=(3,), set=setup)


AUCTION_TARGET = 3
BIDDERS = (((8, 16, 5, 7), (16, 5, 7)),            # (the list, its owners' capitals); 8 and 16 are one owner
           ((0, 5, 7), (15, 5, 7)),                # the bid for fief 0 comes from capital 15
           ((8, 16), (16,)))                       # one owner: no auction


def auction_grid():
    for (order, caps), golds, seq, (human, answer) in itertools.product(
            BIDDERS, ((0, 500, 300), (100, 100, 100), (900, 10, 10), (5, 9000, 40), (1, 1, 1)),
            ((0,), (50, 40, 30), (450, 99, 5), (1000, 2, 1)),
            ((None, None), (0, None), (1, None), (0, 50), (1, 1), (2, 1), (2, 9999))):
        if human is not None and human >= len(caps):
            continue
        yield _auction_point(order, caps, golds, seq, human, answer, resting=False)
    yield _auction_point(*BIDDERS[0], (100, 100, 100), (9,), 1, 50, resting=True)


def _auction_point(order, caps, golds, seq, human, answer, resting):
    def setup(m):
        for i, j in enumerate(order):
            m.w8(M.DEDUPED_OWNER_LIST + i, j)
        m.w8(M.DEDUPED_OWNER_LIST + len(order), 0xFF)
        m.w16(M.BATTLE_DEFENDING, AUCTION_TARGET)
        m.w8(M.PROVINCE_AI_STATE + AUCTION_TARGET, 0xFF)
        for i, c in enumerate(caps):
            m.w8(M.PROVINCE_AI_STATE + c, 5 if i == human else 0)
            m.w16(m.fief(c) + M.F_GOLD, golds[i])
            m.w8(M.REST_TURNS + m.fief_owner(c), 1 if resting and i == human else 0)
    return dict(draws=seq, set=setup, order=order, answer=answer, installed=[])


def auction_stubs(pt):
    def install(vm):
        pt["installed"].append(1)
        return 0
    return [(labels()["install_new_daimyo"][1], install),
            *stub_of("prompt_y_n", value=0 if pt["answer"] is None else 1),
            (NUMBER_INPUT, prompt(pt["answer"] or 1))]


def auction_model(m, pt):
    count = P.dedup_owners(m, pt["order"])
    answer = pt["answer"]
    return P.auction_ownerless_fief_to_bidders(
        m, count, lambda m, gold: None if answer is None else max(1, min(answer, gold)))


def bribe_point(skill, side, enemy_morale, amount, unit, own_men, human, draw, gate=0):
    def setup(m):
        own, enemy = (FIEF, 5) if side == 0 else (5, FIEF)
        m.w16(M.BATTLE_DEFENDING, 5)
        m.w16(M.CUR_COMBAT_SIDE, side)
        m.w8(M.COMBAT_CASUALTY_SKIP, gate)
        m.w8(M.PROVINCE_AI_STATE + own, human)
        m.w16(m.fief(own) + M.F_MORALE, 200)
        m.w16(m.fief(enemy) + M.F_MORALE, enemy_morale)
        daimyo_stats(m, own, charisma=80)
        daimyo_stats(m, enemy, charisma=70)
        m.w16(m.side_resource_ptr(side) + M.SR_GOLD, 5000)
        m.w16(m.side_resource_ptr(side) + M.SR_MEN, own_men)
        m.w16(m.side_resource_ptr(side ^ 1) + M.SR_MEN, 4000)
        m.w16(m.unit_strength_ptr(side ^ 1, 2), unit)
        m.w16(m.unit_strength_ptr(side, 0), 77)
    return dict(skill=skill, draws=(draw,), set=setup, amount=amount)


def bribe_grid():
    for p in itertools.product((1, 5), (0, 1), (10, 300), (1, 2000), (40, 3000), (100, 9990, 9999),
                               (0, 5), (0, 3)):
        yield bribe_point(*p)
    yield bribe_point(2, 0, 10, 2000, 40, 100, 5, 0, gate=1)


def fief_call(fn):
    return lambda m, pt: fn(m, m.fief(FIEF))


RULES = {
    "train": dict(calls=lambda pt: [("driver_train", ())], ret=True, grid=train_grid,
                  model=lambda m, pt: P.driver_train(m)),
    "hire": dict(calls=lambda pt: [("effect_hire_men", (REC,))], ret=True, grid=hire_grid,
                 stubs=lambda pt: [(NUMBER_INPUT, prompt(pt["amount"]))],
                 model=lambda m, pt: P.effect_hire_men(m, m.fief(FIEF), pt["amount"])),
    "give": dict(calls=lambda pt: [("driver_give", ())], ret=True, grid=give_grid, stubs=give_stubs,
                 model=lambda m, pt: P.driver_give(m, pt["peasants"], pt["gold"], pt["amount"])),
    "harvest": dict(calls=lambda pt: [("harvest_income_sweep_all_fiefs", ())], grid=harvest_grid,
                    stubs=lambda pt: stub_of("decay_relations_matrix_upper"), model=harvest_model),
    "upkeep": dict(calls=lambda pt: [("consume_province_army_upkeep", (REC,))], grid=upkeep_grid,
                   model=fief_call(P.consume_province_army_upkeep)),
    "luck_then_cap": dict(calls=lambda pt: [("drift_daimyo_luck", (FIEF,)), ("cap_fief_stats", (FIEF,))],
                          grid=luck_grid,
                          model=lambda m, pt: (P.drift_daimyo_luck(m, FIEF), P.cap_fief_stats(m, FIEF))),
    "period_driver": dict(calls=lambda pt: [("per_period_fief_daimyo_update_driver", ())], grid=period_grid,
                          stubs=lambda pt: stub_of("resolve_ownerless_fiefs_by_auction", "decay_relations_matrix_upper",
                                                   "check_and_process_daimyo_natural_death"),
                          model=lambda m, pt: P.per_period_fief_update(m)),
    "uprising": dict(calls=lambda pt: [("uprising_rebels_win_roll", (FIEF,))], ret=True, grid=uprising_grid,
                     model=lambda m, pt: P.uprising_rebels_win_roll(m, FIEF)),
    "revolt_loyal": dict(calls=lambda pt: [("resolve_revolt_event_on_listed_fiefs", ())], grid=revolt_grid,
                         stubs=lambda pt: stub_of("try_trigger_akechi_revolt", "cur_flag_and_selected_ai_state5",
                                                  "uprising_rebels_win_roll", "play_audio"),
                         model=lambda m, pt: P.revolt_loyal_men_won(m, FIEF)),
    "spring": dict(calls=lambda pt: [("per_turn_age_daimyo_decay_health_and_province_stats", ())], grid=spring_grid,
                   stubs=lambda pt: stub_of("decay_relations_matrix_upper", "decay_relations_matrix_lower"),
                   model=lambda m, pt: P.spring_age_and_decay(m)),
    "auction": dict(calls=lambda pt: [("dedup_owners", (M.DEDUPED_OWNER_LIST,)),
                                      ("auction_ownerless_fief_to_bidders", lambda count: (count,))],
                    grid=auction_grid, stubs=auction_stubs, model=auction_model,
                    agree=lambda pt, out: bool(pt["installed"]) == (out is None)),
    "bribe": dict(calls=lambda pt: [("resolve_bribe_enemy_unit", (2, pt["amount"]))], grid=bribe_grid,
                  model=lambda m, pt: P.resolve_bribe_enemy_unit(m, 2, pt["amount"])),
}


def run_rule(name, spec, verbose):
    bad = n = 0
    for pt in spec["grid"]():
        n += 1
        pre = rule_image(pt)
        rom_draws = Draws(pt.get("draws", ()))
        stubs = [(TRIGGER_CUTSCENE, lambda vm: 0), (RNG_MOD, rom_draws.stub), *stub_of(*UI),
                 *spec.get("stubs", lambda p: ())(pt)]
        img, ret = M.Memory(), None
        img.m[0x6000:0x8000] = pre.m[0x6000:0x8000]
        for sub, args in spec["calls"](pt):
            bank, stub = labels()[sub]
            body, frame_off = frame(bank, stub)
            args = args(ret) if callable(args) else args
            post, ret = O.run_rom_ret(img, body, frame_off, bank, args=args, stubs=stubs, strict=True)
            img.m[0x6000:0x8000] = post
        pre.rng = Draws(pt.get("draws", ()))
        out = spec["model"](pre, pt)
        why = [f"{label}+{i}: ROM {img.m[a + i]} model {pre.m[a + i]}" for label, a, size in REGIONS
               for i in range(size) if img.m[a + i] != pre.m[a + i]]
        if rom_draws.asked != pre.rng.asked:
            why.append(f"draws: ROM {rom_draws.asked} model {pre.rng.asked}")
        if spec.get("ret") and (ret & 0xFFFF) != int(out):
            why.append(f"return: ROM {ret} model {int(out)}")
        if not spec.get("agree", lambda p, o: True)(pt, out):
            why.append(f"outcome: ROM installed={pt['installed']} model {out}")
        if why:
            bad += 1
            if verbose or bad <= 3:
                print(f"    DIFF skill={pt.get('skill', 2)} {pt.get('fields')} draws={pt.get('draws')}: {why[:4]}")
    return n, bad


# Known-wrong rules, each the reading a note or an older model held. `patched` swaps a vmprims name
# for the run.
def patched(target, name, value):
    def model(m, pt):
        saved = getattr(P, name)
        setattr(P, name, value)
        try:
            return RULES[target]["_model"](m, pt)
        finally:
            setattr(P, name, saved)
    return model


def _hire_arms_by_men(m, fief, count):              # the form in the appendix: all three weighted by men
    men, cap = m.r16(fief + M.F_MEN), m.r16(fief + M.F_HEADER)
    for off, recruit in ((M.F_MORALE, m.rng_mod(20) + 40), (M.F_SKILL, m.rng_mod(20) + 60),
                         (M.F_ARMS, m.rng_mod(10) + 50)):
        m.w16(fief + off, P.scaled_force_transfer(m.r16(fief + off), recruit, count, men, cap))
    m.w16(fief + M.F_MEN, men + count)
    return m.r16(fief + M.F_MEN)


def _train_no_bonus(m):
    skill = m.cur_fief() + M.F_SKILL
    m.w16(skill, m.r16(skill) + (m.rng_mod(20) + 10) * 4)
    return 11


def _upkeep_no_cull(m, fief):                       # upkeep paid in full, nobody deserts
    m.w16(fief + M.F_GOLD, max(0, m.r16(fief + M.F_GOLD) - m.r16(fief + M.F_MEN) // 2))
    m.w16(fief + M.F_RICE, max(0, m.r16(fief + M.F_RICE) - m.r16(fief + M.F_MEN) // 2))


def _uprising_old_split(m, pt):                     # the old sim: rebels = men / 2, so a tie at worst
    m.rng_mod(31)
    return False


def _auction_pays_best(m, pt):                      # the old sim: the winner pays its own bid
    out = auction_model(m, pt)
    if out:
        winner, best, price = out
        f = m.fief(winner)
        m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) + price - best)
    return out


def _bribe_ai_penalty_always(m, pt):                # the morale cost read as skill_level for both
    own = m.r16(M.BATTLE_DEFENDING if m.cur_combat_side else M.SELECTED_PROVINCE)
    state = m.province_ai_state(own)
    m.w8(M.PROVINCE_AI_STATE + own, 0)
    P.resolve_bribe_enemy_unit(m, 2, pt["amount"])
    m.w8(M.PROVINCE_AI_STATE + own, state)


def _give_no_charisma(m, pt):                       # the old sim: the +1 charisma was missing
    d = m.fief_daimyo(m.selected) + M.D_CHARISMA
    before = m.r8(d)
    out = P.driver_give(m, pt["peasants"], pt["gold"], pt["amount"])
    m.w8(d, before)
    return out


def _harvest_boost_all(m, pt):                      # the old sim: the player took the AI's boost
    state = m.province_ai_state(FIEF)
    m.w8(M.PROVINCE_AI_STATE + FIEF, 0)
    harvest_model(m, pt)
    m.w8(M.PROVINCE_AI_STATE + FIEF, state)


def _spring_decay_two(m, pt):                       # the revisit note: rng_mod(2) at every skill
    real = m.rng_mod
    m.rng_mod = lambda n: real(2 if n == m.skill else n)
    P.spring_age_and_decay(m)


RULE_PLANTS = {
    "hire_arms_by_men": ("hire", lambda: patched("hire", "apply_hire_unit_stats", _hire_arms_by_men)),
    "train_no_bonus": ("train", lambda: patched("train", "effect_train", _train_no_bonus)),
    "give_no_charisma": ("give", lambda: _give_no_charisma),
    "harvest_boost_all": ("harvest", lambda: _harvest_boost_all),
    "upkeep_no_cull": ("upkeep", lambda: lambda m, pt: _upkeep_no_cull(m, m.fief(FIEF))),
    "luck_no_cap": ("luck_then_cap", lambda: lambda m, pt: P.drift_daimyo_luck(m, FIEF)),
    "uprising_old_split": ("uprising", lambda: _uprising_old_split),
    "auction_pays_best": ("auction", lambda: _auction_pays_best),
    "bribe_ai_penalty": ("bribe", lambda: _bribe_ai_penalty_always),
    "decay_men": ("spring", lambda: patched("spring", "SPRING_DECAY_FIELDS", (M.F_LOYALTY, M.F_WEALTH, M.F_MEN))),
    "decay_rng2": ("spring", lambda: _spring_decay_two),
}


def s16(v):
    return v - 0x10000 if v & 0x8000 else v


def run_case(name, spec, verbose):
    bad = n = 0
    for skill, amt, fields in spec["grid"]():
        n += 1
        stubs = spec.get("stubs", lambda a: ())(amt)
        rec, _ = rom(fields, skill, spec["calls"](amt), stubs)
        p = spec["model"](province(fields, skill), amt)
        got = {k: rec[k] for k in spec["compare"]}
        want = {k: getattr(p, k) & 0xFFFF for k in spec["compare"]}
        if got != want:
            bad += 1
            if verbose or bad <= 3:
                print(f"    DIFF skill={skill} amount={amt} {fields}: ROM {got} model {want}")
    return n, bad


def run_pure(name, spec, verbose):
    bad = n = 0
    for a, b in spec["grid"]():
        n += 1
        _, ret = rom({}, 2, [(spec["bank"], spec["stub"], (a, b))])
        want = spec["model"](a, s16(b) if name == "tax_drain" else b) & 0xFFFF
        if ret != want:
            bad += 1
            if verbose or bad <= 3:
                print(f"    DIFF ({a}, {b}): ROM {ret} model {want}")
    return n, bad


def main(argv=None):
    ap = argparse.ArgumentParser(description="na1sim formula models vs the ROM's routines")
    ap.add_argument("--case", nargs="*", help=f"cases to run (default all): {', '.join([*CASES, *PURE, *RULES])}")
    ap.add_argument("--plant", choices=sorted([*PLANTS, *RULE_PLANTS]), help="swap in a known-wrong model; must fail")
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args(argv)
    names = a.case or [*CASES, *PURE, *RULES]
    if a.plant in RULE_PLANTS:
        target, wrong = RULE_PLANTS[a.plant]
        RULES[target]["_model"] = RULES[target]["model"]
        RULES[target]["model"] = wrong()
        names = [target]
    elif a.plant:
        target, wrong = PLANTS[a.plant]
        (CASES.get(target) or PURE[target])["model"] = wrong
        names = [target]
    print(f"=== formula check: na1sim models vs ROM routines | {SRAM.name}, fief {FIEF}"
          + (f" | PLANTED {a.plant}" if a.plant else "") + " ===")
    failed = 0
    for name in names:
        spec = CASES.get(name) or PURE.get(name) or RULES[name]
        n, bad = (run_case if name in CASES else run_pure if name in PURE else run_rule)(name, spec, a.verbose)
        failed += bad > 0
        print(f"  {name:14} {n - bad:4}/{n} {'MATCH' if not bad else 'DIFF'}")
    print("=== all cases MATCH ===" if not failed else f"=== {failed} case(s) DIFF ===")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
