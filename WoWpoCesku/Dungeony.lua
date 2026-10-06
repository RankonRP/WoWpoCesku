-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: Dungeonový deník – samostatné okno. Přehled dungeonů a raidů, detail se záložkami
-- Bossové a kořist / Questy / Průvodce. Otevře se příkazem /czq dungeon nebo tlačítkem v Kronice.
-- Data: DataDungeony (bossové, questy), DataKoristi (kořist, ID příšer), DataPruvodce (průvodce, místa questů),
-- DataObrazky (která instance má malovaný banner v Textures\Dungeony).

local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local TITLE_FONT = "Fonts\\FRIZQT__.TTF"   -- písmo hry pro anglické názvy (instance, bossové); české texty mají vlastní písmo
local PARCHMENT = "Interface\\AddOns\\WoWpoCesku\\Textures\\pergamen.tga"
local ART = "Interface\\AddOns\\WoWpoCesku\\Textures\\Dungeony\\"
local INK, RED, SEPIA = { 0.20, 0.13, 0.07 }, { 0.50, 0.12, 0.05 }, { 0.42, 0.30, 0.18 }
local QUALITY = { [0] = "|cff6b6b6b", [1] = "|cff4a4a4a", [2] = "|cff1a7a1a", [3] = "|cff0b5cc4", [4] = "|cff8a2be2", [5] = "|cffc25a00" }
local QCOLOR = { [0] = { 0.42, 0.42, 0.42 }, [1] = { 0.29, 0.29, 0.29 }, [2] = { 0.10, 0.48, 0.10 }, [3] = { 0.04, 0.36, 0.77 }, [4] = { 0.54, 0.17, 0.89 }, [5] = { 0.76, 0.35, 0.0 } }

-- Kvalita a jméno předmětu přímo z klienta (WoW Forever mění kvalitu i jména oproti classic databázi).
-- Když klient předmět ještě nezná, vyžádá se a okno se po načtení samo obnoví.
local itemPending = false
function WoWpoCesku_ItemQuality(id, dbQuality, dbName)
    local q, n
    if C_Item and C_Item.GetItemQualityByID then
        local ok, v = pcall(C_Item.GetItemQualityByID, id)
        if ok and v then q = v end
    end
    if C_Item and C_Item.GetItemNameByID then
        local ok, v = pcall(C_Item.GetItemNameByID, id)
        if ok and v then n = v end
    end
    if (not q or not n) and GetItemInfo then
        local ok, name, _, quality = pcall(GetItemInfo, id)
        if ok then q = q or quality; n = n or name end
    end
    if (not q or not n) and C_Item and C_Item.RequestLoadItemDataByID then
        pcall(C_Item.RequestLoadItemDataByID, id)
        itemPending = true
    end
    return q or dbQuality, n or dbName
end
local GREEN = "|cff1d6b1d"

local DUNGEONS = { "Ragefire Chasm", "Wailing Caverns", "The Deadmines", "Shadowfang Keep", "Blackfathom Deeps",
    "The Stockade", "Gnomeregan", "Razorfen Kraul", "Scarlet Monastery", "Razorfen Downs", "Uldaman", "Zul'Farrak",
    "Maraudon", "Sunken Temple", "Blackrock Depths", "Blackrock Spire", "Dire Maul", "Scholomance", "Stratholme" }
local RAIDS = { "Molten Core", "Onyxia's Lair", "Blackwing Lair", "Zul'Gurub", "Ruins of Ahn'Qiraj",
    "Ahn'Qiraj Temple", "Naxxramas" }

-- barva instance (banner, když ještě není malovaný obrázek)
local ACCENT = {
    ["Ragefire Chasm"] = { 0.80, 0.30, 0.10 }, ["Wailing Caverns"] = { 0.20, 0.55, 0.30 }, ["The Deadmines"] = { 0.35, 0.45, 0.60 },
    ["Shadowfang Keep"] = { 0.45, 0.35, 0.55 }, ["Blackfathom Deeps"] = { 0.20, 0.50, 0.55 }, ["The Stockade"] = { 0.50, 0.50, 0.55 },
    ["Gnomeregan"] = { 0.75, 0.55, 0.25 }, ["Razorfen Kraul"] = { 0.50, 0.55, 0.25 }, ["Scarlet Monastery"] = { 0.70, 0.20, 0.20 },
    ["Razorfen Downs"] = { 0.55, 0.65, 0.70 }, ["Uldaman"] = { 0.70, 0.55, 0.35 }, ["Zul'Farrak"] = { 0.65, 0.60, 0.30 },
    ["Maraudon"] = { 0.50, 0.35, 0.60 }, ["Sunken Temple"] = { 0.30, 0.55, 0.40 }, ["Blackrock Depths"] = { 0.65, 0.30, 0.20 },
    ["Blackrock Spire"] = { 0.55, 0.30, 0.20 }, ["Dire Maul"] = { 0.45, 0.60, 0.35 }, ["Scholomance"] = { 0.40, 0.25, 0.50 },
    ["Stratholme"] = { 0.60, 0.30, 0.30 }, ["Molten Core"] = { 0.85, 0.40, 0.10 }, ["Onyxia's Lair"] = { 0.60, 0.20, 0.20 },
    ["Blackwing Lair"] = { 0.50, 0.15, 0.15 }, ["Zul'Gurub"] = { 0.35, 0.55, 0.25 }, ["Ruins of Ahn'Qiraj"] = { 0.70, 0.60, 0.30 },
    ["Ahn'Qiraj Temple"] = { 0.60, 0.50, 0.30 }, ["Naxxramas"] = { 0.40, 0.60, 0.55 },
}

