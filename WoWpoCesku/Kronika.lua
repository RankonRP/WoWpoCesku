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
local function recordPlace()
    local key = zoneKey()
    if not key then return end
    local S = seen()
    S.sub[key] = S.sub[key] or {}
    local sub = GetSubZoneText and GetSubZoneText()
    if sub and sub ~= "" and not secret(sub) and not S.sub[key][sub] then S.sub[key][sub] = time() end
    local real = GetRealZoneText and GetRealZoneText()
    if real and real ~= "" and not secret(real) and not S.z[real] then S.z[real] = time() end
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

local mapHooked
local function hookMap()
    if mapHooked or not WorldMapFrame then return end
    mapHooked = true
    -- body jen na mapě té oblasti; při změně mapy schovat / znovu ukázat
    hooksecurefunc(WorldMapFrame, "OnMapChanged", function(self)
        if pinMapID and self:GetMapID() == pinMapID and pinName then
            placePins(rarePoints(pinName, pinMapID))
        else
            hidePins()
        end
    end)
end

function WoWpoCesku_ShowRareOnMap(name)
    local mapID = WoWpoCesku_BookMapID or (C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player"))
    local points = rarePoints(name, mapID)
    if #points == 0 then
        say(("pro %s nemam souradnice - zkus ho najit sam a addon si ho zapise."):format(name))
        return
    end
    pinMapID, pinName = mapID, name
    if not WorldMapFrame:IsShown() then
        if ToggleWorldMap then ToggleWorldMap() else WorldMapFrame:Show() end
    end
    pcall(hookMap)
    WorldMapFrame:SetMapID(mapID)
    C_Timer.After(0.05, function() placePins(points) end)
    -- případnou starou herní značku (animovaný ping) smazat
    pcall(function() if C_Map.ClearUserWaypoint then C_Map.ClearUserWaypoint() end end)
    say(("%s: %d mist vyskytu na mape"):format(name, #points))
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
            if first then say(("Kronika: %s zapsan do Bestiare (%s)"):format(b[1], key)) end
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
-- Poznámky k postavám a rarům pod popiskem NPC (vlastní okno – písmo popisku neumí č/ř/ů)
-------------------------------------------------------------------------------
local note
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
    if not note then
        note = parchmentFrame("WoWpoCeskuNpcNote", GameTooltip, "TOOLTIP")
        note:SetClampedToScreen(true)
        GameTooltip:HookScript("OnHide", function() note:Hide() end)
    end
    note.title:SetText(title)
    note.text:SetText(text)
    note:ClearAllPoints()
    note:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 0, -2)
    fitFrame(note, math.max(260, GameTooltip:GetWidth()))
    note:Show()
end

local function hookTooltip()
    if TooltipDataProcessor and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Unit then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tt)
            pcall(onUnitTooltip, tt)
        end)
    elseif GameTooltip:HasScript("OnTooltipSetUnit") then
        GameTooltip:HookScript("OnTooltipSetUnit", function(tt) pcall(onUnitTooltip, tt) end)
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
ev:RegisterEvent("ADDON_ACTION_BLOCKED")
ev:RegisterEvent("ADDON_ACTION_FORBIDDEN")
pcall(ev.RegisterEvent, ev, "ENCOUNTER_END")
pcall(ev.RegisterEvent, ev, "COMBAT_LOG_EVENT_UNFILTERED")
ev:SetScript("OnEvent", function(_, event, unit, ...)
    if event == "PLAYER_LOGIN" then
        pcall(hookTooltip)
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
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        if IsInInstance and IsInInstance() and CombatLogGetCurrentEventInfo then
            local ok, _, sub, _, _, _, _, _, _, destName = pcall(CombatLogGetCurrentEventInfo)
            if ok and (sub == "UNIT_DIED" or sub == "PARTY_KILL") then pcall(markBoss, destName) end
        end
    elseif event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" then
        -- unit = název addonu, ... = funkce, kterou hra zablokovala – ať víme, co opravit
        local func = ...
        if unit == "WoWpoCesku" then
            say(("hra zablokovala akci: %s (napis to prosim autorovi)"):format(tostring(func)))
            local S = seen()
            S.blocked = S.blocked or {}
            S.blocked[#S.blocked + 1] = date("%d.%m. %H:%M ") .. tostring(func)
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if not (alert and alert:IsShown()) then hideTargetButton() end
    else
        C_Timer.After(1, function() pcall(recordPlace) end)
    end
end)
