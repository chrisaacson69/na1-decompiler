"""
data-xref.py - who reads / writes / points at a data address. The variable-side
twin of native-call-index.py: name a sub by behavior, then ask "who touches X?" to
recover a DATA item's role. Covers BOTH halves of the data world:

  * RAM/SRAM variables ($0000-$7FFF) -- read/written by the absolute value family
    ($A4-$AB). The $6xxx/$7xxx game-state vars.
  * ROM data / ASSETS ($8000-$FFFF) -- referenced as a 16-bit IMMEDIATE address (a
    pointer/base) by the *_imm2 family (LOADR_imm2 / LOADL_imm2 / PUSH_imm2). This
    is how tables, CHR, and message strings are reached, so it is how you FIND a
    labeled asset's uses (and which unlabeled assets are worth naming next).

SOURCE: the VM bytecode disasm (source/2-asm-vm/bank_NN_vm.asm), where the game
logic lives. Each ref maps to its containing `; sub $XXXX`, named via the toml --
i.e. the C function in source/4-c/. So `refs daimyo_banner_chr` answers "where, in
the C, is this asset used?"

ROM is bank-switched: $8000-$BFFF means a different asset per bank, so ROM refs are
keyed by PRG offset (bank*0x4000 + cpu&0x3FFF), the bank-unambiguous identity (same
keying as the .mlb / load_labels_by_prg). RAM/SRAM is bank-independent.

Opcode classification (as THIS ROM's handlers model them; the spec's "STORE_abs"
note on $A8 is misleading -- $A8 is a LOAD here):
  READ : A4 word->A, A5 byte->A, A6 word->B, A8 word->A, AA push word, AB push byte
  ADDR : A7 address-of -> A
  WRITE: A9 byte store -> abs
  PTR  : any *_imm2 -- loads a 16-bit address constant (a data pointer/base)
  CAVEAT: word stores to a FIXED address go through frame-relative ($85 STORE_near)
  or indirect ($B1) opcodes that carry no static address -- so WRITE is a LOWER
  BOUND. Don't read "0 writers" as "never written" (e.g. $6FF6, frame-relative).

Commands (addr accepts 6FF6 / 0x6FF6 / $6FF6 / a label name):
  refs <addr|name>         every ref, grouped by sub (= C function), kind + site
  hot [--min N]            RAM/SRAM vars ranked by ref count (naming priority)
      [--unlabeled]        ... restricted to addresses with NO toml name yet
      [--lo HEX --hi HEX]  ... restricted to a window (default 0x6000-0x7FFF)
  hot --rom [--min N]      ROM ASSETS ranked by pointer-ref count, per (bank,addr)
      [--unlabeled]
"""
import argparse
import re
import sys
from collections import defaultdict
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
DISASM = PROJ / "source" / "2-asm-vm"   # VM bytecode disasm (stage 2)
CODE_BANKS = (0, 1, 2, 10, 14, 15)      # every bank that holds bytecode

sys.path.insert(0, str(PROJ / "tools"))
from importlib import import_module
_nv = import_module("na1dream.nobunaga_vm")

# absolute value family ($A4-$AB): how a RAM/SRAM VARIABLE is read/written.
ABS_KIND = {
    0xA4: "read", 0xA5: "read", 0xA6: "read", 0xAA: "read",
    0xAB: "read", 0xA7: "addr", 0xA8: "write", 0xA9: "write",
}

INS_RE = re.compile(
    r'^\s*>?\$([0-9A-Fa-f]{4})\s+'                 # 1: instruction address
    r'([0-9A-Fa-f]{2}(?:\s+[0-9A-Fa-f]{2})*)\s+'   # 2: raw bytes
    r'(\S+)'                                       # 3: mnemonic
    r'(.*)$'                                       # 4: operand + comment
)
SUB_RE = re.compile(r'^;\s*sub\s+\$([0-9A-Fa-f]{4})')


