-- WoWpoCesku: zobrazuje české překlady questů.
-- Přeložené questy bere z Data.lua (generuje pomocnik.ps1).
-- Nepřeložený quest nabídne k označení -> hráč zmáčkne Ctrl+C -> Pomocník ho přeloží.
-- Funguje v okně questu u NPC i v deníku questů.

local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local NAME_TOKEN = "{N}"
local DEFAULT_FONT_SIZE = 13

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

-- Celé slovo bez ohledu na velikost písmen ("Paladin" i "paladin")
local function wordPattern(word)
    local p = escapePattern(word):gsub("%a", function(c) return "[" .. c:upper() .. c:lower() .. "]" end)
    return "%f[%a]" .. p .. "%f[%A]"
end

-- Jméno, třídu a rasu hráče nahradí značkami, aby byl text stejný pro všechny hráče
-- (jeden překlad pro všechny postavy a sběrna pozná stejný quest od různých hráčů)
local function toToken(s)
    s = s or ""
    local name = UnitName("player")
    if name and name ~= "" then
        s = s:gsub(escapePattern(name), NAME_TOKEN)
    end
    local race = UnitRace("player")
    if race and race ~= "" then s = s:gsub(wordPattern(race), "{R}") end
    local class = UnitClass("player")
    if class and class ~= "" then s = s:gsub(wordPattern(class), "{C}") end
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
title:SetTextColor(1, 0.82, 0)
title:SetPoint("TOPLEFT", 12, -28)
title:SetPoint("RIGHT", panel, "RIGHT", -30, 0)
title:SetJustifyH("LEFT")

-- Režim "přeloženo": rolovací text + tlačítka dole
local scroll = CreateFrame("ScrollFrame", "WoWpoCeskuScroll", panel, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
scroll:SetPoint("BOTTOMRIGHT", -30, 42)

-- Když překlad nesedí na text ve hře (Forever quest změnil), jde ho přeložit znovu
local retry = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
retry:SetSize(165, 22)
retry:SetPoint("BOTTOMLEFT", 12, 12)
czButton(retry)
retry:SetText("Nesedí? Přeložit znovu")

-- Špatný překlad jde opravit v Pomocníkovi (oprava se pošle i ostatním hráčům)
local fix = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
fix:SetSize(150, 22)
fix:SetPoint("BOTTOMRIGHT", -12, 12)
czButton(fix)
fix:SetText("Opravit překlad")

local content = CreateFrame("Frame", nil, scroll)
content:SetSize(310, 10)
scroll:SetScrollChild(content)

local body = content:CreateFontString(nil, "OVERLAY")
body:SetTextColor(0.95, 0.92, 0.85)
body:SetPoint("TOPLEFT")
body:SetWidth(310)
body:SetJustifyH("LEFT")
body:SetSpacing(2)

-- Režim "kopírování": návod + políčko s textem pro Pomocníka
local copyFrame = CreateFrame("Frame", nil, panel)
copyFrame:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
copyFrame:SetPoint("BOTTOMRIGHT", -12, 12)

local hint = copyFrame:CreateFontString(nil, "OVERLAY")
hint:SetTextColor(0.95, 0.92, 0.85)
hint:SetPoint("TOPLEFT")
hint:SetPoint("RIGHT")
hint:SetJustifyH("LEFT")
hint:SetSpacing(3)

local HINTS = {
    preklad = "Tento quest ještě není přeložený.\n\n"
        .. "|cffffd1001.|r Text níže je označený – zmáčkni |cff00ff00Ctrl+C|r\n"
        .. "|cffffd1002.|r Překlad se hned ukáže v okně Pomocníka\n"
        .. "|cffffd1003.|r Po |cff00ff00/reload|r už bude česky i tady",
    znovu = "Přeložit znovu podle aktuálního textu ve hře:\n\n"
        .. "|cffffd1001.|r Text níže je označený – zmáčkni |cff00ff00Ctrl+C|r\n"
        .. "|cffffd1002.|r Nový překlad se ukáže v okně Pomocníka\n"
        .. "|cffffd1003.|r Po |cff00ff00/reload|r bude i tady",
    oprava = "Oprava překladu:\n\n"
        .. "|cffffd1001.|r Text níže je označený – zmáčkni |cff00ff00Ctrl+C|r\n"
        .. "|cffffd1002.|r V Pomocníkovi se otevře okno pro opravu\n"
        .. "|cffffd1003.|r Po uložení a |cff00ff00/reload|r bude oprava i tady",
}

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
again:SetText("Označit text")
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
            status:SetText("|cff00ff00Zkopírováno!|r  Pokračuj v okně Pomocníka.")
        end)
    end
