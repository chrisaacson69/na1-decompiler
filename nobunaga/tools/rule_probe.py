#!/usr/bin/env python3
"""rule_probe.py - NA1's rules, read from the C, checked against the ROM's own routines.

Each rule is a model written from the decompiled C. The probe loads every 8 KB SRAM dump in traces/
(real game states), runs the routine on the title's own VM interpreter (titles.make_vm, the same
engine titles.run_sub uses), reads RAM back, and requires the model's result. Each rule also has a
PLANTED wrong model (the reading the C used to print, or the obvious misreading); it must disagree on
some input, or the probe is not able to tell them apart and fails.

    py -3.14 tools/rule_probe.py [-v]          exit 1 on any disagreement or a planted model that passes

Rules (the C each model is read from is in the docstring of its check):
  deduct_byte_at          *p = (*p < amt) ? 0 : *p - amt               (byte; clamps at 0)
  word_sub_saturating     *p = max(*p - amt, 0)                          (signed word)
  consume_army_upkeep     upkeep = men/2, capped at min(gold, rice) with men = 2*cap; gold, rice -= upkeep
  cap_fief_stats          fields 0..22 in [0, stat_cap]; dams <= 100; daimyo bytes > 235 -> 0, > 210 -> 210
"""
import argparse
import sys
from pathlib import Path

from emu_harness.vm.koei.nes import titles

HERE = Path(__file__).resolve().parent.parent
PROV, STRIDE, DAIMYO = 0x7001, 26, 0x752F
F = {"gold": 0, "debt": 2, "town": 4, "rice": 6, "output": 8, "dams": 10, "loyalty": 12, "wealth": 14,
     "men": 16, "morale": 18, "skill": 20, "arms": 22, "stat_cap": 24}


def labels_by_name():
    cfg = titles.game_cfg("na1")
    out = {}
    for bank in (0, 15):
        for a, (n, _c) in titles.bank_scoped_labels(cfg, bank).items():
            out.setdefault(n, (a, bank))
    return out


def run(sub, bank, args, sram, max_ops=200000, poke=None):
    """titles.run_sub, returning the VM so RAM can be read back. `poke` = {addr: byte} written after the
    dump loads (an input the saved states never hold, such as luck 0)."""
    vm, cfg = titles.make_vm("na1")
    if bank is not None and sub < 0xC000:
        vm.switch_bank(bank)
    vm.load_sram(sram)
    for a, v in (poke or {}).items():
        vm.mem.write(a, v)
    fp = 0x05FF
    vm.vm_fp, vm.vm_sp = fp, (fp - 16) & 0xFFFF
    for i, x in enumerate(args):
        vm.mem.write_word(fp + 11 + 2 * i, x & 0xFFFF)
    vm.vm_pc = sub + 5
    vm.cpu.pc = vm.DISPATCHER_ADDR
    vm.run_until_outermost_return(max_ops=max_ops)
    return vm


def run_more(vm, sub, args, max_ops=200000):
    """Run another sub on the same VM (RAM carries over), as the turn planner runs them in sequence."""
    fp = 0x05FF
    vm.vm_fp, vm.vm_sp = fp, (fp - 16) & 0xFFFF
    for i, x in enumerate(args):
        vm.mem.write_word(fp + 11 + 2 * i, x & 0xFFFF)
    vm.vm_pc = sub + 5
    vm.cpu.pc = vm.DISPATCHER_ADDR
    vm.run_until_outermost_return(max_ops=max_ops)
    return vm


def sword(w):
    return w - 0x10000 if w & 0x8000 else w


def fresh(sram):
    vm, _ = titles.make_vm("na1")
    vm.load_sram(sram)
    return vm


def fief_count(vm):
    n = vm.mem.read(0x6D9D)
    return n if n in (17, 50) else 17


# --- checks: each returns (cases, [disagreements], planted_disagreements) --------------------------

def check_deduct_byte_at(L, dumps):
    """C (bank 15 $CA12): if (*(byte*)p < amt) phi = 0; else phi = *(byte*)p - amt; *(byte*)p = phi."""
    sub, _b = L["deduct_byte_at"]
    cases, bad, planted = 0, [], 0
    for d in dumps[::5]:
        base = fresh(d)
        for rec in range(0, 17, 4):
            p = DAIMYO + 7 * rec + 1                          # the daimyo's health byte
            before = base.mem.read(p)
            for amt in (0, 1, 7, 50, before, before + 1, 200, 255):
                vm = run(sub, None, (p, amt & 0xFF), d)
                got = vm.mem.read(p)
                want = 0 if before < (amt & 0xFF) else before - (amt & 0xFF)
                wrong = (before - (amt & 0xFF)) & 0xFF          # planted: the wrapping subtract the old C read as
                cases += 1
                if got != want:
                    bad.append(f"{d.name} p=${p:04X} before={before} amt={amt}: ROM {got}, model {want}")
                planted += got != wrong
    return cases, bad, planted


