# `attic/` — archaeology, kept for the record

One-off scripts that did their job during the reverse-engineering and decompiler
build and are no longer part of the pipeline: address hunts (`find-*`), table/asset
locators (`locate-*`, `map-*`, `cluster-*`), default-dumpers (`dump-*`), and the
`probe-*` diagnostics written while bringing up the V2/DREAM structurers.

They are **kept, not deleted** — they document how findings were reached and are
occasionally worth re-reading. They are **not maintained**: most predate the
`na1dream/` package boundary (2026-06-10) and import the engine by its old flat
names (`import vm_cfg`). To actually run one, update its imports to the package
form (`from na1dream import vm_cfg`) and run it from the `tools/` directory.

If you reach for one of these often enough that it earns its keep, promote it back
to `tools/` (or into `na1dream/` if it belongs in the library) — see
`../na1dream/ARCHITECTURE.md` for where new code goes.
