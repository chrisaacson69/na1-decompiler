#!/usr/bin/env python3
"""sound_verify.py - the sound lane's gate for NA1: does the headless engine write what the real game writes?

Converted from Mappy's sound_verify.py. From a savestate, Mesen plays an input script and records, in
CPU-cycle order:
  * every write the GAME makes into the sound engine's RAM ($0720-$0760: playing flags, voice configs,
    voice records), i.e. from a PC outside the music driver ($C7A5-$CA02);
  * every APU write made outside the music driver (audio_control's silence, $C41A);
  * every entry to music_driver ($C7A5), the per-frame tick;
  * every write to the APU registers: the reference stream;
  * every write to sound_request_id ($7FE5), the game's requests.
Two checks follow.
  1. The engine: start the headless CPU from the savestate's internal RAM, replay the game's writes and
     ticks in the same order on sound_engine's machine, and compare the APU streams write for write.
  2. The requests: each request the game made, run through sound_engine.Engine.request from the RAM it
     saw, must write the engine RAM the game's own code wrote for it, byte for byte.

  py -3.14 tools/sound_verify.py [state.mss] [--inputs "wait*1800"]     (no state: from power-on)
"""
import argparse
import sys
import tempfile
from pathlib import Path

from emu_harness.backends.mesen import read_watch
from emu_harness.machines.nes import NES
from emu_harness.machines.nes.live import run
from emu_harness.machines.nes.sound import NOT_APU, Recorder, tap

sys.path.insert(0, str(Path(__file__).resolve().parent))
from sound_engine import AUDIO_WAIT_GATE, MUSIC_DRIVER, PRG_BANK_SHADOW, SOUND_REQUEST_ID, Engine  # noqa: E402

HERE = Path(__file__).resolve().parent
from emu_harness.vm.koei.nes.titles import game_cfg   # the ROM: the machine's ROM store, via the [na1] profile
ROM = game_cfg("na1")["_rom"]
DRIVER = (0xC7A5, 0xCA05)          # Mesen's PC is after the store: allow the last store's length
ENGINE_RAM = (0x0720, 0x0760)


def record(state, inputs, tmp):
    paths = {k: tmp / f"{k}.watch" for k in ("ram", "apu", "tick", "req", "gate")}
    # power-on (no state): a fresh session, RAM all zeros like the headless machine's
    with NES(ROM, ram_power_on="AllZeros" if state is None else None) as m:
        if state is not None:
            m.step(frames=5)
            m.load("00000000" + state.read_bytes().hex())
        ram0 = bytes(m.read("nesInternalRam", 0, 0x800))
        sram0 = bytes(m.read("nesSaveRam", 0, 0x2000))
        m.watch("write", *ENGINE_RAM, paths["ram"], regs=True)
        m.watch("write", 0x4000, 0x4017, paths["apu"], regs=True)
        m.watch("exec", MUSIC_DRIVER, MUSIC_DRIVER, paths["tick"], regs=True)
        m.watch("write", SOUND_REQUEST_ID, SOUND_REQUEST_ID + 1, paths["req"], regs=True)
        m.watch("write", AUDIO_WAIT_GATE, AUDIO_WAIT_GATE, paths["gate"], regs=True)
        run(m, inputs)
        m.watch_off()
    return ram0, sram0, {k: read_watch(p) for k, p in paths.items()}


def outside(r):
    return not DRIVER[0] <= r["cpu.pc"] <= DRIVER[1]


def check_engine(engine, ram0, sram0, w):
    events = [(r["cpu.cycleCount"], "poke", (r["address"], r["value"])) for r in w["ram"] if outside(r)]
    events += [(r["cpu.cycleCount"], "apu", (r["address"], r["value"])) for r in w["apu"] if outside(r)]
    events += [(r["cpu.cycleCount"], "tick", None) for r in w["tick"]]
    events.sort(key=lambda e: e[0])
    ref = [(r["address"], r["value"]) for r in w["apu"] if r["address"] not in NOT_APU]
    rec = Recorder()
    mem = tap(engine.machine(), rec)
    mem.ram[:] = ram0
    mem.sram[:] = sram0
    mem.switch_bank(ram0[PRG_BANK_SHADOW])
    counts = {"poke": 0, "apu": 0, "tick": 0}
    for _, kind, payload in events:
        counts[kind] += 1
        if kind == "tick":
            engine.tick()
        else:
            mem.write(*payload)
    got = [(a, v) for _, a, v in rec.writes]
    print(f"engine: replayed {counts}; APU writes Mesen {len(ref):,}, headless {len(got):,}")
    k = next((i for i in range(min(len(ref), len(got))) if ref[i] != got[i]), None)
    if k is None and len(ref) == len(got):
        print("engine: identical, write for write")
        return True
    k = k if k is not None else min(len(ref), len(got))
    print(f"engine: first difference at write {k}: Mesen {ref[k:k+4]}  headless {got[k:k+4]}")
    return False


def check_requests(engine, ram0, sram0, w):
    """Each request: from the RAM the game had just before it (ram0 + every engine-RAM write before
    the request's write), the adapter's request must write what the game wrote until the next tick."""
    reqs = [r for r in w["req"] if r["address"] == SOUND_REQUEST_ID]
    if not reqs:
        print("requests: none in this run (check 1 covers ticks only)")
        return True
    ticks = sorted(r["cpu.cycleCount"] for r in w["tick"])
    ok = True
    for r in reqs:
        c0 = r["cpu.cycleCount"]
        c1 = next((t for t in ticks if t > c0), float("inf"))
        # what play_audio_by_id reads besides ROM: the engine RAM and audio_wait_gate, as they stood
        before = [(x["address"], x["value"]) for x in w["ram"] + w["gate"] if x["cpu.cycleCount"] < c0]
        game = {x["address"]: x["value"] for x in w["ram"] if c0 < x["cpu.cycleCount"] < c1 and outside(x)}
        mem = engine.machine()
        mem.ram[:] = ram0
        mem.sram[:] = sram0
        mem.switch_bank(ram0[PRG_BANK_SHADOW])
        for a, v in before:
            mem.write(a, v)
        snap = bytes(mem.read(a) for a in range(ENGINE_RAM[0], ENGINE_RAM[1] + 1))
        engine.request(r["value"])
        mine = {a: mem.read(a) for a in range(ENGINE_RAM[0], ENGINE_RAM[1] + 1)
                if mem.read(a) != snap[a - ENGINE_RAM[0]] or a in game}
        same = all(mine.get(a) == v for a, v in game.items()) and all(game.get(a, snap[a - ENGINE_RAM[0]]) == v
                                                                       for a, v in mine.items())
        ok &= same
        print(f"request {r['value']:2d} at cycle {c0:,}: game wrote {len(game)} engine bytes, "
              f"{'identical' if same else 'DIFFERENT'}")
        if not same:
            for a in sorted(set(game) | set(mine)):
                if game.get(a) != mine.get(a):
                    print(f"    ${a:04X}: game {game.get(a)}  headless {mine.get(a)}")
    return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("state", type=Path, nargs="?", help="Mesen .mss savestate (omit: from power-on)")
    ap.add_argument("--inputs", default="wait*1800", help='live.run script, e.g. "a,wait*120"')
    a = ap.parse_args()
    ram0, sram0, w = record(a.state, a.inputs, Path(tempfile.mkdtemp(prefix="sound-verify-")))
    engine = Engine()
    ok = check_engine(engine, ram0, sram0, w)
    ok &= check_requests(engine, ram0, sram0, w)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
