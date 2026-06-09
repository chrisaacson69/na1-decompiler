#!/usr/bin/env python3
"""dream.py -- PARALLEL control-flow structuring back-end (DREAM approach).

A pattern-INDEPENDENT structurer: instead of matching CFG shapes against a schema
catalog (vm_reduce's region reducer), it computes a REACHING CONDITION (a boolean
formula over branch predicates) for each node and refines those formulas into
if/else/switch/loops. Goto-free by construction (Bohm-Jacopini). Compiler-
independent, so it needs no NA1-compiler reference.

  Yakdan, Eschweiler, Gerhards-Padilla, Smith. "No More Gotos." NDSS 2015.

This is a FORK, parallel to vm_reduce.py -- not a replacement yet. PoC stage:
foundation (boolean layer + tagged CFG + reaching conditions) verified before
the refinement/emit is built on top.

Front-end (bytecode->CFG, per-block C, branch predicates) is INHERITED from
vm_cfg.py + vm_decompile.py + vm_reduce._parse_block. We replace only structuring.

Usage (PoC dump):
  py -3 tools/dream.py <bank> <sub_addr_hex>      # e.g. tools/dream.py 15 CDCF
"""
import re
import sys
import vm_cfg

# --------------------------------------------------------------------------- #
# Boolean layer. Expressions are immutable tuples in a canonical-ish form:
#   ('T',) | ('F',) | ('lit', base_str, pol) | ('and', frozenset) | ('or', frozenset)
# A literal's base_str is the predicate text with any outer `!(...)` stripped;
# pol=True means asserted, False means negated. So a predicate and its negation
# share base_str and differ only in pol -> complementation is detectable.
# --------------------------------------------------------------------------- #
TRUE = ('T',)
FALSE = ('F',)


def lit(cond_text):
    """A literal from raw condition text, normalizing a leading `!(...)` to polarity."""
    s = cond_text.strip()
    pol = True
    m = re.match(r'^!\((.*)\)$', s)
    if m:
        s, pol = m.group(1).strip(), False
    return ('lit', s, pol)


def neg(e):
    k = e[0]
    if k == 'T':
        return FALSE
    if k == 'F':
        return TRUE
    if k == 'lit':
        return ('lit', e[1], not e[2])
    if k == 'and':                       # De Morgan
        return _or(*[neg(x) for x in e[1]])
    if k == 'or':
        return _and(*[neg(x) for x in e[1]])
    raise ValueError(e)


def _flatten(kind, args):
    out = []
    for a in args:
        if a[0] == kind:
            out.extend(a[1])
        else:
            out.append(a)
    return out


def _and(*args):
    terms = _flatten('and', args)
    s = set()
    for t in terms:
        if t == FALSE:
            return FALSE
        if t == TRUE:
            continue
        if neg(t) in s:                  # complementation x & !x = F
            return FALSE
        s.add(t)
    # absorption: x & (x | y) = x
    s = {t for t in s if not any(o != t and o[0] == 'or' and t in o[1] for o in s)}
    if not s:
        return TRUE
    if len(s) == 1:
        return next(iter(s))
    return ('and', frozenset(s))


def _or(*args):
    terms = _flatten('or', args)
    s = set()
    for t in terms:
        if t == TRUE:
            return TRUE
        if t == FALSE:
            continue
        if neg(t) in s:                  # x | !x = T
            return TRUE
        s.add(t)
    s = {t for t in s if not any(o != t and o[0] == 'and' and t in o[1] for o in s)}
    s = _consensus(s)
    if not s:
        return FALSE
    if len(s) == 1:
        return next(iter(s))
    return ('or', frozenset(s))


def _terms(e):
    """The conjunct set of `e` as an AND (a bare literal/expr is a 1-element conjunction)."""
    return set(e[1]) if e[0] == 'and' else {e}


