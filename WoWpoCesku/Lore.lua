-- WoWpoCesku: příběhy oblastí (lore)
--  * při vstupu do oblasti nahoře krátce název + úvodní věta (klik = kniha)
--  * kniha s celým příběhem v kapitolách – vždy jen pro oblast, kde hráč je
--  * /czq lore = kniha pro oblast, kde jsi; /czq lore vyp|zap = titulky při vstupu
--  * navštívené oblasti se ukládají (WoWpoCeskuSeen.z), ať je jasné, které příběhy psát dál
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local GOLD = { 1, 0.82, 0.35 }

local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end

-- název oblasti, kde hráč je (anglicky, jak ho dává hra)
local function currentZone()
    local id = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
    -- vyšší úroveň mapy, dokud nenarazíme na zónu (podoblasti a města mají vlastní mapu)
    for _ = 1, 4 do
        local info = id and C_Map.GetMapInfo(id)
        if not info then break end
        if WoWpoCesku_Lore[info.name] or WoWpoCesku_LoreAlias[info.name] then return info.name end
        if info.mapType and info.mapType <= 3 then return info.name end
        id = info.parentMapID
    end
    return (GetRealZoneText and GetRealZoneText()) or (GetZoneText and GetZoneText()) or "?"
end

local function resolve(name)
    if not name then return nil end
    if WoWpoCesku_Lore[name] then return name end
    local a = WoWpoCesku_LoreAlias[name]
    if a and WoWpoCesku_Lore[a] then return a end
    -- podoblast (třeba Thendal Grove uvnitř nového ostrova)
    local sub = GetSubZoneText and GetSubZoneText()
    if sub and sub ~= "" then
        if WoWpoCesku_Lore[sub] then return sub end
        a = WoWpoCesku_LoreAlias[sub]
        if a and WoWpoCesku_Lore[a] then return a end
    end
end


-------------------------------------------------------------------------------
-- Kniha
-------------------------------------------------------------------------------
local book, bookKey

local function fontString(parent, size, r, g, b, flags)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(FONT, size, flags or "")
    fs:SetTextColor(r or 1, g or 1, b or 1)
    fs:SetJustifyH("LEFT")
    return fs
end

