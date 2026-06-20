"""
Validate econ.py against the bytecode-certified ground truth.

The oracle is the appendix-formulas.md §4 worked example (Mikawa, fief 7),
which is emulator-verified to the digit. If our pct_op and harvest reproduce
its exact numbers, the economy primitive layer is grounded.

Also demonstrates the pct_op fidelity catch vs the naive (b*p)//100 that
tools/econ_sim.py used.

    py -3 -m na1sim.validate
"""

from .state import Province
from . import econ


def _naive_pct(b, p):
    return (b * p) // 100


def check_pct_op():
    # The appendix harvest table entries — split-by-10 ROM values:
    cases = {
        (40, 40): 16,            # pct_op(40,40)
        (16, 55): 8,             # loyalty contrib
        (51, 55): 27,            # wealth contrib  (naive gives 28 — the catch)
        (66, 55): 36,            # town contrib
        (136, 64): 86,           # output*dams inner
        (86, 55): 47,            # OD_pct outer
    }
    diffs = []
    for (b, p), want in cases.items():
        got = econ.pct_op(b, p)
        assert got == want, f"pct_op({b},{p})={got}, ROM says {want}"
        if got != _naive_pct(b, p):
            diffs.append((b, p, got, _naive_pct(b, p)))
    print("pct_op: all 6 appendix values reproduced EXACTLY")
    for b, p, rom, naive in diffs:
        print(f"  fidelity catch: pct_op({b},{p}) = {rom} (ROM)  vs  {naive} (naive //100)"
              f"  <- econ_sim was wrong here")


def check_harvest_mikawa():
    """Appendix §4 verification: Mikawa fief 7.
    State: town=66, dams_max=64, output_max=136, lm=40, wm=51, men=71,
           tax=55, Charisma=68(Tokugawa). RNG_G=4, RNG_R=14 (from the trace).
    Predicted GOLD net = +40, RICE net = +61."""
    # build a province carrying just the harvest-relevant fields
    p = Province(
        idx=7, name="Mikawa", header=1640,
        gold=0, debt=0, town=66, rice=0, output=136, dams=64,
        loyalty=50, wealth=51,           # loyalty>0 so income fires; wealth unused here
        men=71, morale=70, skill=60, arms=60,
        lm=40, wm=51, om=136, dm=64,     # the MARKS the harvest actually reads
        owner=7, tax=55,
    )
    CHARISMA = 68
    RNG_G, RNG_R = 4, 14

    gy, ry = econ.fief_income(p, CHARISMA, RNG_G, RNG_R)
    # income (pre-upkeep): gold 8+27+36+4=75, rice 8+27+47+14=96
    assert gy == 75, f"gold income {gy}, expected 75"
    assert ry == 96, f"rice income {ry}, expected 96"

    # net after MEN/2 = 35 upkeep (no debt here)
    upkeep = p.men // 2
    net_gold = gy - upkeep
    net_rice = ry - upkeep
    assert net_gold == 40, f"net gold {net_gold}, expected 40"
    assert net_rice == 61, f"net rice {net_rice}, expected 61"
    print("harvest (Mikawa sec4): income gold=75 rice=96; net (-MEN/2=35) "
          "gold=+40 rice=+61 -- MATCHES the emulator-verified appendix EXACTLY")


def check_develop_sane():
    """Quick sanity that the develop family runs and respects its guards
    (full per-op fidelity is the emulator oracle's job — oracle.py, ROADMAP)."""
    p = Province(idx=0, name="t", header=1000, gold=100, debt=0, town=50, rice=200,
                 output=100, dams=30, loyalty=50, wealth=50, men=50, morale=70,
                 skill=60, arms=50, lm=50, wm=50, om=100, dm=30, owner=0, tax=20)
    g0 = p.gold
    econ.grow(p, 30)
    assert p.output > 100 and p.gold == g0 - 30, (p.output, p.gold)
    econ.dam(p, 9999)             # capped by max_spend to reach dams<=100
    assert p.dams <= 100
    # guard: can't grow with insufficient gold
    p.gold = 5
    out_before = p.output
    econ.grow(p, 30)
    assert p.output == out_before, "grow should no-op when gold<amount"
    print("develop family: runs, guards hold (grow/dam/no-op-on-insufficient-gold)")


if __name__ == "__main__":
    check_pct_op()
    check_harvest_mikawa()
    check_develop_sane()
    print("\nna1sim econ validation: PASS (primitive layer grounded vs appendix)")
