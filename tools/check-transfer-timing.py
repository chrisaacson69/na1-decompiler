"""Cartridge check (#66, headless Mesen via na1_play): does a Send reach a fief that acts later in the
SAME season? Owari (17) is given Mino (9) as a conquest writes it (owner map $6E15, AI state 5, capital
flag 0); at each player prompt the acting fief Sends 1 rice and 10 gold to the other (then confirms Y);
the other's gold is read right after and at the next prompt, until the receiver acts in the sender's season.

  py -3.14 tools/check-transfer-timing.py

2026-11-18: Summer 1560, Mino sent; Owari's gold 100 -> 110 at once, and Owari's own Summer turn showed
110. (Move, the same setup: Owari 78 -> 68 and Mino 43 -> 53 when the command completed, after the
"arrived safely" message: $9798, then effect_move at $97A7.)"""
import os
import re
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from na1_play import Session

OWNER, AISTATE, CAPITAL = 0x6E15, 0x6CF7, 0x6DA2
OW, MI = 17, 9
HEAD = re.compile(r"(\d{4}) (Spring|Summer|Fall|Winter) Fief +(\d+)")
NL = chr(10)


def w8(s, addr, v):
    s.m.write("nesSaveRam", addr - 0x6000, bytes([v]))


def asks(s):
    return " | ".join(l.strip() for l in s.screen().splitlines() if "?" in l)


with Session() as s:
    s.new_game(OW, 1)
    assert s.to_turn(), "no first turn"
    own = s.sram()[OWNER + OW - 1 - 0x6000]
    w8(s, OWNER + MI - 1, own); w8(s, AISTATE + MI - 1, 5); w8(s, CAPITAL + MI - 1, 0)
    s.pass_turn()
    for _ in range(10):
        assert s.to_turn(), "no prompt"
        sc = s.screen()
        h = HEAD.search(sc)
        yr, sea, me = h.group(1), h.group(2), int(h.group(3))
        other = MI if me == OW else OW
        g0 = s.fief(other)["gold"]
        print(f"=== {yr} {sea}: fief {me} acts; fief {other} gold {g0}")
        s.command("Send")
        print("--- Send opened: " + asks(s))
        s.number(other)
        print("--- after destination: " + asks(s))
        s.number(1)
        print("--- after rice: " + asks(s))
        s.number(10)
        print("--- after gold: " + asks(s))
        s.choose(True)
        s.press("wait*120")
        print(f"--- fief {other} gold right after the Send: {s.fief(other)['gold']} (was {g0})")
        s.press("a,wait*60")
        assert s.to_turn(), "no next prompt"
        sc = s.screen()
        h2 = HEAD.search(sc)
        print(f"=== next prompt: {h2.group(0)}; fief {other} gold in SRAM {s.fief(other)['gold']}; on screen: "
              + " ".join(l.strip() for l in sc.splitlines() if "Gold" in l))
        if h2.group(2) == sea and int(h2.group(3)) == other:
            print("SAME SEASON: the receiver acts after the sender")
            break
        s.pass_turn()
