"""
mesen-labels.py - project mesen-labels.toml (the single source of truth for every
named address) onto its consumers. One label edit -> propagates everywhere.

The toml is authoritative; this tool NEVER writes back to it. Targets:

  --mlb [PATH]   Emit a Mesen 2 .mlb label file. Default: the committed one at the project root,
                 copied beside the ROM (the ROM store) so Mesen 2 auto-loads it on launch.
                 Delegates to emu-harness (shared reader, NES locator, Mesen writer;
                 needs `py -3.14` + `pip install -e ../../emu-harness`). Registry
                 defects and labels Mesen would drop are printed.

  --asm          Regenerate source/1-asm-6502/bank_NN_labeled.asm (code banks
                 0/1/2/10/14/15) via tools/labeled_6502.py, rewriting code labels
                 (b{NN}_{addr} definitions + jsr/jmp/branch operands) and RAM/SaveRAM
                 operands ($0000-$07FF / $6000-$7FFF) to their toml names. These files
                 are COMMITTED and must stay in sync with the toml -- see --verify.

  --verify       Check each committed *_labeled.asm against a fresh regen; exit 1 if
                 any is stale (toml changed but --asm not re-run). Wire into CI /
                 pre-commit so the labeled disasm can never silently drift again.

  --check        Parse + classify only; print coverage stats, no files written.

The decompiler (vm_decompile.py) already reads the toml directly, so decompiled/*.c
is covered for free -- this tool closes the gap for Mesen and the native disasm.

Every target needs `py -3.14` with emu-harness installed (pip install -e ../../emu-harness):
--mlb / --check use its registry reader and Mesen writer, --asm / --verify its passes/listing.
Run from anywhere.
"""
import argparse
import re
import sys
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent
TOML = PROJ / "mesen-labels.toml"
from emu_harness.vm.koei.nes.titles import game_cfg   # the ROM: the machine's ROM store, via the [na1] profile
ROM = game_cfg("na1")["_rom"]
MLB = PROJ / Path(ROM).with_suffix(".mlb").name   # the committed label file; Mesen also gets a copy beside the ROM
DISASM = PROJ / "source" / "1-asm-6502"   # native 6502 disassembly (pipeline stage 1)

BANK_SIZE = 0x4000

# ---------------------------------------------------------------------------
# toml parse (tailored; entries are single-line and uniform)
# ---------------------------------------------------------------------------
SECTION_RE = re.compile(r'^\[([^\]]+)\]')
# "0xADDR" = { name = "NAME", comment = "COMMENT" }   (comment optional)
ENTRY_RE = re.compile(
    r'^"0x([0-9A-Fa-f]+)"\s*=\s*\{\s*'
    r'name\s*=\s*"((?:[^"\\]|\\.)*)"'
    r'(?:\s*,\s*comment\s*=\s*"((?:[^"\\]|\\.)*)")?'
    r'\s*\}'
)


def _unescape(s):
    """TOML basic-string escapes -> plain text, flattened to one line for .mlb."""
    if s is None:
        return ""
    out, i = [], 0
    while i < len(s):
        c = s[i]
        if c == "\\" and i + 1 < len(s):
            nxt = s[i + 1]
            out.append({"n": " ", "t": " ", '"': '"', "\\": "\\"}.get(nxt, nxt))
            i += 2
        else:
            out.append(c)
            i += 1
    return "".join(out).replace("\r", " ").replace("\n", " ")


class Label:
    __slots__ = ("addr", "name", "comment", "section", "section_bank")

    def __init__(self, addr, name, comment, section):
        self.addr = addr
        self.name = name
        self.comment = comment
        self.section = section
        # section_bank is None for [ram]; the int written in the [prg.bankN] header.
        m = re.match(r"prg\.bank(\d+)", section)
        self.section_bank = int(m.group(1)) if m else None

    @property
    def bank(self):
        """Physical PRG bank. $C000-$FFFF is the MMC1 FIXED bank (15) regardless of
        which section the entry was written under -- the address is authoritative,
        the section is just organization (and ~60 kernel labels are mis-filed under
        [prg.bank0]). $8000-$BFFF is switchable, so trust the section there."""
        if self.section_bank is None:
            return None
        if self.addr >= 0xC000:
            return 15
        return self.section_bank

    @property
    def missectioned(self):
        return self.bank is not None and self.bank != self.section_bank


