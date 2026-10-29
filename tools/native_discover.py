#!/usr/bin/env python3
"""native_discover.py - the discover gate for NA1's fixed-bank 6502 (emu-harness PHASES.md section 2).

A KOEI fixed bank interleaves native 6502 with bytecode, so the native walk first masks every
bytecode sub's body as data (extents from the round-trip encoder, the 3-byte `JSR vm_entry` stub
kept as code) along with the VM's own tables. Then:

  1. walk     NativeMap.reach from native_floor's seeds + its subs, plus what they miss: the natives
              only bytecode calls (from the call graph), the syscall table's JMP entries, and the
              syscall RTI continuation $F23C (syscall_dispatch pushes $F23C, PHP, JMP ($FFFE)).
  2. conflict NativeMap.conflicts through passes.native.explain; the illegal-opcode BRK traps
              ($EF92/$EF93, where the handler table sends the 38 dead opcodes) are named here.
  3. tables   every JMP (ind) site and what dispatches through it.
  4. holes    every fixed-bank PC in the Mesen traces (traces/*.txt[.gz]) must be an instruction
              start of the walk or a bytecode stub; anything else is a hole, by definition.

Usage (from the repo root):  py -3.14 tools/native_discover.py [--no-traces]
Exit 1 on an unexplained conflict or a hole.
"""
import argparse
import glob
import gzip
import sys
from pathlib import Path

from emu_harness.core.symbols import names_by_address, read_registry
from emu_harness.cpu.m6502.descent import Window
from emu_harness.passes import native as N
from emu_harness.vm.koei.nes import native_floor as NF
from emu_harness.vm.koei.nes.callgraph import build
from emu_harness.vm.koei.nes.nobunaga_vm import NobunagaVM
from emu_harness.vm.koei.nes.vm_assemble import bank_range, encode_sub, find_stubs

HERE = Path(__file__).resolve().parent.parent
SYSCALL_RTI = 0xF23C                     # syscall_dispatch's pushed return: reached only by RTI
BRK_TRAPS = {0xEF92: "illegal-opcode BRK trap", 0xEF93: "illegal-opcode BRK trap ($FF)"}
PHANTOMS = {0xF007: "census hit from operand bytes (lda $0720 / beq at $C7FD, $C82A)",
            0xFFFF: "census hit from data bytes 20 FF FF"}


def bytecode_spans():
    vm = NobunagaVM()
    vm.switch_bank(15)
    base, size = bank_range(15)
    stubs = find_stubs(vm.mem, base, size)
    bounds = stubs + [base + size]
    return [(s, encode_sub(vm.mem, s, bounds[i + 1])[1]) for i, s in enumerate(stubs)]


def walk():
    t = NF.Title("na1")
    cfg = t.cfg
    m = N.NativeMap(Window(bytearray(t.buf), 0xC000))
    spans = bytecode_spans()
    for s, e in spans:
        m.mark_data(s + 3, e - s - 3)
    m.mark_data(cfg["handler_lo"], 0x200)
    m.mark_data(t.nf["extop_table"], 2 * t.nf["extop_slots"])
    m.mark_data(0xFFFA, 6)
    G = build("na1")
    from_bc = {d[1] for (src, d), ks in G.edges.items()
               if "call" in ks and (src[1] < 0xC000 or t.is_stub(src[1])) and 0xC000 <= d[1] and not t.is_stub(d[1])}
    seeds = {a for a in NF.seeds(t) if t.in_bank(a)}
    subs, _census = NF.native_subs(t)
    systab = {cfg["syscall_table"] + 3 * k for k in range(t.nf["syscall_slots"])}
    start = (seeds | set(subs) | from_bc | systab | {SYSCALL_RTI}) - set(PHANTOMS)
    routines, starts = m.reach(start)
    return t, m, spans, routines, {m.canon(a) for a in starts}, from_bc


def trace_pcs(paths):
    pcs = {}
    for f in paths:
        with (gzip.open if f.endswith(".gz") else open)(f, "rt", errors="replace") as fh:
            for line in fh:
                if line[:1] in "CDEF" and line[4:6] == "  ":
                    try:
                        a = int(line[:4], 16)
                    except ValueError:
                        continue
                    pcs[a] = pcs.get(a, 0) + 1
    return pcs


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--no-traces", action="store_true", help="skip the hole check")
    a = ap.parse_args(argv)
    t, m, spans, routines, starts, from_bc = walk()
    names = names_by_address(read_registry(t.cfg["_labels"]))
    bad = 0
    print(f"bank 15: {len(spans)} bytecode subs masked; {len(routines)} native routines, "
          f"{sum(m.code)} code bytes ({len(from_bc)} natives only bytecode calls)")
    for kind, addrs in m.conflicts().items():
        for x in addrs:
            why = N.explain(m, kind, x) or BRK_TRAPS.get(x)
            bad += why is None
            print(f"  conflict {kind} ${x:04X}: {why or 'UNEXPLAINED'}")
    for x, why in PHANTOMS.items():
        print(f"  dropped phantom ${x:04X}: {why}")
    _tables, sites, _r, _s = N.dispatch_tables(m, set(routines))
    for s in sorted(m.canon(x) for x in sites):
        own = max((r for r in routines if r <= s), default=0)
        print(f"  JMP (ind) ${s:04X} in {names.get(own, f'${own:04X}')}")
    if not a.no_traces:
        files = sorted(glob.glob(str(HERE / "traces" / "*.txt.gz")) + glob.glob(str(HERE / "traces" / "*trace*.txt")))
        pcs = trace_pcs(files)
        holes = [x for x in pcs if x not in starts and not t.is_stub(x)]
        stubs = sum(1 for x in pcs if t.is_stub(x))
        print(f"holes: {len(files)} traces, {sum(pcs.values()):,} fixed-bank steps, {len(pcs)} distinct PCs: "
              f"{len(pcs) - stubs - len(holes)} walk starts, {stubs} bytecode stubs, {len(holes)} holes; "
              f"walk starts executed {sum(1 for x in starts if x in pcs)}/{len(starts)}")
        for x in sorted(holes):
            print(f"  HOLE ${x:04X} x{pcs[x]}")
        bad += len(holes)
    print("PASS" if not bad else f"FAIL: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
