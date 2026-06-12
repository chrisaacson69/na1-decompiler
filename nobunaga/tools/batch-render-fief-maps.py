#!/usr/bin/env python3
"""Batch-render every fief's tactical map (17-fief and 50-fief scenarios) to
gitignored, canonical, per-scenario folders.

  assets/maps/fiefs/17/fief-NN.png   (provinces 0..16)
  assets/maps/fiefs/50/fief-NN.png   (provinces 0..49)

Each image is the true full-color combat map from the decoded ROM path
(render-fief-truecolor.render): map_populate nametable + real CHR ($9F6E) +
combat palette ($B55A), in the 11x5 staggered layout.

The 4 combat sub-palettes are TERRAIN sub-palettes (NES attribute table picks
one per cell), not seasons. Until the per-cell attribute table is wired in,
--sub None renders all 4 stacked (diagnostic); --sub N renders a single one.

Usage:  py batch-render-fief-maps.py [--scenario 17|50|all] [--sub 0..3]
"""
import sys, importlib.util, argparse
from pathlib import Path

HERE = Path(__file__).parent
_spec = importlib.util.spec_from_file_location("rftc", HERE / "render-fief-truecolor.py")
rftc = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(rftc)

OUT_ROOT = HERE.parent / "assets" / "maps" / "fiefs"
COUNTS = {17: 17, 50: 50}

def run(scenario, sub):
    out_dir = OUT_ROOT / str(scenario)
    out_dir.mkdir(parents=True, exist_ok=True)
    ok = 0
    for province in range(COUNTS[scenario]):
        try:
            rftc.render(province, scenario, sub=sub,
                        out_path=str(out_dir / f"fief-{province:02d}.png"))
            ok += 1
        except Exception as e:
            print(f"  !! province {province} ({scenario}-fief): {e}")
    print(f"[{scenario}-fief] rendered {ok}/{COUNTS[scenario]} -> {out_dir}")

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenario", default="all", choices=["17", "50", "all"])
    ap.add_argument("--sub", type=int, default=None)
    a = ap.parse_args()
    scenarios = [17, 50] if a.scenario == "all" else [int(a.scenario)]
    for s in scenarios:
        run(s, a.sub)
