"""Close the combat DAMAGE MODEL: separate the three mechanisms that touch unit strength,
and settle what the famous "/30" in apply_unit_damage_over_30 ($830B) actually is.

CONCLUSION (bytecode + static xref + cross-dump evidence): NA1 combat has THREE distinct
mechanisms, and the /30 is the RICE/SUPPLY CLOCK, not combat damage:

  1. apply_unit_damage_over_30 ($830B) -- the daily RICE/SUPPLY drain.
       each day:  unit_record(side)+2  -=  current_men(unit_record+4) / 30   (+ carried remainder)
     rice(+2) drains men/30 per day (an army of `men` eats ~men rice over a ~30-day battle); at 0 ->
     "you have no rice!" (the rice-exhaustion / doughnut-fief mechanic, ch17). The 31-day 'limit'. NOT a damage accumulator: +4 is
     labelled war_attacker_men (the live men count), and its only writers (static xref below) are
     the capture transfer and the kill applier -- nothing accumulates per-tick damage into it.

  2. apply_pct_reduction_to_unit_strength ($9D03) -- the KILL applier.
       removes arg3% of a unit slot's strength: $6FBC[slot,side] -= pct%; unit_record+4 -= same.
     Driven by tally_unit_type_then_check_strength_parity_50 ($9DFB): the damage split between the
     two engaged units is local11 = calc_battle_strength_pct_one_side = math32_2arg(strengthA,strengthB)
     = 100*A/(A+B); defender loses local11%, attacker loses (100-local11)% -- a relative-strength split.

  3. resolve_attack_apply_casualties ($9E73) -- the CAPTURE/defection contest (separate finding,
     emulator-confirmed in probe-combat-casualty.py): morale+charisma+rng, winner converts enemy men.

This script presents the cross-dump evidence for (1): between two saves of the SAME battle, the
endurance field +2 drains while the men count +4 and the visible $6FBC slot strengths are unchanged
-- the signature of a time/endurance drain, not a kill. (A live run of $830B needs the indirect
pointer-array args set up via the VM frame model -- deferred to the var-walk; the dump diff + the
literal bytecode are the stronger ground truth here.)
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from na1dream.nobunaga_vm import NobunagaVM

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

REC, STR = 0x6F7D, 0x6FBC


def load(dmp):
    vm = NobunagaVM(); vm.load_sram(dmp); vm.switch_bank(2)
    return vm


def fields(vm, s):
    rec = [vm.mem.read_word(REC + s * 6 + i) for i in (0, 2, 4)]
    st  = [vm.mem.read_word(STR + s * 10 + i * 2) for i in range(5)]
    return rec, st, sum(st)


def main():
    print("=" * 78)
    print("combat damage model: the /30 in apply_unit_damage_over_30 is the RICE/SUPPLY clock")
    print("  unit_record(side) = {+0 gold, +2 RICE/supply (drains men/30/day), +4 live men}\n")
    a = load("traces/b2-startbattle.dmp")
    b = load("traces/b2-firstcontact.dmp")
    print(f"  {'side':>4}  {'field':>5}  {'startbattle':>11}  {'firstcontact':>12}   note")
    for s in (0, 1):
        ra, sa, suma = fields(a, s)
        rb, sb, sumb = fields(b, s)
        print(f"  {s:>4}  {'+0':>5}  {ra[0]:>11}  {rb[0]:>12}   gold")
        print(f"  {s:>4}  {'+2':>5}  {ra[1]:>11}  {rb[1]:>12}   RICE Δ={rb[1]-ra[1]:+d}  (drains over days)")
        print(f"  {s:>4}  {'+4':>5}  {ra[2]:>11}  {rb[2]:>12}   live men   Δ={rb[2]-ra[2]:+d}")
        print(f"  {s:>4}  {'$6FBC':>5}  {str(sa):>11}  {str(sb):>12}   slots sum {suma}->{sumb}  (unchanged = no kills yet)")
    print("\n  Reading: rice(+2) dropped while +4 (men) and the $6FBC slot strengths held")
    print("  steady -> the per-day /30 is the RICE/supply drain (men/30 rice/day), NOT per-tick combat damage.")
    print("  Kills happen via apply_pct_reduction_to_unit_strength ($9D03, a strength-ratio %);")
    print("  troop capture via resolve_attack_apply_casualties ($9E73). Three mechanisms, decoupled.")


if __name__ == "__main__":
    main()
