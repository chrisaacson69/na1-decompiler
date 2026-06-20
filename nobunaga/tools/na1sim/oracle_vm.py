"""
oracle_vm.py -- validate the Plan-B transcription (vmprims + ai_vm) against the
REAL ROM via na1dream (Plan A). Mirrors an identical $6000-$7FFF memory image
into both, runs the routine on each, and diffs the fief/daimyo/market deltas.

RNG PARITY: na1dream's rng is an LCG (_rng = _rng*1103515245+12345 & 0xFFFF;
val = _rng & 0x7FFF; rng_mod(n) = val % n), seeded 0x1234 on a fresh VM and
untouched by load_sram. We replicate that LCG (DreamRNG) and seed our Memory's
rng to 0x1234, so BOTH sides consume the identical sequence. If a whole routine
stays in lockstep, that proves our control-flow + rng-call ORDER match the ROM,
not just the arithmetic.

Run:  py -3 -m na1sim.oracle_vm [sram.dmp]
"""

import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
sys.path.insert(0, str(REPO / "tools"))
from na1dream.nobunaga_vm import NobunagaVM        # noqa: E402

from . import memmap as M                           # noqa: E402
from . import vmprims as P                          # noqa: E402
from . import ai_vm                                 # noqa: E402

DEFAULT_SRAM = REPO / "traces" / "aftertax.dmp"

# routine table: name -> (body, frame_off, bank)
ROUTINES = {
    "effect_grow":            (0x87F5, -4, 1),
    "grow_if_men_exceeds_gold": (0x95CE, -4, 1),
    "develop_town_handler":   (0xB3AF, -8, 1),
    "develop_dam_and_grow":   (0xB430, -12, 1),
    "recruit_arm_train":      (0xB4DA, -8, 1),
    "econ_command_dispatch":  (0xB650, -2, 1),
    "commit_attack_deduct":   (0x904B, -6, 1),
    "try_war_attack":         (0x949F, -12, 1),
}

RESOLVE_SIEGE = 0x8DFD     # autoresolve hand-off; no-op'd in the deduct-only check

# fief record field names by 2-byte slot (for pretty diffs)
FIELD_NAMES = {0: "gold", 2: "debt", 4: "town", 6: "rice", 8: "output",
               10: "dams", 12: "loyalty", 14: "wealth", 16: "men",
               18: "morale", 20: "skill", 22: "arms", 24: "header"}


class DreamRNG:
    """Bit-exact replica of na1dream's rng (LCG + rng_mod), exposed via the
    randrange(n) interface our Memory.rng_mod calls."""

    def __init__(self, seed=0x1234):
        self._rng = seed

    def randrange(self, n):
        self._rng = (self._rng * 1103515245 + 12345) & 0xFFFF
        val = self._rng & 0x7FFF
        return (val % n) if n else 0


def base_memory(sram_path):
    """A memmap.Memory with the 8KB SRAM image loaded at $6000."""
    m = M.Memory(rng=DreamRNG())
    data = Path(sram_path).read_bytes()
    assert len(data) == 0x2000, f"SRAM dump should be 8KB, got {len(data)}"
    m.m[0x6000:0x8000] = data
    return m


def run_rom(m_state, body, frame_off, bank, args=(), fp=0x05FF, max_ops=200000, stubs=()):
    """Drive na1dream on the EXACT $6000-$7FFF image in m_state; return the post
    image as a bytes($6000..$7FFF). `stubs` = [(addr, fn)] to install_stub."""
    vm = NobunagaVM()
    vm.mem.sram[:] = bytes(m_state.m[0x6000:0x8000])
    for addr, fn in stubs:
        vm.install_stub(addr, fn)
    vm.switch_bank(bank)
    vm.vm_fp = fp
    vm.vm_sp = fp + frame_off
    for i, a in enumerate(args):
        vm.mem.write_word(fp + 11 + i * 2, a)     # args land at fp+11, fp+13, ...
    vm.vm_pc = body
    vm.cpu.pc = vm.DISPATCHER_ADDR
    try:
        vm.run_until_outermost_return(max_ops=max_ops)
    except Exception:
        pass                                       # benign end-of-run trap
    return bytes(vm.mem.read(a) for a in range(0x6000, 0x8000))


