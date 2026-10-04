-- WoWpoCesku: Kronika Azerothu – doplňky
--  * upozornění na vzácné moby (rare) + deník, kde a kdy jsi je viděl (WoWpoCeskuSeen.rares)
--  * deník objevů: navštívená místa a viděné rary v kapitole kroniky „Tvoje objevy“
--  * české poznámky k důležitým postavám pod popiskem (tooltipem) NPC
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local PARCHMENT = "Interface\\AddOns\\WoWpoCesku\\Textures\\pergamen.tga"
local INK, RED, SEPIA = { 0.20, 0.13, 0.07 }, { 0.50, 0.12, 0.05 }, { 0.42, 0.30, 0.18 }

local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end

local function seen()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.rares = WoWpoCeskuSeen.rares or {}
    WoWpoCeskuSeen.sub = WoWpoCeskuSeen.sub or {}
    WoWpoCeskuSeen.z = WoWpoCeskuSeen.z or {}
    return WoWpoCeskuSeen
end
local function secret(v) return issecretvalue and issecretvalue(v) end
local checkSeals   -- Pečetě kronikáře (definováno níž)

-- malé okno z pergamenu (stejný vzhled jako kronika)
local function parchmentFrame(name, parent, strata)
    local f = CreateFrame("Frame", name, parent or UIParent, "BackdropTemplate")
    f:SetFrameStrata(strata or "TOOLTIP")
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14, insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    f:SetBackdropColor(0.91, 0.84, 0.66, 1)
    f:SetBackdropBorderColor(0.45, 0.30, 0.16, 1)
    local tex = f:CreateTexture(nil, "BACKGROUND", nil, 1)
    tex:SetPoint("TOPLEFT", 3, -3)
    tex:SetPoint("BOTTOMRIGHT", -3, 3)
    tex:SetTexture(PARCHMENT)
    f.title = f:CreateFontString(nil, "OVERLAY")
    f.title:SetFont(FONT, 13, "")
    f.title:SetTextColor(RED[1], RED[2], RED[3])
    f.title:SetPoint("TOPLEFT", 10, -8)
    f.title:SetJustifyH("LEFT")
    f.text = f:CreateFontString(nil, "OVERLAY")
    f.text:SetFont(FONT, 12, "")
    f.text:SetTextColor(INK[1], INK[2], INK[3])
    f.text:SetPoint("TOPLEFT", f.title, "BOTTOMLEFT", 0, -4)
    f.text:SetJustifyH("LEFT")
    f.text:SetSpacing(2)
    f:Hide()
    return f
end

local function fitFrame(f, width)
    f.title:SetWidth(width - 20)
    f.text:SetWidth(width - 20)
    f:SetSize(width, f.title:GetStringHeight() + f.text:GetStringHeight() + 22)
end

-- české okénko pod popiskem (písmo popisku neumí č/ř/ů) – postavy, předměty, místa na mapě
local notes = {}
local function showNote(tt, title, text)
    local n = notes[tt]
    if not n then
        n = parchmentFrame(nil, tt, "TOOLTIP")
        n:SetClampedToScreen(true)
        tt:HookScript("OnHide", function() n:Hide() end)
        notes[tt] = n
    end
    n.title:SetText(title)
    n.text:SetText(text)
    n:ClearAllPoints()
    n:SetPoint("TOPLEFT", tt, "BOTTOMLEFT", 0, -2)
    fitFrame(n, math.max(260, tt:GetWidth()))
    n:Show()
end

-------------------------------------------------------------------------------
-- Vzácní mobové: seznam z classic dat (foreverdb) – "Jméno|level|t" (t = lovec ochočí)
-------------------------------------------------------------------------------
local RARE = {}   -- jméno -> { zone, lvl, tame }
for zone, list in pairs(WoWpoCesku_RareList or {}) do
    for _, s in ipairs(list) do
        local name, lvl, flags = strsplit("|", s)
        RARE[name] = { zone = zone, lvl = lvl, tame = flags and flags:find("t") and true }
    end
end
WoWpoCesku_RareInfo = RARE

local function zoneKey()
    return WoWpoCesku_CurrentZoneKey and WoWpoCesku_CurrentZoneKey() or (GetRealZoneText and GetRealZoneText())
end

local function playerPos()
    local ok, x, y = pcall(function()
        local id = C_Map.GetBestMapForUnit("player")
        local p = id and C_Map.GetPlayerMapPosition(id, "player")
        if p then return p.x, p.y end
    end)
    if ok and x then return math.floor(x * 1000 + 0.5) / 10, math.floor(y * 1000 + 0.5) / 10 end
end

local alert
local lastAlert = {}

