---
status: active
created: 2026-05-14
layout: default
title: "Chapter 9 \u2014 The Command System: How a Menu Pick Becomes a Formula"
---
# Chapter 9 — The Command System: How a Menu Pick Becomes a Formula

> Chapter 8 decoded the VM's instruction set and found that the economy lives in the bytecode banks. This chapter walks the bridge the project was built to cross: from a menu item the player selects, through the VM's calling convention, down into the arithmetic that actually mutates a province — and out the other side with the **hidden mechanics of a single command fully exposed.** The worked example is menu item 7, **Grow**. By the end we have its complete formula, the cost the UI never shows, the diminishing-returns curve, the silent precondition, and the cross-field redistribution — plus the structural tools (`$B9B2` command table, the calling convention, the province-access idiom) that make the *other* 33 commands a mechanical diff rather than 33 fresh investigations.

**Links:** [Chapter 8 — VM Instruction Set](./08-vm-instruction-set.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Appendix A — Formulas](./appendix-formulas.md) · [Appendix C — Opcodes](./appendix-vm-opcodes.md) · [Nobunaga README](./README.md)

## 1. Finding a command — the call-graph technique

Game logic is all bytecode, so a menu command lives somewhere in banks 0–14, not in any 6502 disassembly. The way in is to trace **one instruction**: `$EB7A`, the VM's universal indirect-call trampoline (`JMP ($0000)` — every `host_call` routes through it). One trace line per call, each showing its resolved target, turns an opaque execution log into a **call graph**. Picking in-game menu item 7 once, the command-fire burst reads `… $CC7B → $87F0 → $CBCD → $D6B8 → $D6DE → $D70D` — and `$87F0` is the handler, called via `host_call $87F0` from bank 1 next to `$9D3D` (the driver). That pair makes the whole menu legible.

## 2. The command driver table — `$B9B2`

There is **no master `switch`**. Each menu command is its own bytecode subroutine, and their entry points sit in a pointer table at bank 1 `$B9B2` — **34 entries**. Menu item N (as numbered in-game, 1-based) is table index **N−1**. This is confirmed, not inferred: the `$EB7A` trace was taken while picking in-game item **7**, and it landed on table index **6 = `$9D3D`**.

`command-table.py` walks the table, validates every entry is a real bytecode subroutine (each starts with the `20 23 E8` `JSR vm_entry` stub), and groups entries by their opening-byte signature. The grouping is the roadmap:

- **The "raise a province stat" family** — signature `A4 5F 6F 8B 1A B5 8C 01 70 BB …` — indices **4, 5, 6, 10, 12, 13, 14, 15** (idx 6 is Grow). Eight near-identical commands.
- **The display-command family** — signature `8E xx .. E9 26 D3 02` — indices **20–32**. Twelve commands, all "select a message, call `$D326`".
- **Ten unique commands** — indices 0,1,2,3,7,8,9,11,17,19 — the special actions (war, move, cede, search, and so on).

So 34 commands collapse to roughly **13 distinct decodes**, and once one member of a family is understood the rest are a diff. `command-table.txt` is the generated reference.

## 3. The VM calling convention — the Rosetta stone

Before any handler's *data flow* is readable, you have to know how arguments pass between VM subroutines. The answer is in `vm_entry` (`$E823`), and it is the single most useful structural fact in this chapter.

A bytecode subroutine begins with a 5-byte stub:

```
20 23 E8        JSR vm_entry
ff fc           frame offset (signed 16-bit; here −4)
<bytecode...>   the actual body, at stub+5
```

When `host_call` invokes that stub, `vm_entry` runs. Stripped to essentials:

```
vm_fp (frame pointer)  = vm_sp − 9          ; vm_sp = the VM data stack pointer
vm_sp (new data stack) = vm_fp + frame_offset
vm_ip (bytecode PC)    = stub + 5
```

The consequence is the key:

> **A caller's negative frame locals are the same physical memory as the callee's positive argument slots.**

