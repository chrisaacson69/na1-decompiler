---
status: active
created: 2026-05-14
layout: default
title: "Chapter 10 \u2014 The Command Families: Eight Handlers for the Price of One"
---
# Chapter 10 — The Command Families: Eight Handlers for the Price of One

> Chapter 9 traced one menu command — Grow — all the way down, building the scaffolding (the command driver table, the calling convention, the province-access idiom, a control-flow-following disassembler) along the way. This chapter spends that scaffolding. It diffs the seven handlers that the `$B9B2` table grouped with Grow and shows that the "family" splits cleanly into **two real templates** — and that within each, the commands are the *same code parameterized by a province field offset, a set of message IDs, and an effect handler.* Eight commands, decoded for roughly the cost of two.

**Links:** [Chapter 9 — Command System & Grow](./09-command-system-and-grow.md) · [Chapter 8 — VM Instruction Set](./08-vm-instruction-set.md) · [Appendix A — Formulas](./appendix-formulas.md) · [commands/](./commands/README.md) · [Nobunaga README](./README.md)

## The signature was too coarse

`command-table.py` grouped table indices **4, 5, 6, 10, 12, 13, 14, 15** together because they share an eight-byte opening signature. That signature, decoded, is just the province-access idiom from chapter 9 — `regA = word[$6F5F] × 26 + $7001`, "pointer to the selected province's record." *Every* command opens that way. So the eight-byte grouping is real but shallow: it means "operates on the current province," not "is the same command."

Disassembling all eight with the flow-following tool splits them on a sharper line: **does the handler call `$D5E9`** — the number-input prompt?

- **Prompt-and-apply** (`$D5E9` present): indices **4, 6, 12, 14**.
- **Immediate-action** (no `$D5E9`): indices **5, 10, 13, 15**.

That single fact — "does it ask the player for an amount" — is the genuine family boundary.

> All field names below use the **confirmed `$7001` layout** (ch.7 / ch.9): `gold@0 debt@2 town@4 rice@6 output@8 dams@10 loyalty@12 wealth@14 men@16 morale@18 skill@20 arms@22 header@24`, little-endian. Field *offsets* are read directly from the bytecode; the *names* are the verified mapping.

## Template A — prompt-and-apply (idx 4, 6, 12, 14)

These four are one piece of code. The driver skeleton, identical across all four:

```
record = $7001 + selectedProvince*26
precondition A : compare two record fields; on fail, show a message and return
precondition B : if word[record+24] (header) == 0, show a message and return
display the current value
amount = $D5E9(cap, 1)         ; number-input prompt, capped at a record field
if amount == 0: return         ; silent cancel
word[record+0] -= amount       ; deduct the cost from GOLD
result = <effect handler>(record, amount)
display result ; redraw ; return
```

And the effect skeleton (the same one Grow uses, ch.9 §5b) is equally fixed: `amount < 1` guard → `$CBCD` integer square root of `field + amount` (the divisor) → the **`(6−skill)` skill-level multiplier** (`word[$6D63]` = `const_two`, difficulty 1–5) → `$D6B8` 32-bit math → clamp against `header@24` → a **live-computed** drain pct (flat-50 ceiling) → `$D70D` percentage redistribution out of other fields. The verified develop gain is `2·⌊amount·(6−skill)/√(field+amount)⌋`.

What varies — the entire content of the diff (command names confirmed from the in-game menu, item N = table index N+1):

| idx | command | driver / effect | grows (√ target) | redistributes from | notes |
|---:|---|---|---|---|---|
| 6 | **Grow** | `$9D3D` / `$87F0` | **output** (`@8`) | dams (`@10`), loyalty (`@12`) | fully traced in ch 9 |
| 12 | **Build** | `$A858` / `$88A6` | **town** (`@4`) | wealth (`@14`) | effect also chains `$887D` |
| 4 | **Dam** | `$9B83` / `$87D8` + `$887D` | **output** (`@8`) + **debt** (`@2`) | — | two effect handlers — a two-field command |
| 14 | **Bribe** | `$AAB3` / `effect_bribe $8D4D` | *(not a develop command)* | — | Shares the *prompt* skeleton (asks for gold) but a different effect: `$8D4D` is **gold-for-spy peasant defection** — `peasants = loyalty − (⌊(30+rng%25)·(min(loyalty,√gold)+1)/100⌋+1)`. See [bribe.md](./commands/bribe.md). |

