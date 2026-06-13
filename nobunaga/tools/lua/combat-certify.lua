-- combat-certify.lua  (v3)  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- WHY v3: v2 polled at end-of-frame, so its vmpc was wherever the VM happened to
-- be at the frame boundary (useless for identifying the write site) and multiple
-- writes in one frame couldn't be ordered. v3 uses a MEMORY WRITE CALLBACK on the
-- unit-men array, so each write is caught AT the write with the TRUE vmpc, and
-- writes arrive in execution order -> the two halves of one melee exchange (your
-- loss, then enemy loss) are consecutive. Clean pairing without controlled setup.
--
-- Write sites of interest (vmpc): casualty apply ~ $9D4A (apply_pct_reduction),
-- unit removal ~ $9D66, deployment ~ $91xx/$92xx. We just log the real vmpc and
-- classify offline (tools/combat-check.py).
--
-- side 0 = ATTACKER (selected_province_idx);  side 1 = DEFENDER (battle_defending_province).
-- TO RUN: Mesen 2 -> Debug -> Script Window -> open -> Run; play a battle; copy log.
-- ============================================================================
local MT = emu.memType.nesMemory
local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return rd(a) + rd(a + 1) * 256 end
local function vmpc()  return rd(0x06) + rd(0x07) * 256 end

local STR  = 0x6FBC   -- unit men: STR + side*10 + slot*2 (word); array = 20 bytes
local COL, ROW, MOM = 0x6FD0, 0x6FDA, 0x7BEE
local ATKP, DEFP, FLAG = 0x6F5F, 0x6F63, 0x6F65
local CSIDE, CSLOT = 0x7BE8, 0x7BE4
local OWNER, PROV, DMY = 0x6E15, 0x7001, 0x752F

local function owner(p)  return rd(OWNER + p) end
local function fstats(p) local b=PROV+p*26; return rd16(b+18),rd16(b+20),rd16(b+22) end
local function dstats(p) local d=DMY+owner(p)*7; return rd(d+1),rd(d+2),rd(d+3),rd(d+4),rd(d+5) end
local function mom_str() local t={}; for i=0,4 do t[i+1]=rd(MOM+i) end; return table.concat(t,",") end

local shadow = {}
for s=0,1 do for u=0,4 do shadow[s*5+u]=rd16(STR+s*10+u*2) end end
local curDef, started, nrec = -1, false, 0

local function print_start()
  local a,d=rd(ATKP),rd(DEFP)
  local am,ask,aar=fstats(a); local ah,adr,alk,ach,aiq=dstats(a)
  local dm,dsk,dar=fstats(d); local dh,ddr,dlk,dch,diq=dstats(d)
  emu.log("")
  emu.log(string.format("======== BATTLE: atk fief %d (own %d) vs def fief %d (own %d) ========", a,owner(a),d,owner(d)))
  emu.log(string.format("  ATK(side0) fief[mor=%d skl=%d arm=%d] dmy[hp=%d dr=%d lk=%d ch=%d iq=%d] flag=%02X", am,ask,aar,ah,adr,alk,ach,aiq,rd(FLAG)))
  emu.log(string.format("  DEF(side1) fief[mor=%d skl=%d arm=%d] dmy[hp=%d dr=%d lk=%d ch=%d iq=%d] flag=%02X", dm,dsk,dar,dh,ddr,dlk,dch,diq,rd(FLAG+1)))
end

local function onWrite(address, value)
  local d = rd(DEFP)
  if d >= 50 then curDef = -1; return end
  if d ~= curDef then  -- new battle: re-arm + refresh shadow, don't print yet
    curDef = d; started = false; nrec = 0
    for s=0,1 do for u=0,4 do shadow[s*5+u]=rd16(STR+s*10+u*2) end end
    return
  end
  local wi = (address - STR) // 2          -- word index 0..9
  local s, u = wi // 5, wi % 5
  local new = rd16(STR + wi*2)             -- full word after the write
  local i = s*5+u; local old = shadow[i]
  if new == old then return end            -- high-byte settle / no net change
  if not started then started = true; print_start() end
  nrec = nrec + 1
  local delta = new - old
  local pct = (old > 0) and (math.abs(delta)*100.0/old) or 0
  local col,row = rd(COL+s*5+u), rd(ROW+s*5+u)
  local cs,cu = rd(CSIDE), rd(CSLOT)
  local ccol,crow = rd(COL+cs*5+cu), rd(ROW+cs*5+cu)
  emu.log(string.format(
    "  [#%2d] s%du%d  %4d->%-4d (%s%d, %4.1f%%)  pos(%d,%d)  cur(s%d,u%d)@(%d,%d)  atkMor=%d defMor=%d  mom[%s]  vmpc=$%04X",
    nrec, s,u, old,new, (delta<0) and "-" or "+", math.abs(delta), pct,
    col,row, cs,cu, ccol,crow, rd16(PROV+rd(ATKP)*26+18), rd16(PROV+rd(DEFP)*26+18), mom_str(), vmpc()))
  shadow[i] = new
end

local WRITE = emu.callbackType and (emu.callbackType.write or emu.callbackType.cpuWrite)
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onWrite, WRITE, STR, STR + 19)
emu.displayMessage("Lua", "combat-certify v3 armed (write-based)")
emu.log("=== combat-certify v3: write-callback on unit-men; side0=atk side1=def; play a battle ===")
