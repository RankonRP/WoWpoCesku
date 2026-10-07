-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: Dungeon Kronika – samostatné okno. Přehled dungeonů a raidů, detail se záložkami
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

-- Zobrazují se jen dungeony, které má i původní DungeonJournal; ostatní a raidy jsou zatím skryté (data zůstávají).
-- Skryté dungeony: Razorfen Downs, Uldaman, Zul'Farrak, Maraudon, Sunken Temple, Blackrock Depths, Blackrock Spire, Dire Maul, Scholomance, Stratholme
-- Skryté raidy: Molten Core, Onyxia's Lair, Blackwing Lair, Zul'Gurub, Ruins of Ahn'Qiraj, Ahn'Qiraj Temple, Naxxramas
local DUNGEONS = { "Hall of Thanes", "Ragefire Chasm", "Ruins of Lordaeron", "The Deadmines", "Wailing Caverns", "Shadowfang Keep", "Blackfathom Deeps", "Excavation Site: Wetlands", "City of Dalaran",
    "The Stockade", "Gnomeregan", "Razorfen Kraul", "Scarlet Monastery: Graveyard", "Scarlet Monastery: Library" }
local RAIDS = {}

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
    ["Ahn'Qiraj Temple"] = { 0.60, 0.50, 0.30 }, ["Naxxramas"] = { 0.40, 0.60, 0.55 }, ["Scarlet Monastery: Graveyard"] = { 0.70, 0.20, 0.20 }, ["Scarlet Monastery: Library"] = { 0.70, 0.20, 0.20 }, ["Ruins of Lordaeron"] = { 0.40, 0.55, 0.30 },
}