def _prg_off(bank, cpu):
    """Bank-unambiguous ROM identity. $C000-$FFFF is the MMC1 FIXED bank 15 no matter
    which bank the *referencing* code sits in, so key those to 15; $8000-$BFFF is the
    switchable window, keyed to the referencing bank."""
    fixed = 15 if cpu >= 0xC000 else bank
    return fixed * 0x4000 + (cpu & 0x3FFF)


def build_index():
    """Scan the VM-asm. Returns (ram, rom):
      ram: addr (int, <$8000) -> [ref]          bank-independent vars + table bases
      rom: prg_off (int)      -> [ref]          ROM assets, keyed by PRG offset
    Each ref: {bank, sub, ins, opc, kind, mnem, cpu}."""
    ram = defaultdict(list)
    rom = defaultdict(list)
    for bank in CODE_BANKS:
        path = DISASM / f"bank_{bank:02d}_vm.asm"
        if not path.exists():
            continue
        cur_sub = None
        for line in path.read_text(encoding="utf-8", errors="ignore").splitlines():
            sm = SUB_RE.match(line)
            if sm:
                cur_sub = int(sm.group(1), 16)
                continue
            m = INS_RE.match(line)
            if not m:
                continue
            mnem = m.group(3)
            opc = int(m.group(2).split()[0], 16)
            am = re.search(r'\$([0-9A-Fa-f]{4})', m.group(4))
            if not am:
                continue
            addr = int(am.group(1), 16)
            kind = ABS_KIND.get(opc)
            if kind is None and "imm2" in mnem:
                kind = "ptr"                        # a 16-bit address constant = a pointer
            if kind is None:
                continue
            ref = {"bank": bank, "sub": cur_sub, "ins": int(m.group(1), 16),
                   "opc": opc, "kind": kind, "mnem": mnem, "cpu": addr}
            if addr < 0x8000:
                ram[addr].append(ref)               # RAM/SRAM var or table base
            else:
                rom[_prg_off(bank, addr)].append(ref)   # ROM asset (per bank)
    return ram, rom


def _norm(tok):
    return int(tok.lstrip("$"), 16)


def _sub_name(labels, sub):
    if sub is None:
        return "(top-level)"
    v = labels.get(sub)
    name = (v[0] if isinstance(v, tuple) else v) if v else None
    return f"{name} (${sub:04X})" if name else f"sub_${sub:04X}"


def _kinds(rs):
    c = lambda k: sum(r["kind"] == k for r in rs)
    return f"{c('read')}R {c('write')}W {c('addr')}& {c('ptr')}P"


def _print_grouped(rs, labels, header):
    print(header)
    by_sub = defaultdict(list)
    for r in rs:
        by_sub[(r["bank"], r["sub"])].append(r)
    for (bank, sub) in sorted(by_sub, key=lambda k: (k[0], k[1] is None, k[1])):
        sites = by_sub[(bank, sub)]
        tags = ", ".join(f"{r['kind']}@${r['ins']:04X}" for r in sorted(sites, key=lambda r: r["ins"]))
        print(f"  bank{bank:02d}  {_sub_name(labels, sub)}: {tags}")
    if not rs:
        print("  (no static refs; may be ZP / frame-relative / indirect only)")


def _name_of(labels, addr):
    lab = labels.get(addr)
    return (lab[0] if isinstance(lab, tuple) else lab) if lab else None


