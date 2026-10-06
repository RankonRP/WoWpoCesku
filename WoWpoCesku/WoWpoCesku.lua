-- WoWpoCesku: zobrazuje české překlady questů.
-- Přeložené questy bere z Data.lua (generuje pomocnik.ps1).
-- Nepřeložený quest nabídne k označení -> hráč zmáčkne Ctrl+C -> Pomocník ho přeloží.
-- Funguje v okně questu u NPC i v deníku questů.

-- zablokované akce ("blocked from an action only available to the Blizzard UI") – vypsat a uložit, ať víme, co opravit
do
    local guard = CreateFrame("Frame")
    guard:RegisterEvent("ADDON_ACTION_BLOCKED")
    guard:RegisterEvent("ADDON_ACTION_FORBIDDEN")
    guard:SetScript("OnEvent", function(_, event, addon, func)
        if addon ~= "WoWpoCesku" then return end
        print(("|cffffd100WoWpoCesku:|r hra zablokovala akci: %s (%s) - napis to prosim autorovi"):format(tostring(func), event))
        WoWpoCeskuSeen = WoWpoCeskuSeen or {}
        WoWpoCeskuSeen.blocked = WoWpoCeskuSeen.blocked or {}
        table.insert(WoWpoCeskuSeen.blocked, date("%d.%m. %H:%M ") .. tostring(func))
    end)
end

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
WoWpoCesku_Gossip = WoWpoCesku_Gossip or {}

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
    -- Pojistka: neviditelné znaky nulové šířky (U+200B–U+200D) písmo neumí a ukáže je jako ��
    s = s:gsub("\226\128[\139-\141]", "")
    return s
end
WoWpoCesku_FromToken = fromToken   -- používá i Rozhrani.lua
WoWpoCesku_ToToken = toToken

-------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------
local panel = CreateFrame("Frame", "WoWpoCeskuPanel", UIParent, BackdropTemplateMixin and "BackdropTemplate")
panel:SetSize(360, 460)
panel:SetFrameStrata("HIGH")
panel:SetClampedToScreen(true)
-- vzhled jako Kronika Azerothu: kožená vazba, pergamen, tmavý inkoust
local INK, RED, SEPIA = { 0.20, 0.13, 0.07 }, { 0.50, 0.12, 0.05 }, { 0.42, 0.30, 0.18 }
panel:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 },
})
panel:SetBackdropColor(0.23, 0.13, 0.07, 1)
do
    local page = panel:CreateTexture(nil, "BACKGROUND", nil, 1)
    page:SetPoint("TOPLEFT", 14, -14)
    page:SetPoint("BOTTOMRIGHT", -14, 14)
    page:SetColorTexture(0.91, 0.84, 0.66, 1)   -- kdyby textura chyběla
    local tex = panel:CreateTexture(nil, "BACKGROUND", nil, 2)
    tex:SetAllPoints(page)
    tex:SetTexture("Interface\\AddOns\\WoWpoCesku\\Textures\\pergamen.tga")
end
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
header:SetTextColor(RED[1], RED[2], RED[3])
header:SetPoint("TOP", 0, -22)
header:SetText("W o W p o Č e s k u")
-- ozdobný předěl pod záhlavím: linka – kosočtverec – linka
local orn = CreateFrame("Frame", nil, panel)
orn:SetSize(200, 10)
orn:SetPoint("TOP", header, "BOTTOM", 0, -3)
do
    local d = orn:CreateTexture(nil, "ARTWORK")
    d:SetColorTexture(RED[1], RED[2], RED[3], 0.85)
    d:SetSize(6, 6)
    d:SetPoint("CENTER")
    d:SetRotation(math.rad(45))
    for _, side in ipairs({ -1, 1 }) do
        local l = orn:CreateTexture(nil, "ARTWORK")
        l:SetColorTexture(SEPIA[1], SEPIA[2], SEPIA[3], 0.7)
        l:SetSize(86, 1)
        l:SetPoint(side < 0 and "RIGHT" or "LEFT", d, "CENTER", side * 9, 0)
    end
end

local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -8, -8)

local title = panel:CreateFontString(nil, "OVERLAY")
title:SetTextColor(INK[1], INK[2], INK[3])
title:SetPoint("TOPLEFT", 24, -46)
title:SetPoint("RIGHT", panel, "RIGHT", -24, 0)
title:SetJustifyH("CENTER")

-- Režim "přeloženo": rolovací text + tlačítka dole
local scroll = CreateFrame("ScrollFrame", "WoWpoCeskuScroll", panel, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -12)
scroll:SetPoint("BOTTOMRIGHT", -36, 74)

-- Když překlad nesedí na text ve hře (Forever quest změnil), jde ho přeložit znovu
local retry = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
retry:SetSize(165, 22)
retry:SetPoint("BOTTOMLEFT", 20, 18)
czButton(retry)
retry:SetText("Nesedí? Přeložit znovu")

-- Špatný překlad jde opravit v Pomocníkovi (oprava se pošle i ostatním hráčům)
local fix = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
fix:SetSize(150, 22)
fix:SetPoint("BOTTOMRIGHT", -20, 18)
czButton(fix)
fix:SetText("Opravit překlad")

-- Překlad, který se hráči nelíbí: označí se pro Clauda (jen mezi hráčem a Claudem, nikam se neposílá)
local claudeBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
claudeBtn:SetSize(316, 24)
claudeBtn:SetPoint("BOTTOMLEFT", 20, 46)
czButton(claudeBtn)
claudeBtn:SetText("Nelíbí se mi – poslat Claudovi")
claudeBtn:Hide()

local content = CreateFrame("Frame", nil, scroll)
content:SetSize(310, 10)
scroll:SetScrollChild(content)

local body = content:CreateFontString(nil, "OVERLAY")
body:SetTextColor(INK[1], INK[2], INK[3])
body:SetPoint("TOPLEFT")
body:SetWidth(310)
body:SetJustifyH("LEFT")
body:SetSpacing(2)

-- Režim "kopírování": návod + políčko s textem pro Pomocníka
local copyFrame = CreateFrame("Frame", nil, panel)
copyFrame:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
copyFrame:SetPoint("BOTTOMRIGHT", -22, 18)

local hint = copyFrame:CreateFontString(nil, "OVERLAY")
hint:SetTextColor(INK[1], INK[2], INK[3])
hint:SetPoint("TOPLEFT")
hint:SetPoint("RIGHT")
hint:SetJustifyH("LEFT")
hint:SetSpacing(3)

