-- dashboard.lua -- Nobunaga's Ambition (USA, NES), Mesen 2: where the player stands, each turn.
-- Debug -> Script Window -> Open. Draws a panel; press D for the full report in the Script Window log.
--
-- Built on the rules the sim measured (docs/synthesis-frontier.md #45-#47), read from live RAM:
--   HARVEST  the Fall formula (game.harvest_fief / appendix-formulas section 4): the low-water marks,
--            the charisma variance, the header cap, then the upkeep men/2 from gold AND rice.
--   STATUS   per enemy neighbour, three states (Chris, 2026-11-12):
--              SAFE      its share of men <= 47: it cannot pick you;
--              HUNTABLE  share > 47 but its budget min(2*rice, men, gold) < your shield min(rice, men);
--              COMING    share > 47 and it can pay. Shares use provisioned men (rice 0 counts as 0 men,
--                        so a fief at rice 0 is everyone's target and loses before it fights).
--   ORDER    daimyo_turn_order ($6F1B), reshuffled each season: a neighbour later in the order than
--            you can still move this season; one earlier has moved.
--   SAFE AT  the fewest men that put every neighbour back under 47 (52a/48 + 1), and the gold to hire them.
--   RICE     how much Summer can give without opening a gate (shield_rice mode 4, reaction.economy):
--              SAFE: whatever the harvest and next year's upkeep leave;
--              HUNTABLE, a hunter still to move: keep rice above every neighbour's budget (<= men);
--              HUNTABLE, every hunter has moved: keep only what the harvest refills to the men;
--              COMING: keep the shield whole (rice >= men) and close the gate with men first.
-- 17-fief scenario (the adjacency is the ROM's bank-4 table at $8300).

-- ===== addresses (tools/na1sim/memmap.py) =====
local MT  = emu.memType.nesMemory
local PRG = emu.memType.nesPrgRom or emu.memType.prgRom
local PROV, STRIDE = 0x7001, 26          -- fief records
local OWNER    = 0x6E15                  -- fief -> daimyo
local AISTATE  = 0x6CF7                  -- 0 AI, 5 player Direct, 255 empty
local TAX      = 0x6D2D                  -- byte per fief
local MARKS    = 0x6003                  -- low-water marks, 8 bytes per fief: output, dams, loyalty, wealth
local DAIMYO, DSTRIDE, D_CHA = 0x752F, 7, 4
local SEASON, YEAR = 0x6D5F, 0x6D9F
local SELECTED = 0x6F5F
local ORDER    = 0x6F1B                  -- daimyo_turn_order
local NFIEFS   = 0x6D9D
local HIRE_RATE = 0x6E11                 -- gold per man, in tenths
local ADJ = 0x10300                      -- bank 4 $8300 in PRG-ROM: 8 neighbours per fief, $FF ends
local F = {gold=0, debt=2, town=4, rice=6, output=8, dams=10, loyalty=12, wealth=14,
           men=16, morale=18, skill=20, arms=22, header=24}
local SHARE_LINE, CLIFF = 47, 45

local NAMES = {[0]="Noto","Echigo","Musashi","Kaga","Echizen","Hida","Suruga","Mikawa","Mino",
               "Yamato","Omi","Iga","Iseshima","Yamashiro","Settsu","Shinano","Owari"}
local SEASONS = {[0]="Spring","Summer","Fall","Winter"}

-- ===== reads =====
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a + 1) * 256 end
local function prg(o)  if PRG then return emu.read(o, PRG) end return 0xFF end

local function fief(i)
  local b, k = PROV + i * STRIDE, MARKS + i * 8
  local t = {idx = i, owner = rd(OWNER + i), state = rd(AISTATE + i), tax = rd(TAX + i),
             om = rd16(k), dm = rd16(k + 2), lm = rd16(k + 4), wm = rd16(k + 6)}
  for name, off in pairs(F) do t[name] = rd16(b + off) end
  t.cha = rd(DAIMYO + t.owner * DSTRIDE + D_CHA)
  return t
end

local function neighbours(i)
  local t = {}
  for j = 0, 7 do
    local n = prg(ADJ + i * 8 + j)
    if n == 0xFF then break end
    t[#t + 1] = n
  end
  return t
end

-- ===== the ROM's arithmetic =====
local function pct_op(b, p)            -- pct_op $D70D: split by ten, not floor(b*p/100)
  if b < 0 or p < 0 then return 0 end
  return (b // 10) * (p // 10) + ((b % 10) * p) // 100 + ((p % 10) * (b // 10)) // 10
end
local function share(a, b)             -- math32_2arg $D6DE: a*100/(a+b)
  if a + b == 0 then return 0 end
  return (a * 100) // (a + b)
end
local function provisioned(f) return f.rice > 0 and f.men or 0 end   -- $9382
local function budget(f) return math.min(2 * f.rice, f.men, f.gold) end
local function shield(f) return math.min(f.rice, f.men) end

-- the Fall harvest, before upkeep: {lo, hi} for gold and rice (game.harvest_fief)
-- The marks are re-seeded from the live stats each Summer and ratcheted down to them at the harvest,
-- so in Summer the coming harvest reads min(mark, live); in any other season it reads the live stats.
local function harvest(f)
  if f.loyalty == 0 then return 0, 0, 0, 0 end
  local s = rd16(SEASON)
  local marked = (s == 1)               -- Fall's harvest runs before Fall's commands
  local function mk(mark, live) if marked then return math.min(mark, live) end return live end
  local lm, wm, om, dm = mk(f.lm, f.loyalty), mk(f.wm, f.wealth), mk(f.om, f.output), mk(f.dm, f.dams)
  local base = pct_op(pct_op(lm, 40), f.tax) + pct_op(wm, f.tax)
  local var = pct_op(f.cha // 2, f.tax)
  local g = base + pct_op(f.town, f.tax)
  local r = base + pct_op(pct_op(om, dm), f.tax)
  local cap = f.header
  return math.min(g, cap), math.min(g + var, cap), math.min(r, cap), math.min(r + var, cap)
end

-- gold and rice after the harvest (worst rolls), its debt repaid and the army paid
local function after_harvest(f, give)
  local glo, _, rlo, _ = harvest(f)
  local gold, rice = f.gold + glo, f.rice - give + rlo
  gold = gold - math.min(gold, f.debt)
  local up = f.men // 2
  local pay = math.min(up, gold, rice)
  local men = f.men
  if pay < up then men = pay * 2 end          -- the upkeep dismisses what it cannot pay
  return gold - pay, rice - pay, men
end

-- ===== the read =====
local function me_idx()
  local sel = rd16(SELECTED)
  if sel < rd16(NFIEFS) and rd(AISTATE + sel) == 5 then return sel end
  for i = 0, rd16(NFIEFS) - 1 do if rd(AISTATE + i) == 5 then return i end end
  return nil
end

local function order_pos()
  local pos = {}
  for k = 0, rd16(NFIEFS) - 1 do pos[rd(ORDER + k)] = k end
  return pos
end

local function read_position()
  local i = me_idx()
  if not i then return nil end
  local me = fief(i)
  local pos = order_pos()
  local rows, worst, line, hunters_pending, max_budget = {}, "SAFE", me.men, false, 0
  for _, n in ipairs(neighbours(i)) do
    local o = fief(n)
    if o.state ~= 0xFF and o.owner ~= me.owner then
      local s = share(provisioned(o), provisioned(me))
      local b = budget(o)
      local st = "SAFE"
      if s > SHARE_LINE then st = (b >= shield(me)) and "COMING" or "HUNTABLE" end
      local moved = (pos[n] or 99) < (pos[i] or 99)
      rows[#rows + 1] = {idx = n, f = o, share = s, budget = b, state = st, moved = moved}
      if st == "COMING" or (st == "HUNTABLE" and worst == "SAFE") then worst = st end
      if s > SHARE_LINE and not moved then hunters_pending = true end
      max_budget = math.max(max_budget, b)
      -- the fewest men m with a*100 // (a + m) <= 47, i.e. a*100 < 48*(a + m)
      line = math.max(line, (provisioned(o) * (100 - SHARE_LINE - 1)) // (SHARE_LINE + 1) + 1)
    end
  end
  table.sort(rows, function(a, b) return a.share > b.share end)

  -- Summer's rice gift (shield_rice mode 4)
  local season = rd16(SEASON)
  local _, rice_after = after_harvest(me, 0)
  local room = math.max(0, rice_after - me.men // 2 - 1)        -- next year's upkeep stays fed
  local why = "harvest + next upkeep"
  if worst == "COMING" then
    room = math.min(room, math.max(0, me.rice - me.men)); why = "keep rice >= men"
  elseif worst == "HUNTABLE" then
    if season == 1 and not hunters_pending then
      room = math.min(room, math.max(0, rice_after - me.men)); why = "hunters moved: harvest refills to men"
    else
      local keep = math.min(me.men, max_budget + 1)
      room = math.min(room, math.max(0, me.rice - keep)); why = "keep rice > budgets (" .. keep .. ")"
    end
  end
  room = math.max(0, math.min(room, me.rice - 1))               -- a gift is rice on hand, not the harvest's
  local rate = rd16(HIRE_RATE)
  local need = math.max(0, line - me.men)
  return {me = me, rows = rows, status = worst, line = line, need = need,
          need_gold = (rate > 0) and (need * rate + 9) // 10 or 0,
          room = room, why = why, season = season, year = rd16(YEAR),
          turn = (pos[i] or 0) + 1, nf = rd16(NFIEFS)}
end

-- ===== drawing =====
local WHITE, GREY, GREEN, AMBER, RED, BG = 0xFFFFFF, 0xA0A0A0, 0x60E060, 0xF0C040, 0xFF5040, 0x000000
local COLOR = {SAFE = GREEN, HUNTABLE = AMBER, COMING = RED}
local X, Y0, LH = 1, 16, 9
local SHOW = true

local function put(y, text, color) emu.drawString(X, y, text, color or WHITE, BG) end

local function draw()
  if not SHOW then return end
  local ok, p = pcall(read_position)
  if not ok or not p then return end
  local me, y = p.me, Y0
  put(y, string.format("%s %d %s  turn %d/%d", NAMES[me.idx] or me.idx, p.year, SEASONS[p.season] or "?", p.turn, p.nf)); y = y + LH
  local glo, ghi, rlo, rhi = harvest(me)
  put(y, string.format("harvest g%d-%d r%d-%d eat%d", glo, ghi, rlo, rhi, me.men // 2), GREY); y = y + LH
  put(y, string.format("men%d rice%d mor%d loy%d", me.men, me.rice, me.morale, me.loyalty),
      (me.morale < CLIFF or me.loyalty < CLIFF or me.rice < me.men) and AMBER or GREY); y = y + LH
  put(y, p.status .. (p.need > 0 and string.format("  safe at %d (+%d, %dg)", p.line, p.need, p.need_gold) or ""),
      COLOR[p.status]); y = y + LH
  if p.season == 1 then put(y, string.format("give rice <= %d", p.room), WHITE); y = y + LH end
  for _, r in ipairs(p.rows) do
    put(y, string.format("%-8s m%-3d %2d%% b%-3d %s", (NAMES[r.idx] or r.idx):sub(1, 8), r.f.men, r.share,
        r.budget, r.moved and "-" or ">"), COLOR[r.state]); y = y + LH
  end
end

local function report()
  local p = read_position()
  if not p then emu.log("dashboard: no player (Direct) fief"); return end
  local me = p.me
  local glo, ghi, rlo, rhi = harvest(me)
  local g_after, r_after, men_after = after_harvest(me, 0)
  emu.log(string.format("== %s, %d %s, turn %d of %d", NAMES[me.idx] or me.idx, p.year, SEASONS[p.season] or "?", p.turn, p.nf))
  emu.log(string.format("   gold %d rice %d men %d morale %d loyalty %d tax %d%%", me.gold, me.rice, me.men, me.morale, me.loyalty, me.tax))
  emu.log(string.format("   harvest: gold +%d..%d, rice +%d..%d, upkeep %d each -> worst case gold %d rice %d men %d",
      glo, ghi, rlo, rhi, me.men // 2, g_after, r_after, men_after))
  emu.log(string.format("   status %s; every neighbour under %d%% at %d men (+%d, about %d gold)", p.status, SHARE_LINE, p.line, p.need, p.need_gold))
  emu.log(string.format("   Summer rice gift up to %d (%s)", p.room, p.why))
  emu.log("   neighbour   men rice gold  share budget  moves     state")
  for _, r in ipairs(p.rows) do
    emu.log(string.format("   %-10s %4d %4d %4d   %3d%%  %4d    %-8s  %s", NAMES[r.idx] or r.idx, r.f.men, r.f.rice, r.f.gold,
        r.share, r.budget, r.moved and "moved" or "after me", r.state))
  end
end
_G.report = report

-- D: the full report in the log; H: hide or show the panel
local function keyname(cands)
  for _, k in ipairs(cands) do if pcall(function() return emu.isKeyPressed(k) end) then return k end end
  return cands[1]
end
local KD, KH = keyname({"D", "KeyD"}), keyname({"H", "KeyH"})
local prevD, prevH = false, false
local function onFrame()
  local okD, d = pcall(function() return emu.isKeyPressed(KD) end)
  local okH, h = pcall(function() return emu.isKeyPressed(KH) end)
  d, h = okD and d or false, okH and h or false
  if d and not prevD then pcall(report) end
  if h and not prevH then SHOW = not SHOW end
  prevD, prevH = d, h
  draw()
end
emu.addEventCallback(onFrame, emu.eventType.endFrame)
emu.displayMessage("Lua", "NA1 dashboard: D report, H hide")
