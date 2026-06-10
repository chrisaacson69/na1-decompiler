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


# A branch predicate that READS MUTABLE STATE — a function CALL or a memory DEREFERENCE (`*`) — is
# IMPURE: two textually-identical occurrences at different branch blocks are two DISTINCT evaluations
# with independent truth values, so they must be DIFFERENT literals. Else the reaching-condition
# algebra entangles them: asserting branch A's predicate true makes branch B's identical-text
# false-arm contradictory, dropping a real edge — `prompt_yes_no()` at `$AAD3`+`$AB04` (`$AAAC`),
# `test_6f65_bit7(...)` at `$A858`+`$A8A6` (`$A852`), `*(byte*)(local9+0x6DA2)` at `$9855`+`$9937`
# (`$9855`). We append a per-block sentinel to the literal's base; `to_c` strips it so the emitted
# condition stays clean. (Bare scalar predicates — `cur_combat_unit_slot`, `(local10 <= 0)`, `arg1`
# — keep shared identity: uniquifying them would needlessly de-factor clean structure.)
_DISAMBIG = '\x1f'
_IMPURE_RE = re.compile(r'[A-Za-z_]\w*\(|\*')        # a call `name(` or a pointer deref `*`


def _branch_lit(rawcond, block_addr):
    """`lit(rawcond)` but an IMPURE predicate (call or memory deref) is made unique to its block."""
    e = lit(rawcond)
    if e[0] == 'lit' and _IMPURE_RE.search(e[1]):
        return ('lit', '%s%s%X' % (e[1], _DISAMBIG, block_addr), e[2])
    return e


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
        base = e[1].split(_DISAMBIG, 1)[0]             # strip the impure-call disambiguator
        return base if e[2] else '!(%s)' % base
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
                c = _branch_lit(rawcond, L)
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


def _reachable(cfg, header):
    """Forward-reachable set of every node (INCLUSIVE of the node, EXIT excluded) in the acyclic
    CFG. Computed successors-first (reverse of reverse-postorder) so each node unions sets already
    built. Feeds `_reconvergences`."""
    EXIT = vm_cfg.EXIT
    reach = {}
    for n in reversed(_reverse_postorder(cfg, header)):
        s = {n}
        for t in cfg.get(n, ()):
            if t != EXIT:
                s |= reach.get(t, {t})
        reach[n] = s
    return reach


def _reconvergences(cfg, header, rpo):
    """Continuation map for `refine`: for each 2-way branch, the node where its arms RE-MEET. This
    is the EXIT-rooted immediate post-dominator (Cooper–Harvey–Kennedy) in a SINGLE-exit region,
    but survives MULTI-exit functions where that collapses: early `return`s (and a separate
    success-exit) drive every strict post-dominator to EXIT (e.g. `$9A62`: all 18 pivots → EXIT,
    nothing extracted, tail duplicated 34x). The reconvergence `m` of branch `Lpiv` is the lowest-rpo
    node reached by BOTH arms such that EVERY path from Lpiv either reaches `m` or first hits a
    RETURN SINK positioned BEFORE `m` (rpo < rpo(m)) — i.e. `m` post-dominates Lpiv once early
    returns that terminate ahead of it are exempted. The rpo test is the right discriminator: a
    sink that returns BEFORE m's position is a guard-style early-out (exempt); a sink AT-OR-PAST m
    means a path overtook m, so m isn't the reconvergence. (Plain `reachable-from-both` is WRONG —
    it picks an arm-internal node a sibling path bypasses, `$9A1B`'s `$9A2D`, dropping that branch;
    an in-degree heuristic is WRONG too — `$AAAC`'s `return 0` early-out has in-degree 2 yet must be
    exempt so the dominant `return 1` exit `$AB35` can be the continuation.)"""
    EXIT = vm_cfg.EXIT
    reach = _reachable(cfg, header)

    def valid(Lpiv, m, succs):
        """True iff `m` post-dominates Lpiv modulo exempt early returns (see docstring)."""
        rm = rpo.get(m, 1 << 30)
        stack, seen = list(succs), set()
        while stack:
            n = stack.pop()
            if n == m or n in seen:
                continue
            seen.add(n)
            outs = cfg.get(n, ())
            if tuple(outs) == (EXIT,):                 # a return sink reached before m
                if rpo.get(n, 1 << 30) < rm:
                    continue                           # terminated BEFORE m's position — exempt
                return False                           # overtook m → m isn't the reconvergence
            for t in outs:
                if t == m:
                    continue                           # this path reaches m — good
                if t == EXIT:
                    return False                       # fell off without m / exempt sink
                stack.append(t)
        return True

    cont = {}
    for n in cfg:
        succs = [s for s in cfg[n] if s != EXIT]
        if len(succs) < 2:
            continue
        common = set.intersection(*[reach.get(s, set()) for s in succs])
        common.discard(n)
        cands = sorted(common, key=lambda x: rpo.get(x, 1 << 30))
        for m in cands:
            if valid(n, m, succs):
                cont[n] = m
                break
    return cont


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
    return _branch_lit(rawcond, L) if rawcond is not None else None


