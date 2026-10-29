---
status: active
created: 2026-05-13
---
# Chapter 5 — The Bytecode VM

> The orchestration question — "how does the boot sequence know to do `call_bank → audio_load_voice ×3 → audio_control ×3 → palette_swap`?" — has an answer at a higher level of abstraction than chapters 1-4 reached. The 6502 kernel in bank 15 is an operating system. The game itself is a **bytecode program in banks 0-14**, interpreted by a virtual machine at $E823. Game logic, boot sequence, AI, menus, combat — all of it is VM bytecode. The kernel just provides syscall services.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Chapter 3 — NMI Pipeline](./03-nmi-pipeline.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Nobunaga README](./README.md)

## The orchestration question

Chapter 4 cataloged *what* the kernel does — 23 syscalls — but not **who decides which to call, and in what order.** The boot trace fires task $07, then $09 ×3, then $0A ×3, then $12 — clearly conducted, never random. The conductor lives outside bank 15 (the kernel is just the orchestra): it is the **bytecode program** in bank 0, which begins as bytes "inconsistent with raw 6502" at $A778. This chapter is how that program — and the VM that runs it — works.

## The boot path

```
RESET ($C000) → ... → JMP $8000 (bank 0 entry)
                    → JMP $A778 (skip past data)
                    → JSR $E823 (enter VM with inline bytecode at $A77B onwards)
```

Bank 0 at $8000 contains exactly three bytes of code (`4C 78 A7` = `JMP $A778`) and then ~16 KB of data. At $A778 itself, three more bytes of code (`20 23 E8` = `JSR $E823`), then *also* data — but that data is the **bytecode program** that the VM at $E823 is about to interpret. Everything after the JSR is operands and opcodes for the VM, not native 6502 instructions.

## The VM entry point ($E823)

Called as `JSR vm_entry`, with inline bytecode following:

```asm
vm_entry:                           ; $E823
    ; --- Pull 4 bytes off the stack ---
    pla / sta $08                   ; $08 = low byte of caller's return-1 (= byte before next operand)
    pla / sta $09                   ; $09 = high byte
    pla / sta scratch_ptr_lo               ; scratch_ptr = previous-context pointer (from the stack)
    pla / sta scratch_ptr_hi

    ; --- Allocate a new VM frame ---
    ldy #$07
    lda vm_sp_lo / sbc #$09 / sta $0c   ; $0c/$0d = vm_sp - 9
    lda vm_sp_hi / sbc #$00 / sta $0d
.save: lda (scratch_ptr_lo),y / sta ($0c),y / dey / bpl .save
                                       ; copy 8 bytes from previous context to the new frame slot

    ldy #$01
    lda $0c / clc / adc ($08),y / sta vm_sp_lo    ; vm_sp = $0c + 16-bit inline operand after JSR
    iny / lda $0d / adc ($08),y / sta vm_sp_hi

    lda $08 / clc / adc #$03 / sta vm_ip_lo       ; vm_ip = $08 + 3 = bytecode IP (skips JSR target + 16-bit param)
    lda $09 / adc #$00 / sta vm_ip_hi

    jmp vm_dispatch                              ; → $E867
```

Two things to notice:

1. **The 4-PLA pattern is unusual.** JSR only pushed 2 bytes (the return address). The other 2 PLAs pull bytes placed on the stack by either the previous VM frame or the reset code — which deliberately boots with SP=$FD instead of $FF, seeding the sentinel slot the VM entry consumes here.

2. **vm_sp is the VM frame pointer.** Each VM call advances it backward by 9 bytes (saving 8 bytes of previous context + reserving 1 for the new frame). The advance/restore happens on every VM call/return — it's literally the VM's stack.

## The dispatch loop ($E867)

```asm
vm_dispatch:                                     ; $E867
    ldy #$00
    lda (vm_ip_lo),y                              ; fetch next bytecode byte
    inc vm_ip_lo / bne + / inc vm_ip_hi            ; advance IP
+:  tax
    lda vm_opcode_lo_table,x                     ; $F026
    sta scratch_ptr_lo
    lda vm_opcode_hi_table,x                     ; $F126 (indexed as offset 256 into the same table)
    sta scratch_ptr_hi
    jmp (scratch_ptr_lo)                                ; → opcode handler
```

Two 256-byte tables hold the handler addresses. The 16-bit handler for opcode `op` lives at `($F126[op] << 8) | $F026[op]`. Handlers do their work and either fall back to `jmp vm_dispatch` (for the next opcode) or to a tail routine like `$EB9E` (which does extra stack adjustment before dispatching).

## The 256-entry opcode table

