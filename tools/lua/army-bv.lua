-- army-bv.lua  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- On-demand readout, two sections:
--
--  (1) HEAD-TO-HEAD: for each of YOUR fiefs (province_ai_state != 0), compare it
--      against each adjacent fief you do NOT own — the engine's OWN relative stat
--      contest. You bank a stat's weight when your stat beats theirs (ties to the
--      defender). DIRECT compare (no 120 normalization), so stat-bumps past 120
--      are handled naturally. Answers "can I take this neighbour?" for real.
--      Same-owner neighbours are skipped (can't attack yourself) — a fief with no
--      foreign neighbours still prints its header, just with no targets listed.
--
--        per side: S = men * (FLOOR + 0.4 * Wself/100)   FLOOR = 2 (atk) / 3 (def,+home)
--        Wself = sum of weights of the stats that side WINS  (hp5 dr10 lk10 ch5 iq20 mor10 skl25 arm15)
--        p = S_atk*100/(S_atk+S_def)   -> p>50 means you're favoured (terrain is per-battle, excluded)
--      Plus an INVADE-RISK column: the engine's actual *attack decision* ($949A) is a MEN-COUNT
--      share, not this BV. An AI fief comes at YOU when its men-share vs you > 47 (~>0.89x your
--      men); "men-safe" = your men >= ~1.13x theirs. BV = who'd WIN; invade-risk = who'll COME.
--
--  (2) DAIMYO ECONOMY: every daimyo's fiefs, current gold/rice + the EXPECTED Fall
--      harvest gold/rice (the bytecode-certified §4 formula — appendix-formulas.md),
--      summed per daimyo. The harvest sums are each house's economic potential.
--
-- Press 'B' (or call report()).  Reads LIVE values + adjacency from ROM ($8300).
-- Output goes to the Mesen Script Window log; an on-screen toast confirms a refresh.
-- ============================================================================
local MT  = emu.memType.nesMemory
local PRG = emu.memType.nesPrgRom or emu.memType.prgRom
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a+1)*256 end
local function prg(o)  return PRG and emu.read(o, PRG) or 0xFF end

local PROV, DMY, OWNER, AISTATE = 0x7001, 0x752F, 0x6E15, 0x6CF7   -- live tables
local TAX   = 0x6D2D                                               -- fief_tax_rate[] (byte/fief)
local MARK  = 0x6000                                               -- low-water mark table (8 B/fief, words)
local ADJ   = 0x10300                                              -- bank4 $8300 adjacency in PRG-ROM
local NF    = 17                                                   -- 17-fief scenario
-- the 8 combat stats in order, with weights:
local STATS = {{"hp",5},{"dr",10},{"lk",10},{"ch",5},{"iq",20},{"mor",10},{"skl",25},{"arm",15}}
local NAMES = {[0]="Noto","Echigo","Musashi","Kaga","Echizen","Hida","Suruga","Mikawa","Mino",
               "Yamato","Omi","Iga","Iseshima","Yamashiro","Settsu","Shinano","Owari"}

local function fstats(p)
  local b = PROV + p*26
  local o = rd(OWNER + p); local d = DMY + o*7
  return { hp=rd(d+1), dr=rd(d+2), lk=rd(d+3), ch=rd(d+4), iq=rd(d+5),
           mor=rd16(b+18), skl=rd16(b+20), arm=rd16(b+22), men=rd16(b+16), own=o }