local TABS = {
    { id = "pribeh", label = "Příběh", icon = "Interface\\Icons\\INV_Misc_Book_09" },
    { id = "bossove", label = "Bossové a kořist", icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" },
    { id = "questy", label = "Questy", icon = "Interface\\GossipFrame\\AvailableQuestIcon" },
    { id = "mapa", label = "Mapa", icon = "Interface\\Icons\\INV_Misc_Map_01" },
    { id = "pruvodce", label = "Rady", icon = "Interface\\Icons\\INV_Misc_Book_09" },
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

local function questList(key, facArg)
    local out, seen = {}, {}
    local fac = facArg or myFactionLetter()
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
local setDJMark   -- definováno níž (dopředná deklarace)

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
    if settings().djWaypoint and C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
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
    setDJMark(uiMap, u, v, label, "Interface\\GossipFrame\\AvailableQuestIcon", nil, 44)
    say(label .. ": " .. where .. (set and " - znacka je na mape" or " (znacku nastavit nejde, souradnice jsou vyse)") .. (opened and "." or " (otevri mapu klavesou M)."))
end

-------------------------------------------------------------------------------
-- Zobrazit vstup: hra umí říct, kde na mapě zóny je vchod do instance (C_EncounterJournal.GetDungeonEntrancesForMap).
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
                -- kruh pod ikonou: je vidět i když se ikona nenakreslí (tyrkysový kruh se zlatým lemem)
                p.rim = p:CreateTexture(nil, "BACKGROUND", nil, -2)
                p.rim:SetPoint("CENTER")
                p.rim:SetTexture("Interface\\Buttons\\WHITE8x8")
                p.rim:SetVertexColor(0.85, 0.66, 0.2, 1)
                p.ring = p:CreateTexture(nil, "BACKGROUND", nil, -1)
                p.ring:SetPoint("CENTER")
                p.ring:SetTexture("Interface\\Buttons\\WHITE8x8")
                p.ring:SetVertexColor(0.1, 0.5, 0.58, 1)
                pcall(p.rim.SetMask, p.rim, "Interface\\CharacterFrame\\TempPortraitAlphaMask")
                pcall(p.ring.SetMask, p.ring, "Interface\\CharacterFrame\\TempPortraitAlphaMask")
                p.dot = p:CreateTexture(nil, "BACKGROUND", nil, 0)
                p.dot:SetPoint("CENTER")
                p.dot:SetTexture("Interface\\Buttons\\WHITE8x8")
                p.dot:SetVertexColor(0.8, 0.95, 0.95, 1)
                pcall(p.dot.SetMask, p.dot, "Interface\\CharacterFrame\\TempPortraitAlphaMask")
                p.icon = p:CreateTexture(nil, "ARTWORK")
                p.icon:SetAllPoints()
                p:EnableMouse(true)
                p:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:AddLine(self.label or "")
                    GameTooltip:AddLine("Prave tlacitko znacku odstrani.", 0.8, 0.8, 0.8)
                    GameTooltip:Show()
                end)
                p:SetScript("OnLeave", function() GameTooltip:Hide() end)
                p:SetScript("OnMouseUp", function(self, btn) if btn == "RightButton" then wipe(djMarks); drawDJMarks() end end)
                djPins[n] = p
            end
            p.label = m.label
            local usedAtlas = false
            if m.atlas and p.icon.SetAtlas then
                usedAtlas = pcall(p.icon.SetAtlas, p.icon, m.atlas)
            end
            if usedAtlas then
                p:SetSize(m.size or 34, m.size or 34)
                p.glow:Hide()   -- kruhová ikona se září kreslila jako černý čtverec
            else
                if m.icon == "ring" then p.icon:SetTexture(nil) else p.icon:SetTexture(m.icon) end
                p:SetSize(m.size or 40, m.size or 40)

                p.glow:Hide()   -- kreslil se jako černý čtverec
            end
            do
                local sz = p:GetWidth()
                local ringed = (m.icon == "ring") and not usedAtlas
                p.rim:SetShown(ringed); p.ring:SetShown(ringed); p.dot:SetShown(ringed)
                p.rim:SetSize(sz, sz)
                p.ring:SetSize(sz * 0.84, sz * 0.84)
                p.dot:SetSize(sz * 0.40, sz * 0.40)
            end
            p:SetFrameLevel(10000)
            p:ClearAllPoints()
            local placed = WorldMapFrame.SetPinPosition and pcall(WorldMapFrame.SetPinPosition, WorldMapFrame, p, m.u, m.v)
            if not placed then p:SetPoint("CENTER", canvas, "TOPLEFT", m.u * w, -m.v * h) end
            p:Show()
        end
    end
end

local function clearOldWaypoint(uiMap, u, v)
    if settings().djWaypoint then return end
    if not (C_Map and C_Map.GetUserWaypoint and C_Map.ClearUserWaypoint) then return end
    local ok, wp = pcall(C_Map.GetUserWaypoint)
    if ok and wp and wp.uiMapID == uiMap and wp.position then
        local x, y = xy(wp.position)
        if x and y and math.abs(x - u) < 0.03 and math.abs(y - v) < 0.03 then pcall(C_Map.ClearUserWaypoint) end
    end
end

setDJMark = function(uiMap, u, v, label, icon, atlas, size)
    clearOldWaypoint(uiMap, u, v)
    wipe(djMarks)
    djMarks[1] = { uiMap = uiMap, u = u, v = v, label = label, icon = icon, atlas = atlas, size = size }
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

local function isRaid(key)
    for _, r in ipairs(RAIDS) do if r == key then return true end end
    return false
end

local function showEntrance(key)
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local e
    local m = WoWpoCesku_DungeonEntryMap and WoWpoCesku_DungeonEntryMap[key]
    if m then e = { uiMap = m[1], u = m[2], v = m[3], zone = m[4] } end
    if not e then e = findEntrance(key) end
    if not e then
        local o = WoWpoCesku_DungeonEntryOut and WoWpoCesku_DungeonEntryOut[key]
        if o then
            local uiMap, u, v, zname = locate(o[1], o[2], o[3])
            if uiMap then e = { uiMap = uiMap, u = u, v = v, zone = zname } end
        end
    end
    if not e then say(key .. ": vstup se na mape nepodarilo najit (klient ho nenabizi). Viz Prvodce, tam je popis cesty.") return end
    local set = false
    if settings().djWaypoint and C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
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
    setDJMark(e.uiMap, e.u, e.v, key .. " - vstup", "ring", isRaid(key) and "Raid" or "Dungeon", 52)   -- ikona ověřená ve hře (atlas Dungeon se nekreslil)
    say(("vstup %s: %s %.1f, %.1f%s%s"):format(key, e.zone or "?", e.u * 100, e.v * 100, set and " - znacka je na mape" or "", opened and "." or " (otevri mapu klavesou M)."))
end

local BOX = { bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 }
-- erb frakce: nejdřív atlas hry, jinak textura s výřezem (Horda červená, Aliance modrá)
local function setFactionIcon(tex, letter)
    tex:SetTexCoord(0, 1, 0, 1)
    tex:SetTexture(letter == "H" and "Interface\\FriendsFrame\\PlusManz-Horde" or "Interface\\FriendsFrame\\PlusManz-Alliance")
end

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
    ["Gnomeregan"] = "Gnomeregan", ["Razorfen Kraul"] = "RazorfenKraul", ["Scarlet Monastery"] = "ScarletMonastery", ["Scarlet Monastery: Graveyard"] = "ScarletMonastery", ["Scarlet Monastery: Library"] = "ScarletMonastery",
    ["Razorfen Downs"] = "RazorfenDowns", ["Uldaman"] = "Uldaman", ["Zul'Farrak"] = "ZulFarrak", ["Maraudon"] = "Maraudon",
    ["Sunken Temple"] = "SunkenTemple", ["Blackrock Depths"] = "BlackrockDepths", ["Blackrock Spire"] = "BlackrockSpire",
    ["Dire Maul"] = "DireMaul", ["Scholomance"] = "Scholomance", ["Stratholme"] = "Stratholme", ["Molten Core"] = "MoltenCore",
    ["Blackwing Lair"] = "BlackwingLair", ["Zul'Gurub"] = "ZulGurub", ["Ruins of Ahn'Qiraj"] = "RuinsofAhnQiraj", ["Naxxramas"] = "Naxxramas",
}