The full table fits in 512 bytes immediately before `syscall_dispatch` at $F226. Reading the structure:

| Opcode range | Handler page | Pattern |
|---|---|---|
| $00–$0B | $E87F–$E8AB (4 bytes each) | 12 "load offset from vm_fp + immediate $E8/$EA/.../$FE" entries; one entry per immediate value |
| $0C–$26 | $E8xx | Various opcodes; mostly fetches/stores |
| $27–$66 | $E9xx | Branches, arithmetic |
| **$60–$6F** | **$EA18 (all 16 share)** | **Opcode-as-operand encoding — 16 opcodes route to the same handler with bits 0-3 of the opcode as a 4-bit immediate** |
| **$80–$8F** | **$E918 (all 16 share)** | Same pattern, different operation |
| **$A6–$B5** | $EAxx span | Many opcodes with overlapping handlers |
| **$E9** | **$EB38 — host_call_with_adjust** | Calls native code at the next 16-bit operand, with VM stack adjustment |
| **$AC** | **$EB4E — host_call_simple** | Calls native code at the next 16-bit operand, no adjustment |
| $F8–$FF | $EFxx | "Return" / end-of-frame opcodes |

The **opcode-as-operand clusters** ($60-$6F, $80-$8F, etc.) are the classic VM-design trick of encoding small constants directly in the opcode value. A `$63` instruction is "operation X with parameter 3"; only 4 bits of operand encoded, but the same byte triples as opcode dispatch + parameter.

## The host-call mechanism (opcode $E9)

This is the bridge between bytecode and kernel.

```asm
opcode_E9_host_call:                             ; $EB38
    jsr read_word_into_scratch_ptr                      ; $EFD5 — read 2-byte operand from bytecode → scratch_ptr
    jsr vm_call_native                           ; $EB57 — JSR through scratch_ptr (with VM stack save)
    ldy #$00
    jmp tail_with_vm_sp_adjust                    ; $EB9E — advance vm_sp, dispatch next opcode

read_word_into_scratch_ptr:                             ; $EFD5
    lda (vm_ip_lo),y / sta scratch_ptr_lo                ; (Y=0)
    iny / lda (vm_ip_lo),y / sta scratch_ptr_hi          ; (Y=1)
    dey / clc
    lda vm_ip_lo / adc #$02 / sta vm_ip_lo         ; vm_ip += 2 (consume the operand)
    bcc + / inc vm_ip_hi
+:  rts

vm_call_native:                                  ; $EB57 — the magic
    ; Save VM IP into VM stack (at vm_sp)
    sec / lda vm_sp_lo / sbc #$02 / sta vm_sp_lo
    bcs + / dec vm_sp_hi
+:  lda vm_ip_lo / sta (vm_sp_lo),y                ; save IP low
    iny / lda vm_ip_hi / sta (vm_sp_lo),y          ; save IP high

    jsr indirect_jmp_trampoline                  ; $EB6B — JSR through a data block
    ; → trampoline contains `6C 00 00` = JMP ($0000)
    ; → JMP indirect through $00/$01 = scratch_ptr
    ; → effectively a JSR to wherever scratch_ptr points
    ; native code runs and returns via RTS

    clc / lda vm_sp_lo / adc #$02 / sta vm_sp_lo   ; pop VM IP off VM stack
    bcc + / inc vm_sp_hi
+:  rts

indirect_jmp_trampoline:                         ; $EB7A
    .byte $6C, $00, $00                          ; `JMP ($0000)` — the indirect target is $00/$01 (scratch_ptr)
```

The `JSR through a data block holding JMP ($0000)` is the **6502-doesn't-have-indirect-JSR workaround**. The 6502 only has `JSR <absolute>` and `JMP (<indirect>)`, no `JSR (<indirect>)`. To call a function whose address is in a ZP pointer, you JSR to a place that does an indirect JMP. When the JMP'd-to function RTS's, it returns to the instruction after the original JSR. Three bytes of data become a one-instruction-equivalent indirect call.

## What the bytecode pattern `E9 26 F2 ...` does, decoded end-to-end

```
Bytecode: ... [prepared frame] ...  E9 26 F2  ...
```

