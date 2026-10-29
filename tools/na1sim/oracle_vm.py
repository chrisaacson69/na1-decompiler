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


def run_rom_ret(m_state, body, frame_off, bank, args=(), fp=0x05FF, max_ops=200000, stubs=()):
    """Like run_rom but ALSO returns the routine's return value (regL/$08 at the
    outermost RETURN) -- for the pure combat strength functions that return a
    number rather than mutating the fief region. Returns (post_image, regL)."""
    vm = NobunagaVM()
    vm.mem.sram[:] = bytes(m_state.m[0x6000:0x8000])
    for addr, fn in stubs:
        vm.install_stub(addr, fn)
    vm.switch_bank(bank)
    vm.vm_fp = fp
    vm.vm_sp = fp + frame_off
    for i, a in enumerate(args):
        vm.mem.write_word(fp + 11 + i * 2, a)
    vm.vm_pc = body
    vm.cpu.pc = vm.DISPATCHER_ADDR
    try:
        vm.run_until_outermost_return(max_ops=max_ops)
    except Exception:
        pass
    post = bytes(vm.mem.read(a) for a in range(0x6000, 0x8000))
    return post, vm.regL


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


def _combat_battle_setup(m, atk, deff, *, atk_men=10, def_men=8,
                         atk_col=3, def_col=5, row=2, def_home=True,
                         ai_state=0, momentum=0):
    """A minimal 2-unit (slot 0 each) tactical melee on the DEFENDER's real map.
    Sets scenario/const_two, ownership+daimyo, fief stats, unit men/positions,
    presence flags (defender bit7 = home), and the cur_combat cursors."""
    m.w16(M.SCENARIO_FIEF_COUNT, 17)
    m.w16(M.CONST_TWO, 2)
    m.selected = atk
    m.defending = deff
    m.w8(M.FIEF_TO_DAIMYO_MAP + atk, 1)
    m.w8(M.FIEF_TO_DAIMYO_MAP + deff, 2)
    da, dd = m.daimyo(1), m.daimyo(2)
    for off, v in [(M.D_HEALTH, 50), (M.D_DRIVE, 60), (M.D_LUCK, 40),
                   (M.D_CHARISMA, 30), (M.D_IQ, 70)]:
        m.w8(da + off, v)
    for off, v in [(M.D_HEALTH, 45), (M.D_DRIVE, 55), (M.D_LUCK, 50),
                   (M.D_CHARISMA, 60), (M.D_IQ, 50)]:
        m.w8(dd + off, v)
    fa, fd = m.fief(atk), m.fief(deff)
    for off, v in [(M.F_MORALE, 60), (M.F_SKILL, 80), (M.F_ARMS, 70), (M.F_HEADER, 1900)]:
        m.w16(fa + off, v)
    for off, v in [(M.F_MORALE, 50), (M.F_SKILL, 60), (M.F_ARMS, 55), (M.F_HEADER, 1900)]:
        m.w16(fd + off, v)
    m.w8(M.PROVINCE_AI_STATE + atk, ai_state)
    m.w8(M.PROVINCE_AI_STATE + deff, ai_state)
    m.w16(m.unit_strength_ptr(0, 0), atk_men)
    m.w16(m.unit_strength_ptr(1, 0), def_men)
    m.w8(m.unit_col_ptr(0, 0), atk_col); m.w8(m.unit_row_ptr(0, 0), row)
    m.w8(m.unit_col_ptr(1, 0), def_col); m.w8(m.unit_row_ptr(1, 0), row)
    # side resource men totals (+4) -- used by the casualty path
    m.w16(m.side_resource_ptr(0) + M.SR_MEN, atk_men)
    m.w16(m.side_resource_ptr(1) + M.SR_MEN, def_men)
    m.w8(M.WAR_SIDE_STATE_FLAG + 0, 0x01)                 # attacker slot0 present
    m.w8(M.WAR_SIDE_STATE_FLAG + 1, 0x81 if def_home else 0x01)  # +home bit7
    m.w8(M.UNIT_EXCHANGE_COUNT + 0, momentum)
    m.cur_combat_side = 0
    m.cur_combat_unit_slot = 0


