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
        # PIVOT = the block's actual goto-cond literal, WITH its real polarity. Normalizing to
        # positive swaps the pos/neg factoring vs the edge tags when rawcond is `!(...)`, so the
        # goto-side nodes land in the fall arm (the emit flip compensated, but the AST gate's
        # orientation check — read from rawcond — exposed it). With the real literal, pos==goto.
        rest = [x for x in items if x[1] != L]
        if any(_factor(cc, lt) for cc, _ in rest):
            piv, Lpiv = lt, L
            break
    if piv is None:                                   # no factorable branch: guard the residue
        out = []
        for c, L in sorted(items, key=lambda x: x[1]):
            payload = ('block', L, tc['info'][L][0])
            out.append(payload if c == TRUE else ('guard', c, payload))
        return out
    # PRE-PIVOT TRUNK: every block at a LOWER address than the pivot is on the linear entry
    # chain before the first branch (Lpiv is the lowest-address branch, so nothing below it
    # branches → all are unconditional `cr==TRUE` trunk). Emit them in address order BEFORE the
    # if. (Previously they fell into `rest` and were emitted AFTER the branch — the address-based
    # gate masked the misplacement via addresses; the reorder-tolerant AST gate exposed it.)
    pre = sorted((x for x in items if x[1] < Lpiv), key=lambda x: x[1])
    pre_set = {L for _c, L in pre}
    pre_nodes = [('block', L, tc['info'][L][0]) for _c, L in pre]
    cpiv = dict((L, c) for c, L in items)[Lpiv]
    head = ('block', Lpiv, tc['info'][Lpiv][0])
    head_emit = head if cpiv == TRUE else ('guard', cpiv, head)
    fall_i, goto_i, rest_i = [], [], []               # fall side (!piv) / goto side (piv) / merge
    for c, L in items:
        if L == Lpiv or L in pre_set:
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
    return pre_nodes + [head_emit, node] + refine(tc, rest_i)


def _emits(seq, nxt):
    """Does this AST seq produce any emitted line? (post-emit emptiness, not list-empty —
    a seq can hold a both-empty nested `if` that yields nothing.)"""
    probe = []
    _emit_ast(seq, 0, probe, nxt)
    return bool(probe)


def _min_addr(seq, nxt):
    """Lowest real (addr>0) line a seq emits, or None. Used to keep the then-arm = the
    LOWER-address arm so emit stays address-ascending (what the address-anchored gate wants)."""
    probe = []
    _emit_ast(seq, 0, probe, nxt)
    addrs = [a for a, _i, _t in probe if a]
    return min(addrs) if addrs else None


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
            # The gate is address-anchored, so the then-arm should be the LOWER-address arm
            # (emit ascending). FLIP to the goto side as `then` when the fall arm is empty (a
            # guard idiom `if(c) goto body; merge`) OR the goto body simply sits at a lower
            # address than the fall body (arm-order inversion — `$8008`).
            fm, gm = _min_addr(fall_seq, nxt), _min_addr(goto_seq, nxt)
            flip = (not fall_has) or (goto_has and (fm is None or gm < fm))
            if flip:
                then_seq, else_seq, cond, else_has = goto_seq, fall_seq, piv, fall_has
            else:
                then_seq, else_seq, cond, else_has = fall_seq, goto_seq, neg(piv), goto_has
            out.append((Lpiv, indent, f"if ({to_c(cond)}) {{"))
            _emit_ast(then_seq, indent + 1, out, nxt)
            if else_has:
                out.append((0, indent, "} else {"))
                _emit_ast(else_seq, indent + 1, out, nxt)
            out.append((0, indent, "}"))


def dream_ast(lines, instructions):
    """Build the refinement AST (+ tc + the address next_leader map) for an eligible sub,
    or None when out of scope (loop/switch). Shared by the emitter and the AST-native gate."""
    tc = tagged_cfg(lines, instructions)
    leaders = tc['leaders']
    if not leaders or not eligible(tc, leaders[0]):
        return None
    cr = reaching_conditions(tc, leaders[0])
    items = [(cr[L], L) for L in leaders if L != vm_cfg.EXIT and L in cr]
    real = [L for L in leaders if L != vm_cfg.EXIT]
    nxt = {real[i]: (real[i + 1] if i + 1 < len(real) else vm_cfg.EXIT) for i in range(len(real))}
    return refine(tc, items), tc, nxt


