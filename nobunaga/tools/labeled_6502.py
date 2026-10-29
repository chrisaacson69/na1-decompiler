#!/usr/bin/env python3
"""labeled_6502.py - the labeled 6502 listing of one NA1 bank, as a reading view.

Laid out like Mappy's labeled listing: names and branch targets flush left, every instruction indented
under them as `ADDR: bytes  mnemonic operand`. What it knows, and where from:

  native code   the discover walk (tools/native_discover.py: for the fixed bank the same instruction
                starts its gate proves against 30 M traced steps; for a bytecode bank a walk from the
                bank's $8000 entry), decoded with emu_harness.cpu.m6502's opcode table
  bytecode      each sub's extent from the round-trip encoder (vm_assemble.encode_sub): the 3-byte
                JSR into the VM and the frame word are shown, the body is ONE line pointing at the VM
                listing (source/2-asm-vm/bank_NN_vm_labeled.asm), not pages of 6502 mis-decoded bytes
  data          everything else, 16 bytes a row, with a printable-ASCII gutter
  names         the bank-scoped registry (titles.bank_scoped_labels); a branch / jump target with no
                name gets L_XXXX, and nothing else gets a label

It replaces the relabel of nes-disasm6's force-decoded bank_NN.asm (every line labelled b15_xxxx,
bytecode decoded as 6502). Called by mesen-labels.py --asm / --verify; runnable alone:

    py -3.14 tools/labeled_6502.py <bank> [out.asm]
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from emu_harness.cpu.m6502.descent import Window                                  # noqa: E402
from emu_harness.cpu.m6502.disasm import (ABS, ABX, ABY, ACC, IMM, IMP, IND, IZX, IZY,  # noqa: E402
                                          MODE_LEN, OPS, REL, ZP, ZPX, ZPY)
from emu_harness.passes import native as N                                         # noqa: E402
from emu_harness.vm.koei.nes import titles                                         # noqa: E402
from emu_harness.vm.koei.nes.nobunaga_vm import NobunagaVM                          # noqa: E402
from emu_harness.vm.koei.nes.vm_assemble import bank_range, encode_sub, find_stubs  # noqa: E402

FIXED = 15
BRANCHY = {"jmp", "jsr"}


def bytecode_spans(bank):
    vm = NobunagaVM()
    vm.switch_bank(bank)
    base, size = bank_range(bank)
    stubs = find_stubs(vm.mem, base, size)
    bounds = stubs + [base + size]
    return {s: encode_sub(vm.mem, s, bounds[i + 1])[1] for i, s in enumerate(stubs)}


def native_starts(bank, buf, base, spans):
    """Instruction starts of the bank's native code."""
    if bank == FIXED:
        import native_discover as ND
        _t, _m, _spans, _routines, starts, _from_bc = ND.walk()
        return set(starts)
    m = N.NativeMap(Window(bytearray(buf), base))
    for s, e in spans.items():
        m.mark_data(s + 3, e - s - 3)
    # seeds: the bank's $8000 entry, plus every native routine this bank's bytecode CALLs inside the
    # bank (bank 2's tactical_hex_step at $8003 is reached only that way, never from the entry)
    from emu_harness.vm.koei.nes import vm_disasm as VD
    vm = NobunagaVM()
    vm.switch_bank(bank)
    seeds = {base}
    for s, e in spans.items():
        instrs, _pc, _t = VD.walk_sub(vm.mem, s + 5, e, {})
        for ins in instrs:
            if ins["op"] in (VD.CALL_ADJ_OP, *VD.WORD_TARGET_OPS):
                t = ins["bytes"][1] | (ins["bytes"][2] << 8)
                if base <= t < base + len(buf) and t not in spans and not VD.is_bytecode_target(vm.mem, t):
                    seeds.add(t)
    _routines, starts = m.reach(seeds)
    return {m.canon(a) for a in starts}


def decode(buf, base, a):
    op = buf[a - base]
    mn, mode = OPS[op]
    n = MODE_LEN[mode]
    lo = buf[a - base + 1] if n >= 1 else 0
    hi = buf[a - base + 2] if n >= 2 else 0
    return mn, mode, lo, hi, 1 + n