So the readable picture: **Grow develops agricultural output, Build develops the town (commerce), Dam touches output and debt** — three √-develop commands sharing one effect — while **Bribe** rides the same gold-prompt skeleton with an entirely different (peasant-defection) effect. The three develop commands each cost **gold** (debited from `gold@0`, the prompt capped at it), are gated by **`header == 0`** and a development-ceiling precondition, and carry the √-curve diminishing returns plus the silent cross-field drain — those are not Grow-specific quirks, they are *how this whole class of command works.*

That Bribe rides the same *prompt* skeleton as the develop commands is a small surprise: "bribe a target" is built as "ask for a gold amount, then run an effect" — the same front end, a different back end. The `$879F`/`$804C` helpers it shares with Pact (and War/View/Ninja) are the **generic province-target-select** routines — how *any* command picks a target province — not a diplomacy subsystem.

That is a strong result for the counter-graph: four menu options that look independent are one mechanic with four parameterizations, and they share a cost model (gold), a curve (√), and a hidden tax (redistribution).

## Template B — immediate-action (idx 5, 10, 13, 15)

These four never call `$D5E9` — they take no amount from the player. They read the province's current state and act directly. They are *not* a single parameterized template the way Group A is; they share the province-access opening and not much else. Characterized from their field-touch and call patterns (names confirmed from the menu):

| idx | command | driver | touches | calls | reading |
|---:|---|---|---|---|---|
| 5 | **Pact** | `driver_pact $9C4F` | relations matrix | `$879F $804C $CEC4 …` | diplomacy — pay gold to a rival for an alliance (`$879F`/`$804C` = the generic target-select helpers). |
| 10 | **Train** | `$A63C` | header (`@24`), skill (`@20`), men (`@16`) | `$CEC4` | trains troops — reads men/skill against a header-derived cap, raises skill |
| 13 | **Give** | `$AA24` | header, morale (`@18`), loyalty (`@12`), wealth (`@14`), town (`@4`) | `$A93A $A9D5 $A95E` | charity to the people — touches the most fields (loyalty/morale up); three bank-1 helpers |
| 15 | **Assign** | `$AD6C` | arms (`@22`), men (`@16`) | `effect_assign $AC11` | **interactive arms-allocation editor** — 5 unit-type rows; needs soldiers + a flat 30 gold ([assign.md](./commands/assign.md)). |

The names make these legible: **Pact** is diplomacy, **Train** raises skill against a cap, **Give** is the loyalty/morale charity command, **Assign** is the arms-allocation editor. None calls the shared `$D5E9` number prompt (Assign has its own per-row arms UI) — they read province state and act, rather than taking a single √-develop investment.

The immediate-action commands also lean on **byte-level** field access (`loadA_ind_byte`/`storeA_ind_byte`, opcodes `$D3`/`$D4`) where Group A used word access — they edit sub-fields or flags, not whole 16-bit stats.

## The full command menu

The 21 lord commands, in menu order: Move, War, Tax, Send, Dam, Pact, Grow, Marry, Trade, Hire, Train, View, Build, Give, Bribe, Assign, Rest, Map, Grant, Other (save), Pass. Item N = table index N−1 (item 7 = Grow = index 6, matching the trace), so the menu is indices 0–20; the remaining `$B9B2` entries (21–33) are sub-handlers, not top-level items.

So four menu options that look independent — Grow, Build, Dam (and Give's develop-like effect) — are one mechanic with several parameterizations, sharing a cost model (gold), a curve (√), and a hidden cross-field tax. Bribe and Assign borrow only the *front end* (the gold prompt / the target-select helpers), with their own effects.

## What's open

- **The display-command family** — `$B9B2` indices 20–32, the `8E xx / host_call $D326` group: status/info screens. Ch.11 sweeps the remaining commands.
- **The unique commands** — indices 0, 1, 2, 3, 7, 8, 9, 11, 17, 19 (War, Move, Cede, Search…), each its own decode but on the same convention/idiom.
- **The `$D5E9` number-prompt primitive** and Group B's per-command effects (`effect_assign`, Give's `$A93A/$A9D5/$A95E`, Train's cap math) — short follow-up walks.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
