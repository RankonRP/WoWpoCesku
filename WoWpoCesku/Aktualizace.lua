-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- Upozornění na novou verzi: addon si s ostatními hráči (cech, skupina, raid) vyměňuje číslo verze.
-- Když potkáš někoho s novějším WoWpoČesku, v chatu se jednou objeví hláška. Na internet addon nesahá.
local PREFIX = "WPCVER"

local function cfg()
    WoWpoCeskuSettings = WoWpoCeskuSettings or {}
    return WoWpoCeskuSettings
end

local function myVersion()
    local get = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    local ok, v = pcall(get, "WoWpoCesku", "Version")
    return ok and type(v) == "string" and v or nil
end

local function num(v)
    local a, b, c = tostring(v or ""):match("^(%d+)%.(%d+)%.?(%d*)")
    if not a then return nil end
    return tonumber(a) * 1000000 + tonumber(b) * 1000 + (tonumber(c) or 0)
end

local lastSent = 0
local function broadcast()
    local ver = myVersion()
    if not ver or not (C_ChatInfo and C_ChatInfo.SendAddonMessage) then return end
    if GetTime() - lastSent < 30 then return end
    lastSent = GetTime()
    local function send(channel) pcall(C_ChatInfo.SendAddonMessage, PREFIX, ver, channel) end
    if IsInGuild and IsInGuild() then send("GUILD") end
    if IsInRaid and IsInRaid() then send("RAID")
    elseif IsInGroup and IsInGroup() then send("PARTY") end
end

local notified = false
local function onReceive(text)
    if notified or cfg().updateCheck == false then return end
    local mine, theirs = myVersion(), text
    local a, b = num(mine), num(theirs)
    if not (a and b) or b <= a then return end
    notified = true
    if cfg().updateNotified == theirs then return end   -- tuhle verzi jsme už hlásili
    cfg().updateNotified = theirs
    print(("|cffffd100WoWpoCesku:|r Je dostupna novejsi verze %s (ty mas %s). Aktualizuj na CurseForge (hledej WoWpoCesku)."):format(theirs, mine))
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(_, event, prefix, text)
    if event == "PLAYER_LOGIN" then
        if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX) end
        C_Timer.After(8, broadcast)
    elseif event == "GROUP_ROSTER_UPDATE" then
        C_Timer.After(2, broadcast)
    elseif event == "CHAT_MSG_ADDON" and prefix == PREFIX and type(text) == "string" then
        pcall(onReceive, text)
    end
end)