local function rareNote(name, info, rec)
    local parts = {}
    if info then
        parts[#parts + 1] = ("Vzácný mob – %s, level %s."):format(info.zone, info.lvl or "?")
        if info.tame then parts[#parts + 1] = "Lovec si ho může ochočit." end
    else
        parts[#parts + 1] = "Vzácný mob, který v classic datech není – možná novinka WoW Forever!"
    end
    if rec and rec.n and rec.n > 1 then parts[#parts + 1] = ("Viděl jsi ho už %dx."):format(rec.n) end
    return table.concat(parts, " ")
end

-- tlačítko „Zaměřit“ (jako NPCScan): bezpečné tlačítko s makrem /targetexact – jen mimo boj
local targetBtn
local function setupTargetButton(name, w, h)
    -- v boji se bezpečné tlačítko nesmí měnit ani schovat (hra by to zablokovala)
    if InCombatLockdown() then return false end
    if not targetBtn then
        targetBtn = CreateFrame("Button", "WoWpoCeskuRareTarget", UIParent, "SecureActionButtonTemplate")
        targetBtn:SetFrameStrata("HIGH")
        targetBtn:RegisterForClicks("AnyUp", "AnyDown")
        targetBtn:SetAttribute("type", "macro")
        local hl = targetBtn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(RED[1], RED[2], RED[3], 0.12)
        targetBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
            GameTooltip:AddLine("Klikni = zamerit vzacneho moba")
            GameTooltip:Show()
        end)
        targetBtn:SetScript("OnLeave", GameTooltip_Hide)
    end
    targetBtn:SetAttribute("macrotext", "/targetexact " .. name)
    -- vlastní pozice (stejné místo jako cedulka), NE přichycení k cedulce –
    -- jinak by se cedulka stala chráněnou a její změny v boji hra blokuje
    targetBtn:ClearAllPoints()
    targetBtn:SetPoint("TOP", UIParent, "TOP", 0, -110)
    targetBtn:SetSize(w, h)
    targetBtn:Show()
    return true
end

local function hideTargetButton()
    if targetBtn and not InCombatLockdown() then targetBtn:Hide() end
end

local function showAlert(name, info, rec)
    if not alert then
        alert = parchmentFrame("WoWpoCeskuRareAlert", UIParent, "HIGH")
        alert:SetPoint("TOP", 0, -110)
        alert:EnableMouse(false)
        alert.hint = alert:CreateFontString(nil, "OVERLAY")
        alert.hint:SetFont(FONT, 11, "")
        alert.hint:SetTextColor(RED[1], RED[2], RED[3])
        alert.hint:SetPoint("TOPLEFT", alert.text, "BOTTOMLEFT", 0, -4)
        local anim = alert:CreateAnimationGroup()
        local hold = anim:CreateAnimation("Alpha")
        hold:SetFromAlpha(1) hold:SetToAlpha(1) hold:SetDuration(12) hold:SetOrder(1)
        local out = anim:CreateAnimation("Alpha")
        out:SetFromAlpha(1) out:SetToAlpha(0) out:SetDuration(1.5) out:SetOrder(2)
        anim:SetScript("OnPlay", function() alert:Show(); alert:SetAlpha(1) end)
        anim:SetScript("OnFinished", function() alert:Hide(); hideTargetButton() end)
        alert.anim = anim
    end
    alert.title:SetText("Vzácný mob: " .. name)
    alert.text:SetText(rareNote(name, info, rec))
    fitFrame(alert, 340)
    alert:SetHeight(alert:GetHeight() + 16)
    local canTarget = setupTargetButton(name, 340, alert:GetHeight())
    alert.hint:SetText(canTarget and "Klikni a zaměříš ho" or "V boji ho addon zaměřit nemůže")
    alert.anim:Stop()
    alert.anim:Play()
end

-- společné hlášení: zápis do deníku + upozornění (nejvýš jednou za 5 minut na stejného)
local function reportRare(name, cls, lvl, x, y)
    local info = RARE[name]
    local S = seen()
    local rec = S.rares[name] or { n = 0 }
    local now = time()
    if not rec.t or now - rec.t > 300 then rec.n = (rec.n or 0) + 1 end
    rec.t = now
    rec.z = zoneKey()
    if x then rec.x, rec.y = x, y else rec.x, rec.y = playerPos() end
    rec.c = cls or rec.c
    if lvl then rec.l = lvl end
    rec.new = (info == nil) or nil
    S.rares[name] = rec
    if checkSeals then C_Timer.After(3, function() pcall(checkSeals) end) end

    if lastAlert[name] and GetTime() - lastAlert[name] < 300 then return end
    lastAlert[name] = GetTime()
    PlaySound(SOUNDKIT and SOUNDKIT.RAID_WARNING or 8959, "Master")
    if FlashClientIcon then pcall(FlashClientIcon) end
    -- velký nápis uprostřed obrazovky (písmo hry neumí č/ř – bez diakritiky)
    if RaidNotice_AddMessage and RaidWarningFrame then
        pcall(RaidNotice_AddMessage, RaidWarningFrame, "VZACNY MOB: " .. name,
            ChatTypeInfo and ChatTypeInfo["RAID_WARNING"] or { r = 1, g = 0.3, b = 0.1 })
    end
    showAlert(name, info, rec)
    say(("vzacny mob: %s%s"):format(name, rec.x and (" (%.1f, %.1f)"):format(rec.x, rec.y) or ""))
end

local function checkRare(unit)
    if not WoWpoCeskuSettings or WoWpoCeskuSettings.rareAlert == false then return end
    local okN, name = pcall(UnitName, unit)
    if not okN or not name or secret(name) then return end
    local okC, cls = pcall(UnitClassification, unit)
    if not okC or secret(cls) then cls = nil end
    if not RARE[name] and cls ~= "rare" and cls ~= "rareelite" then return end
    local okP, isPlayer = pcall(UnitIsPlayer, unit)
    if okP and isPlayer == true then return end
    local okL, lvl = pcall(UnitLevel, unit)
    reportRare(name, cls, (okL and not secret(lvl)) and lvl or nil)
end

-- ikony vzácných mobů na minimapě (vignettes) – dosah větší než jmenovky
local function checkVignettes()
    if not WoWpoCeskuSettings or WoWpoCeskuSettings.rareAlert == false then return end
    if not (C_VignetteInfo and C_VignetteInfo.GetVignettes) then return end
    local mapID = C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
    for _, guid in ipairs(C_VignetteInfo.GetVignettes() or {}) do
        local info = C_VignetteInfo.GetVignetteInfo(guid)
        local name = info and info.name
        if name and not secret(name) then
            local atlas = info.atlasName or ""
            if RARE[name] or atlas:find("Rare") or atlas:find("VignetteKill") then
                local x, y
                local pos = mapID and C_VignetteInfo.GetVignettePosition and C_VignetteInfo.GetVignettePosition(guid, mapID)
                if pos then x, y = math.floor(pos.x * 1000 + 0.5) / 10, math.floor(pos.y * 1000 + 0.5) / 10 end
                reportRare(name, nil, nil, x, y)
            end
        end
    end
end

-- /czq vzacni [vyp|zap]
function WoWpoCesku_RareCommand(arg)
    WoWpoCeskuSettings = WoWpoCeskuSettings or {}
    if arg == "vyp" or arg == "off" then
        WoWpoCeskuSettings.rareAlert = false
        say("upozorneni na vzacne moby VYPNUTO")
    elseif arg == "zap" or arg == "on" then
        WoWpoCeskuSettings.rareAlert = true
        say("upozorneni na vzacne moby ZAPNUTO")
    else
        local list = {}
        for name, rec in pairs(seen().rares) do list[#list + 1] = { name, rec } end
        table.sort(list, function(a, b) return (a[2].t or 0) > (b[2].t or 0) end)
        if #list == 0 then say("zatim jsi nevidel zadneho vzacneho moba.") return end
        say(("videni vzacni mobove (%d):"):format(#list))
        for i = 1, math.min(#list, 15) do
            local name, rec = list[i][1], list[i][2]
            say(("  %s - %s%s, %s%s"):format(name, tostring(rec.z or "?"),
                rec.x and (" (%.1f, %.1f)"):format(rec.x, rec.y) or "",
                date("%d.%m. %H:%M", rec.t or 0), rec.new and "  [novy ve Forever?]" or ""))
        end
        say("vypnuti upozorneni: /czq vzacni vyp")
    end
end

-------------------------------------------------------------------------------
-- Deník objevů: navštívená místa se ukládají do WoWpoCeskuSeen.sub[oblast][místo]
-------------------------------------------------------------------------------
local onNewPlace   -- (definováno níž) obnoví mapu a zkontroluje pečetě
local function recordPlace()
    local key = zoneKey()
    if not key then return end
    local S = seen()
    S.sub[key] = S.sub[key] or {}
    local new
    local sub = GetSubZoneText and GetSubZoneText()
    if sub and sub ~= "" and not secret(sub) and not S.sub[key][sub] then S.sub[key][sub] = time(); new = true end
    local real = GetRealZoneText and GetRealZoneText()
    if real and real ~= "" and not secret(real) and not S.z[real] then S.z[real] = time(); new = true end
    if new and onNewPlace then onNewPlace() end
end

local function placeVisited(place)
    local S = seen()
    if S.z[place] then return true end
    for _, subs in pairs(S.sub) do
        if subs[place] then return true end
    end
    return false
end

-------------------------------------------------------------------------------
-- Vzácný mob na velké mapě: pulzující body tam, kde se objevuje
-------------------------------------------------------------------------------
local pins, pinMapID, pinName = {}, nil, nil

-- světové souřadnice z databáze -> souřadnice 0..1 na mapě oblasti (pořadí os ověří samo)
local function worldToMap(mapID, cont, x, y)
    local function try(a, b)
        local ok, _, pos = pcall(C_Map.GetMapPosFromWorldPos, cont, CreateVector2D(a, b), mapID)
        if ok and pos and pos.x >= 0 and pos.x <= 1 and pos.y >= 0 and pos.y <= 1 then return pos.x, pos.y end
    end
    local axis = WoWpoCeskuSettings and WoWpoCeskuSettings.axis
    if axis == "ba" then return try(y, x) end
    if axis == "ab" then return try(x, y) end
    local px, py = try(x, y)
    if px then return px, py, "ab" end
    px, py = try(y, x)
    if px then return px, py, "ba" end
end

local function rarePoints(name, mapID)
    local out = {}
    local manual = WoWpoCesku_RareMapPts and WoWpoCesku_RareMapPts[name]
    if manual then
        for i = 2, #manual, 2 do out[#out + 1] = { manual[i] / 100, manual[i + 1] / 100 } end
        return out
    end
    local w = WoWpoCesku_RareSpawns and WoWpoCesku_RareSpawns[name]
    if not w or not mapID then return out end
    for i = 1, #w, 3 do
        local px, py, axis = worldToMap(mapID, w[i], w[i + 1], w[i + 2])
        if px then
            out[#out + 1] = { px, py }
            if axis and WoWpoCeskuSettings then WoWpoCeskuSettings.axis = axis end
        end
    end
    return out
end

local function hidePins()
    for _, p in ipairs(pins) do p:Hide() end
end

local function placePins(points)
    local canvas = WorldMapFrame and WorldMapFrame.ScrollContainer and WorldMapFrame.ScrollContainer.Child
    if not canvas then return false end
    local w, h = canvas:GetWidth(), canvas:GetHeight()
    for i, pt in ipairs(points) do
        local p = pins[i]
        if not p then
            p = CreateFrame("Frame", nil, canvas)
            p:SetSize(26, 26)
            p.icon = p:CreateTexture(nil, "OVERLAY")
            p.icon:SetAllPoints()
            p.icon:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")
            p:EnableMouse(true)
            p:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:AddLine(pinName or "")
                GameTooltip:AddLine("Vzacny mob - mozne misto vyskytu (WoWpoCesku)", 1, 1, 1)
                GameTooltip:Show()
            end)
            p:SetScript("OnLeave", GameTooltip_Hide)
            pins[i] = p
        end
        p:SetFrameLevel(canvas:GetFrameLevel() + 2000)
        p:ClearAllPoints()
        p:SetPoint("CENTER", canvas, "TOPLEFT", pt[1] * w, -pt[2] * h)
        p:Show()
    end
    for i = #points + 1, #pins do pins[i]:Hide() end
    return true
end

-- POZOR: herní mapu addon sám neotvírá ani nepřepíná (ToggleWorldMap, SetMapID,
-- C_Map.ClearUserWaypoint). Taint se pak přenese na herní body mapy a v boji
-- hra blokuje Button:SetPassThroughButtons(). Lebky jen přikreslíme, až hráč
-- mapu otevře sám.
-------------------------------------------------------------------------------
-- Místa Poutníkova deníku na mapě (+ tip ze záložky Tajemství pod popiskem)
-------------------------------------------------------------------------------
local placeMarks = {}
local exploredCache = {}   -- mapID -> { název oblasti -> {x, y} } z objevených oblastí mapy

-- poloha objevených oblastí přímo ze hry: střed bodů mřížky, které do oblasti patří
local function exploredPositions(mapID)
    if exploredCache[mapID] then return exploredCache[mapID] end
    local res = {}
    local E = C_MapExplorationInfo
    if E and E.GetExploredAreaIDsAtPosition and C_Map.GetAreaInfo then
        local sum, N = {}, 40
        for i = 1, N - 1 do
            for j = 1, N - 1 do
                local ok, ids = pcall(E.GetExploredAreaIDsAtPosition, mapID, CreateVector2D(i / N, j / N))
                if ok and type(ids) == "table" then
                    for _, id in ipairs(ids) do
                        local s = sum[id] or { 0, 0, 0 }
                        s[1], s[2], s[3] = s[1] + i / N, s[2] + j / N, s[3] + 1
                        sum[id] = s
                    end
                end
            end
        end
        for id, s in pairs(sum) do
            local ok, name = pcall(C_Map.GetAreaInfo, id)
            if ok and type(name) == "string" and not secret(name) then res[name] = { s[1] / s[3], s[2] / s[3] } end
        end
    end
    exploredCache[mapID] = res
    return res
end

-- tip ze záložky Tajemství, který místo zmiňuje
local function secretTip(zone, place)
    local T = WoWpoCesku_LoreTajemstvi and WoWpoCesku_LoreTajemstvi[zone]
    if not T then return nil end
    for bullet in (T .. "\n\n"):gmatch("(.-)\n\n") do
        if bullet:find(place, 1, true) and bullet:find("•", 1, true) then
            return (bullet:gsub("^%s*•%s*", ""))
        end
    end
end

local function placeMark(i, canvas)
    local p = placeMarks[i]
    if p then return p end
    p = CreateFrame("Frame", nil, canvas)
    p:SetSize(18, 18)
    p.icon = p:CreateTexture(nil, "ARTWORK")
    p.icon:SetAllPoints()
    p.icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    p.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    p.check = p:CreateTexture(nil, "OVERLAY")
    p.check:SetSize(14, 14)
    p.check:SetPoint("BOTTOMRIGHT", 5, -5)
    p.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
    p:EnableMouse(true)
    p:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(self.place or "")
        GameTooltip:AddLine(self.visited and "Poutnikuv denik: navstiveno" or "Poutnikuv denik: zatim neobjeveno", 1, 1, 1)
        GameTooltip:Show()
        local tip = secretTip(self.zone, self.place)
        if tip then showNote(GameTooltip, "Tajemství", tip) end
    end)
    p:SetScript("OnLeave", GameTooltip_Hide)
    placeMarks[i] = p
    return p
end

local function hidePlaceMarks()
    for _, p in ipairs(placeMarks) do p:Hide() end
end

local function refreshPlaceMarks()
    hidePlaceMarks()
    if WoWpoCeskuSettings and (WoWpoCeskuSettings.enabled == false or WoWpoCeskuSettings.mapPlaces == false) then return end
    local canvas = WorldMapFrame and WorldMapFrame.ScrollContainer and WorldMapFrame.ScrollContainer.Child
    if not canvas or not WorldMapFrame:IsShown() then return end
    local mapID = WorldMapFrame:GetMapID()
    local info = mapID and C_Map.GetMapInfo(mapID)
    local zone = info and info.name
    local places = zone and WoWpoCesku_Objevy and WoWpoCesku_Objevy[zone]
    if not places then return end
    local static = (WoWpoCesku_ObjevyPts and WoWpoCesku_ObjevyPts[zone]) or {}
    local explored = exploredPositions(mapID)
    local w, h = canvas:GetWidth(), canvas:GetHeight()
    local n = 0
    for _, place in ipairs(places) do
        local x, y
        if explored[place] then
            x, y = explored[place][1], explored[place][2]
        else
            local s = static[place]
            if s and s[1] == "w" then
                x, y = worldToMap(mapID, s[2], s[3], s[4])
            elseif s then
                x, y = s[1] / 100, s[2] / 100
            end
        end
        if x then
            n = n + 1
            local p = placeMark(n, canvas)
            p.zone, p.place, p.visited = zone, place, placeVisited(place)
            p.icon:SetDesaturated(not p.visited)
            p.icon:SetAlpha(p.visited and 1 or 0.8)
            p.check:SetShown(p.visited)
            p:SetFrameLevel(canvas:GetFrameLevel() + 1990)
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", x * w, -y * h)
            p:Show()
        end
    end
end

local mapHooked
local function refreshPins()
    if pinMapID and pinName and WorldMapFrame:IsShown() and WorldMapFrame:GetMapID() == pinMapID then
        placePins(rarePoints(pinName, pinMapID))
    else
        hidePins()
    end
    pcall(refreshPlaceMarks)
end
local function hookMap()
    if mapHooked or not WorldMapFrame then return end
    mapHooked = true
    hooksecurefunc(WorldMapFrame, "OnMapChanged", function() refreshPins() end)
    WorldMapFrame:HookScript("OnShow", function() C_Timer.After(0, refreshPins) end)
end
WoWpoCesku_RefreshMapPlaces = function() if WorldMapFrame and WorldMapFrame:IsShown() then refreshPins() end end

function WoWpoCesku_ShowRareOnMap(name)
    local mapID = WoWpoCesku_BookMapID or (C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player"))
    local points = rarePoints(name, mapID)
    if #points == 0 then
        say(("pro %s nemam souradnice - zkus ho najit sam a addon si ho zapise."):format(name))
        return
    end
    pinMapID, pinName = mapID, name
    pcall(hookMap)
    if WorldMapFrame:IsShown() then
        refreshPins()
        say(("%s: %d mist vyskytu na mape"):format(name, #points))
    else
        say(("%s: %d mist vyskytu - otevri mapu (M), lebky jsou vyznacene."):format(name, #points))
    end
end

local GRAY = "|cff6b4d2e"

-------------------------------------------------------------------------------
-- Dungeony: bossové v Bestiáři, zabití se zapisují do WoWpoCeskuSeen.bosses[dungeon][boss]
-------------------------------------------------------------------------------
local function normBoss(n) return ((n or ""):lower():gsub("^the ", "")) end

local function markBoss(name)
    if not name or secret(name) then return end
    local key = zoneKey()
    local list = key and WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key]
    if not list then return end
    local want = normBoss(name)
    for _, b in ipairs(list) do
        if b[1] and normBoss(b[1]) == want then
            local S = seen()
            S.bosses = S.bosses or {}
            S.bosses[key] = S.bosses[key] or {}
            local first = not S.bosses[key][b[1]]
            S.bosses[key][b[1]] = time()
            if first then
                say(("Kronika: %s zapsan do Bestiare (%s)"):format(b[1], key))
                if checkSeals then C_Timer.After(3, function() pcall(checkSeals) end) end
            end
            return
        end
    end
end

local function dungeonBestiar(key, list)
    local S = seen()
    local killed = (S.bosses and S.bosses[key]) or {}
    local rows, n, total = {}, 0, 0
    for _, b in ipairs(list) do
        if b.sekce then
            rows[#rows + 1] = { text = "|cff801f0d" .. b.sekce .. "|r" }
        else
            total = total + 1
            local t = killed[b[1]]
            if t then n = n + 1 end
            local text = b[1]
            if b[2] and b[2] ~= "" then text = text .. GRAY .. "  – " .. b[2] .. "|r" end
            local note = WoWpoCesku_PostavyNote and WoWpoCesku_PostavyNote(b[1])
            if note then text = text .. "\n" .. note end
            if t then text = text .. "\n" .. GRAY .. "Poražen " .. date("%d.%m. %H:%M", t) .. "|r" end
            rows[#rows + 1] = { mark = t ~= nil, text = text }
        end
    end
    return {
        { "Bestiář", ("Poraženo %d z %d bossů.%s"):format(n, total,
            (n == total and total > 0) and "  |cff1d6b1dDungeon je vyčištěný!|r" or ""),
            rows = rows,
            after = GRAY .. "Boss se odškrtne sám, když ho tvoje skupina porazí.|r" },
    }
end


-- záložka Poutníkův deník: místa v oblasti (řádky se zaškrtávátkem)
function WoWpoCesku_DenikPage(key)
    local places = WoWpoCesku_Objevy and WoWpoCesku_Objevy[key]
    if not places then
        if WoWpoCesku_RareList and WoWpoCesku_RareList[key] then
            return { { "Poutníkův deník", "Pro tuhle oblast zatím nemám seznam míst k objevení." } }
        end
        return nil
    end
    local rows, n = {}, 0
    for _, place in ipairs(places) do
        local ok = placeVisited(place)
        if ok then n = n + 1 end
        rows[#rows + 1] = { mark = ok, text = place }
    end
    return {
        { "Poutníkův deník", ("Objeveno %d z %d míst.%s"):format(n, #places,
            n == #places and "  |cff1d6b1dVšechno jsi prozkoumal!|r" or ""),
            rows = rows,
            after = GRAY .. "Místo se odškrtne samo, když ho navštívíš (název vidíš u minimapy).|r" },
    }
end

-- jeden řádek Bestiáře: jméno, level, poznámka, kdy jsi ho viděl
local function rareRow(name, info, rec, isExtra)
    local desc = {}
    local lvl = (info and info.lvl) or (rec and rec.l and tostring(rec.l))
    if lvl and lvl ~= "?" then desc[#desc + 1] = "level " .. lvl end
    if info and info.tame then desc[#desc + 1] = "ochočitelný" end
    local text = name
    if #desc > 0 then text = text .. GRAY .. "  – " .. table.concat(desc, ", ") .. "|r" end
    local note = WoWpoCesku_RareNotes and WoWpoCesku_RareNotes[name]
    if note then text = text .. "\n" .. note end
    if rec and rec.t then
        text = text .. "\n" .. GRAY .. "Viděn " .. date("%d.%m. %H:%M", rec.t)
            .. (rec.x and (" na %.1f, %.1f"):format(rec.x, rec.y) or "")
            .. ((rec.n or 1) > 1 and ("  (%dx)"):format(rec.n) or "") .. "|r"
    end
    local hasPts = (WoWpoCesku_RareSpawns and WoWpoCesku_RareSpawns[name]) or (WoWpoCesku_RareMapPts and WoWpoCesku_RareMapPts[name])
    if not hasPts and not isExtra then text = text .. "\n" .. GRAY .. "Místo výskytu neznámé.|r" end
    return {
        mark = rec ~= nil,
        text = text,
        hint = hasPts and "Klikni - ukaze se na mape" or nil,
        onClick = hasPts and function() WoWpoCesku_ShowRareOnMap(name) end or nil,
    }
end

-- záložka Bestiář: vzácní mobové oblasti, co jsi viděl a kde
function WoWpoCesku_BestiarPage(key)
    local bosses = WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key]
    if bosses then return dungeonBestiar(key, bosses) end
    local rares = {}
    for name, info in pairs(RARE) do
        if info.zone == key then rares[#rares + 1] = name end
    end
    local S = seen()
    local extra = {}
    for name, rec in pairs(S.rares) do
        if rec.new and rec.z == key then extra[#extra + 1] = name end
    end
    if #rares == 0 and #extra == 0 then
        if WoWpoCesku_Objevy and WoWpoCesku_Objevy[key] then
            return { { "Bestiář", "V této oblasti nežijí žádní známí vzácní mobové." } }
        end
        return nil
    end
    table.sort(rares, function(a, b)
        local la, lb = tonumber((RARE[a].lvl or ""):match("%d+")) or 99, tonumber((RARE[b].lvl or ""):match("%d+")) or 99
        if la ~= lb then return la < lb end
        return a < b
    end)
    local rows, n = {}, 0
    for _, name in ipairs(rares) do
        local rec = S.rares[name]
        if rec then n = n + 1 end
        rows[#rows + 1] = rareRow(name, RARE[name], rec)
    end
    local page = {
        { "Bestiář", ("Viděno %d z %d vzácných mobů.\n"):format(n, #rares)
            .. "|cff801f0dKlikni na moba a na mapě se ukáže, kde se objevuje.|r",
            rows = rows,
            after = GRAY .. "Seznam je z classic dat – ve WoW Forever se mnozí teprve potvrzují. Když nějakého uvidíš, addon ho sám zapíše.|r" },
    }
    if #extra > 0 then
        table.sort(extra)
        local ex = {}
        for _, name in ipairs(extra) do ex[#ex + 1] = rareRow(name, nil, S.rares[name], true) end
        page[#page + 1] = { "Tvoje objevy navíc",
            "Vzácní mobové, kteří v classic datech nejsou – nejspíš novinky WoW Forever. Napiš mi o nich!", rows = ex }
    end
    return page
end

-------------------------------------------------------------------------------
-- Pečetě kronikáře: vlastní malé úspěchy (WoWpoCeskuSeen.seals[id] = čas získání)
-------------------------------------------------------------------------------
local DIA = { ["á"] = "a", ["č"] = "c", ["ď"] = "d", ["é"] = "e", ["ě"] = "e", ["í"] = "i", ["ň"] = "n", ["ó"] = "o",
    ["ř"] = "r", ["š"] = "s", ["ť"] = "t", ["ú"] = "u", ["ů"] = "u", ["ý"] = "y", ["ž"] = "z",
    ["Á"] = "A", ["Č"] = "C", ["Ď"] = "D", ["É"] = "E", ["Ě"] = "E", ["Í"] = "I", ["Ň"] = "N", ["Ó"] = "O",
    ["Ř"] = "R", ["Š"] = "S", ["Ť"] = "T", ["Ú"] = "U", ["Ů"] = "U", ["Ý"] = "Y", ["Ž"] = "Z", ["–"] = "-" }
local function ascii(s) return (s:gsub("[\195-\226][\128-\191]+", function(c) return DIA[c] or "" end)) end

local function countKeys(t) local n = 0; for _ in pairs(t or {}) do n = n + 1 end; return n end

-- série pečetí za počet (vzácní mobové, oblasti, přečtená kronika)
local SERIES = {
    { id = "rare", what = "vzácných mobů", count = function(S) return countKeys(S.rares) end,
      steps = { { 1, "Stopař" }, { 10, "Lovec vzácností" }, { 25, "Mistr lovu" }, { 50, "Legenda Bestiáře" } } },
    { id = "zone", what = "oblastí", count = function(S)
          local n = 0
          for z in pairs(S.z) do if WoWpoCesku_Objevy and WoWpoCesku_Objevy[z] then n = n + 1 end end
          return n
      end,
      steps = { { 5, "Tulák" }, { 15, "Cestovatel" }, { 30, "Poutník Azerothu" }, { 42, "Kartograf Azerothu" } } },
    { id = "read", what = "kapitol kroniky (oblastí a dungeonů)", count = function(S) return countKeys(S.read) end,
      steps = { { 5, "Čtenář kroniky" }, { 20, "Učenec" }, { 50, "Kronikář Azerothu" } } },
}

local function bossTotal(list)
    local n = 0
    for _, b in ipairs(list) do if b[1] then n = n + 1 end end
    return n
end

-- všechny pečetě: { id, name, have, need, group, key }
local function sealList()
    local S = seen()
    local out = {}
    for _, ser in ipairs(SERIES) do
        local c = ser.count(S)
        for _, st in ipairs(ser.steps) do
            out[#out + 1] = { id = ser.id .. st[1], name = st[2], have = math.min(c, st[1]), need = st[1],
                what = ser.what, group = "obecne", series = ser.id }
        end
    end
    for zone, places in pairs(WoWpoCesku_Objevy or {}) do
        local n = 0
        for _, p in ipairs(places) do if placeVisited(p) then n = n + 1 end end
        out[#out + 1] = { id = "poutnik:" .. zone, name = "Průzkumník – " .. zone, have = n, need = #places,
            what = "míst", group = "oblast", key = zone }
    end
    for dung, list in pairs(WoWpoCesku_DungeonBosses or {}) do
        local n = countKeys(S.bosses and S.bosses[dung])
        out[#out + 1] = { id = "dobyvatel:" .. dung, name = "Dobyvatel – " .. dung, have = math.min(n, bossTotal(list)),
            need = bossTotal(list), what = "bossů", group = "dungeon", key = dung }
    end
    return out
end

checkSeals = function()
    local S = seen()
    local first = S.seals == nil
    S.seals = S.seals or {}
    local new = {}
    for _, s in ipairs(sealList()) do
        if s.need > 0 and s.have >= s.need and not S.seals[s.id] then
            S.seals[s.id] = time()
            new[#new + 1] = s
        end
    end
    -- napoprvé (starší postup) pečetě jen tiše zapsat
    if first or #new == 0 then return end
    PlaySound(SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE or 618)
    for i = 1, math.min(#new, 3) do say("nova pecet kronikare: " .. ascii(new[i].name)) end
    if #new > 3 then say(("... a dalsich %d peceti"):format(#new - 3)) end
    if WoWpoCesku_SealToast then pcall(WoWpoCesku_SealToast, new[1].name, #new) end
end

onNewPlace = function()
    wipe(exploredCache)
    if WoWpoCesku_RefreshMapPlaces then pcall(WoWpoCesku_RefreshMapPlaces) end
    C_Timer.After(2, function() pcall(checkSeals) end)
end

WoWpoCesku_CheckSeals = function() pcall(checkSeals) end

local function sealRow(s, S)
    local t = S.seals and S.seals[s.id]
    local text = (t and "|cff801f0d" or "") .. s.name .. (t and "|r" or "")
    if t then
        text = text .. "\n" .. GRAY .. "Získáno " .. date("%d.%m.%Y", t) .. "|r"
    else
        text = text .. "\n" .. GRAY .. ("%d z %d %s"):format(s.have, s.need, s.what) .. "|r"
    end
    return { mark = t ~= nil, text = text }
end

-- záložka Pečetě
function WoWpoCesku_PecetePage(key)
    pcall(checkSeals)
    local S = seen()
    local all = sealList()
    local got, total = 0, 0
    for _, s in ipairs(all) do
        total = total + 1
        if S.seals and S.seals[s.id] then got = got + 1 end
    end
    local here, general, zones, dungs = {}, {}, {}, {}
    -- u série jen získané + nejbližší další
    local nextShown = {}
    for _, s in ipairs(all) do
        local t = S.seals and S.seals[s.id]
        if s.key and s.key == key then
            here[#here + 1] = sealRow(s, S)
        elseif s.group == "obecne" then
            if t or not nextShown[s.series] then
                general[#general + 1] = sealRow(s, S)
                if not t then nextShown[s.series] = true end
            end
        elseif (t or s.have > 0) then
            local list = s.group == "oblast" and zones or dungs
            list[#list + 1] = { s = s, row = sealRow(s, S) }
        end
    end
    local function rows(list)
        table.sort(list, function(a, b) return a.s.name < b.s.name end)
        local out = {}
        for _, x in ipairs(list) do out[#out + 1] = x.row end
        return out
    end
    local page = {
        { "Pečetě kronikáře", ("Získáno %d z %d pečetí.\n"):format(got, total)
            .. "Pečeť dostaneš za prozkoumání celé oblasti, vyčištění dungeonu, vzácné moby, cesty po Azerothu a čtení kroniky.",
            rows = #here > 0 and here or nil },
        { "Hrdinské pečetě", "Za lov, cestování a čtení kroniky.", rows = general },
    }
    page[#page + 1] = { "Oblasti", #zones > 0 and "Rozpracované a dokončené oblasti (pečeť = všechna místa Poutníkova deníku)."
        or "Zatím žádná. Projdi všechna místa v Poutníkově deníku některé oblasti.", rows = rows(zones) }
    page[#page + 1] = { "Dungeony", #dungs > 0 and "Pečeť = všichni bossové dungeonu poraženi."
        or "Zatím žádný. Poraz všechny bosse v dungeonu.", rows = rows(dungs),
        after = GRAY .. "Pečetě se zapisují samy. Postup z doby před touto verzí se počítá také.|r" }
    return page
end

-------------------------------------------------------------------------------
-- Poznámky k postavám a rarům pod popiskem NPC (vlastní okno – písmo popisku neumí č/ř/ů)
-------------------------------------------------------------------------------
local function npcNote(name)
    local P = WoWpoCesku_Postavy
    if not P then return nil end
    if P[name] then return P[name] end
    -- jména s titulem ("Warchief Thrall") – hledej konec jména
    for k, v in pairs(P) do
        if #name > #k and name:sub(-#k - 1) == " " .. k then return v end
    end
end

WoWpoCesku_PostavyNote = function(name) return npcNote(name) end

local function onUnitTooltip(tt)
    if tt ~= GameTooltip then return end
    if WoWpoCeskuSettings and (WoWpoCeskuSettings.enabled == false or WoWpoCeskuSettings.npcNotes == false) then return end
    local ok, _, unit = pcall(tt.GetUnit, tt)
    if not ok or not unit then return end
    local okN, name = pcall(UnitName, unit)
    if not okN or not name or secret(name) then return end
    local okP, isPlayer = pcall(UnitIsPlayer, unit)
    if okP and isPlayer == true then return end
    local text = npcNote(name)
    local title = name
    if not text then
        local info = RARE[name]
        local rec = seen().rares[name]
        local okC, cls = pcall(UnitClassification, unit)
        if info or rec or (okC and not secret(cls) and (cls == "rare" or cls == "rareelite")) then
            text = rareNote(name, info, rec)
        end
    end
    if not text then return end
    showNote(GameTooltip, title, text)
end

-- příběhy slavných předmětů (WoWpoCesku_Predmety; klíč s * = začátek názvu)
local function itemNote(name)
    local P = WoWpoCesku_Predmety
    if not P then return nil end
    if P[name] then return P[name] end
    for k, v in pairs(P) do
        if k:sub(-1) == "*" and name:sub(1, #k - 1) == k:sub(1, -2) then return v end
    end
end

local function onItemTooltip(tt)
    if tt ~= GameTooltip and tt ~= ItemRefTooltip then return end
    if WoWpoCeskuSettings and (WoWpoCeskuSettings.enabled == false or WoWpoCeskuSettings.itemNotes == false) then return end
    local ok, name = pcall(tt.GetItem, tt)
    if not ok or not name or secret(name) then return end
    local text = itemNote(name)
    if text then showNote(tt, name, text) end
end

local function hookTooltip()
    if TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Unit then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tt)
            pcall(onUnitTooltip, tt)
        end)
        if Enum.TooltipDataType.Item then
            TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tt)
                pcall(onItemTooltip, tt)
            end)
        end
    else
        if GameTooltip:HasScript("OnTooltipSetUnit") then
            GameTooltip:HookScript("OnTooltipSetUnit", function(tt) pcall(onUnitTooltip, tt) end)
        end
        for _, tt in ipairs({ GameTooltip, ItemRefTooltip }) do
            if tt and tt:HasScript("OnTooltipSetItem") then
                tt:HookScript("OnTooltipSetItem", function(t) pcall(onItemTooltip, t) end)
            end
        end
    end
end

-------------------------------------------------------------------------------
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("ZONE_CHANGED")
ev:RegisterEvent("ZONE_CHANGED_INDOORS")
ev:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ev:RegisterEvent("NAME_PLATE_UNIT_ADDED")
ev:RegisterEvent("PLAYER_TARGET_CHANGED")
ev:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
pcall(ev.RegisterEvent, ev, "VIGNETTES_UPDATED")
pcall(ev.RegisterEvent, ev, "VIGNETTE_MINIMAP_UPDATED")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")
pcall(ev.RegisterEvent, ev, "ENCOUNTER_END")
-- POZOR: COMBAT_LOG_EVENT_UNFILTERED ve WoW Forever addony registrovat nesmí (hra hlásí zakázanou akci)
ev:SetScript("OnEvent", function(_, event, unit, ...)
    if event == "PLAYER_LOGIN" then
        pcall(hookTooltip)
        pcall(hookMap)
        if not mapHooked then ev:RegisterEvent("ADDON_LOADED") end
        C_Timer.After(5, function() pcall(checkSeals) end)
    elseif event == "ADDON_LOADED" then
        if unit == "Blizzard_WorldMap" then pcall(hookMap) end
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        pcall(checkRare, unit)
    elseif event == "PLAYER_TARGET_CHANGED" then
        pcall(checkRare, "target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        pcall(checkRare, "mouseover")
    elseif event == "VIGNETTES_UPDATED" or event == "VIGNETTE_MINIMAP_UPDATED" then
        pcall(checkVignettes)
    elseif event == "ENCOUNTER_END" then
        local encName, _, _, success = ...   -- unit = encounterID
        if success == 1 then pcall(markBoss, encName) end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if not (alert and alert:IsShown()) then hideTargetButton() end
    else
        C_Timer.After(1, function() pcall(recordPlace) end)
    end
end)
