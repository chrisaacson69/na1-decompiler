"""
Flat memory model for the faithful (Plan B) transcription of the daimyo-AI
command routines from source/4-c/bank_01.c.

WHY A FLAT MEMORY INSTEAD OF NAMED FIELDS
-----------------------------------------
The decompiled C is exact about DATA: it reads/writes one flat NES work-RAM/SRAM
image via raw pointer arithmetic --

    fief   = selected_province_idx * 26 + 0x7001     # the 26-byte fief record
    daimyo = fief_owner * 7         + 0x752F          # the 7-byte daimyo record
    rate   = 0x6E0B + k*2                              # the market-rate table
    *(word*)(fief + 18)  = morale ;  *(word*)(fief + 8) = output ; ...

Re-expressing that against hand-named Python fields is precisely where the
earlier port kept LOSING field-writes -- three dropped gold-sinks (arms-buy,
feed#2, the $95C9 surplus-drain) and counting. So Plan B models the SAME flat
memory the ROM uses; the transcribed routines then read/write it with
`m.r16(fief + MORALE)` -- line-for-line with the C, and trivially diffable
against the na1dream bytecode oracle (Plan A), which operates on this identical
layout.

GROUNDING
---------
Addresses come from mesen-labels.toml + the .mlb, cross-checked against the
decompiled accessors in source/4-c:
  - daimyo_record_addr  $D7CD :  id  * 7  + 0x752F
  - fief record idiom   ch.9  :  idx * 26 + 0x7001
  - fief_owner          $D772 :  fief_to_daimyo_map[$6E15][fief]
  - get_province_ai_state $D98D: province_ai_state[$6CF7][fief]
  - get_fief_daimyo_charisma $946D: daimyo_record + 4
Everything the AI economy path touches lives in $6CF7..$752F+; nothing above
$8000 (that window is ROM/code, which in Plan B becomes Python, not data).

ENDIANNESS / SIGNEDNESS
-----------------------
6502/NES is little-endian; r16/w16 assume that (confirm against na1dream on the
first oracle pass). The C does signed `< 0` clamps on `word` subtractions
(e.g. ai_calc_men_surplus: `gold - men; if (<0) =0`), so a 16-bit *signed* view
(`s16`) is provided for exactly those sites; everything else is unsigned 16-bit
with wrap on write.
"""

# ---------------------------------------------------------------------------
# Address map
# ---------------------------------------------------------------------------
MEM_SIZE = 0x8000          # all work-RAM/SRAM below the ROM window

# --- fief record table ($7001, stride 26 = 0x1A) -------------------------
# 51 slots: idx 0..49 real fiefs (17 used in the 17-fief scenario), idx 50 =
# the uprising / zealot slot (header sentinel 9999).
FIEF_TABLE  = 0x7001
FIEF_STRIDE = 26
FIEF_SLOTS  = 51

# field offsets within a fief record (all 16-bit words)
F_GOLD    = 0      # $7001
F_DEBT    = 2      # $7003
F_TOWN    = 4      # $7005
F_RICE    = 6      # $7007  (provisions; a fief with rice==0 has 0 provisioned men)
F_OUTPUT  = 8      # $7009
F_DAMS    = 10     # $700B  (capped 0..100)
F_LOYALTY = 12     # $700D
F_WEALTH  = 14     # $700F  (label explicitly REFUTES "arms" here -- arms is +22)
F_MEN     = 16     # $7011
F_MORALE  = 18     # $7013
F_SKILL   = 20     # $7015
F_ARMS    = 22     # $7017
F_HEADER  = 24     # $7019  per-fief cap ("header"); develop/recruit clamp to this

# --- province low-water marks ($6003, stride 8) -- the harvest income basis --
# NAME is "high-water" but the op is MIN: update_province_highwater_marks $A0A9
# does mark = min(mark, live) at Fall (asm $A0C5 SCMPGE mark>=live -> mark=live,
# verified); init_province_highwater_from_records $A066 resets mark=live at Summer.
# So income tracks the WORST value since Summer (development lags a year, damage
# bites immediately). 4 words/fief: output/dams/loyalty/wealth.
MARKS_TABLE  = 0x6003
MARKS_STRIDE = 8
MK_OUTPUT  = 0     # om
MK_DAMS    = 2     # dm
MK_LOYALTY = 4     # lm
MK_WEALTH  = 6     # wm

# --- daimyo record table ($752F, stride 7) -------------------------------
# daimyo_record_addr(id) = id*7 + 0x752F. Sits exactly after the 51-slot fief
# table (0x7001 + 51*26 == 0x752F).
DAIMYO_TABLE  = 0x752F
DAIMYO_STRIDE = 7

