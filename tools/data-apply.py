#!/usr/bin/env python3
"""data-apply.py - write NEW data labels into mesen-labels.toml, regenerate, and guard the diff.

The label-walk guard (identifier collapse) cannot take a data label: the name replaces a hex literal
(`0xBE59` -> a name), which collapses differently. So this uses emu-harness walk.guard's stricter
NAME MAPPING check instead: each new name is mapped back to the literal it replaced (C tiers) or
dropped from the `$ADDR (name)` annotation (VM listings), and every file must then be byte-equal to
its pre-regen snapshot. A name that lands on the wrong literal fails it.

Input: a TOML file with the registry's own sections ([ram], [prg.bankN]) and entries
`"0xADDR" = { name = "...", comment = "..." }`. Refuses an address already in the registry (any
section) and a name already used. On a guard failure the registry is restored and the source
regenerated back.

Usage (from nobunaga/):  py -3.14 tools/data-apply.py <entries.toml> [--dry-run]
"""
import argparse
import re
import sys
import tomllib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import na1_regen  # noqa: E402

from emu_harness.vm.koei.nes.vm_decompile import invert_condition  # noqa: E402
from emu_harness.walk.guard import normalize_names  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
TOML = ROOT / "mesen-labels.toml"
TIERS = [("source/4-c", "*.c"), ("source/3-c-basic", "*.raw.c"), ("source/2-asm-vm", "*.asm")]


def snapshot():
    return {f"{d}/{p.name}": p.read_text(encoding="utf-8") for d, g in TIERS for p in (ROOT / d).glob(g)}


def toml_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


def normalize(path, text, new):
    """Map each new name back to what the engine printed before it existed."""
    if path.endswith(".asm"):
        if new:
            text = re.sub(r" \((" + "|".join(map(re.escape, new)) + r")\)", "", text)
        return re.sub(r"labels:\s+\d+ CPU addresses named", "labels: N CPU addresses named", text)
    text = normalize_names(text, {n: f"0x{a:04X}" for n, a in new.items()}, False)
    # The engine renders an unnamed absolute as mem_XXXX and an indexed one as *(T*)((i + 0xXXXX));
    # a named base renders as name / name[i]. Canonicalize both forms for the addresses being named
    # only (byte vs word is not shown once named), so any other change still fails.
    for a in new.values():
        h = f"{a:04X}"
        text = re.sub(rf"\bmem_{h}\b", f"0x{h}", text)
        text = re.sub(rf"\*\((?:byte|word)\*\)\(\((.+?) \+ 0x{h}\)\)", rf"0x{h}[\1]", text)
    # The engine's negation folding is textual (vm_decompile.invert_condition), so a name can turn
    # `if (!((a == b))) goto` into `if ((a != b)) goto`. Fold both sides through that same function.
    return re.sub(r"if \(!\(\((.+)\)\)\) goto",
                  lambda m: "if (" + invert_condition("(" + m.group(1) + ")") + ") goto", text)


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("entries")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args(argv)
    want = tomllib.loads(Path(a.entries).read_text(encoding="utf-8"))
    reg_bytes = TOML.read_bytes()                    # a restore gives back these exact bytes
    reg_text = reg_bytes.decode("utf-8")
    nl = "\r\n" if "\r\n" in reg_text else "\n"      # keep the file's own line ending
    reg = tomllib.loads(reg_text)

    have_addr, have_name = set(), set()           # [ram] and [prg.bankN]; [vars.*] slots are per routine
    for section, ents in [("ram", reg.get("ram", {}))] + [(f"prg.{b}", e) for b, e in reg.get("prg", {}).items()]:
        for k, v in ents.items():
            if isinstance(v, dict) and "name" in v:
                have_addr.add((section, int(k, 16)))
                have_name.add(v["name"])
    flat = []                                        # (section, addr, name, comment)
    for sec, body in want.items():
        for sub, ents in (body.items() if sec == "prg" else [(None, body)]):
            section = f"prg.{sub}" if sub else sec
            for k, v in ents.items():
                flat.append((section, int(k, 16), v["name"], v.get("comment", "")))
    errs = [f"{s} 0x{x:04X} already labeled" for s, x, _, _ in flat if (s, x) in have_addr]
    errs += [f"name {n} already used" for _, _, n, _ in flat if n in have_name]
    names = [n for *_, n, _ in flat]
    errs += [f"name {n} given twice" for n in set(names) if names.count(n) > 1]
    if errs:
        sys.exit("refused:\n  " + "\n  ".join(errs))

    out = reg_text
    for section in dict.fromkeys(s for s, *_ in flat):
        lines = "".join(f'"0x{x:04X}" = {{ name = "{n}", comment = "{toml_escape(c)}" }}{nl}'
                        for s, x, n, c in flat if s == section)
        m = re.search(r"^\[" + re.escape(section) + r"\][^\n]*\n", out, re.M)
        if m is None:
            sys.exit(f"refused: no [{section}] section in the registry")
        nxt = re.search(r"^\[", out[m.end():], re.M)
        end = m.end() + (nxt.start() if nxt else len(out) - m.end())
        body = out[m.end():end].rstrip("\r\n") + nl
        out = out[:m.end()] + body + lines + nl + out[end:]
    tomllib.loads(out)                               # still valid TOML
    if a.dry_run:
        print(f"dry run: {len(flat)} entries in {len(set(s for s, *_ in flat))} sections")
        return 0

    before = snapshot()
    TOML.write_bytes(out.encode("utf-8"))
    errs = na1_regen.regen()
    after = snapshot()
    new = {n: x for _, x, n, _ in flat}
    bad = [p for p in sorted(set(before) | set(after))
           if normalize(p, before.get(p, ""), new) != normalize(p, after.get(p, ""), new)]
    if errs or bad:
        TOML.write_bytes(reg_bytes)
        na1_regen.regen()
        for p in bad[:10]:
            b = normalize(p, before.get(p, ""), new).splitlines()
            f = normalize(p, after.get(p, ""), new).splitlines()
            i = next((k for k in range(min(len(b), len(f))) if b[k] != f[k]), min(len(b), len(f)))
            print(f"  {p}:{i + 1}\n    before: {b[i] if i < len(b) else '<eof>'}\n    after:  {f[i] if i < len(f) else '<eof>'}")
        sys.exit(f"GUARD FAILED ({len(bad)} files, regen errors {len(errs)}); registry restored")
    changed = sum(before.get(p) != after.get(p) for p in after)
    print(f"applied {len(flat)} labels; {changed} files changed, every change a pure name substitution")
    return 0


if __name__ == "__main__":
    sys.exit(main())
