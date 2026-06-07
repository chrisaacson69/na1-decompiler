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
    if not s:
        return FALSE
    if len(s) == 1:
        return next(iter(s))
    return ('or', frozenset(s))


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


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("usage: dream.py <bank> <sub_addr_hex>")
    _dump(int(sys.argv[1]), sys.argv[2])