# --------------------------------------------------------------------------- #
# SHORT-CIRCUIT `||` RECOVERY. The compiler lowers `if (c1 || c2 || … || ck) { body }` to a
# CASCADE of guard blocks: each Bi tests ci and GOTOs the common BODY if true, else falls to the
# next guard; the last guard falls to SKIP. A pivot-by-pivot structurer splits on each ci in turn
# and DUPLICATES body's whole subtree into every disjunct's arm (`$9E26`: 7x). Recovering the
# compound condition lets BODY emit ONCE. SOUND because the absorbed guards B2..Bk (and any
# intervening blocks) are STATEMENT-FREE — their only content is the condition, which short-circuit
# `||` evaluates in the same order — so collapsing the cascade to one `entry → {body, skip}` branch
# is a behaviour-preserving identity (the same one the front-end's `control_shortcircuits` applies).
# The gate stays honest: the SAME collapse runs on the raw-witness CFG, so both sides compare equal.
# --------------------------------------------------------------------------- #
def _or_chains(tc):
    """Detect short-circuit OR chains; return [{entry, body, skip, absorbed, compound_text}]
    where `absorbed` = the statement-free guards/links to remove (B2..Bk + intervening 1-ways).
    A guard reaches BODY under EITHER its goto-cond or its fall-cond (mixed polarity — `$9E26`'s
    `$9E58` falls to the body), so BODY is identified as the COMMON successor and each disjunct is
    read from the EDGE TAG `tag[(Bi, body)]` (already the correctly-signed condition)."""
    cfg, kind, info, tag = tc['cfg'], tc['kind'], tc['info'], tc['tag']
    EXIT = vm_cfg.EXIT
    indeg = {}
    for u in cfg:
        for v in cfg[u]:
            if v != EXIT:
                indeg[v] = indeg.get(v, 0) + 1

    def empty(L):
        return not info[L][0]                         # condition-only block (no statements)

    def absorbable(L):
        # an absorbed guard/link must be statement-free AND reached ONLY from within the chain
        # (in-degree 1) — else removing it would dangle an external predecessor's edge (unsound).
        return empty(L) and indeg.get(L, 0) == 1

    def other_succ(L, body):
        return next((s for s in cfg[L] if s != body and s != EXIT), None)

    def walk(B, body):
        """Longest chain from B whose every member branches to `body`; (members, absorbed, skip)."""
        members, absorbed, cur = [B], [], B
        nxt = other_succ(B, body)
        while True:
            interv, n = [], nxt
            while n not in (None, EXIT) and kind.get(n) == '1way' and absorbable(n):
                interv.append(n)
                n = next((s for s in cfg[n] if s != EXIT), None)
            if (n not in (None, EXIT) and kind.get(n) == '2way' and absorbable(n)
                    and body in cfg[n]):
                absorbed += interv + [n]
                members.append(n)
                cur, nxt = n, other_succ(n, body)
                continue
            break
        return members, absorbed, nxt                 # nxt = the cascade's SKIP exit

    chains, claimed = [], set()
    for B in sorted(cfg):
        if B == EXIT or B in claimed or kind.get(B) != '2way':
            continue
        best = None
        for body in sorted(s for s in cfg[B] if s != EXIT):
            if body in claimed:
                continue
            members, absorbed, skip = walk(B, body)
            if len(members) >= 2 and skip not in (None, body) \
                    and not (set(absorbed) & claimed) and (best is None or len(members) > len(best[0])):
                best = (members, absorbed, skip, body)
        if best is None:
            continue
        members, absorbed, skip, body = best
        parts = [to_c(tag[(m, body)]) for m in members]   # signed disjuncts from the edge tags
        chains.append(dict(entry=B, body=body, skip=skip, absorbed=absorbed,
                           compound_text='(' + ' || '.join(parts) + ')'))
        claimed |= {B} | set(absorbed)
    return chains