# daimyo record byte fields -- [age, H, D, L, Ch, IQ, status] (the $7560 Tokugawa
# record label: "age + H + D + L + Ch + IQ + status, 7 bytes"). Grounded.
D_AGE      = 0     # ages +1/period; new-daimyo init = rng(20)+20
D_HEALTH   = 1     # decays -1/period; natural-death gate
D_DRIVE    = 2     # aggression dial -- war gates + low-drive skip + monk check read +2
D_LUCK     = 3     # drifts +rng(11)-5 each period
D_CHARISMA = 4     # get_fief_daimyo_charisma $946D; harvest RNG ceiling + subsidy
D_IQ       = 5     # effect_train reads the (+5,+3)=IQ,Luck pair
D_STATUS   = 6

# --- per-fief byte arrays ------------------------------------------------
PROVINCE_AI_STATE  = 0x6CF7   # byte/fief: 0=AI Home, 5=player Direct, 255=empty
FIEF_TAX_RATE      = 0x6D2D   # byte/fief
FIEF_IS_CAPITAL    = 0x6DA2   # byte/fief: the "Home"/seat flag
FIEF_TO_DAIMYO_MAP = 0x6E15   # byte/fief -> owning daimyo id

# --- per-daimyo byte arrays ----------------------------------------------
DAIMYO_WEAKNESS_FLAG = 0x6DD4  # byte/daimyo (fief_owner_weakness reads this)

# --- scalar globals ------------------------------------------------------
CONST_TWO           = 0x6D63   # skill/difficulty dial (1..5, default 2);
                               # used as const_two+3, const_two*3, 6-const_two
SCENARIO_FIEF_COUNT = 0x6D9D   # word: 17 or 50
CURRENT_GAME_YEAR   = 0x6D9F   # word, base 1560 ($0618); AI caps use year-1559
AI_TURN_FLAGS       = 0x6DA1   # byte bitfield
AI_PLAYER_COUNT     = 0x6E09   # word: 8 - human players
SELECTED_PROVINCE   = 0x6F5F   # word: the fief currently being acted on (attacker/self)
BATTLE_DEFENDING    = 0x6F63   # word: the target/defender fief

# --- market rate table ($6E0B, word stride 2) ----------------------------
# roll_period_market_rates $924A random-walks these each period.
MARKET_RATE_TABLE   = 0x6E0B
LOAN_RATE           = 0x6E0B   # [0]
GOLD_RICE_EXCHANGE  = 0x6E0D   # [1]  gold<->rice convert
ARMS_BUY_PRICE_RATE = 0x6E0F   # [2]  arms price (= year_scaled/2)
GOLD_MEN_HIRE_RATE  = 0x6E11   # [3]  gold per man (= pct_op(year_base,70))
HIRE_GOLD_RATE      = 0x6E13   # [4]

# --- war / relations globals (ai_try_war_attack + ai_commit_attack_deduct) ---
RELATIONS_MATRIX     = 0x6193   # byte cell [a][b] at a*54 + b + base (stride 54)
RELATIONS_STRIDE     = 54
DEDUPED_OWNER_LIST    = 0x6F4F  # FF-terminated candidate fief list (the war working set)
MINORITY_OWNER_TABLE = 0x6E7F   # byte/fief -> owner id for the men-minority override
UI_CONFIRM_FLAG      = 0x6E7D   # ui_confirm_flag_6e7d (skips the human announce branch)
REST_TURNS           = 0x6D67   # byte/daimyo -> seasons resting (gates the siege-flag roll)
AI_REDISPATCH_FLAG   = 0x6F79   # ai_turn_loop_redispatch_flag
WAR_SIDE_STATE_FLAG  = 0x6F65   # bit7 = siege; set from rng_mod(2)<<7 at a capital
WAR_ATTACKER_GOLD    = 0x6F7D   # committed-force snapshot (attacker triple +0/+6/+16)
WAR_ATTACKER_RICE    = 0x6F7F
WAR_ATTACKER_MEN     = 0x6F81
WAR_DEFENDER_GOLD    = 0x6F83   # defender snapshot triple
WAR_DEFENDER_RICE    = 0x6F85
WAR_DEFENDER_MEN     = 0x6F87