local HINTS = {
    preklad = "Tento quest ještě není přeložený.\n\n"
        .. "|cff801f0dHned:|r text níže je označený – zmáčkni |cff1d6b1dCtrl+C|r,\n"
        .. "překlad se ukáže v okně Pomocníka.\n"
        .. "|cff801f0dNebo nic nedělej:|r po |cff1d6b1d/reload|r ho Pomocník přeloží sám\n"
        .. "a po dalším |cff1d6b1d/reload|r bude česky i tady.",
    znovu = "Přeložit znovu podle aktuálního textu ve hře:\n\n"
        .. "|cff801f0d1.|r Text níže je označený – zmáčkni |cff1d6b1dCtrl+C|r\n"
        .. "|cff801f0d2.|r Nový překlad se ukáže v okně Pomocníka\n"
        .. "|cff801f0d3.|r Po |cff1d6b1d/reload|r bude i tady",
    rozhovor = "Tenhle rozhovor ještě není přeložený.\n\n"
        .. "|cff801f0dHned:|r klikni na 'Označit text' a zmáčkni |cff1d6b1dCtrl+C|r.\n"
        .. "|cff801f0dNebo nic nedělej:|r po |cff1d6b1d/reload|r ho Pomocník přeloží sám\n"
        .. "a po dalším |cff1d6b1d/reload|r bude česky i tady.",
    kniha = "Tahle stránka ještě není přeložená.\n\n"
        .. "|cff801f0dHned:|r klikni na 'Označit text' a zmáčkni |cff1d6b1dCtrl+C|r.\n"
        .. "|cff801f0dNebo nic nedělej:|r po |cff1d6b1d/reload|r ho Pomocník přeloží sám\n"
        .. "a po dalším |cff1d6b1d/reload|r bude česky i tady.",
    oprava = "Oprava překladu:\n\n"
        .. "|cff801f0d1.|r Text níže je označený – zmáčkni |cff1d6b1dCtrl+C|r\n"
        .. "|cff801f0d2.|r V Pomocníkovi se otevře okno pro opravu\n"
        .. "|cff801f0d3.|r Po uložení a |cff1d6b1d/reload|r bude oprava i tady",
}

local boxBg = CreateFrame("Frame", nil, copyFrame, BackdropTemplateMixin and "BackdropTemplate")
boxBg:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 0, -12)
boxBg:SetPoint("RIGHT")
boxBg:SetHeight(110)
boxBg:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
boxBg:SetBackdropColor(1, 0.97, 0.88, 0.45)
boxBg:SetBackdropBorderColor(SEPIA[1], SEPIA[2], SEPIA[3], 0.9)
boxBg:SetClipsChildren(true)

local edit = CreateFrame("EditBox", nil, boxBg)
edit:SetMultiLine(true)
edit:SetAutoFocus(false)
edit:SetFontObject(ChatFontNormal)
edit:SetTextColor(INK[1], INK[2], INK[3])
edit:SetPoint("TOPLEFT", 8, -8)
edit:SetWidth(310)
edit:SetMaxLetters(0)

local status = copyFrame:CreateFontString(nil, "OVERLAY")
status:SetPoint("TOPLEFT", boxBg, "BOTTOMLEFT", 0, -10)
status:SetTextColor(INK[1], INK[2], INK[3])
status:SetPoint("RIGHT")
status:SetJustifyH("LEFT")

local function selectPayload()
    edit:SetFocus()
    edit:HighlightText()
    status:SetText("|cff6b4d2eOznačeno – zmáčkni Ctrl+C (Esc = zrušit)|r")
end

local again = CreateFrame("Button", nil, copyFrame, "UIPanelButtonTemplate")
again:SetSize(140, 24)
again:SetPoint("TOPLEFT", status, "BOTTOMLEFT", 0, -10)
czButton(again)
again:SetText("Označit text")
again:SetScript("OnClick", selectPayload)

-- Načíst překlady = /reload: hra uloží frontu, Pomocník ji přeloží, další načtení ukáže češtinu
local reloadButton = CreateFrame("Button", nil, copyFrame, "UIPanelButtonTemplate")
reloadButton:SetSize(165, 24)
reloadButton:SetPoint("LEFT", again, "RIGHT", 8, 0)
czButton(reloadButton)
reloadButton:SetText("Načíst překlady")
reloadButton:SetScript("OnClick", function() ReloadUI() end)
reloadButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Nacist preklady (/reload)")
    GameTooltip:AddLine("Pomocnik texty prelozi asi za 20 s,", 1, 1, 1)
    GameTooltip:AddLine("pak klikni znovu a budou cesky.", 1, 1, 1)
    GameTooltip:Show()
end)
reloadButton:SetScript("OnLeave", GameTooltip_Hide)
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
            status:SetText("|cff1d6b1dZkopírováno!|r  Pokračuj v okně Pomocníka.")
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
    local inner = width - 66
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

