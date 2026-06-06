"""
tools/probe-primitives.py — MODEL VALIDATION via forward primitives (not residue-chasing).

Chris's reframe (2026-06-06): stop steering by goto-count / "behind V1". Instead, take each KNOWN
source primitive (nested ifs, if-else, short-circuit, loops, …) and its COLLAPSED goto/label form
(the compiler shares merge targets — N closing braces become 1 merge), and ask the one question
that matters: can the structurer PUT IT BACK as readable nested structure? Where it can't, that's a
real model gap (independent of any metric).

Each primitive is authored as its RAW goto/label line list (addr, indent, text) — exactly what the
decompiler hands the reducer — plus its block leaders. We derive the CFG with lower_goto_cfg (so the
input IS a faithful witness), run the whole-sub structurer (mirroring reduce()), and print the
recovered structure + whether it self-validates against the raw witness.

Usage:  py -3 tools/probe-primitives.py [name]
"""
import sys
from pathlib import Path
from collections import defaultdict

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
import vm_cfg
import vm_reduce


def _structure_whole(lines, leaders):
    """Mirror reduce()'s whole-sub structuring (the _COMBOS grid) on a hand-authored raw line list,
    returning (best_structured_lines, validates, goto_count) for the fewest-goto VALIDATING fold, or
    the flat form if none validate."""
    cfg = vm_cfg.lower_goto_cfg(lines, leaders)
    block_of = vm_cfg._block_of_fn(leaders)
    buckets = vm_reduce._partition(lines, leaders)
    info = {L: vm_reduce._parse_block(buckets[L]) for L in leaders}
    nxt = {leaders[i]: (leaders[i + 1] if i + 1 < len(leaders) else vm_cfg.EXIT)
           for i in range(len(leaders))}
    edges, _dom = vm_cfg.back_edges(cfg, leaders[0])
    loops, latches = {}, defaultdict(set)
    for u, hh in edges:
        loops.setdefault(hh, set()).update(vm_cfg.natural_loop(u, hh, cfg))
        latches[hh].add(u)
    loops = {hh: frozenset(s) for hh, s in loops.items()}
    pdom = vm_cfg.post_dominators(cfg)
    switches = {}  # no switches in these primitives

    best, best_g = None, None
    for sm in (False, True):
        for mn in (False, True):
            for dp in (False, True):
                ctx = vm_reduce._Ctx(cfg, info, block_of, nxt, loops, latches, buckets, switches)
                ctx.sink_merge, ctx.merge_nonadj, ctx.dup_terminals = sm, mn, dp
                try:
                    seq, _u = vm_reduce._structure(leaders[0], vm_cfg.EXIT, pdom, ctx, None)
                except vm_reduce._NotReducible:
                    continue
                if dp and not all(ctx.dup_count[T] + (1 if T in ctx.visited else 0)
                                  == len(ctx.preds[T]) for T in ctx.dup_count):
                    continue
                out = []
                vm_reduce._emit(seq, 0, out)
                out = vm_reduce._insert_labels(out, block_of)
                out = vm_reduce._label_reordered_falls(out, block_of)
                if not vm_cfg.structured_equivalent(lines, out, leaders)[0]:
                    continue
                g = sum(1 for _a, _i, t in out if vm_reduce._RE_GOTO_TGT.search(t))
                if best is None or g < best_g:
                    best, best_g = out, g
    if best is not None:
        return best, True, best_g
    # flat fallback
    flat = vm_reduce._flat_emit(buckets, leaders)
    return flat, False, sum(1 for _a, _i, t in flat if vm_reduce._RE_GOTO_TGT.search(t))


def _render(lines):
    return "\n".join(f"{'  ' * i}{t}" for _a, i, t in lines)


# ---- the primitive catalog: (name, raw lines, leaders, what we EXPECT to recover) ----
def _L(*rows):
    return [(a, 0, t) for a, t in rows]


PRIMS = {}


def prim(name, expect):
    def reg(fn):
        PRIMS[name] = (fn(), expect)
        return fn
    return reg