def _consensus(s):
    """Reduce a disjunction term-set toward a normal form, to fixpoint:
      (X∧a) ∨ (X∧¬a)  ->  X        [consensus: the two and-terms differ in one polarity]
      a     ∨ (¬a∧X)  ->  a ∨ X    [a absorbs the ¬a in the other term]
    Without this, reaching conditions of merge blocks (reached from both arms of a branch)
    stay as bloated ORs like `(!c1&&!c2)||(!c1&&c2)` instead of collapsing to `!c1`."""
    s = set(s)
    changed = True
    while changed:
        changed = False
        items = list(s)
        for i in range(len(items)):
            for j in range(i + 1, len(items)):
                a, b = items[i], items[j]
                ta, tb = _terms(a), _terms(b)
                # consensus: identical but for one complementary literal
                diff = ta ^ tb
                if len(diff) == 2:
                    d = list(diff)
                    if d[0] == neg(d[1]) and (ta & tb):
                        merged = _and(*(ta & tb))
                        s.discard(a)
                        s.discard(b)
                        s.add(merged)
                        changed = True
                        break
                # absorption of a complementary literal: a ∨ (¬a ∧ X) -> a ∨ X
                for lit_t, other in ((a, b), (b, a)):
                    if lit_t[0] == 'lit' and other[0] == 'and' and neg(lit_t) in other[1]:
                        reduced = _and(*(set(other[1]) - {neg(lit_t)}))
                        s.discard(other)
                        s.add(reduced)
                        changed = True
                        break
                if changed:
                    break
            if changed:
                break
    return s


def to_c(e):
    """Render a boolean expression as C (for inspection / emit)."""
    k = e[0]
    if k == 'T':
        return '1'
    if k == 'F':
        return '0'
    if k == 'lit':
        return e[1] if e[2] else '!(%s)' % e[1]
    inner = sorted(to_c(x) for x in e[1])
    op = ' && ' if k == 'and' else ' || '
    return '(' + op.join(inner) + ')'


# --------------------------------------------------------------------------- #
# Tagged CFG: reuse vm_cfg + vm_reduce._parse_block to recover, per block, its
# statements and its branch predicate, then tag each edge with the condition
# under which it is taken.
# --------------------------------------------------------------------------- #
def tagged_cfg(lines, instructions):
    import vm_reduce
    cfg, leaders = vm_cfg.bytecode_cfg(instructions)
    block_of = vm_cfg._block_of_fn(leaders)
    buckets = vm_reduce._partition(lines, leaders)
    info = {L: vm_reduce._parse_block(buckets[L]) for L in leaders}
    tag = {}                              # (u, v) -> boolean expr
    kind = {}                             # leader -> '1way' | '2way' | 'switch' | 'exit'
    for L in leaders:
        stmts, rawcond, branch_addr, goto_target, is_switch = info[L]
        succ = [s for s in cfg[L]]
        if is_switch:
            kind[L] = 'switch'
            for s in succ:
                tag[(L, s)] = TRUE        # PoC: switch predicates handled later
        elif rawcond is not None and len(succ) == 2:
            t_succ = block_of(goto_target)
            f_succ = succ[0] if succ[1] == t_succ else succ[1]
            if t_succ == f_succ:          # degenerate goto-to-fallthrough
                kind[L] = '1way'
                tag[(L, t_succ)] = TRUE
            else:
                kind[L] = '2way'
                c = lit(rawcond)
                tag[(L, t_succ)] = c
                tag[(L, f_succ)] = neg(c)
        else:
            kind[L] = 'exit' if (not succ or succ == [vm_cfg.EXIT]) else '1way'
            for s in succ:
                tag[(L, s)] = TRUE
    return dict(cfg=cfg, leaders=leaders, block_of=block_of, info=info,
                buckets=buckets, tag=tag, kind=kind)


def _reverse_postorder(cfg, header):
    """Reverse postorder from header = a valid topological order for an acyclic
    graph (paper §IV-B). DFS, record finish order, reverse. EXIT excluded."""
    seen, post = set(), []

    def dfs(n):
        seen.add(n)
        for s in cfg.get(n, ()):
            if s != vm_cfg.EXIT and s not in seen:
                dfs(s)
        post.append(n)

    dfs(header)
    return list(reversed(post))


def reaching_conditions(tc, header):
    """cr(header, n) for every node in the ACYCLIC graph reachable from header.
    cr(h,n) = OR over preds v of cr(h,v) & tag(v,n), in reverse-postorder so every
    predecessor is computed first. (Loops handled separately later.)"""
    cfg, tag = tc['cfg'], tc['tag']
    preds = {}
    for u in cfg:
        for v in cfg[u]:
            preds.setdefault(v, []).append(u)
    cr = {header: TRUE}
    for n in _reverse_postorder(cfg, header):
        if n == header:
            continue
        acc = FALSE
        for v in preds.get(n, []):
            if v in cr:
                acc = _or(acc, _and(cr[v], tag.get((v, n), TRUE)))
        cr[n] = acc
    return cr