-- Rozhovor s NPC (okno "gossip"): co NPC říká, když ho oslovíš
local function gossipKey(s)
    return ((s or ""):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", ""))
end

-- Starší verze Pomocníka ukládala víceodstavcové rozhovory s doslovným "\r" v klíči (zpětné lomítko + r).
-- Hra takový klíč nikdy nenajde, rozhovor zůstal nepřeložený. Proto si pro každý klíč uděláme i opravený
-- tvar (bez "\r", s jednotnými mezerami) a hledáme napřed přesně, pak v opraveném indexu.
local gossipIndex
local function cleanGossip(s)
    return ((s or ""):gsub("\\r", ""):gsub("\\t", " "):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", ""))
end
local function gossipLookup(text)
    local key = gossipKey(text)
    local cs = WoWpoCesku_Gossip[key]
    if cs then return (cs:gsub("\\r", "")) end
    if not gossipIndex then
        gossipIndex = {}
        for k, v in pairs(WoWpoCesku_Gossip) do gossipIndex[cleanGossip(k)] = v end
    end
    cs = gossipIndex[cleanGossip(key)]
    if cs then return (cs:gsub("\\r", "")) end
end

local function gatherGossip()
    local text = (C_GossipInfo and C_GossipInfo.GetText and C_GossipInfo.GetText()) or (GetGossipText and GetGossipText())
    if not text or text == "" then return nil end
    local npcId = 0
    local guid = UnitGUID("npc")
    if guid then npcId = tonumber((select(6, strsplit("-", guid)))) or 0 end
    return { kind = "gossip", id = npcId, title = UnitName("npc") or "", gossip = toToken(text) }
end

-- Kniha, dopis, cedule (okno ItemText). Ukládá se jako rozhovor (klíč = anglický text).
local function gatherBook()
    local text = ItemTextGetText and ItemTextGetText()
    if not text or text == "" then return nil end
    -- Některé knihy mají HTML – ve hře i v Pomocníkovi pracujeme jen s čistým textem
    text = text:gsub("<[Bb][Rr]%s*/?>", "\n"):gsub("</[Pp]>", "\n\n"):gsub("<[^>]+>", "")
    text = text:gsub("\n\n\n+", "\n\n"):gsub("^%s+", ""):gsub("%s+$", "")
    return { kind = "gossip", book = true, id = 1, title = (ItemTextGetItem and ItemTextGetItem()) or "", gossip = toToken(text) }
end

local function anchorFrame(source)
    if source == "book" then
        if ItemTextFrame and ItemTextFrame:IsShown() then return ItemTextFrame end
    elseif source == "gossip" then
        if GossipFrame and GossipFrame:IsShown() then return GossipFrame end
    elseif source == "log" then
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

-- Označení: WoWpoCeskuSeen.flag["q:<id>"] / ["g:<anglický text>"] = { t = čas, part = ... }
-- Hra ho zapíše při /reload nebo odhlášení; Claude si ho přečte (tools/claude-preklad.js oznacene) a přeloží ručně.
local FLAG_MAX = 200
local function flagKey(q)
    if not q then return nil end
    if q.kind == "gossip" then return "g:" .. gossipKey(q.gossip) end
    return "q:" .. tostring(q.id)
end
local function flagTable()
    WoWpoCeskuSeen = WoWpoCeskuSeen or { q = {}, g = {} }
    WoWpoCeskuSeen.flag = WoWpoCeskuSeen.flag or {}
    return WoWpoCeskuSeen.flag
end
local function flagCount()
    local n = 0
    for _ in pairs(flagTable()) do n = n + 1 end
    return n
end
local function refreshClaude()
    local k = flagKey(panel.quest)
    if not k then claudeBtn:Hide() return end
    claudeBtn:SetText(flagTable()[k] and "|cff1d6b1dOznačeno pro Clauda|r – klikni pro zrušení" or "Nelíbí se mi – poslat Claudovi")
    claudeBtn:Show()
end
claudeBtn:SetScript("OnClick", function()
    local q = panel.quest
    local k = flagKey(q)
    if not k then return end
    local flags = flagTable()
    if flags[k] then
        flags[k] = nil
        print("|cffffd100WoWpoCesku:|r oznaceni zruseno (celkem oznaceno: " .. flagCount() .. ")")
    else
        if flagCount() >= FLAG_MAX then
            print("|cffffd100WoWpoCesku:|r uz je oznaceno " .. FLAG_MAX .. " textu - nejdriv je nech prelozit")
            return
        end
        flags[k] = { t = time(), part = q.part or "", title = (q.title or ""):sub(1, 80) }
        print("|cffffd100WoWpoCesku:|r oznaceno pro Clauda (celkem: " .. flagCount() .. "). Az jich bude vic, napis /reload a rekni Claudovi, ze ma prelozit oznacene.")
    end
    refreshClaude()
end)
claudeBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Poslat Claudovi")
    GameTooltip:AddLine("Oznaci tento preklad jako spatny.", 1, 1, 1)
    GameTooltip:AddLine("Claude ho prelozi rucne, az mu to reknes", 1, 1, 1)
    GameTooltip:AddLine("(po /reload se oznaceni ulozi do souboru).", 1, 1, 1)
    GameTooltip:Show()
end)
claudeBtn:SetScript("OnLeave", GameTooltip_Hide)
WoWpoCesku_FlagCount = flagCount

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
    if q.kind == "gossip" then
        return table.concat({ ("CZG#%d"):format(q.id), "##title", q.title, "##gossip", q.gossip }, "\n")
    end
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
            text = text .. "\n\n|cff801f0dÚkol:|r\n" .. fromToken(tr.objectives)
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
    refreshClaude()
end

-- Fronta pro Pomocníka: nepřeložené texty se ukládají do WoWpoCeskuQueue (SavedVariables).
-- Hra je zapíše na disk při /reload nebo odhlášení a Pomocník je odtud sám přeloží – bez Ctrl+C.
local QUEUE_MAX = 300

local function queueKey(q)
    if q.kind == "gossip" then return ("CZG#%d#%s"):format(q.id, gossipKey(q.gossip):sub(1, 60)) end
    return ("CZQ#%d#%s"):format(q.id, q.part)
end

local function addToQueue(q, payload)
    WoWpoCeskuQueue = WoWpoCeskuQueue or {}
    local key = queueKey(q)
    if WoWpoCeskuQueue[key] then WoWpoCeskuQueue[key] = payload return end
    local n = 0
    for _ in pairs(WoWpoCeskuQueue) do n = n + 1 end
    if n < QUEUE_MAX then WoWpoCeskuQueue[key] = payload end
end

-- Po načtení vyhodit z fronty, co už je mezitím přeložené
local function cleanQueue()
    WoWpoCeskuQueue = WoWpoCeskuQueue or {}
    for key, payload in pairs(WoWpoCeskuQueue) do
        local id, part = key:match("^CZQ#(%d+)#(%a+)$")
        local done = false
        if id then
            local tr = WoWpoCesku_Data[tonumber(id)]
            local fields = PART_FIELDS[part]
            if tr and fields then
                done = true
                for _, f in ipairs(fields) do
                    if payload:find("##" .. f .. "\n", 1, true) and not tr[f] then done = false end
                end
            end
        elseif key:find("^CZU#") then
            local text = payload:match("##ui\n(.*)$")
            done = not text or (WoWpoCesku_UI and WoWpoCesku_UI[text] ~= nil)
        else
            local text = payload:match("##gossip\n(.*)$")
            done = not text or gossipLookup(text) ~= nil
        end
        if done then WoWpoCeskuQueue[key] = nil end
    end
end

-- mode: "preklad" (nový quest), "znovu" (nesedí), "oprava" (oprava překladu)
local function showCopy(q, mode)
    title:SetText(q.title)
    hint:SetText(HINTS[mode] or HINTS.preklad)
    edit.payload = buildPayload(q, mode)
    if mode == "preklad" or mode == "rozhovor" or mode == "kniha" then addToQueue(q, edit.payload) end
    edit:SetText(edit.payload)
    edit:SetCursorPosition(0)
    status:SetText("")
    scroll:Hide()
    claudeBtn:Hide()
    retry:Hide()
    fix:Hide()
    copyFrame:Show()
    -- V deníku a u rozhovorů se text sám neoznačuje (zabral by klávesnici)
    local passive = (panel.source == "log" or panel.source == "gossip" or panel.source == "book")
        and (mode == "preklad" or mode == "rozhovor" or mode == "kniha")
    if WoWpoCeskuSettings.autofocus and not passive then
        selectPayload()
    elseif passive then
        status:SetText("|cff6b4d2eKlikni na 'Označit text' a zmáčkni Ctrl+C|r")
    end
end

local currentQuest

local function showGossip(q)
    local cs = gossipLookup(q.gossip)
    if cs then
        title:SetText(q.title)
        body:SetText(fromToken(cs))
        content:SetHeight(body:GetStringHeight() + 10)
        scroll:SetVerticalScroll(0)
        C_Timer.After(0, function()
            local bar = scroll.ScrollBar or _G["WoWpoCeskuScrollScrollBar"]
            if bar then bar:SetShown(scroll:GetVerticalScrollRange() > 0) end
        end)
        copyFrame:Hide()
        scroll:Show()
        -- Opravy rozhovorů zatím Pomocník neumí (u rozhovorů proto zůstává jen tlačítko pro Clauda)
        retry:Hide()
        fix:Hide()
        refreshClaude()
    else
        showCopy(q, q.book and "kniha" or "rozhovor")
    end
end

-- Co hráč viděl (pro ruční kvalitní překlad správcem/Claudem): WoWpoCeskuSeen (SavedVariables)
local SEEN_MAX = 2000
local function markSeen(q)
    WoWpoCeskuSeen = WoWpoCeskuSeen or { q = {}, g = {} }
    WoWpoCeskuSeen.q = WoWpoCeskuSeen.q or {}
    WoWpoCeskuSeen.g = WoWpoCeskuSeen.g or {}
    local list, key = WoWpoCeskuSeen.q, q.id
    if q.kind == "gossip" then list, key = WoWpoCeskuSeen.g, gossipKey(q.gossip) end
    if list[key] then return end
    local n = 0
    for _ in pairs(list) do n = n + 1 end
    if n < SEEN_MAX then list[key] = time() end
end

local function showQuest(q, source)
    if not q then return end
    markSeen(q)
    currentQuest = q
    panel.quest = q
    panel.source = source
    placePanel(source)
    panel:Show()
    if q.kind == "gossip" then
        showGossip(q)
    elseif isTranslated(q) then
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
events:RegisterEvent("GOSSIP_SHOW")
events:RegisterEvent("GOSSIP_CLOSED")
events:RegisterEvent("ITEM_TEXT_READY")
events:RegisterEvent("ITEM_TEXT_CLOSED")
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == "WoWpoCesku" then
            WoWpoCeskuSettings = WoWpoCeskuSettings or {}
            if WoWpoCeskuSettings.enabled == nil then WoWpoCeskuSettings.enabled = true end
            if WoWpoCeskuSettings.autofocus == nil then WoWpoCeskuSettings.autofocus = true end
            applyLayout()
            cleanQueue()
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

    if event == "ITEM_TEXT_CLOSED" then
        if panel.source == "book" then
            edit:ClearFocus()
            panel:Hide()
        end
        return
    end

    if event == "GOSSIP_CLOSED" then
        if panel.source == "gossip" then
            edit:ClearFocus()
            panel:Hide()
        end
        return
    end

    if not WoWpoCeskuSettings.enabled then return end
    if event == "GOSSIP_SHOW" then
        if WoWpoCeskuSettings.gossip ~= false then showQuest(gatherGossip(), "gossip") end
        return
    end
    if event == "ITEM_TEXT_READY" then
        if WoWpoCeskuSettings.books ~= false then showQuest(gatherBook(), "book") end
        return
    end
    if WoWpoCeskuSettings.quests ~= false then showQuest(gatherDialog(event), "dialog") end
end)

