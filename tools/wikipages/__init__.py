"""wikipages — generate per-fief and per-daimyo wiki HTML pages for Nobunaga's Ambition.

A small package (not another flat tools/ script) per the tools-architecture-refactor goal:

    data.py    load + join the decoded fief/daimyo stat tables (both scenarios)
    assets.py  emit one portrait PNG and one banner PNG per daimyo
    font.py    extract the in-game CHR font as a scalable web @font-face
    pages.py   render one HTML page per fief and per daimyo
    build.py   CLI orchestrator

The visual template mirrors the in-game fief/daimyo status screen; final styling is
calibrated against gameplay screenshots (see the wiki-fief-pages-plan).
"""