# --------------------------------------------------------------------------- #
# RUNG 1 (SPIKE A) — condition-based refinement -> nested if/else, ADDRESS-CONSTRAINED.
# The gate (vm_cfg.lower_struct_cfg) is address-anchored: an if's then-arm must be the
# address-NEXT block. So we emit the fall-through side as `then`, the goto side as `else`,
# in ascending address order, choosing the pivot = the lowest-address 2-way branch whose
# predicate factors the reaching conditions. Merges (a node reached from BOTH arms -> its
# cr is an OR, unfactorable by the pivot) drop to `rest` and emit AFTER the if/else, i.e.
# the continuation. Eligible = acyclic + no switch (loops/switch are later rungs); anything
# else passes through unchanged. The CFG-equivalence gate is the backstop.
# --------------------------------------------------------------------------- #
def _has_backedge(cfg, header):
    """DFS gray-node test: True iff a back edge is reachable from header (loop present)."""
    color = {header: 1}
    stack = [(header, iter(cfg.get(header, ())))]
    while stack:
        node, it = stack[-1]
        try:
            s = next(it)
        except StopIteration:
            color[node] = 2
            stack.pop()
            continue
        if s == vm_cfg.EXIT:
            continue
        c = color.get(s, 0)
        if c == 1:
            return True
        if c == 0:
            color[s] = 1
            stack.append((s, iter(cfg.get(s, ()))))
    return False


def eligible(tc, header):
    """Rung-1 scope: acyclic CFG, no switch dispatch."""
    if any(k == 'switch' for k in tc['kind'].values()):
        return False
    return not _has_backedge(tc['cfg'], header)


def _lit_of(tc, L):
    """The goto-condition literal of a 2-way block (None otherwise)."""
    if tc['kind'].get(L) != '2way':
        return None
    rawcond = tc['info'][L][1]
    return lit(rawcond) if rawcond is not None else None


def _factor(cond, piv):
    """Divide `piv` (a positive literal) out of `cond` if it's a top-level conjunct.
    Returns ('pos', residual) if piv⊆cond, ('neg', residual) if !piv⊆cond, else None."""
    n = neg(piv)
    if cond == piv:
        return ('pos', TRUE)
    if cond == n:
        return ('neg', TRUE)
    if cond[0] == 'and':
        s = cond[1]
        if piv in s:
            return ('pos', _and(*(s - {piv})))
        if n in s:
            return ('neg', _and(*(s - {n})))
    return None


def refine(tc, items):
    """items = ordered [(cond, leader)]. Recursively factor by the lowest-address branch
    predicate into nested if/else. Returns an emit AST (list of nodes)."""
    items = [(c, L) for c, L in items if c != FALSE]
    if not items:
        return []
    piv = Lpiv = None
    for _c, L in sorted(items, key=lambda x: x[1]):
        lt = _lit_of(tc, L)
        if lt is None:
            continue
        p = ('lit', lt[1], True)                      # normalize to positive polarity
        rest = [x for x in items if x[1] != L]
        if any(_factor(cc, p) for cc, _ in rest):
            piv, Lpiv = p, L
            break
    if piv is None:                                   # no factorable branch: guard the residue
        out = []
        for c, L in sorted(items, key=lambda x: x[1]):
            payload = ('block', L, tc['info'][L][0])
            out.append(payload if c == TRUE else ('guard', c, payload))
        return out
    cpiv = dict((L, c) for c, L in items)[Lpiv]
    head = ('block', Lpiv, tc['info'][Lpiv][0])
    head_emit = head if cpiv == TRUE else ('guard', cpiv, head)
    fall_i, goto_i, rest_i = [], [], []               # fall side (!piv) / goto side (piv) / merge
    for c, L in items:
        if L == Lpiv:
            continue
        f = _factor(c, piv)
        if f is None:
            rest_i.append((c, L))
        elif f[0] == 'pos':                           # piv(goto-cond) TRUE -> goto arm
            goto_i.append((f[1], L))
        else:                                         # !piv -> fall arm
            fall_i.append((f[1], L))
    goto_target = tc['info'][Lpiv][3]
    t_succ = tc['block_of'](goto_target) if goto_target is not None else None
    f_succ = next((s for s in tc['cfg'][Lpiv] if s != vm_cfg.EXIT and s != t_succ), vm_cfg.EXIT)
    node = ('if', Lpiv, piv, f_succ, t_succ, refine(tc, fall_i), refine(tc, goto_i))
    return [head_emit, node] + refine(tc, rest_i)


def _emits(seq, nxt):
    """Does this AST seq produce any emitted line? (post-emit emptiness, not list-empty —
    a seq can hold a both-empty nested `if` that yields nothing.)"""
    probe = []
    _emit_ast(seq, 0, probe, nxt)
    return bool(probe)


