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

local function showAlert(name, info, rec)
    if not alert then
        alert = parchmentFrame("WoWpoCeskuRareAlert", UIParent, "HIGH")
        alert:SetPoint("TOP", 0, -110)
        alert:EnableMouse(false)
        local anim = alert:CreateAnimationGroup()
        local hold = anim:CreateAnimation("Alpha")
        hold:SetFromAlpha(1) hold:SetToAlpha(1) hold:SetDuration(6) hold:SetOrder(1)
        local out = anim:CreateAnimation("Alpha")
        out:SetFromAlpha(1) out:SetToAlpha(0) out:SetDuration(1.5) out:SetOrder(2)
        anim:SetScript("OnPlay", function() alert:Show(); alert:SetAlpha(1) end)
        anim:SetScript("OnFinished", function() alert:Hide() end)
        alert.anim = anim
    end
    alert.title:SetText("Vzácný mob: " .. name)
    alert.text:SetText(rareNote(name, info, rec))
    fitFrame(alert, 340)
    alert.anim:Stop()
    alert.anim:Play()
end

local function checkRare(unit)
    if not WoWpoCeskuSettings or WoWpoCeskuSettings.rareAlert == false then return end
    local okN, name = pcall(UnitName, unit)
    if not okN or not name or secret(name) then return end
    local okC, cls = pcall(UnitClassification, unit)
    if not okC or secret(cls) then cls = nil end
    local info = RARE[name]
    if not info and cls ~= "rare" and cls ~= "rareelite" then return end
    local okP, isPlayer = pcall(UnitIsPlayer, unit)
    if okP and isPlayer == true then return end

    -- deník: kde a kdy
    local S = seen()
    local rec = S.rares[name] or { n = 0 }
    local now = time()
    if not rec.t or now - rec.t > 300 then rec.n = (rec.n or 0) + 1 end
    rec.t = now
    rec.z = zoneKey()
    rec.x, rec.y = playerPos()
    rec.c = cls
    local okL, lvl = pcall(UnitLevel, unit)
    if okL and not secret(lvl) then rec.l = lvl end
    rec.new = (info == nil) or nil
    S.rares[name] = rec

    -- upozornění nejvýš jednou za 5 minut na stejného
    if lastAlert[name] and GetTime() - lastAlert[name] < 300 then return end
    lastAlert[name] = GetTime()
    PlaySound(SOUNDKIT and SOUNDKIT.RAID_WARNING or 8959, "Master")
    showAlert(name, info, rec)
    say(("vzacny mob: %s%s"):format(name, rec.x and (" (%.1f, %.1f)"):format(rec.x, rec.y) or ""))
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

local YES, NO = "|cff1d6b1d[x]|r ", "|cff8a7458[  ]|r "
local GRAY = "|cff6b4d2e"

-- záložka Poutníkův deník: místa v oblasti
function WoWpoCesku_DenikPage(key)
    local places = WoWpoCesku_Objevy and WoWpoCesku_Objevy[key]
    if not places then
        if WoWpoCesku_RareList and WoWpoCesku_RareList[key] then
            return { { "Poutníkův deník", "Pro tuhle oblast zatím nemám seznam míst k objevení." } }
        end
        return nil
    end
    local lines, n = {}, 0
    for _, place in ipairs(places) do
        local ok = placeVisited(place)
        if ok then n = n + 1 end
        lines[#lines + 1] = (ok and YES or NO) .. place
    end
    local head = ("Objeveno %d z %d míst.%s\n\n"):format(n, #places,
        n == #places and "  |cff1d6b1dVšechno jsi prozkoumal!|r" or "")
    return {
        { "Poutníkův deník", head .. table.concat(lines, "\n")
            .. "\n\n" .. GRAY .. "Místo se odškrtne samo, když ho navštívíš (název vidíš u minimapy).|r" },
    }
end

-- záložka Bestiář: vzácní mobové oblasti, co jsi viděl a kde
function WoWpoCesku_BestiarPage(key)
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
    local lines, n = {}, 0
    for _, name in ipairs(rares) do
        local info, rec = RARE[name], S.rares[name]
        if rec then n = n + 1 end
        local desc = {}
        if info.lvl and info.lvl ~= "?" then desc[#desc + 1] = "level " .. info.lvl end
        if info.tame then desc[#desc + 1] = "ochočitelný" end
        local line = (rec and YES or NO) .. name
        if #desc > 0 then line = line .. GRAY .. "  – " .. table.concat(desc, ", ") .. "|r" end
        if rec and rec.t then
            line = line .. "\n      " .. GRAY .. "viděn " .. date("%d.%m. %H:%M", rec.t)
                .. (rec.x and (" na %.1f, %.1f"):format(rec.x, rec.y) or "")
                .. ((rec.n or 1) > 1 and ("  (%dx)"):format(rec.n) or "") .. "|r"
        end
        lines[#lines + 1] = line
    end
    local page = {
        { "Bestiář", ("Viděno %d z %d vzácných mobů.\n\n"):format(n, #rares) .. table.concat(lines, "\n")
            .. "\n\n" .. GRAY .. "Seznam je z classic dat – ve WoW Forever se mnozí teprve potvrzují. Když nějakého uvidíš, addon ho sám zapíše.|r" },
    }
    if #extra > 0 then
        table.sort(extra)
        local ex = {}
        for _, name in ipairs(extra) do
            local rec = S.rares[name]
            ex[#ex + 1] = YES .. name .. (rec.l and (GRAY .. "  – level " .. rec.l .. "|r") or "")
                .. "\n      " .. GRAY .. "viděn " .. date("%d.%m. %H:%M", rec.t or 0)
                .. (rec.x and (" na %.1f, %.1f"):format(rec.x, rec.y) or "") .. "|r"
        end
        page[#page + 1] = { "Tvoje objevy navíc", "Vzácní mobové, kteří v classic datech nejsou – nejspíš novinky WoW Forever. Napiš mi o nich!\n\n"
            .. table.concat(ex, "\n") }
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
ev:SetScript("OnEvent", function(_, event, unit)
    if event == "PLAYER_LOGIN" then
        pcall(hookTooltip)
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        pcall(checkRare, unit)
    elseif event == "PLAYER_TARGET_CHANGED" then
        pcall(checkRare, "target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        pcall(checkRare, "mouseover")
    else
        C_Timer.After(1, function() pcall(recordPlace) end)
    end
end)
