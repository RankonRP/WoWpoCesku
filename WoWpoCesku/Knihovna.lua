-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-------------------------------------------------------------------------------
-- Knihovna kronikáře: každá kniha, dopis nebo svitek, který hráč ve hře otevře, se uloží (název, oblast, datum, text
-- stránek). Překlad se bere z databáze rozhovorů při zobrazení, takže zlepšený překlad se projeví i u starších záznamů.
-- Uloženo v WoWpoCeskuSeen.library (společné pro celý účet), okno ve stylu Cechovní kroniky.
-------------------------------------------------------------------------------
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local CINZEL = "Interface\\AddOns\\WoWpoCesku\\Fonts\\Cinzel.ttf"
local INK, RED, SEPIA = { 0.20, 0.13, 0.07 }, { 0.50, 0.12, 0.05 }, { 0.32, 0.22, 0.12 }
local WHITE = "Interface\\Buttons\\WHITE8x8"
local WIN_W, WIN_H = 920, 640
local BOX = { bgFile = WHITE, edgeFile = WHITE, edgeSize = 1 }

local win
local state = { key = nil, page = 1, mode = "cs", filter = "" }
local lastKey, lastTitle

local function lib()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.library = WoWpoCeskuSeen.library or {}
    return WoWpoCeskuSeen.library
end

