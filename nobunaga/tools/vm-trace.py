#!/usr/bin/env python3
"""Headless VM trace: tools/lua/vm-trace.lua's log, without the Mesen GUI (emu-harness row P2).

One emu-harness `watch` on the dispatcher ($E867) logs the VM registers ($02-$0D) and the 4 bytes
at the VM PC on every dispatch; the probe's trigger / call-depth / outermost-RETURN logic then runs
here, over that log ("log now, calc later"). Output lines match the Lua probe's.

  py -3.14 tools/vm-trace.py <state.mss|bridge-state.txt> [--inputs "a,wait*40,..."]
                             [--trigger 967A] [--out trace.txt] [--check]

--check also runs tools/lua/vm-trace.lua (its TRIGGER constant set to --trigger) in the same
session and fails unless both logs are identical. 2026-10-26: NAsave1.mss, trigger $858D:
240 lines, 60 cycles, identical.
"""
import argparse
import sys
import tempfile
from pathlib import Path

from emu_harness.backends.mesen import read_watch
from emu_harness.machines.nes import NES
from emu_harness.machines.nes.live import run

HERE = Path(__file__).resolve().parent
ROM = HERE.parent / "Nobunaga's Ambition (USA).nes"
PROBE = HERE / "lua" / "vm-trace.lua"
DISPATCHER = 0xE867
CALL_OPS, RETURN_OP, MAX_LOG = {0xAC, 0xDD, 0xE9, 0xEA}, 0xCF, 5000
ZP, AT_PC = ("nesDebug", 2, 12), ("nesDebug", "*6", 4)   # $02 SP $04 FP $06 PC $08 L $0C R


def trace_lines(rows, trigger):
    """vm-trace.lua's on_dispatcher over watch rows."""
    out, active, depth, count = [], False, 0, 0
    w = lambda b, i: b[i] | b[i + 1] << 8
    for r in rows:
        zp, ops = r["nesDebug:2:12"], r["nesDebug:*6:4"]
        sp, fp, vmpc, reg_l, reg_r = w(zp, 0), w(zp, 2), w(zp, 4), w(zp, 6), w(zp, 10)
        op = ops[0]
        if not active:
            if vmpc != trigger:
                continue
            active, depth, count = True, 0, 0
            out.append(f"=== TRIGGER: VM entered ${trigger:04X} ===")
        out.append("   VMPC=$%04X op=$%02X+(%02X %02X %02X)  L=$%04X R=$%04X SP=$%04X FP=$%04X  d=%d"
                   % (vmpc, op, ops[1], ops[2], ops[3], reg_l, reg_r, sp, fp, depth))
        if op in CALL_OPS:
            depth += 1
        elif op == RETURN_OP:
            depth -= 1
            if depth < 0:
                out.append("=== OUTERMOST RETURN reached ===")
                active = False
                continue
        count += 1
        if count > MAX_LOG:
            out.append("=== MAX_LOG reached ===")
            active = False
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("state", type=Path, help="Mesen .mss savestate, or a bridge state text file")
    ap.add_argument("--inputs", default="", help='live.run script, e.g. "a,wait*40"')
    ap.add_argument("--trigger", default="967A", help="VM PC that starts a trace (hex)")
    ap.add_argument("--out", type=Path, help="write the trace here (default: stdout)")
    ap.add_argument("--check", action="store_true", help="also run the Lua probe and diff")
    a = ap.parse_args()
    trigger = int(a.trigger, 16)
    tmp = Path(tempfile.mkdtemp(prefix="vm-trace-"))
    scripts = []
    if a.check:
        src = PROBE.read_text()
        assert src.count("local TRIGGER_VM_PC = 0x967A") == 1, "vm-trace.lua's trigger line changed"
        probe = tmp / "vm-trace.lua"
        probe.write_text(src.replace("local TRIGGER_VM_PC = 0x967A", f"local TRIGGER_VM_PC = 0x{trigger:04X}"))
        scripts = [probe]
    with NES(ROM, scripts=scripts) as m:
        m.step(frames=5)
        m.load("00000000" + a.state.read_bytes().hex() if a.state.suffix == ".mss" else a.state.read_text())
        m.watch("exec", DISPATCHER, DISPATCHER, tmp / "watch.txt", ranges=[ZP, AT_PC])
        run(m, a.inputs)
        m.watch_off()
        lua_log = m.script_log
    lines = trace_lines(read_watch(tmp / "watch.txt"), trigger)
    text = "\n".join(lines) + "\n"
    if a.out:
        a.out.write_text(text)
        print(f"wrote {a.out} ({len(lines)} lines)")
    else:
        sys.stdout.write(text)
    if a.check:
        lua = [l.rstrip() for l in Path(lua_log).read_text().splitlines() if l.startswith(("  ", "==="))]
        ok = lua == lines
        print(f"check vs vm-trace.lua: {'IDENTICAL' if ok else 'DIFFERENT'} ({len(lua)} / {len(lines)} lines)",
              file=sys.stderr)
        sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
