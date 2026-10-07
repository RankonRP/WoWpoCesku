-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- Kompas: tenký pruh nahoře na obrazovce. Ukazuje sledovaný cíl, vstupy do dungeonů v oblasti a blízké vzácné moby,
-- u každé značky je vzdálenost. Cíl se nastaví klikem na vstup v Dungeon Kronice nebo na vzácného moba v Bestiáři.
-- Bez navigační mřížky hry jde jen o směr a vzdálenost vzdušnou čarou.
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"

local BAR_W, BAR_H = 520, 34
local HALF = math.pi / 2   -- pruh ukazuje 180° před hráčem (±90°)
local RARE_RANGE = 300     -- vzácní moby dál než tohle (yardy) se neukazují

local function cfg()
    WoWpoCeskuSettings = WoWpoCeskuSettings or {}
    return WoWpoCeskuSettings
end

local target   -- { uiMap, u, v, label }
local bar, marks = nil, {}
local elapsed = 0

local function say(t) print("|cffffd100WoWpoCesku:|r " .. t) end

local function playerMapPos()
    if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetPlayerMapPosition) then return end
    local id = C_Map.GetBestMapForUnit("player")
    if not id then return end
    local p = C_Map.GetPlayerMapPosition(id, "player")
    if not p then return end
    local x, y = p:GetXY()
    if not x or (x == 0 and y == 0) then return end
    return id, x, y
end

-- směr (rad, po směru hodin od severu) a vzdálenost (yardy) z bodu hráče k cíli
local function vector(pid, px, py, tmap, tu, tv)
    -- 1. světové souřadnice (funguje i mezi mapami stejného kontinentu)
    if C_Map.GetWorldPosFromMapPos and CreateVector2D then
        local ok, c1, w1, c2, w2 = pcall(function()
            local a, wa = C_Map.GetWorldPosFromMapPos(pid, CreateVector2D(px, py))
            local b, wb = C_Map.GetWorldPosFromMapPos(tmap, CreateVector2D(tu, tv))
            return a, wa, b, wb
        end)
        if ok and c1 and c1 == c2 and w1 and w2 then
            local north = w2.x - w1.x
            local east = -(w2.y - w1.y)   -- ve světě je y směrem na západ
            return math.atan2(east, north), math.sqrt(north * north + east * east)
        end
    end
    -- 2. stejná mapa: rozměr mapy v yardech
    if tmap == pid and C_Map.GetMapWorldSize then
        local ok, w, h = pcall(C_Map.GetMapWorldSize, pid)
        if ok and w and h and w > 0 then
            local east, north = (tu - px) * w, -(tv - py) * h
            return math.atan2(east, north), math.sqrt(east * east + north * north)
        end
    end
end

local function norm(a)
    while a > math.pi do a = a - 2 * math.pi end
    while a < -math.pi do a = a + 2 * math.pi end
    return a
end

local function dist(d)
    if d >= 1000 then return ("%.1f km"):format(d / 1000) end
    return ("%d yd"):format(d + 0.5)
end

local function createBar()
    bar = CreateFrame("Frame", "WoWpoCeskuKompas", UIParent, "BackdropTemplate")
    bar:SetSize(BAR_W, BAR_H)
    bar:SetFrameStrata("MEDIUM")
    local c = cfg().compassPos
    if c then bar:SetPoint(c[1], UIParent, c[1], c[2], c[3]) else bar:SetPoint("TOP", UIParent, "TOP", 0, -26) end
    bar:SetClampedToScreen(true)
    bar:SetMovable(true)
    bar:EnableMouse(true)
    bar:RegisterForDrag("LeftButton")
    bar:SetScript("OnDragStart", function(self) if IsShiftKeyDown() then self:StartMoving() end end)
    bar:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local p, _, _, x, y = self:GetPoint()
        cfg().compassPos = { p, x, y }
    end)

    -- střed (kam se díváš)
    local mid = bar:CreateTexture(nil, "OVERLAY")
    mid:SetSize(2, 9)
    mid:SetPoint("BOTTOM", 0, 0)
    mid:SetColorTexture(1, 0.82, 0.30, 0.7)

    bar.cards = {}
    for i, def in ipairs({ { 0, "S" }, { math.pi / 2, "V" }, { math.pi, "J" }, { -math.pi / 2, "Z" } }) do
        local fs = bar:CreateFontString(nil, "OVERLAY")
        fs:SetFont(FONT, 14, "OUTLINE")
        fs:SetTextColor(1, 0.82, 0.30)
        fs:SetText(def[2])
        bar.cards[i] = { fs = fs, bearing = def[1] }
    end
    bar.ticks = {}
    for i = 1, 48 do   -- tečky po 7,5°, každá šestá (45°) je větší
        local t = bar:CreateTexture(nil, "ARTWORK")
        local big = (i - 1) % 6 == 0
        t:SetSize(big and 3 or 2, big and 3 or 2)
        t:SetColorTexture(1, 0.9, 0.65, big and 0.95 or 0.6)
        bar.ticks[i] = { tex = t, bearing = (i - 1) * math.pi / 24 }
    end
    bar.label = bar:CreateFontString(nil, "OVERLAY")
    bar.label:SetFont(FONT, 12, "OUTLINE")
    bar.label:SetTextColor(1, 0.95, 0.8)
    bar.label:SetPoint("TOP", bar, "BOTTOM", 0, -3)
