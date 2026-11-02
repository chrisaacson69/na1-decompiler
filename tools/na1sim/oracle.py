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
driver does), so that case compares only the fields they write. The cutscene is stubbed out.
Frame offsets are read from the VM listing, not typed in.

--plant NAME swaps in a known-wrong model; the run must then fail (exit 1), which is the check
that a case can fail at all.

Run:  py -3.14 -m na1sim.oracle [-v] [--case NAME ...] [--plant NAME]
"""

import argparse
import itertools
import re
import sys
from math import isqrt
from pathlib import Path

from . import econ
from . import oracle_vm as O
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
OFF = {"gold": 0, "debt": 2, "town": 4, "rice": 6, "output": 8, "dams": 10, "loyalty": 12,
       "wealth": 14, "men": 16, "morale": 18, "skill": 20, "arms": 22, "header": 24}


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
    stubs = [(TRIGGER_CUTSCENE, lambda vm: 0), *stubs]
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
    ap.add_argument("--case", nargs="*", help=f"cases to run (default all): {', '.join([*CASES, *PURE])}")
    ap.add_argument("--plant", choices=sorted(PLANTS), help="swap in a known-wrong model; must fail")
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args(argv)
    names = a.case or [*CASES, *PURE]
    if a.plant:
        target, wrong = PLANTS[a.plant]
        (CASES.get(target) or PURE[target])["model"] = wrong
        names = [target]
    print(f"=== formula check: na1sim models vs ROM routines | {SRAM.name}, fief {FIEF}"
          + (f" | PLANTED {a.plant}" if a.plant else "") + " ===")
    failed = 0
    for name in names:
        spec = CASES.get(name) or PURE[name]
        n, bad = (run_case if name in CASES else run_pure)(name, spec, a.verbose)
        failed += bad > 0
        print(f"  {name:14} {n - bad:4}/{n} {'MATCH' if not bad else 'DIFF'}")
    print("=== all cases MATCH ===" if not failed else f"=== {failed} case(s) DIFF ===")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
