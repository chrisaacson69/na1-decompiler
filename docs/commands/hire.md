---
status: active
created: 2026-05-25
command: Hire
menu_index: 10
driver: $A5F4
effect: $A2D2
---
# 10. Hire — Recruit Men or Ninja

> Two sub-modes via the `(Men/Ninja)?` prompt routed through `ui_helper_d351`. Chapter 11: "thin driver — substance is in the callee."

**Links:** [commands README](./README.md) · [Chapter 11](../11-strategic-engine-complete.md) · disasm/bank_01_vm.asm (driver $A5F4, effect $A2D2)

## What we expect

- `gold −= cost` (per-recruit rate)
- `men += amount` recruited (Men mode)
- OR some "ninja" stat field += (Ninja mode) — possibly a hidden field, or arms?

## Test runs

### Test 1 (COMPOUND with Train — see [train.md](./train.md))

Tokugawa did Hire AND Train in the same Summer turn. Hire-attributable signals from the diff:
- `gold: 77 → 3 (−74)` and `men: 32 → 41 (+9)` → **≈ 8.2 gold per man** recruited
- Other field drift (morale −8, arms −6) is shared with Train; can't fully separate from this test alone.

For clean per-man-cost confirmation, do a Hire-only turn next time.

### Test 1 ORIGINAL (PLANNED — superseded by compound)

**Context**: Post-combat with Oda. Need to rebuild army from 32 men. Have 77 gold.

PRE captured as `traces/hire-men-summer_PRE.dmp`.

**Snap protocol** (start-of-next-fief-turn convention):
```
(in-game: Hire → Men → enter amount → confirm)
(after Tokugawa Summer turn ends, snap at start of next fief's turn)
py capture-test.py hire-men-summer post
py capture-test.py hire-men-summer diff --fief 8
```

**Recording**:

| value | pre | post | Δ | notes |
|---|---:|---:|---:|---|
| gold | 77 | | | cost field |
| men | 32 | | | target field |
| morale | 71 | | | watch (could rise from "fresh recruits" or fall from green troops) |
| arms | 73 | | | watch (each recruit may bring arms) |
| skill | 74 | | | watch (averaging effect?) |
| rice | 67 | | | watch |
| (others) | | | | sanity 0s expected |

### Test 2 (planned): Hire Ninja

Different sub-mode. The "ninja" stat may not be visible in the 26-byte province record — could live elsewhere (daimyo table at $752F?). Watch for changes outside the province record too.

## Open questions

- ~~**Per-man cost** — does it scale with anything (current men, output, header)? Or flat-rate?~~ **Resolved 2026-11-09** → flat per purchase at the period's market rate (`roll_period_market_rates` $924A: 70% of `((year − 1560)/2 + 2) × 10 + rng(51)`, in tenths of a gold), costing `(rate × amount + 9)/10`, and each purchase nudges the rate up 1 (`effect_hire_men` $A553, `cycle_economy_rate`); see [synthesis-frontier #38](../synthesis-frontier.md), The market.
- ~~**Does Hire raise morale?** — fresh recruits' morale could average down the current force's morale, or be neutral.~~ **Resolved 2026-11-09** → it blends: recruits arrive at morale `rng(20) + 40`, skill `rng(20) + 60`, arms `rng(10) + 50`, weighted by headcount against the fief's own (`apply_hire_unit_stats` $8BF4 → `scaled_force_transfer` $DA1F). So Hire raises morale below about 40 and lowers it above about 59; Hatakeyama's full opening hire takes morale 23 to about 30-33 ([synthesis-frontier #40](../synthesis-frontier.md)).
- **Where does Ninja count live?** Province record has no obvious "ninja" field. Likely in daimyo table or a separate SRAM region.
- ~~**Does the in-game "How many"** prompt cap at `gold / per_man_cost`? (Same pattern as Grow's cap-at-gold.)~~ **Resolved 2026-11-09** → yes, and at the header: `most = ratio_times10_capped(gold, rate, header − men)` (`effect_hire_men` $A553).
