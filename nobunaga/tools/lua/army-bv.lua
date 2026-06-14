-- army-bv.lua  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- On-demand HEAD-TO-HEAD readout: for each of YOUR fiefs (province_ai_state != 0),
-- compares it against each adjacent fief using the engine's OWN relative stat
-- contest — you bank a stat's weight when your stat beats theirs (ties to the
-- defender, as the engine does). This is a DIRECT compare (no 120 normalization),
-- so stat-bumps past 120 are handled naturally, and it answers "can I take this
-- neighbour?" for real.
--
--   per side: S = men * (FLOOR + 0.4 * Wself/100)   FLOOR = 2 (attacker) or 3 (defender, +home)
--   Wself = sum of weights of the stats that side WINS   (weights: hp5 dr10 lk10 ch5 iq20 mor10 skl25 arm15)
--   p = S_atk*100/(S_atk+S_def)   -> p>50 means you're favoured (terrain is per-battle, excluded)
--
-- Press 'B' (or call report()).  Reads LIVE values + adjacency from ROM ($8300).
-- ============================================================================
local MT  = emu.memType.nesMemory
local PRG = emu.memType.nesPrgRom or emu.memType.prgRom
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a+1)*256 end
local function prg(o)  return PRG and emu.read(o, PRG) or 0xFF end

local PROV, DMY, OWNER, AISTATE = 0x7001, 0x752F, 0x6E15, 0x6CF7   -- live tables
local ADJ = 0x10300                                                -- bank4 $8300 adjacency in PRG-ROM
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

function report()
  local mine = {}
  for p = 0, 16 do if rd(AISTATE + p) ~= 0 then mine[#mine+1] = p end end
  if #mine == 0 then for p = 0, 16 do mine[#mine+1] = p end end   -- fallback: show all
  emu.log("==== ArmyBV head-to-head (your fiefs vs neighbours; p>50 = you favoured; terrain excl.) ====")
  for _,p in ipairs(mine) do
    local A = fstats(p)
    emu.log(string.format("  %s#%d (own %d) men=%d  state=%d", NAMES[p] or "?", p, A.own, A.men, rd(AISTATE+p)))
    for _,n in ipairs(neighbours(p)) do
      local D = fstats(n); local pr, Wa = headtohead(A, D)
      local tag = (pr >= 60) and "FAVOURED" or (pr >= 45 and "even" or "RISKY")
      emu.log(string.format("      vs %-10s#%-2d  p=%2d%%  (Wyou=%d) men %d vs %d   %s",
        NAMES[n] or "?", n, pr, Wa, A.men, D.men, tag))
    end
  end
end

local prevB = false
local function onFrame()
  local ok, down = pcall(function() return emu.isKeyPressed("KeyB") end)
  if ok and down and not prevB then report() end
  prevB = ok and down or false
end
pcall(function() emu.addEventCallback(onFrame, (emu.eventType.startFrame or emu.eventType.endFrame)) end)

report()
emu.displayMessage("Lua", "army-bv head-to-head armed (press B / report())")