def _emit_ast(ast, indent, out, nxt):
    for node in ast:
        k = node[0]
        if k == 'block':
            for a, t in node[2]:
                out.append((a, indent, t))
        elif k == 'guard':
            _, cond, payload = node
            baddr = payload[1] if payload[0] == 'block' else 0
            out.append((baddr, indent, f"if ({to_c(cond)}) {{"))
            _emit_ast([payload], indent + 1, out, nxt)
            out.append((0, indent, "}"))
        else:  # 'if'
            _, Lpiv, piv, f_succ, t_succ, fall_seq, goto_seq = node
            fall_has, goto_has = _emits(fall_seq, nxt), _emits(goto_seq, nxt)
            if not fall_has and not goto_has:
                continue                              # empty diamond — nothing to guard
            if not fall_has:
                # empty fall arm (a guard idiom `if(c) goto body; merge`) -> FLIP so the
                # goto-side body is the then-arm: reads better and the body block is the
                # address-next leader the gate expects, where empty-then mis-routed.
                out.append((Lpiv, indent, f"if ({to_c(piv)}) {{"))
                _emit_ast(goto_seq, indent + 1, out, nxt)
                out.append((0, indent, "}"))
            else:
                out.append((Lpiv, indent, f"if ({to_c(neg(piv))}) {{"))   # then = fall side
                _emit_ast(fall_seq, indent + 1, out, nxt)
                if goto_has:
                    out.append((0, indent, "} else {"))
                    _emit_ast(goto_seq, indent + 1, out, nxt)
                out.append((0, indent, "}"))


def dream_structure(lines, instructions):
    """Top-level rung-1 structurer (Spike A). Returns address-constrained structured lines,
    or the input unchanged when out of scope (loop/switch)."""
    tc = tagged_cfg(lines, instructions)
    leaders = tc['leaders']
    if not leaders:
        return list(lines)
    header = leaders[0]
    if not eligible(tc, header):
        return list(lines)
    cr = reaching_conditions(tc, header)
    items = [(cr[L], L) for L in leaders if L != vm_cfg.EXIT and L in cr]
    real = [L for L in leaders if L != vm_cfg.EXIT]   # next_leader by address (gate's then-arm rule)
    nxt = {real[i]: (real[i + 1] if i + 1 < len(real) else vm_cfg.EXIT) for i in range(len(real))}
    out = []
    _emit_ast(refine(tc, items), 0, out, nxt)
    return out


# --------------------------------------------------------------------------- #
# PoC harness: capture one sub's (lines, instructions) via the structure_v2 hook
# and dump its tagged CFG + reaching conditions.
# --------------------------------------------------------------------------- #
def _capture_sub(bank, sub_addr_hex):
    import importlib.util
    import pathlib
    import tempfile
    here = pathlib.Path(__file__).parent
    spec = importlib.util.spec_from_file_location("decompile_all", here / "decompile-all.py")
    da = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(da)
    import vm_decompile
    target = int(sub_addr_hex, 16)
    grab = {}

    def cap(lines, instructions):
        a0 = instructions[0]['addr'] if instructions else None
        grab[a0] = (list(lines), instructions)
        return list(lines)

    vm_decompile.structure_v2 = cap
    vm_decompile.STRUCTURE = True
    vm_decompile.STRUCTURE_V2 = True
    with tempfile.TemporaryDirectory() as td:
        da.bank_subs(bank, pathlib.Path(td))
    # match by body addr (== target) or nearest header whose body we grabbed
    if target in grab:
        return grab[target]
    for a0, pair in grab.items():
        if a0 is not None and abs(a0 - target) <= 8:
            return pair
    raise SystemExit(f"sub @ {sub_addr_hex} not captured (got {len(grab)} subs)")


def _dump(bank, sub_addr_hex):
    lines, instructions = _capture_sub(bank, sub_addr_hex)
    tc = tagged_cfg(lines, instructions)
    print(f"=== sub bank {bank} @ ${sub_addr_hex} : {len(tc['leaders'])} blocks ===")
    for L in tc['leaders']:
        if L == vm_cfg.EXIT:
            continue
        stmts = tc['info'][L][0]
        body = '; '.join(t for _a, t in stmts)[:70]
        succ = tc['cfg'][L]
        edges = '  '.join(f"->{s if s==vm_cfg.EXIT else '$%X'%s}[{to_c(tc['tag'].get((L,s),TRUE))}]"
                          for s in succ)
        print(f"  ${L:X} ({tc['kind'][L]:6}) {body}")
        print(f"          {edges}")
    print("--- reaching conditions from header ---")
    cr = reaching_conditions(tc, tc['leaders'][0])
    for L in tc['leaders']:
        if L != vm_cfg.EXIT and L in cr:
            print(f"  ${L:X}: {to_c(cr[L])}")