def _collapse_tc_chains(tc, chains):
    """Rewrite tc IN PLACE: each chain's entry becomes one 2-way block with the compound condition
    (goto BODY / fall SKIP); the absorbed statement-free guards/links are removed."""
    absorbed = set()
    for ch in chains:
        e, T, skip = ch['entry'], ch['body'], ch['skip']
        clit = _branch_lit(ch['compound_text'], e)
        tc['cfg'][e] = frozenset({T, skip})
        tc['tag'][(e, T)] = clit
        tc['tag'][(e, skip)] = neg(clit)
        info_e = list(tc['info'][e])
        info_e[1], info_e[3] = ch['compound_text'], T
        tc['info'][e] = tuple(info_e)
        absorbed |= set(ch['absorbed'])
    for b in absorbed:
        tc['cfg'].pop(b, None)
        tc['kind'].pop(b, None)
        tc['info'].pop(b, None)
    for k in [k for k in tc['tag'] if k[0] in absorbed or k[1] in absorbed]:
        tc['tag'].pop(k, None)
    tc['leaders'] = [L for L in tc['leaders'] if L not in absorbed]


def _collapse_raw_chains(cfg, orient, chains):
    """Apply the SAME collapse to a lowered RAW-witness CFG + orientation so the gate compares the
    structurer's compound branch against an equally-collapsed witness: entry → {body, skip}. The
    orientation is recorded with the SAME `_record_orient(compound_text, body, skip)` call the
    structurer uses, so its parity fold (a `(!(c)||…)` compound flips taken/fall) is identical on
    both sides — hard-coding true=body would mismatch whenever the compound's parity is negative."""
    absorbed = set()
    for ch in chains:
        e = ch['entry']
        cfg[e] = frozenset({ch['body'], ch['skip']})
        vm_cfg._record_orient(orient, e, ch['compound_text'], ch['body'], ch['skip'])
        absorbed |= set(ch['absorbed'])
    for b in absorbed:
        cfg.pop(b, None)
        if orient is not None:
            orient.pop(b, None)


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


def _assert(e, piv, truth):
    """Simplify `e` under the assumption that the pivot literal `piv` has truth value `truth`
    (substitute piv's base everywhere and fold). Used to split each item's reaching condition
    into its goto-arm part (piv true) and fall-arm part (piv false). A block reachable in only
    one arm yields FALSE in the other (lands in one arm — what `_factor` did); a SHARED MERGE
    (cr = an OR spanning piv and !piv) yields non-FALSE in BOTH (it is DUPLICATED into each arm,
    where the recursion places it at the depth its residual condition becomes TRUE — un-sharing
    the merge so the structurer folds it goto-free instead of emitting a flat reject guard)."""
    k = e[0]
    if k == 'lit' and e[1] == piv[1]:                 # same predicate base as the pivot
        base_true = piv[2] if truth else (not piv[2])  # base's value given piv == truth
        return TRUE if (e[2] == base_true) else FALSE
    if k == 'and':
        return _and(*[_assert(x, piv, truth) for x in e[1]])
    if k == 'or':
        return _or(*[_assert(x, piv, truth) for x in e[1]])
    return e