end)

-- Velikost písma a šířka panelu (/czq velikost N)
local function applyLayout()
    local size = WoWpoCeskuSettings.fontSize or DEFAULT_FONT_SIZE
    local width = 360 + (size - DEFAULT_FONT_SIZE) * 22
    panel:SetWidth(width)
    title:SetFont(FONT, size + 3, "")
    body:SetFont(FONT, size, "")
    hint:SetFont(FONT, size, "")
    status:SetFont(FONT, size, "")
    local inner = width - 50
    content:SetWidth(inner)
    body:SetWidth(inner)
    edit:SetWidth(inner)
end

-------------------------------------------------------------------------------
-- Zdroje questu: okno u NPC ("dialog") a deník questů ("log")
-------------------------------------------------------------------------------
local function gatherDialog(event)
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

-- Vybraný quest v deníku – klasický deník (QuestLogFrame) i moderní (v mapě)
local function selectedLogQuest()
    local questID, index
    if C_QuestLog and C_QuestLog.GetSelectedQuest then questID = C_QuestLog.GetSelectedQuest() end
    if GetQuestLogSelection then index = GetQuestLogSelection() end
    if (not questID or questID == 0) and index and index > 0 and GetQuestLogTitle then
        questID = select(8, GetQuestLogTitle(index))
    end
    if (not index or index == 0) and questID and questID > 0 and C_QuestLog and C_QuestLog.GetLogIndexForQuestID then
        index = C_QuestLog.GetLogIndexForQuestID(questID)
    end
    return questID, index
end

local function gatherLog()
    local questID, index = selectedLogQuest()
    if not questID or questID == 0 then return nil end
    local titleText = C_QuestLog and C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(questID)
    if (not titleText or titleText == "") and index and GetQuestLogTitle then titleText = GetQuestLogTitle(index) end
    local desc, objectives = GetQuestLogQuestText(index)
    return {
        id = questID,
        part = "detail",
        title = toToken(titleText),
        text = toToken(desc),
        objectives = toToken(objectives),
    }
end

local function anchorFrame(source)
    if source == "log" then
        if QuestLogFrame and QuestLogFrame:IsShown() then return QuestLogFrame end
        if WorldMapFrame and WorldMapFrame:IsShown() then return WorldMapFrame end
    elseif QuestFrame and QuestFrame:IsShown() then
        return QuestFrame
    end
end

local function placePanel(source)
    panel:ClearAllPoints()
    local pos = WoWpoCeskuSettings.pos
    local anchor = anchorFrame(source)
    if pos then
        panel:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
    elseif anchor then
        panel:SetPoint("TOPLEFT", anchor, "TOPRIGHT", 4, 0)
    else
        panel:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    end
    if anchor then
        panel:SetHeight(math.max(420, math.min(anchor:GetHeight(), 600)))
    end
end

-------------------------------------------------------------------------------
-- Zobrazení
-------------------------------------------------------------------------------
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

local function buildPayload(q, mode)
    local header = ("CZQ#%d#%s"):format(q.id, q.part)
    if mode == "oprava" then header = header .. "#oprava" end
    local lines = { header, "##title", q.title }
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
    fix:Show()
end

-- mode: "preklad" (nový quest), "znovu" (nesedí), "oprava" (oprava překladu)
local function showCopy(q, mode)
    title:SetText(q.title)
    hint:SetText(HINTS[mode] or HINTS.preklad)
    edit.payload = buildPayload(q, mode)
    edit:SetText(edit.payload)
    edit:SetCursorPosition(0)
    status:SetText("")
    scroll:Hide()
    retry:Hide()
    fix:Hide()
    copyFrame:Show()
    -- V deníku se text sám neoznačuje (zabral by klávesnici při procházení deníku)
    if WoWpoCeskuSettings.autofocus and (panel.source ~= "log" or mode ~= "preklad") then
        selectPayload()
    elseif panel.source == "log" then
        status:SetText("|cffaaaaaaKlikni na 'Označit text' a zmáčkni Ctrl+C|r")
    end
end

local currentQuest

local function showQuest(q, source)
    if not q then return end
    currentQuest = q
    panel.source = source
    placePanel(source)
    panel:Show()
    if isTranslated(q) then
        showTranslated(q)
    else
        showCopy(q, "preklad")
    end
end

retry:SetScript("OnClick", function()
    if currentQuest then showCopy(currentQuest, "znovu") end
end)
fix:SetScript("OnClick", function()
    if currentQuest then showCopy(currentQuest, "oprava") end
end)

