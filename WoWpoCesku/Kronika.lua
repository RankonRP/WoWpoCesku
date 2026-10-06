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
local journalAdd   -- Tvůj příběh – deník postavy (definováno níž)

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
WoWpoCesku_ShowNote = showNote

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
    if journalAdd then pcall(journalAdd, "rare", name) end
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
    -- hlavní města: zvlášť za každou frakci (pečeť Velvyslanec, skrytá pečeť Špeh)
    local okF, fk = pcall(UnitFactionGroup, "player")
    local caps = WoWpoCesku_SealCapitals
    if okF and caps and real and caps[fk] then
        S.cap = S.cap or {}
        for f2, cities in pairs(caps) do
            for _, c in ipairs(cities) do
                if c == real then
                    if f2 == fk and not S.cap[c .. ":" .. fk] then S.cap[c .. ":" .. fk] = time(); new = true end
                    if f2 ~= fk and not S.spy then S.spy = time(); new = true end
                end
            end
        end
    end
    if journalAdd and real and not secret(real) then
        local okI, inInst = pcall(IsInInstance)
        if okI and inInst then
            if WoWpoCesku_DungeonBosses and WoWpoCesku_DungeonBosses[key] then pcall(journalAdd, "dungeon", key) end
        elseif WoWpoCesku_Objevy and WoWpoCesku_Objevy[real] then
            pcall(journalAdd, "zone", real)
        end
    end
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
            WoWpoCesku_LastBoss = { key = key, name = b[1], t = GetTime and GetTime() or 0 }
            if journalAdd then pcall(journalAdd, "boss", b[1], key) end
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
            local loot = WoWpoCesku_BossLoot and WoWpoCesku_BossLoot[key] and WoWpoCesku_BossLoot[key][b[1]]
            if loot and #loot > 0 then
                local parts = {}
                for i = 1, math.min(#loot, 8) do
                    local q, nm = loot[i][2], loot[i][1]
                    if WoWpoCesku_ItemQuality then q, nm = WoWpoCesku_ItemQuality(loot[i][3], q, nm) end
                    parts[#parts + 1] = (q >= 4 and "|cff8a2be2" or (q == 3 and "|cff0b5cc4" or "|cff1a7a1a")) .. nm .. "|r"
                end
                text = text .. "\n" .. GRAY .. "Může padnout: |r" .. table.concat(parts, ", ")
                    .. (#loot > 8 and (GRAY .. (" … a dalších %d|r"):format(#loot - 8)) or "")
            end
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

-- Pečetě fungují jako achievementy: každá má popisek, ikonu a body; při získání vyjede banner.
local IC = "Interface\\Icons\\"
local PIC = "Interface\\AddOns\\WoWpoCesku\\Textures\\Pecete\\"   -- obrázky pečetí (tools/pecete-obrazky.js)
local RAIDS = { ["Molten Core"] = true, ["Onyxia's Lair"] = true, ["Blackwing Lair"] = true, ["Zul'Gurub"] = true,
    ["Ruins of Ahn'Qiraj"] = true, ["Ahn'Qiraj Temple"] = true, ["Naxxramas"] = true }

local function bossTotal(list)
    local n = 0
    for _, b in ipairs(list) do if b[1] then n = n + 1 end end
    return n
end

-- série za počet: { id, ikona, co se počítá, popisek, stupně { počet, název, body } }
local SERIES = {
    { id = "rare", icon = IC .. "Ability_Hunter_SniperShot", image = PIC .. "lovec", what = "vzácných mobů",
      desc = function(n) return n == 1 and "Spatři svého prvního vzácného moba." or ("Spatři %d různých vzácných mobů."):format(n) end,
      steps = { { 1, "Stopař", 5 }, { 10, "Lovec vzácností", 10 }, { 25, "Mistr lovu", 25 }, { 50, "Legenda Bestiáře", 50 } } },
    { id = "zone", icon = IC .. "Ability_Mount_RidingHorse", image = PIC .. "cestovatel", what = "oblastí",
      desc = function(n) return ("Navštiv %d oblastí Azerothu."):format(n) end,
      steps = { { 5, "Tulák", 5 }, { 15, "Cestovatel", 10 }, { 30, "Poutník Azerothu", 25 }, { 42, "Kartograf Azerothu", 50 } } },
    { id = "mista", icon = IC .. "INV_Misc_Spyglass_02", image = PIC .. "objevitel", what = "míst",
      desc = function(n) return ("Objev celkem %d míst z Poutníkova deníku."):format(n) end,
      steps = { { 25, "Objevitel", 5 }, { 100, "Zvěd", 10 }, { 200, "Znalec všech cest", 25 } } },
    { id = "dung", icon = IC .. "INV_Sword_04", image = PIC .. "hrdina", what = "dungeonů",
      desc = function(n) return n == 1 and "Vyčisti svůj první dungeon – poraz v něm všechny bosse."
          or ("Vyčisti %d různých dungeonů nebo raidů."):format(n) end,
      steps = { { 1, "Hrdina", 10 }, { 5, "Ochránce Azerothu", 10 }, { 10, "Postrach temnot", 25 }, { 20, "Legenda dungeonů", 50 } } },
    { id = "kviz", icon = IC .. "INV_Misc_Book_09", image = PIC .. "ctenar", what = "složených zkoušek",
      desc = function(n) return ("Slož Zkoušku kronikáře (5 z 5) v %d různých oblastech nebo dungeonech."):format(n) end,
      steps = { { 3, "Žák kronikáře", 5 }, { 10, "Učenec Azerothu", 10 }, { 25, "Mudrc", 25 } } },
    { id = "read", icon = IC .. "INV_Misc_Book_09", image = PIC .. "ctenar", what = "kapitol kroniky",
      desc = function(n) return ("Otevři v Kronice příběh %d různých oblastí nebo dungeonů."):format(n) end,
      steps = { { 5, "Čtenář kroniky", 5 }, { 20, "Učenec", 10 }, { 50, "Kronikář Azerothu", 25 } } },
    -- postava (group = "postava")
    { id = "level", group = "postava", icon = IC .. "Spell_Holy_SealOfMight", image = PIC .. "uroven", what = "úrovní",
      desc = function(n) return ("Dosáhni s některou postavou úrovně %d."):format(n) end,
      steps = { { 10, "Na cestě", 5 }, { 20, "Zkušený dobrodruh", 5 }, { 40, "Veterán", 10 }, { 60, "Na vrcholu", 25 } } },
    { id = "gold", group = "postava", icon = IC .. "INV_Misc_Coin_01", image = PIC .. "bohatstvi", what = "zlatých",
      desc = function(n) return ("Měj u jedné postavy najednou %d zlatých."):format(n) end,
      steps = { { 100, "Zámožný", 10 }, { 1000, "Boháč", 25 } } },
    { id = "riding", group = "postava", icon = IC .. "Ability_Mount_RidingHorse", image = PIC .. "jezdec", what = "bodů jízdy",
      desc = function(n) return n <= 75 and "Nauč se jezdit na mountovi." or "Nauč se jezdit na epickém mountovi." end,
      steps = { { 75, "Na koni", 10 }, { 150, "Epický jezdec", 25 } } },
    { id = "death", group = "postava", icon = IC .. "Spell_Shadow_DeathScream", image = PIC .. "smrt", what = "smrtí",
      desc = function(n) return ("Zemři %d×. Smrt je jen začátek."):format(n) end,
      steps = { { 10, "Ještě dýchám?", 5 }, { 50, "Duch Azerothu", 10 }, { 100, "Nesmrtelný", 10 } } },
}

-- statistiky postavy pro pečetě (úroveň, peníze, profese, jízda, reputace) – čte se ze hry
local PROF_SET, REP_SET = {}, {}
for _, p in ipairs(WoWpoCesku_SealProfese or {}) do PROF_SET[p[1]] = true end
for _, r in ipairs(WoWpoCesku_SealRep or {}) do REP_SET[r[1]] = true end
local function updateStats()
    local S = seen()
    local ok, lvl = pcall(UnitLevel, "player")
    if ok and type(lvl) == "number" and not secret(lvl) then S.maxLvl = math.max(S.maxLvl or 0, lvl) end
    local okM, money = pcall(GetMoney)
    if okM and type(money) == "number" and not secret(money) then S.maxGold = math.max(S.maxGold or 0, money) end
    S.prof = S.prof or {}
    -- novější klient (WoW Forever): GetProfessions / GetProfessionInfo
    if GetProfessions and GetProfessionInfo then
        local okP, a, b, c, d, e, f = pcall(GetProfessions)
        if okP then
            for _, idx in ipairs({ a or 0, b or 0, c or 0, d or 0, e or 0, f or 0 }) do
                if idx and idx > 0 then
                    local okI, name, _, rank = pcall(GetProfessionInfo, idx)
                    if okI and type(name) == "string" and type(rank) == "number" and PROF_SET[name] then
                        S.prof[name] = math.max(S.prof[name] or 0, rank)
                    end
                end
            end
        end
    end
    -- jízda v novějším klientu = naučené kouzlo (Apprentice / Journeyman Riding)
    local known = IsPlayerSpell or IsSpellKnown
    if known then
        local ok75, has75 = pcall(known, 33388)
        local ok150, has150 = pcall(known, 33391)
        if ok150 and has150 then S.riding = math.max(S.riding or 0, 150)
        elseif ok75 and has75 then S.riding = math.max(S.riding or 0, 75) end
    end
    if GetNumSkillLines and GetSkillLineInfo then
        for i = 1, GetNumSkillLines() do
            local okS, name, header, _, rank = pcall(GetSkillLineInfo, i)
            if okS and type(name) == "string" and not header and type(rank) == "number" then
                if PROF_SET[name] then S.prof[name] = math.max(S.prof[name] or 0, rank) end
                if name:find("Riding") or name:find("Horsemanship") or name:find("Piloting") then
                    S.riding = math.max(S.riding or 0, rank)
                end
            end
        end
    end
    S.rep = S.rep or {}
    if GetNumFactions and GetFactionInfo then
        for i = 1, GetNumFactions() do
            local okF, name, _, standing = pcall(GetFactionInfo, i)
            if okF and REP_SET[name] and standing == 8 and not S.rep[name] then S.rep[name] = time() end
        end
    elseif C_Reputation and C_Reputation.GetNumFactions and C_Reputation.GetFactionDataByIndex then
        for i = 1, C_Reputation.GetNumFactions() do
            local okF, d = pcall(C_Reputation.GetFactionDataByIndex, i)
            if okF and d and REP_SET[d.name] and d.reaction == 8 and not S.rep[d.name] then S.rep[d.name] = time() end
        end
    end
end

-- splněný quest (classic API i novější C_QuestLog)
local function questDone(id)
    local f = (C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted) or IsQuestFlaggedCompleted
    if not f then return false end
    local ok, r = pcall(f, id)
    return ok and r == true
end

local function myFaction()
    local ok, f = pcall(UnitFactionGroup, "player")
    if ok and (f == "Alliance" or f == "Horde") then return f end
end

local FACTION = {
    A = { key = "Alliance", label = "|cff1d4fa0Aliance|r", only = "jen pro Alianci" },
    H = { key = "Horde", label = "|cff9a1c14Horda|r", only = "jen pro Hordu" },
}

-- hodnost kronikáře podle bodů pečetí
local RANKS = { { 0, "Učedník" }, { 50, "Písař" }, { 150, "Kronikář" }, { 300, "Strážce kroniky" },
    { 600, "Mistr kronikář" }, { 1000, "Legenda Azerothu" } }
local function rankOf(pts)
    local cur, nxt = RANKS[1], nil
    for i, r in ipairs(RANKS) do
        if pts >= r[1] then cur, nxt = r, RANKS[i + 1] end
    end
    return cur[2], nxt
end

-- všechny pečetě: { id, name, desc, icon, image, points, have, need, what, group, key, series,
--                   gold, hidden, faction, detail (co chybí) }
local function sealList()
    local S = seen()
    local out, counts = {}, { rare = countKeys(S.rares), read = countKeys(S.read), zone = 0, mista = 0, dung = 0,
        kviz = countKeys(S.quiz), level = S.maxLvl or 0, gold = math.floor((S.maxGold or 0) / 10000), riding = S.riding or 0, death = S.deaths or 0 }
    for z in pairs(S.z) do if WoWpoCesku_Objevy and WoWpoCesku_Objevy[z] then counts.zone = counts.zone + 1 end end
    for zone, places in pairs(WoWpoCesku_Objevy or {}) do
        local n, missing = 0, {}
        for _, p in ipairs(places) do
            if placeVisited(p) then n = n + 1 else missing[#missing + 1] = "• " .. p end
        end
        counts.mista = counts.mista + n
        out[#out + 1] = { id = "poutnik:" .. zone, name = "Průzkumník – " .. zone, icon = IC .. "INV_Misc_Map_01", image = PIC .. "pruzkumnik",
            desc = "Navštiv všechna místa Poutníkova deníku v oblasti " .. zone .. ".",
            points = 10, have = n, need = #places, what = "míst", group = "oblast", key = zone,
            detail = #missing > 0 and ("Ještě neobjeveno:\n" .. table.concat(missing, "\n")) or nil }
    end
    for dung, list in pairs(WoWpoCesku_DungeonBosses or {}) do
        local total = bossTotal(list)
        local killed = (S.bosses and S.bosses[dung]) or {}
        local missing = {}
        for _, b in ipairs(list) do if b[1] and not killed[b[1]] then missing[#missing + 1] = "• " .. b[1] end end
        local n = math.min(countKeys(killed), total)
        if total > 0 and n >= total then counts.dung = counts.dung + 1 end
        local raid = RAIDS[dung]
        out[#out + 1] = { id = "dobyvatel:" .. dung, name = "Dobyvatel – " .. dung,
            icon = IC .. (raid and "INV_Misc_Head_Dragon_01" or "INV_Misc_Bone_HumanSkull_01"),
            image = PIC .. (raid and "raid" or "dobyvatel"), gold = raid,
            desc = "Poraz všechny bosse " .. (raid and "v raidu " or "v dungeonu ") .. dung .. ".",
            points = raid and 25 or 10, have = n, need = total, what = "bossů", group = "dungeon", key = dung,
            detail = #missing > 0 and ("Ještě nepadli:\n" .. table.concat(missing, "\n")) or nil }
    end
    for _, ser in ipairs(SERIES) do
        local c = counts[ser.id] or 0
        for i, st in ipairs(ser.steps) do
            out[#out + 1] = { id = ser.id .. st[1], name = st[2], desc = ser.desc(st[1]), icon = ser.icon, image = ser.image, points = st[3],
                have = math.min(c, st[1]), need = st[1], what = ser.what, group = ser.group or "obecne", series = ser.id,
                gold = (i == #ser.steps) }
        end
    end
    -- Legendy Azerothu: slavné questové příběhy (frakční jen pro svou frakci)
    local fac = myFaction()
    for _, L in ipairs(WoWpoCesku_SealLegends or {}) do
        local done = false
        for _, q in ipairs(L.q) do if questDone(q) then done = true break end end
        -- řada questů: pro mou frakci; u variant (Atiesh) ta, ve které už mám postup
        local chain
        for _, q in ipairs(L.q) do
            local c = WoWpoCesku_SealChains and WoWpoCesku_SealChains[q]
            if c and (not c.f or not fac or FACTION[c.f].key == fac) then
                local any = false
                for _, st in ipairs(c) do if questDone(st[1]) then any = true break end end
                if not chain or any then chain = c end
                if any then break end
            end
        end
        local s = { id = "legenda:" .. L.id, name = L.name, desc = L.desc, icon = IC .. "INV_Misc_Book_11",
            image = PIC .. "legenda", gold = L.gold, points = L.pts or 10, have = done and 1 or 0, need = 1,
            group = "legenda", faction = L.f }
        if chain then
            local n, lines, nextStep = 0, {}, nil
            for _, st in ipairs(chain) do
                local ok = done or questDone(st[1])
                if ok then n = n + 1 elseif not nextStep then nextStep = st end
                local cz = WoWpoCesku_Data and WoWpoCesku_Data[st[1]] and WoWpoCesku_Data[st[1]].title
                lines[#lines + 1] = ok and ("|cff1d6b1d• " .. (cz or st[2]) .. "  (hotovo)|r") or ("• " .. (cz or st[2]))
            end
            s.have, s.need, s.what = done and #chain or math.min(n, #chain - 1), #chain, "questů"
            if not done then
                local t = nextStep and (nextStep[3] ~= "" and ("Další krok: %s – dává %s"):format(nextStep[2], nextStep[3])
                    or ("Další krok: %s (začíná předmětem)"):format(nextStep[2]))
                s.detail = (t and (t .. "\n\n") or "") .. table.concat(lines, "\n")
            end
        end
        out[#out + 1] = s
    end
    -- Zkouška kronikáře: pečeť Znalec za 5 z 5 v oblasti / dungeonu
    for key in pairs(WoWpoCesku_Kviz or {}) do
        local got = S.quiz and S.quiz[key]
        out[#out + 1] = { id = "znalec:" .. key, name = "Znalec – " .. key, icon = IC .. "INV_Misc_Book_09", image = PIC .. "ctenar",
            desc = "Odpověz správně na všech pět otázek Zkoušky kronikáře: " .. key .. ".", points = 10,
            have = got and 1 or 0, need = 1, group = "znalost", key = key, statusText = (not got) and "zkouška nesložena" or nil }
    end
    -- kontinenty: všechny oblasti
    for _, C in ipairs(WoWpoCesku_SealContinents or {}) do
        local n, missing = 0, {}
        for _, z in ipairs(C.zones) do if S.z[z] then n = n + 1 else missing[#missing + 1] = "• " .. z end end
        out[#out + 1] = { id = "kontinent:" .. C.id, name = C.name, icon = IC .. "INV_Misc_Map_01", image = PIC .. "kontinent",
            desc = "Navštiv všechny oblasti kontinentu.", points = 25, gold = true, have = n, need = #C.zones, what = "oblastí",
            group = "svet", detail = #missing > 0 and ("Ještě nenavštíveno:\n" .. table.concat(missing, "\n")) or nil }
    end
    -- hlavní města své frakce (návštěvy se zapisují zvlášť za každou frakci)
    for fk, cities in pairs(WoWpoCesku_SealCapitals or {}) do
        local n, missing = 0, {}
        for _, c in ipairs(cities) do
            if S.cap and S.cap[c .. ":" .. fk] then n = n + 1 else missing[#missing + 1] = "• " .. c end
        end
        out[#out + 1] = { id = "mesta:" .. fk, name = fk == "Alliance" and "Velvyslanec Aliance" or "Velvyslanec Hordy",
            icon = IC .. "INV_Misc_Book_11", image = PIC .. "mesta", points = 10, have = n, need = #cities, what = "měst",
            desc = "Navštiv všechna hlavní města své frakce.", faction = fk == "Alliance" and "A" or "H", group = "svet",
            detail = #missing > 0 and ("Ještě nenavštíveno:\n" .. table.concat(missing, "\n")) or nil }
    end
    -- profese na 300
    for _, p in ipairs(WoWpoCesku_SealProfese or {}) do
        local rank = (S.prof and S.prof[p[1]]) or 0
        out[#out + 1] = { id = "prof:" .. p[1], name = p[2], icon = IC .. "Trade_BlackSmithing", image = PIC .. "remeslo",
            desc = ("Dosáhni úrovně 300 v profesi %s (%s)."):format(p[1], p[3]), points = 10,
            have = math.min(rank, 300), need = 300, what = "bodů", group = "remeslo" }
    end
    -- reputace Exalted
    for _, R in ipairs(WoWpoCesku_SealRep or {}) do
        local got = S.rep and S.rep[R[1]]
        out[#out + 1] = { id = "rep:" .. R[1], name = "Exalted – " .. R[1], icon = IC .. "INV_Misc_Book_11", image = PIC .. "reputace",
            desc = ("Dosáhni u frakce %s nejvyšší reputace Exalted."):format(R[1]), points = R[3] and 25 or 10, gold = R[3],
            have = got and 1 or 0, need = 1, group = "reputace", faction = R[2], statusText = (not got) and "zatím ne" or nil }
    end
    -- skryté pečetě: potkat postavu (nebo všechny ze seznamu), navštívit místo, špeh, ochočený rare
    local met = S.met or {}
    for _, H in ipairs(WoWpoCesku_SealHidden or {}) do
        local done = (H.npc and met[H.npc] ~= nil) or (H.misto and placeVisited(H.misto))
            or (H.spy and S.spy ~= nil) or (H.tameRare and S.tamed ~= nil) or false
        if H.npcs then
            done = true
            for _, nm in ipairs(H.npcs) do if not met[nm] then done = false end end
        end
        out[#out + 1] = { id = "skryta:" .. H.id, name = H.name, desc = H.desc, hint = H.hint,
            icon = IC .. "INV_Misc_QuestionMark", image = PIC .. "skryta", points = H.pts or 10,
            have = done and 1 or 0, need = 1, group = "skryta", hidden = true }
    end
    return out
end

-- banner „Pečeť získána!“ (jako achievement ve hře); víc pečetí najednou jde postupně
local banner, bannerQueue = nil, {}
local function tintSeal(tex, s, got)
    -- obrázek pečeti: rudý vosk; vzácná = zlatý, skrytá = černý; nezískaná = vybledlá
    tex:SetDesaturated((not got) or s.gold or s.hidden or false)
    if not got then tex:SetVertexColor(0.80, 0.72, 0.57)
    elseif s.gold then tex:SetVertexColor(1.0, 0.80, 0.36)
    elseif s.hidden then tex:SetVertexColor(0.50, 0.50, 0.58)
    else tex:SetVertexColor(1, 1, 1) end
end
WoWpoCesku_TintSeal = tintSeal

local function showNextBanner()
    local s = table.remove(bannerQueue, 1)
    if not s then return end
    if not banner then
        banner = parchmentFrame("WoWpoCeskuSealBanner", UIParent, "HIGH")
        banner:SetSize(400, 92)
        banner:SetPoint("CENTER", 0, 120)   -- uprostřed obrazovky, kousek nad postavou
        banner:EnableMouse(true)
        banner.wax = banner:CreateTexture(nil, "ARTWORK", nil, 2)
        banner.wax:SetSize(78, 78)
        banner.wax:SetPoint("LEFT", 6, 0)
        banner.title:ClearAllPoints()
        banner.title:SetPoint("TOPLEFT", banner.wax, "TOPRIGHT", 6, -8)
        banner.title:SetFont(FONT, 11, "")
        banner.title:SetTextColor(SEPIA[1], SEPIA[2], SEPIA[3])
        banner.name = banner:CreateFontString(nil, "OVERLAY")
        banner.name:SetFont(FONT, 17, "")
        banner.name:SetTextColor(RED[1], RED[2], RED[3])
        banner.name:SetPoint("TOPLEFT", banner.title, "BOTTOMLEFT", 0, -3)
        banner.name:SetWidth(296)
        banner.name:SetJustifyH("LEFT")
        banner.text:ClearAllPoints()
        banner.text:SetPoint("TOPLEFT", banner.name, "BOTTOMLEFT", 0, -3)
        banner.text:SetWidth(296)
        banner.text:SetFont(FONT, 11, "")
        local anim = banner:CreateAnimationGroup()
        local a1 = anim:CreateAnimation("Alpha"); a1:SetFromAlpha(0); a1:SetToAlpha(1); a1:SetDuration(0.4); a1:SetOrder(1)
        local a2 = anim:CreateAnimation("Alpha"); a2:SetFromAlpha(1); a2:SetToAlpha(1); a2:SetDuration(5); a2:SetOrder(2)
        local a3 = anim:CreateAnimation("Alpha"); a3:SetFromAlpha(1); a3:SetToAlpha(0); a3:SetDuration(1); a3:SetOrder(3)
        anim:SetScript("OnPlay", function() banner:Show(); banner:SetAlpha(1) end)
        anim:SetScript("OnFinished", function() banner:Hide(); showNextBanner() end)
        banner.anim = anim
        banner:SetScript("OnMouseUp", function()
            banner.anim:Stop(); banner:Hide(); wipe(bannerQueue)
            if WoWpoCesku_ShowLore then WoWpoCesku_ShowLore("pecete") end
        end)
    end
    local kind = s.hidden and "Skrytá pečeť odhalena!" or (s.gold and "Vzácná pečeť získána!" or "Pečeť získána!")
    banner.title:SetText(("%s  ·  %d bodů"):format(kind, s.points or 0))
    banner.name:SetText(s.name)
    banner.text:SetText(s.desc or "")
    banner.wax:SetTexture(s.image)
    tintSeal(banner.wax, s, true)
    pcall(PlaySound, 888, "Master")
    banner.anim:Stop()
    banner.anim:Play()
end

-- jméno postavy, která pečeť získala (pečetě jsou společné pro celý účet)
local function charName()
    local ok, name = pcall(UnitName, "player")
    if ok and type(name) == "string" and name ~= "" and not secret(name) then return name end
end

local SEAL_VERSION = 4   -- při přidání nových druhů pečetí zvýšit: starý postup se zapíše potichu

checkSeals = function()
    local S = seen()
    local silent = S.seals == nil or (S.sealVer or 1) < SEAL_VERSION
    S.seals = S.seals or {}
    S.sealBy = S.sealBy or {}
    S.sealVer = SEAL_VERSION
    local me = charName()
    local fac = myFaction()
    -- pečetě z doby, kdy se jméno nezapisovalo, připadnou postavě, která se přihlásí první
    if me then
        for id in pairs(S.seals) do
            if not S.sealBy[id] then S.sealBy[id] = me end
        end
    end
    local new = {}
    for _, s in ipairs(sealList()) do
        local allowed = not s.faction or (fac and FACTION[s.faction].key == fac)
        if allowed and s.need > 0 and s.have >= s.need and not S.seals[s.id] then
            S.seals[s.id] = time()
            S.sealBy[s.id] = me
            new[#new + 1] = s
        end
    end
    if silent or #new == 0 then return end
    for i = 1, #new do
        say("nova pecet: " .. ascii(new[i].name))
        if journalAdd then pcall(journalAdd, "seal", new[i].name) end
        if i <= 5 and not (WoWpoCeskuSettings and WoWpoCeskuSettings.sealBanner == false) then bannerQueue[#bannerQueue + 1] = new[i] end
    end
    -- volitelně oznámit guildě (v nastavení, výchozí vypnuto)
    if WoWpoCeskuSettings and WoWpoCeskuSettings.sealGuild and IsInGuild and IsInGuild() then
        local msg = "[WoWpoCesku] ziskal(a) jsem pecet: " .. ascii(new[1].name)
        if #new > 1 then msg = msg .. (" (a dalsich %d)"):format(#new - 1) end
        pcall(SendChatMessage, msg, "GUILD")
    end
    if not (banner and banner:IsShown()) then showNextBanner() end
end

onNewPlace = function()
    wipe(exploredCache)
    if WoWpoCesku_RefreshMapPlaces then pcall(WoWpoCesku_RefreshMapPlaces) end
    C_Timer.After(2, function() pcall(checkSeals) end)
end

WoWpoCesku_CheckSeals = function() pcall(checkSeals) end

-- skryté pečetě: potkané postavy (zaměření, najetí myší, jmenovka)
local HIDDEN_NPC = {}
for _, H in ipairs(WoWpoCesku_SealHidden or {}) do
    if H.npc then HIDDEN_NPC[H.npc] = true end
    for _, nm in ipairs(H.npcs or {}) do HIDDEN_NPC[nm] = true end
end
local function metUnit(unit)
    local ok, name = pcall(UnitName, unit)
    if not ok or type(name) ~= "string" or secret(name) or not HIDDEN_NPC[name] then return end
    local S = seen()
    S.met = S.met or {}
    if S.met[name] then return end
    S.met[name] = time()
    if journalAdd then pcall(journalAdd, "met", name) end
    C_Timer.After(1, function() pcall(checkSeals) end)
end

-- záložka Pečetě: mřížka voskových pečetí (vykresluje Lore.lua)
function WoWpoCesku_PecetePage(key)
    pcall(checkSeals)
    local S = seen()
    local all = sealList()
    local got, total, pts, ptsAll, mine = 0, 0, 0, 0, 0
    local me, fac = charName(), myFaction()
    for _, s in ipairs(all) do
        total, ptsAll = total + 1, ptsAll + s.points
        s.got = S.seals and S.seals[s.id]
        s.by = S.sealBy and S.sealBy[s.id]
        if s.got then got, pts = got + 1, pts + s.points end
        if s.got and me and s.by == me then mine = mine + 1 end
        -- úpravy pro zobrazení
        if s.faction then
            local F = FACTION[s.faction]
            s.desc = F.label .. " – " .. s.desc
            if not s.got and fac and F.key ~= fac then s.statusText, s.dim = F.only, true end
        end
        if s.group == "legenda" and not s.got and not s.statusText and not s.what then s.statusText = "zatím nesplněno" end
        if s.hidden and not s.got then
            s.name, s.desc, s.statusText = "? ? ?", s.hint, "skrytá pečeť"
        end
    end
    local here, general, zones, dungs, legends, hidden = {}, {}, {}, {}, {}, {}
    local postava, svet, remeslo, reputace, znalost = {}, {}, {}, {}, {}
    local nextShown = {}
    local byName = function(a, b) return a.name < b.name end
    for _, s in ipairs(all) do
        if s.key and s.key == key then
            here[#here + 1] = s
        elseif s.group == "obecne" or s.group == "postava" then
            -- u série jen získané + nejbližší další stupeň
            if s.got or not nextShown[s.series] then
                local list = s.group == "postava" and postava or general
                list[#list + 1] = s
                if not s.got then nextShown[s.series] = true end
            end
        elseif s.group == "legenda" then
            legends[#legends + 1] = s
        elseif s.group == "skryta" then
            hidden[#hidden + 1] = s
        elseif s.group == "znalost" then
            if s.got then znalost[#znalost + 1] = s end
        elseif s.group == "svet" then
            if not s.dim or s.got then svet[#svet + 1] = s end
        elseif s.group == "remeslo" then
            if s.got or s.have > 0 then remeslo[#remeslo + 1] = s end
        elseif s.group == "reputace" then
            if not s.dim or s.got then reputace[#reputace + 1] = s end
        elseif s.got or s.have > 0 then
            local list = s.group == "oblast" and zones or dungs
            list[#list + 1] = s
        end
    end
    table.sort(zones, byName)
    table.sort(dungs, byName)
    -- legendy: získané první, pak tvoje frakce, nakonec druhá frakce
    table.sort(legends, function(a, b)
        local ka = a.got and 0 or (a.dim and 2 or 1)
        local kb = b.got and 0 or (b.dim and 2 or 1)
        if ka ~= kb then return ka < kb end
        return a.name < b.name
    end)
    table.sort(hidden, function(a, b) return (a.got and 0 or 1) < (b.got and 0 or 1) end)
    local rank, nxt = rankOf(pts)
    local page = {
        { "Pečetě kronikáře", ("Hodnost: |cff801f0d%s|r%s\n"):format(rank,
                nxt and ("  ·  do hodnosti %s chybí %d bodů"):format(nxt[2], nxt[1] - pts) or "")
            .. ("Získáno |cff801f0d%d|r z %d pečetí  ·  body: |cff801f0d%d|r z %d"):format(got, total, pts, ptsAll)
            .. (me and ("\nZ toho získala postava %s: |cff801f0d%d|r."):format(me, mine) or "")
            .. "\nPečetě jsou společné pro všechny tvoje postavy. Najeď myší na pečeť a uvidíš, co ještě chybí.",
            seals = here },
        { "Legendy Azerothu", "Slavné příběhy klasického WoW. Některé zvládne jen Aliance, jiné jen Horda.", seals = legends },
        { "Skryté pečetě", "Tajemství, která se odhalí, až na ně narazíš.", seals = hidden },
        { "Hrdinské pečetě", "Za lov vzácných mobů, cestování, objevování, dungeony a čtení kroniky.", seals = general },
        { "Postava", "Úroveň, bohatství, jízda – a kolikrát už tě Azeroth porazil.", seals = postava },
        { "Svět", "Celé kontinenty a hlavní města.", seals = svet },
        { "Řemesla", #remeslo > 0 and "Profese, které se učíš – pečeť za mistrovství na úrovni 300."
            or "Zatím žádná profese. Nauč se řemeslo a pečeť se začne plnit.", seals = remeslo },
        { "Reputace", "Nejvyšší reputace Exalted u frakcí Azerothu.", seals = reputace },
        { "Zkouška kronikáře", #znalost > 0 and "Oblasti a dungeony, jejichž příběh znáš na výbornou."
            or "Zatím žádná složená zkouška. Najdeš ji v záložce Zkouška kronikáře.", seals = znalost },
        { "Oblasti", #zones > 0 and "Rozpracované a dokončené oblasti."
            or "Zatím žádná – projdi místa Poutníkova deníku a pečeť oblasti se začne plnit.", seals = zones },
        { "Dungeony a raidy", #dungs > 0 and "Rozpracované a dokončené dungeony."
            or "Zatím žádný – poraz bosse v dungeonu a pečeť se začne plnit.", seals = dungs,
          after = GRAY .. "Pečetě se zapisují samy. Zlatý vosk = vzácná pečeť, černý = skrytá.|r" },
    }
    return page
end

-------------------------------------------------------------------------------
-- Tvůj příběh: deník každé postavy zvlášť (WoWpoCeskuSeen.journal["Jméno-Realm"])
-------------------------------------------------------------------------------
local function charKey()
    local n = charName()
    if not n then return nil end
    local okR, realm = pcall(GetRealmName)
    return n .. "-" .. ((okR and type(realm) == "string") and realm or ""), n
end

local function journal(create)
    local key, name = charKey()
    if not key then return nil end
    local S = seen()
    S.journal = S.journal or {}
    local J = S.journal[key]
    if not J and create then
        local okS, sex = pcall(UnitSex, "player")
        J = { name = name, sex = okS and sex or nil, list = {}, zones = {}, dungs = {}, rares = {}, bosses = {}, deaths = 0 }
        S.journal[key] = J
        local okL, lvl = pcall(UnitLevel, "player")
        if okL and type(lvl) == "number" and lvl <= 2 then
            J.list[#J.list + 1] = { t = time(), k = "start" }
        else
            J.list[#J.list + 1] = { t = time(), k = "older", a = okL and lvl or nil }
        end
    end
    return J
end

journalAdd = function(kind, a, b)
    if WoWpoCeskuSettings and WoWpoCeskuSettings.journal == false then return end
    local J = journal(true)
    if not J then return end
    if kind == "zone" then if J.zones[a] then return end J.zones[a] = time() end
    if kind == "dungeon" then if J.dungs[a] then return end J.dungs[a] = time() end
    if kind == "rare" then if J.rares[a] then return end J.rares[a] = time() end
    if kind == "level" then J.levels = J.levels or {}; if J.levels[a] then return end J.levels[a] = time() end
    if kind == "death" then J.deathLog = J.deathLog or {}; if J.deathLog[a] then return end J.deathLog[a] = time() end
    if kind == "seal" or kind == "met" then J.once = J.once or {}; local id = kind .. ":" .. tostring(a); if J.once[id] then return end J.once[id] = time() end
    if kind == "boss" then
        local id = (b or "") .. ":" .. (a or "")
        if J.bosses[id] then return end
        J.bosses[id] = time()
    end
    J.list[#J.list + 1] = { t = time(), k = kind, a = a, b = b }
    while #J.list > 300 do table.remove(J.list, 1) end
end

-- pády v boji: zápis při 1., 10., 25., 50. a 100.
function WoWpoCesku_JournalDeath()
    local J = journal(true)
    if not J then return end
    J.deaths = (J.deaths or 0) + 1
    local n = J.deaths
    if n == 1 or n == 10 or n == 25 or n == 50 or n == 100 then journalAdd("death", n) end
end

-- věty deníku: víc variant, vybírá se podle času zápisu (stejný zápis = vždy stejná věta)
-- "(a)" se podle pohlaví postavy změní na "a" nebo zmizí
local SENT = {
    start = { "%s se poprvé probudil(a) v Azerothu. Začíná nový příběh." },
    older = { "Ze starších zápisů: tenhle příběh se začal psát dřív, než se ho kronika naučila zapisovat. %s už byl(a) na úrovni %s." },
    zone = { "%s poprvé vkročil(a) do oblasti %s.", "%s dorazil(a) do oblasti %s. Začíná nová kapitola.",
        "Cesta zavedla postavu %s do oblasti %s." },
    dungeon = { "%s poprvé sestoupil(a) do dungeonu %s.", "%s vstoupil(a) do dungeonu %s. Ze tmy se ozývaly kroky.",
        "Brány dungeonu se otevřely – %s vkročil(a) do %s." },
    boss = { "%s porazil(a) bosse %s (%s).", "Skupina, ve které byl(a) %s, srazila k zemi bosse %s v dungeonu %s." },
    level = { "%s dosáhl(a) úrovně %s.", "%s je zase o kus silnější: úroveň %s." },
    level60 = { "%s dosáhl(a) úrovně %s – vrcholu cesty. Teď začínají opravdové legendy." },
    seal = { "%s získal(a) pečeť %s.", "%s vtiskl(a) do kroniky novou pečeť: %s." },
    rare = { "%s spatřil(a) vzácného tvora: %s.", "%s zahlédl(a) vzácného tvora %s. Takové štěstí nemá každý." },
    met = { "%s potkal(a) postavu, o které se vyprávějí příběhy: %s." },
    death1 = { "%s poprvé padl(a) v boji – ale duch se vrátil mezi živé." },
    death = { "%s se zvedl(a) po %s. pádu. Azeroth není pro slabé." },
}

local function sentence(J, e)
    local kind = e.k
    if kind == "level" and tonumber(e.a) == 60 then kind = "level60" end
    if kind == "death" and tonumber(e.a) == 1 then kind = "death1" end
    local list = SENT[kind]
    if not list then return nil end
    local tpl = list[(e.t % #list) + 1]
    local ok, s = pcall(string.format, tpl, J.name or "?", tostring(e.a or "?"), tostring(e.b or ""))
    if not ok then s = tpl end
    s = s:gsub("([%?!])%.", "%1")
    if J.sex == 3 then s = s:gsub("%(a%)", "a") else s = s:gsub("%(a%)", "") end
    return s
end

-- záložka Tvůj příběh: zápisy po dnech, nejnovější nahoře
function WoWpoCesku_PribehPage()
    local J = journal(true)
    if not J then return { { "Tvůj příběh", "Kronika zatím neví, kdo jsi." } } end
    local page = {}
    local n = #J.list
    local first = J.list[1] and J.list[1].t
    page[1] = { "Příběh postavy " .. (J.name or "?"),
        ("Zápisů v kronice: %d%s. Kronika zapisuje sama: nové oblasti a dungeony, poražené bosse, úrovně, pečetě, vzácné tvory, slavné postavy i pády v boji.")
            :format(n, first and (" · první z " .. date("%d.%m.%Y", first)) or "") }
    local day, lines, shown = nil, {}, 0
    local function flush()
        if day and #lines > 0 then page[#page + 1] = { day, table.concat(lines, "\n\n") } end
        lines = {}
    end
    for i = n, 1, -1 do
        local e = J.list[i]
        local d = date("%d.%m.%Y", e.t)
        if d ~= day then flush(); day = d end
        local s = sentence(J, e)
        if s then lines[#lines + 1] = s; shown = shown + 1 end
        if shown >= 120 then break end
    end
    flush()
    return page
end

-------------------------------------------------------------------------------
-- Zkouška kronikáře: 5 otázek z oblasti / dungeonu (WoWpoCesku_Kviz), za 5/5 pečeť Znalec
-------------------------------------------------------------------------------
local QUIZ_LEN = 5
local quiz = nil   -- { key, items = { {otázka, odpovědi[4], správná index, kde} }, i, score, chosen }

local function shuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

local function startQuiz(key)
    local pool = WoWpoCesku_Kviz and WoWpoCesku_Kviz[key]
    if not pool or #pool == 0 then return end
    local idx = {}
    for i = 1, #pool do idx[i] = i end
    shuffle(idx)
    local items = {}
    for n = 1, math.min(QUIZ_LEN, #pool) do
        local q = pool[idx[n]]
        local answers = shuffle({ q[2], q[3], q[4], q[5] })
        local right
        for i, a in ipairs(answers) do if a == q[2] then right = i end end
        items[#items + 1] = { q[1], answers, right, q[6] }
    end
    quiz = { key = key, items = items, i = 1, score = 0 }
end

local function refresh()
    if WoWpoCesku_RefreshBook then WoWpoCesku_RefreshBook() end
end

function WoWpoCesku_ZkouskaPage(key)
    local pool = WoWpoCesku_Kviz and WoWpoCesku_Kviz[key]
    if not pool or #pool == 0 then
        return { { "Zkouška kronikáře", "Pro tuhle oblast zatím otázky nemám. Přibývají postupně – zkus jinou oblast nebo dungeon." } }
    end
    local S = seen()
    local passed = S.quiz and S.quiz[key]
    -- úvod
    if not quiz or quiz.key ~= key then
        return { { "Zkouška kronikáře",
            ("Pět otázek z příběhu, tajemství a legend této oblasti (v zásobě %d). Odpovědi najdeš v Kronice – i se spoilery.\n%s")
                :format(#pool, passed and ("|cff1d6b1dZkoušku jsi už složil(a) %s.|r"):format(date("%d.%m.%Y", passed))
                    or "Za pět správných odpovědí získáš pečeť Znalec."),
            rows = { { text = "|cff801f0d» Začít zkoušku|r", hint = "Zacit zkousku", onClick = function() startQuiz(key); refresh() end } } } }
    end
    -- výsledek
    if quiz.i > #quiz.items then
        local all = quiz.score == #quiz.items
        local text = ("Správně %d z %d."):format(quiz.score, #quiz.items)
        if all then
            text = text .. "\n|cff1d6b1dVýborně! Znáš příběh této oblasti jako pravý kronikář.|r"
        else
            text = text .. "\nNevadí – přečti si Letopis a Tajemství a zkus to znovu. Otázky se pokaždé zamíchají."
        end
        return { { "Výsledek zkoušky", text,
            rows = { { text = "|cff801f0d» Zkusit znovu|r", hint = "Zkusit znovu", onClick = function() startQuiz(key); refresh() end } } } }
    end
    -- otázka
    local it = quiz.items[quiz.i]
    local rows = {}
    for n, a in ipairs(it[2]) do
        local row = { text = ("%d)  %s"):format(n, a) }
        if quiz.chosen then
            if n == it[3] then row.text = "|cff1d6b1d" .. row.text .. "  – správně|r"
            elseif n == quiz.chosen then row.text = "|cff801f0d" .. row.text .. "  – tvoje odpověď|r" end
        else
            row.hint = "Vybrat odpoved"
            row.onClick = function()
                quiz.chosen = n
                if n == it[3] then quiz.score = quiz.score + 1 end
                PlaySound(n == it[3] and (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE or 618) or 847)
                refresh()
            end
        end
        rows[#rows + 1] = row
    end
    local chapter = { ("Otázka %d z %d"):format(quiz.i, #quiz.items), it[1], rows = rows }
    if quiz.chosen then
        local ok = quiz.chosen == it[3]
        local last = quiz.i == #quiz.items
        chapter.after = (ok and "|cff1d6b1dSprávně!|r" or "|cff801f0dTo není ono.|r")
            .. (it[4] and (GRAY .. "  Najdeš to v Kronice: " .. it[4] .. "|r") or "")
        rows[#rows + 1] = { text = last and "|cff801f0d» Vyhodnotit|r" or "|cff801f0d» Další otázka|r", hint = "Dalsi",
            onClick = function()
                quiz.i, quiz.chosen = quiz.i + 1, nil
                if quiz.i > #quiz.items and quiz.score == #quiz.items then
                    S.quiz = S.quiz or {}
                    if not S.quiz[key] then S.quiz[key] = time() end
                    C_Timer.After(0.5, function() pcall(checkSeals) end)
                end
                refresh()
            end }
    end
    return { chapter }
end

-------------------------------------------------------------------------------
-- Questy k dungeonu (kapitola v Letopisu dungeonu): jen pro tvou frakci, splněné odškrtnuté
-------------------------------------------------------------------------------
function WoWpoCesku_DungeonQuestsChapter(key)
    local list = WoWpoCesku_DungeonQuests and WoWpoCesku_DungeonQuests[key]
    if not list then return nil end
    local fac = myFaction()
    local rows, n, total, seenTitle = {}, 0, 0, {}
    local kinds = { 0, 0, 0 }
    for _, e in ipairs(list) do
        local id, title, lvl, minLvl, f, from, rew = e[1], e[2], e[3], e[4], e[5], e[6], e[7]
        -- stejný quest ve variantách pro obě frakce ukaž jen jednou
        if (not f or not fac or FACTION[f].key == fac) and not seenTitle[title] then
            seenTitle[title] = true
            total = total + 1
            local done = questDone(id)
            if done then n = n + 1 end
            local cz = WoWpoCesku_Data and WoWpoCesku_Data[id] and WoWpoCesku_Data[id].title
            local text = (cz and cz ~= title) and (cz .. GRAY .. "  (" .. title .. ")|r") or title
            text = text .. GRAY .. ("  – level %d, od %d"):format(lvl, minLvl) .. "|r"
            if f then text = text .. "  " .. FACTION[f].label end
            local kind = 3   -- 1 = bere se před vchodem, 2 = uvnitř dungeonu, 3 = začíná předmětem
            if from and from ~= "" then
                local place = WoWpoCesku_DungeonQuestPlaces and WoWpoCesku_DungeonQuestPlaces[id]
                kind = (place and place:find("^uvnitř")) and 2 or 1
                text = text .. "\n" .. GRAY .. "Dává: |r" .. from .. (place and (GRAY .. "  – " .. place .. "|r") or "")
            else
                text = text .. "\n" .. GRAY .. "Začíná předmětem, který najdeš v dungeonu nebo u nepřítele.|r"
            end
            if rew and rew ~= "" then text = text .. "\n" .. GRAY .. "Odměna: |r" .. rew end
            rows[#rows + 1] = { mark = done, text = text, kind = kind, order = #rows + 1 }
            kinds[kind] = kinds[kind] + 1
        end
    end
    if total == 0 then return nil end
    -- nejdřív questy, které se berou před vchodem, pak ty uvnitř, nakonec ty od předmětů
    table.sort(rows, function(a, b)
        if a.kind ~= b.kind then return a.kind < b.kind end
        return a.order < b.order
    end)
    return { "Questy k dungeonu", ("Splněno %d z %d questů. Před vchodem se bere %d, uvnitř dungeonu %d, od předmětu %d. Ty z první skupiny vezmi dřív, než vyrazíš – ušetříš si cestu navíc."):format(n, total, kinds[1], kinds[2], kinds[3]),
        rows = rows,
        after = GRAY .. "Podle classic databáze (questy zařazené k dungeonu). Ve WoW Forever se může něco lišit.|r" }
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
pcall(ev.RegisterEvent, ev, "QUEST_TURNED_IN")
for _, e in ipairs({ "PLAYER_LEVEL_UP", "PLAYER_MONEY", "SKILL_LINES_CHANGED", "UPDATE_FACTION", "PLAYER_DEAD", "UNIT_PET" }) do
    pcall(ev.RegisterEvent, ev, e)
end
-- /czq pecete: co addon o postavě zjistil (kontrola, že se profese a reputace čtou)
function WoWpoCesku_SealDebug()
    pcall(updateStats)
    local S = seen()
    local profs = {}
    for k, v in pairs(S.prof or {}) do profs[#profs + 1] = k .. " " .. v end
    local reps = {}
    for k in pairs(S.rep or {}) do reps[#reps + 1] = k end
    say(("pecete: uroven %d, nejvic zlata %d, jizda %d, smrti %d"):format(S.maxLvl or 0, math.floor((S.maxGold or 0) / 10000), S.riding or 0, S.deaths or 0))
    say("profese: " .. (#profs > 0 and table.concat(profs, ", ") or "zadne nenalezeny"))
    say("exalted: " .. (#reps > 0 and table.concat(reps, ", ") or "zatim zadne"))
    pcall(checkSeals)
end
-- statistiky postavy a kontrola pečetí nejvýš jednou za 3 s (PLAYER_MONEY chodí často)
local statsPending
local function scheduleStats()
    if statsPending then return end
    statsPending = true
    C_Timer.After(3, function() statsPending = nil; pcall(updateStats); pcall(checkSeals) end)
end
-- POZOR: COMBAT_LOG_EVENT_UNFILTERED ve WoW Forever addony registrovat nesmí (hra hlásí zakázanou akci)
ev:SetScript("OnEvent", function(_, event, unit, ...)
    if event == "PLAYER_LOGIN" then
        pcall(hookTooltip)
        pcall(hookMap)
        if not mapHooked then ev:RegisterEvent("ADDON_LOADED") end
        C_Timer.After(5, function() pcall(updateStats); pcall(checkSeals) end)
    elseif event == "ADDON_LOADED" then
        if unit == "Blizzard_WorldMap" then pcall(hookMap) end
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        pcall(checkRare, unit)
        pcall(metUnit, unit)
    elseif event == "PLAYER_TARGET_CHANGED" then
        pcall(checkRare, "target")
        pcall(metUnit, "target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        pcall(checkRare, "mouseover")
        pcall(metUnit, "mouseover")
    elseif event == "VIGNETTES_UPDATED" or event == "VIGNETTE_MINIMAP_UPDATED" then
        pcall(checkVignettes)
    elseif event == "PLAYER_DEAD" then
        local S = seen()
        S.deaths = (S.deaths or 0) + 1
        if WoWpoCesku_JournalDeath then pcall(WoWpoCesku_JournalDeath) end
        scheduleStats()
    elseif event == "UNIT_PET" then
        -- ochočené zvíře má zpočátku jméno tvora: vzácný = skrytá pečeť Krotitel
        local okP, pet = pcall(UnitName, "pet")
        if unit == "player" and okP and type(pet) == "string" and not secret(pet) and RARE[pet] then
            local S = seen()
            if not S.tamed then S.tamed = time(); scheduleStats() end
        end
    elseif event == "PLAYER_LEVEL_UP" and type(unit) == "number" and (unit % 5 == 0 or unit == 60) then
        if journalAdd then pcall(journalAdd, "level", unit) end
        scheduleStats()
    elseif event == "PLAYER_LEVEL_UP" or event == "PLAYER_MONEY" or event == "SKILL_LINES_CHANGED" or event == "UPDATE_FACTION" then
        scheduleStats()
    elseif event == "QUEST_TURNED_IN" then
        C_Timer.After(2, function() pcall(checkSeals) end)
    elseif event == "ENCOUNTER_END" then
        local encName, _, _, success = ...   -- unit = encounterID
        if success == 1 then pcall(markBoss, encName) end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if not (alert and alert:IsShown()) then hideTargetButton() end
    else
        C_Timer.After(1, function() pcall(recordPlace) end)
    end
end)