def refine(tc, items):
    """items = ordered [(cond, leader)]. Recursively split by the lowest-address branch
    predicate into nested if/else, DUPLICATING shared merges into each arm (via `_assert`) so
    they fold goto-free rather than dropping to a flat reject guard. Returns an emit AST."""
    items = [(c, L) for c, L in items if c != FALSE]
    if not items:
        return []
    piv = Lpiv = None
    _rpo = tc.get('rpo', {})
    for _c, L in sorted(items, key=lambda x: (_rpo.get(x[1], 1 << 30), x[1])):
        # PIVOT = the TOPOLOGICALLY-FIRST 2-way branch (lowest rpo) — the one that dominates the
        # others — with its real polarity. rpo, not address: an address-inverted branch region
        # (`$9192`'s `$9290` merge sits below the `$92BC`/`$92C5` that precede it topologically)
        # must pivot on the entry-most branch, else the merge is split before its predecessors and
        # the structure scrambles. The AST gate is reorder-tolerant, so address order isn't owed.
        lt = _lit_of(tc, L)
        if lt is not None:
            piv, Lpiv = lt, L
            break
    if piv is None:                                   # no branch left: emit the residue
        out = []
        rank = tc.get('rpo', {})                       # topological order, NOT address (see dream_ast)
        for c, L in sorted(items, key=lambda x: (rank.get(x[1], 0), x[1])):
            payload = ('block', L, tc['info'][L][0])
            out.append(payload if c == TRUE else ('guard', c, payload))
        return out
    rpo, cont_map = tc['rpo'], tc.get('cont_map', {})
    big = 1 << 30
    rpiv = rpo.get(Lpiv, big)
    # PRE-PIVOT TRUNK: the UNCONDITIONAL linear entry chain before the first branch — blocks
    # TOPOLOGICALLY before the pivot (rpo < rpo(pivot)) AND with reaching condition TRUE (always
    # executed in this context). Selection AND order are by rpo, NOT address: a reconvergence/join
    # is also `cr==TRUE` but sits AFTER the branches (rpo > pivot), and it can be ADDRESS-INVERTED
    # below its own predecessors (`$9E78`'s flag-set `$9FC7` at a lower address than `$A008`/`$A010`
    # that feed it). Address order would mis-grab that join as trunk and emit it before the branch,
    # dropping the edges into it; rpo excludes it (it's a continuation, placed after the if). The
    # `c == TRUE` guard also keeps a CONDITIONAL low-rpo arm body out (`$AD3D`'s `$AD67`).
    pre = sorted((x for x in items if x[0] == TRUE and rpo.get(x[1], big) < rpiv),
                 key=lambda x: rpo.get(x[1], big))
    pre_set = {L for _c, L in pre}
    pre_nodes = [('block', L, tc['info'][L][0]) for _c, L in pre]
    cpiv = dict((L, c) for c, L in items)[Lpiv]
    head = ('block', Lpiv, tc['info'][Lpiv][0])
    head_emit = head if cpiv == TRUE else ('guard', cpiv, head)
    # CONTINUATION: the pivot branch's reconvergence (immediate post-dominator) is reached by
    # all its non-returning arm-paths, so emit it ONCE after the if (the structural fall-through)
    # rather than DUPLICATING it into both arms — distribution alone makes a wide reconvergent
    # tail blow up combinatorially. Split: [< cont in topo order] distributes into the arms;
    # [>= cont] is the continuation, refined once with cont forced unconditional (TRUE).
    item_ls = {L for _c, L in items}
    cont = cont_map.get(Lpiv)
    if cont in (None, vm_cfg.EXIT) or cont not in item_ls or cont == Lpiv or cont in pre_set:
        cont = None
    # The continuation is a FRESH sub-problem rooted at `cont`: recompute reaching conditions with
    # `cont` as header so each continuation block's condition is RELATIVE to cont, not the header.
    # For a strict single-exit post-dominator cr(cont)≡TRUE, so this is a no-op; for a multi-exit
    # reconvergence (early returns) cr(cont) is a real OR — dividing it out here is what stops the
    # continuation blocks from carrying an unreducible prefix guard (which otherwise SPLITS a block
    # into a guarded-body copy + a pivot copy, duplicating it and breaking the AST→CFG gate). Its
    # KEYS are exactly the nodes reachable FROM cont — the precise continuation region. (An rpo
    # threshold is too crude: a PARALLEL exit like `$97BB` ranks past cont yet isn't reached through
    # it, so a threshold would steal it from its arm and sever the branch that guards it.)
    cr_cont = reaching_conditions(tc, cont) if cont is not None else None
    fall_i, goto_i, cont_i = [], [], []               # fall side / goto side / continuation
    for c, L in items:
        if L == Lpiv or L in pre_set:
            continue
        if cont is not None and L in cr_cont:         # reachable through cont → the continuation
            cont_i.append((TRUE if L == cont else cr_cont[L], L))   # reached once, after the if
            continue
        cg = _assert(c, piv, True)                    # this block's condition on the goto arm
        cf = _assert(c, piv, False)                   #                       ... the fall arm
        if cg != FALSE:
            goto_i.append((cg, L))
        if cf != FALSE:                               # non-FALSE in both -> a duplicated merge
            fall_i.append((cf, L))
    goto_target = tc['info'][Lpiv][3]
    t_succ = tc['block_of'](goto_target) if goto_target is not None else None
    f_succ = next((s for s in tc['cfg'][Lpiv] if s != vm_cfg.EXIT and s != t_succ), vm_cfg.EXIT)
    node = ('if', Lpiv, piv, f_succ, t_succ, refine(tc, fall_i), refine(tc, goto_i))
    return pre_nodes + [head_emit, node] + refine(tc, cont_i)


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
        elif k == 'continue':
            out.append((0, indent, "continue;"))
        elif k == 'break':
            out.append((0, indent, "break;"))
        elif k == 'loop':
            _, h, body = node
            out.append((h, indent, "while (1) {"))
            _emit_ast(body, indent + 1, out, nxt)
            out.append((0, indent, "}"))
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
            INF = 1 << 30                             # a break/continue-only arm has no real addr
            fmv = fm if fm is not None else INF       # → sorts last, so it never steals `then`
            gmv = gm if gm is not None else INF
            flip = (not fall_has) or (goto_has and gmv < fmv)
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


