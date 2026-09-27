-- WoWpoCesku: zobrazuje české překlady questů.
-- Přeložené questy bere z Data.lua (generuje pomocnik.ps1).
-- Nepřeložený quest nabídne k označení -> hráč zmáčkne Ctrl+C -> Pomocník ho přeloží.

local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local NAME_TOKEN = "{N}"

-- Výchozí písma WoW nemají česká písmena -> tlačítka dostanou vlastní font
local buttonFont = CreateFont("WoWpoCeskuButtonFont")
buttonFont:SetFont(FONT, 12, "")
buttonFont:SetTextColor(1, 0.82, 0)
local buttonFontHighlight = CreateFont("WoWpoCeskuButtonFontHighlight")
buttonFontHighlight:SetFont(FONT, 12, "")
buttonFontHighlight:SetTextColor(1, 1, 1)

local function czButton(button)
    button:SetNormalFontObject(buttonFont)
    button:SetHighlightFontObject(buttonFontHighlight)
end

-- Která pole musí být přeložená pro danou část questu
local PART_FIELDS = {
    detail   = { "text", "objectives" },
    progress = { "progress" },
    reward   = { "reward" },
}

WoWpoCesku_Data = WoWpoCesku_Data or {}

-------------------------------------------------------------------------------
-- Jméno postavy <-> {N}, aby šel jeden překlad použít pro všechny postavy
-------------------------------------------------------------------------------
local function escapePattern(s)
    return (s:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1"))
end

local function toToken(s)
    s = s or ""
    local name = UnitName("player")
    if name and name ~= "" then
        s = s:gsub(escapePattern(name), NAME_TOKEN)
    end
    return s
end

-- {C} a {R} pocházejí z předpřipravené databáze (tam je třída/rasa hráče jako proměnná)
local CZ_CLASS = {
    WARRIOR = "válečník", PALADIN = "paladin", HUNTER = "lovec", ROGUE = "zloděj",
    PRIEST = "kněz", SHAMAN = "šaman", MAGE = "mág", WARLOCK = "černokněžník", DRUID = "druid",
}
local CZ_RACE = {
    Human = "člověk", Dwarf = "trpaslík", NightElf = "noční elf", Gnome = "gnóm",
    Orc = "ork", Scourge = "nemrtvý", Tauren = "tauren", Troll = "trol",
}

local function fromToken(s)
    local name = UnitName("player") or ""
    local className, classToken = UnitClass("player")
    local raceName, raceToken = UnitRace("player")
    local cls = CZ_CLASS[classToken or ""] or className or ""
    local race = CZ_RACE[raceToken or ""] or raceName or ""
    s = (s or ""):gsub("{N}", (name:gsub("%%", "%%%%")))
    s = s:gsub("{C}", (cls:gsub("%%", "%%%%")))
    s = s:gsub("{R}", (race:gsub("%%", "%%%%")))
    return s
end

-------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------
local panel = CreateFrame("Frame", "WoWpoCeskuPanel", UIParent, BackdropTemplateMixin and "BackdropTemplate")
panel:SetSize(360, 460)
panel:SetFrameStrata("HIGH")
panel:SetClampedToScreen(true)
panel:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
panel:SetBackdropColor(0.05, 0.05, 0.08, 1)
panel:SetMovable(true)
panel:EnableMouse(true)
panel:RegisterForDrag("LeftButton")
panel:SetScript("OnDragStart", panel.StartMoving)
panel:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local p, _, rp, x, y = self:GetPoint()
    WoWpoCeskuSettings.pos = { p, rp, x, y }
end)
panel:Hide()

local header = panel:CreateFontString(nil, "OVERLAY")
header:SetFont(FONT, 11, "")
header:SetTextColor(0.6, 0.6, 0.6)
header:SetPoint("TOPLEFT", 12, -10)
header:SetText("WoWpoČesku")

local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -2, -2)

local title = panel:CreateFontString(nil, "OVERLAY")
title:SetFont(FONT, 16, "")
title:SetTextColor(1, 0.82, 0)
title:SetPoint("TOPLEFT", 12, -28)
title:SetPoint("RIGHT", panel, "RIGHT", -30, 0)
title:SetJustifyH("LEFT")