Concretely — because `vm_call_native` pushes the return PC (`vm_sp −= 2`) and then `vm_entry` sets `vm_fp = vm_sp − 9`, the callee's `frame[+0x0B]` lands exactly on the caller's data-stack top, `frame[+0x0D]` on the next word down, and so on. A caller sets up a callee's arguments by **storing into its own low locals** (`storeX_local_neg`) right before the `host_call`; the callee reads them as `loadX_local_pos` (`$0C`–`$1F`). `host_call X, +N` then advances `vm_sp` by N to discard the args on return.

This is why the disassembler's `loadA_local_pos` / `storeA_local_neg` opcodes — which looked like dull register-file shuffling in chapter 8 — are actually the **argument-passing protocol**. Every `host_call` site is now readable as a function call with arguments.

## 4. The province-access idiom

A province record is **26 bytes**. The table the command handlers operate on is at SRAM **`$7001`**, and the currently-selected province's index is held in the variable **`$6F5F`**. The universal idiom for "get a pointer to the current province's record" is ten bytes:

```
A4 5F 6F     loadA_mem_word $6F5F      regA = selected province index
8B 1A        loadB_imm_byte 26         regB = 26  (record size)
B5           mul                       regA = index * 26
8C 01 70     loadB_imm_word $7001      regB = $7001  (table base)
BB           add                       regA = index*26 + $7001  -> record pointer
```

This exact sequence appears **81 times** across banks 0, 1, 2, and 15 — it is *the* province-access pattern, and recognizing it instantly orients you in any handler.

The `$7001` records are read **little-endian** (`loadA_ind_word` reads the low byte first). The 26-byte layout (anchored to a known Mikawa save; full save map in ch.7):

| byte | 0 | 2 | 4 | 6 | 8 | 10 | 12 | 14 | 16 | 18 | 20 | 22 | 24 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| field | gold | debt | town | rice | output | dams | loyalty | wealth | men | morale | skill | arms | **header** (base koku) |

The header (base koku) ceiling is the **last** field (+24). Two more variables the Grow handlers lean on: `$6D63` = **`const_two`, the skill-level / difficulty knob** (1–5, default 2, chosen at new-game — *not* a literal constant 2), and `$6F0B` = the daimyo turn-order permutation (17 elements, 0–16).

## 5. Grow, fully traced

Menu item 7 is two bytecode subroutines: a **driver** (`$9D3D`) that handles the player interaction and the cost, and an **effect** (`$87F0`) that computes the actual stat changes.

### 5a. The driver — `$9D3D`

```
record = $7001 + ($6F5F * 26)            ; pointer to the selected province

if  word[record + 24] >= word[record + 8]:         ; PRECONDITION A: header >= output
        show msg_we_re_at_our_limit ; return       ;   at the base-koku ceiling -> blocked

if  word[record + 0]  == 0:                        ; PRECONDITION B: gold == 0
        show msg_you_have_no_gold ; return         ;   no gold -> blocked

display the prompt screen (current output, record+8)
amount = number_input(word[record + 0], 1)         ; prompt, capped at the
                                                   ;   province's gold (record+0)
if amount == 0:  return                            ; silent cancel

word[record + 0] = word[record + 0] - amount       ; <-- THE COST (gold)
result = $87F0(record, amount)                     ; the effect (5b)
display the result ; redraw ; return
```

Two things the menu screen never states:

- **The cost is paid in gold from the province's own treasury** (`record+0`), and the input prompt is *capped* at that gold — you cannot Grow more than the province can afford.
- Two **silent preconditions** block it outright (output already at the base-koku ceiling, or gold == 0), each with only a flash of a message string.

### 5b. The effect — `$87F0`

`$87F0` receives `record` and `amount` (the gold spent) as arguments (via the calling convention of §3). It raises **output** (+8) by an emulator-verified amount, then pays for it out of two other stats:

```
if amount < 1:  return 0                                  ; guard

gain = 2 · ⌊ amount · (6 − skill) / √(output + amount) ⌋  ; $CBCD = integer sqrt;
                                                          ;   skill = const_two ($6D63)
gain = clamp(gain, 1 .. header − output)                  ; capped by base-koku headroom

pct  = ⌊ 100 · gain / (gain + output) ⌋ / 2               ; live drain %, ceiling 50
loyalty -= pct_op(loyalty, pct)                           ; $D70D = base·pct÷100
dams    -= pct_op(dams, pct)
output  += gain
```

