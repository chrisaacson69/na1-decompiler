"""Pin the real combat casualty/capture formula by RUNNING resolve_attack_apply_casualties
($9E73, bank 2) on a real combat SRAM dump and diffing the unit strength arrays.

Static read (verified): the attack is a CONTEST, not a magnitude table.
  atk_score = rng(6-skill) + morale(atk_prov,+18) + charisma(atk_daimyo,+4)
  def_score =               morale(def_prov,+18) + charisma(def_daimyo,+4) + 2*skill
  capture happens iff atk_score > def_score; magnitude uses pct_op(math32_2arg(atk,atk-def), enemy_slot_strength).
Body arg1 = target enemy unit-slot (0-4), arg2 = men committed (reverse-push display).

We treat the sub as a black box: fix skill, enemy slot strength, committed men; sweep the
ATTACKER province morale; observe (a) the capture threshold and (b) captured-men magnitude
by diffing $6FBC (5 slots x 2 sides) + the unit_record totals ($6F7D+6*side, fields +0/+2/+4).
rng is stubbed deterministic per the rng-stub fix, so we also sweep seeds to bound it out.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

SEED = "traces/b2-startbattle.dmp"
FP = 0x05FF
BODY = 0x9E78
WON  = 0x9F34          # JUMPT: contest won, regA = local11 = capture magnitude
LOST = 0x9F37          # skip/contest-lost path (atk_score <= def_score)
RET  = 0x9F57
SEL, DEFP, SIDE, SKILL = 0x6F5F, 0x6F63, 0x7BE8, 0x6D63
SKIP = 0x7BF3          # combat_casualty_skip_flag_7bf3
USLOT = None           # cur_combat_unit_slot (resolved below if needed)
REC = 0x6F7D           # unit_record base (6 B/side)
STR = 0x6FBC           # strength array (10 B/side = 5 slots x word)


def signed(w):
    w &= 0xFFFF
    return w - 0x10000 if w >= 0x8000 else w


def strengths(vm, side):
    return [vm.mem.read_word(STR + side * 10 + i * 2) for i in range(5)]


def rec(vm, side):
    return [vm.mem.read_word(REC + side * 6 + i) for i in (0, 2, 4)]


# UI subs that block on vblank/input — patch a RETURN ($CF) at each entry so the
# arithmetic completes. Their return values are unused in resolve_attack_apply_casualties.
UI_STUBS = [0x8B8A, 0x89DF,            # draw_unit_stat_field, draw_unit_count_digits (bank 2)
            0xD326, 0xCEC4, 0xD31A, 0xD309, 0xCE81]  # message/redraw/window (bank 15 fixed)


def _stub_ui(vm):
    # mem.write ignores ROM; patch the underlying PRG array (RETURN=$CF) at each entry.
    if isinstance(vm.mem.rom, bytes):
        vm.mem.rom = bytearray(vm.mem.rom)
    for a in UI_STUBS:
        ofs = vm.mem._rom_offset(a)
        if ofs is not None:
            vm.mem.rom[ofs] = 0xCF


def run(atk_morale, slot, men, skill=1, enemy_str=None, seed=0x1234, def_morale=None):
    vm = NobunagaVM(); vm.load_sram(SEED); vm.switch_bank(2)
    w = vm.mem.write_word
    atk, dfn = vm.mem.read_word(SEL), vm.mem.read_word(DEFP)   # 5, 8
    w(SIDE, 0)                       # cur_combat_side = 0 (atk = side0 = prov 'atk')
    w(SKILL, skill)
    w(SKIP, 0)
    w(0x7001 + atk * 26 + 18, atk_morale)
    if def_morale is not None:
        w(0x7001 + dfn * 26 + 18, def_morale)
    if enemy_str is not None:
        w(STR + 1 * 10 + slot * 2, enemy_str)   # set defender (side1) slot strength
    vm._rng = seed & 0xFFFF
    # capture pre-state
    pre_s0, pre_s1, pre_r0, pre_r1 = strengths(vm, 0), strengths(vm, 1), rec(vm, 0), rec(vm, 1)
    # set the two args: arg1@fp+0x0B = slot, arg2@fp+0x0D = men
    vm.mem.write_word(FP + 0x0B, slot)
    vm.mem.write_word(FP + 0x0D, men)
    vm.vm_fp = FP; vm.vm_sp = FP - 10
    vm.vm_pc = BODY; vm.cpu.pc = vm.DISPATCHER_ADDR
    outcome, mag = None, 0
    for _ in range(8000):
        if vm.cpu.pc == vm.DISPATCHER_ADDR:
            if vm.vm_pc == WON:
                outcome, mag = "won", signed(vm.regL)   # LOADL_quick 11 just loaded local11
                break
            if vm.vm_pc == LOST:
                outcome = "lost"; break
        if vm.step_one_vm_op() is None:
            break
    return dict(outcome=outcome, mag=mag, atk=atk, dfn=dfn,
                enemy_str=vm.mem.read_word(STR + 1 * 10 + slot * 2),
                def_mor=vm.mem.read_word(0x7001 + dfn * 26 + 18))


import math


def main():
    print("=" * 78)
    print("resolve_attack_apply_casualties ($9E73): the combat CONTEST, on b2-startbattle")
    print("  atk_score = rng(6-skill) + morale(atk) + charisma(atk_daimyo)")
    print("  def_score =               morale(def) + charisma(def_daimyo) + 2*skill")
    print("  capture iff atk_score > def_score; we stop at the branch ($9F34 won / $9F37 lost).\n")
    base = run(73, 1, 40)
    print(f"  battle: atk=prov{base['atk']} def=prov{base['dfn']}  def morale={base['def_mor']} "
          f"enemy slot str={base['enemy_str']}")
    # (1) THRESHOLD: sweep attacker morale at fixed seed; find where won<->lost flips
    print("\n  (1) contest threshold — sweep attacker morale (skill=1, seed fixed):")
    print(f"      {'atkMor':>6}  {'outcome':>7}  {'magnitude(local11)':>18}")
    prev = None
    for m in range(40, 121, 4):
        r = run(m, 1, 40, seed=0x0001)
        flip = "  <-- flip" if prev and prev != r['outcome'] else ""
        prev = r['outcome']
        print(f"      {m:6d}  {r['outcome']:>7}  {r['mag']:18d}{flip}")
    # (2) MAGNITUDE: vary enemy slot strength at a fixed winning gap, check pct_op formula
    print("\n  (2) magnitude vs enemy slot strength (atk morale=120 forces a win, skill=1):")
    print(f"      {'enemyStr':>8}  {'outcome':>7}  {'local11':>8}")
    for es in (2, 4, 6, 8, 10, 15, 20):
        r = run(120, 1, 40, enemy_str=es, seed=0x0001)
        print(f"      {es:8d}  {r['outcome']:>7}  {r['mag']:8d}")
    # (2b) force a LOSS by giving the defender a huge morale (proves the contest gate fires)
    print("\n  (2b) contest gate — raise DEFENDER morale to force atk_score <= def_score:")
    print(f"      {'defMor':>6}  {'outcome':>7}   (attacker morale fixed low = 30)")
    for dm in (60, 120, 200, 300, 400):
        r = run(30, 1, 40, def_morale=dm, seed=0x0001)
        print(f"      {dm:6d}  {r['outcome']:>7}")
    # (3) rng spread: same inputs, many seeds, near the threshold
    print("\n  (3) rng spread at atk morale=95 (near threshold), 200 seeds:")
    from collections import Counter
    c = Counter()
    for s in range(1, 201):
        r = run(95, 1, 40, seed=(s * 2654435761) & 0xFFFF)
        c[r['outcome']] += 1
    print(f"      outcomes: {dict(c)}  (rng(6-skill)=rng(0..4) jitters the attacker score)")


if __name__ == "__main__":
    main()