-- Nové dungeony Forever nemají obrázek v klientu; když má hráč nainstalovaný ForeverDungeonJournal, použijeme jeho obrázek
-- (jen se na něj odkazujeme, nic se nekopíruje; bez toho addonu zůstane barevná plocha nebo vlastní banner).
-- (číselné hodnoty jsou ID souborů – načítací obrazovky Forever přímo z klienta hry)
local EXTERNAL_ART = {
    ["Scarlet Monastery: Graveyard"] = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\ScarletMonasteryGraveyardHome",
    ["Scarlet Monastery: Library"] = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\ScarletMonasteryLibraryHome",
    ["Excavation Site: Wetlands"] = 7963777,
    ["City of Dalaran"] = 7963775,
    ["Ruins of Lordaeron"] = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\RuinsOfLordaeron",
    ["Hall of Thanes"] = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\HallOfThanes",
}

local function externalArt(key)
    local p = EXTERNAL_ART[key]
    if not p then return nil end
    if type(p) == "number" then return p end
    local loaded = C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("ForeverDungeonJournal")
    return loaded and p or nil
end

local function setBanner(frame, key, w, h)
    local slug = WoWpoCesku_DungeonArt and WoWpoCesku_DungeonArt[key]
    local clientName = CLIENT_ART[key]
    if externalArt(key) and not slug then clientName = nil end   -- obrázek křídla z ForeverDungeonJournal, když je k dispozici
    if settings().djArt == "own" then clientName = nil end   -- v nastavení lze zvolit vlastní malované bannery
    local c = ACCENT[key] or { 0.5, 0.4, 0.3 }
    if clientName then
        frame.art:SetTexture("Interface\\EncounterJournal\\UI-EJ-LOREBG-" .. clientName)
        -- obrázek leží v textuře vlevo nahoře (ověřeno /czq obr3), kolem je průhledno; bereme jen vnitřek bez rámečku
        local u0, u1, v0, v1 = 0.055, 0.70, 0.08, 0.575
        local want, have = w / h, ((u1 - u0) * 1024) / ((v1 - v0) * 512)   -- poměr oblasti ~2,6:1
        if want > have then
            local cut = (1 - have / want) / 2 * (v1 - v0)
            frame.art:SetTexCoord(u0, u1, v0 + cut, v1 - cut)
        else
            local cut = (1 - want / have) / 2 * (u1 - u0)
            frame.art:SetTexCoord(u0 + cut, u1 - cut, v0, v1)
        end
        frame.art:SetVertexColor(1, 1, 1, 1)
        frame.art:Show()
    elseif externalArt(key) and not slug then
        frame.art:SetTexture(externalArt(key))
        local want, have = w / h, 2   -- textura 1024×512
        if want > have then
            local cut = (1 - have / want) / 2
            frame.art:SetTexCoord(0, 1, 0.12 + cut * 0.76, 0.88 - cut * 0.76)
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
    c.moneyBox = false
    c.xpBox = false
    c.facA = false
    c.facH = false
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
    if c.moneyBox then c.moneyBox:Hide() end
    if c.xpBox then c.xpBox:Hide() end
    if c.facA then c.facA:Hide() end
    if c.facH then c.facH:Hide() end
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
        b:SetNormalFontObject(win.fontBtn)
        b:SetHighlightFontObject(win.fontBtnOn)
        c.btns[c.nb] = b
    end
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", 0, -c.y)
    b:SetText(label)
    b:SetScript("OnClick", onClick)
    b:Show()
    c.y = c.y + 34
end