-- Deník: po výběru questu počkat jeden snímek, než hra aktualizuje výběr
local function onLogChanged()
    C_Timer.After(0, function()
        if not WoWpoCeskuSettings.enabled or WoWpoCeskuSettings.log == false then return end
        if not (anchorFrame("log")) then return end
        showQuest(gatherLog(), "log")
    end)
end

local function onLogHidden()
    if panel.source == "log" then
        edit:ClearFocus()
        panel:Hide()
    end
end

local hookedLog = {}
local function hookQuestLog()
    -- Klasický deník
    if QuestLog_UpdateQuestDetails and not hookedLog.classic then
        hooksecurefunc("QuestLog_UpdateQuestDetails", onLogChanged)
        hookedLog.classic = true
    end
    if QuestLogFrame and not hookedLog.classicHide then
        QuestLogFrame:HookScript("OnHide", onLogHidden)
        hookedLog.classicHide = true
    end
    -- Moderní deník v mapě
    if QuestMapFrame_ShowQuestDetails and not hookedLog.map then
        hooksecurefunc("QuestMapFrame_ShowQuestDetails", onLogChanged)
        hookedLog.map = true
    end
    if QuestMapFrame and QuestMapFrame.DetailsFrame and not hookedLog.mapHide then
        QuestMapFrame.DetailsFrame:HookScript("OnHide", onLogHidden)
        hookedLog.mapHide = true
    end
end

-------------------------------------------------------------------------------
-- Události
-------------------------------------------------------------------------------
local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
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
            applyLayout()
        end
        -- Deník může patřit do addonu Blizzardu, který se načte později
        hookQuestLog()
        return
    end

    if event == "PLAYER_LOGIN" then
        hookQuestLog()
        return
    end

    if event == "QUEST_FINISHED" then
        if panel.source == "dialog" then
            edit:ClearFocus()
            panel:Hide()
        end
        return
    end

    if not WoWpoCeskuSettings.enabled then return end
    showQuest(gatherDialog(event), "dialog")
end)

-------------------------------------------------------------------------------
-- Příkazy: /czq (zprávy do chatu bez diakritiky – písmo chatu ji nemusí umět)
-------------------------------------------------------------------------------
SLASH_CZQUESTS1 = "/czq"
SLASH_CZQUESTS2 = "/wpc"
SlashCmdList.CZQUESTS = function(msg)
    msg = (msg or ""):lower()
    local cmd, arg = msg:match("^(%S*)%s*(.-)$")
    local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end
    if cmd == "reset" then
        WoWpoCeskuSettings.pos = nil
        say("pozice panelu obnovena.")
    elseif cmd == "focus" then
        WoWpoCeskuSettings.autofocus = not WoWpoCeskuSettings.autofocus
        say("automaticke oznaceni textu " .. (WoWpoCeskuSettings.autofocus and "ZAPNUTO" or "VYPNUTO"))
    elseif cmd == "velikost" then
        local size = tonumber(arg)
        if not size then
            say(("velikost pisma: %d  (zmena: /czq velikost 10-20, vychozi %d)"):format(
                WoWpoCeskuSettings.fontSize or DEFAULT_FONT_SIZE, DEFAULT_FONT_SIZE))
            return
        end
        WoWpoCeskuSettings.fontSize = math.max(10, math.min(20, math.floor(size)))
        applyLayout()
        if panel:IsShown() and currentQuest then showQuest(currentQuest, panel.source) end
        say(("velikost pisma nastavena na %d"):format(WoWpoCeskuSettings.fontSize))
    elseif cmd == "denik" then
        WoWpoCeskuSettings.log = (WoWpoCeskuSettings.log == false)
        say("preklad v deniku questu " .. (WoWpoCeskuSettings.log and "ZAPNUT" or "VYPNUT"))
    elseif cmd == "stav" then
        local n = 0
        for _ in pairs(WoWpoCesku_Data) do n = n + 1 end
        say(("prelozenych questu: %d"):format(n))
    elseif cmd == "info" then
        hookQuestLog()
        say(("denik: klasicky=%s, v mape=%s | vybrany quest: %s"):format(
            tostring(hookedLog.classic or false), tostring(hookedLog.map or false),
            tostring((selectedLogQuest()))))
    else
        WoWpoCeskuSettings.enabled = not WoWpoCeskuSettings.enabled
        if not WoWpoCeskuSettings.enabled then panel:Hide() end
        say("preklad " .. (WoWpoCeskuSettings.enabled and "ZAPNUT" or "VYPNUT")
            .. "   (dalsi: /czq velikost, /czq denik, /czq reset, /czq focus, /czq stav)")
    end
end