def parse_toml(path=TOML):
    labels = []
    section = None
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        m = SECTION_RE.match(line)
        if m:
            section = m.group(1)
            continue
        if not line.startswith('"0x'):
            continue
        e = ENTRY_RE.match(line)
        if not e:
            print(f"WARN: unparsed entry: {raw!r}", file=sys.stderr)
            continue
        labels.append(Label(int(e.group(1), 16), e.group(2),
                            _unescape(e.group(3)), section))
    mis = [l for l in labels if l.missectioned]
    if mis:
        print(f"NOTE: {len(mis)} fixed-bank labels ($C000-$FFFF) are filed under the "
              f"wrong [prg.bankN] section (normalized to bank 15). e.g. "
              f"{mis[0].name} (${mis[0].addr:04X}) under [prg.bank{mis[0].section_bank}]. "
              f"Tool output is correct; consider moving them to [prg.bank15] in the toml.",
              file=sys.stderr)
    return labels


# ---------------------------------------------------------------------------
# --mlb / --check: the shared emu-harness label export (row A of its MIGRATION.md).
# Imported here, not at the top, so --asm / --verify still run on py -3 (3.9);
# these two need `py -3.14` with emu-harness installed (pip install -e ../../emu-harness).
# ---------------------------------------------------------------------------
def mlb_symbols():
    """-> (symbols, registry defects, entries outside PRG), via emu-harness."""
    from emu_harness.core.symbols import Symbol, read_registry
    from emu_harness.machines.nes.memory import Cart, locate
    reg, cart = read_registry(TOML), Cart.from_ines(ROM)
    symbols, lost = [], []
    for e in reg.entries:
        where = locate(cart, e.section, e.addr)
        if where is None:
            lost.append(e)
        else:
            symbols.append(Symbol(where[0], where[1], e.name, e.comment))
    return symbols, reg.defects, lost


def emit_mlb(out_path):
    from emu_harness.backends.mesen.labels import write_mlb
    symbols, defects, lost = mlb_symbols()
    problems = write_mlb(symbols, out_path)
    by_type = {}
    for s in symbols:
        by_type[s.region] = by_type.get(s.region, 0) + 1
    for d in defects:
        print(f"  registry line {d.line}: {d.kind} {d.detail}")
    for e in lost:
        print(f"  outside PRG: line {e.line} [{e.section}] ${e.addr:04X} {e.name}")
    for p in problems:
        print(f"  dropped: {p}")
    return by_type, len(problems)


# ---------------------------------------------------------------------------
# --asm: rewrite raw disasm with toml names. The algorithm moved to emu-harness
# passes/listing (row A3 of its MIGRATION.md; it was this file's apply_to_asm):
# b{NN}_{addr} tokens and RAM operands renamed, the trailing `; OFFSET: bytes`
# comment protected, fixed-bank anchors inserted. $C000-$FFFF labels count as
# bank 15's whatever section they sit under.
# ---------------------------------------------------------------------------
# Only banks 0/1/2/15 contain code (3-14 are data per the ROADMAP). Bank 15's
# raw disasm uses symbolic b15_ operands so code-label propagation is full; banks
# 0/1/2 use raw $XXXX operands (their code reads better as decompiled/*.c), so
# they mainly gain RAM-operand labels here.
CODE_BANKS = (0, 1, 2, 10, 14, 15)      # every bank with bytecode (the VM listings' set)
FIXED_BANK = 15