local TABS = {
    { id = "bossove", label = "Bossové a kořist", icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" },
    { id = "questy", label = "Questy", icon = "Interface\\GossipFrame\\AvailableQuestIcon" },
    { id = "mapa", label = "Mapa", icon = "Interface\\Icons\\INV_Misc_Map_01" },
    { id = "pruvodce", label = "Průvodce", icon = "Interface\\Icons\\INV_Misc_Book_09" },
}

local win
local state = { view = "list", key = nil, tab = "bossove", boss = {}, quest = {} }

-------------------------------------------------------------------------------
-- Pomocné
-------------------------------------------------------------------------------
local function newFont(name, size, r, g, b)
    local f = CreateFont(name)
    f:SetFont(FONT, size, "")
    f:SetTextColor(r, g, b)
    return f
end

local function text(parent, size, r, g, b)
    local t = parent:CreateFontString(nil, "OVERLAY")
    t:SetFont(FONT, size, "")
    t:SetTextColor(r, g, b)
    t:SetJustifyH("LEFT")
    t:SetSpacing(2)
    return t
end

local function settings()
    WoWpoCeskuSettings = WoWpoCeskuSettings or {}
    return WoWpoCeskuSettings
end

local function myFactionLetter()
    local f = UnitFactionGroup and UnitFactionGroup("player")
    if f == "Horde" then return "H" elseif f == "Alliance" then return "A" end
end

local function questDone(id)
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        local ok, v = pcall(C_QuestLog.IsQuestFlaggedCompleted, id)
        return ok and v or false
    end
    return false
end

local function killedBosses(key)
    local S = WoWpoCeskuSeen
    return (S and S.bosses and S.bosses[key]) or {}
end

local function questList(key)
    local out, seen = {}, {}
    local fac = myFactionLetter()
    for _, e in ipairs((WoWpoCesku_DungeonQuests and WoWpoCesku_DungeonQuests[key]) or {}) do
        local f = e[5]
        if (not f or not fac or f == fac) and not seen[e[2]] then
            seen[e[2]] = true
            out[#out + 1] = e
        end
    end
    return out
end

local function bossList(key)
    local out = {}
    for _, b in ipairs((WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key]) or {}) do
        if not b.sekce then out[#out + 1] = b end
    end
    return out
end

local function levelText(key)
    local L = WoWpoCesku_Lore and WoWpoCesku_Lore[key]
    local lv = L and L.tag and L.tag:match("levely%s+([%d–%-]+)")
    return lv and ("Levely " .. lv) or nil
end

-------------------------------------------------------------------------------
-- Mapa instance. Polohy bossů jsou ze serverové databáze (x, y), hra je ale kreslí podle vlastních souřadnic,
-- proto se mapa instance hledá podle ID instance a přepočet se vybírá automaticky podle toho, kam vyjdou body.
-- Když cokoli z toho klient neumí, záložka Mapa se vůbec nenabídne (nic se nerozbije).
-------------------------------------------------------------------------------
local mapIndex   -- [ID instance] = { uiMapID, ... }
local mapCache = {}

local function xy(v)
    if not v then return nil end
    if v.GetXY then
        local a, b = v:GetXY()
        return a, b
    end
    return v.x, v.y
end

local function buildMapIndex()
    mapIndex = {}
    if not (C_Map and C_Map.GetWorldPosFromMapPos and CreateVector2D) then return end
    local wanted = {}
    for _, bosses in pairs(WoWpoCesku_BossPos or {}) do
        for _, p in pairs(bosses) do wanted[p[1]] = true end
    end
    for id = 1, 3000 do
        local ok, cont = pcall(C_Map.GetWorldPosFromMapPos, id, CreateVector2D(0.5, 0.5))
        if ok and cont and wanted[cont] then
            mapIndex[cont] = mapIndex[cont] or {}
            table.insert(mapIndex[cont], id)
        end
    end
end

-- čtyři možná přiřazení os; vybere se to, při kterém vyjde nejvíc bodů na mapu
local function transforms(ax, ay, bx, by)
    local dx, dy = bx - ax, by - ay
    if dx == 0 or dy == 0 then return {} end
    return {
        function(x, y) return (x - ax) / dx, (y - ay) / dy end,
        function(x, y) return (y - ax) / dx, (x - ay) / dy end,
        function(x, y) return (x - ay) / dy, (y - ax) / dx end,
        function(x, y) return (y - ay) / dy, (x - ax) / dx end,
    }
end

local function inside(u, v) return u and v and u >= -0.03 and u <= 1.03 and v >= -0.03 and v <= 1.03 end

local function mapData(key)
    if mapCache[key] ~= nil then return mapCache[key] or nil end
    mapCache[key] = false
    local bosses = WoWpoCesku_BossPos and WoWpoCesku_BossPos[key]
    if not bosses or not (C_Map and C_Map.GetMapArtLayers and C_Map.GetMapArtLayerTextures) then return nil end
    if not mapIndex then buildMapIndex() end
    local instanceID
    for _, p in pairs(bosses) do instanceID = p[1] break end
    local candidates = instanceID and mapIndex[instanceID]
    if not candidates then return nil end
    local pts = {}
    for name, p in pairs(bosses) do pts[#pts + 1] = { name = name, x = p[2], y = p[3] } end
    local entry = WoWpoCesku_DungeonEntry and WoWpoCesku_DungeonEntry[key]
    local best
    for _, uiMap in ipairs(candidates) do
        local ok0, _, p0 = pcall(C_Map.GetWorldPosFromMapPos, uiMap, CreateVector2D(0, 0))
        local ok1, _, p1 = pcall(C_Map.GetWorldPosFromMapPos, uiMap, CreateVector2D(1, 1))
        local layers = C_Map.GetMapArtLayers(uiMap)
        local layer = layers and layers[1]
        if ok0 and ok1 and layer and layer.layerWidth and layer.layerWidth > 0 then
            local ax, ay = xy(p0)
            local bx, by = xy(p1)
            if ax and ay and bx and by then
                for ti, fn in ipairs(transforms(ax, ay, bx, by)) do
                    local n = 0
                    for _, pt in ipairs(pts) do
                        local u, v = fn(pt.x, pt.y)
                        if inside(u, v) then n = n + 1 end
                    end
                    if n > 0 and (not best or n > best.n) then
                        best = { n = n, uiMap = uiMap, fn = fn, layer = layer, ti = ti }
                    end
                end
            end
        end
    end
    if not best or best.n < math.min(2, #pts) then return nil end
    local data = { uiMap = best.uiMap, layer = best.layer, pins = {}, ti = best.ti, total = #pts }
    for _, pt in ipairs(pts) do
        local u, v = best.fn(pt.x, pt.y)
        if inside(u, v) then data.pins[#data.pins + 1] = { name = pt.name, u = u, v = v } end
    end
    if entry and entry[1] == instanceID then
        local u, v = best.fn(entry[2], entry[3])
        if inside(u, v) then data.entry = { u = u, v = v } end
    end
    mapCache[key] = data
    return data
end

-------------------------------------------------------------------------------
-- Zobrazit na mapě: DB souřadnice (x, y) -> zóna a pozice na její mapě -> uživatelská značka hry (waypoint).
-- Herní mapu z addonu neotevíráme ani nepřepínáme (způsobovalo to chyby ADDON_ACTION_BLOCKED); značku hra ukáže sama.
-- Přiřazení os se vybere automaticky podle toho, při kterém se nejvíc dárců questů trefí do nějaké zóny.
-------------------------------------------------------------------------------
local zoneCache, zoneFitCache

local function zoneMaps(cont)
    if zoneCache then return zoneCache[cont] or {} end
    zoneCache = {}
    if not (C_Map and C_Map.GetMapInfo and C_Map.GetWorldPosFromMapPos and CreateVector2D) then return {} end
    for id = 1, 3000 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and info.mapType == 3 then
            local ok0, c0, p0 = pcall(C_Map.GetWorldPosFromMapPos, id, CreateVector2D(0, 0))
            local ok1, c1, p1 = pcall(C_Map.GetWorldPosFromMapPos, id, CreateVector2D(1, 1))
            if ok0 and ok1 and c0 and c0 == c1 then
                local ax, ay = xy(p0)
                local bx, by = xy(p1)
                if ax and ay and bx and by and ax ~= bx and ay ~= by then
                    zoneCache[c0] = zoneCache[c0] or {}
                    table.insert(zoneCache[c0], { id = id, ax = ax, ay = ay, bx = bx, by = by, area = math.abs((bx - ax) * (by - ay)), name = info.name })
                end
            end
        end
    end
    return zoneCache[cont] or {}
end

local function unit(ti, z, x, y)
    local dx, dy = z.bx - z.ax, z.by - z.ay
    if ti == 1 then return (x - z.ax) / dx, (y - z.ay) / dy end
    if ti == 2 then return (y - z.ax) / dx, (x - z.ay) / dy end
    if ti == 3 then return (x - z.ay) / dy, (y - z.ax) / dx end
    return (y - z.ay) / dy, (x - z.ax) / dx
end

local function norm(n) return ((n or ""):lower():gsub("[^a-z]", "")) end

-- Nejmenší zóna, do které bod padne při daném přiřazení os
local function zoneAt(ti, map, x, y)
    local pick
    for _, z in ipairs(zoneMaps(map)) do
        local u, v = unit(ti, z, x, y)
        if u >= 0 and u <= 1 and v >= 0 and v <= 1 and (not pick or z.area < pick.area) then pick = z end
    end
    return pick
end

-- Přiřazení os se vybere podle směrů: např. Moonbrook leží jihozápadně od Sentinel Hill. Prohozené osy nebo
-- obrácený směr tu vyjdou špatně (u středů zón by to nebylo poznat).
local function zoneFit()
    if zoneFitCache then return zoneFitCache.ti, zoneFitCache.best, zoneFitCache.total end
    local counts, total = { 0, 0, 0, 0 }, 0
    for _, d in ipairs(WoWpoCesku_ZoneDir or {}) do
        total = total + 2
        for ti = 1, 4 do
            local z = zoneAt(ti, d[1], d[2], d[3])
            if z then
                local u1, v1 = unit(ti, z, d[2], d[3])
                local u2, v2 = unit(ti, z, d[4], d[5])
                if (u2 - u1) * d[6] > 0 then counts[ti] = counts[ti] + 1 end
                if (v2 - v1) * d[7] > 0 then counts[ti] = counts[ti] + 1 end
            end
        end
    end
    local ti, best = 1, counts[1]
    for i = 2, 4 do if counts[i] > best then ti, best = i, counts[i] end end
    zoneFitCache = { ti = ti, best = best, total = total, counts = counts }
    return ti, best, total
end

local function locate(map, x, y)
    local ti, best = zoneFit()
    if not best or best < 1 then return nil end
    local pick
    for _, z in ipairs(zoneMaps(map)) do
        local u, v = unit(ti, z, x, y)
        if u >= 0 and u <= 1 and v >= 0 and v <= 1 and (not pick or z.area < pick.z.area) then pick = { z = z, u = u, v = v } end
    end
    if pick then return pick.z.id, pick.u, pick.v, pick.z.name end
end

local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end

local function showOnMap(p, label)
    if not p then say("pro tento quest nemam polohu venku (zacina uvnitr dungeonu nebo predmetem).") return end
    local uiMap, u, v, zname = locate(p[1], p[2], p[3])
    if not uiMap then say("polohu se nepodarilo prevest na mapu (zkus /czq mapa).") return end
    local where = ("%s %.1f, %.1f"):format(zname or "?", u * 100, v * 100)
    local set = false
    if C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
        set = pcall(function()
            if C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(uiMap) then error("nelze") end
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uiMap, u, v))
            if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then C_SuperTrack.SetSuperTrackedUserWaypoint(true) end
        end)
    end
    local opened = false
    if settings().djOpenMap ~= false and not (InCombatLockdown and InCombatLockdown()) then
        -- mapu otevíráme přes securecall a jen mimo boj; kdyby hra hlásila ADDON_ACTION_BLOCKED, jde vypnout v nastavení
        opened = pcall(function()
            if OpenWorldMap then securecall(OpenWorldMap, uiMap) end
            if WorldMapFrame then
                if not WorldMapFrame:IsShown() then securecall(ShowUIPanel, WorldMapFrame) end
                if WorldMapFrame.SetMapID then securecall(WorldMapFrame.SetMapID, WorldMapFrame, uiMap) end
            end
        end)
    end
    setDJMark(uiMap, u, v, label, "Interface\\GossipFrame\\AvailableQuestIcon")
    say(label .. ": " .. where .. (set and " - znacka je na mape" or " (znacku nastavit nejde, souradnice jsou vyse)") .. (opened and "." or " (otevri mapu klavesou M)."))
end

-------------------------------------------------------------------------------
-- Zobrazit vchod: hra umí říct, kde na mapě zóny je vchod do instance (C_EncounterJournal.GetDungeonEntrancesForMap).
-------------------------------------------------------------------------------
local djMarks = {}      -- { uiMap, u, v, label, icon }
local djPins = {}
local djHooked

local function drawDJMarks()
    for _, p in ipairs(djPins) do p:Hide() end
    if #djMarks == 0 or not (WorldMapFrame and WorldMapFrame:IsShown()) then return end
    local canvas = WorldMapFrame.ScrollContainer and WorldMapFrame.ScrollContainer.Child
    if not canvas then return end
    local cur = WorldMapFrame:GetMapID()
    local w, h = canvas:GetWidth(), canvas:GetHeight()
    local n = 0
    for _, m in ipairs(djMarks) do
        if m.uiMap == cur then
            n = n + 1
            local p = djPins[n]
            if not p then
                p = CreateFrame("Frame", nil, canvas)
                p:SetSize(30, 30)
                p.glow = p:CreateTexture(nil, "BACKGROUND")
                p.glow:SetPoint("CENTER")
                p.glow:SetSize(44, 44)
                p.glow:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
                p.icon = p:CreateTexture(nil, "ARTWORK")
                p.icon:SetAllPoints()
                p:EnableMouse(true)
                p:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:AddLine(self.label or "")
                    GameTooltip:AddLine("Pravé tlačítko značku odstraní.", 0.8, 0.8, 0.8)
                    GameTooltip:Show()
                end)
                p:SetScript("OnLeave", function() GameTooltip:Hide() end)
                p:SetScript("OnMouseUp", function(self, btn) if btn == "RightButton" then wipe(djMarks); drawDJMarks() end end)
                djPins[n] = p
            end
            p.label = m.label
            p.icon:SetTexture(m.icon)
            p:SetFrameLevel(canvas:GetFrameLevel() + 1995)
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", m.u * w, -m.v * h)
            p:Show()
        end
    end
end

local function setDJMark(uiMap, u, v, label, icon)
    wipe(djMarks)
    djMarks[1] = { uiMap = uiMap, u = u, v = v, label = label, icon = icon }
    if WorldMapFrame and not djHooked then
        djHooked = true
        if WorldMapFrame.OnMapChanged then hooksecurefunc(WorldMapFrame, "OnMapChanged", function() C_Timer.After(0, drawDJMarks) end) end
        WorldMapFrame:HookScript("OnShow", function() C_Timer.After(0.1, drawDJMarks) end)
    end
    C_Timer.After(0.3, drawDJMarks)
    C_Timer.After(1, drawDJMarks)
end

local entranceCache = {}

local function findEntrance(key)
    if entranceCache[key] ~= nil then return entranceCache[key] or nil end
    entranceCache[key] = false
    if not (C_EncounterJournal and C_EncounterJournal.GetDungeonEntrancesForMap and C_Map and C_Map.GetMapInfo) then return nil end
    local want = key:lower():gsub("^the ", "")
    for id = 1, 3000 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and (info.mapType == 3 or info.mapType == 2) then
            local ok2, list = pcall(C_EncounterJournal.GetDungeonEntrancesForMap, id)
            if ok2 and type(list) == "table" then
                for _, e in ipairs(list) do
                    local nm = e.name and e.name:lower():gsub("^the ", "")
                    if nm and (nm == want or nm:find(want, 1, true) or want:find(nm, 1, true)) then
                        local u, v = xy(e.position)
                        if u and v then entranceCache[key] = { uiMap = id, u = u, v = v, zone = info.name } return entranceCache[key] end
                    end
                end
            end
        end
    end
    return nil
end

local function showEntrance(key)
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local e = findEntrance(key)
    if not e then
        local o = WoWpoCesku_DungeonEntryOut and WoWpoCesku_DungeonEntryOut[key]
        if o then
            local uiMap, u, v, zname = locate(o[1], o[2], o[3])
            if uiMap then e = { uiMap = uiMap, u = u, v = v, zone = zname } end
        end
    end
    if not e then say(key .. ": vchod se na mape nepodarilo najit (klient ho nenabizi). Viz Prvodce, tam je popis cesty.") return end
    local set = false
    if C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
        set = pcall(function()
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(e.uiMap, e.u, e.v))
            if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then C_SuperTrack.SetSuperTrackedUserWaypoint(true) end
        end)
    end
    local opened = false
    if settings().djOpenMap ~= false and not (InCombatLockdown and InCombatLockdown()) then
        opened = pcall(function()
            if OpenWorldMap then securecall(OpenWorldMap, e.uiMap) end
            if WorldMapFrame then
                if not WorldMapFrame:IsShown() then securecall(ShowUIPanel, WorldMapFrame) end
                if WorldMapFrame.SetMapID then securecall(WorldMapFrame.SetMapID, WorldMapFrame, e.uiMap) end
            end
        end)
    end
    setDJMark(e.uiMap, e.u, e.v, key .. " - vchod", "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar")
    say(("vchod %s: %s %.1f, %.1f%s%s"):format(key, e.zone or "?", e.u * 100, e.v * 100, set and " - znacka je na mape" or "", opened and "." or " (otevri mapu klavesou M)."))
end

local BOX = { bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 }
local function boxFrame(parent, level)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetBackdrop(BOX)
    f:SetBackdropColor(0.40, 0.26, 0.14, 0.16)
    f:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.9)
    if level then f:SetFrameLevel(level) end
    return f
end

-- plynulý přechod barvy (nový i starý způsob zápisu; když nejde ani jeden, zůstane plná plocha)
local function gradient(tex, r, g, b, a1, a2)
    tex:SetColorTexture(r, g, b, math.max(a1, a2))
    if tex.SetGradient and CreateColor then
        local ok = pcall(tex.SetGradient, tex, "HORIZONTAL", CreateColor(r, g, b, a1), CreateColor(r, g, b, a2))
        if ok then return end
    end
    if tex.SetGradientAlpha then pcall(tex.SetGradientAlpha, tex, "HORIZONTAL", r, g, b, a1, r, g, b, a2) end
end

-- banner instance: malovaný obrázek, když existuje, jinak barevná plocha; w/h = poměr cílové plochy
-- Obrázky instancí, které už jsou v klientu hry (Interface\\EncounterJournal\\UI-EJ-LOREBG-<jméno>); nic se nekopíruje.
-- Ověřeno ve WoW Forever (zkouška /czq obr2). Chybí Onyxia's Lair a Ahn'Qiraj Temple.
local CLIENT_ART = {
    ["Ragefire Chasm"] = "RagefireChasm", ["Wailing Caverns"] = "WailingCaverns", ["The Deadmines"] = "Deadmines",
    ["Shadowfang Keep"] = "ShadowfangKeep", ["Blackfathom Deeps"] = "BlackfathomDeeps", ["The Stockade"] = "TheStockade",
    ["Gnomeregan"] = "Gnomeregan", ["Razorfen Kraul"] = "RazorfenKraul", ["Scarlet Monastery"] = "ScarletMonastery",
    ["Razorfen Downs"] = "RazorfenDowns", ["Uldaman"] = "Uldaman", ["Zul'Farrak"] = "ZulFarrak", ["Maraudon"] = "Maraudon",
    ["Sunken Temple"] = "SunkenTemple", ["Blackrock Depths"] = "BlackrockDepths", ["Blackrock Spire"] = "BlackrockSpire",
    ["Dire Maul"] = "DireMaul", ["Scholomance"] = "Scholomance", ["Stratholme"] = "Stratholme", ["Molten Core"] = "MoltenCore",
    ["Blackwing Lair"] = "BlackwingLair", ["Zul'Gurub"] = "ZulGurub", ["Ruins of Ahn'Qiraj"] = "RuinsofAhnQiraj", ["Naxxramas"] = "Naxxramas",
}

local function setBanner(frame, key, w, h)
    local slug = WoWpoCesku_DungeonArt and WoWpoCesku_DungeonArt[key]
    local clientName = CLIENT_ART[key]
    if settings().djArt == "own" then clientName = nil end   -- v nastavení lze zvolit vlastní malované bannery
    local c = ACCENT[key] or { 0.5, 0.4, 0.3 }
    if clientName then
        frame.art:SetTexture("Interface\\EncounterJournal\\UI-EJ-LOREBG-" .. clientName)
        local want, have = w / h, 4   -- obrázek z klienta má zhruba poměr 4:1
        if want > have then
            local cut = (1 - have / want) / 2
            frame.art:SetTexCoord(0, 1, cut, 1 - cut)
        else
            local cut = (1 - want / have) / 2
            frame.art:SetTexCoord(cut, 1 - cut, 0, 1)
        end
        frame.art:SetVertexColor(1, 1, 1, 1)
        frame.art:Show()
    elseif slug then
        frame.art:SetTexture(ART .. slug)
        local want = w / h
        local have = 8   -- textura je 512×64
        if want < have then
            local cut = (1 - want / have) / 2
            frame.art:SetTexCoord(cut, 1 - cut, 0, 1)
        else
            frame.art:SetTexCoord(0, 1, 0, 1)
        end
        frame.art:SetVertexColor(1, 1, 1, 1)
        frame.art:Show()
    else
        frame.art:SetColorTexture(c[1] * 0.55, c[2] * 0.55, c[3] * 0.55, 1)
        frame.art:SetTexCoord(0, 1, 0, 1)
        frame.art:Show()
    end
    gradient(frame.shade, 0.05, 0.03, 0.02, 0.78, 0.10)
    frame.bar:SetColorTexture(c[1], c[2], c[3], 1)
end

local function makeBanner(parent)
    local f = CreateFrame("Frame", nil, parent)
    f.art = f:CreateTexture(nil, "BACKGROUND")
    f.art:SetAllPoints()
    f.shade = f:CreateTexture(nil, "BORDER")
    f.shade:SetAllPoints()
    f.bar = f:CreateTexture(nil, "ARTWORK")
    f.bar:SetPoint("TOPLEFT", 0, 0)
    f.bar:SetPoint("BOTTOMLEFT", 0, 0)
    f.bar:SetWidth(5)
    f.edge = f:CreateTexture(nil, "OVERLAY")
    f.edge:SetPoint("BOTTOMLEFT", 0, 0)
    f.edge:SetPoint("BOTTOMRIGHT", 0, 0)
    f.edge:SetHeight(1)
    f.edge:SetColorTexture(0.9, 0.75, 0.45, 0.7)
    return f
end

-------------------------------------------------------------------------------
-- Posuvné panely se samostatnými hromádkami textů, předmětů a řádků seznamu
-------------------------------------------------------------------------------
local function newScroll(parent, x, y, w, h)
    local sf = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", x, y)
    sf:SetSize(w, h)
    local c = CreateFrame("Frame", nil, sf)
    c.w = w - 26
    c:SetSize(c.w, 10)
    sf:SetScrollChild(c)
    c.texts, c.items, c.rows, c.cards, c.btns = {}, {}, {}, {}, {}
    c.nt, c.ni, c.nr, c.nc, c.nb, c.y = 0, 0, 0, 0, 0, 0
    c.portrait = false
    c.map = false
    return sf, c
end

local function reset(c)
    c.y, c.nt, c.ni, c.nr, c.nc, c.nb = 0, 0, 0, 0, 0, 0
    for _, b in ipairs(c.btns) do b:Hide() end
    for _, t in ipairs(c.texts) do t:Hide() end
    for _, b in ipairs(c.items) do b:Hide() end
    for _, b in ipairs(c.rows) do b:Hide() end
    for _, b in ipairs(c.cards) do b:Hide() end
    if c.portrait then c.portrait:Hide() end
    if c.map then c.map:Hide() end
end

local function addText(c, str, size, color, gap, indent, width, fontPath)
    c.nt = c.nt + 1
    local t = c.texts[c.nt]
    if not t then
        t = text(c, size, 1, 1, 1)
        c.texts[c.nt] = t
    end
    t:SetFont(fontPath or FONT, size, "")
    t:SetTextColor(color[1], color[2], color[3])
    t:ClearAllPoints()
    t:SetPoint("TOPLEFT", indent or 0, -c.y)
    t:SetWidth(width or (c.w - (indent or 0)))
    t:SetText(str)
    t:Show()
    c.y = c.y + (t:GetStringHeight() or 14) + (gap or 6)
end

local function addButton(c, label, onClick)
    c.nb = c.nb + 1
    local b = c.btns[c.nb]
    if not b then
        b = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
        b:SetSize(200, 28)
        b.ico = b:CreateTexture(nil, "OVERLAY")
        b.ico:SetSize(20, 20)
        b.ico:SetPoint("LEFT", 8, 0)
        b.ico:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
        b:SetNormalFontObject(win.fontBtn)
        b:SetHighlightFontObject(win.fontBtnOn)
        c.btns[c.nb] = b
    end
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", 0, -c.y)
    b:SetText("     " .. label)
    b:SetScript("OnClick", onClick)
    b:Show()
    c.y = c.y + 34
end

-- tenká ozdobná čára pod nadpisem
local function addRule(c)
    c.ni = c.ni + 1
    local b = c.items[c.ni]
    if not b or not b.isRule then
        b = CreateFrame("Frame", nil, c)
        b.isRule = true
        b.t = b:CreateTexture(nil, "ARTWORK")
        b.t:SetAllPoints()
        b.t:SetColorTexture(0.50, 0.12, 0.05, 0.35)
        c.items[c.ni] = b
    end
    b:SetHeight(1)
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", 0, -c.y)
    b:SetWidth(c.w)
    b:Show()
    c.y = c.y + 8
end

-------------------------------------------------------------------------------
-- Předměty (ikona s rámečkem kvality, jméno, typ; tooltip při najetí)
-------------------------------------------------------------------------------
local function itemIcon(id)
    local icon
    if C_Item and C_Item.GetItemIconByID then
        local ok, v = pcall(C_Item.GetItemIconByID, id)
        if ok then icon = v end
    end
    if not icon and GetItemIcon then
        local ok, v = pcall(GetItemIcon, id)
        if ok then icon = v end
    end
    return icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function itemKind(id)
    if not GetItemInfoInstant then return "" end
    local ok, _, _, subType, equipLoc = pcall(GetItemInfoInstant, id)
    if not ok then return "" end
    local parts = {}
    local slot = equipLoc and equipLoc ~= "" and _G[equipLoc] or nil
    if slot then parts[#parts + 1] = slot end
    if subType and subType ~= "" then parts[#parts + 1] = subType end
    return table.concat(parts, ", ")
end

local function showItemTip(self)
    if not self.itemID then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    local ok = GameTooltip.SetItemByID and pcall(GameTooltip.SetItemByID, GameTooltip, self.itemID)
    if not ok then pcall(GameTooltip.SetHyperlink, GameTooltip, "item:" .. self.itemID) end
    GameTooltip:Show()
end

local function addItem(c, name, quality, id, confirmed)
    c.ni = c.ni + 1
    local b = c.items[c.ni]
    if not b or b.isRule then
        b = CreateFrame("Button", nil, c, "BackdropTemplate")
        b:SetHeight(42)
        b:SetBackdrop(BOX)
        b:SetBackdropColor(0.40, 0.26, 0.14, 0.14)
        b:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.85)
        b.bg = b:CreateTexture(nil, "BACKGROUND")
        b.bg:SetSize(1, 1)
        b.frame = CreateFrame("Frame", nil, b, "BackdropTemplate")
        b.frame:SetSize(34, 34)
        b.frame:SetPoint("LEFT", 4, 0)
        b.frame:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetPoint("TOPLEFT", b.frame, "TOPLEFT", 2, -2)
        b.icon:SetPoint("BOTTOMRIGHT", b.frame, "BOTTOMRIGHT", -2, 2)
        b.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        b.star = b:CreateTexture(nil, "OVERLAY")
        b.star:SetSize(16, 16)
        b.star:SetPoint("RIGHT", -6, 0)
        b.star:SetTexture("Interface\\Common\\ReputationStar")
        b.star:SetTexCoord(0, 0.5, 0, 0.5)
        b.label = text(b, 13, INK[1], INK[2], INK[3])
        b.label:SetPoint("TOPLEFT", b.frame, "TOPRIGHT", 8, -2)
        b.kind = text(b, 11, SEPIA[1], SEPIA[2], SEPIA[3])
        b.kind:SetPoint("TOPLEFT", b.label, "BOTTOMLEFT", 0, -1)
        b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
        b:SetScript("OnEnter", showItemTip)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
        c.items[c.ni] = b
    end
    local liveQ, liveName = WoWpoCesku_ItemQuality(id, quality, name)
    quality, name = liveQ, liveName
    local qc = QCOLOR[quality] or { 0.4, 0.3, 0.2 }
    b.itemID = id
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", 0, -c.y)
    b:SetWidth(c.w)
    b.frame:SetBackdropBorderColor(qc[1], qc[2], qc[3], 1)
    b.icon:SetTexture(itemIcon(id))
    b.star:SetShown(confirmed and true or false)
    b.label:SetWidth(c.w - 56)
    b.label:SetText((QUALITY[quality] or "") .. name .. "|r")
    b.kind:SetWidth(c.w - 56)
    b.kind:SetText(itemKind(id))
    b:Show()
    c.y = c.y + 47
end

-------------------------------------------------------------------------------
-- 3D portrét bosse (model příšery z ID); když ho klient nepozná, zůstane prázdný rámeček
-------------------------------------------------------------------------------
local function showPortrait(c, npcID)
    if not c.portrait then
        local f = CreateFrame("Frame", nil, c, "BackdropTemplate")
        f:SetSize(120, 150)
        f:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2,
        })
        f:SetBackdropColor(0.10, 0.06, 0.04, 0.92)
        f:SetBackdropBorderColor(0.50, 0.30, 0.16, 1)
        f.model = CreateFrame("PlayerModel", nil, f)
        f.model:SetPoint("TOPLEFT", 3, -3)
        f.model:SetPoint("BOTTOMRIGHT", -3, 3)
        c.portrait = f
    end
    local f = c.portrait
    f:ClearAllPoints()
    f:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
    local ok = npcID and pcall(function()
        f.model:ClearModel()
        f.model:SetCreature(npcID)
        if f.model.SetPortraitZoom then f.model:SetPortraitZoom(0.8) end
    end)
    f:SetShown(ok and true or false)
    return ok