def dream_structure(lines, instructions):
    """Top-level rung-1 structurer (Spike A). Returns address-constrained structured lines,
    or the input unchanged when out of scope (loop/switch)."""
    built = dream_ast(lines, instructions)
    if built is None:
        return list(lines)
    ast, _tc, nxt = built
    out = []
    _emit_ast(ast, 0, out, nxt)
    return out


def _ast_cfg(ast, tc):
    """Build the structured CFG DIRECTLY from the DREAM AST — identity = the real block each
    node owns, edges = the tree's nesting (an `if`'s two arms; a block's lexical continuation).
    This is the AST-native gate's core: because the tree KNOWS each block's identity, there is
    no text to parse and no address to honour, so flushed-call reordering and address-inverted
    merges are irrelevant by construction (the wall V2 hit, and the flush-fragility of the
    synth-renumber first cut, both vanish). Returns (edges, orient, entry), or None if the AST
    contains a node that can't be placed in a block-CFG."""
    EXIT = vm_cfg.EXIT
    edges, orient = {}, {}

    def build(seq, fall):
        cont = fall
        for node in reversed(seq):
            cont = build_node(node, cont)
        return cont

    def build_node(node, cont):
        k = node[0]
        if k == 'block':
            L = node[1]
            if L not in edges:                        # a branch head's `if` node already set it
                rs = tc['cfg'][L]
                edges[L] = frozenset({EXIT}) if EXIT in rs else frozenset({cont})
            return L
        if k == 'guard':
            # `if(cr){block}` where cr is a residual reaching condition. CFG-TRANSPARENT: the
            # real branching that reaches `block` is the upstream `if` nodes (their empty goto
            # arms route here via `cont`); the guard cond is emit-only and correct-by-
            # construction (it IS the reaching condition). So process the payload as a block.
            return build_node(node[2], cont)
        # 'if'
        _, Lpiv, piv, _f, _t, fall_seq, goto_seq = node
        entry_fall = build(fall_seq, cont)
        entry_goto = build(goto_seq, cont)
        edges[Lpiv] = frozenset({entry_fall, entry_goto})
        vm_cfg._record_orient(orient, Lpiv, tc['info'][Lpiv][1], entry_goto, entry_fall)
        return Lpiv

    entry = build(ast, EXIT)
    return edges, orient, entry


def dream_equivalent_ast(raw_lines, ast, tc, leaders):
    """AST-native reorder-tolerant gate: lower the DREAM AST to a CFG via `_ast_cfg` (identity
    from the tree, NOT from emitted text), then compare to the raw witness exactly as
    `structured_equivalent` does (contract + TRUE/FALSE orientation). No renumbering, no text
    re-parse → immune to flush + address inversion. Sound for the same reason as the synth
    version: DREAM carries each block verbatim, so CFG-match + orientation ⇒ behaviour-match."""
    EXIT = vm_cfg.EXIT
    real = [L for L in leaders if L != EXIT]
    if not real:
        return True
    built = _ast_cfg(ast, tc)
    if built is None:
        return False
    cfg_str, or_str, _entry = built
    or_raw = {}
    cfg_raw = vm_cfg.lower_goto_cfg(raw_lines, real, orient=or_raw)
    obs = vm_cfg.observable_blocks(raw_lines, real)
    entry = real[0]
    pred_n = {}
    for _u, ss in cfg_raw.items():
        for s in ss:
            pred_n[s] = pred_n.get(s, 0) + 1
    crossjump = frozenset(T for T, ss in cfg_raw.items()
                          if ss == frozenset({EXIT}) and pred_n.get(T, 0) >= 2)
    n_raw = vm_cfg.contract(cfg_raw, obs, entry, orient=or_raw, crossjump=crossjump)
    n_str = vm_cfg.contract(cfg_str, obs, entry, orient=or_str, crossjump=crossjump)
    if n_raw != n_str:
        return False
    fo_raw = {L: tf for L, tf in or_raw.items() if tf[0] != tf[1]}
    fo_str = {L: tf for L, tf in or_str.items() if tf[0] != tf[1]}
    return fo_raw == fo_str


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