def diff_region(pre, rom_post, py_mem):
    """Compare ROM-post vs Python-post against the same pre, over the selected
    fief record, its daimyo record, and the market table. Returns (label->...)."""
    sel = pre.r16(M.SELECTED_PROVINCE)
    fief = pre.fief(sel)
    daimyo = pre.fief_daimyo(sel)

    def w(buf, addr):     # read word from a bytes($6000..) buffer
        o = addr - 0x6000
        return buf[o] | (buf[o + 1] << 8)

    rom = {}
    py = {}
    # fief fields
    for off, name in FIELD_NAMES.items():
        a = fief + off
        p0 = pre.r16(a)
        r1 = w(rom_post, a)
        y1 = py_mem.r16(a)
        if r1 != p0 or y1 != p0:
            rom[name] = r1 - p0
            py[name] = y1 - p0
    # daimyo stat bytes +0..+6
    for i in range(7):
        a = daimyo + i
        p0 = pre.r8(a)
        r1 = rom_post[a - 0x6000]
        y1 = py_mem.r8(a)
        if r1 != p0 or y1 != p0:
            rom[f"daimyo+{i}"] = r1 - p0
            py[f"daimyo+{i}"] = y1 - p0
    # market rates
    for a, name in [(M.GOLD_RICE_EXCHANGE, "gr_rate"), (M.ARMS_BUY_PRICE_RATE, "arms_rate"),
                    (M.GOLD_MEN_HIRE_RATE, "hire_rate"), (M.LOAN_RATE, "loan_rate")]:
        p0 = pre.r16(a)
        r1 = w(rom_post, a)
        y1 = py_mem.r16(a)
        if r1 != p0 or y1 != p0:
            rom[name] = r1 - p0
            py[name] = y1 - p0
    # fief_tax_rate[sel] (byte)
    a = M.FIEF_TAX_RATE + sel
    if rom_post[a - 0x6000] != pre.r8(a) or py_mem.r8(a) != pre.r8(a):
        rom["tax(abs)"] = rom_post[a - 0x6000]
        py["tax(abs)"] = py_mem.r8(a)
    # war globals (ABSOLUTE post-values). war_side is a BYTE; the att triple words.
    ws_r, ws_y = rom_post[M.WAR_SIDE_STATE_FLAG - 0x6000], py_mem.r8(M.WAR_SIDE_STATE_FLAG)
    if ws_r != pre.r8(M.WAR_SIDE_STATE_FLAG) or ws_y != pre.r8(M.WAR_SIDE_STATE_FLAG):
        rom["war_side(abs)"], py["war_side(abs)"] = ws_r, ws_y
    for a, name in [(M.WAR_ATTACKER_MEN, "war_att_men"), (M.WAR_ATTACKER_GOLD, "war_att_gold"),
                    (M.WAR_ATTACKER_RICE, "war_att_rice")]:
        r1, y1 = w(rom_post, a), py_mem.r16(a)
        if r1 != pre.r16(a) or y1 != pre.r16(a):
            rom[name + "(abs)"], py[name + "(abs)"] = r1, y1
    return sel, rom, py