-- Režim "přeloženo": rolovací text
local scroll = CreateFrame("ScrollFrame", "WoWpoCeskuScroll", panel, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
scroll:SetPoint("BOTTOMRIGHT", -30, 42)

-- Když překlad nesedí na text ve hře (Forever quest změnil), jde ho přeložit znovu
local retry = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
retry:SetSize(170, 22)
retry:SetPoint("BOTTOMLEFT", 12, 12)
czButton(retry)
retry:SetText("Nesedí? Přeložit znovu")

local content = CreateFrame("Frame", nil, scroll)
content:SetSize(310, 10)
scroll:SetScrollChild(content)

local body = content:CreateFontString(nil, "OVERLAY")
body:SetFont(FONT, 13, "")
body:SetTextColor(0.95, 0.92, 0.85)
body:SetPoint("TOPLEFT")
body:SetWidth(310)
body:SetJustifyH("LEFT")
body:SetSpacing(2)

-- Režim "nepřeloženo": návod + políčko s textem ke zkopírování
local copyFrame = CreateFrame("Frame", nil, panel)
copyFrame:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
copyFrame:SetPoint("BOTTOMRIGHT", -12, 12)

local hint = copyFrame:CreateFontString(nil, "OVERLAY")
hint:SetFont(FONT, 13, "")
hint:SetTextColor(0.95, 0.92, 0.85)
hint:SetPoint("TOPLEFT")
hint:SetPoint("RIGHT")
hint:SetJustifyH("LEFT")
hint:SetSpacing(3)
hint:SetText("Tento quest ještě není přeložený.\n\n"
    .. "|cffffd1001.|r Text níže je označený – zmáčkni |cff00ff00Ctrl+C|r\n"
    .. "|cffffd1002.|r Překlad se hned ukáže v okně Pomocníka\n"
    .. "|cffffd1003.|r Po |cff00ff00/reload|r už bude česky i tady")

local boxBg = CreateFrame("Frame", nil, copyFrame, BackdropTemplateMixin and "BackdropTemplate")
boxBg:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 0, -12)
boxBg:SetPoint("RIGHT")
boxBg:SetHeight(110)
boxBg:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 12,
    insets = { left = 3, right = 3, top = 3, bottom = 3 },
})
boxBg:SetBackdropColor(0, 0, 0, 0.8)
boxBg:SetClipsChildren(true)

local edit = CreateFrame("EditBox", nil, boxBg)
edit:SetMultiLine(true)
edit:SetAutoFocus(false)
edit:SetFontObject(ChatFontNormal)
edit:SetPoint("TOPLEFT", 8, -8)
edit:SetWidth(310)
edit:SetMaxLetters(0)

local status = copyFrame:CreateFontString(nil, "OVERLAY")
status:SetFont(FONT, 13, "")
status:SetPoint("TOPLEFT", boxBg, "BOTTOMLEFT", 0, -10)
status:SetPoint("RIGHT")
status:SetJustifyH("LEFT")

local function selectPayload()
    edit:SetFocus()
    edit:HighlightText()
    status:SetText("|cffaaaaaaOznačeno – zmáčkni Ctrl+C (Esc = zrušit)|r")
end

local again = CreateFrame("Button", nil, copyFrame, "UIPanelButtonTemplate")
again:SetSize(140, 24)
again:SetPoint("TOPLEFT", status, "BOTTOMLEFT", 0, -10)
czButton(again)
again:SetText("Označit znovu")
again:SetScript("OnClick", selectPayload)
boxBg:EnableMouse(true)
boxBg:SetScript("OnMouseDown", selectPayload)

edit:SetScript("OnEscapePressed", edit.ClearFocus)
edit:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0) end)
-- Text nejde přepsat: při psaní se vrátí původní obsah
edit:SetScript("OnTextChanged", function(self, userInput)
    if userInput then
        self:SetText(self.payload or "")
        self:HighlightText()
    end
end)
edit:SetScript("OnKeyDown", function(self, key)
    if key == "C" and IsControlKeyDown() then
        C_Timer.After(0.1, function()
            self:ClearFocus()
            status:SetText("|cff00ff00Zkopírováno!|r  Překlad najdeš v okně Pomocníka.")
        end)
    end
end)

-------------------------------------------------------------------------------
-- Logika
-------------------------------------------------------------------------------
local function placePanel()
    panel:ClearAllPoints()
    local pos = WoWpoCeskuSettings.pos
    if pos then
        panel:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
    elseif QuestFrame and QuestFrame:IsShown() then
        panel:SetPoint("TOPLEFT", QuestFrame, "TOPRIGHT", 4, 0)
        panel:SetHeight(QuestFrame:GetHeight())
    else
        panel:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    end
end

local function gather(event)
    local id = GetQuestID and GetQuestID()
    if not id or id == 0 then return nil end
    local q = { id = id, title = toToken(GetTitleText()) }
    if event == "QUEST_DETAIL" then
        q.part = "detail"
        q.text = toToken(GetQuestText())
        q.objectives = toToken(GetObjectiveText())
    elseif event == "QUEST_PROGRESS" then
        q.part = "progress"
        q.progress = toToken(GetProgressText())
    else
        q.part = "reward"
        q.reward = toToken(GetRewardText())
    end
    return q
