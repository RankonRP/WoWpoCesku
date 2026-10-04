-- WoWpoCesku: Kronika Azerothu – příběhy oblastí (lore)
--  * při vstupu do oblasti nahoře krátce název + úvodní věta (klik = kniha)
--  * kniha s celým příběhem v kapitolách – vždy jen pro oblast, kde hráč je
--  * /czq lore = kniha pro oblast, kde jsi; /czq lore vyp|zap = titulky při vstupu
--  * navštívené oblasti se ukládají (WoWpoCeskuSeen.z), ať je jasné, které příběhy psát dál
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local GOLD = { 1, 0.82, 0.35 }

local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end

-- název oblasti, kde hráč je (anglicky, jak ho dává hra)
-- v dungeonu: název instance (Deadmines, Ragefire Chasm…)
local function instanceName()
    if not (IsInInstance and IsInInstance()) then return nil end
    local name = GetInstanceInfo and GetInstanceInfo()
    if name and (WoWpoCesku_Lore[name] or WoWpoCesku_LoreAlias[name]) then return name end
end

local function currentZone()
    local inst = instanceName()
    if inst then return inst end
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


-- klíč kroniky pro oblast, kde hráč je (používá Kronika.lua pro deník objevů)
function WoWpoCesku_CurrentZoneKey()
    local z = currentZone()
    return resolve(z) or z
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

-- barvy kroniky: inkoust na pergamenu
local INK   = { 0.20, 0.13, 0.07 }
local RED   = { 0.50, 0.12, 0.05 }
local SEPIA = { 0.42, 0.30, 0.18 }
local PARCHMENT = "Interface\\AddOns\\WoWpoCesku\\Textures\\pergamen.tga"
local W = 520   -- šířka textu a ilustrace

-- ozdobný předěl: linka – kosočtverec – linka
local function ornament(parent, width)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(width, 12)
    local d = f:CreateTexture(nil, "ARTWORK")
    d:SetColorTexture(RED[1], RED[2], RED[3], 0.85)
    d:SetSize(7, 7)
    d:SetPoint("CENTER")
    d:SetRotation(math.rad(45))
    for _, side in ipairs({ -1, 1 }) do
        local l = f:CreateTexture(nil, "ARTWORK")
        l:SetColorTexture(SEPIA[1], SEPIA[2], SEPIA[3], 0.7)
        l:SetSize(width / 2 - 14, 1)
        l:SetPoint(side < 0 and "RIGHT" or "LEFT", d, "CENTER", side * 10, 0)
    end
    return f
end

-- ilustrace: mapa oblasti ze hry v sépiovém tónu (jako stará kreslená mapa)
local function drawIllustration(mapID)
    local ill = book.ill
    for _, t in ipairs(ill.tiles) do t:Hide() end
    local layers = mapID and C_Map.GetMapArtLayers and C_Map.GetMapArtLayers(mapID)
    local layer = layers and layers[1]
    local textures = layer and C_Map.GetMapArtLayerTextures and C_Map.GetMapArtLayerTextures(mapID, 1)
    if not layer or not textures or not layer.layerWidth or layer.layerWidth == 0 then
        ill:Hide()
        return false
    end
    ill:Show()
    local k = W / layer.layerWidth
    local H = layer.layerHeight * k
    -- výřez ze středu mapy
    local top = math.max(0, (H - ill:GetHeight()) / 2)
    local cols = math.ceil(layer.layerWidth / layer.tileWidth)
    for i, fileID in ipairs(textures) do
        local t = ill.tiles[i]
        if not t then
            t = ill.clip:CreateTexture(nil, "ARTWORK")
            ill.tiles[i] = t
        end
        local col, row = (i - 1) % cols, math.floor((i - 1) / cols)
        t:SetTexture(fileID)
        t:SetDesaturated(true)
        t:SetVertexColor(1, 0.86, 0.62)
        t:SetSize(layer.tileWidth * k, layer.tileHeight * k)
        t:ClearAllPoints()
        t:SetPoint("TOPLEFT", ill.clip, "TOPLEFT", col * layer.tileWidth * k, -row * layer.tileHeight * k + top)
        t:Show()
    end
    return true
end

-- záložky na pravém okraji knihy
local TABS = {
    { id = "letopis", label = "Letopis" },
    { id = "tajemstvi", label = "Tajemství" },
    { id = "denik", label = "Poutníkův deník" },
    { id = "bestiar", label = "Bestiář" },
}