def cmd_refs(query, ram, rom, labels):
    # resolve a label name (via the flat toml) or a literal hex address -> cpu addr
    name_to_addr = {v[0]: a for a, v in labels.items()}
    q = query.strip()
    try:
        addr = _norm(q)
    except ValueError:
        if q not in name_to_addr:
            print(f"// unknown label: {q}"); return
        addr = name_to_addr[q]

    nm = _name_of(labels, addr)
    if addr < 0x8000:                                # RAM/SRAM var
        rs = ram.get(addr, [])
        _print_grouped(rs, labels, f"// ${addr:04X}  {nm or '(unlabeled)'}   {len(rs)} refs  ({_kinds(rs)})")
    elif addr >= 0xC000:                             # fixed bank 15 (unambiguous)
        rs = rom.get(_prg_off(15, addr), [])
        _print_grouped(rs, labels, f"// ${addr:04X}  (bank15)  {nm or '(unlabeled)'}   {len(rs)} refs  ({_kinds(rs)})")
    else:                                            # switchable $8000-$BFFF -> every bank that refs it
        hits = sorted((prg, rs) for prg, rs in rom.items() if (prg & 0x3FFF) == (addr & 0x3FFF))
        if not hits:
            print(f"// ${addr:04X}  (ROM) — no pointer refs in any bank"); return
        for prg, rs in hits:
            _print_grouped(rs, labels, f"// ${addr:04X} @ bank{prg // 0x4000:02d}  {nm or '(unlabeled)'}   {len(rs)} refs  ({_kinds(rs)})")


def cmd_hot_ram(ram, labels, min_n, unlabeled, lo, hi):
    rows = []
    for addr, rs in ram.items():
        if not (lo <= addr <= hi) or len(rs) < min_n:
            continue
        lab = labels.get(addr)
        name = (lab[0] if isinstance(lab, tuple) else lab) if lab else None
        if unlabeled and name:
            continue
        c = lambda k: sum(r["kind"] == k for r in rs)
        rows.append((len(rs), addr, c('read'), c('write'), c('addr'), c('ptr'),
                     len({r["sub"] for r in rs}), name))
    rows.sort(key=lambda t: (-t[0], t[1]))
    print(f"// {len(rows)} addresses  (window ${lo:04X}-${hi:04X}, min {min_n} refs"
          f"{', unlabeled only' if unlabeled else ''})")
    print(f"// {'addr':>6}  {'refs':>4} {'R':>3} {'W':>3} {'&':>3} {'P':>3} {'subs':>4}  label")
    for n, addr, nr, nw, na, npp, nsubs, name in rows:
        print(f"   ${addr:04X}  {n:>4} {nr:>3} {nw:>3} {na:>3} {npp:>3} {nsubs:>4}  {name or '-'}")


def cmd_hot_rom(rom, labels, min_n, unlabeled):
    rows = []
    for prg, rs in rom.items():
        if len(rs) < min_n:
            continue
        cpu = rs[0]["cpu"]
        name = _name_of(labels, cpu)               # flat toml: resolves regardless of mis-filed section
        if unlabeled and name:
            continue
        data_bank = 15 if cpu >= 0xC000 else rs[0]["bank"]
        rows.append((len(rs), data_bank, cpu, len({r["sub"] for r in rs}), name))
    rows.sort(key=lambda t: (-t[0], t[1], t[2]))
    print(f"// {len(rows)} ROM data assets  (min {min_n} pointer-refs"
          f"{', unlabeled only' if unlabeled else ''})")
    print(f"// {'bank':>4} {'addr':>6}  {'refs':>4} {'subs':>4}  label")
    for n, bank, cpu, nsubs, name in rows:
        print(f"   b{bank:02d}   ${cpu:04X}  {n:>4} {nsubs:>4}  {name or '-'}")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("refs"); p.add_argument("addr")
    p = sub.add_parser("hot")
    p.add_argument("--min", type=int, default=3)
    p.add_argument("--unlabeled", action="store_true")
    p.add_argument("--rom", action="store_true", help="rank ROM assets (pointer-refs) instead of RAM vars")
    p.add_argument("--lo", default="0x6000")
    p.add_argument("--hi", default="0x7FFF")
    args = ap.parse_args()

    ram, rom = build_index()
    labels = _nv.load_labels()
    if args.cmd == "refs":
        cmd_refs(args.addr, ram, rom, labels)
    elif args.cmd == "hot":
        if args.rom:
            cmd_hot_rom(rom, labels, args.min, args.unlabeled)
        else:
            cmd_hot_ram(ram, labels, args.min, args.unlabeled, _norm(args.lo), _norm(args.hi))


if __name__ == "__main__":
    main()