end

local function mark(i)
    local m = marks[i]
    if m then return m end
    m = {}
    m.icon = bar:CreateTexture(nil, "OVERLAY", nil, 2)
    m.icon:SetSize(16, 16)
    m.text = bar:CreateFontString(nil, "OVERLAY")
    m.text:SetFont(FONT, 10, "OUTLINE")
    m.text:SetTextColor(1, 1, 1)
    -- průhledné políčko nad ikonou kvůli tooltipu
    m.hit = CreateFrame("Frame", nil, bar)
    m.hit:SetSize(30, 30)
    m.hit:EnableMouse(true)
    m.hit:SetScript("OnEnter", function(self)
        local it = m.info
        if not it then return end
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:AddLine(it.label or "?", 1, 1, 1)
        if it.kind == "rare" then
            GameTooltip:AddLine("Vzacny mob - mozne misto vyskytu", 1, 0.82, 0)
            if it.lvl then GameTooltip:AddLine("Level " .. it.lvl, 0.8, 0.8, 0.8) end
            GameTooltip:AddLine(it.seen and "Uz jsi ho videl" or "Zatim jsi ho nevidel", 0.8, 0.8, 0.8)
            GameTooltip:AddLine("Podrobnosti: Kronika > Bestiar", 0.6, 0.6, 0.6)
        elseif it.kind == "dungeon" then
            GameTooltip:AddLine("Vstup do dungeonu", 1, 0.82, 0)
        else
            GameTooltip:AddLine("Sledovany cil", 1, 0.82, 0)
            GameTooltip:AddLine("Zrusit: /czq kompas zrusit", 0.6, 0.6, 0.6)
        end
        if it.d then GameTooltip:AddLine("Vzdalenost: " .. dist(it.d), 0.8, 0.8, 0.8) end
        GameTooltip:Show()
    end)
    m.hit:SetScript("OnLeave", GameTooltip_Hide)
    marks[i] = m
    return m
end

local ICONS = {
    target = "Interface\\Icons\\INV_Misc_Map_01",
    dungeon = "Interface\\Icons\\INV_Misc_Key_14",
    rare = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
}

local function hideAll()
    if not bar then return end
    bar:Hide()
end