`$CBCD` is the find that makes Grow make sense: an **integer square root** (the classic restoring algorithm, two bits per iteration over a 16-bit input). It sits in the *denominator* — `√(output + amount)` — which is what gives Grow its diminishing returns. `$D70D` is the **percentage operator** (`base × pct ÷ 100`, computed split-by-10 so the 16-bit product never overflows).

### 5c. The hidden mechanics of Grow

Everything the in-game UI does *not* tell you about pressing "Grow":

1. **It costs gold** from the province's own treasury (`gold`, +0). The prompt is capped at that gold; `gold == 0` blocks the command outright (precondition B).
2. **The benefit is `output gain = 2·⌊amount·(6−skill)/√(output+amount)⌋`** (emulator-verified). Grow raises **output** on a square-root curve in the gold spent, scaled by the global **`(6−skill)` difficulty multiplier** (`skill = const_two`). Doubling the gold yields ≈`1.41×` (the √); the skill dial swings the whole gain **~5.4×** — skill 1 → ×5 … skill 5 → ×1, *higher skill = slower economy* — and none of it shows in the UI. Many small Grows beat one large one. The gain is clamped to `header − output` (min 1).
3. **A development ceiling blocks it.** Precondition A refuses Grow when `header ≥ output` — base koku caps how far output can be pushed.
4. **Grow silently drains `loyalty` and `dams`.** The effect's tail runs the `$D70D` percentage operator on both and **subtracts** the results — raising output costs those two stats. The drain % is **live-computed** (`pct = ⌊100·gain/(gain+output)⌋ / 2`, ceiling 50), not a flat constant.

None of this is visible in the menu — exactly the class of opaque mechanic the project set out to surface, and the first concrete entry in the strategy counter-graph. `const_two` (the skill dial) is a pervasive anti-player knob beyond Grow: it also gates AI-only stat boosts, uprising magnitude `(skill+1)·10`, and combat casualties `rng(6−skill)`.

## 6. The extended instruction set — `$B7`

Walking Grow's helpers (`$D6B8`, `$D6DE`) surfaced a structural discovery worth recording. The opcode `$B7` is not an operation — it is an **extended-opcode prefix**. Its handler `$F246` reads the *next* byte as a sub-opcode index and dispatches through a **second ~47-entry handler table at `$F263`**. So `B7 xx` is a two-byte instruction selecting from an entire secondary instruction set, and that set holds the VM's **wide / 32-bit arithmetic** (the first extended handler, `$F2C1`, zeroes a four-byte accumulator and runs a 32-iteration loop). The helper subroutines that do precise multi-precision math are dense with `B7 xx`. The 47 extended opcodes — the VM's 32-bit math (add32/sub32, shifts, compares, moves) — are decoded in **[Appendix C](./appendix-vm-opcodes.md)**; the disassembler consumes the one sub-opcode byte to stay byte-aligned.

## 7. Staying byte-aligned

A mis-sized opcode silently drifts a disassembly until a branch happens to re-sync it — and menu drivers are branch-dense, so getting operand lengths exactly right matters. The canonical lengths (including the cases where a handler's *conditional* fetch fooled an early straight-line classifier — `$8A`/`$8C`, `$A4`–`$A6`, `$D6`–`$D8`, plus the `$B7` prefix above) are in **[Appendix C](./appendix-vm-opcodes.md)**. The disassembler follows control flow — it queues branch/jump targets and stops at `vm_return` — so it stays aligned through a whole subroutine and never decodes the bytes a branch jumps over.

## 8. Where this goes

The Grow family (indices 4/5/10/12/13/14/15, all sharing the `A4 5F 6F 8B 1A B5 …` template) and the display-command family (20–32) are now a mechanical diff against this walk — **chapters 10 and 11** decode the rest of the 21 lord commands that way. The native math primitives Grow leans on (`$CBCD` sqrt, `$D70D` pct_op, the `$B7` 32-bit extended set) recur throughout the harvest and combat code.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
