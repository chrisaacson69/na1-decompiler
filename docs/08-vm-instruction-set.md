---
status: active
created: 2026-05-14
layout: default
title: "Chapter 8 \u2014 The VM Instruction Set: Arithmetic, Control Flow, and the 9999 Cap"
---
# Chapter 8 — The VM Instruction Set: Arithmetic, Control Flow, and the 9999 Cap

> Chapter 6 gave every one of the 256 opcodes a correct operand *length* — enough to walk bytecode without losing byte-alignment — but ~140 of them still had no *meaning*. This chapter hand-decodes the core of the instruction set: the register-file load/store matrix, the full ALU (add, sub, multiply, divide, modulo, shifts, bitwise, compares), and control flow. With those decoded, VM bytecode stops being a byte-aligned mystery and starts reading like source. The chapter ends by following that capability straight into the first real game mechanic: the value-clamp routine that caps resources at **9999** — the "big number" that kept surfacing in earlier sessions.

> The descriptive opcode mnemonics here (`add`, `mul`, `cmp_sgt`, `host_call`, `loadA_local_neg`…) are the readable forms; the canonical names, lengths, and stack effects are in **[Appendix C — the opcode reference](./appendix-vm-opcodes.md)** (`add`→`ADD`, `mul`→`MULT`, `cmp_sgt`→`SCMPGT`, `host_call`→`CALL_abs_imm1`, `loadA_imm_word`→`LOADL_imm2`, …). The two working registers `regA`/`regB` are the appendix's **`regL` ($08) / `regR` ($0C)**.

**Links:** [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Appendix C — Opcode Reference](./appendix-vm-opcodes.md) · [Nobunaga README](./README.md)

## The VM is a register machine

Chapter 5 called the VM "stack-based." That was half right. It *has* a data stack (`vm_sp`), but the bulk of the work happens in **two 16-bit working registers** plus a frame-relative local array. The decoded picture:

| Zero-page | Role |
|---|---|
| `$08/$09` | **regA** (= `regL`) — primary 16-bit accumulator |
| `$0C/$0D` | **regB** (= `regR`) — secondary 16-bit operand register |
| `$04/$05` | **`vm_fp`** — frame pointer; base of the current subroutine's local array |
| `$06/$07` | **`vm_ip`** — program counter; points at the next bytecode byte |
| `$02/$03` | **`vm_sp`** — data stack pointer; grows downward, spills regA across calls |
| `$00/$01` | **`scratch_ptr`** — target of indirect loads/stores and native calls |

Almost every opcode is "do something to regA, optionally using regB." Binary operators are uniformly `regA = regA OP regB`. This is why the bytecode is so dense: there are no register names to encode — the operands are implicit.

## The $00–$3F frame-local load/store matrix

The first 64 opcodes are a single, beautifully regular structure: **four 16-opcode rows** — `LOADL_quick` ($00, regL←frame), `LOADR_quick` ($10, regR←frame), `STORE_quick` ($20, frame←regL), `PUSH_quick` ($30, **push** frame→stack) — each split into a negative-offset block (caller args / outer locals) and a positive-offset block (args 1–4).

| Opcodes | Operation (canonical) | Addresses |
|---|---|---|
| `$00–$0B` | `LOADL_quick` — regL = frame local | frame[−24 .. −2] (12 slots) |
| `$0C–$0F` | `LOADL_quick` — regL = arg | frame[+0x0B/+0x0D/+0x0F/+0x11] (args 1–4) |
| `$10–$1B` | `LOADR_quick` — regR = frame local | frame[−24 .. −2] |
| `$1C–$1F` | `LOADR_quick` — regR = arg | frame[+0x0B .. +0x11] |
| `$20–$2B` | `STORE_quick` — frame local = regL | frame[−24 .. −2] |
| `$2C–$2F` | `STORE_quick` — arg = regL | frame[+0x0B .. +0x11] |
| `$30–$3B` | `PUSH_quick` — **push** frame local → stack | frame[−24 .. −2] |
| `$3C–$3F` | `PUSH_quick` — **push** arg → stack | frame[+0x0B .. +0x11] |