-------------------------------------------------------------------------------
-- Nastavení ve hře (Options -> AddOns -> WoWpoCesku) a ikona u minimapy
-------------------------------------------------------------------------------
local labelFont = CreateFont("WoWpoCeskuLabelFont")
labelFont:SetFont(FONT, 13, "")
labelFont:SetTextColor(1, 1, 1)
local headFont = CreateFont("WoWpoCeskuHeadFont")
headFont:SetFont(FONT, 18, "")
headFont:SetTextColor(1, 0.82, 0)
local noteFont = CreateFont("WoWpoCeskuNoteFont")
noteFont:SetFont(FONT, 11, "")
noteFont:SetTextColor(0.7, 0.7, 0.7)

local minimapButton
local function setEnabled(on)
    WoWpoCeskuSettings.enabled = on
    if not on then panel:Hide() end
end

local function setFontSize(size)
    WoWpoCeskuSettings.fontSize = math.max(10, math.min(20, math.floor(size)))
    applyLayout()
    if panel:IsShown() and currentQuest then showQuest(currentQuest, panel.source) end
end

local options = CreateFrame("Frame", "WoWpoCeskuOptions")
options.name = "WoWpoCesku"
options:Hide()

local optionWidgets = {}
local function refreshOptions()
    for _, w in ipairs(optionWidgets) do w:Refresh() end
end

-- Rozložení: dva sloupce se sekcemi; každý sloupec si pamatuje, kde skončil (col.y)
local COL_W = 300   -- přepočítá se podle skutečné šířky okna nastavení
local function newColumn(x) return { x = x, y = -92 } end

local content   -- posuvný obsah nastavení (vznikne v buildOptions)
local function addSection(col, title)
    col.y = col.y - 6
    local t = content:CreateFontString(nil, "ARTWORK")
    t:SetFontObject(labelFont)
    t:SetTextColor(1, 0.82, 0)
    t:SetPoint("TOPLEFT", col.x, col.y)
    t:SetText(title)
    local line = content:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 0.82, 0, 0.35)
    line:SetPoint("TOPLEFT", col.x, col.y - 18)
    line:SetSize(COL_W, 1)
    col.y = col.y - 26
end

