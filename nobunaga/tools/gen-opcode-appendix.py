#!/usr/bin/env python3
"""Generate nobunaga/appendix-vm-opcodes.md — the canonical VM opcode reference.

Fuses two authoritative sources (run from tools/):
  - na1dream.nobunaga_vm.OPCODE_INFO  -> per-opcode (mnemonic, operand byte length),
    execution-validated (this is the source that CORRECTED the early wrong lengths).
  - na1dream/vm-opcodes-v2.toml        -> per-group pops/pushes/verified/description.

Output groups consecutive identical opcodes into ranges. Regenerate after editing
either source; do NOT hand-edit the appendix.
"""
import re, sys
from pathlib import Path

PKG = Path(__file__).resolve().parent / "na1dream"
sys.path.insert(0, str(Path(__file__).resolve().parent))
from na1dream import nobunaga_vm  # noqa: E402

INFO = nobunaga_vm.OPCODE_INFO
if not INFO:                       # ensure the table is built
    nobunaga_vm._init_opcode_info()
    INFO = nobunaga_vm.OPCODE_INFO

# ---- parse the toml (3.9, no tomllib): section -> fields, keyed by start opcode ----
def parse_toml(path):
    sections = {}            # start_op -> {pops, pushes, verified, description}
    cur = None
    for line in path.read_text(encoding="utf-8").splitlines():
        m = re.match(r"\[op_([0-9A-Fa-f]{2})\]", line.strip())
        if m:
            cur = int(m.group(1), 16)
            sections[cur] = {}
            continue
        if cur is None:
            continue
        m = re.match(r"\s*([a-z_]+)\s*=\s*(.+?)\s*$", line)
        if not m:
            continue
        k, v = m.group(1), m.group(2)
        if v.startswith('"') and v.endswith('"'):
            v = v[1:-1]
        elif v in ("true", "false"):
            v = (v == "true")
        else:
            try: v = int(v)
            except ValueError: pass
        sections[cur][k] = v
    return sections

SEC = parse_toml(PKG / "vm-opcodes-v2.toml")
# Match a toml section to an opcode by MNEMONIC (not address range), so undefined
# opcodes in the gaps ($91-$9F, $EB-$FF) don't inherit a neighbour's fields.
SEC_BY_MNEMONIC = {f.get("mnemonic"): f for f in SEC.values() if f.get("mnemonic")}

def fields_for(op):
    return SEC_BY_MNEMONIC.get(INFO.get(op, ("", 0))[0], {})

def operand_str(op, oplen):
    if op < 0x80:
        return "nibble"           # $00-$7F: operand is the low 4 bits of the opcode
    if oplen == -1:
        return "variable"
    if oplen == 0:
        return "—"
    if oplen == 6:
        return "6 (+table)"       # SWITCH_contig: offs/num/default header, then jump table
    return f"{oplen} byte" + ("s" if oplen != 1 else "")

# ---- build per-opcode rows, then collapse consecutive identical rows into ranges ----
rows = []
for op in range(0x100):
    mn, oplen = INFO.get(op, ("(undefined)", 0))
    f = fields_for(op)
    rows.append({
        "op": op, "mn": mn, "operand": operand_str(op, oplen),
        "pops": f.get("pops"), "pushes": f.get("pushes"),
        "verified": f.get("verified", False), "desc": f.get("description", ""),
    })

def stack(r):
    if r["pops"] is None and r["pushes"] is None: return "—"
    return f"{r['pops'] or 0}→{r['pushes'] or 0}"

def key(r):  # rows merge into a range iff everything but the opcode matches
    return (r["mn"], r["operand"], stack(r), r["verified"], r["desc"])

groups = []
for r in rows:
    if groups and key(groups[-1][-1]) == key(r) and groups[-1][-1]["op"] == r["op"] - 1:
        groups[-1].append(r)
    else:
        groups.append([r])

# ---- emit markdown, sectioned by opcode family ----
FAMILIES = [
    (0x00, 0x7F, "Quick group ($00-$7F) — operand in the low nibble"),
    (0x80, 0x9F, "Near / far / immediate frame & stack ops"),
    (0xA0, 0xAF, "Absolute loads/stores, call, copy, unstack"),
    (0xB0, 0xBF, "Deref / arithmetic (the LONG $B7 prefix selects 32-bit ext-ops)"),
    (0xC0, 0xCF, "Comparisons, unary ops, RETURN"),
    (0xD0, 0xDF, "Inc/dec/shift, switch, jumps, bitwise, call-ptr"),
    (0xE0, 0xFF, "Bitfields, relative jumps, calls (the host-call path)"),
]
def fam_title(op):
    for lo, hi, t in FAMILIES:
        if lo <= op <= hi: return (lo, t)
    return (op, "")

out = []
out.append("---\nstatus: active\n---")
out.append("# Appendix — The VM Opcode Reference (canonical)\n")
out.append("> The authoritative 256-entry opcode table for the Sea-16 VM. "
           "**Generated** by `tools/gen-opcode-appendix.py` from `tools/na1dream/vm-opcodes-v2.toml` "
           "(pops/pushes/semantics) fused with `nobunaga_vm.OPCODE_INFO` (execution-validated mnemonic + "
           "operand byte-length). Do not hand-edit — edit a source and regenerate. Cited by "
           "[ch.6 (VM Disassembler)](./06-vm-disassembler.md) and [ch.8 (VM Instruction Set)](./08-vm-instruction-set.md).\n")
out.append("**Legend.** *Operand* = inline bytes consumed after the opcode (`nibble` = the value is the "
           "opcode's low 4 bits, $00-$7F). *Stack* = `pops→pushes` on the descending word stack at `vm_sp`. "
           "*V* = ✓ when verified against the ROM/emulator. Registers: `regL`=$08, `regR`=$0C, frame base "
           "`vm_fp`=$04. Only **$80** and **$CE** are ILLEGAL; opcodes the table leaves undefined are "
           "trapped (never emitted by the compiler).\n")

last_fam = None
for grp in groups:
    op0 = grp[0]["op"]
    fam_lo, title = fam_title(op0)
    if fam_lo != last_fam:
        out.append(f"\n## {title}\n")
        out.append("| Opcode | Mnemonic | Operand | Stack | V | Description |")
        out.append("|---|---|---|---|:-:|---|")
        last_fam = fam_lo
    r = grp[0]
    if len(grp) > 1:
        opcell = f"`${grp[0]['op']:02X}-${grp[-1]['op']:02X}`"
    else:
        opcell = f"`${r['op']:02X}`"
    v = "✓" if r["verified"] else "·"
    desc = r["desc"] or "—"
    out.append(f"| {opcell} | `{r['mn']}` | {r['operand']} | {stack(r)} | {v} | {desc} |")

n_verified = sum(1 for r in rows if r["verified"])
out.append(f"\n---\n*256 opcodes · {n_verified} verified against the ROM · "
           "2 illegal ($80, $CE). Regenerate with `py -3 tools/gen-opcode-appendix.py`.*")

DEST = Path(__file__).resolve().parent.parent / "appendix-vm-opcodes.md"
DEST.write_text("\n".join(out) + "\n", encoding="utf-8")
print(f"wrote {DEST}  ({len(groups)} rows over 256 opcodes, {n_verified} verified)")
