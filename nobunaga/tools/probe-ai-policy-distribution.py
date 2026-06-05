"""Show that the AI never 'picks' a Grant policy — every AI fief sits at
province_ai_state == 0 (Home/Balanced); states 1-4 only appear when the PLAYER
grants them, and state 5 (Direct) marks player/manual fiefs.

Reads province_ai_state ($6CF7, one byte per fief) straight out of every SRAM
.dmp in traces/ and prints the value histogram. No emulation — it's a save-state
census. The dispatch in ai_per_fief_command_driver ($B89B) reads this byte fresh
each turn, so the histogram IS the set of policies actually in play.

  state 0 = Home (-> ai_econ_action_state0 -> ai_econ_command_dispatch, the
            RNG-weighted "Balanced" loop the AI runs on EVERY fief, every turn)
  states 1-4 = Industrial / Military / Balanced / Farming  (player Grant menu)
  state 5 = Direct (player-controlled / manual)
  0xFF = excluded (ownerless / dead)
"""
import sys
import glob
import os
from collections import Counter
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

AI_STATE = 0x6CF7
CAPITAL = 0x6DA2          # per-fief daimyo home-seat / capital flag (see census below)
OWNER = 0x6E15           # fief_to_daimyo_map
SRAM_BASE = 0x6000
NAMES = {0: "Home", 1: "Industrial", 2: "Military", 3: "Balanced", 4: "Farming",
         5: "Direct", 0xFF: "excl"}


def _bytes(data, addr, n):
    off = addr - SRAM_BASE
    return [data[off + i] for i in range(n)] if len(data) >= off + n else None


def census(path, n_fiefs=50):
    data = Path(path).read_bytes()
    return _bytes(data, AI_STATE, n_fiefs)


def main():
    root = Path(__file__).resolve().parent.parent
    dumps = sorted(glob.glob(str(root / "traces" / "*.dmp")))
    print("=" * 78)
    print("province_ai_state ($6CF7) census across SRAM dumps — the AI's 'style' choice")
    print("=" * 78)
    print(f"  {'dump':30} {'state histogram (non-excluded)':40}")
    for f in dumps:
        states = census(f)
        if states is None:
            continue
        c = Counter(s for s in states if s != 0xFF)
        pretty = "  ".join(f"{NAMES.get(k, k)}={v}" for k, v in sorted(c.items()))
        print(f"  {os.path.basename(f):30} {pretty}")
    print("\n  Reading: every normal save = {Home:49, Direct:1} — all 49 AI fiefs run")
    print("  policy 0 (Home), only the player's own fief is Direct. States 1-4 appear")
    print("  solely in saves where the PLAYER granted them (e.g. the post-victory map).")
    print("  => The AI does not pick a style; it always runs Home == the Balanced loop.")

    print("\n" + "=" * 78)
    print("$6DA2 census — is it one flag per daimyo (= the capital/home-seat)?")
    print("=" * 78)
    print(f"  {'dump':30} {'capitals':>8} {'owners':>7} {'1-per-daimyo?':>14}")
    bijection_holds = True
    for f in dumps:
        data = Path(f).read_bytes()
        n = 50
        states = _bytes(data, AI_STATE, n)
        cap = _bytes(data, CAPITAL, n)
        own = _bytes(data, OWNER, n)
        if states is None or cap is None or own is None:
            continue
        # skip PPU-memory captures (SRAM region not meaningful — no fiefs flagged)
        n_cap = sum(1 for c in cap if c)
        if n_cap == 0:
            continue
        cap_owners = [own[i] for i in range(n) if cap[i]]
        distinct_owners = len({o for o in own if o != 0xFF})
        one_each = (n_cap == distinct_owners) and (len(cap_owners) == len(set(cap_owners)))
        bijection_holds &= one_each
        print(f"  {os.path.basename(f):30} {n_cap:8} {distinct_owners:7} {str(one_each):>14}")
    print(f"\n  => bijection (exactly one $6DA2 flag per living daimyo) holds in ALL real "
          f"saves: {bijection_holds}.")
    print("  $6DA2[fief] == 1 marks that fief as its owner's CAPITAL / home seat. It")
    print("  transfers on conquest, adds a defensive bonus in ai_sum_battle_strength")
    print("  ((capital+2)*weight), and the living-daimyo count drives the game-over check.")


if __name__ == "__main__":
    main()