# --- bank-2 TACTICAL combat state ----------------------------------------
# The on-screen battle. Two sides (0=attacker, 1=defender), each up to 5 unit
# slots. Geometry on an 11x5 grid (cols 0..10, rows 0..4). Sources: bank_02.c
# accessors + mesen-labels.toml [HIGH CONFIRMED] entries.
#
# side_resource_ptr(side) = side*6 + 0x6F7D  -> the attacker/defender triples
#   ABOVE are exactly side 0 / side 1 of this table: +0 gold, +2 rice, +4 MEN
#   (the per-side army TOTAL; consume_daily_battle_rice drains rice by men/30).
SIDE_RESOURCE_BASE   = 0x6F7D   # = WAR_ATTACKER_GOLD; side*6, +0 gold +2 rice +4 men
SR_GOLD = 0
SR_RICE = 2
SR_MEN  = 4
UNIT_STRENGTH_BASE   = 0x6FBC   # word[2][5]: side*10 + slot*2 -> a unit's men
UNIT_COL_BASE        = 0x6FD0   # byte[2][5]: side*5 + slot -> map column (X); 200=off-map
UNIT_ROW_BASE        = 0x6FDA   # byte[2][5]: side*5 + slot -> map row (Y)
# war_side_state_flag[side] ($6F65) is PACKED: bits 0..4 = unit-slot presence,
# bit 7 = war/siege (home) state.  is_unit_present = bit slot; test bit7 = home.
UNIT_PRESENCE_MASK_ALL = 31     # bits 0..4 (distribute_men sets these)
COMBAT_ARENA_X_MIN   = 0x6FF6   # tactical bounding rect [x_min,y_min,x_max,y_max]
COMBAT_ARENA_Y_MIN   = 0x6FF8
COMBAT_ARENA_X_MAX   = 0x6FFA
COMBAT_ARENA_Y_MAX   = 0x6FFC
BATTLE_WINNER_PROV   = 0x6F57   # winner/survivor province selector ($DEC6 reassign)
BATTLE_DEFENDER_STATUS = 0x6F66 # bit7 = defending fief's capital flag (snapshot)
CUR_COMBAT_UNIT_SLOT = 0x7BE4   # word: current unit slot 0..4
CUR_COMBAT_SIDE      = 0x7BE8   # word: current side (0=attacker / 1=defender)
BATTLE_SIDE_STR_MOD  = 0x7BEA   # word[2]: per-side 8-stat weight sum (ai_sum_battle_strength)
UNIT_EXCHANGE_COUNT  = 0x7BEE   # byte[5]: per-enemy-slot prior-exchange count (momentum)
COMBAT_CASUALTY_SKIP = 0x7BF3   # gate suppressing the defection casualty-apply branch
PROVINCE_UNIT_TYPE_PCT = 0x76A9 # byte[51][5]: prov*5 -> per-unit-type composition %

# ROM constant tables (bank 2, fixed) -- inlined as Python (read once, never written)
# battle_strength_stat_weights $B5B1: the 8-stat weighted-contest weights, in the
#   order ai_sum_battle_strength reads them -> daimyo [Health,Drive,Luck,Charisma,IQ]
#   then fief [Morale,Skill,Arms].
BATTLE_STRENGTH_STAT_WEIGHTS = (5, 10, 10, 5, 20, 10, 25, 15)
# terrain_strength_mult_table $B9C2: indexed by terrain_class 0..3
#   (0=castle, 1=forest, 2=town, 3=clear); applied pct_op(men, t)*3 -> the
#   +270/+60/+30/+0% defensive terrain bonus.
TERRAIN_STRENGTH_MULT_TABLE = (90, 20, 10, 0)
# province_to_mapid_table $F70E (bank 15) -- 17-fief scenario tactical-map ids.
PROVINCE_TO_MAPID_17 = (15, 9, 13, 20, 21, 17, 19, 23, 22, 31, 26, 27, 25, 30, 32, 14, 24)
MAP_CELL_POOL = 0xA57E          # bank-4 ROM tactical_map_cell_pool; stride 55/map

# --- province_ai_state values --------------------------------------------
AI_HOME       = 0     # AI-owned fief: runs ai_econ_command_dispatch
PLAYER_DIRECT = 5     # human-owned fief
EMPTY         = 0xFF  # no owner