# RUNG 2 (value-aware) — CONSUMING-CALL STACK-PHI repair now lives in the FRONT-END
# (`vm_cfg.consuming_phis` + `vm_decompile`'s post-dispatch materialisation), where the live
# data stack lets it stay sound (each arm's CAPTURED value, no re-evaluation) and it fixes
# V1/V2's canonical output too. This DREAM-only `cr`-based ternary prototype proved the
# mechanism (6/8 eligible repaired, gate-green) and is now superseded — DREAM inherits the
# front-end's phi temps (`phi_<merge> = <value>;` per arm; the merge call reads the temp).


# --------------------------------------------------------------------------- #
# RUNG 2 — LOOP STRUCTURING.  DREAM's acyclic core (reaching conditions → `refine`) is
# loop-blind, but a natural loop is just an ACYCLIC sub-problem once its two erased boundaries
# are put back (the un-sharing lever again): the BACK edge (latch → header) and the EXIT edges
# (a loop node → a block outside the loop). We cut both, redirecting each to a synthetic SINK
# leader — the back edge to a CONTINUE sink, every exit edge to a BREAK sink — so the loop body
# becomes a DAG rooted at the header that the existing `_acyclic_seq` structures verbatim. The
# resulting AST's sink-blocks are then mapped to `('continue', h)` / `('break', X)` markers, and
# the whole body is wrapped in a `('loop', h, body)` node emitted as `while (1) { … }`. The OUTER
# graph collapses each loop to its header (successor = the single exit target), is structured
# acyclically, and the loop node is substituted back in for the header's block. The gate is
# already cycle-tolerant (`vm_cfg.contract` bypasses routers through self-loops and keeps tail
# orientation), and `_ast_cfg` derives every edge from each block's REAL successors — so the
# continue/break markers resolve to the true header / exit and the lowered CFG matches the raw
# witness exactly. Phase 1 scope: SINGLE-LEVEL, SINGLE-EXIT-TARGET, reducible loops; any other
# shape (nested, multi-exit, irreducible, switch-in-loop) returns None → passthrough unchanged.
# --------------------------------------------------------------------------- #
CONT_SINK = '\x1bCONT'                    # synthetic sink: latch back-edge → loop header (continue)


def _brk_sink(x):
    return ('\x1bBRK', x)                  # synthetic sink: loop-exit edge → block X outside the loop


def _is_sink(L):
    return L == CONT_SINK or (isinstance(L, tuple) and L and L[0] == '\x1bBRK')


def _acyclic_seq(tc, header, do_orchains=True):
    """Run the full acyclic refinement pipeline over `tc` (its `leaders` already set, `header` =
    entry): optional ||-collapse, reverse-postorder rank, reconvergence map, reaching conditions,
    `refine`. Returns the AST seq. Shared by the top-level acyclic path AND each loop sub-problem
    (body region + collapsed outer). `do_orchains=False` for loop sub-problems — the gate lowers
    the REAL (un-collapsed) witness for the loop case, so recovering `||` inside a loop would
    desync the two sides; left for a later rung."""
    leaders = tc['leaders']
    if do_orchains:
        # SHORT-CIRCUIT `||` recovery: collapse guard cascades to one compound branch BEFORE
        # reaching conditions, so BODY emits once (not duplicated per disjunct). leaders_full +
        # or_chains are kept for the gate, which collapses the raw witness identically.
        tc['leaders_full'] = list(leaders)
        tc['or_chains'] = _or_chains(tc)
        if tc['or_chains']:
            _collapse_tc_chains(tc, tc['or_chains'])
            leaders = tc['leaders']
    else:
        tc.setdefault('leaders_full', list(leaders))
        tc.setdefault('or_chains', [])
    # Topological (reverse-postorder) rank: a block ranks before the blocks it flows to. Used to
    # order an arm's branch-free residue by DATA dependency (so each block falls into its
    # successor), pivot selection, and pre-trunk membership — never by address (the gate is
    # reorder-tolerant; a merge can sit at a LOWER address than its predecessor).
    tc['rpo'] = {L: i for i, L in enumerate(_reverse_postorder(tc['cfg'], header))}
    # Multi-exit-aware reconvergence (NOT the strict EXIT-rooted post-dominator: early returns
    # collapse that to EXIT, defeating continuation extraction — see `_reconvergences`).
    tc['cont_map'] = _reconvergences(tc['cfg'], header, tc['rpo'])
    cr = reaching_conditions(tc, header)
    items = [(cr[L], L) for L in leaders if L != vm_cfg.EXIT and L in cr]
    return refine(tc, items)