end

-------------------------------------------------------------------------------
-- Seznam vlevo (bossové / questy)
-------------------------------------------------------------------------------
local function addRow(c, title, sub, mark, selected, onClick, icon, badge, emblem, npcID)
    c.nr = c.nr + 1
    local b = c.rows[c.nr]
    if not b then
        b = CreateFrame("Button", nil, c, "BackdropTemplate")
        b:SetHeight(44)
        b:SetBackdrop(BOX)
        b:SetBackdropColor(0.40, 0.26, 0.14, 0.12)
        b:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.85)
        b.sel = b:CreateTexture(nil, "BACKGROUND")
        b.sel:SetAllPoints()
        b.sel:SetColorTexture(0.78, 0.55, 0.30, 0.55)
        b.accent = b:CreateTexture(nil, "ARTWORK")
        b.accent:SetPoint("TOPLEFT", 0, 0)
        b.accent:SetPoint("BOTTOMLEFT", 0, 0)
        b.accent:SetWidth(4)
        b.accent:SetColorTexture(0.50, 0.12, 0.05, 1)
        b.line = b:CreateTexture(nil, "BORDER")
        b.line:SetPoint("BOTTOMLEFT", 0, 0)
        b.line:SetPoint("BOTTOMRIGHT", 0, 0)
        b.line:SetHeight(1)
        b.line:SetColorTexture(0.45, 0.30, 0.16, 0.35)
        b.check = b:CreateTexture(nil, "ARTWORK")
        b.check:SetSize(18, 18)
        b.check:SetPoint("RIGHT", -4, 0)
        b.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetSize(30, 30)
        b.icon:SetPoint("LEFT", 12, 0)
        b.pframe = CreateFrame("Frame", nil, b, "BackdropTemplate")
        b.pframe:SetSize(40, 40)
        b.pframe:SetPoint("LEFT", 8, 0)
        b.pframe:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
        b.pframe:SetBackdropColor(0.10, 0.06, 0.04, 1)
        b.pframe:SetBackdropBorderColor(0.85, 0.65, 0.20, 1)
        b.pmodel = CreateFrame("PlayerModel", nil, b.pframe)
        b.pmodel:SetPoint("TOPLEFT", 2, -2)
        b.pmodel:SetPoint("BOTTOMRIGHT", -2, 2)
        b.bframe = CreateFrame("Frame", nil, b)
        b.bframe:SetAllPoints()
        b.bframe:SetFrameLevel(b.pframe:GetFrameLevel() + 6)
        b.badgeBg = b.bframe:CreateTexture(nil, "OVERLAY", nil, 1)
        b.badgeBg:SetSize(24, 14)
        b.badgeBg:SetPoint("BOTTOMRIGHT", b.icon, "BOTTOMRIGHT", 5, -3)
        b.badgeBg:SetColorTexture(0.07, 0.04, 0.02, 0.92)
        b.badge = text(b.bframe, 10, 1, 0.82, 0.25)
        b.badge:SetPoint("CENTER", b.badgeBg, "CENTER", 0, 0)
        b.emblem = b:CreateTexture(nil, "ARTWORK")
        b.emblem:SetSize(22, 22)
        b.emblem:SetPoint("RIGHT", -28, 0)
        b.label = text(b, 13, INK[1], INK[2], INK[3])
        b.label:SetPoint("TOPLEFT", 12, -6)
        b.sub = text(b, 11, SEPIA[1], SEPIA[2], SEPIA[3])
        b.sub:SetPoint("TOPLEFT", b.label, "BOTTOMLEFT", 0, -1)
        b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
        c.rows[c.nr] = b
    end
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", 0, -c.y)
    b:SetWidth(c.w)
    local hasModel = false
    if npcID then
        hasModel = pcall(function()
            b.pmodel:ClearModel()
            b.pmodel:SetCreature(npcID)
            if b.pmodel.SetPortraitZoom then b.pmodel:SetPortraitZoom(1) end
        end)
    end
    b.pframe:SetShown(hasModel)
    if hasModel then icon = nil end
    local off = (icon or hasModel) and 56 or 12
    local right = emblem and 62 or 34
    b.label:ClearAllPoints()
    b.label:SetPoint("TOPLEFT", off, -6)
    b.label:SetWidth(c.w - off - right)
    b.sub:SetWidth(c.w - off - right)
    b.icon:SetShown(icon and true or false)
    if icon then b.icon:SetTexture(icon) end
    b.badgeBg:SetShown(badge and true or false)
    b.badge:SetShown(badge and true or false)
    if hasModel then
        b.badgeBg:ClearAllPoints()
        b.badgeBg:SetPoint("BOTTOMLEFT", b.pframe, "BOTTOMLEFT", -4, -4)
    else
        b.badgeBg:ClearAllPoints()
        b.badgeBg:SetPoint("BOTTOMRIGHT", b.icon, "BOTTOMRIGHT", 5, -3)
    end
    if badge then b.badge:SetText(badge) end
    b.emblem:SetShown(emblem and true or false)
    if emblem then b.emblem:SetTexture(emblem) end
    b.label:SetFont(title:find("[\128-\255]") and FONT or TITLE_FONT, 13, "")
    b.label:SetText(title)
    b.sub:SetText(sub or "")
    local h = 8 + (b.label:GetStringHeight() or 14) + 2 + ((sub and sub ~= "") and (b.sub:GetStringHeight() or 12) or 0) + 8
    if h < (hasModel and 54 or 46) then h = hasModel and 54 or 46 end
    b:SetHeight(h)
    b.check:SetShown(mark and true or false)
    b.sel:SetShown(selected and true or false)
    b.accent:SetShown(selected and true or false)
    b:SetBackdropBorderColor(selected and 0.62 or 0.42, selected and 0.20 or 0.27, selected and 0.10 or 0.13, selected and 1 or 0.85)
    b:SetScript("OnClick", onClick)
    b:Show()
    c.y = c.y + h + 4