def _capture_all(bank):
    """Capture (raw_lines, instructions) for EVERY sub in a bank via the structure_v2 hook."""
    import importlib.util
    import pathlib
    import tempfile
    here = pathlib.Path(__file__).parent
    spec = importlib.util.spec_from_file_location("decompile_all", here / "decompile-all.py")
    da = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(da)
    import vm_decompile
    grab = {}

    def cap(lines, instructions):
        a0 = instructions[0]['addr'] if instructions else None
        grab[a0] = (list(lines), instructions)
        return list(lines)

    vm_decompile.structure_v2 = cap
    vm_decompile.STRUCTURE = True
    vm_decompile.STRUCTURE_V2 = True
    with tempfile.TemporaryDirectory() as td:
        da.bank_subs(bank, pathlib.Path(td))
    return grab


def _gotos(lines):
    return sum(1 for _a, _i, t in lines if 'goto ' in t)


def _check(bank, verbose=False):
    """Spike-A measurement: run dream_structure over every sub in `bank`, gate each vs its
    raw witness, and tally folded / gate-rejected / passthrough + goto deltas."""
    import vm_cfg
    grab = _capture_all(bank)
    elig = folded = rejected = passthrough = 0
    g_raw_e = g_dream_e = 0                            # goto totals over ELIGIBLE-and-validated
    rej_list, win_list = [], []
    for a0, (raw, instrs) in sorted(grab.items(), key=lambda x: (x[0] is None, x[0])):
        if not instrs:
            continue
        tc = tagged_cfg(raw, instrs)
        leaders = tc['leaders']
        if not leaders or not eligible(tc, leaders[0]):
            passthrough += 1
            continue
        elig += 1
        dream = dream_structure(raw, instrs)
        try:
            ok = vm_cfg.structured_equivalent(raw, dream, leaders)[0]
        except Exception:
            ok = False                                # malformed emit the gate can't lower = reject
        if ok:
            folded += 1
            gr, gd = _gotos(raw), _gotos(dream)
            g_raw_e += gr
            g_dream_e += gd
            if gd < gr:
                win_list.append((a0, gr, gd))
        else:
            rejected += 1
            rej_list.append(a0)
    print(f"=== DREAM rung-1 spike A — bank {bank} ===")
    print(f"  subs total       : {sum(1 for _a,(r,i) in grab.items() if i)}")
    print(f"  passthrough      : {passthrough}  (loop/switch — out of rung-1 scope)")
    print(f"  eligible (acyclic, no switch): {elig}")
    print(f"    validated (gate-green): {folded}")
    print(f"    gate-rejected         : {rejected}")
    if folded:
        print(f"  gotos over validated  : raw {g_raw_e} -> dream {g_dream_e}  (delta {g_dream_e-g_raw_e})")
        print(f"  subs strictly improved: {len(win_list)}")
    if verbose and rej_list:
        print("  rejected: " + ' '.join('$%X' % a for a in rej_list[:40]))
    return folded, rejected, elig


def _emit_one(bank, sub_addr_hex):
    """Dump the structured C dream_structure produces for one sub + the gate verdict."""
    import vm_cfg
    lines, instrs = _capture_sub(bank, sub_addr_hex)
    tc = tagged_cfg(lines, instrs)
    leaders = tc['leaders']
    if not eligible(tc, leaders[0]):
        print(f"sub ${sub_addr_hex}: OUT OF SCOPE (loop or switch) — passthrough")
        return
    dream = dream_structure(lines, instrs)
    ok, nr, ns = vm_cfg.structured_equivalent(lines, dream, leaders)
    print(f"=== DREAM structured C — bank {bank} @ ${sub_addr_hex}  [gate: {'PASS' if ok else 'REJECT'}] ===")
    for a, ind, t in dream:
        print(f"  {('$%04X'%a) if a else '     '}  {'  '*ind}{t}")
    print(f"  gotos: raw {_gotos(lines)} -> dream {_gotos(dream)}")


if __name__ == "__main__":
    if len(sys.argv) >= 2 and sys.argv[1] == "--check":
        _check(int(sys.argv[2]), verbose="-v" in sys.argv)
    elif len(sys.argv) >= 2 and sys.argv[1] == "--emit":
        _emit_one(int(sys.argv[2]), sys.argv[3])
    elif len(sys.argv) == 3:
        _dump(int(sys.argv[1]), sys.argv[2])
    else:
        sys.exit("usage: dream.py <bank> <addr> | --emit <bank> <addr> | --check <bank> [-v]")
