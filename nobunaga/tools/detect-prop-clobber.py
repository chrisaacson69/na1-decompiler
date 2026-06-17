#!/usr/bin/env python3
"""
detect-prop-clobber.py  --  find the DREAM "copy-propagated past a clobber" hazard.

The bytecode idiom (one value computed, stored to >1 location, source reused):

    LOADL_quick 11      ; L = turn_idx
    INC                 ; L = turn_idx + 1
    STORE_quick 11      ; turn_idx = L            <-- clobbers the source slot 11
    STORE_abs  $6001    ; loop_index = L          <-- SAME value, but DREAM may
                        ;                              re-render it as (turn_idx + 1)

Stage 1 (bytecode): within a single L-lifetime (from one L-def to the next),
collect every STORE destination. If a later store's value still *reads* a
location that an earlier store in the same lifetime already wrote, that later
store is a propagation HAZARD.

Stage 2 (C confirmation): map both stores to their emitted C statements via the
`// $ADDR` comments. If the later store's C RHS textually contains the earlier
store's C LHS name, DREAM rendered it STALE  ->  CONFIRMED misrepresentation.
"""
import re, glob, os, sys

ASM_DIR = os.path.join(os.path.dirname(__file__), "..", "source", "2-asm-vm")
C_DIR   = os.path.join(os.path.dirname(__file__), "..", "source", "4-c")

# --- opcode classification by mnemonic -------------------------------------
STORE_OPS = {"STORE_abs", "STORE_quick", "BYTE_STORE_abs", "BYTE_STORE_quick"}

def is_l_def(m):
    """Op that redefines L (ends the current L-lifetime, starts a new one)."""
    if m.startswith(("LOADL_", "BYTE_LOADL_", "LEAL_", "CALL", "SCMP", "UCMP")):
        return True
    return m in {"INC","DEC","ADD","SUB","MULT","AND","OR","XOR","LSHIFT","LSHIFT1",
                 "SDIV","UDIV","UMOD","CMPEQ","CMPNE","DEREF","BYTE_DEREF","SWAP",
                 "CALLPTR","ADD_","BYTE_ADD_"}
def is_l_keep(m):       # redefines L but keeps the same read-set (unary on L)
    return m in {"INC","DEC","LSHIFT","LSHIFT1"}
def is_l_binary(m):     # L = L op R  -> read-set gains R's reads
    return m in {"ADD","SUB","MULT","AND","OR","XOR","SDIV","UDIV","UMOD","ADD_","BYTE_ADD_",
                 "CMPEQ","CMPNE"} or m.startswith(("SCMP","UCMP"))
def is_loadr(m):
    return m.startswith(("LOADR_","BYTE_LOADR_"))
def is_branch(m):
    return m.startswith("JUMP") or m == "RETURN"

LINE = re.compile(r'^\s*(>?)\s*\$([0-9A-Fa-f]{4})\s+(.*)$')

def parse_line(line):
    m = LINE.match(line)
    if not m: return None
    is_target = m.group(1) == ">"
    addr = int(m.group(2), 16)
    rest = m.group(3)
    toks = rest.split()
    i = 0
    while i < len(toks) and re.fullmatch(r'[0-9A-Fa-f]{2}', toks[i]):
        i += 1
    if i >= len(toks): return None
    mnem = toks[i]
    tail = rest.split(mnem, 1)[1] if mnem in rest else ""
    # operand
    om = re.search(r'inline operand = (-?\d+)', tail)
    slot = int(om.group(1)) if om else None
    am = re.search(r'\$([0-9A-Fa-f]{4})', tail)
    absaddr = int(am.group(1), 16) if am else None
    return dict(addr=addr, target=is_target, mnem=mnem, slot=slot, abs=absaddr)

def reads_of_load(ins):
    """Read-set produced by an L- or R-defining load."""
    m = ins["mnem"]
    if m.endswith("_quick"):                       # slot load
        return {("slot", ins["slot"])}
    if m.endswith(("_qimm","_imm1","_imm2")) or m.startswith("LEAL_"):
        return set()                               # constant / address-immediate
    if m.endswith("_abs"):                          # memory load
        return {("abs", ins["abs"])}
    return set()

def store_dest(ins):
    if ins["mnem"].endswith("_quick"): return ("slot", ins["slot"])
    if ins["mnem"].endswith("_abs"):   return ("abs",  ins["abs"])
    return None