end

local function simplify(s)
    return ((s or ""):lower():gsub("[%s%p]", ""))
end

local function isTranslated(q)
    local tr = WoWpoCesku_Data[q.id]
    if not tr then return false end
    -- Jiný anglický název než v databázi = Forever quest změnil, překlad by neseděl
    if tr.en and simplify(tr.en) ~= simplify(q.title) then return false end
    for _, field in ipairs(PART_FIELDS[q.part]) do
        if q[field] ~= "" and not tr[field] then return false end
    end
    return true
end

local function buildPayload(q)
    local lines = { ("CZQ#%d#%s"):format(q.id, q.part), "##title", q.title }
    for _, field in ipairs(PART_FIELDS[q.part]) do
        if q[field] ~= "" then
            lines[#lines + 1] = "##" .. field
            lines[#lines + 1] = q[field]
        end
    end
    return table.concat(lines, "\n")
end

local function showTranslated(q)
    local tr = WoWpoCesku_Data[q.id]
    title:SetText(fromToken(tr.title or q.title))
    local text
    if q.part == "detail" then
        text = fromToken(tr.text or "")
        if tr.objectives and tr.objectives ~= "" then
            text = text .. "\n\n|cffffd100Úkol:|r\n" .. fromToken(tr.objectives)
        end
    else
        text = fromToken(tr[q.part] or "")
    end
    body:SetText(text)
    content:SetHeight(body:GetStringHeight() + 10)
    scroll:SetVerticalScroll(0)
    -- Posuvník jen když se text nevejde (rozsah se přepočítá až v dalším snímku)
    C_Timer.After(0, function()
        local bar = scroll.ScrollBar or _G["WoWpoCeskuScrollScrollBar"]
        if bar then bar:SetShown(scroll:GetVerticalScrollRange() > 0) end
    end)
    copyFrame:Hide()
    scroll:Show()
    retry:Show()
end

local function showUntranslated(q)
    title:SetText(q.title)
    edit.payload = buildPayload(q)
    edit:SetText(edit.payload)
    edit:SetCursorPosition(0)
    status:SetText("")
    scroll:Hide()
    retry:Hide()
    copyFrame:Show()
    if WoWpoCeskuSettings.autofocus then
        selectPayload()
    end
end

local currentQuest
retry:SetScript("OnClick", function()
    if currentQuest then showUntranslated(currentQuest) end
end)

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("QUEST_DETAIL")
events:RegisterEvent("QUEST_PROGRESS")
events:RegisterEvent("QUEST_COMPLETE")
events:RegisterEvent("QUEST_FINISHED")
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == "WoWpoCesku" then
            WoWpoCeskuSettings = WoWpoCeskuSettings or {}
            if WoWpoCeskuSettings.enabled == nil then WoWpoCeskuSettings.enabled = true end
            if WoWpoCeskuSettings.autofocus == nil then WoWpoCeskuSettings.autofocus = true end
        end
        return
    end

    if event == "QUEST_FINISHED" then
        edit:ClearFocus()
        panel:Hide()
        return
    end

    if not WoWpoCeskuSettings.enabled then return end
    local q = gather(event)
    if not q then return end
    currentQuest = q

    placePanel()
    panel:Show()
    if isTranslated(q) then
        showTranslated(q)
    else
        showUntranslated(q)
    end
end)

-------------------------------------------------------------------------------
-- Příkazy: /czq (zprávy do chatu bez diakritiky – písmo chatu ji nemusí umět)
-------------------------------------------------------------------------------
SLASH_CZQUESTS1 = "/czq"
SLASH_CZQUESTS2 = "/wpc"
SlashCmdList.CZQUESTS = function(msg)
    msg = (msg or ""):lower()
    local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end
    if msg == "reset" then
        WoWpoCeskuSettings.pos = nil
        say("pozice panelu obnovena.")
    elseif msg == "focus" then
        WoWpoCeskuSettings.autofocus = not WoWpoCeskuSettings.autofocus
        say("automaticke oznaceni textu " .. (WoWpoCeskuSettings.autofocus and "ZAPNUTO" or "VYPNUTO"))
    elseif msg == "stav" then
        local n = 0
        for _ in pairs(WoWpoCesku_Data) do n = n + 1 end
        say(("prelozenych questu: %d"):format(n))
    else
        WoWpoCeskuSettings.enabled = not WoWpoCeskuSettings.enabled
        if not WoWpoCeskuSettings.enabled then panel:Hide() end
        say("preklad " .. (WoWpoCeskuSettings.enabled and "ZAPNUT" or "VYPNUT")
            .. "   (dalsi: /czq reset, /czq focus, /czq stav)")
    end
end