1. **VM frame setup (earlier bytecode):** opcodes load the syscall task ID into `(vm_sp),Y=2` (= byte 2 of the current frame) and any required parameters into bytes 4, 6, 8, etc. of the same frame.
2. **`E9` opcode:** dispatches to `$EB38`.
3. **`$EB38`:** reads next 2 bytes (`26 F2`) as a 16-bit address → scratch_ptr = $F226 (`syscall_dispatch`).
4. **`vm_call_native`:** pushes the VM IP onto the VM stack, then "JSR through scratch_ptr" — control transfers to `syscall_dispatch` at $F226.
5. **`syscall_dispatch`:** copies bytes from `(vm_sp),Y=$17..$02` into $0050+. This is the chapter-4 22-byte param copy — but the source struct **is** the VM frame at vm_sp. Byte 2 of the frame (the task ID we set in step 1) lands at $0050.
6. **`syscall_dispatch`** does PHP + JMP ($FFFE) → `irq_handler` → the syscall executes → RTS through the `$F23C` fixup.
7. Control returns through `vm_call_native`'s post-RTS cleanup, then to `$EB9E` which advances vm_sp and re-enters `vm_dispatch`.

So **the syscall struct never has to be built separately** — the VM frame *is* the syscall struct. The bytecode prepares it in place, fires the host-call opcode, gets results back through `$66/$67 → $08/$09` (chapter 4's calling convention), and continues.

## The VM frame registers — `vm_sp` and `vm_fp`

The VM keeps two frame registers in zero page, and together they explain why `$02/$03` does double duty in the asm above:

- **`vm_sp` ($02/$03) — the operand-stack pointer.** The operand stack and the call frame are the *same* downward-growing structure (a frame is a slice of the stack), so the one register does both the `-= 9` frame allocation and the `(vm_sp),Y` parameter reads. Reset-inits to `$05FF` (the stack base). A frame holds byte 2 = host-call task ID, bytes 4-$15 = parameters, bytes 0-1/$16-$17 = metadata.
- **`vm_fp` ($04/$05) — the frame-base pointer.** Locals and arguments are addressed as `vm_fp + signed offset` — what the decompiler renders as `local0..N` / `arg1..N`.

And the syscall struct **is** the live VM frame: when bytecode fires a host-call to `syscall_dispatch`, the kernel reads its 22-byte parameter block straight out of the frame at `vm_sp` (chapter 4's struct copy). The VM never builds a separate struct.

## The architecture — a bytecode VM, not native game code

The engine is two layers:

> Bytecode program in banks 0-14 (the compiled game logic) ↔ VM interpreter + kernel in bank 15

Banks 0-14 contain almost no native 6502 code. They hold VM bytecode, VM data, graphics data, and a small handful of native helpers (10-50 bytes, called from bytecode for tight inner loops). The "game" — the Sengoku simulation with daimyo AI, combat resolution, province management, save/load — is **all bytecode**.

This is structurally the same move as:
- **Infocom's Z-machine** (1979–) — Z-code for interactive fiction
- **SCUMM** (LucasArts, 1987–) — bytecode for adventures
- **Atari's mid-1970s "Crash" abstraction layer** — micro-coded high-level operations

For a 1989 NES cartridge it's sophisticated engineering: Koei authors strategy-game logic in a high-level form (presumably a VM-bytecode source whose tools we don't have) and reuses the kernel across titles. The 4 RTS placeholder slots in the syscall table (ch.4) fit exactly — one kernel template, different games filling the placeholders with their own primitives and shipping entirely different bytecode programs.

## The implications for game logic flow

The orchestration question — "how does boot know to do `call_bank → audio_load_voice ×3 → audio_control ×3 → palette_swap`?" — answers itself:

> Because the bytecode at $A77B (start of the VM program) **is** that sequence, expressed in VM opcodes. The boot script literally enumerates these operations.

The main game loop is also bytecode. The "92% of dispatch traffic is read_controller" finding from chapter 4 is not about the **engine's** CPU budget — it's about **the bytecode program's** structure: the menu-wait code is a tight bytecode loop that polls `syscall_read_controller` and branches on the result. When the player presses an input, the bytecode dispatches to a different sequence (a screen-transition routine, a menu item handler, an AI tick). No native 6502 logic runs the menu; bytecode does.

This is also why `jsr $F226` appears nowhere in the native disasm even though `syscall_dispatch` is called constantly: **the calls are bytecode — opcode $E9 followed by `26 F2` — not native JSR instructions.** The 6502 disassembler can't see them because they aren't 6502 instructions.

## Where this goes

Walking actual game execution needs a **VM bytecode disassembler** — read the 256-entry opcode table, decode each opcode's operand format, and walk the bytecode from $A77B into a VM-assembly listing. That's chapter 6, and the project carries it all the way through: `source/2-asm-vm/` is the VM disassembly of all six code banks, and `source/4-c/` is that bytecode decompiled to structured C (by DREAM). Every chapter past here — the boot script, the main loop, the daimyo AI, combat — reads *that* output, not native 6502. The VM model also transfers: any other Koei MMC1 title runs the same interpreter (the "generic kernel" of ch.4), so the disassembler is game-portable.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