The negative offsets reach the caller's arguments and outer locals; the positive offsets are the current frame's own scratch. The handlers are tiny `LDY #imm / LDA (vm_fp),Y` stubs sharing a common tail. In disassembly these read as `loadA_local_neg #11`, `push_local_pos #1`, and so on — the bytecode's variable accesses are legible.

## The ALU ($B0–$DC)

This is the heart of the chapter. The arithmetic and logic opcodes are all no-operand; they consume regA and regB and leave the result in regA.

### Arithmetic

| Opcode | Name | Operation |
|---|---|---|
| `$BB` | `add` | regA = regA + regB |
| `$BC` | `sub` | regA = regA − regB |
| `$B5` | `mul` | regA = regA × regB (16-bit shift-add) |
| `$B6` | `div_signed` | regA = regA ÷ regB (signed) |
| `$B8` | `div_unsigned` | regA = regA ÷ regB (unsigned) |
| `$B9` | `mod_signed` | regA = regA mod regB (signed) |
| `$BA` | `mod_unsigned` | regA = regA mod regB (unsigned) |
| `$D0` / `$D1` | `incA` / `decA` | regA ± 1 |
| `$D2` | `aslA` | regA <<= 1 |
| `$8F` | `addA_imm_sbyte` | regA += sign-extended byte literal |
| `$71–$7F` | `addA_imm4` | regA += (opcode & 0x0F) |

The multiply at `$B5` ($ECF0) is a classic 16-bit shift-and-add loop. The divides at `$ED2E` are a restoring shift-subtract: quotient accumulates in regA, remainder in scratch_ptr — `$B8`/`$BA` simply choose which one to keep. The signed variants (`$B6`, `$B9`) wrap the unsigned core in a sign-extraction prologue (`$ED7A`) that records the result sign in `$0A`/`$0B` and negates at the end.

**This is the find that unlocks the economy.** A "fall harvest = f(town, rice, output, dams)" formula is, at the bytecode level, exactly a sequence of `loadA_local / loadB_local / mul / add / div` operations. Until this chapter those bytes were `op_BX_DX (auto-classified)`; now they are arithmetic.

### Bitwise and compares

| Opcode | Name | Operation |
|---|---|---|
| `$DA` / `$DB` / `$DC` | `bitand` / `bitor` / `bitxor` | regA = regA OP regB |
| `$CC` | `bitnot` | regA = ~regA |
| `$BD` / `$BE` / `$BF` | `shl_by_regB` / `lshr_by_regB` / `ashr_by_regB` | barrel shifts by regB count |
| `$C0`–`$C9` | `cmp_*` | signed/unsigned compares — **leave a 0/1 boolean in regA** |
| `$CA` | `is_zero` | regA = (regA == 0) |
| `$CD` | `swap_AB` | regA ↔ regB |

The compares are the key control-flow primitive. `cmp_sgt` ($C4) computes `regA = (regA > regB) ? 1 : 0`. The result is a clean boolean, designed to be consumed immediately by a conditional branch.

## Control flow ($D8, $E3–$EA, $CF)

| Opcode | Name | Operation |
|---|---|---|
| `$E3` / `$E6` | `jump_rel` | vm_ip += signed byte (unconditional) |
| `$E4` / `$E7` | `branch_nz_rel` | if regA ≠ 0: vm_ip += signed byte |
| `$E5` / `$E8` | `branch_z_rel` | if regA == 0: vm_ip += signed byte |
| `$D8` | `JUMPF_abs` | if regA == 0: PC = abs (2-byte **absolute** target) — the dominant conditional branch (the relative branch forms are $E3–$E8) |
| `$D5` | `switch` | jump-table dispatch on regA over inline (value,target) pairs |
| `$E9` / `$AC` | `host_call` / `host_call_simple` | call native code or a bytecode subroutine |
| `$DD` / `$EA` | `host_call_indirect*` | call through an address held in regA |
| `$CF` | `vm_return` | restore the caller's frame and `JMP (scratch_ptr)` — subroutine return |

The idiom is **compare-then-branch**: a `cmp_*` opcode sets regA to 0/1, and the very next opcode is `branch_z` ($D8) or `branch_nz` ($E4). `if (x > 9999) goto clamp` compiles to exactly three opcodes: `loadB_imm_word 9999 / cmp_sgt / branch_z`.

