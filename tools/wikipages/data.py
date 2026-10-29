"""data.py — load and join the decoded fief + daimyo stat tables.

Sources (whitespace-aligned tables in the repo root, one per scenario):
    {17fief.txt, 50Fief.txt}     fief economic/military stats
    {17Diamyo.txt, 50Diamyo.txt} the ruling daimyo's personal stats

At scenario start the two tables are index-aligned: daimyo i rules fief i, and the
daimyo's `owns_province` equals that fief's `name`. We join on the index and assert
the name match so a future re-extraction that reorders one table fails loudly rather
than silently mis-pairing a lord with a province.

    from wikipages.data import load_scenario, SCENARIOS
    sc = load_scenario(17)            # -> Scenario(scenario=17, entries=[Entry, ...])
    sc.entries[16].fief['gold']       # Owari's gold
    sc.entries[16].daimyo['clan']     # 'Oda'
"""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent  # repo .../nobunaga

SCENARIOS = (17, 50)

# Source filenames differ in capitalisation between scenarios (as extracted).
_FIEF_FILE = {17: "17fief.txt", 50: "50Fief.txt"}
_DAIMYO_FILE = {17: "17Diamyo.txt", 50: "50Diamyo.txt"}

# Numeric columns in each table (everything except idx + the one text column).
FIEF_STATS = ("header", "gold", "debt", "town", "rice", "output", "dams",
              "loyalty", "wealth", "men", "morale", "skill", "arms")
DAIMYO_STATS = ("age", "health", "drive", "luck", "charisma", "iq", "status")


def _parse_table(path: Path):
    """Parse a whitespace-aligned stat table into a list of column->value dicts.

    The header line names the columns; each data row splits on whitespace. The single
    text column (fief `name` / daimyo `clan` and `owns_province`) never contains spaces
    in either scenario (e.g. 'Yamashir', 'Awa(E)'), so a naive split is safe.
    """
    lines = [ln.rstrip("\n") for ln in path.read_text(encoding="utf-8").splitlines() if ln.strip()]
    header = lines[0].split()
    rows = []
    for ln in lines[1:]:
        cells = ln.split()
        if len(cells) != len(header):
            raise ValueError(f"{path.name}: row has {len(cells)} cells, header has "
                             f"{len(header)}: {ln!r}")
        row = {}
        for col, cell in zip(header, cells):
            row[col] = int(cell) if cell.lstrip("-").isdigit() else cell
        rows.append(row)
    return rows


@dataclass
class Entry:
    """One province and the daimyo who rules it at scenario start."""
    idx: int
    name: str          # fief name == daimyo.owns_province
    fief: dict         # the fief stat row
    daimyo: dict       # the daimyo stat row


@dataclass
class Scenario:
    scenario: int      # 17 or 50
    entries: list      # list[Entry], index-aligned with the game's fief order


def load_scenario(scenario: int) -> Scenario:
    if scenario not in SCENARIOS:
        raise ValueError(f"scenario must be one of {SCENARIOS}, got {scenario}")
    fiefs = _parse_table(ROOT / _FIEF_FILE[scenario])
    daimyo = _parse_table(ROOT / _DAIMYO_FILE[scenario])
    if len(fiefs) != len(daimyo) != scenario:
        raise ValueError(f"{scenario}-fief: {len(fiefs)} fiefs, {len(daimyo)} daimyo "
                         f"(expected {scenario} each)")
    entries = []
    for i, (f, d) in enumerate(zip(fiefs, daimyo)):
        if f["name"] != d["owns_province"]:
            raise ValueError(f"{scenario}-fief idx {i}: fief name {f['name']!r} != "
                             f"daimyo owns_province {d['owns_province']!r} — the tables "
                             f"are not index-aligned; join logic needs revisiting")
        entries.append(Entry(idx=i, name=f["name"], fief=f, daimyo=d))
    return Scenario(scenario=scenario, entries=entries)


def load_all():
    """{17: Scenario, 50: Scenario}."""
    return {sc: load_scenario(sc) for sc in SCENARIOS}


if __name__ == "__main__":
    for sc in SCENARIOS:
        s = load_scenario(sc)
        print(f"{sc}-fief: {len(s.entries)} entries joined OK")
        e = s.entries[-1]
        print(f"  last: #{e.idx} {e.name} ruled by {e.daimyo['clan']} "
              f"(cha {e.daimyo['charisma']}, gold {e.fief['gold']})")