local function fillBook(key)
    bookKey = key
    local L = WoWpoCesku_Lore[key]
    book.title:SetText(L.title)
    book.tag:SetText(L.tag)
    local y = 0
    local w = book.content:GetWidth()
    -- kapitoly + na konec „Tajemství a kam se podívat“
    local chapters = {}
    for _, ch in ipairs(L.ch) do chapters[#chapters + 1] = ch end
    local books = WoWpoCesku_LoreKnihy and WoWpoCesku_LoreKnihy[key]
    if books then chapters[#chapters + 1] = { "Z knih a legend (spoilery)", books } end
    local secrets =WoWpoCesku_LoreTajemstvi and WoWpoCesku_LoreTajemstvi[key]
    if secrets then chapters[#chapters + 1] = { "Tajemství a kam se podívat", secrets } end
    L = { ch = chapters }
    for i, ch in ipairs(L.ch) do
        local h = book.heads[i]
        if not h then
            h = fontString(book.content, 15, GOLD[1], GOLD[2], GOLD[3])
            book.heads[i] = h
        end
        local p = book.paras[i]
        if not p then
            p = fontString(book.content, 13, 0.92, 0.9, 0.85)
            p:SetSpacing(3)
            book.paras[i] = p
        end
        h:SetWidth(w)
        p:SetWidth(w)
        h:ClearAllPoints()
        h:SetPoint("TOPLEFT", 0, -y)
        h:SetText(ch[1])
        h:Show()
        y = y + h:GetStringHeight() + 6
        p:ClearAllPoints()
        p:SetPoint("TOPLEFT", 0, -y)
        p:SetText(ch[2])
        p:Show()
        y = y + p:GetStringHeight() + 18
    end
    for i = #L.ch + 1, #book.heads do book.heads[i]:Hide(); book.paras[i]:Hide() end
    book.content:SetHeight(math.max(1, y))
    book.sf:SetVerticalScroll(0)
end

local function createBook()
    book = CreateFrame("Frame", "WoWpoCeskuLore", UIParent, "BackdropTemplate")
    book:SetSize(560, 600)
    book:SetPoint("CENTER")
    book:SetFrameStrata("DIALOG")
    book:SetToplevel(true)
    book:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
    book:SetBackdropColor(0.06, 0.045, 0.03, 0.97)
    book:SetBackdropBorderColor(0.75, 0.55, 0.25, 1)
    book:EnableMouse(true)
    book:SetMovable(true)
    book:SetClampedToScreen(true)
    book:RegisterForDrag("LeftButton")
    book:SetScript("OnDragStart", book.StartMoving)
    book:SetScript("OnDragStop", book.StopMovingOrSizing)
    book:Hide()
    tinsert(UISpecialFrames, "WoWpoCeskuLore")

    book.title = fontString(book, 22, GOLD[1], GOLD[2], GOLD[3])
    book.title:SetPoint("TOPLEFT", 22, -18)
    book.tag = fontString(book, 13, 0.75, 0.72, 0.65)
    book.tag:SetPoint("TOPLEFT", book.title, "BOTTOMLEFT", 0, -6)
    book.tag:SetWidth(510)
    local line = book:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(0.75, 0.55, 0.25, 0.6)
    line:SetPoint("TOPLEFT", 20, -80)
    line:SetPoint("TOPRIGHT", -20, -80)
    line:SetHeight(1)
    local close = CreateFrame("Button", nil, book, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 2, 2)

    book.sf = CreateFrame("ScrollFrame", nil, book, "UIPanelScrollFrameTemplate")
    book.sf:SetPoint("TOPLEFT", 22, -92)
    book.sf:SetPoint("BOTTOMRIGHT", -40, 50)
    book.content = CreateFrame("Frame", nil, book.sf)
    book.content:SetSize(490, 10)
    book.sf:SetScrollChild(book.content)
    book.heads, book.paras = {}, {}

    local hint = fontString(book, 11, 0.6, 0.6, 0.6)
    hint:SetPoint("BOTTOMRIGHT", -22, 19)
    hint:SetJustifyH("RIGHT")
    hint:SetText("Příběh oblasti, kde právě jsi – WoWpoČesku")
end

-- kniha ukazuje vždy jen oblast, kde hráč právě je
function WoWpoCesku_ShowLore()
    local key = resolve(currentZone())
    if not key then
        if book then book:Hide() end
        say("pro tuhle oblast zatim pribeh nemam (" .. tostring(currentZone()) .. ").")
        return
    end
    if not book then createBook() end
    book:Show()
    book:Raise()
    fillBook(key)
end

-------------------------------------------------------------------------------
-- Úvodní titulky při vstupu do oblasti
-------------------------------------------------------------------------------
local toast
local lastShown = {}

local function createToast()
    toast = CreateFrame("Button", nil, UIParent)
    toast:SetSize(620, 90)
    toast:SetPoint("TOP", 0, -150)
    toast:SetFrameStrata("HIGH")
    toast.title = fontString(toast, 26, GOLD[1], GOLD[2], GOLD[3], "OUTLINE")
    toast.title:SetPoint("TOP", 0, 0)
    toast.title:SetJustifyH("CENTER")
    toast.tag = fontString(toast, 14, 0.95, 0.92, 0.85, "OUTLINE")
    toast.tag:SetPoint("TOP", toast.title, "BOTTOM", 0, -6)
    toast.tag:SetWidth(600)
    toast.tag:SetJustifyH("CENTER")
    toast.hint = fontString(toast, 11, 0.75, 0.75, 0.75, "OUTLINE")
    toast.hint:SetPoint("TOP", toast.tag, "BOTTOM", 0, -6)
    toast.hint:SetJustifyH("CENTER")
    toast.hint:SetText("Klikni pro celý příběh oblasti  (/czq lore)")
    toast:SetAlpha(0)
    toast:Hide()
    local anim = toast:CreateAnimationGroup()
    local fadeIn = anim:CreateAnimation("Alpha")
    fadeIn:SetFromAlpha(0) fadeIn:SetToAlpha(1) fadeIn:SetDuration(0.8) fadeIn:SetOrder(1)
    local hold = anim:CreateAnimation("Alpha")
    hold:SetFromAlpha(1) hold:SetToAlpha(1) hold:SetDuration(7) hold:SetOrder(2)
    local fadeOut = anim:CreateAnimation("Alpha")
    fadeOut:SetFromAlpha(1) fadeOut:SetToAlpha(0) fadeOut:SetDuration(1.5) fadeOut:SetOrder(3)
    anim:SetScript("OnPlay", function() toast:Show(); toast:SetAlpha(1) end)
    anim:SetScript("OnFinished", function() toast:Hide() end)
    toast.anim = anim
    toast:SetScript("OnClick", function(self)
        self.anim:Stop()
        self:Hide()
        WoWpoCesku_ShowLore()
    end)
end

local function onZone()
    local name = currentZone()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.z = WoWpoCeskuSeen.z or {}
    if name and name ~= "?" and not WoWpoCeskuSeen.z[name] then WoWpoCeskuSeen.z[name] = time() end
    -- otevřená kniha se přepne na novou oblast (nebo zavře, když pro ni příběh není)
    if book and book:IsShown() then WoWpoCesku_ShowLore() end
    if WoWpoCeskuSettings and WoWpoCeskuSettings.loreToast == false then return end
    if WoWpoCeskuSettings and WoWpoCeskuSettings.enabled == false then return end
    local key = resolve(name)
    if not key then return end
    -- stejnou oblast neukazovat znovu dřív než za 15 minut
    if lastShown[key] and GetTime() - lastShown[key] < 900 then return end
    lastShown[key] = GetTime()
    if not toast then createToast() end
    local L = WoWpoCesku_Lore[key]
    toast.key = key
    toast.title:SetText(L.title)
    toast.tag:SetText(L.tag)
    toast.anim:Stop()
    toast.anim:Play()
    -- kdo titulky nestihne, najde připomínku v chatu
    say("pribeh oblasti " .. key .. " - otevres ho Ctrl+klikem na ikonu u minimapy nebo /czq lore")
end

-- příkaz /czq lore …
function WoWpoCesku_LoreCommand(arg)
    arg = (arg or ""):lower()
    if arg == "vyp" or arg == "off" then
        WoWpoCeskuSettings.loreToast = false
        say("titulky pri vstupu do oblasti vypnuty (kniha porad funguje: /czq lore).")
    elseif arg == "zap" or arg == "on" then
        WoWpoCeskuSettings.loreToast = true
        say("titulky pri vstupu do oblasti zapnuty.")
    else
        WoWpoCesku_ShowLore()
    end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:SetScript("OnEvent", function() C_Timer.After(1.5, function() pcall(onZone) end) end)
