"""build.py — orchestrate the per-fief / per-daimyo page build.

    py -3 -m wikipages.build            # full pipeline: assets + font + pages
    py -3 -m wikipages.build --pages    # pages only (assets/font already emitted)

Run from anywhere; paths resolve against the nobunaga root.
"""
from __future__ import annotations

import argparse

from . import assets, font, pages


def main():
    ap = argparse.ArgumentParser(description="Build NA1 per-fief / per-daimyo wiki pages.")
    ap.add_argument("--pages", action="store_true",
                    help="skip asset + font emission; rebuild HTML only")
    a = ap.parse_args()

    if not a.pages:
        print("[1/3] emitting per-daimyo portraits + banners ...")
        assets.emit_all()
        print("[2/3] building the in-game webfont ...")
        font.build_font()
    print("[3/3] rendering pages ..." if not a.pages else "rendering pages ...")
    pages.build_all()


if __name__ == "__main__":
    main()
