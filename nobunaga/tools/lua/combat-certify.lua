-- combat-certify.lua  (v4)  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- v4 = v3 (write-callback, accurate PC, execution-order pairing) PLUS a live
-- self-check: each casualty exchange prints the FLAT (no-terrain) formula
-- prediction next to the observed casualties, and the live TERRAIN class of both
-- units (read from PRG-ROM, the exact source the engine uses). Where observed
-- diverges from the flat prediction AND a unit is on castle/forest/town, the gap
-- IS the terrain effect — quantified live. (We deliberately predict WITHOUT the
-- terrain term, since that term is the open question.)
--
-- The flat strength model (emulator-certified on plains, ledger #31):
--   S = men + DEFENDER-home(+men) + unit-rank(+men if wrap(slot)>wrap(other))
--       + (men·(1 + 0.4·W/100))  + momentum(men·0.2·other_contests)
--   p = S_cur·100/(S_cur+S_enemy);  cas = pct_op(men,pct) + (pct>=50?1:0)
--   W = sum of won stat-weights [hp5 dr10 lk10 ch5 iq20 mor10 skl25 arm15]
--   (difficulty scale assumed 100 = AI-vs-AI; player battles add (115-15·skill).)
--
-- SET SCENARIO below (17 or 50) so the terrain map-id table is read correctly.
-- TO RUN: Mesen 2 -> Debug -> Script Window -> open -> Run; play a battle; copy log.
-- ============================================================================
local SCENARIO = 17

local MT = emu.memType.nesMemory
local PRG = emu.memType.nesPrgRom or emu.memType.prgRom or emu.memType.nesPrgRomBytes
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a + 1) * 256 end
local function vmpc()  return rd(0x06) + rd(0x07) * 256 end
local function prg(o)  if not PRG then return 0xFF end return emu.read(o, PRG) end  -- PRG-ROM, header-stripped offset

local STR  = 0x6FBC
local COL, ROW, MOM = 0x6FD0, 0x6FDA, 0x7BEE
local ATKP, DEFP, FLAG = 0x6F5F, 0x6F63, 0x6F65
local CSIDE, CSLOT = 0x7BE8, 0x7BE4
local OWNER, PROV, DMY = 0x6E15, 0x7001, 0x752F
local STAT_W = {5,10,10,5,20, 10,25,15}                     -- hp,dr,lk,ch,iq, mor,skl,arm
local TERR_NAME = {[0]="CAS",[1]="for",[2]="TWN",[3]="."}   -- class 0..3