local function addCheck(col, label, note, get, set)
    local cb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", col.x - 4, col.y + 2)
    local text = content:CreateFontString(nil, "ARTWORK")
    text:SetFontObject(labelFont)
    text:SetPoint("TOPLEFT", col.x + 28, col.y - 4)
    text:SetWidth(COL_W - 32)
    text:SetJustifyH("LEFT")
    text:SetText(label)
    local h = text:GetStringHeight() + 4
    if note then
        local n = content:CreateFontString(nil, "ARTWORK")
        n:SetFontObject(noteFont)
        n:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -2)
        n:SetWidth(COL_W - 32)
        n:SetJustifyH("LEFT")
        n:SetText(note)
        h = h + n:GetStringHeight() + 2
    end
    col.y = col.y - math.max(28, h + 10)
    cb:SetScript("OnClick", function(self) set(self:GetChecked() and true or false) end)
    cb.Refresh = function(self) self:SetChecked(get()) end
    optionWidgets[#optionWidgets + 1] = cb
end

-- Předvolby: jedním klikem zapnout/vypnout celé skupiny (otevřené okno se obnoví)
local KRONIKA_KEYS = { "loreToast", "rareAlert", "npcNotes", "itemNotes", "mapPlaces", "sealBanner", "journal" }
function WoWpoCesku_ApplyPreset(name)
    local st = WoWpoCeskuSettings
    local vse = (name == "vse")
    local rozsireny = (name ~= "questy")   -- rozhovory, knihy, přehled úkolů
    st.enabled = true
    st.quests = true
    st.log = true
    st.gossip, st.books, st.ui = rozsireny, rozsireny, rozsireny
    st.lok = st.lok or {}
    for _, part in ipairs(WoWpoCesku_LokParts or {}) do st.lok[part.key] = vse end
    for _, k in ipairs(KRONIKA_KEYS) do st[k] = vse end
    if not rozsireny and (panel.source == "gossip" or panel.source == "book") then panel:Hide() end
    refreshOptions()
    if minimapButton then minimapButton:SetShown(st.minimap ~= false) end
    print("|cffffd100WoWpoCesku:|r predvolba pouzita. Zmeny v rozhrani hry se projevi po /reload.")
end

local function buildOptions()
    local scroll = CreateFrame("ScrollFrame", nil, options, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 0, -4)
    scroll:SetPoint("BOTTOMRIGHT", -28, 4)
    content = CreateFrame("Frame", nil, scroll)
    content:SetSize(((options:GetWidth() or 0) > 300 and options:GetWidth() or 640) - 30, 10)
    scroll:SetScrollChild(content)
    local head = content:CreateFontString(nil, "ARTWORK")
    head:SetFontObject(headFont)
    head:SetPoint("TOPLEFT", 16, -16)
    head:SetText("WoWpoČesku – nastavení")

    local presetLabel = content:CreateFontString(nil, "ARTWORK")
    presetLabel:SetFontObject(noteFont)
    presetLabel:SetPoint("TOPLEFT", 20, -50)
    presetLabel:SetText("Rychlé předvolby:")
    local prev
    for _, p in ipairs({ { "vse", "Vše česky" }, { "preklad", "Jen překlad" }, { "questy", "Jen questy" } }) do
        local b = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        b:SetSize(112, 22)
        if prev then b:SetPoint("LEFT", prev, "RIGHT", 6, 0) else b:SetPoint("LEFT", presetLabel, "RIGHT", 10, 0) end
        czButton(b)
        b:SetText(p[2])
        b:SetScript("OnClick", function() WoWpoCesku_ApplyPreset(p[1]) end)
        prev = b
    end
    local presetNote = content:CreateFontString(nil, "ARTWORK")
    presetNote:SetFontObject(noteFont)
    presetNote:SetPoint("TOPLEFT", 20, -74)
    presetNote:SetText("Jen překlad = questy, rozhovory, knihy a přehled úkolů. Jen questy = pouze texty questů. Vše česky = i rozhraní a Kronika.")

    -- dva stejně široké sloupce podle skutečné šířky okna (hra ho škáluje)
    local w = options:GetWidth()
    if not w or w < 300 then w = 640 end
    COL_W = math.floor((w - 70) / 2)
    local left, right = newColumn(20), newColumn(40 + COL_W)

    -- levý sloupec: překlad
    addSection(left, "Překlad")
    addCheck(left, "Překlad zapnutý", nil,
        function() return WoWpoCeskuSettings.enabled end, setEnabled)
    addCheck(left, "Překlad textu questů u NPC", "Okno s českým textem při přijetí a odevzdání questu",
        function() return WoWpoCeskuSettings.quests ~= false end,
        function(on) WoWpoCeskuSettings.quests = on; if not on and panel.source == "dialog" then panel:Hide() end end)
    addCheck(left, "Překlad v deníku questů (klávesa L)", nil,
        function() return WoWpoCeskuSettings.log ~= false end,
        function(on) WoWpoCeskuSettings.log = on end)
    addCheck(left, "Překlad rozhovorů s NPC", "Když NPC jen mluví (obchodníci, strážní…)",
        function() return WoWpoCeskuSettings.gossip ~= false end,
        function(on) WoWpoCeskuSettings.gossip = on; if not on and panel.source == "gossip" then panel:Hide() end end)
    addCheck(left, "Překlad knih, dopisů a cedulí", nil,
        function() return WoWpoCeskuSettings.books ~= false end,
        function(on) WoWpoCeskuSettings.books = on; if not on and panel.source == "book" then panel:Hide() end end)
    addCheck(left, "Čeština v přehledu úkolů a volbách u NPC",
        "Názvy questů, „Zabito: 3/10“, „Ukaž mi, kam můžu letět“… (po /reload)",
        function() return WoWpoCeskuSettings.ui ~= false end,
        function(on) WoWpoCeskuSettings.ui = on end)
    addCheck(left, "Automaticky označit text pro Ctrl+C", "U nového questu je text hned připravený ke zkopírování",
        function() return WoWpoCeskuSettings.autofocus end,
        function(on) WoWpoCeskuSettings.autofocus = on end)

    -- levý sloupec: rozhraní hry česky (Lokalizace.lua)
    addSection(left, "Rozhraní hry česky (po /reload)")
    for _, part in ipairs(WoWpoCesku_LokParts or {}) do
        addCheck(left, part.label, part.note and part.note:gsub("%s*%(projeví se po /reload%)", ""),
            function() return not (WoWpoCeskuSettings.lok and WoWpoCeskuSettings.lok[part.key] == false) end,
            function(on) WoWpoCeskuSettings.lok = WoWpoCeskuSettings.lok or {}; WoWpoCeskuSettings.lok[part.key] = on end)
    end

    -- pravý sloupec: Kronika Azerothu
    addSection(right, "Kronika Azerothu")
    addCheck(right, "Titulky při vstupu do oblasti", "Kniha jde otevřít vždy: klik na ikonu u minimapy nebo /czq lore",
        function() return WoWpoCeskuSettings.loreToast ~= false end,
        function(on) WoWpoCeskuSettings.loreToast = on end)
    addCheck(right, "Upozornění na vzácné moby", "Zvuk, nápis a cedulka; zapíše se kde a kdy (/czq vzacni)",
        function() return WoWpoCeskuSettings.rareAlert ~= false end,
        function(on) WoWpoCeskuSettings.rareAlert = on end)
    addCheck(right, "Poznámky k postavám u NPC", "Kdo je Thrall, Hogger, lady Prestor…",
        function() return WoWpoCeskuSettings.npcNotes ~= false end,
        function(on) WoWpoCeskuSettings.npcNotes = on end)
    addCheck(right, "Příběhy slavných předmětů", "Thunderfury, Atiesh, Corrupted Ashbringer…",
        function() return WoWpoCeskuSettings.itemNotes ~= false end,
        function(on) WoWpoCeskuSettings.itemNotes = on end)
    addCheck(right, "Místa a tajemství na mapě", "Značky Poutníkova deníku na velké mapě (M)",
        function() return WoWpoCeskuSettings.mapPlaces ~= false end,
        function(on) WoWpoCeskuSettings.mapPlaces = on end)
    addCheck(right, "Dungeonový deník otevře mapu", "Po kliknutí na Zobrazit na mapě se mapa otevře. Když hra hlásí chybu ADDON_ACTION_BLOCKED, vypni.",
        function() return WoWpoCeskuSettings.djOpenMap ~= false end,
        function(on) WoWpoCeskuSettings.djOpenMap = on end)
    addCheck(right, "Okno při získání pečeti", "Cedulka uprostřed obrazovky; pečeť se získá i bez ní",
        function() return WoWpoCeskuSettings.sealBanner ~= false end,
        function(on) WoWpoCeskuSettings.sealBanner = on end)
    addCheck(right, "Deník postavy (Tvůj příběh)", "Zapisuje, kde jsi byl, koho jsi potkal a co jsi dokázal",
        function() return WoWpoCeskuSettings.journal ~= false end,
        function(on) WoWpoCeskuSettings.journal = on end)
    addCheck(right, "Oznamovat nové pečetě guildě", "Do chatu guildy napíše, jakou pečeť jsi získal",
        function() return WoWpoCeskuSettings.sealGuild == true end,
        function(on) WoWpoCeskuSettings.sealGuild = on end)

    -- pravý sloupec: panel s překladem
    addSection(right, "Panel s překladem")
    local sizeLabel = content:CreateFontString(nil, "ARTWORK")
    sizeLabel:SetFontObject(labelFont)
    sizeLabel:SetPoint("TOPLEFT", right.x, right.y - 4)
    sizeLabel:SetText("Velikost písma:")
    local minus = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    minus:SetSize(26, 22)
    minus:SetPoint("LEFT", sizeLabel, "RIGHT", 12, 0)
    minus:SetText("-")
    local value = content:CreateFontString(nil, "ARTWORK")
    value:SetFontObject(labelFont)
    value:SetPoint("LEFT", minus, "RIGHT", 8, 0)
    value:SetWidth(24)
    local plus = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    plus:SetSize(26, 22)
    plus:SetPoint("LEFT", value, "RIGHT", 8, 0)
    plus:SetText("+")
    value.Refresh = function(self) self:SetText(WoWpoCeskuSettings.fontSize or DEFAULT_FONT_SIZE) end
    optionWidgets[#optionWidgets + 1] = value
    minus:SetScript("OnClick", function() setFontSize((WoWpoCeskuSettings.fontSize or DEFAULT_FONT_SIZE) - 1); value:Refresh() end)
    plus:SetScript("OnClick", function() setFontSize((WoWpoCeskuSettings.fontSize or DEFAULT_FONT_SIZE) + 1); value:Refresh() end)
    right.y = right.y - 36

    local reset = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    reset:SetSize(230, 24)
    reset:SetPoint("TOPLEFT", right.x, right.y)
    czButton(reset)
    reset:SetText("Vrátit panel na výchozí místo")
    reset:SetScript("OnClick", function() WoWpoCeskuSettings.pos = nil; if panel:IsShown() then placePanel(panel.source) end end)
    right.y = right.y - 40

    -- pravý sloupec: ostatní
    addSection(right, "Ostatní")
    addCheck(right, "Ikona u minimapy", "Klik = Kronika, Ctrl+klik = nastavení, pravý klik = překlad zap/vyp",
        function() return WoWpoCeskuSettings.minimap ~= false end,
        function(on) WoWpoCeskuSettings.minimap = on; if minimapButton then minimapButton:SetShown(on) end end)

    local help = content:CreateFontString(nil, "ARTWORK")
    help:SetFontObject(noteFont)
    help:SetPoint("TOPLEFT", right.x, right.y - 8)
    help:SetWidth(COL_W)
    help:SetJustifyH("LEFT")
    help:SetSpacing(2)
    help:SetText("Nové questy překládá Pomocník na počítači (Spustit pomocnika.bat). "
        .. "Panel s překladem jde přetáhnout myší.\nPříkazy do chatu: /czq nastaveni, /czq stav, /czq lore, /czq dungeon, /czq vzacni")
    content:SetHeight(math.max(-left.y, -right.y + help:GetStringHeight()) + 50)
end

options:SetScript("OnShow", function(self)
    if not self.built then buildOptions(); self.built = true end
    refreshOptions()
end)

local optionsCategory
local function registerOptions()
    if Settings and Settings.RegisterCanvasLayoutCategory then
        optionsCategory = Settings.RegisterCanvasLayoutCategory(options, "WoWpoCesku")
        Settings.RegisterAddOnCategory(optionsCategory)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(options)
    end
end

local function openOptions()
    if Settings and Settings.OpenToCategory and optionsCategory then
        Settings.OpenToCategory(optionsCategory:GetID())
    elseif InterfaceOptionsFrame_OpenToCategory then
        -- klasické rozhraní napoprvé otevře jen seznam, proto dvakrát
        InterfaceOptionsFrame_OpenToCategory(options)
        InterfaceOptionsFrame_OpenToCategory(options)
    end
end

-- Ikona u minimapy: levé kliknutí = nastavení, pravé = zapnout/vypnout, tažení = posun
local function placeMinimapButton()
    local angle = math.rad(WoWpoCeskuSettings.minimapAngle or 200)
    local r = (Minimap:GetWidth() / 2) + 10
    minimapButton:ClearAllPoints()
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * r, math.sin(angle) * r)
end

local function createMinimapButton()
    if minimapButton or not Minimap then return end
    minimapButton = CreateFrame("Button", "WoWpoCeskuMinimapButton", Minimap)
    minimapButton:SetSize(31, 31)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetFrameLevel(8)
    local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 1)
    local border = minimapButton:CreateTexture(nil, "OVERLAY")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT")
    minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    minimapButton:RegisterForDrag("LeftButton")
    minimapButton:SetScript("OnClick", function(_, button)
        if IsShiftKeyDown() then
            ReloadUI()   -- načíst nové překlady
        elseif IsControlKeyDown() then
            openOptions()
        elseif button == "RightButton" then
            setEnabled(not WoWpoCeskuSettings.enabled)
            print("|cffffd100WoWpoCesku:|r preklad " .. (WoWpoCeskuSettings.enabled and "ZAPNUT" or "VYPNUT"))
        elseif WoWpoCeskuLore and WoWpoCeskuLore:IsShown() then
            WoWpoCeskuLore:Hide()   -- druhý klik knihu zavře
        elseif WoWpoCesku_ShowLore then
            WoWpoCesku_ShowLore()   -- Kronika Azerothu pro aktuální oblast
        else
            openOptions()
        end
    end)
    minimapButton:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            WoWpoCeskuSettings.minimapAngle = math.deg(math.atan2(cy / scale - my, cx / scale - mx))
            placeMinimapButton()
        end)
    end)
    minimapButton:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
    -- Tooltip bez diakritiky (písmo tooltipu ji neumí)
    minimapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("WoWpoCesku")
        GameTooltip:AddLine("Levy klik: Kronika Azerothu", 1, 1, 1)
        GameTooltip:AddLine("Pravy klik: preklad zapnout / vypnout", 1, 1, 1)
        GameTooltip:AddLine("Shift+klik: nacist nove preklady (/reload)", 1, 1, 1)
        GameTooltip:AddLine("Ctrl+klik: nastaveni", 1, 1, 1)
        local n = 0
        for _ in pairs(WoWpoCeskuQueue or {}) do n = n + 1 end
        if n > 0 then GameTooltip:AddLine(("Ceka na preklad: %d textu"):format(n), 1, 0.82, 0) end
        GameTooltip:AddLine("Tazenim posunes ikonu", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    minimapButton:SetScript("OnLeave", GameTooltip_Hide)
    placeMinimapButton()
    minimapButton:SetShown(WoWpoCeskuSettings.minimap ~= false)
end

-- Úvodní okno (poprvé po instalaci, jinak /czq uvod)
local welcome
local function showWelcome()
    WoWpoCeskuSettings.welcomed = 1
    if welcome then welcome:Show() return end
    local INK = { 0.20, 0.13, 0.07 }
    local f = CreateFrame("Frame", "WoWpoCeskuUvod", UIParent, "BackdropTemplate")
    welcome = f
    f:SetSize(540, 520)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 },
    })
    f:SetBackdropColor(0.23, 0.13, 0.07, 1)
    local tex = f:CreateTexture(nil, "BACKGROUND", nil, 1)
    tex:SetPoint("TOPLEFT", 11, -11)
    tex:SetPoint("BOTTOMRIGHT", -11, 11)
    tex:SetTexture("Interface\\AddOns\\WoWpoCesku\\Textures\\pergamen.tga")
    f:EnableMouse(true)
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)

    local last
    local function text(str, size, r, g, b, gap, justify)
        local t = f:CreateFontString(nil, "OVERLAY")
        t:SetFont(FONT, size, "")
        t:SetTextColor(r, g, b)
        t:SetWidth(490)
        t:SetJustifyH(justify or "LEFT")
        t:SetSpacing(2)
        if last then t:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -(gap or 8)) else t:SetPoint("TOPLEFT", 25, -30) end
        t:SetText(str)
        last = t
        return t
    end
    text("Vítej v WoWpoČesku", 24, 0.50, 0.12, 0.05, 0, "CENTER")
    text("čeština pro WoW: Forever", 13, 0.42, 0.30, 0.18, 2, "CENTER")
    text("Addon ukazuje české překlady questů, rozhovorů s NPC, knih a části rozhraní. "
        .. "K tomu přidává Kroniku Azerothu: letopis oblastí, pečetě (jako achievementy), deník tvé postavy a zkoušku kronikáře. "
        .. "Kniha se otevře klikem na ikonu u minimapy.", 13, INK[1], INK[2], INK[3], 16)
    text("Nepřeložený text?", 15, 0.50, 0.12, 0.05, 16)
    text("V balíčku jsou tisíce hotových překladů. Nový, zatím nepřeložený text zůstane anglicky a addon si ho zapamatuje. "
        .. "Přeložit ho umí volitelný Pomocník (program pro Windows, zdarma). Najdeš ho na stránce projektu na GitHubu:",
        13, INK[1], INK[2], INK[3], 6)
    local url = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    url:SetSize(300, 22)
    url:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 6, -8)
    url:SetAutoFocus(false)
    url:SetFont(FONT, 12, "")
    local URL = "https://github.com/RankonRP/WoWpoCesku"
    url:SetText(URL)
    url:SetCursorPosition(0)
    url:SetScript("OnTextChanged", function(self) if self:GetText() ~= URL then self:SetText(URL) end end)
    url:SetScript("OnEscapePressed", url.ClearFocus)
    local hint = f:CreateFontString(nil, "OVERLAY")
    hint:SetFont(FONT, 11, "")
    hint:SetTextColor(0.42, 0.30, 0.18)
    hint:SetPoint("LEFT", url, "RIGHT", 10, 0)
    hint:SetText("klik + Ctrl+C zkopíruje odkaz")
    last = url
    text("Chceš jen část češtiny?", 15, 0.50, 0.12, 0.05, 18)
    text("Vyber předvolbu. Všechno si pak můžeš upravit v nastavení (Esc > Možnosti > AddOns, nebo Ctrl+klik na ikonu u minimapy). "
        .. "Tento úvod otevřeš znovu příkazem /czq uvod.", 13, INK[1], INK[2], INK[3], 6)

    local prev
    for _, p in ipairs({ { "vse", "Vše česky" }, { "preklad", "Jen překlad" }, { "questy", "Jen questy" } }) do
        local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        b:SetSize(150, 26)
        if prev then b:SetPoint("LEFT", prev, "RIGHT", 8, 0) else b:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -14) end
        czButton(b)
        b:SetText(p[2])
        b:SetScript("OnClick", function() WoWpoCesku_ApplyPreset(p[1]); f:Hide() end)
        prev = b
    end
    local cap = f:CreateFontString(nil, "OVERLAY")
    cap:SetFont(FONT, 11, "")
    cap:SetTextColor(0.42, 0.30, 0.18)
    cap:SetWidth(490)
    cap:SetJustifyH("LEFT")
    cap:SetSpacing(2)
    cap:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", -316, -8)
    cap:SetText("Vše česky: i rozhraní hry a Kronika. Jen překlad: questy, rozhovory, knihy a přehled úkolů. Jen questy: pouze texty questů.")

    local opt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    opt:SetSize(180, 26)
    opt:SetPoint("BOTTOMLEFT", 25, 24)
    czButton(opt)
    opt:SetText("Otevřít nastavení")
    opt:SetScript("OnClick", function() f:Hide(); openOptions() end)
    local ok = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    ok:SetSize(120, 26)
    ok:SetPoint("BOTTOMRIGHT", -25, 24)
    czButton(ok)
    ok:SetText("Zavřít")
    ok:SetScript("OnClick", function() f:Hide() end)