end

-------------------------------------------------------------------------------
-- Obsah záložek
-------------------------------------------------------------------------------
local showDetail

local function renderBosses(key)
    local L, R = win.left, win.right
    reset(L); reset(R)
    local bosses = bossList(key)
    if #bosses == 0 then
        addText(R, "Pro tuhle instanci zatím nemám seznam bossů.", 13, INK)
        return
    end
    local killed = killedBosses(key)
    local cur = state.boss[key]
    local found = false
    for _, b in ipairs(bosses) do if b[1] == cur then found = true end end
    if not found then cur = bosses[1][1]; state.boss[key] = cur end
    for _, b in ipairs(bosses) do
        local lv = WoWpoCesku_BossLevel and WoWpoCesku_BossLevel[key] and WoWpoCesku_BossLevel[key][b[1]]
        addRow(L, b[1], (b[2] and b[2] ~= "") and b[2] or nil, killed[b[1]] ~= nil, b[1] == cur,
            function() state.boss[key] = b[1]; showDetail() end,
            "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8", lv and (lv >= 63 and "??" or tostring(lv)) or nil, nil,
            WoWpoCesku_BossNpc and WoWpoCesku_BossNpc[key] and WoWpoCesku_BossNpc[key][b[1]])
    end
    local sel
    for _, b in ipairs(bosses) do if b[1] == cur then sel = b end end

    -- hlavička: portrét vpravo, jméno a popis vlevo
    local npc = WoWpoCesku_BossNpc and WoWpoCesku_BossNpc[key] and WoWpoCesku_BossNpc[key][sel[1]]
    local hasModel = showPortrait(R, npc)
    local textW = hasModel and (R.w - 134) or nil
    addText(R, sel[1], 21, RED, 2, 0, textW, TITLE_FONT)
    if sel[2] and sel[2] ~= "" then addText(R, sel[2], 12, SEPIA, 4, 0, textW) end
    if killed[sel[1]] then addText(R, GREEN .. "Poražen " .. date("%d.%m.%Y", killed[sel[1]]) .. "|r", 12, INK, 6, 0, textW) end
    local note = WoWpoCesku_PostavyNote and WoWpoCesku_PostavyNote(sel[1])
    if note then addText(R, note, 12, INK, 8, 0, textW) end
    if hasModel and R.y < 158 then R.y = 158 end
    addRule(R)
    local loot = {}
    local seenIds = {}
    local learned = WoWpoCeskuSeen and WoWpoCeskuSeen.loot and WoWpoCeskuSeen.loot[key] and WoWpoCeskuSeen.loot[key][sel[1]]
    if learned then
        local ids = {}
        for id in pairs(learned) do ids[#ids + 1] = id end
        table.sort(ids, function(a, b) return (learned[a].q or 0) > (learned[b].q or 0) or ((learned[a].q or 0) == (learned[b].q or 0) and a < b) end)
        for _, id in ipairs(ids) do
            loot[#loot + 1] = { learned[id].name or ("item " .. id), learned[id].q or 3, id, true }
            seenIds[id] = true
        end
    end
    local db = WoWpoCesku_BossLoot and WoWpoCesku_BossLoot[key] and WoWpoCesku_BossLoot[key][sel[1]]
    for _, it in ipairs(db or {}) do
        if not seenIds[it[3]] then loot[#loot + 1] = it end
    end
    if #loot > 0 then
        addText(R, "Může padnout", 14, RED, 6)
        for _, it in ipairs(loot) do addItem(R, it[1], it[2], it[3], it[4]) end
        addText(R, "Zlatá hvězdička = padlo ti to ve hře (potvrzeno). Ostatní jsou z classic databáze a ve WoW Forever se mohou lišit. Najeď myší na předmět.", 11, SEPIA, 4)
    else
        addText(R, "V databázi pro něj není žádné zelené, modré ani epické vybavení.", 12, SEPIA, 4)
    end
end

local function renderQuests(key)
    local L, R = win.left, win.right
    reset(L); reset(R)
    local list = questList(key)
    if #list == 0 then
        addText(R, "K téhle instanci nemám v databázi žádné questy.", 13, INK)
        return
    end
    local cur = state.quest[key]
    local found = false
    for _, e in ipairs(list) do if e[1] == cur then found = true end end
    if not found then cur = list[1][1]; state.quest[key] = cur end
    for _, e in ipairs(list) do
        local cz = WoWpoCesku_Data and WoWpoCesku_Data[e[1]] and WoWpoCesku_Data[e[1]].title
        local title = (cz and cz ~= e[2]) and cz or e[2]
        local emblem = (e[5] == "H" and "Interface\\Icons\\INV_BannerPVP_01") or (e[5] == "A" and "Interface\\Icons\\INV_BannerPVP_02") or nil
        addRow(L, title, ("od levelu %d"):format(e[4]), questDone(e[1]), e[1] == cur,
            function() state.quest[key] = e[1]; showDetail() end,
            "Interface\\GossipFrame\\AvailableQuestIcon", nil, emblem)
    end
    local sel
    for _, e in ipairs(list) do if e[1] == cur then sel = e end end
    local id = sel[1]
    local d = WoWpoCesku_Data and WoWpoCesku_Data[id]
    local cz = d and d.title
    addText(R, (cz and cz ~= sel[2]) and cz or sel[2], 19, RED, 2)
    if cz and cz ~= sel[2] then addText(R, sel[2], 12, SEPIA, 4) end
    addText(R, ("Level questu %d · dostupný od levelu %d"):format(sel[3], sel[4]) .. (questDone(id) and ("  " .. GREEN .. "(splněno)|r") or ""), 12, SEPIA, 6)
    addRule(R)
    local obj = d and d.objectives
    if obj and obj ~= "" then
        addText(R, "Cíl", 14, RED, 2)
        addText(R, obj, 13, INK, 10)
    end
    local place = WoWpoCesku_DungeonQuestPlaces and WoWpoCesku_DungeonQuestPlaces[id]
    addText(R, "Začíná u", 14, RED, 2)
    if sel[6] and sel[6] ~= "" then
        addText(R, sel[6] .. (place and (", " .. place) or ""), 13, INK, 10)
    else
        addText(R, "Začíná předmětem, který najdeš v dungeonu nebo u nepřítele.", 13, INK, 10)
    end
    local qpos = WoWpoCesku_QuestPos and WoWpoCesku_QuestPos[id]
    if qpos and qpos[1] then
        addButton(R, "Zobrazit na mapě", function() showOnMap(qpos[1], (sel[6] and sel[6] ~= "" and sel[6]) or "zacatek questu") end)
        R.y = R.y + 4
    end
    local ends = WoWpoCesku_DungeonQuestEnds and WoWpoCesku_DungeonQuestEnds[id]
    if ends then
        addText(R, "Odevzdává se u", 14, RED, 2)
        addText(R, ends, 13, INK, 10)
        if qpos and qpos[2] then
            addButton(R, "Zobrazit na mapě", function() showOnMap(qpos[2], ends:match("^(.-) – ") or "odevzdani questu") end)
            R.y = R.y + 4
        end
    end
    if sel[7] and sel[7] ~= "" then
        addText(R, "Odměna", 14, RED, 2)
        addText(R, sel[7], 13, INK, 10)
    end
    addText(R, "Podle classic databáze. Ve WoW Forever se může něco lišit.", 11, SEPIA, 4)
end

local function renderMap(key)
    local R = win.right
    reset(win.left); reset(R)
    local d = mapData(key)
    if not d then addText(R, "Mapu téhle instance se nepodařilo načíst.", 13, INK) return end
    local layer = d.layer
    local textures = C_Map.GetMapArtLayerTextures(d.uiMap, 1)
    local mw = R.w
    local k = mw / layer.layerWidth
    local mh = layer.layerHeight * k
    if not R.map then
        local m = CreateFrame("Frame", nil, R, "BackdropTemplate")
        m:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
        m:SetBackdropColor(0.12, 0.08, 0.05, 1)
        m:SetBackdropBorderColor(0.50, 0.30, 0.16, 1)
        m.clip = CreateFrame("Frame", nil, m)
        m.clip:SetPoint("TOPLEFT", 2, -2)
        m.clip:SetPoint("BOTTOMRIGHT", -2, 2)
        m.clip:SetClipsChildren(true)
        m.tiles, m.pins = {}, {}
        R.map = m
    end
    local m = R.map
    m:Show()
    m:ClearAllPoints()
    m:SetPoint("TOPLEFT", 0, 0)
    m:SetSize(mw, mh + 4)
    for _, t in ipairs(m.tiles) do t:Hide() end
    for _, p in ipairs(m.pins) do p:Hide() end
    local cols = math.ceil(layer.layerWidth / layer.tileWidth)
    for i, fileID in ipairs(textures or {}) do
        local t = m.tiles[i]
        if not t then t = m.clip:CreateTexture(nil, "ARTWORK"); m.tiles[i] = t end
        local col, row = (i - 1) % cols, math.floor((i - 1) / cols)
        t:SetTexture(fileID)
        t:SetSize(layer.tileWidth * k, layer.tileHeight * k)
        t:ClearAllPoints()
        t:SetPoint("TOPLEFT", m.clip, "TOPLEFT", col * layer.tileWidth * k, -row * layer.tileHeight * k)
        t:Show()
    end
    local killed = killedBosses(key)
    local function pin(i, u, v, label, icon, done, onClick)
        local p = m.pins[i]
        if not p then
            p = CreateFrame("Button", nil, m)
            p:SetSize(26, 26)
            p.icon = p:CreateTexture(nil, "ARTWORK")
            p.icon:SetAllPoints()
            p.ring = p:CreateTexture(nil, "OVERLAY")
            p.ring:SetPoint("BOTTOMRIGHT", 4, -4)
            p.ring:SetSize(14, 14)
            p.ring:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            p:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
            m.pins[i] = p
        end
        p:ClearAllPoints()
        p:SetPoint("CENTER", m, "TOPLEFT", 2 + u * (mw - 4), -(2 + v * (mh)))
        p.icon:SetTexture(icon)
        p.ring:SetShown(done and true or false)
        p:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(label)
            if onClick then GameTooltip:AddLine("Klikni a zobrazí se kořist.", 0.8, 0.8, 0.8) end
            GameTooltip:Show()
        end)
        p:SetScript("OnLeave", function() GameTooltip:Hide() end)
        p:SetScript("OnClick", onClick)
        p:Show()
    end
    local n = 0
    if d.entry then
        n = n + 1
        pin(n, d.entry.u, d.entry.v, "Vchod", "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4", false, nil)
    end
    for _, pt in ipairs(d.pins) do
        n = n + 1
        pin(n, pt.u, pt.v, pt.name, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8", killed[pt.name] ~= nil,
            function() state.boss[key] = pt.name; state.tab = "bossove"; showDetail() end)
    end
    R.y = mh + 12
    addText(R, ("Značky: lebka = boss, zelená značka = poražen" .. (d.entry and ", trojúhelník = vchod" or "") .. ". Zobrazeno %d z %d bossů; polohy jsou z classic databáze a jsou přibližné."):format(#d.pins, d.total), 11, SEPIA, 4)
end

local function renderGuide(key)
    local R = win.right
    reset(win.left); reset(R)
    local g = WoWpoCesku_DungeonGuide and WoWpoCesku_DungeonGuide[key]
    if not g then addText(R, "Průvodce pro tuhle instanci ještě není.", 13, INK) return end
    addText(R, g, 13, INK, 10)
    local T = WoWpoCesku_LoreTajemstvi and WoWpoCesku_LoreTajemstvi[key]
    if T then
        addRule(R)
        addText(R, "Tajemství a drobnosti", 15, RED, 6)
        addText(R, T, 12, INK, 8)
    end
end

-------------------------------------------------------------------------------
-- Přehled a detail
-------------------------------------------------------------------------------
local function renderList()
    local c = win.browse
    reset(c)
    local colW = math.floor((c.w - 12) / 2)
    local CARD_H = 76
    local function card(key, x, y)
        c.nc = c.nc + 1
        local b = c.cards[c.nc]
        if not b then
            b = CreateFrame("Button", nil, c)
            b:SetHeight(CARD_H)
            b.banner = makeBanner(b)
            b.banner:SetAllPoints()
            b.over = CreateFrame("Frame", nil, b)
            b.over:SetAllPoints()
            b.over:SetFrameLevel(b:GetFrameLevel() + 5)
            b.name = text(b.over, 17, 1, 0.82, 0.25)
            b.name:SetFont(TITLE_FONT, 17, "OUTLINE")
            b.name:SetPoint("TOPLEFT", 14, -10)
            b.name:SetShadowOffset(1, -1)
            b.info = text(b.over, 12, 0.95, 0.90, 0.80)
            b.info:SetPoint("TOPLEFT", b.name, "BOTTOMLEFT", 0, -4)
            b.info:SetShadowOffset(1, -1)
            b.prog = text(b.over, 11, 0.85, 0.80, 0.68)
            b.prog:SetPoint("TOPLEFT", b.info, "BOTTOMLEFT", 0, -2)
            b.prog:SetShadowOffset(1, -1)
            b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            b:SetFrameLevel(b:GetFrameLevel() + 1)
            c.cards[c.nc] = b
        end
        b:ClearAllPoints()
        b:SetPoint("TOPLEFT", x, -y)
        b:SetWidth(colW)
        b.name:SetWidth(colW - 28)
        b.info:SetWidth(colW - 28)
        b.prog:SetWidth(colW - 28)
        setBanner(b.banner, key, colW, CARD_H)
        b.name:SetText(key)
        local bosses, quests = bossList(key), questList(key)
        local killed, n = killedBosses(key), 0
        for _, bs in ipairs(bosses) do if killed[bs[1]] then n = n + 1 end end
        local lv = levelText(key)
        b.info:SetText((lv or "") .. ((lv and #quests > 0) and " · " or "") .. (#quests > 0 and (#quests .. " questů") or ""))
        b.prog:SetText(#bosses > 0 and ("Poraženo bossů: " .. n .. " z " .. #bosses .. ((n == #bosses) and "  ✔" or "")) or "")
        b:SetScript("OnClick", function() state.view = "detail"; state.key = key; settings().djKey = key; showDetail() end)
        b:Show()
    end
    local function section(label, list)
        addText(c, label, 17, RED, 4)
        addRule(c)
        local y = c.y
        for i, key in ipairs(list) do
            local col = (i - 1) % 2
            local row = math.floor((i - 1) / 2)
            card(key, col * (colW + 12), y + row * (CARD_H + 8))
        end
        c.y = y + math.ceil(#list / 2) * (CARD_H + 8) + 8
    end
    section("Dungeony", DUNGEONS)
    section("Raidy", RAIDS)
    c:SetHeight(c.y + 10)
end

local function setTabs()
    local prev
    for i = 1, #win.tabs do
        local t = win.tabs[i]
        local avail = (t.id ~= "mapa") or (mapData(state.key) ~= nil)
        t:SetShown(avail)
        if avail then
            t:ClearAllPoints()
            if prev then t:SetPoint("RIGHT", prev, "LEFT", -4, 0) else t:SetPoint("TOPRIGHT", -44, -152) end
            prev = t
        end
    end
    if state.tab == "mapa" and mapData(state.key) == nil then state.tab = "bossove" end
    for _, t in ipairs(win.tabs) do
        local active = (t.id == state.tab)
        if active then t:LockHighlight() else t:UnlockHighlight() end
        t:SetNormalFontObject(active and win.fontBtnOn or win.fontBtn)
        if t.SetEnabled then t:SetEnabled(true) end
    end
end

showDetail = function()
    if not win then return end
    if state.view == "list" or not state.key then
        win.detail:Hide(); win.browseSf:Show()
        renderList()
        win.browseSf:SetVerticalScroll(0)
        return
    end
    win.browseSf:Hide(); win.detail:Show()
    local key = state.key
    setBanner(win.banner, key, 730, 88)
    win.name:SetText(key)
    win.tag:SetText(levelText(key) or "")
    setTabs()
    local twoPane = (state.tab ~= "pruvodce" and state.tab ~= "mapa")
    win.leftSf:SetShown(twoPane)
    win.boxL:SetShown(twoPane)
    win.boxR:ClearAllPoints()
    win.boxR:SetPoint("TOPLEFT", twoPane and 328 or 24, -184)
    win.boxR:SetSize(twoPane and 440 or 744, 372)
    win.rightSf:ClearAllPoints()
    if twoPane then
        win.rightSf:SetPoint("TOPLEFT", 336, -190)
        win.rightSf:SetSize(402, 360)
        win.right.w = 402 - 26
    else
        win.rightSf:SetPoint("TOPLEFT", 30, -190)
        win.rightSf:SetSize(708, 360)
        win.right.w = 708 - 26
    end
    win.right:SetWidth(win.right.w)
    if state.tab == "bossove" then renderBosses(key)
    elseif state.tab == "questy" then renderQuests(key)
    elseif state.tab == "mapa" then renderMap(key)
    else renderGuide(key) end
    win.left:SetHeight(math.max(win.left.y + 10, 10))
    win.right:SetHeight(math.max(win.right.y + 10, 10))
    win.rightSf:SetVerticalScroll(0)
    win.leftSf:SetVerticalScroll(0)
    for _, pair in ipairs({ { win.leftSf, win.left }, { win.rightSf, win.right } }) do
        local sb = pair[1].ScrollBar
        if type(sb) == "table" and sb.SetShown then sb:SetShown((pair[2]:GetHeight() or 0) > (pair[1]:GetHeight() or 0) + 1) end
    end
end

-------------------------------------------------------------------------------
-- Okno
-------------------------------------------------------------------------------
local function build()
    win = CreateFrame("Frame", "WoWpoCeskuDungeony", UIParent, "BackdropTemplate")
    win:SetSize(800, 600)
    win:SetPoint("CENTER")
    win:SetFrameStrata("DIALOG")
    win:SetToplevel(true)
    win:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 },
    })
    win:SetBackdropColor(0.23, 0.13, 0.07, 1)
    local tex = win:CreateTexture(nil, "BACKGROUND", nil, 1)
    tex:SetPoint("TOPLEFT", 11, -11)
    tex:SetPoint("BOTTOMRIGHT", -11, 11)
    tex:SetTexture(PARCHMENT)
    win:EnableMouse(true)
    win:SetMovable(true)
    win:SetClampedToScreen(true)
    win:RegisterForDrag("LeftButton")
    win:SetScript("OnDragStart", win.StartMoving)
    win:SetScript("OnDragStop", win.StopMovingOrSizing)
    win:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "WoWpoCeskuDungeony") end

    win.fontNormal = newFont("WoWpoCeskuDJTab", 12, INK[1], INK[2], INK[3])
    win.fontActive = newFont("WoWpoCeskuDJTabOn", 12, RED[1], RED[2], RED[3])
    win.fontBack = newFont("WoWpoCeskuDJBack", 12, 1, 0.92, 0.75)
    win.fontBtn = newFont("WoWpoCeskuDJBtn", 12, 1, 0.82, 0)
    win.fontBtnOn = newFont("WoWpoCeskuDJBtnOn", 12, 1, 1, 1)

    local close = CreateFrame("Button", nil, win, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -8, -8)

    local head = text(win, 22, RED[1], RED[2], RED[3])
    head:SetPoint("TOP", 0, -24)
    head:SetText("Dungeonový deník")

    -- přehled (karty)
    win.browseSf, win.browse = newScroll(win, 30, -70, 740, 500)
    win.browse.w = 740 - 26

    -- detail
    win.detail = CreateFrame("Frame", nil, win)
    win.detail:SetAllPoints()

    win.banner = makeBanner(win.detail)
    win.banner:SetPoint("TOPLEFT", 30, -62)
    win.banner:SetSize(730, 88)

    local back = CreateFrame("Button", nil, win.detail, "UIPanelButtonTemplate")
    back:SetFrameLevel(win.detail:GetFrameLevel() + 7)
    back:SetSize(110, 26)
    back:SetPoint("TOPLEFT", win.banner, "TOPLEFT", 12, -8)
    back:SetNormalFontObject(win.fontBtn)
    back:SetHighlightFontObject(win.fontBtnOn)
    back:SetText("‹ Přehled")
    back:SetScript("OnClick", function() state.view = "list"; showDetail() end)

    local entr = CreateFrame("Button", nil, win.detail, "UIPanelButtonTemplate")
    entr:SetFrameLevel(win.detail:GetFrameLevel() + 7)
    entr:SetSize(150, 26)
    entr:SetPoint("TOPRIGHT", win.banner, "TOPRIGHT", -12, -8)
    entr:SetNormalFontObject(win.fontBtn)
    entr:SetHighlightFontObject(win.fontBtnOn)
    entr.ico = entr:CreateTexture(nil, "OVERLAY")
    entr.ico:SetSize(20, 20)
    entr.ico:SetPoint("LEFT", 8, 0)
    entr.ico:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    entr:SetText("     Zobrazit vchod")
    entr:SetScript("OnClick", function() if state.key then showEntrance(state.key) end end)

    win.top = CreateFrame("Frame", nil, win.detail)
    win.top:SetAllPoints()
    win.top:SetFrameLevel(win.detail:GetFrameLevel() + 6)
    win.name = text(win.top, 26, 1, 0.82, 0.25)
    win.name:SetFont(TITLE_FONT, 26, "OUTLINE")
    win.name:SetPoint("TOPLEFT", win.banner, "TOPLEFT", 16, -36)
    win.name:SetWidth(460)
    win.name:SetShadowOffset(1, -1)
    win.tag = text(win.top, 12, 0.92, 0.86, 0.72)
    win.tag:SetPoint("TOPLEFT", win.name, "BOTTOMLEFT", 0, -1)
    win.tag:SetWidth(460)
    win.tag:SetShadowOffset(1, -1)

    win.tabs = {}
    local prev
    for i = #TABS, 1, -1 do
        local t = TABS[i]
        local b = CreateFrame("Button", nil, win.detail, "UIPanelButtonTemplate")
        b:SetSize(156, 30)
        if prev then b:SetPoint("RIGHT", prev, "LEFT", -2, 0) else b:SetPoint("TOPRIGHT", -40, -150) end
        b.ico = b:CreateTexture(nil, "OVERLAY")
        b.ico:SetSize(22, 22)
        b.ico:SetPoint("LEFT", 8, 0)
        b.ico:SetTexture(t.icon)
        b.bg = b:CreateTexture(nil, "BACKGROUND")
        b.bg:SetSize(1, 1)
        b.under = b:CreateTexture(nil, "BACKGROUND")
        b.under:SetSize(1, 1)
        b:SetNormalFontObject(win.fontBtn)
        b:SetHighlightFontObject(win.fontBtnOn)
        b:SetText("     " .. t.label)
        b.id = t.id
        b:SetScript("OnClick", function() state.tab = t.id; showDetail() end)
        win.tabs[#win.tabs + 1] = b
        prev = b
    end

    win.boxL = boxFrame(win.detail, win.detail:GetFrameLevel() + 1)
    win.boxL:SetPoint("TOPLEFT", 24, -184)
    win.boxL:SetSize(284, 372)
    win.boxR = boxFrame(win.detail, win.detail:GetFrameLevel() + 1)
    win.boxR:SetPoint("TOPLEFT", 328, -184)
    win.boxR:SetSize(440, 372)
    win.leftSf, win.left = newScroll(win.detail, 30, -190, 252, 360)
    win.rightSf, win.right = newScroll(win.detail, 336, -190, 402, 360)
    win.right.w = 402 - 26
end

-------------------------------------------------------------------------------
-- Učení kořisti: co skutečně padlo z bosse (Forever mění kořist oproti classic databázi).
-- Ukládá se do WoWpoCeskuSeen.loot[instance][boss][ID předmětu]; deník to ukáže jako potvrzené.
-------------------------------------------------------------------------------
local function secretValue(v) return issecretvalue and issecretvalue(v) end

local function bossFromLoot(key)
    local ids = WoWpoCesku_BossNpc and WoWpoCesku_BossNpc[key]
    if ids and GetLootSourceInfo then
        local ok, g1 = pcall(GetLootSourceInfo, 1)
        if ok and type(g1) == "string" and not secretValue(g1) then
            local npc = tonumber(select(6, strsplit("-", g1)))
            if npc then
                for name, id in pairs(ids) do if id == npc then return name end end
            end
        end
    end
    local last = WoWpoCesku_LastBoss
    if last and last.key == key and GetTime and (GetTime() - last.t) < 120 then return last.name end
end

local lootFrame = CreateFrame("Frame")
lootFrame:RegisterEvent("LOOT_OPENED")
lootFrame:SetScript("OnEvent", function()
    if not (IsInInstance and IsInInstance()) then return end
    local key = WoWpoCesku_CurrentZoneKey and WoWpoCesku_CurrentZoneKey()
    if not (key and WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key]) then return end
    local n = GetNumLootItems and GetNumLootItems() or 0
    if n == 0 then return end
    local boss = bossFromLoot(key)
    if not boss then return end
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.loot = WoWpoCeskuSeen.loot or {}
    local L = WoWpoCeskuSeen.loot
    L[key] = L[key] or {}
    L[key][boss] = L[key][boss] or {}
    for i = 1, n do
        local ok, link = pcall(GetLootSlotLink, i)
        if ok and type(link) == "string" and not secretValue(link) then
            local id = tonumber(link:match("item:(%d+)"))
            if id then
                local okI, _, _, _, equipLoc, _, classID = pcall(GetItemInfoInstant, id)
                local gear = okI and ((classID == 2 or classID == 4) or (equipLoc and equipLoc ~= ""))
                if gear then
                    local q = C_Item and C_Item.GetItemQualityByID and select(2, pcall(C_Item.GetItemQualityByID, id))
                    local name = link:match("%[(.-)%]")
                    L[key][boss][id] = { name = name, q = tonumber(q) or 3 }
                end
            end
        end
    end
end)

local refreshCount = 0
local itemFrame = CreateFrame("Frame")
itemFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
itemFrame:SetScript("OnEvent", function()
    if not (win and win:IsShown() and itemPending) or refreshCount >= 30 then return end
    itemPending = false
    refreshCount = refreshCount + 1
    C_Timer.After(0.4, function() if win and win:IsShown() then showDetail() end end)
end)

-- Otevře deník; key = instance (nepovinné), tab = záložka (nepovinné).
-- Bez parametrů: v dungeonu se otevře jeho detail, jinde přehled; opakované volání okno zavře.
function WoWpoCesku_DungeonJournal(key, tab)
    if not win then build() end
    if win:IsShown() and not key and not tab then win:Hide() return end
    if tab then state.tab = tab end
    if not key then
        local zone = WoWpoCesku_CurrentZoneKey and WoWpoCesku_CurrentZoneKey()
        if zone and WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[zone] then key = zone end
    end
    if key and WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key] then
        state.view, state.key = "detail", key
        settings().djKey = key
    elseif not state.key then
        state.view = "list"
    end
    refreshCount = 0
    win:Show()
    win:Raise()
    showDetail()
end

-- Diagnostika mapy: /czq mapa [název instance]. Vypíše, jak se přepočet povedl; uvnitř dungeonu porovná i tvou polohu.
function WoWpoCesku_MapDebug(key)
    if key then
        local want = key:lower()
        for k in pairs(WoWpoCesku_BossPos or {}) do
            if k:lower():find(want, 1, true) then key = k break end
        end
    end
    key = key or (WoWpoCesku_CurrentZoneKey and WoWpoCesku_CurrentZoneKey())
    if not (key and WoWpoCesku_BossPos and WoWpoCesku_BossPos[key]) then
        say("mapa: tohle neni dungeon s polohami (zkus /czq mapa Deadmines nebo vstup do dungeonu).")
        return
    end
    local zti, zbest, ztotal = zoneFit()
    say(("zony (pro tlacitka na mape): prepocet c. %d, %d z %d smerovych kontrol spravne"):format(zti or 0, zbest or 0, ztotal or 0))
    mapCache[key] = nil
    local d = mapData(key)
    if not d then
        say("mapa " .. key .. ": NEPODARILO SE (klient nezna mapu instance nebo se body nevesly). Zalozka Mapa se nenabizi.")
    else
        say(("mapa %s: OK, uiMapID %d, prepocet c. %d, bossu na mape %d z %d%s"):format(key, d.uiMap, d.ti, #d.pins, d.total, d.entry and ", vchod ano" or ", vchod ne"))
    end
    if UnitPosition and C_Map and C_Map.GetBestMapForUnit then
        local y, x = UnitPosition("player")
        local id = C_Map.GetBestMapForUnit("player")
        local p = id and C_Map.GetPlayerMapPosition and C_Map.GetPlayerMapPosition(id, "player")
        local u, v
        if p then u, v = xy(p) end
        say(("tvoje poloha: UnitPosition %s, %s | uiMap %s | na mape %s, %s"):format(tostring(x), tostring(y), tostring(id), tostring(u), tostring(v)))
    end
end

-- Diagnostika map instance: /czq mapa2 <název> vypíše všechny mapy klienta, jejichž jméno obsahuje hledaný text.
function WoWpoCesku_MapList(text)
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    if not (text and text ~= "" and C_Map and C_Map.GetMapInfo) then say("pouziti: /czq mapa2 deadmines") return end
    local want, n = text:lower(), 0
    for id = 1, 3500 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and info.name and info.name:lower():find(want, 1, true) then
            n = n + 1
            local wp = "-"
            if C_Map.GetWorldPosFromMapPos and CreateVector2D then
                local ok2, inst, pos = pcall(C_Map.GetWorldPosFromMapPos, id, CreateVector2D(0.5, 0.5))
                if ok2 and inst then wp = ("svet %s [%s, %s]"):format(tostring(inst), tostring(pos and select(1, xy(pos))), tostring(pos and select(2, xy(pos)))) end
            end
            local layers = C_Map.GetMapArtLayers and C_Map.GetMapArtLayers(id)
            say(("uiMap %d '%s' typ %s, rodic %s, vrstev %s, %s"):format(id, info.name, tostring(info.mapType), tostring(info.parentMapID), tostring(layers and #layers or 0), wp))
        end
    end
    if n == 0 then say("zadna mapa se jmenem obsahujicim '" .. text .. "'") end
end

-- Zkouška obrázků z klienta: /czq obr  (načítací obrazovky a obrázky Encounter Journalu; nic se nekopíruje, jen se zobrazí cesty hry)
local previewWin
function WoWpoCesku_ArtTest()
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local cands = {
        { "Glues LoadScreenRagefireChasm", "Interface\\Glues\\LoadingScreens\\LoadScreenRagefireChasm" },
        { "Glues LoadScreenRagefire", "Interface\\Glues\\LoadingScreens\\LoadScreenRagefire" },
        { "Glues LoadingScreen_RagefireChasm", "Interface\\Glues\\LoadingScreens\\LoadingScreen_RagefireChasm" },
        { "LoadingScreens RagefireChasm", "Interface\\LoadingScreens\\LoadScreenRagefireChasm" },
        { "EJ pozadi", "Interface\\EncounterJournal\\UI-EJ-DungeonBG-RagefireChasm" },
        { "EJ lore", "Interface\\EncounterJournal\\UI-EJ-LOREBG-RagefireChasm" },
        { "EJ tlacitko", "Interface\\EncounterJournal\\UI-EJ-BOSS-RagefireChasm" },
    }
    -- Encounter Journal API (pokud ji klient má): obrázky instancí podle jména
    if EJ_GetInstanceByIndex then
        for tier = 1, 2 do
            if EJ_SelectTier then pcall(EJ_SelectTier, tier) end
            for i = 1, 60 do
                local ok, id, name, _, _, button, small, _, _, loreImage = pcall(EJ_GetInstanceByIndex, i, false)
                if not ok or not id then break end
                if name and name:lower():find("ragefire", 1, true) then
                    cands[#cands + 1] = { "EJ API button " .. tostring(name), button }
                    cands[#cands + 1] = { "EJ API small", small }
                    cands[#cands + 1] = { "EJ API lore", loreImage }
                end
            end
        end
    else
        say("Encounter Journal API klient nema (EJ_GetInstanceByIndex).")
    end
    if not previewWin then
        local f = CreateFrame("Frame", "WoWpoCeskuObrTest", UIParent, "BackdropTemplate")
        f:SetSize(760, 560)
        f:SetPoint("CENTER")
        f:SetFrameStrata("DIALOG")
        f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.1, 0.07, 0.04, 1)
        f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local c = CreateFrame("Button", nil, f, "UIPanelCloseButton"); c:SetPoint("TOPRIGHT", -6, -6)
        f.items = {}
        previewWin = f
    end
    local f = previewWin
    for _, it in ipairs(f.items) do it.tex:Hide(); it.label:Hide() end
    for i, c in ipairs(cands) do
        local it = f.items[i]
        if not it then
            it = {}
            it.tex = f:CreateTexture(nil, "ARTWORK")
            it.label = f:CreateFontString(nil, "OVERLAY")
            it.label:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 10, "")
            f.items[i] = it
        end
        local col, row = (i - 1) % 3, math.floor((i - 1) / 3)
        it.tex:ClearAllPoints()
        it.tex:SetPoint("TOPLEFT", 22 + col * 240, -30 - row * 130)
        it.tex:SetSize(228, 100)
        it.tex:SetTexture(c[2] or "")
        it.tex:Show()
        it.label:ClearAllPoints()
        it.label:SetPoint("TOPLEFT", it.tex, "BOTTOMLEFT", 0, -2)
        it.label:SetWidth(228)
        it.label:SetText(c[1])
        it.label:Show()
    end
    f:Show()
    say("okno /czq obr: ukazuje obrazky z klienta; ktere jsou videt (ne cerne/zelene), pouzijeme. Pošli screenshot.")
end

-- Zkouška názvů obrázků Encounter Journalu pro všechny instance: /czq obr2
local nameWin
function WoWpoCesku_ArtTest2()
    local all = {}
    for _, k in ipairs(DUNGEONS) do all[#all + 1] = k end
    for _, k in ipairs(RAIDS) do all[#all + 1] = k end
    local items = {}
    for _, key in ipairs(all) do
        local base = key:gsub("[^%w]", "")
        local noThe = base:gsub("^The", "")
        local list = { base }
        if noThe ~= base then list[#list + 1] = noThe end
        if key == "The Stockade" then list[#list + 1] = "StormwindStockade" end
        if key == "Sunken Temple" then list[#list + 1] = "TempleofAtalHakkar" end
        if key == "Zul'Farrak" then list[#list + 1] = "ZulFarrak" end
        if key == "Zul'Gurub" then list[#list + 1] = "ZulGurub" end
        if key == "Onyxia's Lair" then list[#list + 1] = "Onyxia" end
        for _, n in ipairs(list) do items[#items + 1] = { n, "Interface\\EncounterJournal\\UI-EJ-LOREBG-" .. n } end
    end
    if not nameWin then
        local f = CreateFrame("Frame", "WoWpoCeskuObr2", UIParent, "BackdropTemplate")
        f:SetSize(1010, 560)
        f:SetPoint("CENTER")
        f:SetFrameStrata("DIALOG")
        f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.1, 0.07, 0.04, 1)
        f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local c = CreateFrame("Button", nil, f, "UIPanelCloseButton"); c:SetPoint("TOPRIGHT", -6, -6)
        f.items = {}
        nameWin = f
    end
    local f = nameWin
    for _, it in ipairs(f.items) do it.tex:Hide(); it.label:Hide() end
    for i, it in ipairs(items) do
        local t = f.items[i]
        if not t then
            t = { tex = f:CreateTexture(nil, "ARTWORK"), label = f:CreateFontString(nil, "OVERLAY") }
            t.label:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 10, "")
            f.items[i] = t
        end
        local col, row = (i - 1) % 6, math.floor((i - 1) / 6)
        t.tex:ClearAllPoints()
        t.tex:SetPoint("TOPLEFT", 22 + col * 160, -30 - row * 66)
        t.tex:SetSize(152, 46)
        t.tex:SetTexture(it[2])
        t.tex:Show()
        t.label:ClearAllPoints()
        t.label:SetPoint("TOPLEFT", t.tex, "BOTTOMLEFT", 0, -1)
        t.label:SetWidth(152)
        t.label:SetText(it[1])
        t.label:Show()
    end
    f:Show()
    print("|cffffd100WoWpoCesku:|r /czq obr2: " .. #items .. " nahledu. Co je videt jako obrazek, klient zna. Posli screenshot.")
end

-- Měřítko oblasti obrázku v textuře klienta: /czq obr3 [název souboru, např. RagefireChasm]
local rulerWin
function WoWpoCesku_ArtTest3(name)
    name = (name and name ~= "") and name or "RagefireChasm"
    if not rulerWin then
        local f = CreateFrame("Frame", "WoWpoCeskuObr3", UIParent, "BackdropTemplate")
        f:SetSize(1040, 560)
        f:SetPoint("CENTER")
        f:SetFrameStrata("DIALOG")
        f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.35, 0.05, 0.35, 1)   -- výrazná barva, aby byla vidět průhledná místa
        f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local c = CreateFrame("Button", nil, f, "UIPanelCloseButton"); c:SetPoint("TOPRIGHT", -6, -6)
        f.tex = f:CreateTexture(nil, "ARTWORK")
        f.tex:SetPoint("TOPLEFT", 40, -60)
        f.tex:SetSize(960, 480)      -- celá textura bez výřezu, poměr 2:1
        f.lines = {}
        for i = 0, 10 do
            local v = f:CreateTexture(nil, "OVERLAY")
            v:SetColorTexture(1, 1, 0, 0.7); v:SetSize(1, 480); v:SetPoint("TOPLEFT", f.tex, "TOPLEFT", i * 96, 0)
            local h = f:CreateTexture(nil, "OVERLAY")
            h:SetColorTexture(0, 1, 1, 0.7); h:SetSize(960, 1); h:SetPoint("TOPLEFT", f.tex, "TOPLEFT", 0, -i * 48)
            local t = f:CreateFontString(nil, "OVERLAY"); t:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 11, "")
            t:SetPoint("BOTTOM", v, "TOP", 0, 2); t:SetText(tostring(i * 10))
            f.lines[#f.lines + 1] = v
        end
        f.title = f:CreateFontString(nil, "OVERLAY"); f.title:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 12, "")
        f.title:SetPoint("TOPLEFT", 40, -20)
        rulerWin = f
    end
    rulerWin.tex:SetTexture("Interface\\EncounterJournal\\UI-EJ-LOREBG-" .. name)
    rulerWin.title:SetText("UI-EJ-LOREBG-" .. name .. " (cela textura 2:1; zluta = vodorovne procenta, tyrkysova = svisle)")
    rulerWin:Show()
end
