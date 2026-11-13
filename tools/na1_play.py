#!/usr/bin/env python3
"""na1_play.py - play NA1 in headless Mesen: start a game, give commands, read the game's memory.

The running cartridge is the ground truth the sim is checked against (#54: the Summer snapshot).
This drives it through emu-harness (`machines.nes.NES` + `live.run`): scripted buttons in, SRAM and
the nametables' text out. It never captures the screen.

Input conventions (read from the ROM, ledger #54):
  * screen text is the nametables through tile = ASCII - 0x2F (capitals 4 further; digits at 8-17);
  * Y/N and two-way choices (`prompt_y_n` $D3A9, `prompt_ab_window`): Left = yes / the first, Right =
    no / the second;
  * number entry (`input_number_digits` $D3ED): each digit starts at 0, Up adds 1, Right opens the
    next digit at 0, A confirms;
  * the command menu is a cursor from item 1, 12 to a page with wrap; Right flips to items 13-21.

  py -3.14 tools/na1_play.py screen  --fief 17           new game as fief 17, play to its first turn
  py -3.14 tools/na1_play.py summer-gift --runs 20       #54's check, Summer give vs train, N rolls

From Python:
  with Session() as s:
      s.new_game(fief=17, skill=1)
      s.to_turn(season=0); s.tax(55)
      s.to_turn(season=1); s.give(50)
      s.to_turn(season=2); print(s.fief(17), s.marks(17))
Fiefs are numbered 1-17 as the game shows them.
"""
from __future__ import annotations

import argparse
import re
import statistics

from emu_harness.machines.nes import NES
from emu_harness.machines.nes.live import PPUSnapshot, run, text
from emu_harness.vm.koei.nes.titles import game_cfg

ROM = game_cfg("na1")["_rom"]

# tile -> character (ASCII - 0x2F; capitals sit 4 further; digits 0-9 at tiles 8-17)
CHARMAP = {0: " ", 1: " ", 3: "(", 4: ")", 5: "-", 6: "/", 0x15: "?"}
for _t in range(2, 0x60):
    if _t in CHARMAP:
        continue
    _c = _t + 0x2F
    if 8 <= _t <= 17:
        CHARMAP[_t] = chr(ord("0") + _t - 8)
    elif 0x45 <= _c <= 0x5E:
        CHARMAP[_t] = chr(_c - 4)
    elif _c < 0x7F:
        CHARMAP[_t] = chr(_c)

# the live province record, $7001 + fief*26 (docs/commands/README.md "Per-fief field layout")
FIELDS = dict(gold=0, debt=2, town=4, rice=6, output=8, dams=10, loyalty=12, wealth=14, men=16,
              morale=18, skill=20, arms=22, header=24)
MARKS = ("output", "dams", "loyalty", "wealth")        # $6003 + fief*8, the harvest's low-water marks
SEASON, YEAR, SKILL, TAX = 0x6D5F, 0x6D9F, 0x6D63, 0x6D2D
MENU = ["Move", "War", "Tax", "Send", "Dam", "Pact", "Grow", "Marry", "Trade", "Hire", "Train", "View",
        "Build", "Give", "Bribe", "Assign", "Rest", "Map", "Grant", "Other", "Pass"]
SETUP_START = "wait*600,start,wait*240,left,wait*180"      # power-on to the scenario prompt