def dream_equivalent(raw_lines, dream_lines, leaders):
    """REORDER-TOLERANT structured-equivalence gate (the pseudo-address idea).

    DREAM emits goto-free C that is often correct but ADDRESS-INVERTED (a shared merge
    placed below its arms), which the address-anchored `lower_struct_cfg` rejects. Here we
    RENUMBER each emitted block with a synthetic address in EMIT order (so emit order ==
    address order by construction, below `_SYNTH_BASE` so the gate's dup-handling stays
    inert), lower THAT with the existing verified gate (which is now never reordered), then
    map the resulting CFG back to the real leaders via `synth->real` and compare to the raw
    witness exactly as `structured_equivalent` does. Identity = the real address each block
    belongs to; position = the emit-order synthetic address. No change to the shared gate.

    Sufficient because DREAM carries each block's statements VERBATIM (it rearranges blocks,
    never rewrites expressions): CFG-match + every-block-once ⇒ the right values reach every
    call/return. A dropped/duplicated block shows up as a CFG mismatch here.

    ⚠ EXPERIMENTAL — FLUSH-FRAGILE FIRST CUT (2026-06-08). Detecting block boundaries by
    `bor(addr)` line-to-line breaks on flushed-call reordering: a flushed line whose address
    belongs to a neighbouring block transiently flips the mapping and corrupts the synthetic
    block split → net REGRESSION (274→240) vs the old gate. The old gate is flush-robust
    because it stays in real-address space. CONCLUSION: don't renumber-and-reuse; build the
    CFG directly from the DREAM AST (block identity is known structurally, flush irrelevant).
    Kept behind `--check2` as the concept proof (genuine reorder wins DID appear: $E3A9,
    $93C4, $A6CA, $AD3D); NOT used by `--check` or anything else."""
    import vm_cfg
    EXIT = vm_cfg.EXIT
    real = [L for L in leaders if L != EXIT]
    if not real:
        return True
    bor = vm_cfg._block_of_fn(real)
    syn_lines, syn2real = [], {}
    cur_real = cur_syn = None
    n = 0
    for addr, ind, text in dream_lines:
        if addr and not vm_cfg._RE_LABEL.match(text.strip()):
            rl = bor(addr)
            if rl != cur_real:
                n += 1
                cur_syn, cur_real = 0x10000 + n * 0x10, rl
                syn2real[cur_syn] = rl
            syn_lines.append((cur_syn, ind, text))
        else:
            syn_lines.append((addr, ind, text))
    if not syn2real:
        return False
    or_syn = {}
    cfg_syn = vm_cfg.lower_struct_cfg(syn_lines, sorted(syn2real), orient=or_syn)

    def m(x):
        return x if x == EXIT else syn2real.get(x, x)

    cfg_dream = {}
    for u, ss in cfg_syn.items():
        cfg_dream.setdefault(m(u), set()).update(m(s) for s in ss)
    cfg_dream = {u: frozenset(ss) for u, ss in cfg_dream.items()}
    or_dream = {m(u): (m(a), m(b)) for u, (a, b) in or_syn.items()}

    or_raw = {}
    cfg_raw = vm_cfg.lower_goto_cfg(raw_lines, real, orient=or_raw)
    entry = real[0]
    pred_n = {}
    for _u, ss in cfg_raw.items():
        for s in ss:
            pred_n[s] = pred_n.get(s, 0) + 1
    crossjump = frozenset(T for T, ss in cfg_raw.items()
                          if ss == frozenset({EXIT}) and pred_n.get(T, 0) >= 2)
    n_raw = vm_cfg.contract(cfg_raw, vm_cfg.observable_blocks(raw_lines, real), entry,
                            orient=or_raw, crossjump=crossjump)
    n_dr = vm_cfg.contract(cfg_dream, vm_cfg.observable_blocks(dream_lines, real), entry,
                           orient=or_dream, crossjump=crossjump)
    if n_raw != n_dr:
        return False
    fo_raw = {L: tf for L, tf in or_raw.items() if tf[0] != tf[1]}
    fo_dr = {L: tf for L, tf in or_dream.items() if tf[0] != tf[1]}
    return fo_raw == fo_dr


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
        ast = dream_ast(raw, instrs)[0]
        try:
            ok = dream_equivalent_ast(raw, ast, tc, leaders)   # the AST-native reorder-tolerant gate
        except Exception:
            ok = False                                # malformed AST the gate can't lower = reject
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