-- vykreslí kapitoly jedné záložky do rolovací stránky
-- klikací řádek (třeba vzácný mob v Bestiáři)
local function rowButton(i)
    local b = book.rowBtns[i]
    if b then return b end
    b = CreateFrame("Button", nil, book.content)
    b.text = fontString(b, 13.5, INK[1], INK[2], INK[3])
    b.text:SetSpacing(2)
    -- zaškrtávátko v pevném sloupci vlevo (jako ve hře)
    b.box = b:CreateTexture(nil, "ARTWORK")
    b.box:SetSize(20, 20)
    b.box:SetPoint("TOPLEFT", 0, 0)
    b.box:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
    b.check = b:CreateTexture(nil, "OVERLAY")
    b.check:SetAllPoints(b.box)
    b.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
    local hl = b:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(RED[1], RED[2], RED[3], 0.12)
    b:SetScript("OnClick", function(self) if self.onClick then self.onClick() end end)
    b:SetScript("OnEnter", function(self)
        if not self.hint then return end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(self.hint, 1, 1, 1)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)
    book.rowBtns[i] = b
    return b
end

local function renderPage(chapters)
    local y, nRows = 0, 0
    for i, ch in ipairs(chapters) do
        local h, p, o = book.heads[i], book.paras[i], book.orns[i]
        if not h then
            h = fontString(book.content, 16, RED[1], RED[2], RED[3])
            h:SetJustifyH("CENTER")
            p = fontString(book.content, 13.5, INK[1], INK[2], INK[3])
            p:SetSpacing(4)
            o = ornament(book.content, 160)
            book.heads[i], book.paras[i], book.orns[i] = h, p, o
        end
        h:SetWidth(W - 20)
        p:SetWidth(W - 20)
        if i > 1 then
            o:ClearAllPoints()
            o:SetPoint("TOP", book.content, "TOPLEFT", (W - 20) / 2, -y)
            o:Show()
            y = y + 22
        else
            o:Hide()
        end
        h:ClearAllPoints()
        h:SetPoint("TOPLEFT", 0, -y)
        h:SetText(ch[1])
        h:Show()
        y = y + h:GetStringHeight() + 8
        p:ClearAllPoints()
        p:SetPoint("TOPLEFT", 0, -y)
        p:SetText(ch[2])
        p:Show()
        y = y + p:GetStringHeight() + 16
        for _, row in ipairs(ch.rows or {}) do
            nRows = nRows + 1
            local b = rowButton(nRows)
            local hasBox = row.mark ~= nil
            b.box:SetShown(hasBox)
            b.check:SetShown(row.mark == true)
            b.text:ClearAllPoints()
            b.text:SetPoint("TOPLEFT", hasBox and 24 or 4, -2)
            b.text:SetWidth(W - (hasBox and 50 or 30))
            b.text:SetText(row.text)
            b.onClick, b.hint = row.onClick, row.hint
            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", 0, -y)
            b:SetSize(W - 20, b.text:GetStringHeight() + 6)
            b:Show()
            y = y + b.text:GetStringHeight() + 7
        end
        if ch.rows and ch.after then
            nRows = nRows + 1
            local b = rowButton(nRows)
            b.box:Hide(); b.check:Hide()
            b.text:ClearAllPoints()
            b.text:SetPoint("TOPLEFT", 4, -2)
            b.text:SetWidth(W - 30)
            b.text:SetText(ch.after)
            b.onClick, b.hint = nil, nil
            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", 0, -(y + 8))
            b:SetSize(W - 20, b.text:GetStringHeight() + 6)
            b:Show()
            y = y + b.text:GetStringHeight() + 24
        end
    end
    for i = nRows + 1, #book.rowBtns do book.rowBtns[i]:Hide() end
    for i = #chapters + 1, #book.heads do
        book.heads[i]:Hide(); book.paras[i]:Hide(); book.orns[i]:Hide()
    end
    book.content:SetHeight(math.max(1, y))
    book.sf:SetVerticalScroll(0)
end

local function showTab(id)
    if not book.pages[id] then id = "letopis" end
    book.tab = id
    for _, t in ipairs(book.tabs) do
        local active = (t.id == id)
        t:SetShown(book.pages[t.id] ~= nil)
        t:SetWidth(active and 166 or 154)
        t.bg:SetVertexColor(active and 1 or 0.86, active and 1 or 0.80, active and 1 or 0.70)
        if active then t.text:SetTextColor(RED[1], RED[2], RED[3]) else t.text:SetTextColor(INK[1], INK[2], INK[3], 0.8) end
    end
    renderPage(book.pages[id])
