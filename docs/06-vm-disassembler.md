---
status: active
created: 2026-05-13
layout: default
title: "Chapter 6 \u2014 The VM Disassembler"
---
# Chapter 6 — The VM Disassembler

> Chapter 5 documented the VM architecturally. This chapter is the tool that reads its bytecode and renders it as a readable instruction listing. To a 6502 disassembler the bytecode in banks 0/1/2/10/14 is nonsense `hex` bytes; the VM disassembler turns it into `CALL_abs`, `LOADL_abs`, `PUSH_qimm`, with labels and operands resolved. Its output is `source/2-asm-vm/bank_NN_vm.asm` — the legible bytecode the rest of the project (and the C decompiler) reads. The canonical 256-opcode reference is **[appendix-vm-opcodes.md](./appendix-vm-opcodes.md)**.

**Links:** [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Appendix — VM Opcode Reference](./appendix-vm-opcodes.md) · [Nobunaga README](./README.md)

## What it produces

`na1dream.vm_disasm` walks a bank's bytecode one opcode at a time, resolves each opcode's handler and operand format, consumes the right number of bytes, and renders labels from the toml. The boot entry is a clean example:

```
; sub $A778   (frame_off=+0, body @ $A77D)
 >$A77D  AC A3 89        CALL_abs        $89A3 (init_new_game_state) {bytecode}
  $A780  61              PUSH_qimm       ; inline operand = 1
  $A781  E9 03 CA 02     CALL_abs_imm1   $CA03 (call_bank10_entry) {bytecode}, $02
```

disasm6 renders that same range as `hex ac a3 89 61 e9 03 ca 02` — undecodable, because these aren't 6502 instructions. The VM listing carries the opcode, the operand, the resolved target name, and whether the call enters bytecode or native code.

## How it works

1. **The dispatch table.** The 256 handler addresses live in two 256-byte tables in bank 15 — `vm_opcode_lo_table` ($F026) and `vm_opcode_hi_table` ($F126). Opcode `op`'s handler is `($F126[op] << 8) | $F026[op]` (ch.5).
2. **Operand format per opcode.** A handler that needs an inline operand calls a known fetch helper — `$EFD5` reads a 16-bit word, `$EF97` a signed byte, and so on — so the operand length is recovered by *which* helper (if any) a handler calls. The execution-validated per-opcode formats (length, pops, pushes) are the appendix; the disassembler reads them from `vm-opcodes-v2.toml` + `OPCODE_INFO`.
3. **Subroutine tiling.** Every bytecode subroutine begins with a 5-byte stub `20 23 E8 <frame:2>` — the `JSR $E823` (`vm_entry`) plus a 16-bit frame offset (ch.1/ch.5). Scanning a bank for `20 23 E8` yields every stub, and the stubs partition the bank: sub *i* spans `[body_i, stub_{i+1})`. That gives the walk a correct end for each sub, so a single mis-length doesn't desync the rest of the bank.
4. **Bytecode vs native targets.** For a `CALL_abs` / `CALL_abs_imm1` to address X, the disassembler peeks at X's first three bytes: `20 23 E8` ⇒ a bytecode subroutine (`{bytecode}`); anything else ⇒ native 6502 (`{native}`).

## Two call worlds, one annotation

The host-call opcodes (`$AC` = `CALL_abs`, `$E9` = `CALL_abs_imm1`, ch.5) are the bridge between bytecode and everything else, and the `{bytecode}`/`{native}` tag at each site tells you which world the call enters:

```
 $A77D  AC A3 89        CALL_abs        $89A3 (init_new_game_state) {bytecode}   ; re-enters the VM
 $87EB  E9 CD CB 02     CALL_abs_imm1   $CBCD (sqrt_int) {native}, $02           ; native kernel helper
```

- **`{bytecode}`** — a VM subroutine. This is the bulk of the game: command drivers, effects, the AI, combat. The call re-enters `vm_entry`, pushing a new VM frame.
- **`{native}`** — a bank-15 primitive: `sqrt_int`, `syscall_dispatch`, the 32-bit math and PPU helpers. A real `JSR` into 6502 code that `RTS`es back.

So the disassembler makes the bytecode↔native boundary visible at every call — the boundary ch.5 described as the VM's only escape hatch.

## The opcode reference

The canonical 256-opcode table — mnemonics, operand lengths, stack pops/pushes — is **[appendix-vm-opcodes.md](./appendix-vm-opcodes.md)**, generated from `vm-opcodes-v2.toml` and the execution-validated `OPCODE_INFO`. One structural note worth carrying here: opcodes `$80`/`$CE` are **illegal** and `$91-$9F`/`$EB-$FF` **undefined** — the dispatch table routes every invalid opcode to a single catch-all `BRK` trap, and the compiler never emits them. There is **no implicit-syscall opcode**: the only call/syscall path is `CALL_abs` / `CALL_abs_imm1` to a native address (e.g. `$F226 syscall_dispatch`), which squares with ch.4's "real BRK — unused."

## What this unlocks

With the bytecode legible, the pipeline carries it the rest of the way: `source/3-c-basic/` lowers it to direct goto-form C (the CFG-equivalence witness), and `source/4-c/` structures that into readable C (`if`/`while`/`switch`) via DREAM. Every chapter past here — the turn loop, the economy, the daimyo AI, combat — reads that C, not raw bytes. And the VM is game-portable: any Koei MMC1 title runs the same interpreter (the "generic kernel" of ch.4), so the disassembler transfers directly, with only the per-game opcode table changing.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