def check_word_sub_saturating(L, dumps):
    """C (bank 15 $CA31): result = *p - amt; if (result < 0) result = 0; *p = result."""
    sub, _b = L["word_sub_saturating"]
    cases, bad, planted = 0, [], 0
    for d in dumps[::5]:
        base = fresh(d)
        for i in range(0, 17, 4):
            p = PROV + STRIDE * i + F["gold"]
            before = base.mem.read_word(p)
            for amt in (0, 1, 100, before, before + 1, 30000):
                vm = run(sub, None, (p, amt), d)
                got = vm.mem.read_word(p)
                r = sword((before - amt) & 0xFFFF)
                want = 0 if r < 0 else r
                cases += 1
                if got != want:
                    bad.append(f"{d.name} p=${p:04X} before={before} amt={amt}: ROM {got}, model {want}")
                planted += got != ((before - amt) & 0xFFFF)     # planted: no saturation
    return cases, bad, planted


def check_consume_army_upkeep(L, dumps):
    """C (bank 0 $A15B): upkeep = men / 2; affordable = min_word(gold, rice);
    if (affordable < upkeep) { upkeep = affordable; men = affordable << 1; } gold -= upkeep; rice -= upkeep."""
    sub, bank = L["consume_province_army_upkeep"]
    cases, bad, planted = 0, [], 0
    for d in dumps:
        base = fresh(d)
        for i in range(fief_count(base)):
            r = PROV + STRIDE * i
            g, rice, men = (sword(base.mem.read_word(r + F[k])) for k in ("gold", "rice", "men"))
            vm = run(sub, 0, (r,), d)
            got = tuple(sword(vm.mem.read_word(r + F[k])) for k in ("gold", "rice", "men"))
            upkeep = int(men / 2)
            aff = min(g, rice)
            m2 = men
            if aff < upkeep:
                upkeep, m2 = aff, (aff << 1)
            want = (sword((g - upkeep) & 0xFFFF), sword((rice - upkeep) & 0xFFFF), sword(m2 & 0xFFFF))
            cases += 1
            if got != want:
                bad.append(f"{d.name} fief {i}: gold/rice/men {g}/{rice}/{men} -> ROM {got}, model {want}")
            wrong = (sword((g - men // 2) & 0xFFFF), sword((rice - men // 2) & 0xFFFF), men)   # planted: no desertion
            planted += got != wrong
    return cases, bad, planted


def check_cap_fief_stats(L, dumps):
    """C (bank 15 cap_fief_stats): for each word field before stat_cap: min(field, stat_cap), then < 0 -> 0;
    dams = min(dams, 100); each of the owner's first 6 daimyo bytes: > 235 -> 0, > 210 -> 210.
    Then clear_military_stats_if_no_men / clear_econ_stats_if_no_output, which can only zero fields, so the
    check is the invariant: every field in [0, stat_cap], dams <= 100, daimyo bytes <= 210, and a byte that
    was > 235 is now 0."""
    sub, _b = L["cap_fief_stats"]
    cases, bad, planted = 0, [], 0
    for d in dumps[::3]:
        base = fresh(d)
        for i in range(fief_count(base)):
            r = PROV + STRIDE * i
            owner = base.mem.read(0x6E15 + i)
            drec = DAIMYO + 7 * owner if owner < 60 else None
            vm = run(sub, None, (i,), d)
            cap = sword(vm.mem.read_word(r + F["stat_cap"]))
            fields = {k: sword(vm.mem.read_word(r + o)) for k, o in F.items() if o < 24}
            ok = all(0 <= v <= max(cap, 0) for v in fields.values()) and fields["dams"] <= 100
            if drec is not None:
                for k in range(6):
                    b0, b1 = base.mem.read(drec + k), vm.mem.read(drec + k)
                    ok &= b1 <= 210 and (b0 <= 235 or b1 == 0)
            cases += 1
            if not ok:
                bad.append(f"{d.name} fief {i}: cap {cap}, fields {fields}")
            planted += any(v > 100 for v in fields.values())   # planted: 'everything capped at 100' (dams' cap)
    return cases, bad, planted


def rng_draw(L, d, n):
    """The value rng_mod(n) returns from dump d's state: the ROM's own rng_mod, run first."""
    sub, _b = L["rng_mod"]
    return run(sub, None, (n,), d).regL


def check_probability_roll(L, dumps):
    """C (bank 0 square_over_2025_probability_roll): if (stat > 50) stat = 50; return stat * stat < rng_mod(2025).
    The rng draw is the ROM's: rng_mod(2025) from the same dump state (the RNG is deterministic in RAM)."""
    sub, bank = L["square_over_2025_probability_roll"]
    cases, bad, planted = 0, [], 0
    for d in dumps:
        r = rng_draw(L, d, 2025)
        for stat in (0, 10, 30, 44, 45, 50, 80, 200):
            got = run(sub, 0, (stat,), d).regL & 0xFFFF
            s = min(stat, 50)
            want = int(s * s < r)
            cases += 1
            if got != want:
                bad.append(f"{d.name} stat={stat} rng={r}: ROM {got}, model {want}")
            planted += got != int(s * s >= r)                  # planted: the direction I first wrote (10-28)
    return cases, bad, planted


def check_luck_drift(L, dumps):
    """C (bank 0 drift_daimyo_luck): *(byte*)luck += rng_mod(11); *(byte*)luck -= 5 (no clamp here; cap_fief_stats
    repairs an underflow afterwards). luck_ptr = daimyo_record_addr(d) + 3."""
    sub, bank = L["drift_daimyo_luck"]
    cases, bad, planted = 0, [], 0
    for d in dumps:
        base = fresh(d)
        r = rng_draw(L, d, 11)
        for dm, forced in ((0, None), (3, None), (9, None), (16, None), (1, 0), (2, 3), (4, 208)):
            p = DAIMYO + 7 * dm + 3
            before = base.mem.read(p) if forced is None else forced      # forced: the under/overflow edges
            vm = run(sub, 0, (dm,), d, poke=None if forced is None else {p: forced})
            got = vm.mem.read(p)
            want = (before + r - 5) & 0xFF
            cases += 1
            if got != want:
                bad.append(f"{d.name} daimyo {dm} luck {before} rng {r}: ROM {got}, model {want}")
            planted += got != max(0, min(255, before + r - 5))  # planted: a clamped drift (it is not clamped here)
    return cases, bad, planted


def check_luck_underflow_repaired(L, dumps):
    """The turn planner runs the luck drift (per_period_fief_daimyo_update_driver, $A498) and then
    cap_fief_stats over every fief ($A4A0). So a drift below 0 wraps to 251..255 and the cap resets it
    (> 235 -> 0). Composed on one VM: luck forced to 0..4, drift, then cap_fief_stats on a fief the daimyo
    owns; luck must end at max(0, luck + r - 5)."""
    drift, _ = L["drift_daimyo_luck"]
    cap, _ = L["cap_fief_stats"]
    cases, bad, planted = 0, [], 0
    for d in dumps:
        base = fresh(d)
        r = rng_draw(L, d, 11)
        for f in range(fief_count(base)):
            dm = base.mem.read(0x6E15 + f)                       # fief_to_daimyo_map[f]
            if dm >= 60:
                continue
            for luck in (0, 2, 4):
                p = DAIMYO + 7 * dm + 3
                vm = run(drift, 0, (dm,), d, poke={p: luck})
                mid = vm.mem.read(p)
                run_more(vm, cap, (f,))
                got = vm.mem.read(p)
                want = max(0, luck + r - 5)
                cases += 1
                if got != want:
                    bad.append(f"{d.name} fief {f} daimyo {dm} luck {luck} rng {r}: after drift {mid}, after cap {got}, model {want}")
                planted += got != ((luck + r - 5) & 0xFF)          # planted: the wrap with no repair
            break                                                # one owned fief per dump is enough
    return cases, bad, planted


CHECKS = [("deduct_byte_at", check_deduct_byte_at), ("word_sub_saturating", check_word_sub_saturating),
          ("consume_army_upkeep", check_consume_army_upkeep), ("cap_fief_stats", check_cap_fief_stats),
          ("probability_roll", check_probability_roll), ("luck_drift", check_luck_drift),
          ("luck_underflow_repaired", check_luck_underflow_repaired)]


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-v", action="store_true")
    a = ap.parse_args(argv)
    dumps = sorted(p for p in (HERE / "traces").glob("*.dmp") if p.stat().st_size == 8192)
    L = labels_by_name()
    fail = 0
    print(f"{len(dumps)} SRAM dumps")
    for name, fn in CHECKS:
        cases, bad, planted = fn(L, dumps)
        verdict = "PASS" if not bad and planted else "FAIL"
        fail += verdict == "FAIL"
        print(f"  {verdict}  {name:22} {cases:5} cases, {len(bad)} disagree; planted wrong model disagrees on {planted}")
        for b in bad[: (20 if a.v else 3)]:
            print("        ", b)
    return 1 if fail else 0


if __name__ == "__main__":
    sys.exit(main())
