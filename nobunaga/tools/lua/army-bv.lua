-- army-bv.lua  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- On-demand ArmyBV readout: rates every fief's army from the FIXED pre-combat
-- factors (men + the 8 combat-weighted stats), reading LIVE values, and lists each
-- fief's neighbours so you can scan surrounding fiefs at a glance.
--
--   ArmyBV = men * (1 + 0.4 * StatQuality/100)
--   StatQuality = Sum weight_i * min(stat_i/120, 1)   weights: hp5 dr10 lk10 ch5 iq20 mor10 skl25 arm15
--   (deliberately EXCLUDES situational terms: defensive terrain, defender home, momentum)
--
-- Press 'B' to print the report (or call report() from the Script Window console).
-- ============================================================================
local MT  = emu.memType.nesMemory
local PRG = emu.memType.nesPrgRom or emu.memType.prgRom
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a+1)*256 end
local function prg(o)  return PRG and emu.read(o, PRG) or 0xFF end

local PROV, DMY, OWNER = 0x7001, 0x752F, 0x6E15   -- live province / daimyo / fief-owner tables
local ADJ = 0x10300                               -- bank4 $8300 adjacency in PRG-ROM (8-byte slots, $FF-term)
local SW  = {hp=5, dr=10, lk=10, ch=5, iq=20, mor=10, skl=25, arm=15}
local NAMES = {[0]="Noto","Echigo","Musashi","Kaga","Echizen","Hida","Suruga","Mikawa","Mino",
               "Yamato","Omi","Iga","Iseshima","Yamashiro","Settsu","Shinano","Owari"}

local function fstats(p)
  local b = PROV + p*26
  local o = rd(OWNER + p); local d = DMY + o*7
  return { men=rd16(b+16), mor=rd16(b+18), skl=rd16(b+20), arm=rd16(b+22),
           hp=rd(d+1), dr=rd(d+2), lk=rd(d+3), ch=rd(d+4), iq=rd(d+5), own=o }
end

local function bv(s)
  local Q = 0
  for k,w in pairs(SW) do Q = Q + w * math.min(s[k]/120, 1) end
  return math.floor(s.men * (1 + 0.4*Q/100) + 0.5), math.floor(Q + 0.5)
end

local function neighbours(p)
  local t = {}
  for i = 0, 7 do local n = prg(ADJ + p*8 + i); if n == 0xFF then break end; t[#t+1] = n end
  return t
end

function report()
  local rows = {}
  for p = 0, 16 do local s = fstats(p); local v,q = bv(s); rows[#rows+1] = {v, q, p, s} end
  table.sort(rows, function(a,b) return a[1] > b[1] end)
  emu.log("==== ArmyBV (live values; men x stat-quality, excl. terrain/home/momentum) ====")
  for _,r in ipairs(rows) do
    local v,q,p,s = r[1],r[2],r[3],r[4]
    local nb = {}
    for _,n in ipairs(neighbours(p)) do nb[#nb+1] = string.format("%s(%d)", NAMES[n] or "?", n) end
    emu.log(string.format("  BV=%4d Q=%3d  %-10s#%-2d  men=%3d own=%-2d | neighbours: %s",
      v, q, NAMES[p] or "?", p, s.men, s.own, table.concat(nb, ", ")))
  end
end

-- 'B' hotkey (edge-detected); console report() always works as a fallback.
local prevB = false
local function onFrame()
  local ok, down = pcall(function() return emu.isKeyPressed("KeyB") end)
  if ok and down and not prevB then report() end
  prevB = ok and down or false
end
local ET = emu.eventType
pcall(function() emu.addEventCallback(onFrame, ET.startFrame or ET.endFrame) end)

report()   -- print once on load
emu.displayMessage("Lua", "army-bv armed (press B or call report())")