local function update()
    local on = cfg().compass ~= false
    if not on then hideAll() return end
    local pid, px, py = playerMapPos()
    if not pid or not GetPlayerFacing then hideAll() return end   -- v dungeonu pozici hra neříká
    local facing = GetPlayerFacing()
    if not facing then hideAll() return end   -- např. na lodi nebo při jízdě taxíkem
    if not bar then createBar() end
    bar:Show()

    -- světové strany a značky po 45°
    local function xFor(rel) return rel / HALF * (BAR_W / 2 - 14) end
    for _, c in ipairs(bar.cards) do
        local rel = norm(c.bearing + facing)
        if math.abs(rel) <= HALF then c.fs:ClearAllPoints(); c.fs:SetPoint("CENTER", bar, "CENTER", xFor(rel), 8); c.fs:Show() else c.fs:Hide() end
    end
    for _, t in ipairs(bar.ticks) do
        local rel = norm(t.bearing + facing)
        if math.abs(rel) <= HALF then t.tex:ClearAllPoints(); t.tex:SetPoint("BOTTOM", bar, "BOTTOM", xFor(rel), 3); t.tex:Show() else t.tex:Hide() end
    end

    -- seznam značek
    local items = {}
    if target then items[#items + 1] = { kind = "target", map = target.uiMap, u = target.u, v = target.v, label = target.label } end
    local entries = WoWpoCesku_DungeonEntryMap
    if entries then
        for key, m in pairs(entries) do
            if m[1] == pid and not (target and target.label == key .. " - vstup") then
                items[#items + 1] = { kind = "dungeon", map = m[1], u = m[2], v = m[3], label = key }
            end
        end
    end
    if cfg().compassRares ~= false and WoWpoCesku_RareInfo and WoWpoCesku_RarePoints then
        local zone = WoWpoCesku_CurrentZoneKey and WoWpoCesku_CurrentZoneKey() or (GetRealZoneText and GetRealZoneText())
        if zone then
            local seenR = WoWpoCeskuSeen and WoWpoCeskuSeen.rares
            for name, info in pairs(WoWpoCesku_RareInfo) do
                if info.zone == zone and not (target and target.label == name) then
                    local best, bd
                    for _, p in ipairs(WoWpoCesku_RarePoints(name, pid)) do
                        local _, d = vector(pid, px, py, pid, p[1], p[2])
                        if d and (not bd or d < bd) then best, bd = p, d end
                    end
                    if best and bd <= RARE_RANGE then
                        items[#items + 1] = { kind = "rare", map = pid, u = best[1], v = best[2], label = name, lvl = info.lvl, seen = seenR and seenR[name] ~= nil }
                    end
                end
            end
        end
    end

    local used = 0
    local label
    for _, it in ipairs(items) do
        local dir, d = vector(pid, px, py, it.map, it.u, it.v)
        if dir then
            if it.kind == "target" then
                if d < 15 then
                    say(("cil %s dosazen."):format(it.label or ""))
                    target = nil
                    label = nil
                else
                    label = ("%s  -  %s"):format(it.label or "Cil", dist(d))
                end
            end
            local rel = norm(dir + facing)
            local inView = math.abs(rel) <= HALF
            if inView or it.kind == "target" then
                used = used + 1
                local m = mark(used)
                local x = xFor(math.max(-HALF, math.min(HALF, rel)))
                m.icon:SetTexture(ICONS[it.kind])
                m.icon:ClearAllPoints()
                m.icon:SetPoint("CENTER", bar, "CENTER", x, 4)
                m.icon:SetAlpha(inView and (it.kind == "rare" and it.seen and 0.6 or 1) or 0.6)
                m.icon:SetSize(it.kind == "target" and 20 or 16, it.kind == "target" and 20 or 16)
                m.icon:Show()
                m.info = { kind = it.kind, label = it.label, d = d, seen = it.seen, lvl = it.lvl }
                m.hit:ClearAllPoints()
                m.hit:SetPoint("CENTER", m.icon, "CENTER", 0, -4)
                m.hit:Show()
                m.text:ClearAllPoints()
                m.text:SetPoint("TOP", m.icon, "BOTTOM", 0, 1)
                m.text:SetText(inView and dist(d) or (rel < 0 and "<" or ">"))
                m.text:Show()
            end
        end
    end
    for i = used + 1, #marks do marks[i].icon:Hide(); marks[i].text:Hide(); marks[i].hit:Hide(); marks[i].info = nil end
    bar.label:SetText(label or "")
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(_, dt)
    elapsed = elapsed + dt
    if elapsed < 0.05 then return end
    elapsed = 0
    local ok, err = pcall(update)
    if not ok and not f.failed then
        f.failed = true
        say("kompas: chyba " .. tostring(err) .. " (kompas se vypnul, /czq kompas ho zapne)")
        cfg().compass = false
        hideAll()
    end
end)

-- nastavení cíle (volá se z Dungeon Kroniky a Bestiáře)
function WoWpoCesku_Track(uiMap, u, v, label)
    if not uiMap or not u or not v then return end
    target = { uiMap = uiMap, u = u, v = v, label = label }
    if cfg().compass == false then
        cfg().compass = true
        f.failed = nil
        say("kompas zapnut (vypnes ho prikazem /czq kompas).")
    end
end

function WoWpoCesku_Untrack()
    target = nil
    say("cil kompasu zrusen.")
end

-- nejbližší známé místo vzácného moba na mapě, kde stojíš
function WoWpoCesku_TrackRare(name)
    if not (WoWpoCesku_RarePoints and name) then return end
    local pid, px, py = playerMapPos()
    pid = pid or (C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player"))
    if not pid then return end
    local best, bd
    for _, p in ipairs(WoWpoCesku_RarePoints(name, pid)) do
        local d = px and select(2, vector(pid, px, py, pid, p[1], p[2])) or 0
        if not bd or d < bd then best, bd = p, d end
    end
    if best then WoWpoCesku_Track(pid, best[1], best[2], name) end
end

function WoWpoCesku_CompassCommand(arg)
    arg = (arg or ""):lower()
    if arg == "zrusit" or arg == "cancel" then
        WoWpoCesku_Untrack()
    elseif arg == "vzacni" then
        cfg().compassRares = not (cfg().compassRares ~= false)
        say("kompas: vzacni mobove " .. (cfg().compassRares ~= false and "ZAPNUTI" or "VYPNUTI"))
    else
        cfg().compass = not (cfg().compass ~= false)
        f.failed = nil
        say("kompas " .. (cfg().compass ~= false and "ZAPNUT" or "VYPNUT") .. " (cil zrusis /czq kompas zrusit, vzacne moby /czq kompas vzacni)")
    end
end