def validate(name, py_call, sram_path, args=(), setup=None, rng_sensitive=(), stubs=(),
             capture_neighbors=False):
    """rng_sensitive: field names allowed to diverge WITHOUT failing the check --
    used where an injected (stubbed) callee consumes ROM rng we don't replicate,
    shifting only the rng-driven outputs (the deterministic deltas must still
    match). stubs: [(addr, fn)] installed on the ROM VM (e.g. no-op $8DFD)."""
    body, frame_off, bank = ROUTINES[name]
    pre = base_memory(sram_path)
    if setup:
        setup(pre)

    rom_post = run_rom(pre, body, frame_off, bank, args=args, stubs=stubs)

    py_mem = base_memory(sram_path)
    if setup:
        setup(py_mem)
    if capture_neighbors:
        # extract the candidate list the ROM's ai_try_war_attack built into $6F4F
        # and feed it to the py side, so the real war hook rolls identical rng.
        lst, a = [], M.DEDUPED_OWNER_LIST
        while rom_post[a - 0x6000] != 0xFF and len(lst) < 24:
            lst.append(rom_post[a - 0x6000])
            a += 1
        py_mem.neighbor_rows[py_mem.r16(M.SELECTED_PROVINCE)] = lst
    py_mem.rng = DreamRNG()                         # same seed as the fresh ROM VM
    py_call(py_mem, args)

    sel, rom, py = diff_region(pre, rom_post, py_mem)
    keys = sorted(set(rom) | set(py))
    ok = all(rom.get(k, 0) == py.get(k, 0) for k in keys if k not in rng_sensitive)
    print(f"--- {name}  (fief {sel}, args={args}) ---")
    if not keys:
        print("    (no deltas on either side)")
    for k in keys:
        same = rom.get(k, 0) == py.get(k, 0)
        flag = "" if same else ("   (rng/war-stub, ignored)" if k in rng_sensitive else "   <<< DIFF")
        print(f"    {k:12} ROM {rom.get(k,0):+6}   py {py.get(k,0):+6}{flag}")
    print(f"    => {'MATCH' if ok else 'MISMATCH'}  (deterministic deltas)")
    return ok


def harvest_check(skill=2, seed=0):
    """Drive the ROM harvest_income_sweep_all_fiefs ($A274) on a setup board and
    diff every fief's gold/rice/men/output/loyalty/wealth against game.harvest_fief
    in LCG lockstep. Validates the low-water marks + income + subsidy + upkeep."""
    from . import setup, game
    m = setup.build_board(skill=skill, seed=seed)
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    rom_post = run_rom(m, 0xA274, -6, 0)
    mp = M.Memory(rng=DreamRNG())
    mp.m[:] = m.m
    mp.neighbor_rows = dict(m.neighbor_rows)
    for idx in range(n):
        game.harvest_fief(mp, idx, mp.rng)
    diffs = []
    for idx in range(n):
        f = m.fief(idx)
        for off, nm in [(M.F_GOLD, "gold"), (M.F_RICE, "rice"), (M.F_MEN, "men"),
                        (M.F_OUTPUT, "output"), (M.F_LOYALTY, "loy"), (M.F_WEALTH, "wealth")]:
            r = rom_post[f + off - 0x6000] | (rom_post[f + off - 0x6000 + 1] << 8)
            if r != mp.r16(f + off):
                diffs.append((idx, nm, r, mp.r16(f + off)))
    print(f"--- harvest_income_sweep ({n} fiefs, LCG lockstep) ---")
    for idx, nm, r, y in diffs[:10]:
        print(f"    fief{idx} {nm}: ROM {r} py {y}   <<< DIFF")
    print(f"    => {'MATCH' if not diffs else 'MISMATCH'}  (all fief gold/rice/men/output/loy/wealth)")
    return not diffs