end

local function fillBook(key, mapID)
    bookKey = key
    WoWpoCesku_BookMapID = mapID
    local L = WoWpoCesku_Lore[key]
    book.title:SetText(L.title)
    book.tag:SetText(L.tag)
    local hasArt = drawIllustration(mapID)
    book.sf:ClearAllPoints()
    book.sf:SetPoint("TOPLEFT", hasArt and book.ill or book.tag, "BOTTOMLEFT", 0, hasArt and -14 or -16)
    book.sf:SetPoint("BOTTOMRIGHT", -34, 46)

    -- Letopis: kapitoly příběhu + „Z knih a legend“
    local letopis = {}
    for _, ch in ipairs(L.ch) do letopis[#letopis + 1] = ch end
    local books = WoWpoCesku_LoreKnihy and WoWpoCesku_LoreKnihy[key]
    if books then letopis[#letopis + 1] = { "Z knih a legend (spoilery)", books } end
    local secrets = WoWpoCesku_LoreTajemstvi and WoWpoCesku_LoreTajemstvi[key]
    book.pages = {
        letopis = letopis,
        tajemstvi = secrets and { { "Tajemství a kam se podívat", secrets } } or nil,
        denik = WoWpoCesku_DenikPage and WoWpoCesku_DenikPage(key) or nil,
        bestiar = WoWpoCesku_BestiarPage and WoWpoCesku_BestiarPage(key) or nil,
    }
    showTab(book.tab or "letopis")
end

local function createTabs()
    book.tabs = {}
    -- záložky jsou v rámečku pod knihou (nižší úroveň), aby je deska knihy překryla
    book:SetFrameLevel(20)
    local holder = CreateFrame("Frame", nil, UIParent)
    holder:SetFrameStrata("DIALOG")
    holder:SetFrameLevel(5)
    holder:SetAllPoints(book)
    holder:Hide()
    book:HookScript("OnShow", function() holder:Show() end)
    book:HookScript("OnHide", function() holder:Hide() end)
    for i, def in ipairs(TABS) do
        local t = CreateFrame("Button", nil, holder, "BackdropTemplate")
        t.id = def.id
        t:SetSize(154, 36)
        t:SetPoint("TOPLEFT", book, "TOPRIGHT", -14, -70 - (i - 1) * 44)
        t:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 } })
        t:SetBackdropBorderColor(0.45, 0.30, 0.16, 1)
        t.bg = t:CreateTexture(nil, "BACKGROUND")
        t.bg:SetPoint("TOPLEFT", 3, -3)
        t.bg:SetPoint("BOTTOMRIGHT", -3, 3)
        t.bg:SetTexture(PARCHMENT)
        t.bg:SetTexCoord(0.3, 0.6, 0.3, 0.4)
        -- vínová stužka na konci záložky
        local ribbon = t:CreateTexture(nil, "ARTWORK")
        ribbon:SetColorTexture(RED[1], RED[2], RED[3], 0.85)
        ribbon:SetPoint("TOPRIGHT", -4, -4)
        ribbon:SetPoint("BOTTOMRIGHT", -4, 4)
        ribbon:SetWidth(4)
        t.text = fontString(t, 13, SEPIA[1], SEPIA[2], SEPIA[3])
        t.text:SetPoint("LEFT", 20, 0)
        t.text:SetWidth(124)
        t.text:SetWordWrap(false)
        t.text:SetText(def.label)
        t:SetScript("OnClick", function(self)
            PlaySound(SOUNDKIT and SOUNDKIT.IG_ABILITY_PAGE_TURN or 836)
            showTab(self.id)
        end)
        book.tabs[i] = t
    end
end