`vm_return` ($CF) at `$EF75` copies 8 bytes of saved frame state back from `frame[0..7]` and does an indirect jump — confirming chapter 5's model that each `host_call` into a bytecode subroutine pushes a frame whose first 8 bytes are the saved caller context.

## The 9999 cap — the "big number," confirmed

Earlier sessions kept hitting a recurring large constant. Scanning the full 256 KB ROM for `0F 27` (= 9999 little-endian) returns **exactly 17 occurrences**:

- **2** are bank-3 table sentinels — the `0F 27` marker that sits immediately before each scenario's daimyo table (chapter 7).
- **2** are in bank 15 (the kernel).
- **13** are in the bytecode banks (0, 1, 2, 4, 7, 14), and every one of those follows the same shape: `loadB_imm_word 9999 / cmp_sgt / branch_z`, or `loadA_imm_word 9999 / storeA_ind_word`.

That is a **clamp-to-maximum**. 9999 is the ceiling for the game's large stats — gold and koku/rice stockpiles. Chris's intuition ("this is the max value stats can get") was correct, and the count lines up with a per-resource clamp applied across the resource-update routines rather than a single shared helper.

### A clamp routine, disassembled

Bank 1 at `$AB44` — a confirmed clamp site — now reads cleanly:

```
$AB44  loadA_local_neg #11      ; regA = local[11]            (a fief / record index)
$AB45  aslA                     ; regA *= 2                   (16-bit element stride)
$AB46  loadB_local_neg #13      ; regB = local[13]            (a table base)
$AB47  add                      ; regA = local[11]*2 + local[13]   -> element address
$AB48  loadA_ind_word           ; regA = word[that address]   (current value)
$AB49  loadB_imm_word 9999      ; regB = 9999
$AB4C  cmp_sgt                  ; regA = (value > 9999)
$AB4D  JUMPF_abs <skip>         ; if regA==0 (NOT over cap), jump past the clamp ($D8 = 2-byte absolute target)
$AB4F  ...                      ; (over cap:)
$AB50  loadA_local_neg #11      ; recompute the element address
$AB53  add
$AB54  pushA                    ; push address
$AB55  loadA_imm_word 9999      ; regA = 9999
$AB58  storeA_ind_word          ; word[address] = 9999        <- CLAMP
```

`address = base + index*2`, read the value, and if it exceeds 9999 write 9999 back. Bank 2 at `$9F18` is the same idea one step earlier in a pipeline — it reads `word[ptr+4]`, **adds `local[11]` to it**, and *then* runs the 9999 check. That `value + income, capped at 9999` is a resource-accumulation step: the shape of a harvest or tax credit.

In other words, the clamp sites are not isolated guards — they are the **tails of the economic update routines**. Finding the 9999 constant found the economy's address.

## What this unlocks

Three things are now true that were not before:

1. **The disassembler renders arithmetic.** With the operand formats grounded, `na1dream.vm_disasm` turns the `op_BX_DX` blanks into `mul`, `div_unsigned`, `add`, `cmp_sgt` — any bytecode region reads as operations.
2. **The economy's location is known.** The resource-update routines live around the bank-1/bank-2 clamp sites (`$AB40`-ish, `$9F10`-ish). The harvest, tax, and development handlers are reachable from there.
3. **The cap is a known quantity.** 9999 is the stockpile ceiling. The per-province stats (town, rice, output, dams, loyalty, etc.) are byte-or-small-word fields with their own lower ceilings — finding *those* clamps is the same scan with different constants, and is the natural next step.

## Where this goes

With the ALU decoded, an economic formula reads as its arithmetic opcodes and a cap reads as its compare-and-store — so the resource-update routines around the bank-1/bank-2 clamp sites become legible. The chapters that follow walk them as readable C: the command handlers (ch.9–11), the turn loop and the fall-harvest gold formula (ch.13), and the daimyo AI (ch.12). The remaining un-named opcodes and the per-stat ceilings (scan for `$0064`/`$03E7`/`$00FF` near `cmp_*`) are catalogued in **[Appendix C](./appendix-vm-opcodes.md)**.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