end

local setupFrame = CreateFrame("Frame")
setupFrame:RegisterEvent("PLAYER_LOGIN")
setupFrame:SetScript("OnEvent", function()
    registerOptions()
    createMinimapButton()
    if not WoWpoCeskuSettings.welcomed then C_Timer.After(5, showWelcome) end
    -- Nová verze hry (patch) -> questy se mohly změnit, doporučit nový sken
    local _, build = GetBuildInfo()
    if WoWpoCeskuSettings.gameBuild and WoWpoCeskuSettings.gameBuild ~= build then
        C_Timer.After(6, function()
            print(("|cffffd100WoWpoCesku:|r hra se aktualizovala (sestaveni %s). Questy se mohly zmenit – doporucujeme /czq sber znovu."):format(tostring(build)))
        end)
    end
    WoWpoCeskuSettings.gameBuild = build
    -- Připomenout, když ve frontě zůstaly nepřeložené texty
    local n = 0
    for _ in pairs(WoWpoCeskuQueue or {}) do n = n + 1 end
    if n > 0 then
        C_Timer.After(5, function()
            print(("|cffffd100WoWpoCesku:|r %d textu ceka na preklad. Pomocnik je prelozi – pak Shift+klik na ikonu knihy (nebo /reload)."):format(n))
        end)
    end
end)

