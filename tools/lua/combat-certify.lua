-- combat-certify.lua  (v7 — THIN RECORDER, "log now, calc later")
-- ============================================================================
-- The live-prediction versions (v2-v5) kept fooling us: pairing exchanges and
-- computing strength IN the callback raced against deployment/+1 writes. v7 does
-- ZERO interpretation. On every write to the unit-men array it dumps the COMPLETE
-- state as one CSV line. All pairing / formula / terrain / conservation analysis
-- happens OFFLINE in tools/combat-check.py against this log, where it's auditable
-- and order-safe. Keep the callback minimal so it never misses an event.
--
-- side 0 = ATTACKER (selected_province_idx);  side 1 = DEFENDER (battle_defending_province).
--
-- OUTPUT (v7 — log the full ARRAYS; the analyzer DIFFs them, since the write-address
-- label desyncs from the men-array change during combat bursts):
--   B,scenario, atkFief,atkOwn, defFief,defOwn,
--     atkMor,atkSkl,atkArm, atkHp,atkDr,atkLk,atkCh,atkIq,
--     defMor,defSkl,defArm, defHp,defDr,defLk,defCh,defIq
--   W,seq,vmpc, curSide,curSlot,
--     m0..m9 (all unit men, post-write), c0..c9 (all cols), r0..r9 (all rows),
--     mom0..mom4, atkMor,defMor
-- (unit index = side*5+slot: 0..4 = attacker u0..u4, 5..9 = defender u0..u4)
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
  local cs, cu = rd(CSIDE), rd(CSLOT)
  -- Log the COMPLETE state every write (the men/pos ARRAYS are ground truth; the
  -- write-address label desyncs from the men-array change during combat bursts, so
  -- the analyzer must DIFF the arrays, not trust a label). Columns (match combat-check.py):
  --   seq, vmpc, cs, cu, m0..m9, c0..c9, r0..r9, mom0..mom4, atkMor, defMor
  local t = {"W", seq, string.format("$%04X", vmpc()), cs, cu}
  for i = 0, 9 do t[#t+1] = rd16(STR + i*2) end        -- men (post-write)
  for i = 0, 9 do t[#t+1] = rd(COL + i) end             -- all unit cols (side*5+slot layout)
  for i = 0, 9 do t[#t+1] = rd(ROW + i) end             -- all unit rows
  for i = 0, 4 do t[#t+1] = rd(MOM + i) end
  t[#t+1] = rd16(PROV+rd(ATKP)*26+18); t[#t+1] = rd16(PROV+rd(DEFP)*26+18)
  emu.log(table.concat(t, ","))
end

local WRITE = emu.callbackType and (emu.callbackType.write or emu.callbackType.cpuWrite)
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onWrite, WRITE, STR, STR + 19)
emu.displayMessage("Lua", "combat-certify v7 (thin recorder) armed")
emu.log("# combat-certify v7 thin recorder: CSV per men-write; B=battle header, W=write. Calc offline.")
