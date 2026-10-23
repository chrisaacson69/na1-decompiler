"""
native-call-index.py - who-calls-whom across the engine's native + bytecode code, plus true-orphan
detection. The backward half of the labeling walk: label a sub by behavior, then ask "who calls
this?" to recover its purpose.

Moved to emu-harness (its MIGRATION.md row H): this file is a thin CLI over
`emu_harness.vm.koei.nes.callgraph na1`. The one graph fuses what this tool fused, from the bytes
instead of listing text:
  1. native jsr / jmp     - the fixed bank's routines (native_floor's enumeration, plus the natives
                            only bytecode calls), walked by the shared 6502 descent
  2. bytecode CALL        - every code bank's decoded CALL_abs / CALL_abs_imm1
  3. roots                - the hardware vectors, the syscall ($C173, 23), VM opcode ($F026/$F126)
                            and ext-op ($F261) tables, and the command-driver table ($B9B2, 34)
                            from the [na1] profile
Named differences: a bytecode sub's bytes are no longer read as 6502 (the old text parse gave it
false jsr edges, e.g. format_string -> $81D4), a stub's own JSR vm_entry is not a call, and
"orphans" are routines (the old universe also held data and interior labels).

Commands (addr accepts C537 / 0xC537 / $C537, or bank:addr):
  callers <addr>        every inbound edge (call / jsr / jmp / bankcall) and root
  calls   <addr>        every outbound edge from the routine at <addr>
  orphans [--bank N]    routines with no caller and no root
  stats                 edge + coverage summary
"""
import sys

from emu_harness.vm.koei.nes import callgraph

if __name__ == "__main__":
    cmd, rest = (sys.argv[1], sys.argv[2:]) if len(sys.argv) > 1 else ("stats", [])
    flags = {"callers": ["--callers", *rest[:1]], "calls": ["--calls", *rest[:1]],
             "orphans": ["--orphans", *rest], "stats": ["--indegree"]}.get(cmd)
    if flags is None:
        sys.exit(__doc__)
    sys.exit(callgraph.main([sys.argv[0], "na1", *flags]))