def _natural_loops(tc, header):
    """The sub's reducible natural loops as [{h, nodes, latches, exit}], or None when out of
    Phase-1 scope. Loops sharing a header merge (one loop, many latches). Bails (None) on nested
    or overlapping loops and on any loop with >1 distinct exit TARGET — left for a later phase."""
    cfg = tc['cfg']
    edges, _dom = vm_cfg.back_edges(cfg, header)
    if not edges:
        return []
    byh = {}
    for u, h in edges:
        byh.setdefault(h, set()).add(u)
    loops, nodes_of = [], {}
    for h, latches in byh.items():
        N = set()
        for u in latches:
            N |= vm_cfg.natural_loop(u, h, cfg)
        nodes_of[h] = N
        loops.append({'h': h, 'nodes': frozenset(N), 'latches': frozenset(latches)})
    hs = list(nodes_of)
    for i, hi in enumerate(hs):                       # disjoint single-level only (Phase 1)
        for j, hj in enumerate(hs):
            if i != j and hj in nodes_of[hi]:
                return None                            # nested loop
        for hj in hs[i + 1:]:
            if nodes_of[hi] & nodes_of[hj]:
                return None                            # overlapping (irreducible-ish)
    for lp in loops:
        exits = set()
        for n in lp['nodes']:
            for s in cfg[n]:
                if s != vm_cfg.EXIT and s not in lp['nodes']:
                    exits.add(s)
        if len(exits) > 1:
            return None                                # multi-exit-target loop
        lp['exit'] = next(iter(exits)) if exits else None
    return loops


def _region_tc(base, nodes, header, exit_target):
    """A self-contained acyclic sub-`tc` for one loop body: the loop's `nodes`, with every back
    edge (→ header) redirected to the CONTINUE sink and every exit edge (→ outside `nodes`) to that
    exit's BREAK sink. Sinks are terminal (→EXIT) statement-free leaders. Block content / branch
    conditions are carried verbatim (the structuring is identity-preserving)."""
    EXIT = vm_cfg.EXIT
    cfg, tag, info, kind = {}, {}, {}, {}
    for L in nodes:
        info[L] = base['info'][L]
        kind[L] = base['kind'][L]
        succ = []
        for s in base['cfg'][L]:
            if s == EXIT:
                t = EXIT
            elif s == header:
                t = CONT_SINK
            elif s in nodes:
                t = s
            else:
                t = _brk_sink(s)
            succ.append(t)
            tag[(L, t)] = base['tag'].get((L, s), TRUE)
        cfg[L] = succ
    sinks = {s for L in nodes for s in cfg[L] if _is_sink(s)}
    for sk in sinks:
        cfg[sk] = [EXIT]
        info[sk] = ([], None, None, None, False)
        kind[sk] = 'exit'
        tag[(sk, EXIT)] = TRUE
    real = [L for L in base['leaders'] if L in nodes]
    leaders = real + sorted(sinks, key=repr)
    return dict(cfg=cfg, leaders=leaders, block_of=base['block_of'], info=info,
                buckets=base.get('buckets', {}), tag=tag, kind=kind)


def _outer_tc(base, loops, removed):
    """The sub with every loop COLLAPSED to its header: body-interior nodes dropped, each header
    rewired to its single exit target (a 1-way), so the residue is acyclic and `_acyclic_seq`
    structures it. The header's block is later replaced by the loop node, so its statements here
    are irrelevant."""
    EXIT = vm_cfg.EXIT
    hexit = {lp['h']: lp['exit'] for lp in loops}
    cfg, tag, info, kind = {}, {}, {}, {}
    leaders = [L for L in base['leaders'] if L not in removed]
    for L in leaders:
        if L in hexit:
            x = hexit[L]
            succ = [x if x is not None else EXIT]
            cfg[L] = succ
            kind[L] = 'exit' if succ == [EXIT] else '1way'
            info[L] = ([], None, None, None, False)
            tag[(L, succ[0])] = TRUE
        else:
            cfg[L] = list(base['cfg'][L])
            kind[L] = base['kind'][L]
            info[L] = base['info'][L]
            for s in base['cfg'][L]:
                tag[(L, s)] = base['tag'].get((L, s), TRUE)
    return dict(cfg=cfg, leaders=leaders, block_of=base['block_of'], info=info,
                buckets=base.get('buckets', {}), tag=tag, kind=kind)