-------------------------------------------------------------------------------
-- Sběr questů (/czq sber): postupně požádá server o informace ke všem questům.
-- Hra je uloží do mezipaměti (Cache\WDB\enUS\questcache.wdb) a Pomocník / správce je
-- odtud přeloží. Průběh se ukládá, takže po přerušení pokračuje, kde skončil.
-------------------------------------------------------------------------------
local SCAN_RANGES = { { 1, 10000 }, { 85000, 105000 } }   -- klasické questy + nové z Forever
local SCAN_PER_TICK, SCAN_TICK = 3, 0.2                     -- = 15 dotazů za vteřinu
local scan = { running = false, sent = 0, found = 0 }

local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end

local function scanTotal()
    local n = 0
    for _, r in ipairs(SCAN_RANGES) do n = n + (r[2] - r[1] + 1) end
    return n
end

local function scanDone()
    local d = 0
    local st = WoWpoCeskuSettings.scan
    for i, r in ipairs(SCAN_RANGES) do
        if i < st.range then d = d + (r[2] - r[1] + 1)
        elseif i == st.range then d = d + (st.id - r[1]) end
    end
    return d
end

local function scanStep()
    if not scan.running then return end
    local st = WoWpoCeskuSettings.scan
    for _ = 1, SCAN_PER_TICK do
        local r = SCAN_RANGES[st.range]
        if not r then
            scan.running = false
            say(("sber HOTOV – server vratil %d questu. Ted se ODHLAS nebo ukonci hru (hra pak ulozi mezipamet) a napis Claudovi."):format(scan.found))
            return
        end
        C_QuestLog.RequestLoadQuestByID(st.id)
        scan.sent = scan.sent + 1
        st.id = st.id + 1
        if st.id > r[2] then
            st.range = st.range + 1
            if SCAN_RANGES[st.range] then st.id = SCAN_RANGES[st.range][1] end
        end
    end
    if scan.sent % 1500 == 0 then
        local pct = math.floor(scanDone() / scanTotal() * 100)
        say(("sber: %d %% (nalezeno %d questu, zastavit: /czq sber stop)"):format(pct, scan.found))
    end
    C_Timer.After(SCAN_TICK, scanStep)