def render_bank(bank):
    cfg = titles.game_cfg("na1")
    rom = Path(cfg["_rom"]).read_bytes()
    base, size = bank_range(bank)
    buf = rom[16 + bank * 0x4000: 16 + (bank + 1) * 0x4000]
    labs = {a: n for a, (n, _c) in titles.bank_scoped_labels(cfg, bank).items()}
    spans = bytecode_spans(bank)
    starts = {a for a in native_starts(bank, buf, base, spans) if base <= a < base + size}

    # branch / jump / call targets inside the bank get a label if they have no name
    targets = set()
    for a in starts:
        mn, mode, lo, hi, ln = decode(buf, base, a)
        t = None
        if mode == REL:
            t = (a + ln + ((lo ^ 0x80) - 0x80)) & 0xFFFF
        elif mn in BRANCHY and mode == ABS:
            t = (hi << 8) | lo
        if t is not None and base <= t < base + size:
            targets.add(t)

    def name(a):
        return labs.get(a) or (f"L_{a:04X}" if a in targets else None)

    def operand(mn, mode, lo, hi, a, ln):
        w = (hi << 8) | lo
        if mode == IMP:
            return ""
        if mode == ACC:
            return "a"
        if mode == IMM:
            return f"#${lo:02X}"
        if mode == REL:
            t = (a + ln + ((lo ^ 0x80) - 0x80)) & 0xFFFF
            return name(t) or f"${t:04X}"
        v = lo if mode in (ZP, ZPX, ZPY, IZX, IZY) else w
        s = labs.get(v) or (name(v) if mode == ABS and mn in BRANCHY else None) or (f"${v:02X}" if v < 0x100 and mode in (ZP, ZPX, ZPY, IZX, IZY) else f"${v:04X}")
        return {ZPX: f"{s},x", ZPY: f"{s},y", ABX: f"{s},x", ABY: f"{s},y", IND: f"({s})",
                IZX: f"({s},x)", IZY: f"({s}),y"}.get(mode, s)

    out = [f"; Nobunaga's Ambition (USA), PRG bank {bank} at ${base:04X}: labeled 6502 (generated by tools/labeled_6502.py)",
           f"; {len(spans)} bytecode subs (bodies shown in source/2-asm-vm/bank_{bank:02d}_vm_labeled.asm), "
           f"{len(starts)} native instruction starts, the rest data", ""]
    a, end = base, base + size
    while a < end:
        if a in spans:
            e = spans[a]
            out.append("")
            out.append(f"{labs.get(a, f'sub_{a:04X}')}:".ljust(48) + f"; bytecode sub ${a:04X}-${e - 1:04X}")
            mn, mode, lo, hi, ln = decode(buf, base, a)
            out.append(f"    {a:04X}: {' '.join(f'{b:02X}' for b in buf[a - base:a - base + 3]):<9} {mn} {operand(mn, mode, lo, hi, a, ln)}")
            fo = buf[a - base + 3] | (buf[a - base + 4] << 8)
            out.append(f"    {a + 3:04X}: {buf[a - base + 3]:02X} {buf[a - base + 4]:02X}     .dw ${fo:04X}".ljust(48) + "; frame offset")
            out.append(f"    {a + 5:04X}: ; {e - a - 5} bytes of bytecode -> 2-asm-vm/bank_{bank:02d}_vm_labeled.asm")
            a = e
            continue
        if a in starts:
            nm = name(a)
            if nm:
                if labs.get(a):
                    out.append("")
                out.append(f"{nm}:")
            mn, mode, lo, hi, ln = decode(buf, base, a)
            byts = " ".join(f"{b:02X}" for b in buf[a - base:a - base + ln])
            ops = operand(mn, mode, lo, hi, a, ln)
            out.append(f"    {a:04X}: {byts:<9} {mn} {ops}".rstrip())
            a += ln
            continue
        # data: up to 16 bytes, stopping at code, a bytecode sub, or a named address
        if labs.get(a):
            out.append("")
            out.append(f"{labs[a]}:")
        b = a + 1
        while b < end and b - a < 16 and b not in starts and b not in spans and b not in labs:
            b += 1
        raw = buf[a - base:b - base]
        text = "".join(chr(c) if 32 <= c < 127 else "." for c in raw)
        out.append(f"    {a:04X}: .db {', '.join(f'${c:02X}' for c in raw)}".ljust(96) + f"; {text}")
        a = b
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    bank = int(sys.argv[1])
    text = render_bank(bank)
    if len(sys.argv) > 2:
        Path(sys.argv[2]).write_text(text, encoding="utf-8")
        print(f"wrote {sys.argv[2]}")
    else:
        sys.stdout.write(text)
