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
-- rám okna: šablona ze hry (zkouška /czq ramy, č. 6); nil = vlastní rám jako v Kronice (s prapory a znaky)
local GAME_FRAME = nil
local DY = GAME_FRAME and 55 or 0   -- o kolik je okno nižší než u vlastního rámu (menší horní část)
local BOX = { bgFile = WHITE, edgeFile = WHITE, edgeSize = 1 }

local win
local state = { key = nil, page = 1, mode = "cs", filter = "" }
local lastKey, lastTitle

-- Do knihovny patří jen knihy: popisky exponátů, desky a krátké nápisy (např. vejce v Explorers' Hall) se neukládají.
local MIN_BOOK_CHARS = 400
local NOT_BOOK_MATERIAL = { Stone = true, Marble = true, Bronze = true, Silver = true, Metal = true }

local function totalChars(e)
    local n = 0
    for _, p in pairs(e.pages or {}) do n = n + #p end
    return n
end

local pruned
local function lib()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.library = WoWpoCeskuSeen.library or {}
    if not pruned then
        pruned = true
        -- úklid starších záznamů, které nejsou knihy (jedna krátká stránka)
        for k, e in pairs(WoWpoCeskuSeen.library) do
            local count = 0
            for _ in pairs(e.pages or {}) do count = count + 1 end
            if count <= 1 and totalChars(e) < MIN_BOOK_CHARS then WoWpoCeskuSeen.library[k] = nil end
        end
    end
    return WoWpoCeskuSeen.library
end

local function hash(s)
    local h = 5381
    for i = 1, math.min(#s, 400) do h = (h * 33 + s:byte(i)) % 4294967296 end
    return tostring(math.floor(h))
end

local refresh

-- tlačítka ze hry (červená šablona UIPanelButtonTemplate, jako „Enter World“); v případě potřeby se vrátí k našim
local USE_GAME_BUTTONS = true
local function makeButton(parent, text, w, h)
    if USE_GAME_BUTTONS then
        local ok, b = pcall(CreateFrame, "Button", nil, parent, "UIPanelButtonTemplate")
        if ok and b then
            b:SetSize(w, h)
            b:SetText(text)
            local label = b:GetFontString()
            if label then label:SetFont(CINZEL, 14, ""); label:SetShadowColor(0, 0, 0, 0.9); label:SetShadowOffset(1, -1) end   -- písmo s diakritikou (jako ostatní tlačítka Kroniky)
            b.label = label
            if label then   -- text přesně doprostřed tlačítka (vodorovně i svisle)
                label:ClearAllPoints()
                label:SetPoint("CENTER", b, "CENTER", 0, -1)
                label:SetWidth(w - 10)
                label:SetJustifyH("CENTER")
                label:SetJustifyV("MIDDLE")
            end
            -- „aktivní" volba (Překlad / Originál) = zvýrazněné tlačítko
            function b:setActive(on)
                if on then self:LockHighlight() else self:UnlockHighlight() end
            end
            return b
        end
    end
    return WoWpoCesku_CechButton(parent, text, w, h)
end
WoWpoCesku_GameButton = makeButton   -- sdílené s Dungeon Kronikou

-- volá se při otevření textu předmětu (WoWpoCesku.lua); page = číslo stránky, text = text stránky (se zástupnými značkami)
function WoWpoCesku_LibraryAdd(title, page, text, material, hasNext)
    if type(title) ~= "string" or title == "" or type(text) ~= "string" or text == "" then return end
    if material and NOT_BOOK_MATERIAL[material] then return end
    local L = lib()
    page = tonumber(page) or 1
    -- jedna krátká stránka bez pokračování není kniha, ale popisek nebo nápis
    if page == 1 and not hasNext and #text < MIN_BOOK_CHARS then return end
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
    if WoWpoCesku_CheckSeals then WoWpoCesku_CheckSeals() end  -- pečeť za počet přečtených knih
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
WoWpoCesku_LibraryCount = countAll

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

-- „Nelíbí se mi“: označení překladu stránky pro Clauda (WoWpoCeskuSeen.flag, uloží se po /reload; viz tools/claude-preklad.js)
local FLAG_MAX = 200
local function flagTable()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    WoWpoCeskuSeen.flag = WoWpoCeskuSeen.flag or {}
    return WoWpoCeskuSeen.flag
end
local function flagKeyFor(e, page)
    local raw = e and e.pages and e.pages[page]
    if not raw then return nil end
    return "g:" .. ((raw:gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")))
end
local function refreshFlag()
    local e = state.key and lib()[state.key]
    local k = flagKeyFor(e, state.page)
    if not win.flagBtn then return end
    -- tlačítko je jen pro správce překladů (zapíná se příkazem /czq oznacovat); ostatním hráčům se nezobrazuje
    local on = WoWpoCeskuSettings and WoWpoCeskuSettings.flagButton
    win.flagBtn:SetShown(on and k ~= nil or false)
    if not k then return end
    win.flagBtn:SetText(flagTable()[k] and "|cff55dd55Označeno|r – zrušit" or "Nelíbí se mi")
end

local rows = {}
-- položka seznamu: pergamenový štítek s jemným hnědým lemem; vybraná má červený proužek jako záložka v knize
local function rowFor(i)
    local b = rows[i]
    if b then return b end
    b = CreateFrame("Button", nil, win.listC, "BackdropTemplate")
    b:SetHeight(44)
    b:SetBackdrop({ bgFile = WHITE, edgeFile = WHITE, edgeSize = 1, insets = { left = 1, right = 1, top = 1, bottom = 1 } })
    b.mark = b:CreateTexture(nil, "ARTWORK")
    b.mark:SetColorTexture(0.62, 0.14, 0.08, 1)
    b.mark:SetPoint("TOPLEFT", 1, -1)
    b.mark:SetPoint("BOTTOMLEFT", 1, 1)
    b.mark:SetWidth(5)
    b.title = fs(b, 13, INK[1], INK[2], INK[3], CINZEL)
    b.title:SetPoint("TOPLEFT", 16, -7)
    b.title:SetWordWrap(false)
    b.sub = fs(b, 10.5, SEPIA[1], SEPIA[2], SEPIA[3])
    b.sub:SetPoint("TOPLEFT", b.title, "BOTTOMLEFT", 0, -3)
    b.sub:SetWordWrap(false)
    b.hl = b:CreateTexture(nil, "HIGHLIGHT")
    b.hl:SetAllPoints()
    b.hl:SetColorTexture(1, 0.92, 0.7, 0.18)
    function b:setActive(on)
        if on then
            self:SetBackdropColor(0.62, 0.30, 0.14, 0.26)
            self:SetBackdropBorderColor(0.58, 0.20, 0.10, 1)
            self.title:SetTextColor(RED[1], RED[2], RED[3])
        else
            self:SetBackdropColor(0.40, 0.26, 0.12, 0.13)
            self:SetBackdropBorderColor(0.46, 0.31, 0.15, 0.6)
            self.title:SetTextColor(INK[1], INK[2], INK[3])
        end
        self.mark:SetShown(on)
    end
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
        b:SetPoint("TOPLEFT", 0, -(i - 1) * 48)
        b:SetWidth(w)
        b.title:SetWidth(w - 26)
        b.sub:SetWidth(w - 26)
        b.title:SetText(e.title or "?")
        local where = (e.sub and e.sub ~= "") and (e.zone .. ", " .. e.sub) or (e.zone or "")
        b.sub:SetText(("%s  ·  %s"):format(date("%d.%m.%Y", e.t or 0), where))
        local on = (it[1] == state.key)
        if b.setActive then b:setActive(on) end
        b:SetScript("OnClick", function() state.key = it[1]; state.page = 1; refresh() end)
        b:Show()
    end
    for i = #list + 1, #rows do rows[i]:Hide() end
    win.listC:SetHeight(math.max(10, #list * 48))
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
        refreshFlag()
    end
end

-- Okno jako otevřená kniha (obrázek knihovna-kniha.tga, 1024×512 roztažené na BW×BH): vlevo seznam knih, vpravo čtečka
local BOOK_TEX = "Interface\\AddOns\\WoWpoCesku\\Textures\\knihovna-kniha.tga"
local BW, BH = 860, 572
local PL_X, PL_W = 44, 380     -- levá strana
local PR_X, PR_W = 439, 382    -- pravá strana
local P_Y, P_H = 23, 518

-- tlačítka na stránkách: červená herní šablona (makeButton), aktivní je zvýrazněná
local function bookButton(parent, text, w, h)
    return makeButton(parent, text, w, h)
end

local function build()
    win = CreateFrame("Frame", "WoWpoCeskuKnihovna", UIParent)
    win:SetSize(BW, BH)
    win:SetPoint("CENTER")
    win:SetFrameStrata("DIALOG")
    win:SetToplevel(true)
    win:EnableMouse(true)
    win:SetMovable(true)
    win:SetClampedToScreen(true)
    win:RegisterForDrag("LeftButton")
    win:SetScript("OnDragStart", win.StartMoving)
    win:SetScript("OnDragStop", win.StopMovingOrSizing)
    win:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "WoWpoCeskuKnihovna") end

    local bg = win:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture(BOOK_TEX)

    local close = CreateFrame("Button", nil, win, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -22, -2)
    close:SetFrameLevel(win:GetFrameLevel() + 20)
    win.closeBtn = close

    -- levá strana: nadpis, počet, hledání
    local head = win:CreateFontString(nil, "OVERLAY")
    head:SetFont("Interface\\AddOns\\WoWpoCesku\\Fonts\\CinzelDecorative.ttf", 30, "")
    head:SetTextColor(RED[1], RED[2], RED[3])
    head:SetPoint("TOP", win, "TOPLEFT", PL_X + PL_W / 2, -(P_Y + 18))
    head:SetText("Knihovna")
    win.count = fs(win, 12, RED[1], RED[2], RED[3])
    win.count:SetPoint("TOP", win, "TOPLEFT", PL_X + PL_W / 2, -(P_Y + 56))
    win.count:SetJustifyH("CENTER")

    local search = CreateFrame("EditBox", nil, win, "InputBoxTemplate")
    search:SetSize(PL_W - 48, 24)
    search:SetPoint("TOPLEFT", PL_X + 24, -(P_Y + 78))
    search:SetAutoFocus(false)
    search:SetFont(FONT, 12, "")
    local hint = fs(search, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    hint:SetPoint("LEFT", 4, 0)
    hint:SetText("hledej podle názvu nebo oblasti")
    search:SetScript("OnTextChanged", function(self)
        state.filter = self:GetText() or ""
        hint:SetShown(state.filter == "")
        if refresh then refresh() end
    end)
    search:SetScript("OnEscapePressed", search.ClearFocus)

    -- seznam knih
    local sf = CreateFrame("ScrollFrame", nil, win, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", PL_X + 20, -(P_Y + 108))
    sf:SetSize(PL_W - 62, P_H - 108 - 34)
    win.listC = CreateFrame("Frame", nil, sf)
    win.listC:SetSize(PL_W - 68, 10)
    sf:SetScrollChild(win.listC)
    win.empty = fs(win, 13, SEPIA[1], SEPIA[2], SEPIA[3])
    win.empty:SetPoint("TOP", win, "TOPLEFT", PL_X + PL_W / 2, -(P_Y + 170))
    win.empty:SetWidth(PL_W - 62)
    win.empty:SetJustifyH("CENTER")

    -- pravá strana: čtečka
    local rd = CreateFrame("Frame", nil, win)
    rd:SetAllPoints()
    win.reader = rd
    win.rTitle = fs(rd, 18, RED[1], RED[2], RED[3], CINZEL)
    win.rTitle:SetPoint("TOPLEFT", PR_X + 22, -(P_Y + 20))
    win.rTitle:SetWidth(PR_W - 48)
    win.rTitle:SetWordWrap(false)
    win.rMeta = fs(rd, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    win.rMeta:SetPoint("TOPLEFT", win.rTitle, "BOTTOMLEFT", 0, -4)
    win.rMeta:SetWidth(PR_W - 48)
    win.rMeta:SetWordWrap(false)

    win.btnCs = bookButton(rd, "Překlad", 104, 30)
    win.btnCs:SetPoint("TOPLEFT", PR_X + 20, -(P_Y + 66))
    win.btnCs:SetScript("OnClick", function() state.mode = "cs"; refresh() end)
    win.btnEn = bookButton(rd, "Originál", 104, 30)
    win.btnEn:SetPoint("LEFT", win.btnCs, "RIGHT", 6, 0)
    win.btnEn:SetScript("OnClick", function() state.mode = "en"; refresh() end)

    -- listování stránek dole uprostřed pravé strany
    win.pageText = fs(rd, 12, SEPIA[1], SEPIA[2], SEPIA[3])
    win.pageText:SetPoint("BOTTOM", win, "BOTTOMLEFT", PR_X + 272, BH - (P_Y + P_H) + 12)
    win.pageText:SetWidth(90)
    win.pageText:SetJustifyH("CENTER")
    win.prev = bookButton(rd, "<", 40, 28)
    win.prev:SetPoint("RIGHT", win.pageText, "LEFT", -6, 0)
    win.prev:SetScript("OnClick", function() state.page = math.max(1, state.page - 1); refresh() end)
    win.next = bookButton(rd, ">", 40, 28)
    win.next:SetPoint("LEFT", win.pageText, "RIGHT", 6, 0)
    win.next:SetScript("OnClick", function() state.page = state.page + 1; refresh() end)

    win.flagBtn = makeButton(rd, "Nelíbí se mi", 142, 28)
    win.flagBtn:SetPoint("BOTTOMLEFT", win, "BOTTOMLEFT", PR_X + 20, BH - (P_Y + P_H) - 0)
    win.flagBtn:SetScript("OnClick", function()
        local e = state.key and lib()[state.key]
        local k = flagKeyFor(e, state.page)
        if not k then return end
        local flags = flagTable()
        if flags[k] then
            flags[k] = nil
            print("|cffffd100WoWpoCesku:|r oznaceni zruseno")
        else
            local n = 0
            for _ in pairs(flags) do n = n + 1 end
            if n >= FLAG_MAX then print("|cffffd100WoWpoCesku:|r uz je oznaceno " .. FLAG_MAX .. " textu - nejdriv je nech prelozit") return end
            flags[k] = { t = time(), part = "", title = (e.title or ""):sub(1, 80) }
            print("|cffffd100WoWpoCesku:|r oznaceno pro Clauda (" .. (n + 1) .. "). Po /reload mu rekni, ze ma prelozit oznacene.")
        end
        refreshFlag()
    end)
    win.flagBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:AddLine("Poslat Claudovi")
        GameTooltip:AddLine("Označí překlad této stránky jako špatný.", 1, 1, 1)
        GameTooltip:AddLine("Claude ho přeloží ručně (po /reload se označení uloží).", 1, 1, 1)
        GameTooltip:Show()
    end)
    win.flagBtn:SetScript("OnLeave", GameTooltip_Hide)

    win.textSf = CreateFrame("ScrollFrame", nil, rd, "UIPanelScrollFrameTemplate")
    win.textSf:SetPoint("TOPLEFT", PR_X + 20, -(P_Y + 108))
    win.textSf:SetSize(PR_W - 58, P_H - 108 - 50)
    win.textC = CreateFrame("Frame", nil, win.textSf)
    win.textC:SetSize(PR_W - 64, 10)
    win.textSf:SetScrollChild(win.textC)
    win.rText = fs(win.textC, 14)
    win.rText:SetPoint("TOPLEFT", 4, -4)
    win.rText:SetWidth(PR_W - 80)
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