def _map_sinks(seq, h, exit_target):
    """Replace synthetic sink blocks in a structured loop body with continue/break markers:
    CONTINUE sink → ('continue', h); BREAK sink for X → ('break', X). Recurses into guards / ifs."""
    def conv(node):
        k = node[0]
        if k == 'block':
            L = node[1]
            if L == CONT_SINK:
                return ('continue', h)
            if _is_sink(L):
                return ('break', L[1])
            return node
        if k == 'guard':
            return ('guard', node[1], conv(node[2]))
        if k == 'if':
            _, Lpiv, piv, f, t, fall, goto = node
            return ('if', Lpiv, piv, f, t, [conv(x) for x in fall], [conv(x) for x in goto])
        return node
    return [conv(x) for x in seq]


def _substitute_loops(seq, loop_nodes):
    """Replace each collapsed loop header's block in the outer AST with its ('loop', h, body)."""
    def sub(node):
        k = node[0]
        if k == 'block' and node[1] in loop_nodes:
            return loop_nodes[node[1]]
        if k == 'guard':
            return ('guard', node[1], sub(node[2]))
        if k == 'if':
            _, Lpiv, piv, f, t, fall, goto = node
            return ('if', Lpiv, piv, f, t, [sub(x) for x in fall], [sub(x) for x in goto])
        return node
    return [sub(x) for x in seq]


def _loop_structure(tc, header, loops):
    """Build the loop-aware AST: structure each loop body in isolation (redirected sub-tc), wrap
    in a loop node, then structure the collapsed outer graph and substitute the loop nodes back.
    Returns None if any region (body or outer) is still cyclic (irreducible — out of scope)."""
    loop_nodes, removed = {}, set()
    for lp in loops:
        h, N = lp['h'], lp['nodes']
        rtc = _region_tc(tc, N, h, lp['exit'])
        if _has_backedge(rtc['cfg'], h):              # body still cyclic ⇒ irreducible — bail
            return None
        body = _map_sinks(_acyclic_seq(rtc, h, do_orchains=False), h, lp['exit'])
        loop_nodes[h] = ('loop', h, body)
        removed |= (set(N) - {h})
    otc = _outer_tc(tc, loops, removed)
    if _has_backedge(otc['cfg'], header):             # outer still cyclic ⇒ irreducible — bail
        return None
    outer = _acyclic_seq(otc, header, do_orchains=False)
    return _substitute_loops(outer, loop_nodes)


def dream_ast(lines, instructions):
    """Build the refinement AST (+ tc + the address next_leader map) for an in-scope sub, or None
    when out of scope (switch, or a loop shape Phase 1 doesn't handle). Shared by the emitter and
    the AST-native gate."""
    tc = tagged_cfg(lines, instructions)
    leaders = tc['leaders']
    if not leaders:
        return None
    if any(k == 'switch' for k in tc['kind'].values()):
        return None
    EXIT = vm_cfg.EXIT
    header = leaders[0]
    real = [L for L in leaders if L != EXIT]
    nxt = {real[i]: (real[i + 1] if i + 1 < len(real) else EXIT) for i in range(len(real))}
    if not _has_backedge(tc['cfg'], header):
        tc['leaders'] = list(leaders)
        return _acyclic_seq(tc, header), tc, nxt
    loops = _natural_loops(tc, header)
    if loops is None:
        return None
    ast = _loop_structure(tc, header, loops)
    if ast is None:
        return None
    return ast, tc, nxt


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
        if k == 'continue':                           # back-edge → the loop header
            return node[1]
        if k == 'break':                              # exit edge → the block past the loop
            return node[1]
        if k == 'loop':
            # The loop body's lexical end loops back to the header (fall == h); break/continue
            # markers carry their own real targets. Building the body sets every loop block's
            # REAL edges, so the lowered CFG is cyclic exactly like the witness. Entry == h.
            _, h, body = node
            return build(body, h)
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
    # Lower the raw witness with the FULL (pre-collapse) leader set so the guard cascade is intact,
    # then apply the SAME OR-chain collapse the structurer did — both sides end at one compound
    # branch, so the recovered `||` verifies against the witness (sound: absorbed guards are
    # statement-free, so cascade ≡ compound). No chains ⇒ this is the original single-lowering path.
    full = tc.get('leaders_full', leaders)
    real_full = [L for L in full if L != EXIT]
    cfg_raw = vm_cfg.lower_goto_cfg(raw_lines, real_full, orient=or_raw)
    _collapse_raw_chains(cfg_raw, or_raw, tc.get('or_chains', []))
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


