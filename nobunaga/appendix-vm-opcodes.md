---
status: active
---
# Appendix — The VM Opcode Reference (canonical)

> The authoritative 256-entry opcode table for the Sea-16 VM. **Generated** by `tools/gen-opcode-appendix.py` from `tools/na1dream/vm-opcodes-v2.toml` (pops/pushes/semantics) fused with `nobunaga_vm.OPCODE_INFO` (execution-validated mnemonic + operand byte-length). Do not hand-edit — edit a source and regenerate. Cited by [ch.6 (VM Disassembler)](./06-vm-disassembler.md) and [ch.8 (VM Instruction Set)](./08-vm-instruction-set.md).

**Legend.** *Operand* = inline bytes consumed after the opcode (`nibble` = the value is the opcode's low 4 bits, $00-$7F). *Stack* = `pops→pushes` on the descending word stack at `vm_sp`. *V* = ✓ when verified against the ROM/emulator. Registers: `regL`=$08, `regR`=$0C, frame base `vm_fp`=$04. Only **$80** and **$CE** are ILLEGAL; opcodes the table leaves undefined are trapped (never emitted by the compiler).


## Quick group ($00-$7F) — operand in the low nibble

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$00-$0F` | `LOADL_quick` | nibble | 0→0 | ✓ | regL = word at frame[fast(opcode)]; codes 0-B = locals 12..1, codes C-F = args 1..4 |
| `$10-$1F` | `LOADR_quick` | nibble | 0→0 | ✓ | regR = word at frame[fast(opcode)]; codes 0-B = locals 12..1, codes C-F = args 1..4 |
| `$20-$2F` | `STORE_quick` | nibble | 0→0 | ✓ | word at frame[fast(opcode)] = regL |
| `$30-$3F` | `PUSH_quick` | nibble | 0→1 | ✓ | push word at frame[fast(opcode)] |
| `$40-$4F` | `LOADL_qimm` | nibble | 0→0 | ✓ | regL = (opcode & 0x0F) — value 0..15 |
| `$50-$5F` | `LOADR_qimm` | nibble | 0→0 | ✓ | regR = (opcode & 0x0F) |
| `$60-$6F` | `PUSH_qimm` | nibble | 0→1 | ✓ | push (opcode & 0x0F) |
| `$70-$7F` | `ADD_qimm` | nibble | 0→0 | ✓ | regL += (opcode & 0x0F) |

## Near / far / immediate frame & stack ops

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$80` | `ILLEGAL` | — | — | · | — |
| `$81` | `LOADL_near` | 1 byte | 0→0 | ✓ | regL = word at frame[+signed_byte] |
| `$82` | `LOADL_far` | 2 bytes | — | · | regL = word at frame[+signed_word] |
| `$83` | `LOADR_near` | 1 byte | 0→0 | ✓ | regR = word at frame[+signed_byte] |
| `$84` | `LOADR_far` | 2 bytes | — | · | regR = word at frame[+signed_word] |
| `$85` | `STORE_near` | 1 byte | 0→0 | ✓ | word at frame[+signed_byte] = regL  (CONFIRMED: handler $EA61) |
| `$86` | `STORE_far` | 2 bytes | — | · | word at frame[+signed_word] = regL |
| `$87` | `PUSH_near` | 1 byte | 0→1 | ✓ | push word at frame[+signed_byte] |
| `$88` | `PUSH_far` | 2 bytes | — | · | push word at frame[+signed_word] |
| `$89` | `BYTE_LOADL_imm1` | 1 byte | 0→0 | ✓ | regL = sign-extended byte from bytecode |
| `$8A` | `LOADL_imm2` | 2 bytes | 0→0 | ✓ | regL = word from bytecode |
| `$8B` | `BYTE_LOADR_imm1` | 1 byte | 0→0 | ✓ | — |
| `$8C` | `LOADR_imm2` | 2 bytes | 0→0 | ✓ | regR = word from bytecode |
| `$8D` | `BYTE_PUSH_imm1` | 1 byte | 0→1 | ✓ | — |
| `$8E` | `PUSH_imm2` | 2 bytes | 0→1 | ✓ | push word from bytecode |
| `$8F` | `BYTE_ADD_imm1` | 1 byte | 0→0 | ✓ | regL += sign-extended byte |
| `$90` | `ADD_imm2` | 2 bytes | 0→0 | ✓ | regL += word from bytecode |
| `$91-$9F` | `(undefined)` | — | — | · | — |

## Absolute loads/stores, call, copy, unstack

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$A0` | `BYTE_LOADL_far` | 2 bytes | 0→0 | ✓ | regL = (byte at frame[+signed_word], zero-extended) |
| `$A1` | `BYTE_LOADR_far` | 2 bytes | — | · | — |
| `$A2` | `BYTE_STORE_far` | 2 bytes | 0→0 | ✓ | byte at frame[+signed_word] = regL low byte |
| `$A3` | `BYTE_PUSH_far` | 2 bytes | 0→1 | ✓ | — |
| `$A4` | `LOADL_abs` | 2 bytes | 0→0 | ✓ | regL = word at absolute address |
| `$A5` | `BYTE_LOADL_abs` | 2 bytes | 0→0 | ✓ | regL = (byte at absolute address, zero-extended) |
| `$A6` | `LOADR_abs` | 2 bytes | 0→0 | ✓ | regR = word at absolute address |
| `$A7` | `BYTE_LOADR_abs` | 2 bytes | — | · | — |
| `$A8` | `STORE_abs` | 2 bytes | 0→0 | ✓ | word at absolute address = regL  (THIS IS THE KEY ONE — old disasm called it loadA_mem_word, which was WRONG) |
| `$A9` | `BYTE_STORE_abs` | 2 bytes | 0→0 | ✓ | byte at absolute address = regL low byte |
| `$AA` | `PUSH_abs` | 2 bytes | 0→1 | ✓ | push word from absolute address |
| `$AB` | `BYTE_PUSH_abs` | 2 bytes | — | · | — |
| `$AC` | `CALL_abs` | 2 bytes | — | ✓ | Call subroutine at absolute address |
| `$AD` | `COPY_imm2` | 4 bytes | — | · | TBD - some 2-word immediate copy |
| `$AE` | `UNSTACK_imm1` | 1 byte | — | · | sp += byte |
| `$AF` | `UNSTACK_imm2` | 2 bytes | — | · | sp += word |

## Deref / arithmetic (the LONG $B7 prefix selects 32-bit ext-ops)

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$B0` | `DEREF` | — | 0→0 | ✓ | regL = word at [regL] |
| `$B1` | `POPSTORE` | — | 1→0 | ✓ | regR = pop; word at [regR] = regL |
| `$B2` | `NOP` | — | 0→0 | ✓ | no-op (no stack/reg effect, length 1) |
| `$B3` | `PUSHL` | — | 0→1 | ✓ | push regL |
| `$B4` | `POPR` | — | 1→0 | ✓ | regR = pop |
| `$B5` | `MULT` | — | 0→0 | ✓ | regL *= regR |
| `$B6` | `SDIV` | — | 0→0 | ✓ | regL = (signed) regL / regR |
| `$B7` | `LONG` | 1 byte | — | · | Prefix for 32-bit operations; next byte selects the 32-bit op (47 of them, see $B700-$B72F) |
| `$B8` | `UDIV` | — | 0→0 | ✓ | — |
| `$B9` | `SMOD` | — | 0→0 | ✓ | — |
| `$BA` | `UMOD` | — | 0→0 | ✓ | — |
| `$BB` | `ADD` | — | 0→0 | ✓ | regL += regR |
| `$BC` | `SUB` | — | 0→0 | ✓ | regL -= regR |
| `$BD` | `LSHIFT` | — | 0→0 | ✓ | regL <<= regR |
| `$BE` | `URSHIFT` | — | 0→0 | ✓ | regL = (unsigned) regL >> regR |
| `$BF` | `SRSHIFT` | — | 0→0 | ✓ | regL = (signed) regL >> regR |

## Comparisons, unary ops, RETURN

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$C0` | `CMPEQ` | — | 0→0 | ✓ | — |
| `$C1` | `CMPNE` | — | 0→0 | ✓ | — |
| `$C2` | `SCMPLT` | — | 0→0 | ✓ | — |
| `$C3` | `SCMPLE` | — | 0→0 | ✓ | — |
| `$C4` | `SCMPGT` | — | 0→0 | ✓ | — |
| `$C5` | `SCMPGE` | — | 0→0 | ✓ | — |
| `$C6` | `UCMPLT` | — | 0→0 | ✓ | — |
| `$C7` | `UCMPLE` | — | 0→0 | ✓ | — |
| `$C8` | `UCMPGT` | — | 0→0 | ✓ | — |
| `$C9` | `UCMPGE` | — | 0→0 | ✓ | — |
| `$CA` | `NOT` | — | — | · | — |
| `$CB` | `MINUS` | — | 0→0 | ✓ | regL = -regL |
| `$CC` | `COMPL` | — | — | · | regL = ~regL |
| `$CD` | `SWAP` | — | 0→0 | ✓ | — |
| `$CE` | `ILLEGAL` | — | — | · | — |
| `$CF` | `RETURN` | — | — | ✓ | VM subroutine return; restore caller IP/FP/SP from frame |

## Inc/dec/shift, switch, jumps, bitwise, call-ptr

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$D0` | `INC` | — | 0→0 | ✓ | — |
| `$D1` | `DEC` | — | 0→0 | ✓ | — |
| `$D2` | `LSHIFT1` | — | 0→0 | ✓ | regL <<= 1 |
| `$D3` | `BYTE_DEREF` | — | 0→0 | ✓ | regL = byte at [regL], zero-extended |
| `$D4` | `BYTE_POPSTORE` | — | 1→0 | ✓ | regR = pop; byte at [regR] = regL low byte  (this is what writes $6FF4/$6FF5) |
| `$D5` | `SWITCH_contig` | 6 (+table) | — | · | — |
| `$D6` | `JUMP_abs` | 2 bytes | 0→0 | ✓ | — |
| `$D7` | `JUMPT_abs` | 2 bytes | 0→0 | ✓ | If regL != 0: PC = abs |
| `$D8` | `JUMPF_abs` | 2 bytes | 0→0 | ✓ | If regL == 0: PC = abs |
| `$D9` | `SWITCH_noncontig` | variable | — | · | — |
| `$DA` | `AND` | — | 0→0 | ✓ | — |
| `$DB` | `OR` | — | 0→0 | ✓ | — |
| `$DC` | `XOR` | — | 0→0 | ✓ | — |
| `$DD` | `CALLPTR` | — | — | ✓ | — |
| `$DE` | `LEAL_far` | 2 bytes | 0→0 | ✓ | regL = address of frame[+signed_word] |
| `$DF` | `LEAR_far` | 2 bytes | — | · | — |

## Bitfields, relative jumps, calls (the host-call path)

| Opcode | Mnemonic | Operand | Stack | V | Description |
|---|---|---|---|:-:|---|
| `$E0` | `SLOADBF` | 1 byte | — | · | — |
| `$E1` | `ULOADBF` | 1 byte | — | · | — |
| `$E2` | `STOREBF` | 1 byte | — | · | — |
| `$E3` | `JUMP_back` | 1 byte | — | · | — |
| `$E4` | `JUMPT_back` | 1 byte | — | · | — |
| `$E5` | `JUMPF_back` | 1 byte | — | · | — |
| `$E6` | `JUMP_ahead` | 1 byte | — | · | — |
| `$E7` | `JUMPT_ahead` | 1 byte | — | · | — |
| `$E8` | `JUMPF_ahead` | 1 byte | — | · | — |
| `$E9` | `CALL_abs_imm1` | 3 bytes | — | ✓ | Call abs; sp -= byte after return (the 'host_call' pattern with adj byte) |
| `$EA` | `CALLPTR_imm1` | 1 byte | — | ✓ | — |
| `$EB-$FF` | `(undefined)` | — | — | · | — |

---
*256 opcodes · 193 verified against the ROM · 2 illegal ($80, $CE). Regenerate with `py -3 tools/gen-opcode-appendix.py`.*
