"""
setup.py — build a faithful flat-memory board for a new game by driving the ROM's
deterministic setup core, apply_scenario_starting_stat_boosts ($83E2), HEADLESS in
na1dream. We do NOT transcribe or mock the header-cap / stat-boost generation; the
ROM does it.

The UI-heavy init_new_game_state ($89A3) is skipped entirely (title screens, the
scenario-size + "how many players" prompts, the daimyo-roll screens) — those are
the runner's job (canned choices). We populate the base scenario records from the
trusted txt data, seed the market, then let $83E2 do:
  - the random header roll   header = pct_op(data + 1000, rng(20)+80)  (~1700-1900)
  - the difficulty stat boosts (+const_two*N to daimyo + fief stats)
  - the 50%/boosted-fief rolls + marriages
  - the gold_rice_exchange_rate seed (rng(6)+20)

Result: a flat memmap.Memory the Python turn loop runs on, with FULL per-turn
stats (the loop stays Python; na1dream is used ONCE, for setup only).

Smoke:  py -3 -m na1sim.setup
"""

import random
import sys
from pathlib import Path

from . import memmap as M
from . import loader

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
sys.path.insert(0, str(REPO / "tools"))
from na1dream.nobunaga_vm import NobunagaVM          # noqa: E402

# apply_scenario_starting_stat_boosts $83E2 (body @ $83E7, frame_off -40, bank 0)
BOOST_BODY, BOOST_FRAME_OFF, BOOST_BANK = 0x83E7, -40, 0

# fief record (offset, Province attr) -- write order is irrelevant, all 13 fields
_FIELDS = [(M.F_GOLD, "gold"), (M.F_DEBT, "debt"), (M.F_TOWN, "town"), (M.F_RICE, "rice"),
           (M.F_OUTPUT, "output"), (M.F_DAMS, "dams"), (M.F_LOYALTY, "loyalty"),
           (M.F_WEALTH, "wealth"), (M.F_MEN, "men"), (M.F_MORALE, "morale"),
           (M.F_SKILL, "skill"), (M.F_ARMS, "arms"), (M.F_HEADER, "header")]
# daimyo record [age, H, D, L, Ch, IQ, status]
_DAIMYO_STATS = [(M.D_AGE, "age"), (M.D_HEALTH, "health"), (M.D_DRIVE, "drive"),
                 (M.D_LUCK, "luck"), (M.D_CHARISMA, "charisma"), (M.D_IQ, "iq"),
                 (M.D_STATUS, "status")]


def _run_boost(m: "M.Memory", rng_state: int) -> None:
    """Drive apply_scenario_starting_stat_boosts on m's $6000-$7FFF image, in
    place. rng_state seeds na1dream's LCG so each game seed gets a distinct board."""
    vm = NobunagaVM()
    vm._rng = rng_state & 0xFFFF
    vm.mem.sram[:] = bytes(m.m[0x6000:0x8000])
    vm.switch_bank(BOOST_BANK)
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = fp + BOOST_FRAME_OFF
    vm.vm_pc = BOOST_BODY
    vm.cpu.pc = vm.DISPATCHER_ADDR
    try:
        vm.run_until_outermost_return(max_ops=500000)
    except Exception:
        pass                                          # benign end-of-run trap
    for a in range(0x6000, 0x8000):
        m.m[a] = vm.mem.read(a)