def scan_bank(path):
    hazards = []   # (sub_addr, s1_addr, dest, s2_addr)
    sub = None
    L_reads, R_reads = set(), set()
    run = []       # [(dest, addr)] stores in current L-lifetime
    for raw in open(path, encoding="utf-8", errors="replace"):
        sm = re.match(r'^;\s*sub \$([0-9A-Fa-f]{4})', raw)
        if sm:
            sub = int(sm.group(1), 16); L_reads=set(); R_reads=set(); run=[]
            continue
        ins = parse_line(raw)
        if not ins: continue
        if ins["target"]:                          # merge point: provenance unknown
            L_reads=set(); R_reads=set(); run=[]
        m = ins["mnem"]
        if m in STORE_OPS:
            d = store_dest(ins)
            for (pd, pa) in run:                    # earlier store in this lifetime...
                if pd in L_reads:                  # ...wrote a location L still reads
                    hazards.append((sub, pa, pd, ins["addr"])); break
            run.append((d, ins["addr"]))
            continue                               # L unchanged -> lifetime continues
        if is_branch(m):
            L_reads=set(); R_reads=set(); run=[]; continue
        if is_loadr(m):
            R_reads = reads_of_load(ins); continue # R changes, L-lifetime unaffected
        if m == "POPR":
            R_reads = set(); continue
        if m == "SWAP":
            L_reads, R_reads = R_reads, L_reads; run=[]; continue
        if is_l_def(m):
            if is_l_keep(m):
                pass                               # INC/DEC: keep read-set
            elif is_l_binary(m):
                L_reads = L_reads | R_reads
            elif m.startswith(("DEREF","BYTE_DEREF")):
                L_reads = {("deref",)}
            elif m.startswith(("CALL",)) or m == "CALLPTR":
                L_reads = set()
            else:                                   # a load
                L_reads = reads_of_load(ins)
            run = []                               # new L value -> new lifetime
            continue
        # everything else (PUSHL, PUSH_*, POPSTORE, COPY...) leaves L untouched
        if m in ("POPSTORE","BYTE_POPSTORE"):
            run = []                               # different store kind; break run
    return hazards

# --- C-side confirmation ----------------------------------------------------
ASSIGN = re.compile(r'^\s*([A-Za-z_]\w*(?:\[[^\]]*\])?)\s(?<![=!<>])=(?!=)\s(.+?);\s*//\s*\$([0-9A-Fa-f]+)')

def load_c(bank):
    """addr(int) -> (lhs, rhs, lineno) for assignment statements in bank_XX.c"""
    path = os.path.join(C_DIR, f"bank_{bank}.c")
    out = {}
    if not os.path.exists(path): return out
    for n, line in enumerate(open(path, encoding="utf-8", errors="replace"), 1):
        m = ASSIGN.match(line)
        if m:
            out[int(m.group(3),16)] = (m.group(1), m.group(2), n)
    return out

def token_in(name, expr):
    return re.search(r'(?<![\w])' + re.escape(name) + r'(?![\w])', expr) is not None

def main():
    banks = [os.path.basename(p).split("_")[1] for p in sorted(glob.glob(os.path.join(ASM_DIR,"bank_*_vm.asm")))]
    grand_h = grand_conf = 0
    for bank in banks:
        asm = os.path.join(ASM_DIR, f"bank_{bank}_vm.asm")
        hazards = scan_bank(asm)
        cmap = load_c(bank)
        print(f"\n===== bank {bank}:  {len(hazards)} bytecode hazard site(s) =====")
        for (sub, s1, dest, s2) in hazards:
            c1 = cmap.get(s1); c2 = cmap.get(s2)
            verdict = "?"
            detail = ""
            if c1 and c2:
                lhs1 = c1[0]; rhs2 = c2[1]
                if token_in(lhs1, rhs2):
                    verdict = "CONFIRMED-STALE"; grand_conf += 1
                    detail = f'  C: `{c1[0]} = {c1[1]};`  THEN  `{c2[0]} = {rhs2};`  (reuses `{lhs1}`)'
                else:
                    verdict = "safe-render"
                    detail = f'  C: `{c1[0]} = {c1[1]};`  THEN  `{c2[0]} = {rhs2};`'
            elif not (c1 or c2):
                verdict = "no-C-line"
            else:
                verdict = "partial-C"
            print(f"  sub ${sub:04X}  store1 ${s1:04X} -> store2 ${s2:04X}  dest={dest}  [{verdict}]{detail}")
            grand_h += 1
    print(f"\n==================================================")
    print(f"TOTAL: {grand_h} hazard sites,  {grand_conf} CONFIRMED-STALE (actual DREAM misrepresentations)")

if __name__ == "__main__":
    main()