def combat_tactical_check():
    """Validate the deterministic strength core vs na1dream: for several battle
    states diff the RETURN value of ai_eval_battle_strength_total ($9C8D, both
    sides) and calc_battle_strength_pct_one_side ($9D7A)."""
    from . import tactical as T
    EVAL = (0x9C8D, -4, 2)        # ai_eval_battle_strength_total(side,slot,other)
    PCT  = (0x9D7A, 0, 2)         # calc_battle_strength_pct_one_side(unit_type)

    cases = [
        dict(label="home-def, AI-home(scale100)", atk_men=10, def_men=8, ai_state=0),
        dict(label="no home, player(scale85)", atk_men=12, def_men=12, def_home=False, ai_state=5),
        dict(label="momentum=2", atk_men=9, def_men=6, momentum=2),
        dict(label="big attacker", atk_men=40, def_men=10, ai_state=0),
    ]
    ok = True
    for c in cases:
        label = c.pop("label")
        # ai_eval for the attacker (0,0,0) and defender (1,0,0)
        for side in (0, 1):
            mr = M.Memory(rng=DreamRNG())
            _combat_battle_setup(mr, 5, 8, **c)
            _, rom_ret = run_rom_ret(mr, *EVAL[:2], EVAL[2], args=(side, 0, 0))
            mp = M.Memory(rng=DreamRNG())
            _combat_battle_setup(mp, 5, 8, **c)
            py_ret = T.ai_eval_battle_strength_total(mp, side, 0, 0)
            match = (rom_ret == py_ret)
            ok = ok and match
            print(f"--- eval[{label}] side{side}: ROM {rom_ret}  py {py_ret}"
                  f"  => {'MATCH' if match else 'MISMATCH'}")
        # p-share
        mr = M.Memory(rng=DreamRNG())
        _combat_battle_setup(mr, 5, 8, **c)
        _, rom_p = run_rom_ret(mr, *PCT[:2], PCT[2], args=(0,))
        mp = M.Memory(rng=DreamRNG())
        _combat_battle_setup(mp, 5, 8, **c)
        py_p = T.calc_battle_strength_pct_one_side(mp, 0)
        match = (rom_p == py_p)
        ok = ok and match
        print(f"--- pct [{label}]: ROM {rom_p}  py {py_p}  => {'MATCH' if match else 'MISMATCH'}")

    # explicit TERRAIN exercise: scan the defender map for a castle(32)/forest(16)
    # cell, stand the defender unit on it, confirm the big terrain bonus matches.
    for feat, fname in [(32, "castle"), (16, "forest"), (8, "town")]:
        cell = None
        mscan = M.Memory(rng=DreamRNG()); mscan.w16(M.SCENARIO_FIEF_COUNT, 17); mscan.defending = 8
        for r in range(5):
            for col in range(11):
                if (T.read_map_cell(mscan, col, r) & 254) == feat:
                    cell = (col, r); break
            if cell:
                break
        if not cell:
            print(f"--- terrain[{fname}]: (no {fname} cell on map 8, skipped)")
            continue
        col, r = cell
        mr = M.Memory(rng=DreamRNG()); _combat_battle_setup(mr, 5, 8, def_men=20)
        mr.w8(mr.unit_col_ptr(1, 0), col); mr.w8(mr.unit_row_ptr(1, 0), r)
        _, rom_ret = run_rom_ret(mr, 0x9C8D, -4, 2, args=(1, 0, 0))
        mp = M.Memory(rng=DreamRNG()); _combat_battle_setup(mp, 5, 8, def_men=20)
        mp.w8(mp.unit_col_ptr(1, 0), col); mp.w8(mp.unit_row_ptr(1, 0), r)
        py_ret = T.ai_eval_battle_strength_total(mp, 1, 0, 0)
        match = (rom_ret == py_ret)
        ok = ok and match
        print(f"--- terrain[{fname}] @({col},{r}) def S: ROM {rom_ret}  py {py_ret}"
              f"  => {'MATCH' if match else 'MISMATCH'}")
    return ok


def _combat_state_addrs(m):
    """The (addr,size,name) tuples that fully describe a 2-unit melee state --
    both units' men/positions, both army totals, momentum, presence, the
    defending town. Used to diff ROM-post vs Python-post after a casualty op."""
    addrs = []
    for side in (0, 1):
        for slot in (0, 1):
            addrs.append((m.unit_strength_ptr(side, slot), 2, f"men[{side}][{slot}]"))
            addrs.append((m.unit_col_ptr(side, slot), 1, f"col[{side}][{slot}]"))
            addrs.append((m.unit_row_ptr(side, slot), 1, f"row[{side}][{slot}]"))
        addrs.append((m.side_resource_ptr(side) + M.SR_MEN, 2, f"army_men[{side}]"))
        addrs.append((M.WAR_SIDE_STATE_FLAG + side, 1, f"presence[{side}]"))
    for slot in range(5):
        addrs.append((M.UNIT_EXCHANGE_COUNT + slot, 1, f"momentum[{slot}]"))
    addrs.append((m.fief(m.defending) + M.F_TOWN, 2, "def_town"))
    return addrs


