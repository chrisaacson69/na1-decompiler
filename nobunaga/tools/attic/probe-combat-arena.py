"""Oracle test: settle what select_quadrant_damage_by_direction ($9675, bank 2)
actually does, overturning the May-27 "4-quadrant damage formula {1,2,4,7}" memory.

Hypothesis (from clean post-fix decompile + 3 independent rect-consumers +
self-contradicting toml): $6FF6/$6FF8/$6FFA/$6FFC are NOT damage magnitudes; they
are the combat-arena BOUNDING RECTANGLE (x_min/y_min/x_max/y_max), default the
11x5 grid (0,0,10,4). $9675 shrinks it to the attacker's ENTRY EDGE based on the
compass bearing between the two fiefs' strategic-map coords (B0BA=x, B0EC=y), and
RETURNS only 0 (no-op) or 3 (configured) -- never a damage value.

Method: jump into the body ($967B, after the frame prologue) with SP=FP-10 to
allocate the 5 word locals (per the May-27 note), seed the 3 globals it reads, run
to its RETURN ($9709), read regL + the 4 rect words. Bank 2 (B0BA/B0EC/is_no_prov
live there); helpers fief_to_mapid/abs16/province_to_mapid_table are fixed bank 15.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from na1dream.nobunaga_vm import NobunagaVM

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

SEED_SRAM = "traces/b2-startbattle.dmp"
FP = 0x05FF
BODY = 0x967B          # first op after the 5-local frame prologue
RET  = 0x9709          # the sub's own RETURN
SEL  = 0x6F5F          # selected_province_idx (attacker)
DEF  = 0x6F63          # battle_defending_province
SIDE = 0x7BE8          # cur_combat_side (must be 0)
FCNT = 0x6D9D          # scenario_fief_count
RECT = [0x6FF6, 0x6FF8, 0x6FFA, 0x6FFC]   # x_min, y_min, x_max, y_max
MAPID = [15, 9, 13, 20, 21, 17, 19, 23, 22, 31, 26, 27, 25, 30, 32, 14, 24]  # 17-fief
B0BA = 0xB0BA          # strategic_map_fief_x[mapid]
B0EC = 0xB0EC          # strategic_map_fief_y[mapid]


def signed(w):
    w &= 0xFFFF
    return w - 0x10000 if w >= 0x8000 else w


def run_pair(att, dfn):
    vm = NobunagaVM()
    vm.load_sram(SEED_SRAM)
    vm.switch_bank(2)
    vm.mem.write_word(SEL, att)
    vm.mem.write_word(DEF, dfn)
    vm.mem.write_word(SIDE, 0)
    vm.mem.write_word(FCNT, 17)
    vm.vm_fp = FP
    vm.vm_sp = FP - 10          # allocate the 5 word locals
    vm.vm_pc = BODY
    vm.cpu.pc = vm.DISPATCHER_ADDR
    for _ in range(4000):
        if vm.cpu.pc == vm.DISPATCHER_ADDR and vm.vm_pc == RET:
            break
        if vm.step_one_vm_op() is None:
            return None
    rect = [signed(vm.mem.read_word(a)) for a in RECT]
    ret = signed(vm.regL)
    # read the coords the function saw, straight from bank-2 ROM tables
    ax = vm.mem.read(B0BA + MAPID[att]); ay = vm.mem.read(B0EC + MAPID[att])
    dx = vm.mem.read(B0BA + MAPID[dfn]); dy = vm.mem.read(B0EC + MAPID[dfn])
    return ret, rect, (ax, ay), (dx, dy)


def bearing(ax, ay, dx, dy):
    if abs(ax - dx) < abs(ay - dy):
        return "S(atk below)" if ay >= dy else "N(atk above)"
    return "E(atk right)" if ax > dx else "W(atk left)"


def main():
    print("=" * 78)
    print("select_quadrant_damage_by_direction ($9675) — arena-rect vs damage-formula")
    print("  default rect (no-op) = (0,0,10,4) = the 11x5 tactical grid")
    print(f"  {'att':>3} {'def':>3}  {'atk(x,y)':>9} {'def(x,y)':>9}  {'bearing':>13}  "
          f"{'ret':>3}  rect[xmin,ymin,xmax,ymax]")
    rets = set()
    # pairs chosen to exercise all four compass branches (17-fief)
    for att, dfn in [(0, 4), (4, 0), (10, 13), (13, 10),   # horizontal (E/W)
                     (1, 2), (2, 1), (0, 1), (1, 0)]:       # vertical (N/S)
        r = run_pair(att, dfn)
        if r is None:
            print(f"  {att:3d} {dfn:3d}  <timeout>"); continue
        ret, rect, a, d = r
        rets.add(ret)
        print(f"  {att:3d} {dfn:3d}  {str(a):>9} {str(d):>9}  {bearing(*a,*d):>13}  "
              f"{ret:3d}  {rect}")
    print(f"\n  return values seen across all pairs: {sorted(rets)}")
    print("  => if returns ⊆ {0,3} and one rect edge moves per bearing, the words are")
    print("     ARENA COORDS, not damage; the {1,2,4,7} 'damage table' was a misread.")


if __name__ == "__main__":
    main()