def build_board(skill: int = 2, seed: int = 0, player_fief=None) -> "M.Memory":
    """Build a faithful flat-memory board. player_fief=None -> all-AI (player==0)."""
    provs = loader.load_provinces()                   # base stats incl. BASE header (1000/500/0)
    daimyos = loader.load_daimyos()
    adj = loader.load_adjacency()
    rng = random.Random(seed)

    # Seed the AI's RNG (m.rng, used by rng_mod) DETERMINISTICALLY off the game seed --
    # else M.Memory() defaults to system entropy and the same seed gives different games.
    m = M.Memory(rng=random.Random(seed * 1000003 + 7))
    m.w16(M.CONST_TWO, skill)
    m.w16(M.SCENARIO_FIEF_COUNT, len(provs))
    m.w16(M.CURRENT_GAME_YEAR, 1560)

    for p in provs:
        f = m.fief(p.idx)
        for off, attr in _FIELDS:
            m.w16(f + off, getattr(p, attr) & 0xFFFF)
        m.w8(M.FIEF_TO_DAIMYO_MAP + p.idx, p.idx)     # each fief owned by its own clan
        m.w8(M.FIEF_IS_CAPITAL + p.idx, 1)
        m.w8(M.PROVINCE_AI_STATE + p.idx, M.AI_HOME)
        m.neighbor_rows[p.idx] = list(adj.get(p.idx, []))

    if player_fief is not None:
        m.w8(M.PROVINCE_AI_STATE + player_fief, M.PLAYER_DIRECT)

    for d in daimyos:
        dr = m.daimyo(d.id)
        for off, attr in _DAIMYO_STATS:
            m.w8(dr + off, getattr(d, attr) & 0xFF)

    # market seed: init_new_game_state writes $6E0B[0..4] = rng(10)+8; $83E2 then
    # overwrites the exchange rate ($6E0D). (Per-season roll_period_market_rates
    # re-rolls these later in the loop.)
    for k in range(5):
        m.w16(M.MARKET_RATE_TABLE + k * 2, rng.randrange(10) + 8)

    # ROM deterministic setup core -> headers / boosts / exchange. Seed na1dream's
    # LCG off the game seed so boards vary by seed.
    _run_boost(m, rng_state=0x1234 ^ ((seed * 2654435761) & 0xFFFF))

    # init the low-water marks from the boosted records (init_province_highwater
    # _from_records $A066): mark = live output/dams/loyalty/wealth.
    for p in provs:
        f, mk = m.fief(p.idx), m.mark(p.idx)
        m.w16(mk + M.MK_OUTPUT, m.r16(f + M.F_OUTPUT))
        m.w16(mk + M.MK_DAMS, m.r16(f + M.F_DAMS))
        m.w16(mk + M.MK_LOYALTY, m.r16(f + M.F_LOYALTY))
        m.w16(mk + M.MK_WEALTH, m.r16(f + M.F_WEALTH))
    return m


# ---------------------------------------------------------------------------
# smoke: the board comes out faithfully boosted (headers ~1700-1900, stats up)
# ---------------------------------------------------------------------------
def _smoke():
    provs = loader.load_provinces()
    base_hdr = {p.idx: p.header for p in provs}
    base = {p.idx: dict(gold=p.gold, men=p.men, output=p.output) for p in provs}

    m = build_board(skill=2, seed=0)
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    hdrs = [m.r16(m.fief(i) + M.F_HEADER) for i in range(n)]
    print(f"setup smoke -- {n}-fief board, skill {m.skill}, year {m.year}")
    print(f"  headers: {hdrs}")
    print(f"  header range {min(hdrs)}-{max(hdrs)} (base koku {sorted(set(base_hdr.values()))}"
          f" -> pct_op(base+1000, rng80..99))")
    # every header is the boosted form of its base koku
    for i in range(n):
        b = base_hdr[i]
        lo, hi = (b + 1000) * 80 // 100, (b + 1000) * 99 // 100 + 2
        assert lo <= hdrs[i] <= hi, f"fief {i}: header {hdrs[i]} not in [{lo},{hi}] for base {b}"

    # difficulty boost landed on stats (gold +const_two*10, etc.) and daimyo stats
    h = 5  # Hida
    f = m.fief(h)
    print(f"  Hida: gold {base[h]['gold']}->{m.r16(f+M.F_GOLD)} "
          f"men {base[h]['men']}->{m.r16(f+M.F_MEN)} "
          f"output {base[h]['output']}->{m.r16(f+M.F_OUTPUT)}")
    d = m.daimyo(m.fief_owner(h))
    print(f"  Hida lord (daimyo {m.fief_owner(h)}): drive(+2)={m.r8(d+M.D_DRIVE)} "
          f"charisma(+4)={m.r8(d+M.D_CHARISMA)}")
    # Hida isn't in the boosted-fief set {1,2,4,7,10,15,16}, so it gets only the
    # general difficulty boost: gold += const_two*10, the rest += const_two*5.
    assert m.r16(f + M.F_GOLD) == base[h]["gold"] + m.skill * 10, m.r16(f + M.F_GOLD)
    assert m.r16(f + M.F_MEN) == base[h]["men"] + m.skill * 5, m.r16(f + M.F_MEN)

    # market seeded
    print(f"  market: exchange={m.r16(M.GOLD_RICE_EXCHANGE)} (rng6+20=20..25) "
          f"hire={m.r16(M.GOLD_MEN_HIRE_RATE)} arms={m.r16(M.ARMS_BUY_PRICE_RATE)}")
    assert 20 <= m.r16(M.GOLD_RICE_EXCHANGE) <= 25, m.r16(M.GOLD_RICE_EXCHANGE)

    # board varies by seed
    m2 = build_board(skill=2, seed=1)
    hdrs2 = [m2.r16(m2.fief(i) + M.F_HEADER) for i in range(n)]
    assert hdrs != hdrs2, "different seeds should give different boards"
    print(f"  seed 1 headers differ: {hdrs2[:5]}... (board varies by seed) OK")
    print("setup smoke: PASS")


if __name__ == "__main__":
    _smoke()