local function createBook()
    -- kožená vazba
    book = CreateFrame("Frame", "WoWpoCeskuLore", UIParent, "BackdropTemplate")
    book:SetSize(600, 700)
    book:SetPoint("CENTER")
    book:SetFrameStrata("DIALOG")
    book:SetToplevel(true)
    book:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 },
    })
    book:SetBackdropColor(0.23, 0.13, 0.07, 1)
    book:EnableMouse(true)
    book:SetMovable(true)
    book:SetClampedToScreen(true)
    book:RegisterForDrag("LeftButton")
    book:SetScript("OnDragStart", book.StartMoving)
    book:SetScript("OnDragStop", book.StopMovingOrSizing)
    book:Hide()
    tinsert(UISpecialFrames, "WoWpoCeskuLore")

    -- stránka z pergamenu
    local page = book:CreateTexture(nil, "BACKGROUND", nil, 1)
    page:SetPoint("TOPLEFT", 16, -16)
    page:SetPoint("BOTTOMRIGHT", -16, 16)
    page:SetColorTexture(0.91, 0.84, 0.66, 1)   -- kdyby textura chyběla (před restartem hry)
    local tex = book:CreateTexture(nil, "BACKGROUND", nil, 2)
    tex:SetAllPoints(page)
    tex:SetTexture(PARCHMENT)

    -- záhlaví: KRONIKA AZEROTHU
    local head = fontString(book, 12, RED[1], RED[2], RED[3])
    head:SetPoint("TOP", 0, -30)
    head:SetText("K R O N I K A   A Z E R O T H U")
    local o = ornament(book, 300)
    o:SetPoint("TOP", head, "BOTTOM", 0, -4)

    book.title = fontString(book, 28, INK[1], INK[2], INK[3])
    book.title:SetPoint("TOP", o, "BOTTOM", 0, -6)
    book.title:SetJustifyH("CENTER")
    book.tag = fontString(book, 13, SEPIA[1], SEPIA[2], SEPIA[3])
    book.tag:SetPoint("TOP", book.title, "BOTTOM", 0, -6)
    book.tag:SetWidth(W)
    book.tag:SetJustifyH("CENTER")

    -- ilustrace s rámečkem
    local ill = CreateFrame("Frame", nil, book, "BackdropTemplate")
    ill:SetSize(W, 160)
    ill:SetPoint("TOP", book.tag, "BOTTOM", 0, -12)
    ill:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
    ill:SetBackdropBorderColor(SEPIA[1], SEPIA[2], SEPIA[3], 0.9)
    ill.clip = CreateFrame("Frame", nil, ill)
    ill.clip:SetPoint("TOPLEFT", 3, -3)
    ill.clip:SetPoint("BOTTOMRIGHT", -3, 3)
    ill.clip:SetClipsChildren(true)
    ill.tiles = {}
    book.ill = ill

    createTabs()

    local close = CreateFrame("Button", nil, book, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -8, -8)

    book.sf = CreateFrame("ScrollFrame", nil, book, "UIPanelScrollFrameTemplate")
    book.content = CreateFrame("Frame", nil, book.sf)
    book.content:SetSize(W - 20, 10)
    book.sf:SetScrollChild(book.content)
    book.heads, book.paras, book.orns, book.rowBtns = {}, {}, {}, {}

    local foot = ornament(book, 120)
    foot:SetPoint("BOTTOM", 0, 30)
    local hint = fontString(book, 10, SEPIA[1], SEPIA[2], SEPIA[3])
    hint:SetPoint("TOP", foot, "BOTTOM", 0, -2)
    hint:SetWidth(W)
    hint:SetJustifyH("CENTER")
    hint:SetText("sepsáno pro WoWpoČesku podle klasického WoW a Warcraft Wiki – ve WoW Forever se může něco lišit")
end

-- kniha ukazuje vždy jen oblast, kde hráč právě je
local function currentKeyAndMap()
    local inst = instanceName()
    if inst then
        return resolve(inst), C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
    end
    local id = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
    for _ = 1, 5 do
        local info = id and C_Map.GetMapInfo(id)
        if not info then break end
        local key = resolve(info.name)
        if key then return key, id end
        id = info.parentMapID
    end
    return resolve(currentZone()), nil
end

function WoWpoCesku_ShowLore()
    local key, mapID = currentKeyAndMap()
    if not key then
        if book then book:Hide() end
        say("pro tuhle oblast zatim pribeh nemam (" .. tostring(currentZone()) .. ").")
        return
    end
    if not book then createBook() end
    book:Show()
    book:Raise()
    fillBook(key, mapID)
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
    toast.hint:SetText("Klikni a otevře se Kronika Azerothu  (/czq lore)")
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
    say("pribeh oblasti " .. key .. " je v Kronice Azerothu - otevres ji klikem na ikonu u minimapy nebo /czq lore")
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