def _check2(bank):
    """Compare the OLD address-anchored gate vs the NEW reorder-tolerant gate over a bank's
    eligible subs: how many more does reorder-tolerance recover, and is any NEWLY-PASSING
    sub actually wrong (sanity: new gate should be a strict superset that stays sound)?"""
    import vm_cfg
    grab = _capture_all(bank)
    old_ok = new_ok = elig = 0
    newly = []
    for a0, (raw, instrs) in sorted(grab.items(), key=lambda x: (x[0] is None, x[0])):
        if not instrs:
            continue
        tc = tagged_cfg(raw, instrs)
        leaders = tc['leaders']
        if not leaders or not eligible(tc, leaders[0]):
            continue
        elig += 1
        dream = dream_structure(raw, instrs)
        try:
            o = vm_cfg.structured_equivalent(raw, dream, leaders)[0]
        except Exception:
            o = False
        try:
            nw = dream_equivalent(raw, dream, leaders)
        except Exception:
            nw = False
        old_ok += o
        new_ok += nw
        if nw and not o:
            newly.append(a0)
        if o and not nw:
            newly.append(-a0)                         # regression marker (should be none)
    print(f"=== bank {bank}: eligible {elig} | OLD gate {old_ok} | NEW reorder-tolerant {new_ok} ===")
    print(f"  newly-passing (reorder wins): {len(newly)}  " +
          ' '.join(('$%X' % a) if a > 0 else ('!REGRESS $%X' % -a) for a in newly[:30]))
    return old_ok, new_ok


def _check3(bank, verbose=False):
    """Measure the AST-NATIVE gate (`dream_equivalent_ast`) vs the OLD address-anchored gate
    over a bank's eligible subs. Reports validated counts, the reorder wins (newly passing),
    and any REGRESSION (old-pass / new-fail — should be empty if the AST gate is sound)."""
    import vm_cfg
    grab = _capture_all(bank)
    old_ok = new_ok = elig = guard = 0
    newly, regress = [], []
    for a0, (raw, instrs) in sorted(grab.items(), key=lambda x: (x[0] is None, x[0])):
        if not instrs:
            continue
        built = dream_ast(raw, instrs)
        if built is None:
            continue
        ast, tc, nxt = built
        leaders = tc['leaders']
        elig += 1
        out = []
        _emit_ast(ast, 0, out, nxt)
        try:
            o = vm_cfg.structured_equivalent(raw, out, leaders)[0]
        except Exception:
            o = False
        try:
            nw = dream_equivalent_ast(raw, ast, tc, leaders)
        except Exception:
            nw = False
        if _ast_cfg(ast, tc) is None:
            guard += 1
        old_ok += o
        new_ok += nw
        if nw and not o:
            newly.append(a0)
        if o and not nw:
            regress.append(a0)
    print(f"=== bank {bank}: eligible {elig} | OLD {old_ok} | AST-native {new_ok} | guard-bail {guard} ===")
    print(f"  reorder wins (new pass, old fail): {len(newly)}  " + ' '.join('$%X' % a for a in newly[:40]))
    if regress:
        print(f"  ⚠ REGRESSIONS (old pass, new fail): {len(regress)}  " + ' '.join('$%X' % a for a in regress[:40]))
    return old_ok, new_ok, len(regress)


if __name__ == "__main__":
    if len(sys.argv) >= 2 and sys.argv[1] == "--check3":
        _check3(int(sys.argv[2]), verbose="-v" in sys.argv)
    elif len(sys.argv) >= 2 and sys.argv[1] == "--check2":
        _check2(int(sys.argv[2]))
    elif len(sys.argv) >= 2 and sys.argv[1] == "--check":
        _check(int(sys.argv[2]), verbose="-v" in sys.argv)
    elif len(sys.argv) >= 2 and sys.argv[1] == "--emit":
        _emit_one(int(sys.argv[2]), sys.argv[3])
    elif len(sys.argv) == 3:
        _dump(int(sys.argv[1]), sys.argv[2])
    else:
        sys.exit("usage: dream.py <bank> <addr> | --emit <bank> <addr> | --check <bank> [-v]")