# ---------------------------------------------------------------------------
# The flat memory
# ---------------------------------------------------------------------------
class Memory:
    """A flat little-endian work-RAM/SRAM image the transcribed AI routines
    operate on. Keep accessors dumb and ROM-shaped; all game logic lives in the
    (forthcoming) vmprims / ai transcription, never here."""

    def __init__(self, rng=None):
        self.m = bytearray(MEM_SIZE)
        # The machine's RNG. The ROM's rng_mod is a syscall ($F226 LCG); for the
        # MC workhorse a seedable random.Random is the right abstraction (the
        # na1dream oracle uses the real LCG -- oracle validation focuses on
        # RNG-independent deltas, or seeds both, until/unless we replicate it).
        import random as _random
        self.rng = rng if rng is not None else _random.Random()
        # Per-fief neighbor/relation rows (the candidate-list source). In the ROM
        # these live in a banked SRAM page read via syscall; we source them here
        # (loader adjacency, or captured from na1dream for the oracle). Each entry
        # is a list of fief ids; load_daimyo_relation_row copies it FF-terminated
        # into DEDUPED_OWNER_LIST. Empty -> no candidates (war can't fire).
        self.neighbor_rows = {}

    def rng_mod(self, n: int) -> int:
        """rng_mod(n) -> 0..n-1 (the ROM's RNG % n). Callers never pass n<=0
        (the $CA52 guard handles score<1 upstream); guard defensively anyway."""
        return self.rng.randrange(n) if n > 0 else 0

    # --- raw access --------------------------------------------------------
    def r8(self, a: int) -> int:
        return self.m[a]

    def w8(self, a: int, v: int) -> None:
        self.m[a] = v & 0xFF

    def r16(self, a: int) -> int:
        return self.m[a] | (self.m[a + 1] << 8)

    def w16(self, a: int, v: int) -> None:
        v &= 0xFFFF
        self.m[a] = v & 0xFF
        self.m[a + 1] = (v >> 8) & 0xFF

    def s16(self, a: int) -> int:
        """Signed 16-bit view -- for the C's `< 0` clamps on word subtraction."""
        v = self.r16(a)
        return v - 0x10000 if v >= 0x8000 else v

    # --- record pointers (return the base ADDRESS, C-style) ---------------
    def fief(self, idx: int) -> int:
        return FIEF_TABLE + idx * FIEF_STRIDE

    def daimyo(self, daimyo_id: int) -> int:
        return DAIMYO_TABLE + daimyo_id * DAIMYO_STRIDE

    def mark(self, idx: int) -> int:
        return MARKS_TABLE + idx * MARKS_STRIDE

    # --- grounded accessor leaves (mirror the $D7xx helpers) --------------
    def fief_owner(self, idx: int) -> int:
        return self.r8(FIEF_TO_DAIMYO_MAP + idx)               # fief_owner $D772

    def fief_daimyo(self, idx: int) -> int:
        return self.daimyo(self.fief_owner(idx))               # fief_to_daimyo_record_addr $D7DA

    def province_ai_state(self, idx: int) -> int:
        return self.r8(PROVINCE_AI_STATE + idx)                # get_province_ai_state $D98D

    def is_capital(self, idx: int) -> int:
        return self.r8(FIEF_IS_CAPITAL + idx)

    def selected_province_owner(self) -> int:
        return self.fief_owner(self.selected)                  # $D77E

    def province_state_is_FF(self, idx: int) -> int:
        return 1 if self.province_ai_state(idx) == 0xFF else 0  # $D999

    def is_enemy_owned(self, idx: int) -> int:
        """is_enemy_owned $D9B7 -- MISNOMER: returns fief_owner(idx) == selected
        owner (i.e. SAME owner / friendly). Callers XOR with match_enemy to keep
        the complement."""
        return 1 if self.fief_owner(idx) == self.selected_province_owner() else 0

    def relations_matrix_get(self, a: int, b: int, order_flag: int) -> int:
        """relations_matrix_get $8250: byte at (min*54 + max) + base, with the
        lo/hi pick flipped by order_flag (XOR with a<b)."""
        flip = (1 if a < b else 0) ^ (order_flag & 1)
        hi, lo = (b, a) if flip else (a, b)
        return self.r8(RELATIONS_MATRIX + lo * RELATIONS_STRIDE + hi)

    def fief_men_if_provisioned(self, idx: int) -> int:
        """fief_men_if_provisioned $9382: men if rice>0, else 0 (provisioned men)."""
        f = self.fief(idx)
        return self.r16(f + F_MEN) if self.r16(f + F_RICE) else 0

    # --- bank-2 tactical accessors (mirror the bank_02.c pointer helpers) --
    def side_resource_ptr(self, side: int) -> int:
        """side_resource_ptr $828A = side*6 + 0x6F7D (+0 gold/+2 rice/+4 men)."""
        return side * 6 + SIDE_RESOURCE_BASE

    def unit_strength_ptr(self, side: int, slot: int) -> int:
        """unit_strength_ptr $82C9 = side*10 + slot*2 + 0x6FBC (word = unit men)."""
        return side * 10 + (slot << 1) + UNIT_STRENGTH_BASE

    def unit_col_ptr(self, side: int, slot: int) -> int:
        """unit_col_ptr $828B = side*5 + slot + 0x6FD0 (byte = map column X)."""
        return side * 5 + slot + UNIT_COL_BASE

    def unit_row_ptr(self, side: int, slot: int) -> int:
        """unit_row_ptr $829A = side*5 + slot + 0x6FDA (byte = map row Y)."""
        return side * 5 + slot + UNIT_ROW_BASE

    def get_battle_side_province(self, side: int) -> int:
        """get_battle_side_province $838F: side 0 -> attacker (selected),
        side!=0 -> defender (battle_defending_province)."""
        return self.defending if side else self.selected

    def is_unit_present(self, side: int, slot: int) -> int:
        """is_unit_present $8F79: bit `slot` of war_side_state_flag[side] ($6F65)."""
        return (self.r8(WAR_SIDE_STATE_FLAG + side) >> slot) & 1 if slot < 5 else 0

    def test_6f65_bit7(self, side: int) -> int:
        """test_6f65_bit7 $D9E5: bit7 (war/siege/home) of war_side_state_flag[side]."""
        return 1 if (self.r8(WAR_SIDE_STATE_FLAG + side) & 0x80) else 0

    @property
    def cur_combat_side(self) -> int:
        return self.r16(CUR_COMBAT_SIDE)

    @cur_combat_side.setter
    def cur_combat_side(self, v: int) -> None:
        self.w16(CUR_COMBAT_SIDE, v)

    @property
    def cur_combat_unit_slot(self) -> int:
        return self.r16(CUR_COMBAT_UNIT_SLOT)

    @cur_combat_unit_slot.setter
    def cur_combat_unit_slot(self, v: int) -> None:
        self.w16(CUR_COMBAT_UNIT_SLOT, v)

    # --- the two ambient cursors most AI routines key off -----------------
    @property
    def selected(self) -> int:
        return self.r16(SELECTED_PROVINCE)

    @selected.setter
    def selected(self, idx: int) -> None:
        self.w16(SELECTED_PROVINCE, idx)

    @property
    def defending(self) -> int:
        return self.r16(BATTLE_DEFENDING)

    @defending.setter
    def defending(self, idx: int) -> None:
        self.w16(BATTLE_DEFENDING, idx)

    def cur_fief(self) -> int:
        """`fief = selected_province_idx*26 + 0x7001` -- the record the dispatch
        and develop/military routines operate on."""
        return self.fief(self.selected)

    @property
    def year(self) -> int:
        return self.r16(CURRENT_GAME_YEAR)

    @property
    def skill(self) -> int:
        """const_two -- the difficulty dial the develop/recruit/war gates scale on."""
        return self.r16(CONST_TWO)


