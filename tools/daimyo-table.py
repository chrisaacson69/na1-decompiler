#!/usr/bin/env python3
"""The daimyo records of an 8 KB SRAM dump: 7 bytes each at daimyo_table $752F (age, health, drive,
luck, charisma, IQ, generated-face flag), with the fiefs each holds. Until 2026-11-04 this was the May
stride hunt (10 and 16 bytes from $7560), which printed plausible rows of the wrong shape.

    py -3.14 tools/daimyo-table.py traces/aftertax.dmp
"""
import sys
from pathlib import Path

BASE, TABLE, STRIDE = 0x6000, 0x752F, 7
FIEF_COUNT, OWNER, CAPITAL = 0x6D9D, 0x6E15, 0x6DA2

data = Path(sys.argv[1]).read_bytes()
fiefs = data[FIEF_COUNT - BASE]
held = {}
for f in range(fiefs):
    held.setdefault(data[OWNER - BASE + f], []).append(f"{f}*" if data[CAPITAL - BASE + f] else str(f))

print(f"{fiefs} fiefs; * = capital")
print(" id  age  hlth drive luck  char   iq  face  fiefs")
for d in range(fiefs + 3):                       # the per-turn ageing runs over fief_count + 3 records
    r = data[TABLE - BASE + d * STRIDE:][:STRIDE]
    print(f"{d:3}" + "".join(f"{b:5}" for b in r) + "  " + " ".join(held.get(d, ["-"])))
