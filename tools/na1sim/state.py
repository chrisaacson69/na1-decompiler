"""
World state for na1sim.

Province / Daimyo / World dataclasses. The province stats and the offset
layout mirror the live SRAM record ($7001 + fief*26) documented in
appendix-formulas.md and 07-sram-save-layer.md. Marks (lm/wm/om/dm) are the
high-water marks the harvest reads; they re-seed from live records each Summer.
"""

from dataclasses import dataclass, field, replace
from typing import List, Optional


# AI-state codes (province_ai_state), per 12-daimyo-ai.md
AI_HOME = 0     # the AI's only real state — full subsidised cascade
AI_DIRECT = 5   # a human/player fief: one manual (policy) action per turn


@dataclass
class Daimyo:
    """A clan lord. Field order mirrors the ROM record ($752F, 7 bytes:
    age, Health, Drive, Luck, Charisma, IQ, status). Real values load from
    17Diamyo.txt; the PLAYER's lord is generated (90±15/stat, total>=450).

    Which stats matter where (per the decode):
      - Drive    : off-screen combat tiebreak (+10% morale to higher Drive) AND
                   the AI aggression gate (Drive>=50 ignores relations).
      - Charisma : harvest RNG ceiling (floor(charisma*tax/200)) + AI gold subsidy.
      - Luck/IQ  : espionage / events (not economy).
      - age/Health: illness & natural death.
    """
    id: int
    name: str
    owns: int               # province idx held at scenario start
    age: int
    health: int
    drive: int
    luck: int
    charisma: int
    iq: int
    status: int = 0
    alive: bool = True
    generated: bool = False  # True = player-rolled, not historical ROM

    # the 5 rollable "power" stats players reroll for (total>=450 target)
    @property
    def power_total(self) -> int:
        return self.health + self.drive + self.luck + self.charisma + self.iq

    def copy(self):
        return replace(self)


@dataclass
class Province:
    """One fief. Field names == appendix-formulas.md offsets.

    Combat inputs (men/morale/skill/arms) and economy inputs (gold..dams) are
    REAL from 17fief.txt. owner indexes into World.daimyos.
    """
    idx: int
    name: str
    header: int
    # economy (SRAM offsets gold+0 debt+2 town+4 rice+6 output+8 dams+10 loy+12 wealth+14)
    gold: int
    debt: int
    town: int
    rice: int
    output: int
    dams: int
    loyalty: int
    wealth: int
    # military (men+16, plus quality stats)
    men: int
    morale: int
    skill: int
    arms: int
    # high-water marks (seeded = live stats at game start / each Summer)
    lm: int
    wm: int
    om: int
    dm: int
    # control
    owner: int                       # daimyo id
    tax: int = 20
    ai_state: int = AI_HOME
    is_capital: bool = True          # every starting fief is its clan's seat
    neighbors: List[int] = field(default_factory=list)

    def copy(self):
        return replace(self)

    @property
    def provisioned_men(self) -> int:
        """A fief with no rice counts as 0 men for war-target selection
        (pick_weakest_men_fief, 12-daimyo-ai.md)."""
        return self.men if self.rice > 0 else 0

    def reseed_marks(self):
        """Summer re-seed: marks track from the live records (appendix §4)."""
        self.lm, self.wm, self.om, self.dm = self.loyalty, self.wealth, self.output, self.dams


@dataclass
class World:
    provinces: List[Province]
    daimyos: List[Daimyo]
    year: int = 1560
    season: int = 0                  # 0 spring,1 summer,2 fall,3 winter (per appendix)
    watch_battles: bool = False      # OFF -> AI wars use the off-screen resolver
    skill: int = 2                   # const_two difficulty (1 easiest..5 hardest);
                                     #   develop x(6-skill); AI recruit prob (skill+3)/10
    men_price: int = 5               # gold per recruited man (market rate ~5 -> ~15;
                                     #   ROM: men = gold_spent*10/hire_rate, rate stored x10)

    # ---- queries ----
    def fiefs_of(self, owner: int) -> List[Province]:
        return [p for p in self.provinces if p.owner == owner]

    def living_owners(self) -> List[int]:
        return sorted({p.owner for p in self.provinces})

    def is_eliminated(self, owner: int) -> bool:
        return not any(p.owner == owner for p in self.provinces)

    def neighbors_of(self, p: Province) -> List[Province]:
        return [self.provinces[n] for n in p.neighbors]

    def enemy_neighbors(self, p: Province) -> List[Province]:
        return [self.provinces[n] for n in p.neighbors
                if self.provinces[n].owner != p.owner]

    def copy(self) -> "World":
        return World(
            provinces=[p.copy() for p in self.provinces],
            daimyos=[d.copy() for d in self.daimyos],
            year=self.year, season=self.season, watch_battles=self.watch_battles,
            skill=self.skill, men_price=self.men_price,
        )