class Session:
    """One emulator. new_game() or load() a state first; fiefs are the game's 1-17."""

    def __init__(self):
        self.m = NES(ROM, ram_power_on="AllZeros")

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        self.close()

    def close(self):
        self.m.close()

    # -- reading ---------------------------------------------------------------------------------
    def screen(self) -> str:
        snap = PPUSnapshot.capture(self.m)
        rows = []
        for i in range(4):
            rows += [r.rstrip() for r in text(snap.page(i), CHARMAP) if re.search(r"[A-Za-z]{3}", r)]
        return "\n".join(dict.fromkeys(rows))          # pages mirror; keep each line once

    def sram(self) -> bytes:
        return self.m.read("nesSaveRam", 0, 0x2000)

    def _w(self, s, addr):
        return s[addr - 0x6000] | s[addr - 0x6000 + 1] << 8

    def season(self) -> int:
        return self.sram()[SEASON - 0x6000]

    def year(self) -> int:
        return self._w(self.sram(), YEAR)

    def fief(self, n: int) -> dict:
        s, base = self.sram(), 0x7001 + (n - 1) * 26
        rec = {k: self._w(s, base + off) for k, off in FIELDS.items()}
        rec["tax"] = s[TAX - 0x6000 + n - 1]
        return rec

    def marks(self, n: int) -> dict:
        s, base = self.sram(), 0x6003 + (n - 1) * 8
        return {k: self._w(s, base + 2 * i) for i, k in enumerate(MARKS)}

    # -- input -----------------------------------------------------------------------------------
    def press(self, script: str):
        run(self.m, script)

    def number(self, n: int):
        """Enter n in a number prompt and confirm."""
        digits = [int(c) for c in str(n)]
        parts = []
        for i, d in enumerate(digits):
            if i:
                parts.append("right")
            if d:
                parts.append(f"up*{d}")
        self.press(",".join(parts + ["a", "wait*90"]))

    def choose(self, first: bool):
        self.press(("left" if first else "right") + ",wait*90")

    # -- the game --------------------------------------------------------------------------------
    def new_game(self, fief: int, skill: int = 1, players: int = 1, watch_battles: bool = False):
        """Power-on to the first season: 17 fiefs, `players` humans all on `fief` (one), the rolled
        abilities accepted as they come."""
        self.press(SETUP_START + ",left,wait*120," + ("left" if watch_battles else "right") + ",wait*120")
        self.number(players)
        self.press("wait*200")
        self.number(fief)
        self.press("wait*30")
        self.choose(True)                              # "Is <lord> of fief N OK?"
        self.press("wait*150," + ",".join(["a,wait*120"] * 5))   # set the five abilities
        self.choose(True)                              # "Is this OK?"
        self.press("wait*90")
        self.number(skill)
        self.choose(True)                              # "Is everything OK so far?"

    def to_turn(self, season: int | None = None, limit: int = 60_000) -> bool:
        """Play on until the human's command prompt ("your orders?"), in `season` if given (0 Spring
        .. 3 Winter). Event messages that wait for a key get an A. -> False if the limit ran out."""
        frames = 0
        while frames < limit:
            sc = self.screen()
            if "orders" in sc and (season is None or self.season() == season):
                self.press("wait*90")                  # the menu takes input a moment after it draws
                return True
            if re.search(r"Hit any key|Press any button", sc) and "orders" not in sc:
                self.press("a")
            self.press("wait*60")
            frames += 60
        return False

    def command(self, name: str):
        """Select a command by name; checks the prompt that opens is not the War command's unless
        War was asked for (a lost key press must not launch an attack)."""
        i = MENU.index(name)
        page2 = i >= 12
        steps = (["right", "wait*30"] if page2 else []) + ([f"down*{i - 12 if page2 else i}"] if (i % 12) else [])
        self.press(",".join(steps + ["a", "wait*120"]))
        if name != "War" and "Attack where" in self.screen():
            self.press("b,wait*90")
            raise RuntimeError(f"menu landed on War, not {name}: a key press was lost")

    def tax(self, rate: int):
        self.command("Tax")
        self.number(rate)

    def give(self, amount: int, peasants: bool = True, gold: bool = True):
        self.command("Give")
        self.choose(peasants)
        self.choose(gold)
        self.number(amount)

    def train(self):
        self.command("Train")
        self.press("wait*60")

    def pass_turn(self):
        self.command("Pass")
        self.press("wait*60")

    def seed_rng(self, seed: int):
        """Set the RNG's 48-bit state ($0083-$0088, the wall-clocks syscall_rng_next $C1C3 mixes) from
        `seed`. The NMI advances it only while $89 gates it on, and not at the command menu, so
        waiting there changes no roll (#54): a branch that should roll differently needs this."""
        import random
        r = random.Random(seed)
        self.m.write("nesInternalRam", 0x83, bytes(r.randrange(256) for _ in range(6)))

    def save(self) -> str:
        return self.m.save()

    def load(self, state: str):
        self.m.load(state)


def summer_gift(runs: int, fief: int = 17, amount: int = 50, tax: int = 55):
    """#54: Spring tax, then Summer give `amount` gold to the peasants vs train; the Fall harvest.
    Each run seeds the RNG state differently at the Summer menu (both arms of a run alike). Prints the marks and the harvest, gold and rice, per arm."""
    with Session() as s:
        s.new_game(fief)
        assert s.to_turn(0), "no Spring turn"
        s.tax(tax)
        assert s.to_turn(1), "no Summer turn"
        state, before = s.save(), s.fief(fief)
        print(f"Summer menu: {before}\n  marks {s.marks(fief)}")
        res = {"give": [], "train": []}
        for k in range(runs):
            for arm in res:
                s.load(state)
                s.seed_rng(k)                          # the same seed for both arms of run k
                gold0 = s.fief(fief)["gold"]
                s.give(amount) if arm == "give" else s.train()
                after = s.fief(fief)
                if not s.to_turn(2):
                    print("  no Fall turn"); continue
                fall, mk = s.fief(fief), s.marks(fief)
                res[arm].append((fall["gold"] - after["gold"], fall["rice"] - after["rice"], mk["loyalty"], mk["wealth"],
                                 after["loyalty"], after["wealth"], gold0))
        for arm, rows in res.items():
            g = [r[0] for r in rows]; r_ = [r[1] for r in rows]
            print(f"{arm:5}: Fall gold +{statistics.mean(g):5.1f} (sd {statistics.pstdev(g):4.1f}, {min(g)}..{max(g)}),"
                  f" rice +{statistics.mean(r_):5.1f} (sd {statistics.pstdev(r_):4.1f}, {min(r_)}..{max(r_)});"
                  f" live loyalty/wealth after the command {rows[0][4]}/{rows[0][5]}, marks at Fall {sorted({(x[2], x[3]) for x in rows})}")
        return res


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("screen", help="new game as --fief, play to its first turn, print the screen and the record")
    p.add_argument("--fief", type=int, default=17)
    p.add_argument("--skill", type=int, default=1)
    p = sub.add_parser("summer-gift", help="#54's check with N rolls")
    p.add_argument("--runs", type=int, default=20)
    p.add_argument("--fief", type=int, default=17)
    a = ap.parse_args()
    if a.cmd == "screen":
        with Session() as s:
            s.new_game(a.fief, a.skill)
            s.to_turn()
            print(s.screen()); print(s.fief(a.fief)); print(s.marks(a.fief))
    else:
        summer_gift(a.runs, a.fief)


if __name__ == "__main__":
    main()