-- terrain class from PRG-ROM (the engine's own source) ------------------------
local function map_id(defprov)
  if SCENARIO == 17 then return prg(0x3F70E + defprov)      -- $F70E bank15
  else return prg(0xCE18 + defprov) end                     -- $8E18 bank3 (50-fief ramp)
end
local function terr_class(defprov, col, row)
  if col > 10 or row > 4 then return 3 end
  local cell = prg(0x1257E + map_id(defprov)*55 + row*11 + col)   -- $A57E bank4
  cell = cell - (cell % 2)                                  -- & 254
  if cell == 32 then return 0 elseif cell == 16 then return 1 elseif cell == 8 then return 2 else return 3 end
end

-- arithmetic primitives (ROM-certified) --------------------------------------
local function pct_op(a, b)
  if b == 100 then return a end
  return ((b%10)*(a//10))//10 + ((a%10)*b)//100 + (b//10)*(a//10)
end
local function math32(a, b) if (a+b) == 0 then return 0 end return (a*100)//(a+b) end
local function wrap(x) if x <= 2 then return x else return 0 end end

-- helpers --------------------------------------------------------------------
local function owner(p)  return rd(OWNER + p) end
local function fstats(p) local b=PROV+p*26; return rd16(b+18),rd16(b+20),rd16(b+22) end
local function dstats(p) local d=DMY+owner(p)*7; return rd(d+1),rd(d+2),rd(d+3),rd(d+4),rd(d+5) end

local W0, W1 = 0, 0      -- attacker-won / defender-won stat weights (set at battle start)
local TMULT = {[0]=90,[1]=20,[2]=10,[3]=0}    -- terrain class -> strength multiplier

-- returns: flat_total, terr_total, and a one-line term breakdown string
local function strength_terms(men, is_def, slot, oslot, W, mom_o, tclass)
  local b  = men
  local t1 = is_def and men or 0
  local t4 = (wrap(slot) > wrap(oslot)) and men or 0
  local t5 = pct_op(pct_op(men,40), W) + men
  local t6 = pct_op(men, mom_o*20)
  local tt = pct_op(men, TMULT[tclass]) * 3
  local flat = b + t1 + t4 + t5 + t6
  return flat, flat + tt,
    string.format("base=%d home=%d rank=%d s40=%d mom=%d terr=%d", b,t1,t4,t5,t6,tt)
end

local shadow = {}
for s=0,1 do for u=0,4 do shadow[s*5+u]=rd16(STR+s*10+u*2) end end
local curDef, started, nrec = -1, false, 0
local lastEx = nil      -- the most recent predicted exchange, for confirming the cur's own-loss

local function print_start()
  local a,d = rd(ATKP), rd(DEFP)
  local am,ask,aar = fstats(a); local ah,adr,alk,ach,aiq = dstats(a)
  local dm,dsk,dar = fstats(d); local dh,ddr,dlk,dch,diq = dstats(d)
  local A = {ah,adr,alk,ach,aiq, am,ask,aar}
  local D = {dh,ddr,dlk,dch,diq, dm,dsk,dar}
  W0, W1 = 0, 0
  for i=1,8 do if A[i] <= D[i] then W1 = W1 + STAT_W[i] else W0 = W0 + STAT_W[i] end end
  emu.log("")
  emu.log(string.format("======== BATTLE: atk fief %d (own %d) vs def fief %d (own %d)  [scen %d, map-id %d] ========",
    a,owner(a),d,owner(d), SCENARIO, map_id(d)))
  emu.log(string.format("  ATK(side0) fief[mor=%d skl=%d arm=%d] dmy[hp=%d dr=%d lk=%d ch=%d iq=%d]", am,ask,aar,ah,adr,alk,ach,aiq))
  emu.log(string.format("  DEF(side1) fief[mor=%d skl=%d arm=%d] dmy[hp=%d dr=%d lk=%d ch=%d iq=%d]", dm,dsk,dar,dh,ddr,dlk,dch,diq))
  emu.log(string.format("  won-weights: attacker=%d  defender=%d  (of 100)  | DEF gets +home", W0, W1))
end

local function onWrite(address, value)
  local d = rd(DEFP)
  if d >= 50 then curDef = -1; return end
  if d ~= curDef then curDef = d; started = false; nrec = 0
    for s=0,1 do for u=0,4 do shadow[s*5+u]=rd16(STR+s*10+u*2) end end
    return
  end
  local wi = (address - STR) // 2
  local s, u = wi // 5, wi % 5
  local new = rd16(STR + wi*2)
  local i = s*5+u; local old = shadow[i]
  if new == old then return end
  if not started then started = true; print_start() end
  nrec = nrec + 1
  local delta = new - old
  local col,row = rd(COL+s*5+u), rd(ROW+s*5+u)
  local cs,cu = rd(CSIDE), rd(CSLOT)
  local ccol,crow = rd(COL+cs*5+cu), rd(ROW+cs*5+cu)
  local pcline = string.format("vmpc=$%04X", vmpc())

  if delta < 0 and (vmpc() // 256) == 0x9D and not (s==cs and u==cu) then
    -- TARGET write: dump BOTH units' full term breakdown + flat AND terrain predictions.
    local cur_men, tgt_men = shadow[cs*5+cu], old
    local tcCur, tcTgt = terr_class(d,ccol,crow), terr_class(d,col,row)
    local cF, cT, cBrk = strength_terms(cur_men, cs==1, cu, u, (cs==1) and W1 or W0, rd(MOM+u),  tcCur)
    local tF, tT, tBrk = strength_terms(tgt_men, s==1,  u, cu, (s==1)  and W1 or W0, rd(MOM+cu), tcTgt)
    local pF, pT = math32(cF,tF), math32(cT,tT)
    local predF = pct_op(tgt_men, pF) + ((pF>=50) and 1 or 0); if predF>tgt_men then predF=tgt_men end
    local predT = pct_op(tgt_men, pT) + ((pT>=50) and 1 or 0); if predT>tgt_men then predT=tgt_men end
    local predFc = pct_op(cur_men, 100-pF) + (((100-pF)>=50) and 1 or 0); if predFc>cur_men then predFc=cur_men end
    lastEx = {cs=cs, cu=cu, predFc=predFc, pTc=(pct_op(cur_men,100-pT)+(((100-pT)>=50) and 1 or 0))}
    local obs = -delta
    emu.log(string.format("  [#%2d] EXCH cur(s%d,u%d)@%s -> s%du%d@%s   TARGET obs=-%d   flat:p=%d pred=-%d %s | +terr:p=%d pred=-%d %s",
      nrec, cs,cu,TERR_NAME[tcCur], s,u,TERR_NAME[tcTgt], obs,
      pF, predF, (predF==obs) and "OK" or "x", pT, predT, (predT==obs) and "OK" or "x"))
    emu.log(string.format("        cur[%s] flat=%d terr=%d ; tgt[%s] flat=%d terr=%d", cBrk, cF, cT, tBrk, tF, tT))
  elseif delta < 0 and (vmpc() // 256) == 0x9D and lastEx and lastEx.cs==cs and lastEx.cu==cu then
    local obs = -delta
    emu.log(string.format("  [#%2d]  '- cur s%du%d own loss obs=-%d  flat pred=-%d %s | terr pred=-%d %s  terr(%s)",
      nrec, s,u, obs, lastEx.predFc, (lastEx.predFc==obs) and "OK" or "x",
      lastEx.pTc, (lastEx.pTc==obs) and "OK" or "x", TERR_NAME[terr_class(d,col,row)]))
    lastEx = nil
  else                                                  -- deploy / removal / +delta: raw line
    emu.log(string.format("  [#%2d] s%du%d %d->%d (%s%d)  pos(%d,%d) cur(s%d,u%d)@(%d,%d) terr(%s)  %s",
      nrec, s,u, old,new, (delta<0) and "-" or "+", math.abs(delta), col,row, cs,cu, ccol,crow,
      TERR_NAME[terr_class(d,col,row)], pcline))
  end
  shadow[i] = new
end

local WRITE = emu.callbackType and (emu.callbackType.write or emu.callbackType.cpuWrite)
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onWrite, WRITE, STR, STR + 19)
emu.displayMessage("Lua", "combat-certify v5 armed (term breakdown + flat/terrain dual predict)")
emu.log(string.format("=== combat-certify v5: scen %d; per-exchange S term breakdown, flat vs +terrain; play a battle ===", SCENARIO))
if not PRG then
  emu.log("!! WARNING: no PRG-ROM memType found in this build (terrain shows '?'); paste me the keys below and I'll fix:")
  pcall(function() for k,_ in pairs(emu.memType) do emu.log("    memType."..tostring(k)) end end)
end