# ---------------------------------------------------------------------------
# Layout consistency self-test (no game logic -- just the map)
# ---------------------------------------------------------------------------
def _smoke():
    # The 51-slot fief table must end exactly where the daimyo table begins.
    assert FIEF_TABLE + FIEF_SLOTS * FIEF_STRIDE == DAIMYO_TABLE, hex(
        FIEF_TABLE + FIEF_SLOTS * FIEF_STRIDE)
    # daimyo_record_addr(0) is the table base.
    assert DAIMYO_TABLE == 0x752F

    m = Memory()
    # round-trip a fief record field (little-endian) and a record pointer.
    f5 = m.fief(5)
    assert f5 == 0x7001 + 5 * 26
    m.w16(f5 + F_MEN, 0x1234)
    assert m.r16(f5 + F_MEN) == 0x1234
    assert m.m[f5 + F_MEN] == 0x34 and m.m[f5 + F_MEN + 1] == 0x12   # LE byte order

    # signed clamp view: gold(40) - men(50) underflows to 0xFFF6 unsigned / -10 signed
    m.w16(f5 + F_GOLD, 40)
    diff = (40 - 50) & 0xFFFF
    m.w16(f5, diff)
    assert m.r16(f5) == 0xFFF6 and m.s16(f5) == -10

    # ownership / state accessor chain
    m.w8(FIEF_TO_DAIMYO_MAP + 5, 3)          # fief 5 owned by daimyo 3
    m.w8(PROVINCE_AI_STATE + 5, AI_HOME)
    assert m.fief_owner(5) == 3
    assert m.fief_daimyo(5) == 0x752F + 3 * 7
    assert m.province_ai_state(5) == AI_HOME

    # ambient cursor
    m.selected = 5
    assert m.cur_fief() == f5
    print("memmap smoke: PASS  (fief@%s daimyo@%s LE+signed+accessors OK)"
          % (hex(FIEF_TABLE), hex(DAIMYO_TABLE)))


if __name__ == "__main__":
    _smoke()