def _read_buf(buf, addr, size):
    o = addr - 0x6000
    return buf[o] if size == 1 else (buf[o] | (buf[o + 1] << 8))


def combat_casualty_check():
    """Validate apply_pct_reduction_to_unit_strength ($9D08) and the melee
    resolve_attack_apply_mutual_casualties ($9E25) vs na1dream, diffing the full
    2-unit combat state (men/positions/army-totals/momentum/presence/town)."""
    from . import tactical as T

    ok = True
    # --- apply_pct_reduction_to_unit_strength: deterministic, no UI cursor ---
    for side, slot, pct in [(1, 0, 40), (1, 0, 50), (1, 0, 100), (0, 0, 30)]:
        mr = M.Memory(rng=DreamRNG()); _combat_battle_setup(mr, 5, 8, atk_men=10, def_men=8)
        rom_post, _ = run_rom_ret(mr, 0x9D08, -4, 2, args=(side, slot, pct))
        mp = M.Memory(rng=DreamRNG()); _combat_battle_setup(mp, 5, 8, atk_men=10, def_men=8)
        T.apply_pct_reduction_to_unit_strength(mp, side, slot, pct)
        diffs = [n for a, s, n in _combat_state_addrs(mp)
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = not diffs
        ok = ok and match
        print(f"--- apply_pct_reduction(side{side},slot{slot},{pct}%): "
              f"{'MATCH' if match else 'MISMATCH ' + ','.join(diffs)}")

    # --- melee exchange: resolve_attack_apply_mutual_casualties(enemy_slot) ---
    for label, atk_men, def_men in [("even", 12, 12), ("atk-ahead", 30, 8), ("atk-behind", 6, 30)]:
        mr = M.Memory(rng=DreamRNG()); _combat_battle_setup(mr, 5, 8, atk_men=atk_men, def_men=def_men)
        # stub validate_phase_unit_cells_draw_cursor ($9B4A) -- pure cursor/audio UI
        rom_post, rom_ret = run_rom_ret(mr, 0x9E25, -2, 2, args=(0,),
                                        stubs=[(0x9B4A, lambda vm: 0)])
        mp = M.Memory(rng=DreamRNG()); _combat_battle_setup(mp, 5, 8, atk_men=atk_men, def_men=def_men)
        py_ret = T.resolve_attack_apply_mutual_casualties(mp, 0)
        diffs = [n for a, s, n in _combat_state_addrs(mp)
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = (not diffs) and rom_ret == py_ret
        ok = ok and match
        det = "" if match else (f"ret ROM{rom_ret}/py{py_ret} " + ",".join(diffs))
        print(f"--- melee[{label}] atk{atk_men}/def{def_men}: "
              f"{'MATCH' if match else 'MISMATCH ' + det}")

    # --- defection / Bribe: resolve_attack_apply_casualties(enemy_slot, gold) ---
    def bribe_setup(m, cha, gold, def_men=8):
        _combat_battle_setup(m, 5, 8, atk_men=10, def_men=def_men)
        m.w8(m.daimyo(1) + M.D_CHARISMA, cha)          # attacker Charisma -> wins/loses contest
        return gold
    for label, cha, gold, def_men in [("win-buy", 100, 40, 8),
                                      ("lose-contest", 10, 40, 8),
                                      ("underpaid", 100, 3, 8)]:
        mr = M.Memory(rng=DreamRNG()); g = bribe_setup(mr, cha, gold, def_men)
        rom_post, _ = run_rom_ret(mr, 0x9E78, -10, 2, args=(0, g),
                                  stubs=[(0x9B4A, lambda vm: 0)])
        mp = M.Memory(rng=DreamRNG()); bribe_setup(mp, cha, gold, def_men)
        T.resolve_attack_apply_casualties(mp, 0, g)
        addrs = _combat_state_addrs(mp) + [
            (mp.side_resource_ptr(0) + M.SR_GOLD, 2, "own_gold"),
            (mp.fief(8) + M.F_MORALE, 2, "enemy_morale"),
            (M.COMBAT_CASUALTY_SKIP, 1, "skip_flag")]
        diffs = [n for a, s, n in addrs
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = not diffs
        ok = ok and match
        print(f"--- bribe[{label}] cha{cha} gold{gold}: "
              f"{'MATCH' if match else 'MISMATCH ' + ','.join(diffs)}")
    return ok


def combat_setup_check():
    """Validate distribute_men_into_unit_strengths ($91DA) and battle_init_defender
    ($92CF) vs na1dream -- the men->units split and the defender snapshot."""
    from . import tactical as T

    def set_split(m, prov, pcts):
        for i, v in enumerate(pcts):
            m.w8(M.PROVINCE_UNIT_TYPE_PCT + prov * 5 + i, v)

    ok = True
    # --- distribute_men: total men split across slots by the % table ---
    for label, a_men, d_men, a_split, d_split in [
            ("even-split", 100, 60, (50, 30, 20, 0, 0), (40, 40, 20, 0, 0)),
            ("remainder", 97, 33, (33, 33, 34, 0, 0), (50, 25, 25, 0, 0)),
            ("five-way", 120, 50, (20, 20, 20, 20, 20), (60, 10, 10, 10, 10))]:
        mr = M.Memory(rng=DreamRNG()); _combat_battle_setup(mr, 5, 8)
        mr.w16(mr.side_resource_ptr(0) + M.SR_MEN, a_men)
        mr.w16(mr.side_resource_ptr(1) + M.SR_MEN, d_men)
        mr.w8(M.WAR_SIDE_STATE_FLAG + 0, 0); mr.w8(M.WAR_SIDE_STATE_FLAG + 1, 0)
        set_split(mr, 5, a_split); set_split(mr, 8, d_split)
        rom_post, _ = run_rom_ret(mr, 0x91DA, -12, 2)
        mp = M.Memory(rng=DreamRNG()); _combat_battle_setup(mp, 5, 8)
        mp.w16(mp.side_resource_ptr(0) + M.SR_MEN, a_men)
        mp.w16(mp.side_resource_ptr(1) + M.SR_MEN, d_men)
        mp.w8(M.WAR_SIDE_STATE_FLAG + 0, 0); mp.w8(M.WAR_SIDE_STATE_FLAG + 1, 0)
        set_split(mp, 5, a_split); set_split(mp, 8, d_split)
        T.distribute_men_into_unit_strengths(mp)
        addrs = []
        for side in (0, 1):
            for slot in range(5):
                addrs.append((mp.unit_strength_ptr(side, slot), 2, f"men[{side}][{slot}]"))
                addrs.append((mp.unit_col_ptr(side, slot), 1, f"col[{side}][{slot}]"))
            addrs.append((M.WAR_SIDE_STATE_FLAG + side, 1, f"presence[{side}]"))
        diffs = [n for a, s, n in addrs
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = not diffs
        ok = ok and match
        print(f"--- distribute_men[{label}]: {'MATCH' if match else 'MISMATCH ' + ','.join(diffs)}")

    # --- battle_init_defender: snapshot + distribute ---
    for label, dg, dr, dm, cap in [("normal", 100, 200, 60, 0),
                                   ("capital", 80, 150, 90, 1),
                                   ("no-rice(depleted)", 50, 0, 40, 0),
                                   ("no-men(depleted)", 50, 80, 0, 0)]:
        mr = M.Memory(rng=DreamRNG()); _combat_battle_setup(mr, 5, 8)
        mr.w16(mr.side_resource_ptr(0) + M.SR_MEN, 80)         # attacker total (pre-set)
        set_split(mr, 5, (50, 30, 20, 0, 0)); set_split(mr, 8, (40, 40, 20, 0, 0))
        fd = mr.fief(8)
        mr.w16(fd + M.F_GOLD, dg); mr.w16(fd + M.F_RICE, dr); mr.w16(fd + M.F_MEN, dm)
        mr.w8(M.FIEF_IS_CAPITAL + 8, cap)
        mr.w8(M.WAR_SIDE_STATE_FLAG + 0, 0); mr.w8(M.WAR_SIDE_STATE_FLAG + 1, 0)
        rom_post, rom_ret = run_rom_ret(mr, 0x92CF, -2, 2)
        mp = M.Memory(rng=DreamRNG()); _combat_battle_setup(mp, 5, 8)
        mp.w16(mp.side_resource_ptr(0) + M.SR_MEN, 80)
        set_split(mp, 5, (50, 30, 20, 0, 0)); set_split(mp, 8, (40, 40, 20, 0, 0))
        fd = mp.fief(8)
        mp.w16(fd + M.F_GOLD, dg); mp.w16(fd + M.F_RICE, dr); mp.w16(fd + M.F_MEN, dm)
        mp.w8(M.FIEF_IS_CAPITAL + 8, cap)
        mp.w8(M.WAR_SIDE_STATE_FLAG + 0, 0); mp.w8(M.WAR_SIDE_STATE_FLAG + 1, 0)
        py_ret = T.battle_init_defender(mp)
        addrs = [(mp.side_resource_ptr(1) + M.SR_GOLD, 2, "wd_gold"),
                 (mp.side_resource_ptr(1) + M.SR_RICE, 2, "wd_rice"),
                 (mp.side_resource_ptr(1) + M.SR_MEN, 2, "wd_men"),
                 (M.BATTLE_DEFENDER_STATUS, 1, "status66"),
                 (M.CUR_COMBAT_SIDE, 2, "cur_side"),
                 (M.BATTLE_WINNER_PROV, 2, "winner")]
        for slot in range(5):
            addrs.append((mp.unit_strength_ptr(1, slot), 2, f"dmen[{slot}]"))
        diffs = [n for a, s, n in addrs
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = (not diffs) and rom_ret == py_ret
        ok = ok and match
        det = "" if match else (f"ret ROM{rom_ret}/py{py_ret} " + ",".join(diffs))
        print(f"--- battle_init_defender[{label}]: {'MATCH' if match else 'MISMATCH ' + det}")
    return ok


def _deploy_setup(m, cur_side=0):
    """A pre-DEPLOYED 2v2 melee: attacker (5) slots 0/1, defender (8) slots 0/1,
    units adjacent so the AI engages. No RNG spent on placement (deploy skipped),
    so the only draws in the turn are the per-unit ai_rng_resolve_combat rolls."""
    _combat_battle_setup(m, 5, 8, atk_men=30, def_men=24)
    # two units a side
    for side, men0, men1 in [(0, 18, 12), (1, 14, 10)]:
        m.w16(m.unit_strength_ptr(side, 0), men0)
        m.w16(m.unit_strength_ptr(side, 1), men1)
        m.w16(m.side_resource_ptr(side) + M.SR_MEN, men0 + men1)
        m.w16(m.side_resource_ptr(side) + M.SR_RICE, 200)
        m.w16(m.side_resource_ptr(side) + M.SR_GOLD, 50)
        m.w8(M.WAR_SIDE_STATE_FLAG + side, 0x03 | (0x80 if side == 1 else 0))
    # positions: attacker col 4, defender col 5 (adjacent), rows 1 & 2
    m.w8(m.unit_col_ptr(0, 0), 4); m.w8(m.unit_row_ptr(0, 0), 2)
    m.w8(m.unit_col_ptr(0, 1), 4); m.w8(m.unit_row_ptr(0, 1), 1)
    m.w8(m.unit_col_ptr(1, 0), 5); m.w8(m.unit_row_ptr(1, 0), 2)
    m.w8(m.unit_col_ptr(1, 1), 5); m.w8(m.unit_row_ptr(1, 1), 1)
    # arena rect = full grid
    m.w16(M.COMBAT_ARENA_X_MIN, 0); m.w16(M.COMBAT_ARENA_Y_MIN, 0)
    m.w16(M.COMBAT_ARENA_X_MAX, 10); m.w16(M.COMBAT_ARENA_Y_MAX, 4)
    m.cur_combat_side = cur_side


def combat_turn_check():
    """Validate run_both_sides_combat_turn ($ADD6) vs na1dream -- one full combat
    day of AI actions for both sides, in LCG lockstep. Diffs every unit's
    men/position/presence, both army totals, the defending fief morale (breach),
    and the winner selector."""
    from . import tactical as T

    ok = True
    for cur_side in (0, 1):
        mr = M.Memory(rng=DreamRNG()); _deploy_setup(mr, cur_side)
        # fp=0x0480 keeps the `day` arg (fp+11) BELOW the $0600 OAM sprite shadow
        # that the combat UI scribbles -- else na1dream's 2nd side reads a clobbered
        # day (>5) and turns aggressive while py stays on day 1.
        rom_post, rom_ret = run_rom_ret(mr, 0xADD6, -6, 2, args=(1,), fp=0x0480,
                                        stubs=[(0x9B4A, lambda vm: 0)])
        mp = M.Memory(rng=DreamRNG()); _deploy_setup(mp, cur_side)
        py_ret = T.run_both_sides_combat_turn(mp, 1)
        addrs = []
        for side in (0, 1):
            for slot in range(5):
                addrs.append((mp.unit_strength_ptr(side, slot), 2, f"men[{side}][{slot}]"))
                addrs.append((mp.unit_col_ptr(side, slot), 1, f"col[{side}][{slot}]"))
                addrs.append((mp.unit_row_ptr(side, slot), 1, f"row[{side}][{slot}]"))
            addrs.append((M.WAR_SIDE_STATE_FLAG + side, 1, f"presence[{side}]"))
            addrs.append((mp.side_resource_ptr(side) + M.SR_MEN, 2, f"army[{side}]"))
        addrs.append((mp.fief(8) + M.F_MORALE, 2, "def_morale"))
        addrs.append((M.BATTLE_WINNER_PROV, 2, "winner"))
        diffs = [n for a, s, n in addrs
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        match = (not diffs) and rom_ret == py_ret
        ok = ok and match
        det = "" if match else (f"ret ROM{rom_ret}/py{py_ret} " + ",".join(diffs[:8]))
        print(f"--- combat_turn[cur_side={cur_side}]: {'MATCH' if match else 'MISMATCH ' + det}")
    return ok


def _pre_deploy_state(m, splits=(50, 30, 20, 0, 0), a_men=120, d_men=90):
    """A post-battle_init_defender image (RNG-free): committed attacker force in
    side 0, defender snapshot + men distributed into units, positions off-map,
    cur_combat_side=1 -- the exact state deploy_both_sides_units_loop starts from."""
    from . import tactical as T
    _combat_battle_setup(m, 5, 8)
    m.w16(m.side_resource_ptr(0) + M.SR_MEN, a_men)
    m.w16(m.side_resource_ptr(0) + M.SR_GOLD, 100)
    m.w16(m.side_resource_ptr(0) + M.SR_RICE, 200)
    fd = m.fief(8)
    m.w16(fd + M.F_MEN, d_men); m.w16(fd + M.F_GOLD, 60); m.w16(fd + M.F_RICE, 150)
    for p in (5, 8):
        for i, v in enumerate(splits):
            m.w8(M.PROVINCE_UNIT_TYPE_PCT + p * 5 + i, v)
    T.battle_init_defender(m)             # RNG-free: distribute + clear positions + cur_side=1


def combat_deploy_check():
    """Validate deploy_both_sides_units_loop ($9B0D) vs na1dream in LCG lockstep --
    the RNG-driven unit placement (approach rect + rng cell search + random fill).
    Diffs every unit's column/row/presence on both sides."""
    from . import tactical as T
    ok = True
    for label, a_men, d_men in [("std", 120, 90), ("big-atk", 200, 60), ("even", 80, 80)]:
        mp = M.Memory(rng=DreamRNG()); _pre_deploy_state(mp, a_men=a_men, d_men=d_men)
        pre = bytes(mp.m[0x6000:0x8000])
        mr = M.Memory(rng=DreamRNG()); mr.m[0x6000:0x8000] = pre
        rom_post, _ = run_rom_ret(mr, 0x9B0D, -4, 2, fp=0x0480)
        mp.rng = DreamRNG()
        T.deploy_both_sides_units_loop(mp)
        diffs = []
        for side in (0, 1):
            for slot in range(5):
                for a, s, n in [(mp.unit_col_ptr(side, slot), 1, f"col{side}{slot}"),
                                (mp.unit_row_ptr(side, slot), 1, f"row{side}{slot}")]:
                    if _read_buf(rom_post, a, s) != mp.r8(a):
                        diffs.append(f"{n}:R{_read_buf(rom_post,a,s)}/p{mp.r8(a)}")
            if _read_buf(rom_post, M.WAR_SIDE_STATE_FLAG + side, 1) != mp.r8(M.WAR_SIDE_STATE_FLAG + side):
                diffs.append(f"present{side}")
        ok = ok and not diffs
        print(f"--- deploy[{label}]: {'MATCH' if not diffs else 'MISMATCH ' + ' '.join(diffs[:6])}")
    return ok


def combat_conquest_check():
    """Validate apply_conquest_outcome ($E041, bank 15) vs na1dream -- survivors
    sum into the conquered fief, ownership flips, stats blend, lords shift. Diffs
    the defending fief record + ownership/capital + both lords' stat bytes."""
    from . import tactical as T

    def setup(m, atk_won, cap_fell):
        _combat_battle_setup(m, 5, 8)
        m.w16(M.BATTLE_WINNER_PROV, 8 if atk_won else 5)
        m.w16(M.WAR_ATTACKER_GOLD, 70); m.w16(M.WAR_ATTACKER_RICE, 40); m.w16(M.WAR_ATTACKER_MEN, 55)
        m.w16(M.WAR_DEFENDER_GOLD, 20); m.w16(M.WAR_DEFENDER_RICE, 15); m.w16(M.WAR_DEFENDER_MEN, 18)
        m.w8(M.WAR_SIDE_STATE_FLAG + 0, 0x80 if cap_fell else 0x01)   # bit7 -> capital fell
        m.w8(M.WAR_SIDE_STATE_FLAG + 1, 0x80 if cap_fell else 0x01)
        fd = m.fief(8)
        for off, v in [(M.F_MORALE, 50), (M.F_SKILL, 60), (M.F_ARMS, 55), (M.F_HEADER, 1900),
                       (M.F_OUTPUT, 200), (M.F_MEN, 18)]:
            m.w16(fd + off, v)

    ok = True
    for label, atk_won, cap_fell in [("atk-won", True, False), ("atk-lost", False, False),
                                     ("capital-fell", True, True)]:
        mr = M.Memory(rng=DreamRNG()); setup(mr, atk_won, cap_fell)
        rom_post, _ = run_rom_ret(mr, 0xE041, -12, 15, fp=0x0480)
        mp = M.Memory(rng=DreamRNG()); setup(mp, atk_won, cap_fell)
        T.apply_conquest_outcome(mp, mp.rng)
        fd = mp.fief(8)
        addrs = [(fd + off, 2, n) for off, n in [(M.F_GOLD, "gold"), (M.F_RICE, "rice"),
                 (M.F_MEN, "men"), (M.F_MORALE, "mor"), (M.F_SKILL, "skl"), (M.F_ARMS, "arm")]]
        addrs += [(M.FIEF_TO_DAIMYO_MAP + 8, 1, "owner8"), (M.FIEF_IS_CAPITAL + 8, 1, "cap8"),
                  (M.FIEF_IS_CAPITAL + 5, 1, "cap5")]
        for off, n in [(M.D_DRIVE, "Dwin"), (M.D_CHARISMA, "Chwin"), (M.D_IQ, "IQwin")]:
            addrs.append((mp.daimyo(1) + off, 1, n))
            addrs.append((mp.daimyo(2) + off, 1, n + "L"))
        diffs = [n for a, s, n in addrs
                 if _read_buf(rom_post, a, s) != (mp.r16(a) if s == 2 else mp.r8(a))]
        ok = ok and not diffs
        print(f"--- conquest[{label}]: {'MATCH' if not diffs else 'MISMATCH ' + ','.join(diffs)}")
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

    print("\n  --- TACTICAL: strength core (ai_eval / calc_pct / terrain) ---")
    results.append(combat_tactical_check())
    print("\n  --- TACTICAL: casualties (apply_pct / melee / bribe) ---")
    results.append(combat_casualty_check())
    print("\n  --- TACTICAL: setup (distribute_men / battle_init_defender) ---")
    results.append(combat_setup_check())
    print("\n  --- TACTICAL: per-day driver (run_both_sides_combat_turn) ---")
    results.append(combat_turn_check())
    print("\n  --- TACTICAL: deploy (deploy_both_sides_units_loop, LCG lockstep) ---")
    results.append(combat_deploy_check())
    print("\n  --- TACTICAL: conquest resolution (apply_conquest_outcome $E041) ---")
    results.append(combat_conquest_check())

    print(f"\n=== {sum(results)}/{len(results)} routines MATCH ===")


if __name__ == "__main__":
    main()
