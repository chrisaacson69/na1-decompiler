# na1dream — architecture & where new code goes

**na1dream = the NA1 Dream Decompiler core.** The importable engine that turns
Nobunaga's Ambition (NES) bytecode into readable C, plus the gates that prove the C
is faithful. This file is the map — read it before adding a script so new code lands
in the right place instead of piling up flat in `tools/`.

## Layout

```
tools/
  na1dream/              # THE LIBRARY — importable engine (underscore module names)
    __init__.py
    nobunaga_vm.py       #   the VM/ROM model + label loading        (front-end input)
    cpu6502.py           #   the 6502 core nobunaga_vm runs on
    vm_disasm.py         #   bytecode -> VM-asm listing               (pipeline stage 1)
    vm_decompile.py      #   VM-asm -> per-block C + the structurer dispatch (stage 2)
    vm_cfg.py            #   bytecode/struct CFG + the equivalence relations (the gate core)
    vm_reduce.py         #   V2 region reducer  (the per-sub FALLBACK structurer)
    dream.py             #   DREAM structurer   (the PRIMARY structurer)        (stage 3)
    vm_stack_effect.py   #   the audited per-opcode data-stack model
    vm-opcodes-v2.toml   #   package-owned data: the opcode table
    cli/                 # COMMAND ENTRY POINTS — run via `python -m na1dream.cli.X`
      decompile_all.py   #   the canonical generator: bank_NN.c / .raw.c / _vm.asm
      decompile_merged.py#   the merged PRG-keyed all_banks view
    gates/               # THE SAFETY NET — run via `python -m na1dream.gates.X`
      cfg_gate.py        #   495-sub CFG equivalence gate (--dream / --v2)
      test_vm_cfg.py     #   the 114 soundness unit-suite
      stack_audit.py     #   per-opcode stack-effect audit vs the live handlers
  attic/                 # archaeology — one-off find/map/probe scripts, kept not maintained
  lua/                   # Mesen emulator scripts (a different runtime)
  *.py                   # active standalone tools (labels, call-index, xref, assemblers, renderers)
```

Data anchors: the ROM and `mesen-labels.toml` live at the project root (`nobunaga/`);
the opcode table ships inside the package. Modules find them with `__file__`-relative
paths, so commands work regardless of the current directory.

## How to run things

Run from the **`tools/` directory** so `na1dream` resolves as a top-level package:

```
cd nobunaga/tools
py -3 -m na1dream.cli.decompile_all            # regenerate the canonical C + asm oracles
py -3 -m na1dream.cli.decompile_all --basic    # the basic goto-form (bank_NN.raw.c)
py -3 -m na1dream.gates.cfg_gate --dream       # gate the canonical hybrid output (495/495)
py -3 -m na1dream.gates.test_vm_cfg            # the 114 soundness suite
py -3 -m na1dream.gates.stack_audit           # the stack-effect audit
py -3 -m na1dream.dream --emit 15 CA9C         # inspect DREAM's output for one sub
```

## Where does a NEW script go? (the decision)

Ask, in order:

1. **Will other modules `import` it?** → it's **library code** → `na1dream/` with an
   underscore name. If it's a structurer/analysis stage, wire it through
   `vm_decompile`'s dispatch; if it's shared data, ship the table beside it in the package.
2. **Is it a command that produces a committed artifact** (an oracle, a generated page)?
   → `na1dream/cli/`, runnable as `python -m na1dream.cli.<name>`. Anchor output paths
   off `__file__`, not the cwd.
3. **Does it prove something is correct** (CFG equivalence, a model audit, a unit suite)?
   → `na1dream/gates/`. A gate exits non-zero on failure and is safe to wire into CI.
4. **Is it a one-off investigation** (find an address, dump a table, probe a shape)?
   → top-level `tools/`. When it has served its purpose, move it to `tools/attic/`.
5. **Is it a Mesen/Lua emulator script?** → `tools/lua/`.

Rule of thumb: **importable ⇒ package + underscore name; one-shot ⇒ a script in `tools/`.**
The smell that something is misfiled: needing `importlib.spec_from_file_location` or a
`sys.path` hack to reach it — that means it should have been an importable package module.
The package is renameable (everything is gate-anchored): re-running the gates proves any
move preserved behavior, so refactors here are mechanical, not risky.