# Readability cap on merge-DUPLICATION. Un-sharing a merge duplicates it into each reaching arm
# (un-shared so the structure folds goto-free); the reconvergence continuation keeps that ~once
# (now multi-exit-aware, so early-return regions like `$9A62` no longer blow up), but a genuinely
# N-way shared region still duplicates a lot — inherently, because a goto-free + structurally-CFG-
# isomorphic form of an N-way shared region MUST duplicate or use a goto. Past this factor the emit
# reads worse than V2's honest goto, so we
# DON'T count it a DREAM win (it stays an honest reject) — DREAM takes the subs it folds READABLY.
DUP_CAP = 4


def _max_dup(lines):
    """Most times any single real-address line is emitted (merge-duplication factor)."""
    from collections import Counter
    c = Counter(a for a, _i, _t in lines if a)
    return max(c.values()) if c else 1


def _check(bank, verbose=False):
    """Spike-A measurement: run dream_structure over every sub in `bank`, gate each vs its
    raw witness, and tally folded / gate-rejected / over-duplicated / passthrough + goto deltas."""
    import vm_cfg
    grab = _capture_all(bank)
    elig = folded = rejected = overdup = passthrough = 0
    g_raw_e = g_dream_e = 0                            # goto totals over ELIGIBLE-and-validated
    rej_list, win_list, dup_list = [], [], []
    for a0, (raw, instrs) in sorted(grab.items(), key=lambda x: (x[0] is None, x[0])):
        if not instrs:
            continue
        built = dream_ast(raw, instrs)               # None ⇒ out of scope (switch / unhandled loop)
        if built is None:
            passthrough += 1
            continue
        elig += 1
        ast, tc, nxt = built
        leaders = tc['leaders']
        out = []
        _emit_ast(ast, 0, out, nxt)
        dream = out
        try:
            ok = dream_equivalent_ast(raw, ast, tc, tc['leaders'])   # AST-native reorder-tolerant gate
        except Exception:
            ok = False                                # malformed AST the gate can't lower = reject
        if ok and _max_dup(dream) > DUP_CAP:          # CFG-correct but reads worse than honest goto
            overdup += 1
            dup_list.append((a0, _max_dup(dream)))
            continue
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
    print(f"    over-duplicated (>{DUP_CAP}x, kept honest): {overdup}")
    if folded:
        print(f"  gotos over validated  : raw {g_raw_e} -> dream {g_dream_e}  (delta {g_dream_e-g_raw_e})")
        print(f"  subs strictly improved: {len(win_list)}")
    if verbose and rej_list:
        print("  rejected: " + ' '.join('$%X' % a for a in rej_list[:40]))
    if verbose and dup_list:
        print("  over-dup: " + ' '.join('$%X(%dx)' % (a, n) for a, n in dup_list))
    return folded, rejected, elig


def _emit_one(bank, sub_addr_hex):
    """Dump the structured C dream_structure produces for one sub + the gate verdict."""
    import vm_cfg
    lines, instrs = _capture_sub(bank, sub_addr_hex)
    built = dream_ast(lines, instrs)                  # None ⇒ out of scope (switch / unhandled loop)
    if built is None:
        print(f"sub ${sub_addr_hex}: OUT OF SCOPE (switch / unhandled loop) — passthrough")
        return
    ast, tc, nxt = built
    dream = []
    _emit_ast(ast, 0, dream, nxt)
    try:
        ok = dream_equivalent_ast(lines, ast, tc, tc['leaders'])   # AST-native reorder-tolerant gate
    except Exception:
        ok = False
    dup = _max_dup(dream)
    tag = 'PASS' if (ok and dup <= DUP_CAP) else ('OVER-DUP %dx' % dup if ok else 'REJECT')
    print(f"=== DREAM structured C — bank {bank} @ ${sub_addr_hex}  [gate: {tag}] ===")
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
