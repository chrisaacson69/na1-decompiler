-- combat-certify.lua  (v6 — THIN RECORDER, "log now, calc later")
-- ============================================================================
-- The live-prediction versions (v2-v5) kept fooling us: pairing exchanges and
-- computing strength IN the callback raced against deployment/+1 writes. v6 does
-- ZERO interpretation. On every write to the unit-men array it dumps the COMPLETE
-- state as one CSV line. All pairing / formula / terrain / conservation analysis
-- happens OFFLINE in tools/combat-check.py against this log, where it's auditable
-- and order-safe. Keep the callback minimal so it never misses an event.
--
-- side 0 = ATTACKER (selected_province_idx);  side 1 = DEFENDER (battle_defending_province).
--
-- OUTPUT:
--   B,scenario, atkFief,atkOwn, defFief,defOwn,
--     atkMor,atkSkl,atkArm, atkHp,atkDr,atkLk,atkCh,atkIq,
--     defMor,defSkl,defArm, defHp,defDr,defLk,defCh,defIq
--   W,seq,vmpc, chSide,chSlot,newMen, curSide,curSlot,
--     m0..m9 (all unit men, post-write),
--     chCol,chRow, curCol,curRow,
--     mom0..mom4, atkMor,defMor
-- (men index = side*5+slot: m0..m4 = attacker u0..u4, m5..m9 = defender u0..u4)
--
-- TO RUN: Mesen 2 -> Debug -> Script Window -> open -> Run; play a battle; copy log.
-- ============================================================================
local SCENARIO = 17

local MT = emu.memType.nesMemory
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a + 1) * 256 end
local function vmpc()  return rd(0x06) + rd(0x07) * 256 end

local STR  = 0x6FBC      -- unit men: STR + side*10 + slot*2 (word); array = 20 bytes
local COL, ROW, MOM = 0x6FD0, 0x6FDA, 0x7BEE
local ATKP, DEFP = 0x6F5F, 0x6F63
local CSIDE, CSLOT = 0x7BE8, 0x7BE4
local OWNER, PROV, DMY = 0x6E15, 0x7001, 0x752F

local function owner(p)  return rd(OWNER + p) end
local function fstats(p) local b=PROV+p*26; return rd16(b+18),rd16(b+20),rd16(b+22) end       -- mor,skl,arm
local function dstats(p) local d=DMY+owner(p)*7; return rd(d+1),rd(d+2),rd(d+3),rd(d+4),rd(d+5) end -- hp,dr,lk,ch,iq

local curDef, started, seq = -1, false, 0

local function emit_B()
  local a,d = rd(ATKP), rd(DEFP)
  local am,ask,aar = fstats(a); local ah,adr,alk,ach,aiq = dstats(a)
  local dm,dsk,dar = fstats(d); local dh,ddr,dlk,dch,diq = dstats(d)
  emu.log(string.format("B,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
    SCENARIO, a,owner(a), d,owner(d),
    am,ask,aar, ah,adr,alk,ach,aiq,
    dm,dsk,dar, dh,ddr,dlk,dch,diq))
end

local function onWrite(address, value)
  local d = rd(DEFP)
  if d >= 50 then curDef = -1; return end
  if d ~= curDef then curDef = d; started = false; seq = 0 end
  if not started then started = true; emit_B() end
  seq = seq + 1
  local wi = (address - STR) // 2
  local chS, chU = wi // 5, wi % 5
  local cs, cu = rd(CSIDE), rd(CSLOT)
  -- Build the CSV via table.concat (no fragile %d counting). Column order matches
  -- combat-check.py: seq,vmpc,chS,chU,new,cs,cu, m0..m9, chCol,chRow,curCol,curRow,
  --                  mom0..mom4, atkMor,defMor
  local t = {"W", seq, string.format("$%04X", vmpc()), chS, chU, rd16(STR + wi*2), cs, cu}
  for i = 0, 9 do t[#t+1] = rd16(STR + i*2) end
  t[#t+1] = rd(COL+chS*5+chU); t[#t+1] = rd(ROW+chS*5+chU)
  t[#t+1] = rd(COL+cs*5+cu);   t[#t+1] = rd(ROW+cs*5+cu)
  for i = 0, 4 do t[#t+1] = rd(MOM+i) end
  t[#t+1] = rd16(PROV+rd(ATKP)*26+18); t[#t+1] = rd16(PROV+rd(DEFP)*26+18)
  emu.log(table.concat(t, ","))
end

local WRITE = emu.callbackType and (emu.callbackType.write or emu.callbackType.cpuWrite)
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onWrite, WRITE, STR, STR + 19)
emu.displayMessage("Lua", "combat-certify v6 (thin recorder) armed")
emu.log("# combat-certify v6 thin recorder: CSV per men-write; B=battle header, W=write. Calc offline.")