local function hash(s)
    local h = 5381
    for i = 1, math.min(#s, 400) do h = (h * 33 + s:byte(i)) % 4294967296 end
    return tostring(math.floor(h))
end

local refresh

-- volá se při otevření textu předmětu (WoWpoCesku.lua); page = číslo stránky, text = text stránky (se zástupnými značkami)
function WoWpoCesku_LibraryAdd(title, page, text)
    if type(title) ~= "string" or title == "" or type(text) ~= "string" or text == "" then return end
    local L = lib()
    page = tonumber(page) or 1
    local key
    if page > 1 and lastKey and lastTitle == title and L[lastKey] then
        key = lastKey
    else
        key = title .. "#" .. hash(text)
        if not L[key] then
            local zone = (GetRealZoneText and GetRealZoneText()) or (GetZoneText and GetZoneText()) or ""
            local sub = GetSubZoneText and GetSubZoneText() or ""
            L[key] = { title = title, t = time(), zone = zone, sub = sub, who = UnitName("player") or "", pages = {} }
        end
        lastKey, lastTitle = key, title
    end
    L[key].pages[page] = text
    if win and win:IsShown() and refresh then refresh() end
end

local function sortedList()
    local out, f = {}, (state.filter or ""):lower()
    for key, e in pairs(lib()) do
        if f == "" or (e.title or ""):lower():find(f, 1, true) or (e.zone or ""):lower():find(f, 1, true) then
            out[#out + 1] = { key, e }
        end
    end
    table.sort(out, function(a, b)
        if (a[2].t or 0) ~= (b[2].t or 0) then return (a[2].t or 0) > (b[2].t or 0) end
        return a[1] < b[1]
    end)
    return out
end

local function countAll()
    local n = 0
    for _ in pairs(lib()) do n = n + 1 end
    return n
end

local function fs(parent, size, r, g, b, font)
    local t = parent:CreateFontString(nil, "OVERLAY")
    t:SetFont(font or FONT, size, "")
    t:SetTextColor(r or INK[1], g or INK[2], b or INK[3])
    t:SetJustifyH("LEFT")
    return t
end

local function pageText(e, page)
    local raw = e.pages and e.pages[page]
    if not raw then return "" end
    if state.mode == "cs" then
        local cs = WoWpoCesku_GossipLookup and WoWpoCesku_GossipLookup(raw)
        if cs and cs ~= "" then return WoWpoCesku_FromToken(cs) end
        return "Překlad této stránky zatím nemám. Až ho Pomocník přeloží a data se načtou, objeví se tady. Zatím je k dispozici originál (tlačítko Originál).\n\n" ..
            WoWpoCesku_FromToken(raw)
    end
    return WoWpoCesku_FromToken(raw)
end

local rows = {}
local function rowFor(i)
    local b = rows[i]
    if b then return b end
    b = CreateFrame("Button", nil, win.listC, "BackdropTemplate")
    b:SetHeight(46)
    b:SetBackdrop(BOX)
    b.title = fs(b, 13)
    b.title:SetPoint("TOPLEFT", 10, -7)
    b.title:SetWordWrap(false)
    b.sub = fs(b, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    b.sub:SetPoint("TOPLEFT", b.title, "BOTTOMLEFT", 0, -3)
    b.sub:SetWordWrap(false)
    b.hl = b:CreateTexture(nil, "HIGHLIGHT")
    b.hl:SetAllPoints()
    b.hl:SetColorTexture(1, 0.92, 0.7, 0.14)
    rows[i] = b
    return b
end

refresh = function()
    if not win then return end
    local list = sortedList()
    win.count:SetText(("Přečteno: %d"):format(countAll()))
    -- seznam vlevo
    local w = win.listC:GetWidth()
    for i, it in ipairs(list) do
        local b = rowFor(i)
        local e = it[2]
        b:ClearAllPoints()
        b:SetPoint("TOPLEFT", 0, -(i - 1) * 52)
        b:SetWidth(w)
        b.title:SetWidth(w - 20)
        b.sub:SetWidth(w - 20)
        b.title:SetText(e.title or "?")
        local where = (e.sub and e.sub ~= "") and (e.zone .. ", " .. e.sub) or (e.zone or "")
        b.sub:SetText(("%s  ·  %s"):format(date("%d.%m.%Y", e.t or 0), where))
        local on = (it[1] == state.key)
        b:SetBackdropColor(0.40, 0.26, 0.12, on and 0.34 or 0.12)
        b:SetBackdropBorderColor(on and 0.62 or 0.42, on and 0.20 or 0.27, on and 0.10 or 0.13, on and 1 or 0.6)
        b:SetScript("OnClick", function() state.key = it[1]; state.page = 1; refresh() end)
        b:Show()
    end
    for i = #list + 1, #rows do rows[i]:Hide() end
    win.listC:SetHeight(math.max(10, #list * 52))
    win.empty:SetShown(#list == 0)
    win.empty:SetText(countAll() == 0 and "Zatím jsi nic nepřečetl.\nKaždá kniha, dopis nebo svitek, který ve hře otevřeš,\nse sem sama uloží." or "Nic takového nenalezeno.")
    -- čtečka vpravo
    local e = state.key and lib()[state.key]
    if not e and #list > 0 and state.key == nil then state.key = list[1][1]; e = lib()[state.key] end
    win.reader:SetShown(e ~= nil)
    if e then
        local pages = 0
        for p in pairs(e.pages or {}) do if p > pages then pages = p end end
        if state.page > pages then state.page = math.max(1, pages) end
        win.rTitle:SetText(e.title or "?")
        local where = (e.sub and e.sub ~= "") and (e.zone .. ", " .. e.sub) or (e.zone or "")
        win.rMeta:SetText(("Přečetl %s  ·  %s  ·  %s"):format(e.who or "?", date("%d.%m.%Y", e.t or 0), where))
        win.pageText:SetText(("Strana %d z %d"):format(state.page, math.max(pages, 1)))
        win.prev:SetShown(pages > 1); win.next:SetShown(pages > 1); win.pageText:SetShown(pages > 1)
        win.btnCs:setActive(state.mode == "cs")
        win.btnEn:setActive(state.mode == "en")
        win.rText:SetText(pageText(e, state.page))
        win.textC:SetHeight(math.max(10, win.rText:GetStringHeight() + 24))
        win.textSf:SetVerticalScroll(0)
    end
end

local function build()
    win = CreateFrame("Frame", "WoWpoCeskuKnihovna", UIParent, "BackdropTemplate")
    win:SetSize(WIN_W, WIN_H)
    win:SetPoint("CENTER")
    win:SetFrameStrata("DIALOG")
    win:SetToplevel(true)
    WoWpoCesku_CechStyle(win, WIN_W, WIN_H)
    win:EnableMouse(true)
    win:SetMovable(true)
    win:SetClampedToScreen(true)
    win:RegisterForDrag("LeftButton")
    win:SetScript("OnDragStart", win.StartMoving)
    win:SetScript("OnDragStop", win.StopMovingOrSizing)
    win:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "WoWpoCeskuKnihovna") end

    -- stuha s nadpisem
    local rf = CreateFrame("Frame", nil, win)
    rf:SetAllPoints()
    rf:SetFrameLevel(win:GetFrameLevel() + 35)
    local rib = rf:CreateTexture(nil, "ARTWORK")
    local fbTex, fbV, fbRatio
    if WoWpoCesku_FactionBanner then fbTex, fbV, fbRatio = WoWpoCesku_FactionBanner() end
    if fbTex then
        rib:SetTexture(fbTex)
        rib:SetSize(480, 480 * fbRatio)
        rib:SetTexCoord(0, 1, 0, fbV)
        rib:SetPoint("TOP", win, "TOP", 0, -12)
    else
        rib:SetTexture("Interface\\AddOns\\WoWpoCesku\\Textures\\cech-plaketa.tga")
        rib:SetSize(460, 460 * 180 / 1024)
        rib:SetTexCoord(0, 1, 0, 180 / 256)
        rib:SetPoint("TOP", win, "TOP", 0, -14)
    end
    local head = rf:CreateFontString(nil, "OVERLAY")
    head:SetFont("Fonts\\MORPHEUS.ttf", 24, "OUTLINE")
    head:SetTextColor(1, 0.95, 0.78)
    head:SetPoint("CENTER", rib, "CENTER", 0, 0)
    head:SetText("Knihovna")
    WoWpoCesku_CechCrests(win)

    -- hledání a počet
    local search = CreateFrame("EditBox", nil, win, "InputBoxTemplate")
    search:SetSize(300, 24)
    search:SetPoint("TOPLEFT", 78, -150)
    search:SetAutoFocus(false)
    search:SetFont(FONT, 12, "")
    search:SetScript("OnTextChanged", function(self) state.filter = self:GetText() or ""; if refresh then refresh() end end)
    search:SetScript("OnEscapePressed", search.ClearFocus)
    local hint = fs(win, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    hint:SetPoint("LEFT", search, "RIGHT", 10, 0)
    hint:SetText("hledej podle názvu nebo oblasti")
    win.count = fs(win, 12, RED[1], RED[2], RED[3])
    win.count:SetPoint("TOPRIGHT", -70, -153)
    win.count:SetJustifyH("RIGHT")

    -- seznam knih
    local boxL = CreateFrame("Frame", nil, win, "BackdropTemplate")
    boxL:SetBackdrop(BOX)
    boxL:SetBackdropColor(0.40, 0.26, 0.14, 0.10)
    boxL:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.9)
    boxL:SetPoint("TOPLEFT", 62, -184)
    boxL:SetSize(306, 394)
    local sf = CreateFrame("ScrollFrame", nil, win, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 70, -192)
    sf:SetSize(268, 378)
    win.listC = CreateFrame("Frame", nil, sf)
    win.listC:SetSize(262, 10)
    sf:SetScrollChild(win.listC)
    win.empty = fs(win, 13, SEPIA[1], SEPIA[2], SEPIA[3])
    win.empty:SetPoint("TOP", boxL, "TOP", 0, -120)
    win.empty:SetWidth(270)
    win.empty:SetJustifyH("CENTER")

    -- čtečka
    local boxR = CreateFrame("Frame", nil, win, "BackdropTemplate")
    boxR:SetBackdrop(BOX)
    boxR:SetBackdropColor(0.40, 0.26, 0.14, 0.10)
    boxR:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.9)
    boxR:SetPoint("TOPLEFT", 380, -184)
    boxR:SetSize(478, 394)
    local rd = CreateFrame("Frame", nil, win)
    rd:SetAllPoints()
    win.reader = rd
    win.rTitle = fs(rd, 17, RED[1], RED[2], RED[3], CINZEL)
    win.rTitle:SetPoint("TOPLEFT", 396, -196)
    win.rTitle:SetWidth(446)
    win.rTitle:SetWordWrap(false)
    win.rMeta = fs(rd, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    win.rMeta:SetPoint("TOPLEFT", win.rTitle, "BOTTOMLEFT", 0, -4)
    win.rMeta:SetWidth(446)
    win.rMeta:SetWordWrap(false)

    win.btnCs = WoWpoCesku_CechButton(rd, "Překlad", 110, 34)
    win.btnCs:SetPoint("TOPLEFT", 394, -246)
    win.btnCs:SetScript("OnClick", function() state.mode = "cs"; refresh() end)
    win.btnEn = WoWpoCesku_CechButton(rd, "Originál", 110, 34)
    win.btnEn:SetPoint("LEFT", win.btnCs, "RIGHT", 6, 0)
    win.btnEn:SetScript("OnClick", function() state.mode = "en"; refresh() end)

    win.next = WoWpoCesku_CechButton(rd, ">", 44, 34)
    win.next:SetPoint("TOPRIGHT", -78, -246)
    win.next:SetScript("OnClick", function() state.page = state.page + 1; refresh() end)
    win.prev = WoWpoCesku_CechButton(rd, "<", 44, 34)
    win.prev:SetPoint("RIGHT", win.next, "LEFT", -94, 0)
    win.prev:SetScript("OnClick", function() state.page = math.max(1, state.page - 1); refresh() end)
    win.pageText = fs(rd, 12, SEPIA[1], SEPIA[2], SEPIA[3])
    win.pageText:SetPoint("LEFT", win.prev, "RIGHT", 4, 0)
    win.pageText:SetWidth(86)
    win.pageText:SetJustifyH("CENTER")

    win.textSf = CreateFrame("ScrollFrame", nil, rd, "UIPanelScrollFrameTemplate")
    win.textSf:SetPoint("TOPLEFT", 394, -290)
    win.textSf:SetSize(432, 280)
    win.textC = CreateFrame("Frame", nil, win.textSf)
    win.textC:SetSize(426, 10)
    win.textSf:SetScrollChild(win.textC)
    win.rText = fs(win.textC, 14)
    win.rText:SetPoint("TOPLEFT", 4, -4)
    win.rText:SetWidth(414)
    win.rText:SetSpacing(3)
    win.rText:SetJustifyV("TOP")
end

function WoWpoCesku_Library(arg)
    if not win then build() end
    if win:IsShown() and arg ~= "otevrit" then win:Hide() return end
    win:Show()
    win:Raise()
    refresh()
end
