"""assets.py — emit one portrait PNG and one banner PNG per daimyo, per scenario.

The existing render tools already expose per-entity render functions; we just loop and
save individual files instead of the labelled anthology/banner sheets:

    render-portrait.py        render_preset_portrait(mapid, scale) -> 48x48 portrait
                              MAPID_17 maps a 17-fief daimyo idx to its mapid (50 = identity)
    render-daimyo-banners.py  banner_img(idx, scale) -> 24x8 crest
                              banner_index(daimyo, scenario) -> the crest source idx

Both legacy scripts load the ROM relative to the repo cwd, so we chdir to the nobunaga
root while importing/rendering them.

Output:
    assets/portraits/{17,50}/daimyo-NN.png   (NN = daimyo index, zero-padded)
    assets/banners/{17,50}/banner-NN.png
"""
from __future__ import annotations

import contextlib
import importlib.util
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent  # .../nobunaga
TOOLS = ROOT / "tools"

PORTRAIT_SCALE = 4   # 48px native -> 192px asset (integer, pixel-crisp)
BANNER_SCALE = 6     # 24x8 native -> 144x48 asset


@contextlib.contextmanager
def _in_root():
    """The legacy render tools resolve the ROM relative to cwd; run them from nobunaga/."""
    prev = os.getcwd()
    os.chdir(ROOT)
    try:
        yield
    finally:
        os.chdir(prev)


def _load_module(filename: str, modname: str):
    """Import a hyphenated tools/ script as a module (they aren't importable by name)."""
    spec = importlib.util.spec_from_file_location(modname, TOOLS / filename)
    mod = importlib.util.module_from_spec(spec)
    with _in_root():
        spec.loader.exec_module(mod)
    return mod


def emit_portraits(scenario: int, scale: int = PORTRAIT_SCALE) -> list[Path]:
    rp = _load_module("render-portrait.py", "na1_render_portrait")
    out_dir = ROOT / "assets" / "portraits" / str(scenario)
    out_dir.mkdir(parents=True, exist_ok=True)
    written = []
    with _in_root():
        for i in range(scenario):
            mapid = i if scenario == 50 else rp.MAPID_17[i]
            img = rp.render_preset_portrait(mapid, scale)
            out = out_dir / f"daimyo-{i:02d}.png"
            img.save(out)
            written.append(out)
    print(f"{scenario}-fief: {len(written)} portraits -> assets/portraits/{scenario}/")
    return written


def emit_banners(scenario: int, scale: int = BANNER_SCALE) -> list[Path]:
    rb = _load_module("render-daimyo-banners.py", "na1_render_banners")
    out_dir = ROOT / "assets" / "banners" / str(scenario)
    out_dir.mkdir(parents=True, exist_ok=True)
    written = []
    with _in_root():
        for i in range(scenario):
            idx = rb.banner_index(i, scenario)
            img = rb.banner_img(idx, scale)
            out = out_dir / f"banner-{i:02d}.png"
            img.save(out)
            written.append(out)
    print(f"{scenario}-fief: {len(written)} banners -> assets/banners/{scenario}/")
    return written


def emit_all():
    for sc in (17, 50):
        emit_portraits(sc)
        emit_banners(sc)


if __name__ == "__main__":
    emit_all()