def combat_check():
    """Validate game.resolve_siege vs the ROM resolve_siege_assault_outcome $8DFD
    on a loss case (defender absorbs half the committed attackers) and a win case
    (conquest: garrison = committed + half defenders, ownership flips). Compares
    the game-relevant outcome (defender men + ownership); the post-battle
    war_attacker_men scratch global is ignored."""
    import random
    from . import game

    def setup(m, atk, deff, c_men, a_q, d_men, d_q, cap):
        m.selected, m.defending = atk, deff
        fa, fd = m.fief(atk), m.fief(deff)
        for off, v in [(M.F_MORALE, a_q), (M.F_SKILL, a_q), (M.F_ARMS, a_q), (M.F_HEADER, 1900)]:
            m.w16(fa + off, v)
        for off, v in [(M.F_MEN, d_men), (M.F_MORALE, d_q), (M.F_SKILL, d_q), (M.F_ARMS, d_q),
                       (M.F_HEADER, 1900), (M.F_GOLD, 100), (M.F_RICE, 100)]:
            m.w16(fd + off, v)
        m.w8(M.FIEF_IS_CAPITAL + deff, 1 if cap else 0)
        m.w8(M.FIEF_TO_DAIMYO_MAP + atk, 1)
        m.w8(M.FIEF_TO_DAIMYO_MAP + deff, 2)
        m.w8(M.PROVINCE_AI_STATE + atk, 0)
        m.w8(M.PROVINCE_AI_STATE + deff, 0)
        m.w8(m.daimyo(1) + M.D_DRIVE, 60)
        m.w8(m.daimyo(2) + M.D_DRIVE, 60)
        m.w16(M.WAR_ATTACKER_MEN, c_men)
        m.w16(M.WAR_ATTACKER_GOLD, c_men)
        m.w16(M.WAR_ATTACKER_RICE, c_men // 2)
        m.w16(M.WAR_DEFENDER_MEN, d_men)
        m.w8(M.WAR_SIDE_STATE_FLAG, 0)

    ok = True
    for name, c_men, a_q, d_men, d_q in [("loss", 20, 50, 200, 80), ("win", 200, 80, 30, 50)]:
        atk, deff = 5, 8
        mr = base_memory(DEFAULT_SRAM)
        setup(mr, atk, deff, c_men, a_q, d_men, d_q, False)
        rom = run_rom(mr, 0x8E02, -34, 1, stubs=[(0xE80C, lambda vm: 0)])   # stub trigger_cutscene
        fd = mr.fief(deff)
        rdm = rom[fd + M.F_MEN - 0x6000] | (rom[fd + M.F_MEN - 0x6000 + 1] << 8)
        rdo = rom[M.FIEF_TO_DAIMYO_MAP + deff - 0x6000]
        mp = base_memory(DEFAULT_SRAM)
        setup(mp, atk, deff, c_men, a_q, d_men, d_q, False)
        game.resolve_siege(mp, random.Random(0))
        pdm, pdo = mp.r16(fd + M.F_MEN), mp.r8(M.FIEF_TO_DAIMYO_MAP + deff)
        match = (rdm == pdm and rdo == pdo)
        ok = ok and match
        print(f"--- resolve_siege {name}: def_men ROM {rdm} py {pdm}, owner ROM {rdo} py {pdo}"
              f"  => {'MATCH' if match else 'MISMATCH'}")
    return ok


def main():
    sram = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_SRAM
    m = base_memory(sram)
    sel = m.r16(M.SELECTED_PROVINCE)
    f = m.fief(sel)
    print(f"=== oracle_vm | {Path(sram).name} | selected fief={sel} "
          f"gold={m.r16(f)} town={m.r16(f+4)} rice={m.r16(f+6)} "
          f"output={m.r16(f+8)} loy={m.r16(f+12)} men={m.r16(f+16)} "
          f"skill_dial={m.skill} year={m.year} ===\n")

    results = []
    # 1. effect_grow leaf -- RNG-free; proves gold-neutrality + out/loy/dams math
    for amt in (30, 60, 120):
        results.append(validate("effect_grow",
                                 lambda mm, a, _amt=amt: P.effect_grow(mm, mm.cur_fief(), _amt),
                                 sram, args=(f, amt)))

    # 2. the surplus gold-sink ($95C9)
    results.append(validate("grow_if_men_exceeds_gold",
                             lambda mm, a: ai_vm.develop_grow_if_men_exceeds_gold(mm), sram))

    # 3. the develop handlers (full routine, LCG parity)
    results.append(validate("develop_town_handler",
                             lambda mm, a: ai_vm.develop_town_handler(mm, mm.selected), sram))
    results.append(validate("develop_dam_and_grow",
                             lambda mm, a: ai_vm.develop_dam_and_grow(mm, mm.selected), sram))

    # 4. RICH state -- force the gold-sink, town-spend, dam+grow magnitudes to fire
    def rich(mm):
        sel = mm.r16(M.SELECTED_PROVINCE)
        f = mm.fief(sel)
        mm.w16(f + M.F_HEADER, 1900)
        mm.w16(f + M.F_GOLD, 800)
        mm.w16(f + M.F_TOWN, 200)
        mm.w16(f + M.F_RICE, 600)
        mm.w16(f + M.F_OUTPUT, 100)
        mm.w16(f + M.F_DAMS, 40)
        mm.w16(f + M.F_LOYALTY, 400)     # loyalty>output -> grow branch fires
        mm.w16(f + M.F_WEALTH, 100)
        mm.w16(f + M.F_MEN, 63)
        mm.w16(f + M.F_MORALE, 60)

    print("\n  --- RICH state (gold 800, men 63, loy 400>out 100): exercises the sinks ---")
    results.append(validate("grow_if_men_exceeds_gold",
                             lambda mm, a: ai_vm.develop_grow_if_men_exceeds_gold(mm), sram, setup=rich))
    results.append(validate("develop_town_handler",
                             lambda mm, a: ai_vm.develop_town_handler(mm, mm.selected), sram, setup=rich))
    results.append(validate("develop_dam_and_grow",
                             lambda mm, a: ai_vm.develop_dam_and_grow(mm, mm.selected), sram, setup=rich))
    # recruit with the REAL ai_try_war_attack hook + the ROM's captured candidate
    # list -> the war's rng draws align, so morale/skill match to the digit too.
    results.append(validate("recruit_arm_train",
                             lambda mm, a: ai_vm.recruit_arm_train(mm, mm.selected, ai_vm.war_hook(ai_vm._no_resolve)),
                             sram, setup=rich, stubs=[(RESOLVE_SIEGE, lambda vm: 0)],
                             capture_neighbors=True))

    # 5. WAR SINK -- ai_commit_attack_deduct_resources, $8DFD no-op'd (deduct only)
    def war_setup(mm):
        sel = mm.r16(M.SELECTED_PROVINCE)
        f = mm.fief(sel)
        mm.w16(f + M.F_HEADER, 1900)
        mm.w16(f + M.F_GOLD, 800)
        mm.w16(f + M.F_MEN, 200)
        mm.w16(f + M.F_RICE, 600)
        mm.w8(M.FIEF_IS_CAPITAL + sel, 1)            # exercise the siege-flag rng
        mm.w8(M.REST_TURNS + sel, 0)
        mm.w8(M.UI_CONFIRM_FLAG, 0)
        deff = 0 if sel != 0 else 1
        mm.defending = deff
        d = mm.fief(deff)
        mm.w16(d + M.F_HEADER, 1900)
        mm.w16(d + M.F_GOLD, 100)
        mm.w16(d + M.F_MEN, 50)                       # min(rice,men)=50 <= budget 200
        mm.w16(d + M.F_RICE, 80)
        mm.w8(M.PROVINCE_AI_STATE + deff, M.AI_HOME)
        mm.w8(M.FIEF_TO_DAIMYO_MAP + deff, 7)
        # zero the relations cells so relations_rng_predicate can't block
        for a, b in [(sel, deff), (mm.fief_owner(sel), 7)]:
            lo, hi = (a, b) if a < b else (b, a)
            mm.w8(M.RELATIONS_MATRIX + lo * 54 + hi, 0)

    print("\n  --- WAR SINK: ai_commit_attack_deduct_resources ($8DFD no-op'd) ---")
    results.append(validate("commit_attack_deduct",
                            lambda mm, a: ai_vm.ai_commit_attack_deduct_resources(mm, ai_vm._no_resolve),
                            sram, setup=war_setup, stubs=[(RESOLVE_SIEGE, lambda vm: 0)]))

    print("\n  --- HARVEST (game.harvest_fief vs ROM harvest_income_sweep) ---")
    results.append(harvest_check())

    print("\n  --- COMBAT (game.resolve_siege vs ROM $8DFD) ---")
    results.append(combat_check())

    print(f"\n=== {sum(results)}/{len(results)} routines MATCH ===")


if __name__ == "__main__":
    main()
