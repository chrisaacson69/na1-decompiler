"""
Load the 17-fief scenario from the committed ground-truth files:
  - 17fief.txt    : province stats (header/gold/.../men/morale/skill/arms)
  - adjacency.txt : the border graph (bank-4 $8300, 0-based, $FF-terminated)

Run directly to SMOKE-TEST the parse against ground truth:
    py -3 -m na1sim.loader
"""

import random
import re
from pathlib import Path
from typing import List, Optional

from .state import Province, Daimyo, World, AI_HOME, AI_DIRECT

HERE = Path(__file__).resolve().parent          # .../tools/na1sim
REPO = HERE.parent.parent                        # .../nobunaga
PROV_FILE = REPO / "17fief.txt"
ADJ_FILE = REPO / "adjacency.txt"
DAIMYO_FILE = REPO / "17Diamyo.txt"

# 17fief.txt column order after idx/name:
# header gold debt town rice output dams loyalty wealth men morale skill arms
_PROV_COLS = ["header", "gold", "debt", "town", "rice", "output", "dams",
              "loyalty", "wealth", "men", "morale", "skill", "arms"]


def load_provinces(path: Path = PROV_FILE) -> List[Province]:
    provs: List[Province] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.lower().startswith("idx"):
            continue
        toks = s.split()
        # toks: idx name <13 numbers>
        idx = int(toks[0])
        name = toks[1]
        nums = list(map(int, toks[2:]))
        if len(nums) != len(_PROV_COLS):
            raise ValueError(f"row {idx} ({name}) has {len(nums)} numbers, "
                             f"expected {len(_PROV_COLS)}: {nums}")
        v = dict(zip(_PROV_COLS, nums))
        provs.append(Province(
            idx=idx, name=name, header=v["header"],
            gold=v["gold"], debt=v["debt"], town=v["town"], rice=v["rice"],
            output=v["output"], dams=v["dams"], loyalty=v["loyalty"], wealth=v["wealth"],
            men=v["men"], morale=v["morale"], skill=v["skill"], arms=v["arms"],
            # marks seed = live stats at game start (Summer re-seed does the same)
            lm=v["loyalty"], wm=v["wealth"], om=v["output"], dm=v["dams"],
            owner=idx, ai_state=AI_HOME, is_capital=True,
        ))
    return provs


# adjacency.txt neighbour rows look like:
#    4: 1, 2, 5, 6, 16            [00 01 04 05 0F FF 00 00]
# the BRACKET holds the authoritative 0-based indices, $FF-terminated.
_ADJ_RE = re.compile(r"^\s*(\d+):\s*[\d,\s]*\[([0-9A-Fa-f ]+)\]")


def load_adjacency(path: Path = ADJ_FILE) -> dict:
    adj: dict = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        m = _ADJ_RE.match(line)
        if not m:
            continue
        prov_1based = int(m.group(1))
        idx = prov_1based - 1
        raw = [int(b, 16) for b in m.group(2).split()]
        neighbors = []
        for b in raw:
            if b == 0xFF:
                break
            neighbors.append(b)
        adj[idx] = neighbors
    return adj


# 17Diamyo.txt columns after idx/clan:
# age health drive luck charisma iq status owns_province
_DAIMYO_COLS = ["age", "health", "drive", "luck", "charisma", "iq", "status"]


def load_daimyos(path: Path = DAIMYO_FILE) -> List[Daimyo]:
    out: List[Daimyo] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.lower().startswith("idx"):
            continue
        toks = s.split()
        idx = int(toks[0])
        name = toks[1]
        nums = list(map(int, toks[2:2 + len(_DAIMYO_COLS)]))
        v = dict(zip(_DAIMYO_COLS, nums))
        out.append(Daimyo(
            id=idx, name=name, owns=idx,
            age=v["age"], health=v["health"], drive=v["drive"], luck=v["luck"],
            charisma=v["charisma"], iq=v["iq"], status=v["status"], generated=False,
        ))
    return out


# Player-generated lord: each rollable stat 90±15, rerolled until total>=450
# (= 5*90). Models a player who rerolls until they get a "decent" lord.
PLAYER_ROLL_LO = 60       # GROUNDED: prompt_roll_stat_value $85FC = rng_mod(50)+60
PLAYER_ROLL_SPAN = 50     #   -> each stat uniform [60,109]; reroll-all until total>=450
PLAYER_TOTAL_MIN = 450
PLAYER_START_AGE = 18    # assumption: a generated lord starts young (longest runway)


def _roll_stat(rng: random.Random) -> int:
    return rng.randrange(PLAYER_ROLL_SPAN) + PLAYER_ROLL_LO   # rng_mod(50)+60 -> [60,109]


def generate_player_daimyo(idx: int, name: str, owns: int,
                           rng: random.Random) -> Daimyo:
    while True:
        health, drive, luck, charisma, iq = (_roll_stat(rng) for _ in range(5))
        if health + drive + luck + charisma + iq >= PLAYER_TOTAL_MIN:
            break
    return Daimyo(id=idx, name=name, owns=owns, age=PLAYER_START_AGE,
                  health=health, drive=drive, luck=luck, charisma=charisma, iq=iq,
                  status=0, generated=True)