end
local function neighbours(p)
  local t = {}
  for i = 0, 7 do local n = prg(ADJ + p*8 + i); if n == 0xFF then break end; t[#t+1] = n end
  return t
end

-- attacker A vs defender D: returns (p = A's strength share %, Wa = weight A wins)
local function headtohead(A, D)
  local Wa = 0
  for _,sw in ipairs(STATS) do
    if A[sw[1]] > D[sw[1]] then Wa = Wa + sw[2] end       -- A wins only on strict >; ties to defender
  end
  local Wd = 100 - Wa
  local Sa = math.floor(A.men * (2 + 0.4*Wa/100))         -- attacker: base + stat8-floor
  local Sd = math.floor(D.men * (3 + 0.4*Wd/100))         -- defender: + home bonus
  local p  = (Sa+Sd > 0) and math.floor(Sa*100/(Sa+Sd)) or 0
  return p, Wa
end

-- INVADE decision is a MEN-COUNT share, NOT the 8-stat BV (bytecode $949A / $939D):
-- men_share(a,b) = 100*men(a)/(men(a)+men(b)) (= math32_2arg). An AI fief attacks a
-- PLAYER neighbour when its share vs you > 47 (~it has > 0.89x your men); among AI it
-- needs > ~70 (2.3x). So you're "men-safe" on an edge when your men >= ~1.13x theirs.
-- (The 8-stat BV above is the separate question of who'd WIN the resulting battle.)
local function men_share(a, b) return (a+b > 0) and math.floor(a*100/(a+b)) or 0 end

-- pct_op (§6): ⌊b·p/100⌋ computed in three pieces, exactly as the engine ($D70D)
local function pct_op(b, p)
  b = math.floor(b); p = math.floor(p)
  return math.floor(b/10)*math.floor(p/10)
       + math.floor((b%10)*p/100)
       + math.floor((p%10)*math.floor(b/10)/10)
end

-- EXPECTED Fall harvest income for fief p (appendix §4, Pass-2 bytecode-certified).
-- Returns gold_income, rice_income, upkeep(men/2).  Uses the harvest-time ratchet:
-- each low-water mark is min(stored_mark, current_live) before the income calc.
local function harvest(p)
  local b   = PROV + p*26
  local o   = rd(OWNER + p)
  local tax = rd(TAX + p)
  local ch  = rd(DMY + o*7 + 4)            -- $946D = daimyo Charisma (daimyo_record+4)
  local loy = rd16(b+12)
  local upkeep = math.floor(rd16(b+16) / 2)
  if loy == 0 then return 0, 0, upkeep end -- full revolt earns nothing
  -- marks ratcheted down to current at harvest ($A0A9): min(mark, live)
  local lm   = math.min(rd16(MARK+7+p*8), loy)
  local wm   = math.min(rd16(MARK+9+p*8), rd16(b+14))
  local omax = math.min(rd16(MARK+3+p*8), rd16(b+8))
  local dmax = math.min(rd16(MARK+5+p*8), rd16(b+10))
  local town = rd16(b+4)
  local header = rd16(b+24)
  local base = pct_op(pct_op(lm, 40), tax) + pct_op(wm, tax)
  local ev_rng = math.floor(pct_op(math.floor(ch/2), tax) / 2)  -- E[rng(0..ceil)] = ceil/2
  local g = base + pct_op(town, tax) + ev_rng
  local r = base + pct_op(pct_op(omax, dmax), tax) + ev_rng
  if g > header then g = header end
  if r > header then r = header end
  return g, r, upkeep
end

local function headtohead_report()
  local mine = {}
  for p = 0, NF-1 do if rd(AISTATE + p) ~= 0 then mine[#mine+1] = p end end
  if #mine == 0 then for p = 0, NF-1 do mine[#mine+1] = p end end   -- fallback: show all
  emu.log("==== ArmyBV head-to-head (your fiefs vs FOREIGN neighbours; p>50 = you favoured; terrain excl.) ====")
  for _,p in ipairs(mine) do
    local A = fstats(p)
    emu.log(string.format("  %s#%d (own %d) men=%d  state=%d", NAMES[p] or "?", p, A.own, A.men, rd(AISTATE+p)))
    for _,n in ipairs(neighbours(p)) do
      local D = fstats(n)
      if D.own ~= A.own then                                        -- skip own fiefs: not valid targets
        local pr, Wa = headtohead(A, D)                              -- TAKE: would I win the battle? (8-stat BV)
        local tag = (pr >= 60) and "FAVOURED" or (pr >= 45 and "even" or "RISKY")
        local risk = men_share(D.men, A.men)                        -- INVADE: will they come? (men-share $949A)
        local rtag = (risk > 47) and "THEY CAN INVADE" or "men-safe"
        emu.log(string.format("      vs %-10s#%-2d  TAKE p=%2d%% (Wyou=%d) %-8s | INVADE-RISK their-share=%2d%% %s  (men %d vs %d)",
          NAMES[n] or "?", n, pr, Wa, tag, risk, rtag, A.men, D.men))
      end
    end
  end
end

local function econ_report()
  -- group fiefs by owning daimyo
  local houses = {}      -- owner -> { fiefs={...} }
  local order  = {}
  for p = 0, NF-1 do
    local o = rd(OWNER + p)
    if not houses[o] then houses[o] = {}; order[#order+1] = o end
    houses[o][#houses[o]+1] = p
  end
  table.sort(order)
  emu.log("==== ArmyBV daimyo economy (current gold/rice + expected Fall harvest; potential = harvest sums) ====")
  for _,o in ipairs(order) do
    local ch = rd(DMY + o*7 + 4)
    local tg, tr, thg, thr, tup = 0, 0, 0, 0, 0
    emu.log(string.format("  Daimyo #%d (Ch=%d)  [%d fief(s)]", o, ch, #houses[o]))
    for _,p in ipairs(houses[o]) do
      local b = PROV + p*26
      local gold, rice = rd16(b+0), rd16(b+6)
      local hg, hr, up = harvest(p)
      tg, tr, thg, thr, tup = tg+gold, tr+rice, thg+hg, thr+hr, tup+up
      emu.log(string.format("      %-10s#%-2d  gold=%-5d rice=%-5d   harvest +%-4d/+%-4d (upkeep -%d)",
        NAMES[p] or "?", p, gold, rice, hg, hr, up))
    end
    emu.log(string.format("    -- TOTAL  gold=%-5d rice=%-5d   harvest +%d/+%d   net +%d/+%d",
      tg, tr, thg, thr, thg-tup, thr-tup))
  end
end

function report()
  headtohead_report()
  econ_report()
end

local function runAll()
  report()
  pcall(function() emu.displayMessage("ArmyBV", "refreshed — see Script Window log") end)
end

-- pick a key name this Mesen build accepts (silently no-ops on an unknown name)
local KEYNAME = "B"
for _,k in ipairs({"B", "KeyB"}) do
  local ok = pcall(function() return emu.isKeyPressed(k) end)
  if ok then KEYNAME = k; break end
end

local prevB = false
local function onFrame()
  local ok, down = pcall(function() return emu.isKeyPressed(KEYNAME) end)
  down = ok and down or false
  if down and not prevB then runAll() end
  prevB = down
end
pcall(function() emu.addEventCallback(onFrame, emu.eventType.endFrame) end)

runAll()
emu.displayMessage("Lua", string.format("army-bv armed (press %s / report())", KEYNAME))
