# NA1 render-tool triage → the asset pipeline

> Classifying the ~24 render/asset scripts as **reusable** (a KOEI-engine primitive — belongs in
> `koei-nes`), **rerunnable** (made a deliverable, may be regenerated — stays game-layer but should call
> the generic renderer), or **legacy** (one-off probe/experiment — leave, just mark). The standing rule
> going forward: **game-layer tools import `nes-render` for the pixel work; nobody re-implements
> `decode_tile`/palette/nametable again.** (`⚠core` = currently carries its own tile-decode → migrate.)

## Reusable → port to `koei-nes` asset layer (locate planes from config → call `nes-render`)
| Tool | What | Note |
|---|---|---|
| `render-portrait.py` ⚠core | daimyo portrait base-5 composite | **first port** — most self-contained KOEI format; API stress-test |
| `run-animation.py` ⚠core | bank-14 animation-VM runner | the animation engine; cross-title KOEI |
| `render-strategic-map.py` ⚠core | illustrated strategic (Map-command) screen, 556L | metatile assembly — the richest KOEI format |
| `render-text.py` | text in the game font (decodes font inline) | the font→text primitive |
| `extract-chr-from-trace.py` | reconstruct CHR-RAM from a Mesen trace | asset-acquisition utility (feeds the renderer) |

## Rerunnable → keep game-layer, but convert to use `nes-render` if re-run/regenerated
| Tool | What |
|---|---|
| `render-fief-from-ppu.py` ⚠core | fief screen from a PPU dump (already consolidated 16 scripts) |
| `render-atlas.py` / `render-rom-atlas.py` / `render-rom-to-map.py` | 17/50-fief tactical maps from bank-4 cell data / ROM-direct |
| `batch-render-fief-maps.py` / `batch-render-anims.py` | batch wrappers over the above (deliverables) |
| `render-daimyo-banners.py` | daimyo crest/banner chart |
| `render-strategic-50.py` / `render-strategic-atlas.py` | 50-node geographic + 17-map composite variants |
| ~~`title-render.py`~~ | retired 2026-10-27: its input `nametable_bytes.txt` is gone ([RETIRED.md](RETIRED.md)) |

## Legacy → leave as-is, mark superseded (no re-run expected)
| Tool | Why |
|---|---|
| `render-iga-full.py` / `render-mino-full.py` | per-fief one-shots, superseded by `render-fief-from-ppu` / `render-atlas` |
| `render-fief-truecolor.py` | true-color experiment |
| `render-from-sram.py` | stylized metatile-box viz (not real CHR) — analysis, not an asset render |
| `viability-map.py` | invasion-viability analysis chart (not asset rendering) |
| `combat-map-decode.py` / ~~`title-nametable.py`~~ (retired) / `title-tiles-extract.py` | one-shot trace→nametable/tile reconstructions |

## Disposition summary
- **Migrate (5):** reusable primitives → `koei-nes/assets/` (config-locate planes → `nes-render`). Start with `render-portrait`.
- **Convert-on-touch (~9):** rerunnable game-layer tools — when next regenerated, drop the inline decode and import `nes-render`. No proactive rewrite of already-shipped output.
- **Mark legacy (~7):** leave; they're history, their deliverables exist.

The 3-layer target: per-title config → `koei-nes` (locate + KOEI formats) → `nes-render` (generic pixels).