def build_world(player_fief: Optional[int] = None,
                seed: Optional[int] = None) -> World:
    """Build the 17-fief world.

    player_fief: if given, that fief is the human seat (ai_state=DIRECT) and its
                 lord is swapped for a player-generated daimyo (90±15, total>=450).
    seed:        seeds the player-daimyo roll for reproducibility.
    """
    provs = load_provinces()
    adj = load_adjacency()
    for p in provs:
        p.neighbors = adj.get(p.idx, [])
    daimyos = load_daimyos()

    # Real economy caps are randomized per game ~1700-1900 (the static 1000/Noto-0
    # header column is not the cap). [FLAG: range per Chris; exact gen-formula TBD.]
    rng = random.Random(seed)
    for p in provs:
        p.header = rng.randint(1700, 1900)

    if player_fief is not None:
        d = daimyos[player_fief]
        daimyos[player_fief] = generate_player_daimyo(
            idx=d.id, name=d.name, owns=d.owns, rng=rng)
        provs[player_fief].ai_state = AI_DIRECT

    return World(provinces=provs, daimyos=daimyos)


# ---------------------------------------------------------------------------
# Smoke test: prove the parse matches ground truth before anything builds on it.
# ---------------------------------------------------------------------------
def _smoke():
    w = build_world()
    assert len(w.provinces) == 17, f"expected 17 fiefs, got {len(w.provinces)}"

    # 1) spot-check Hida (idx 5) against 17fief.txt verbatim
    hida = w.provinces[5]
    assert hida.name == "Hida", hida.name
    expect = dict(gold=38, debt=0, town=41, rice=36, output=42,
                  dams=61, loyalty=73, wealth=69, men=54, morale=68, skill=63, arms=50)
    assert 1700 <= hida.header <= 1900, hida.header   # cap randomized per game
    for k, val in expect.items():
        got = getattr(hida, k)
        assert got == val, f"Hida.{k}={got} but ground truth is {val}"

    # 2) adjacency: symmetry + Hida's borders
    for p in w.provinces:
        for n in p.neighbors:
            assert p.idx in w.provinces[n].neighbors, \
                f"asymmetry: {p.idx}->{n} but not back"
    hida_borders = sorted(w.provinces[n].name for n in hida.neighbors)
    assert hida_borders == ["Echizen", "Kaga", "Mino", "Shinano"], hida_borders

    # 3) the weakest-by-output fief on the map (the AI's prey magnet)
    weakest = min(w.provinces, key=lambda p: p.output)

    print("na1sim loader smoke test: PASS")
    print(f"  fiefs loaded: {len(w.provinces)}, edges: "
          f"{sum(len(p.neighbors) for p in w.provinces)//2}")
    print(f"  Hida (idx5): out={hida.output} men={hida.men} rice={hida.rice} "
          f"gold={hida.gold} loy={hida.loyalty} arms={hida.arms} skill={hida.skill}")
    print(f"  Hida borders: {hida_borders}")
    hida_neigh = [(w.provinces[n].name, w.provinces[n].output, w.provinces[n].men)
                  for n in hida.neighbors]
    print("  neighbour (name, output, men):")
    for nm, o, m in hida_neigh:
        tag = "  <-- map's weakest" if nm == weakest.name else ""
        print(f"     {nm:9} out={o:3} men={m:3}{tag}")
    print(f"  map weakest by output: {weakest.name} (out={weakest.output}) "
          f"— is it Hida's neighbour? {'YES' if weakest.idx in hida.neighbors else 'no'}")

    # 4) real daimyo load (AI lords) — spot-check Tokugawa (idx 7, Mikawa)
    toku = w.daimyos[7]
    assert toku.name == "Tokugawa", toku.name
    assert (toku.drive, toku.luck, toku.charisma, toku.iq) == (102, 115, 110, 115), toku
    assert not toku.generated
    print(f"  AI lord Tokugawa (real ROM): Drive={toku.drive} Luck={toku.luck} "
          f"Cha={toku.charisma} IQ={toku.iq} total={toku.power_total}")

    # 5) player-generated Hida lord (90±15, total>=450), reproducible by seed
    pw = build_world(player_fief=5, seed=42)
    pl = pw.daimyos[5]
    assert pl.generated and pl.power_total >= 450
    for s in (pl.health, pl.drive, pl.luck, pl.charisma, pl.iq):
        assert 60 <= s <= 109, s    # rng_mod(50)+60
    assert pw.provinces[5].ai_state == AI_DIRECT
    print(f"  player Hida lord (gen seed42): H={pl.health} D={pl.drive} L={pl.luck} "
          f"Cha={pl.charisma} IQ={pl.iq} total={pl.power_total} (>=450 ok), "
          f"Hida ai_state=DIRECT ok")
    # neighbour lords' aggression: Drive>=50 => ignores relations, attacks weakest
    bold = [w.daimyos[n].name for n in hida.neighbors if w.daimyos[n].drive >= 50]
    print(f"  Hida's neighbour lords all bold (Drive>=50)? "
          f"{len(bold)}/{len(hida.neighbors)}: {bold}")


if __name__ == "__main__":
    _smoke()