@prim("nested_if3", "if(a){ x; if(b){ y; if(c){ z } } } w")
def _nested_if3():
    return (_L(
        (0x00, "if (!(a())) goto L_0030;"),
        (0x02, "x();"),
        (0x04, "if (!(b())) goto L_0030;"),
        (0x06, "y();"),
        (0x08, "if (!(c())) goto L_0030;"),
        (0x0A, "z();"),
        (0x30, "L_0030:"),
        (0x30, "w();"),
        (0x32, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x08, 0x0A, 0x30])


@prim("if_else", "if(a){ x } else { y } w")
def _if_else():
    return (_L(
        (0x00, "if (!(a())) goto L_0020;"),
        (0x02, "x();"),
        (0x04, "goto L_0030;"),
        (0x20, "L_0020:"),
        (0x20, "y();"),
        (0x30, "L_0030:"),
        (0x30, "w();"),
        (0x32, "return 0;"),
    ), [0x00, 0x02, 0x20, 0x30])


@prim("guard_chain", "if(!a){…}/early — SAME CFG as nested_if3 (which does the model pick?)")
def _guard_chain():
    # identical CFG to nested_if3 but the 'natural' read is a guard chain. Tests which the model emits.
    return (_L(
        (0x00, "if (!(a())) goto L_0030;"),
        (0x02, "x();"),
        (0x04, "if (!(b())) goto L_0030;"),
        (0x06, "y();"),
        (0x08, "if (!(c())) goto L_0030;"),
        (0x0A, "z();"),
        (0x30, "L_0030:"),
        (0x30, "w();"),
        (0x32, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x08, 0x0A, 0x30])


@prim("loop_cond_body", "while(p){ if(!a){body} incr }  (for-loop, conditional body)")
def _loop_cond_body():
    return (_L(
        (0x00, "if (!(p())) goto L_0020;"),
        (0x02, "if (a()) goto L_0010;"),
        (0x04, "body();"),
        (0x10, "L_0010:"),
        (0x10, "incr();"),
        (0x12, "goto L_0000;"),
        (0x20, "L_0020:"),
        (0x20, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x10, 0x20])


@prim("loop_break", "while(p){ if(a) break; body }")
def _loop_break():
    return (_L(
        (0x00, "if (!(p())) goto L_0020;"),
        (0x02, "if (a()) goto L_0020;"),
        (0x04, "body();"),
        (0x06, "goto L_0000;"),
        (0x20, "L_0020:"),
        (0x20, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x20])


@prim("loop_2guard", "while(p){ if(a) continue; if(b) break; body }  (continue + break share-ish)")
def _loop_2guard():
    return (_L(
        (0x00, "if (!(p())) goto L_0030;"),    # H -> body / exit
        (0x02, "if (a()) goto L_0000;"),        # guard a -> continue (header)
        (0x04, "if (b()) goto L_0030;"),        # guard b -> break (exit)
        (0x06, "body();"),
        (0x08, "goto L_0000;"),                 # loop back
        (0x30, "L_0030:"),
        (0x30, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x30])


@prim("tail_after_inner", "if(a){ x; if(b){y}; q() } w   (code AFTER the inner if)")
def _tail_after_inner():
    return (_L(
        (0x00, "if (!(a())) goto L_0030;"),     # A -> X / W
        (0x02, "x();"),                          # X
        (0x04, "if (!(b())) goto L_0020;"),     # B -> Y / Q  (inner merge is Q, not W!)
        (0x06, "y();"),                          # Y -> Q
        (0x20, "L_0020:"),
        (0x20, "q();"),                          # Q -> W
        (0x30, "L_0030:"),
        (0x30, "w();"),
        (0x32, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x20, 0x30])


@prim("two_seq_diamonds", "if(a){x}else{y}; if(b){p}else{q}; w   (two sequential if-elses)")
def _two_seq_diamonds():
    return (_L(
        (0x00, "if (!(a())) goto L_0010;"),
        (0x02, "x();"),
        (0x04, "goto L_0014;"),
        (0x10, "L_0010:"),
        (0x10, "y();"),
        (0x14, "L_0014:"),
        (0x14, "if (!(b())) goto L_0024;"),
        (0x16, "p();"),
        (0x18, "goto L_0030;"),
        (0x24, "L_0024:"),
        (0x24, "q();"),
        (0x30, "L_0030:"),
        (0x30, "w();"),
        (0x32, "return 0;"),
    ), [0x00, 0x02, 0x10, 0x14, 0x16, 0x24, 0x30])


@prim("loop_shared_incr", "while(p){ if(a)->I; if(b)->I; body; I:incr; loop }  ($9C22 shape: shared update block)")
def _loop_shared_incr():
    return (_L(
        (0x00, "if (!(p())) goto L_0020;"),     # H -> B1 / exit
        (0x02, "if (a()) goto L_0010;"),         # guard a -> shared incr I
        (0x04, "if (b()) goto L_0010;"),         # guard b -> shared incr I
        (0x06, "body();"),                       # body -> I (fall)
        (0x10, "L_0010:"),
        (0x10, "incr();"),                       # I: shared update block, ->H
        (0x12, "goto L_0000;"),
        (0x20, "L_0020:"),
        (0x20, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x10, 0x20])


@prim("loop_shared_break_tail", "while(p){ if(a)->R; body }; R: cleanup; return  ($9C22 break-to-shared-return)")
def _loop_shared_break_tail():
    return (_L(
        (0x00, "if (!(p())) goto L_0010;"),     # H -> body / R(exit)
        (0x02, "if (a()) goto L_0010;"),         # guard a -> break to shared tail R
        (0x04, "body();"),
        (0x06, "goto L_0000;"),
        (0x10, "L_0010:"),
        (0x10, "cleanup();"),                    # R: shared tail (multi-stmt), reached by break + exit
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x10])


@prim("c9c22_exact", "$9C22's exact CFG: outer-if + rotated loop (bottom test, entry-jump) + shared incr + break-to-return")
def _c9c22():
    return (_L(
        (0x9C27, "if (!(c0())) goto L_9C83;"),   # outer if; else return
        (0x9C31, "local10 = 0;"),                 # enter loop: jump to bottom test
        (0x9C33, "goto L_9C7A;"),
        (0x9C35, "if (c1()) goto L_9C78;"),       # body: guard -> shared incr
        (0x9C40, "if (c2()) goto L_9C78;"),
        (0x9C48, "if (c3()) goto L_9C78;"),
        (0x9C57, "body();"),                       # the real work when no guard fired
        (0x9C58, "goto L_9C83;"),                 # then break to return
        (0x9C78, "L_9C78:"),
        (0x9C78, "incr();"),                       # shared increment, falls to test
        (0x9C7A, "L_9C7A:"),
        (0x9C7A, "if (c4()) goto L_9C35;"),       # bottom test: continue to body / fall to exit
        (0x9C83, "L_9C83:"),
        (0x9C83, "return 0;"),
    ), [0x9C27, 0x9C31, 0x9C35, 0x9C40, 0x9C48, 0x9C57, 0x9C78, 0x9C7A, 0x9C83])


@prim("rotated_loop", "entry-jump rotated loop (bottom test), single exit")
def _rotated_loop():
    return (_L(
        (0x00, "goto L_0010;"),                  # entry jump to bottom test
        (0x02, "body();"),                       # body
        (0x04, "incr();"),
        (0x10, "L_0010:"),
        (0x10, "if (c()) goto L_0002;"),         # bottom test -> body / fall exit
        (0x12, "L_0012:"),
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x10, 0x12])


@prim("rotated_loop_break", "entry-jump rotated loop + a break, BOTH exits to the shared return")
def _rotated_loop_break():
    return (_L(
        (0x00, "goto L_0010;"),
        (0x02, "if (a()) goto L_0012;"),         # break to shared return
        (0x04, "body();"),
        (0x06, "incr();"),
        (0x10, "L_0010:"),
        (0x10, "if (c()) goto L_0002;"),         # bottom test -> body / fall exit (also L_0012)
        (0x12, "L_0012:"),
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x10, 0x12])


@prim("rotated_loop_sharedincr", "entry-jump rotated loop + shared incr block (guards -> incr)")
def _rotated_loop_sharedincr():
    return (_L(
        (0x00, "goto L_0010;"),
        (0x02, "if (a()) goto L_000A;"),         # guard -> shared incr
        (0x04, "if (b()) goto L_000A;"),         # guard -> shared incr
        (0x06, "body();"),
        (0x0A, "L_000A:"),
        (0x0A, "incr();"),                       # shared incr -> test (fall)
        (0x10, "L_0010:"),
        (0x10, "if (c()) goto L_0002;"),
        (0x12, "L_0012:"),
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x0A, 0x10, 0x12])


@prim("rot_incr_break", "rotated loop: guards->shared incr (continue) AND body->break, no outer if")
def _rot_incr_break():
    return (_L(
        (0x00, "goto L_0010;"),
        (0x02, "if (a()) goto L_000A;"),         # guard -> shared incr (continue)
        (0x04, "if (b()) goto L_000A;"),
        (0x06, "body();"),                       # body ...
        (0x08, "goto L_0012;"),                  # ... then break to shared return
        (0x0A, "L_000A:"),
        (0x0A, "incr();"),
        (0x10, "L_0010:"),
        (0x10, "if (c()) goto L_0002;"),
        (0x12, "L_0012:"),
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x0A, 0x10, 0x12])


@prim("rot_incr_break_outerif", "rot_incr_break wrapped in an outer if (merge == loop-exit == return)")
def _rot_incr_break_outerif():
    return (_L(
        (0x00, "if (!(c0())) goto L_0012;"),     # outer if; else return (same return as loop exit)
        (0x02, "if (a()) goto L_000A;"),
        (0x04, "if (b()) goto L_000A;"),
        (0x06, "body();"),
        (0x08, "goto L_0012;"),
        (0x0A, "L_000A:"),
        (0x0A, "incr();"),
        (0x10, "L_0010:"),
        (0x10, "if (c()) goto L_0002;"),
        (0x12, "L_0012:"),
        (0x12, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x0A, 0x10, 0x12])


@prim("loop_diamond_merge", "while loop, body = if-else diamond merging at a NON-terminal block that continues")
def _loop_diamond_merge():
    return (_L(
        (0x00, "if (!(p())) goto L_0030;"),     # H -> body / exit
        (0x02, "if (!(a())) goto L_0010;"),     # body: if(a){t}else{f}
        (0x04, "t();"),
        (0x06, "goto L_0014;"),
        (0x10, "L_0010:"),
        (0x10, "f();"),
        (0x14, "L_0014:"),
        (0x14, "m();"),                          # shared merge (2 preds), non-terminal -> loop back
        (0x16, "goto L_0000;"),
        (0x30, "L_0030:"),
        (0x30, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x10, 0x14, 0x30])


@prim("loop_chain_merge", "while loop, body = TWO chained shared merges (m1->if->m2), $9778's shape")
def _loop_chain_merge():
    return (_L(
        (0x00, "if (!(p())) goto L_0040;"),     # H -> body / exit
        (0x02, "if (!(a())) goto L_0010;"),     # if1: t/f -> m1
        (0x04, "t();"),
        (0x06, "goto L_0014;"),
        (0x10, "L_0010:"),
        (0x10, "f();"),
        (0x14, "L_0014:"),
        (0x14, "m1();"),                         # merge1 (2 preds) -> if2
        (0x16, "if (!(b())) goto L_0024;"),     # if2: u/v -> m2
        (0x18, "u();"),
        (0x1A, "goto L_0028;"),
        (0x24, "L_0024:"),
        (0x24, "v();"),
        (0x28, "L_0028:"),
        (0x28, "m2();"),                         # merge2 (2 preds) -> loop back
        (0x2A, "goto L_0000;"),
        (0x40, "L_0040:"),
        (0x40, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x10, 0x14, 0x16, 0x18, 0x24, 0x28, 0x40])


@prim("rot_loop_break_diamond", "rotated (entry-jump) loop + top break-guard + if-else diamond + merge ($9778-ish)")
def _rot_loop_break_diamond():
    return (_L(
        (0x00, "goto L_0030;"),                  # entry jump to bottom test
        (0x02, "if (e()) goto L_0040;"),         # body: break-guard at top
        (0x04, "if (!(a())) goto L_0010;"),      # if-else diamond
        (0x06, "t();"),
        (0x08, "goto L_0014;"),
        (0x10, "L_0010:"),
        (0x10, "f();"),
        (0x14, "L_0014:"),
        (0x14, "m();"),                          # merge -> falls to bottom test (loop back)
        (0x30, "L_0030:"),
        (0x30, "if (p()) goto L_0002;"),         # bottom test -> body / fall exit
        (0x40, "L_0040:"),
        (0x40, "return 0;"),
    ), [0x00, 0x02, 0x04, 0x06, 0x10, 0x14, 0x30, 0x40])


def main():
    names = [sys.argv[1]] if len(sys.argv) > 1 else list(PRIMS)
    for name in names:
        (lines, leaders), expect = PRIMS[name]
        out, ok, g = _structure_whole(lines, leaders)
        print(f"=== {name} ===")
        print(f"  expect : {expect}")
        print(f"  result : {'STRUCTURED' if ok else 'FLAT (no fold validated)'}  gotos={g}")
        print(_render(out))
        print()


if __name__ == "__main__":
    main()