def _regen_one(bank):
    """Return (labeled_path, regenerated_text). The view comes from tools/labeled_6502.py: the discover
    walk's native code, bytecode subs as a pointer to the VM listing, data as rows. (Until 2026-10-29 this
    relabelled nes-disasm6's force-decoded bank_NN.asm: every line labelled b15_xxxx, bytecode decoded as
    6502; passes.listing.relabel_disasm6 still exists for titles that keep that dialect.)"""
    import labeled_6502
    return DISASM / f"bank_{bank:02d}_labeled.asm", labeled_6502.render_bank(bank)


def emit_labeled_asm(labels, dry_run=False):
    results = []
    for bank in CODE_BANKS:
        out, text = _regen_one(bank)
        if not dry_run:
            out.write_text(text, encoding="utf-8")
        results.append((out.name, len(text.splitlines()), 0, []))
    return results


def verify_labeled_asm(labels):
    """Compare each committed *_labeled.asm against a fresh in-memory regen.
    Returns list of (filename, status) where status is 'ok' | 'STALE' | 'missing'."""
    results = []
    for bank in CODE_BANKS:
        out, text = _regen_one(bank)
        if not out.exists():
            results.append((out.name, "missing"))
        elif out.read_text(encoding="utf-8") == text:
            results.append((out.name, "ok"))
        else:
            results.append((out.name, "STALE"))
    return results


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--mlb", nargs="?", const="__default__", metavar="PATH",
                    help="write Mesen .mlb (default: beside ROM, ROM basename)")
    ap.add_argument("--asm", action="store_true",
                    help="regenerate committed source/1-asm-6502/bank_NN_labeled.asm from the toml")
    ap.add_argument("--verify", action="store_true",
                    help="check committed *_labeled.asm match a fresh regen; exit 1 if stale")
    ap.add_argument("--check", action="store_true",
                    help="parse + classify only; print stats, write nothing")
    ap.add_argument("--dry-run", action="store_true",
                    help="with --asm: report anchor insertions but write no files")
    args = ap.parse_args()

    labels = parse_toml()
    print(f"Parsed {len(labels)} labels from {TOML.name}")

    if args.verify:
        stale = []
        for name, status in verify_labeled_asm(labels):
            print(f"  {status:8s} {name}")
            if status != "ok":
                stale.append(name)
        if stale:
            print(f"\nSTALE: {len(stale)} file(s) out of date with the toml. "
                  f"Run `py -3 mesen-labels.py --asm` and commit.")
            sys.exit(1)
        print("\nAll committed *_labeled.asm are current with the toml.")
        return

    if args.check or not (args.mlb or args.asm):
        by_type = {}
        for s in mlb_symbols()[0]:
            by_type[s.region] = by_type.get(s.region, 0) + 1
        for t, n in sorted(by_type.items()):
            print(f"  {t:16s} {n}")
        if not (args.mlb or args.asm):
            print("\n(no target given; use --mlb, --asm, or --verify. --check = stats only)")
            return

    if args.mlb:
        if args.mlb == "__default__":
            out = MLB
        else:
            out = Path(args.mlb)
        by_type, dropped = emit_mlb(out)
        if args.mlb == "__default__" and Path(ROM).parent.resolve() != PROJ.resolve() and Path(ROM).exists():
            import shutil                                   # Mesen 2 auto-loads a .mlb beside the ROM it opens
            shutil.copyfile(out, Path(ROM).with_suffix(".mlb"))
            print(f"copied -> {Path(ROM).with_suffix('.mlb')} (beside the ROM, for Mesen)")
        total = sum(by_type.values()) - dropped
        print(f"Wrote {total} labels -> {out}")
        for t, n in sorted(by_type.items()):
            print(f"  {t:16s} {n}")

    if args.asm or args.dry_run:
        verb = "Would write" if args.dry_run else "Wrote"
        for name, nc, nr, inserted in emit_labeled_asm(labels, dry_run=args.dry_run):
            print(f"{verb} {name}: {nc} lines")
            for off, nm in inserted:
                print(f"    + anchor @file ${off:05X} (cpu ${0xC000 + (off & 0x3FFF):04X}): {nm}")


if __name__ == "__main__":
    main()