end

local scanEvents = CreateFrame("Frame")
scanEvents:RegisterEvent("QUEST_DATA_LOAD_RESULT")
scanEvents:SetScript("OnEvent", function(_, _, questID, success)
    if scan.running and success then scan.found = scan.found + 1 end
end)

local function scanCommand(arg)
    if not (C_QuestLog and C_QuestLog.RequestLoadQuestByID) then
        say("tahle verze hry sber questu neumi.")
        return
    end
    if arg == "stop" then
        scan.running = false
        say("sber pozastaven. Pokracovat: /czq sber")
        return
    end
    if arg == "znovu" or not WoWpoCeskuSettings.scan then
        WoWpoCeskuSettings.scan = { range = 1, id = SCAN_RANGES[1][1] }
    end
    if scan.running then say("sber uz bezi.") return end
    if not SCAN_RANGES[WoWpoCeskuSettings.scan.range] then
        say("sber uz je hotovy. Od zacatku: /czq sber znovu")
        return
    end
    scan.running, scan.sent, scan.found = true, 0, 0
    local left = scanTotal() - scanDone()
    say(("sber questu spusten (%d cisel, asi %d minut). Muzes normalne hrat. Zastavit: /czq sber stop"):format(
        left, math.ceil(left / (SCAN_PER_TICK / SCAN_TICK) / 60)))
    scanStep()
end

-------------------------------------------------------------------------------
-- Příkazy: /czq (zprávy do chatu bez diakritiky – písmo chatu ji nemusí umět)
-------------------------------------------------------------------------------
SLASH_CZQUESTS1 = "/czq"
SLASH_CZQUESTS2 = "/wpc"
SlashCmdList.CZQUESTS = function(msg)
    msg = (msg or ""):lower()
    local cmd, arg = msg:match("^(%S*)%s*(.-)$")
    local function say(s) print("|cffffd100WoWpoCesku:|r " .. s) end
    if cmd == "sber" then
        scanCommand(arg)
    elseif cmd == "lore" or cmd == "pribeh" then
        WoWpoCesku_LoreCommand(arg)
    elseif cmd == "oznacene" then
        local n = WoWpoCesku_FlagCount and WoWpoCesku_FlagCount() or 0
        print("|cffffd100WoWpoCesku:|r oznaceno pro Clauda: " .. n .. (n > 0 and " - napis /reload a rekni Claudovi, ze ma prelozit oznacene" or ""))
    elseif cmd == "pecete" then
        if WoWpoCesku_SealDebug then WoWpoCesku_SealDebug() end
    elseif cmd == "vzacni" or cmd == "rare" then
        if WoWpoCesku_RareCommand then WoWpoCesku_RareCommand(arg) end
    elseif cmd == "vypis" then
        local n = WoWpoCesku_DumpStrings and WoWpoCesku_DumpStrings() or 0
        local t = WoWpoCesku_QueueAllTalents and WoWpoCesku_QueueAllTalents() or 0
        say(("ulozeno %d textu rozhrani, %d textu talentu k prekladu. Napis /reload (nebo se odhlas)."):format(n, t))
    elseif cmd == "dungeon" or cmd == "dungy" or cmd == "dj" then
        if WoWpoCesku_DungeonJournal then WoWpoCesku_DungeonJournal() end
    elseif cmd == "obr" then
        if WoWpoCesku_ArtTest then WoWpoCesku_ArtTest() end
    elseif cmd == "mapa2" then
        if WoWpoCesku_MapList then WoWpoCesku_MapList(arg) end
    elseif cmd == "mapa" then
        if WoWpoCesku_MapDebug then WoWpoCesku_MapDebug(arg ~= "" and arg or nil) end
    elseif cmd == "uvod" or cmd == "úvod" then
        showWelcome()
    elseif cmd == "nastaveni" or cmd == "nastavení" or cmd == "config" then
        openOptions()
    elseif cmd == "reset" then
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
    elseif cmd == "rozhovory" then
        WoWpoCeskuSettings.gossip = (WoWpoCeskuSettings.gossip == false)
        if not WoWpoCeskuSettings.gossip and panel.source == "gossip" then panel:Hide() end
        say("preklad rozhovoru s NPC " .. (WoWpoCeskuSettings.gossip and "ZAPNUT" or "VYPNUT"))
    elseif cmd == "stav" then
        local n, g = 0, 0
        for _ in pairs(WoWpoCesku_Data) do n = n + 1 end
        for _ in pairs(WoWpoCesku_Gossip) do g = g + 1 end
        say(("prelozenych questu: %d, rozhovoru: %d"):format(n, g))
    elseif cmd == "info" then
        hookQuestLog()
        say(("denik: klasicky=%s, v mape=%s | vybrany quest: %s"):format(
            tostring(hookedLog.classic or false), tostring(hookedLog.map or false),
            tostring((selectedLogQuest()))))
        if WoWpoCesku_TrackerInfo then say(WoWpoCesku_TrackerInfo()) end
        if WoWpoCesku_TalentDebug then say(WoWpoCesku_TalentDebug()) end
    else
        WoWpoCeskuSettings.enabled = not WoWpoCeskuSettings.enabled
        if not WoWpoCeskuSettings.enabled then panel:Hide() end
        say("preklad " .. (WoWpoCeskuSettings.enabled and "ZAPNUT" or "VYPNUT")
            .. "   (nastaveni: /czq nastaveni nebo ikona u minimapy)")
    end
end