-- ikony mincí (GetCoinTextureString klient nemá)
local function coinText(copper)
    local g, sv, cu = math.floor(copper / 10000), math.floor((copper % 10000) / 100), copper % 100
    local t = {}
    if g > 0 then t[#t + 1] = g .. "|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t" end
    if sv > 0 then t[#t + 1] = sv .. "|TInterface\\MoneyFrame\\UI-SilverIcon:14:14:2:0|t" end
    if cu > 0 or #t == 0 then t[#t + 1] = cu .. "|TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t" end
    return table.concat(t, " ")
end

local function rewardBox(c, key, r, g, b)
    if not c[key] then
        local m = CreateFrame("Frame", nil, c, "BackdropTemplate")
        m:SetBackdrop(BOX)
        m:SetHeight(30)
        m.t = text(m, 13, 1, 0.95, 0.80)
        m.t:SetPoint("CENTER")
        c[key] = m
    end
    local m = c[key]
    m:SetBackdropColor(r, g, b, 0.95)
    m:SetBackdropBorderColor(0.20, 0.12, 0.06, 1)
    return m
end

-- řádek odznaků: XP (fialový) a peníze (tmavý), jako ve vzoru
local function addRewardBar(c, xp, copper)
    local x = 0
    if xp and xp > 0 then
        local m = rewardBox(c, "xpBox", 0.33, 0.20, 0.55)
        m.t:SetText("XP  " .. xp)
        m:ClearAllPoints()
        m:SetPoint("TOPLEFT", x, -c.y)
        m:SetWidth(math.max(90, (m.t:GetStringWidth() or 60) + 26))
        m:Show()
        x = x + m:GetWidth() + 8
    end
    if copper and copper > 0 then
        local m = rewardBox(c, "moneyBox", 0.14, 0.10, 0.07)
        m.t:SetText(coinText(copper))
        m:ClearAllPoints()
        m:SetPoint("TOPLEFT", x, -c.y)
        m:SetWidth(math.max(64, (m.t:GetStringWidth() or 40) + 26))
        m:Show()
    end
    c.y = c.y + 38
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

local function addItem(c, name, quality, id, confirmed, half)
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
    local colW = half and math.floor((c.w - 8) / 2) or c.w
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", half and (half * (colW + 8)) or 0, -c.y)
    b:SetWidth(colW)
    b.frame:SetBackdropBorderColor(qc[1], qc[2], qc[3], 1)
    b.icon:SetTexture(itemIcon(id))
    b.star:SetShown(confirmed and true or false)
    b.label:SetWidth(colW - 56)
    b.label:SetText((QUALITY[quality] or "") .. name .. "|r")
    b.kind:SetWidth(colW - 56)
    b.kind:SetText(half and "" or itemKind(id))
    b:Show()
    if not half or half == 1 then c.y = c.y + 54 end
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
local function addRow(c, title, sub, mark, selected, onClick, icon, badge, emblem, npcID, chain)
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
        b.chain = b:CreateTexture(nil, "OVERLAY")
        b.chain:SetSize(16, 16)
        b.chain:SetPoint("BOTTOMRIGHT", -34, 4)
        b.chain:SetTexture("Interface\\Icons\\Spell_Frost_ChainsOfIce")
        b.emblem = b:CreateTexture(nil, "ARTWORK")
        b.emblem:SetSize(26, 26)
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
    if emblem then setFactionIcon(b.emblem, emblem) end
    b.label:SetFont(title:find("[\128-\255]") and FONT or TITLE_FONT, 13, "")
    b.label:SetText(title)
    b.sub:SetText(sub or "")
    local h = 8 + (b.label:GetStringHeight() or 14) + 2 + ((sub and sub ~= "") and (b.sub:GetStringHeight() or 12) or 0) + 8
    if h < (hasModel and 54 or 46) then h = hasModel and 54 or 46 end
    b:SetHeight(h)
    b.check:SetShown(mark and true or false)
    b.chain:SetShown(chain and true or false)
    b.sel:SetShown(selected and true or false)
    b.accent:SetShown(selected and true or false)
    b:SetBackdropBorderColor(selected and 0.62 or 0.42, selected and 0.20 or 0.27, selected and 0.10 or 0.13, selected and 1 or 0.85)
    b:SetScript("OnClick", onClick)
    b:Show()
    c.y = c.y + h + 8
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
    local blore = WoWpoCesku_BossLore and WoWpoCesku_BossLore[key] and WoWpoCesku_BossLore[key][sel[1]]
    if blore then
        addText(R, "Příběh", 14, RED, 4)
        addText(R, blore, 13, INK, 12)
        addRule(R)
    end
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
    local fv = WoWpoCesku_BossLootForever and WoWpoCesku_BossLootForever[key] and WoWpoCesku_BossLootForever[key][sel[1]]
    for _, it in ipairs(fv or {}) do
        if not seenIds[it[3]] then loot[#loot + 1] = it; seenIds[it[3]] = true end
    end
    -- classic databáze jen tam, kde o Forever nic nevíme (jinak by ukazovala staré předměty)
    local db = (not fv) and WoWpoCesku_BossLoot and WoWpoCesku_BossLoot[key] and WoWpoCesku_BossLoot[key][sel[1]]
    for _, it in ipairs(db or {}) do
        if not seenIds[it[3]] then loot[#loot + 1] = it end
    end
    if #loot > 0 then
        addText(R, "Může padnout", 14, RED, 6)
        for _, it in ipairs(loot) do addItem(R, it[1], it[2], it[3], it[4]) end
        addText(R, "Zlatá hvězdička = padlo ti to ve hře (potvrzeno). Ostatní jsou z databáze (u některých dungeonů z classic, kde se Forever může lišit). Najeď myší na předmět.", 11, SEPIA, 4)
    else
        addText(R, "V databázi pro něj není žádné zelené, modré ani epické vybavení.", 12, SEPIA, 4)
    end
end

local function renderQuests(key)
    local L, R = win.left, win.right
    reset(L); reset(R)
    local fac = state.fac or myFactionLetter() or "H"
    local list = questList(key, fac)

    -- hlavička seznamu: počet a přepínač frakcí (Aliance / Horda)
    addText(L, ("Questy  |  %d"):format(#list), 15, INK, 8, 0, 130)
    L.y = L.y - 8
    local function facButton(slot, letter, x)
        local b = L[slot]
        if not b then
            b = CreateFrame("Button", nil, L, "BackdropTemplate")
            b:SetSize(34, 34)
            b:SetBackdrop(BOX)
            b.ic = b:CreateTexture(nil, "ARTWORK")
            b.ic:SetPoint("TOPLEFT", 3, -3)
            b.ic:SetPoint("BOTTOMRIGHT", -3, 3)
            L[slot] = b
        end
        b:ClearAllPoints()
        b:SetPoint("TOPRIGHT", L, "TOPRIGHT", x, -4)
        setFactionIcon(b.ic, letter)
        local on = (fac == letter)
        b:SetBackdropColor(on and 0.78 or 0.40, on and 0.55 or 0.26, on and 0.30 or 0.14, on and 0.55 or 0.14)
        b:SetBackdropBorderColor(on and 0.62 or 0.42, on and 0.20 or 0.27, on and 0.10 or 0.13, 1)
        b.ic:SetAlpha(on and 1 or 0.55)
        b:SetScript("OnClick", function() state.fac = letter; state.quest[key] = nil; showDetail() end)
        b:Show()
    end
    facButton("facA", "A", -42)
    facButton("facH", "H", -2)
    L.y = L.y + 42

    if #list == 0 then
        addText(R, "Pro tuto frakci nemám v databázi žádné questy k téhle instanci.", 13, INK)
        return
    end
    local cur = state.quest[key]
    local found = false
    for _, e in ipairs(list) do if e[1] == cur then found = true end end
    if not found then cur = list[1][1]; state.quest[key] = cur end
    for _, e in ipairs(list) do
        local title = e[2]
        local emblem = e[5]   -- "H" nebo "A" (nil = obě frakce)
        addRow(L, title, ("od levelu %d"):format(e[4]), questDone(e[1]), e[1] == cur,
            function() state.quest[key] = e[1]; showDetail() end,
            "Interface\\GossipFrame\\AvailableQuestIcon", nil, emblem, nil,
            WoWpoCesku_QuestChain and WoWpoCesku_QuestChain[e[1]] ~= nil)
    end
    local sel
    for _, e in ipairs(list) do if e[1] == cur then sel = e end end
    local id = sel[1]
    local d = WoWpoCesku_Data and WoWpoCesku_Data[id]
    local cz = d and d.title
    addText(R, sel[2], 21, RED, 2, 0, nil, TITLE_FONT)
    if cz and cz ~= sel[2] then addText(R, cz, 12, SEPIA, 4) end
    addText(R, ("Level questu %d · dostupný od levelu %d"):format(sel[3], sel[4]) .. (questDone(id) and ("  " .. GREEN .. "(splněno)|r") or ""), 12, SEPIA, 6)
    local chainInfo = WoWpoCesku_QuestChain and WoWpoCesku_QuestChain[id]
    if chainInfo then
        local function nameOf(qid)
            for _, e in ipairs(WoWpoCesku_DungeonQuests and WoWpoCesku_DungeonQuests[key] or {}) do if e[1] == qid then return e[2] end end
            local d2 = WoWpoCesku_Data and WoWpoCesku_Data[qid]
            return d2 and (d2.en_title or d2.title) or ("quest " .. qid)
        end
        local parts = {}
        if chainInfo.prev and chainInfo.prev > 0 then parts[#parts + 1] = "Vyžaduje předchozí quest: " .. nameOf(chainInfo.prev) end
        if chainInfo.nextq and chainInfo.nextq > 0 then parts[#parts + 1] = "Pokračuje questem: " .. nameOf(chainInfo.nextq) end
        if #parts > 0 then addText(R, "|TInterface\\Icons\\Spell_Frost_ChainsOfIce:14|t Řada questů. " .. table.concat(parts, ". ") .. ".", 12, RED, 6) end
    end
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
    local rw = WoWpoCesku_QuestRewards and WoWpoCesku_QuestRewards[id]
    if rw and (#rw.choice > 0 or #rw.fixed > 0 or (rw.money or 0) > 0) then
        addRule(R)
        addText(R, "Odměny", 17, RED, 6)
        local function tiles(list)
            for i, it in ipairs(list) do addItem(R, it[2], it[3], it[1], false, (i - 1) % 2) end
            if #list % 2 == 1 then R.y = R.y + 54 end
        end
        if #rw.choice > 0 then
            addText(R, "Vyber jednu odměnu:", 13, INK, 4)
            tiles(rw.choice)
        end
        if #rw.fixed > 0 then
            addText(R, "Získáš:", 13, INK, 4)
            tiles(rw.fixed)
        end
        local xp = WoWpoCesku_QuestXP and WoWpoCesku_QuestXP[id]
        if (rw.money or 0) > 0 or xp then addRewardBar(R, xp, rw.money) end
    elseif sel[7] and sel[7] ~= "" then
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

local function renderStory(key)
    local R = win.right
    reset(win.left); reset(R)
    local L = WoWpoCesku_Lore and WoWpoCesku_Lore[key]
    if not L then addText(R, "Příběh téhle instance zatím nemám.", 13, INK) return end
    if L.tag and L.tag ~= "" then addText(R, L.tag, 13, SEPIA, 10) end
    for _, ch in ipairs(L.ch or {}) do
        addText(R, ch[1], 15, RED, 4)
        addText(R, ch[2], 13, INK, 12)
    end
    local bl = WoWpoCesku_BossLore and WoWpoCesku_BossLore[key]
    if bl then addText(R, "Příběh jednotlivých bossů najdeš v záložce Bossové a kořist.", 11, SEPIA, 4) end
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
    local CARD_H = 104
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
    if #RAIDS > 0 then section("Raidy", RAIDS) end
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
            if prev then t:SetPoint("RIGHT", prev, "LEFT", -8, 0) else t:SetPoint("TOPRIGHT", -40, -158) end
            prev = t
        end
    end
    if state.tab == "mapa" and mapData(state.key) == nil then state.tab = "bossove" end
    for _, t in ipairs(win.tabs) do
        local active = (t.id == state.tab)
        t:SetDisabledFontObject(win.fontBtnOff)
        t:SetEnabled(not active)
        t:SetNormalFontObject(win.fontBtn)
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
    setBanner(win.banner, key, 870, 88)
    win.name:SetText(key)
    win.tag:SetText(levelText(key) or "")
    setTabs()
    local twoPane = (state.tab ~= "pruvodce" and state.tab ~= "mapa" and state.tab ~= "pribeh")
    win.leftSf:SetShown(twoPane)
    win.boxL:SetShown(twoPane)
    win.boxR:ClearAllPoints()
    win.boxR:SetPoint("TOPLEFT", twoPane and 392 or 24, -202)
    win.boxR:SetSize(twoPane and 516 or 884, 368)
    win.rightSf:ClearAllPoints()
    if twoPane then
        win.rightSf:SetPoint("TOPLEFT", 408, -214)
        win.rightSf:SetSize(468, 344)
        win.right.w = 468 - 26
    else
        win.rightSf:SetPoint("TOPLEFT", 36, -214)
        win.rightSf:SetSize(836, 344)
        win.right.w = 836 - 26
    end
    win.right:SetWidth(win.right.w)
    if state.tab == "bossove" then renderBosses(key)
    elseif state.tab == "questy" then renderQuests(key)
    elseif state.tab == "mapa" then renderMap(key)
    elseif state.tab == "pribeh" then renderStory(key)
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
    win:SetSize(940, 600)
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
    win.fontBtnOff = newFont("WoWpoCeskuDJBtnOff", 12, 0.62, 0.62, 0.62)

    local close = CreateFrame("Button", nil, win, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -8, -8)

    local dc = CreateFrame("Button", nil, win, "UIPanelButtonTemplate")
    dc:SetSize(150, 22)
    dc:SetPoint("TOPLEFT", 30, -22)
    dc:SetFrameLevel(win:GetFrameLevel() + 200)   -- vždy nad ostatními prvky okna, ať ho hráč vidí
    dc:SetNormalFontObject(win.fontBtn)
    dc:SetHighlightFontObject(win.fontBtnOn)
    dc:SetText("Chyba? Discord")
    dc:SetScript("OnClick", function() if WoWpoCesku_ShowDiscord then WoWpoCesku_ShowDiscord() end end)

    -- nadpis ve stylu hry: zlatá ozdobná cedule nad oknem a zlatý nápis herním písmem
    local plaque = win:CreateTexture(nil, "ARTWORK")
    plaque:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    plaque:SetSize(340, 68)
    plaque:SetPoint("TOP", win, "TOP", 0, 14)
    win.plaque = plaque
    local head = win:CreateFontString(nil, "OVERLAY")
    head:SetFont(TITLE_FONT, 17, "OUTLINE")   -- písmo hry; to nemá českou diakritiku, proto bez diakritiky
    head:SetTextColor(1, 0.82, 0)
    head:SetShadowColor(0, 0, 0, 1)
    head:SetShadowOffset(1, -1)
    head:SetPoint("TOP", plaque, "TOP", 0, -14)
    head:SetText("Dungeon Kronika")

    -- přehled (karty)
    win.browseSf, win.browse = newScroll(win, 30, -70, 856, 500)
    win.browse.w = 856 - 26

    -- detail
    win.detail = CreateFrame("Frame", nil, win)
    win.detail:SetAllPoints()

    win.banner = makeBanner(win.detail)
    win.banner:SetPoint("TOPLEFT", 30, -62)
    win.banner:SetSize(870, 88)

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
    entr:SetText("Zobrazit vstup")
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
        b:SetSize(138, 30)
        if prev then b:SetPoint("RIGHT", prev, "LEFT", -8, 0) else b:SetPoint("TOPRIGHT", -40, -158) end
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
    win.boxL:SetPoint("TOPLEFT", 24, -202)
    win.boxL:SetSize(352, 368)
    win.boxR = boxFrame(win.detail, win.detail:GetFrameLevel() + 1)
    win.boxR:SetPoint("TOPLEFT", 392, -202)
    win.boxR:SetSize(516, 368)
    win.leftSf, win.left = newScroll(win.detail, 36, -214, 304, 344)
    win.rightSf, win.right = newScroll(win.detail, 408, -214, 468, 344)
    win.right.w = 468 - 26
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
function WoWpoCesku_DungeonJournal(key, tab, forceOpen)
    if not win then build() end
    if win:IsShown() and not key and not tab and not forceOpen then win:Hide() return end
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

-- Diagnostika značky vchodu na mapě: /czq znacka (po kliknutí na Zobrazit vstup, s otevřenou mapou)
function WoWpoCesku_MarkDebug()
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local m = djMarks[1]
    local canvas = WorldMapFrame and WorldMapFrame.ScrollContainer and WorldMapFrame.ScrollContainer.Child
    say(("znacek: %d, mapa ve hre: %s, mapa znacky: %s, mapa otevrena: %s"):format(#djMarks, tostring(WorldMapFrame and WorldMapFrame:GetMapID()), tostring(m and m.uiMap), tostring(WorldMapFrame and WorldMapFrame:IsShown())))
    if canvas then say(("platno: %.0f x %.0f, pinu: %d"):format(canvas:GetWidth(), canvas:GetHeight(), #djPins)) end
    for i, p in ipairs(djPins) do
        local cx, cy = p:GetCenter()
        local px, py = canvas and canvas:GetCenter()
        say(("pin %d: viditelny=%s velikost=%.0f alfa=%.2f uroven=%s stred=%s,%s platno-stred=%s,%s meritko=%s"):format(i, tostring(p:IsShown()), p:GetWidth(), p:GetEffectiveAlpha(), tostring(p:GetFrameLevel()), tostring(cx and math.floor(cx)), tostring(cy and math.floor(cy)), tostring(px and math.floor(px)), tostring(py and math.floor(py)), tostring(p:GetEffectiveScale())))
    end
    drawDJMarks()
end

-- Zkouška ikon vchodu: /czq ikony  (ukáže herní atlasy a textury, které by šly použít jako značka)
local iconWin
function WoWpoCesku_IconTest(arg)
    local atlases = { "Dungeon", "Raid", "dungeon", "raid", "DungeonSkull", "UI-EJ-Dungeon", "worldquest-icon-dungeon", "poi-door",
        "Dungeon-Portal", "Portal", "MapPin-Dungeon", "dungeonentrance", "Dungeon-Entrance", "WorldMapDungeon", "Vehicle-Dungeon",
        "poi-dungeon", "VignetteKill", "MiniMap-DeadArrow", "Warfront-NeutralHero", "campaign-icon-dungeon", "ui-ej-dungeonicon",
        "Garr_Building-AddFollowerPlus", "poi-portal" }
    local textures = { "Interface\\EncounterJournal\\UI-EJ-PortraitIcon", "Interface\\Minimap\\ObjectIcons",
        "Interface\\EncounterJournal\\UI-EJ-Icons", "Interface\\EncounterJournal\\UI-EJ-Buttons", "Interface\\Icons\\INV_Misc_Gear_01",
        "Interface\\Minimap\\POIIcons", "Interface\\WorldMap\\UI-World-Icon" }
    if arg == "frakce" then
        atlases = { "poi-horde", "poi-alliance", "bfa-landingbutton-horde-up", "bfa-landingbutton-alliance-up", "Warfront-HordeHero", "Warfront-AllianceHero",
            "worldquest-icon-horde", "worldquest-icon-alliance", "honorsystem-icon-prestige-1", "AllianceAssaultsMapBanner", "HordeAssaultsMapBanner",
            "pvpqueue-sidebar-honorbar-frame", "ui-hud-unitframe-target-portraiton-pvp-horde", "charactercreate-icon-horde", "charactercreate-icon-alliance",
            "Horde", "Alliance", "ShipMissionIcon-Treasure-Mission", "WoWLabs-hordeicon", "mission-icon-horde", "Garr_HordeHero", "PVPFrame-Icon-Horde", "PVPFrame-Icon-Alliance" }
        textures = { "Interface\\FriendsFrame\\PlusManz-Horde", "Interface\\FriendsFrame\\PlusManz-Alliance", "Interface\\TargetingFrame\\UI-PVP-Horde",
            "Interface\\TargetingFrame\\UI-PVP-Alliance", "Interface\\PVPFrame\\PVP-Currency-Horde", "Interface\\PVPFrame\\PVP-Currency-Alliance",
            "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions", "Interface\\Icons\\INV_BannerPVP_01", "Interface\\Icons\\INV_BannerPVP_02",
            "Interface\\WorldStateFrame\\HordeIcon", "Interface\\WorldStateFrame\\AllianceIcon" }
    end
    local items = {}
    for _, a in ipairs(atlases) do
        local ok = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(a)
        items[#items + 1] = { kind = "a", name = a, ok = ok and true or false }
    end
    for _, t in ipairs(textures) do items[#items + 1] = { kind = "t", name = t, ok = true } end
    if not iconWin then
        local f = CreateFrame("Frame", "WoWpoCeskuIkony", UIParent, "BackdropTemplate")
        f:SetSize(1000, 460)
        f:SetPoint("CENTER")
        f:SetFrameStrata("DIALOG")
        f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.6, 0.5, 0.3, 1)
        f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local c = CreateFrame("Button", nil, f, "UIPanelCloseButton"); c:SetPoint("TOPRIGHT", -6, -6)
        f.items = {}
        iconWin = f
    end
    local f = iconWin
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
        t.tex:SetPoint("TOPLEFT", 26 + col * 160, -34 - row * 84)
        t.tex:SetSize(48, 48)
        if it.kind == "a" and it.ok then t.tex:SetAtlas(it.name) elseif it.kind == "t" then t.tex:SetTexture(it.name) else t.tex:SetTexture("") end
        t.tex:Show()
        t.label:ClearAllPoints()
        t.label:SetPoint("TOPLEFT", t.tex, "BOTTOMLEFT", 0, -2)
        t.label:SetWidth(152)
        t.label:SetText((it.kind == "a" and (it.ok and "atlas: " or "(neni) ") or "tex: ") .. it.name:gsub("^Interface\\", ""))
        t.label:Show()
    end
    f:Show()
end

-- Diagnostika vchodů: /czq vchod [text]  -> které vchody klient nabízí (API Encounter Journalu a Area POI)
function WoWpoCesku_EntranceDebug(text)
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local want = (text and text ~= "") and text:lower() or nil
    say(("API: EJ.GetDungeonEntrancesForMap=%s, AreaPoi.GetAreaPOIForMap=%s"):format(
        tostring(C_EncounterJournal and C_EncounterJournal.GetDungeonEntrancesForMap ~= nil),
        tostring(C_AreaPoiInfo and C_AreaPoiInfo.GetAreaPOIForMap ~= nil)))
    local mapsWith, shown = 0, 0
    for id = 1, 3000 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and (info.mapType == 2 or info.mapType == 3) then
            if C_EncounterJournal and C_EncounterJournal.GetDungeonEntrancesForMap then
                local ok2, list = pcall(C_EncounterJournal.GetDungeonEntrancesForMap, id)
                if ok2 and type(list) == "table" and #list > 0 then
                    mapsWith = mapsWith + 1
                    for _, e in ipairs(list) do
                        if not want or (e.name and e.name:lower():find(want, 1, true)) then
                            if shown < 12 then
                                shown = shown + 1
                                local u, v = xy(e.position)
                                say(("EJ mapa %d '%s': %s %.1f, %.1f"):format(id, info.name or "?", tostring(e.name), (u or 0) * 100, (v or 0) * 100))
                            end
                        end
                    end
                end
            end
            if C_AreaPoiInfo and C_AreaPoiInfo.GetAreaPOIForMap and want then
                local ok3, ids = pcall(C_AreaPoiInfo.GetAreaPOIForMap, id)
                if ok3 and type(ids) == "table" then
                    for _, pid in ipairs(ids) do
                        local ok4, pi = pcall(C_AreaPoiInfo.GetAreaPOIInfo, id, pid)
                        if ok4 and pi and pi.name and pi.name:lower():find(want, 1, true) and shown < 12 then
                            shown = shown + 1
                            local u, v = xy(pi.position)
                            say(("POI mapa %d '%s': %s %.1f, %.1f"):format(id, info.name or "?", pi.name, (u or 0) * 100, (v or 0) * 100))
                        end
                    end
                end
            end
        end
    end
    say(("map s vchody (EJ API): %d, vypsano: %d"):format(mapsWith, shown))
end

-------------------------------------------------------------------------------
-- Ověření kořisti: /czq koristi – porovná, co ti v dungeonech padlo, s databází (Forever, classic) a vypíše rozdíly k okopírování.
-------------------------------------------------------------------------------
local reportWin
function WoWpoCesku_LootReport()
    local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end
    local seenLoot = WoWpoCeskuSeen and WoWpoCeskuSeen.loot
    if not seenLoot or not next(seenLoot) then
        say("zatim nemam zadnou zaznamenanou koristi. Otevri loot nejakeho bosse v dungeonu a zkus to znovu.")
        return
    end
    local function inList(list, id)
        for _, it in ipairs(list or {}) do if it[3] == id then return true end end
        return false
    end
    local ok, classic, news, lines = 0, 0, 0, {}
    for key, bosses in pairs(seenLoot) do
        for boss, items in pairs(bosses) do
            for id, rec in pairs(items) do
                local fv = WoWpoCesku_BossLootForever and WoWpoCesku_BossLootForever[key] and WoWpoCesku_BossLootForever[key][boss]
                local db = WoWpoCesku_BossLoot and WoWpoCesku_BossLoot[key] and WoWpoCesku_BossLoot[key][boss]
                local status
                if inList(fv, id) then ok = ok + 1; status = nil
                elseif inList(db, id) then classic = classic + 1; status = "jen classic"
                else news = news + 1; status = "NOVE" end
                if status then
                    lines[#lines + 1] = ("%s | %s | %d | %s | %s | %s"):format(key, boss, id, rec.name or "?", tostring(rec.q or "?"), status)
                end
            end
        end
    end
    table.sort(lines)
    say(("kontrola kořisti: overeno %d, jen classic %d, nove %d. Podrobnosti v okne (Ctrl+A, Ctrl+C a posli mi je)."):format(ok, classic, news))
    if not reportWin then
        local f = CreateFrame("Frame", "WoWpoCeskuLootReport", UIParent, "BackdropTemplate")
        f:SetSize(760, 440)
        f:SetPoint("CENTER")
        f:SetFrameStrata("DIALOG")
        f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.12, 0.08, 0.05, 1)
        f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local c = CreateFrame("Button", nil, f, "UIPanelCloseButton"); c:SetPoint("TOPRIGHT", -6, -6)
        f.title = f:CreateFontString(nil, "OVERLAY")
        f.title:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 13, "")
        f.title:SetPoint("TOPLEFT", 22, -18)
        f.sf = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        f.sf:SetPoint("TOPLEFT", 22, -46)
        f.sf:SetSize(690, 370)
        f.edit = CreateFrame("EditBox", nil, f.sf)
        f.edit:SetMultiLine(true)
        f.edit:SetAutoFocus(false)
        f.edit:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf", 12, "")
        f.edit:SetWidth(680)
        f.edit:SetScript("OnEscapePressed", f.edit.ClearFocus)
        f.sf:SetScrollChild(f.edit)
        reportWin = f
    end
    reportWin.title:SetText(("Kontrola kořisti: ověřeno %d · jen classic %d · nové %d (instance | boss | ID | název | kvalita | stav)"):format(ok, classic, news))
    reportWin.edit:SetText(#lines > 0 and table.concat(lines, "\n") or "Vsechno, co ti padlo, je v databazi Forever.")
    reportWin:Show()
end
