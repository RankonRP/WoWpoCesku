-- WoWpoCesku: čeština v rozhraní hry
--  * české názvy questů (přehled úkolů, seznam v deníku, nabídka questů u NPC)
--  * úkoly v přehledu na obrazovce ("Kobold Vermin slain: 3/10" -> "Zabito – Kobold Vermin: 3/10")
--  * běžná tlačítka v rozhovoru s NPC (obchod, let, hostinec, výcvik…)
-- Bere překlady z WoWpoCesku_Data (Data.lua). Vypíná se v nastavení (WoWpoCeskuSettings.ui = false).

local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"

-- Běžné volby v rozhovoru s NPC (přesný anglický text -> česky). Klidně doplňuj.
local GOSSIP_OPTIONS = {
    ["I want to browse your goods."] = "Chci si prohlédnout tvoje zboží.",
    ["Let me browse your goods."] = "Ukaž mi svoje zboží.",
    ["I'd like to browse your goods."] = "Rád bych si prohlédl tvoje zboží.",
    ["I would like to buy from you."] = "Chci od tebe něco koupit.",
    ["Show me where I can fly."] = "Ukaž mi, kam můžu letět.",
    ["I need a ride."] = "Potřebuju odvoz.",
    ["Make this inn your home."] = "Chci mít domov v tomhle hostinci.",
    ["What can I do at an inn?"] = "Co se dá dělat v hostinci?",
    ["I would like to check my deposit box."] = "Chci se podívat do své bankovní schránky.",
    ["Train me."] = "Vycvič mě.",
    ["I would like to train."] = "Chci se učit.",
    ["I seek training."] = "Hledám výcvik.",
    ["I require training."] = "Potřebuju výcvik.",
    ["I wish to unlearn my talents."] = "Chci zapomenout svoje talenty.",
    ["I would like to reset my talents."] = "Chci resetovat svoje talenty.",
    ["I'd like to stable my pet here."] = "Chci tu ustájit svého mazlíčka.",
    ["I want to stable my pet."] = "Chci ustájit svého mazlíčka.",
    ["I want to create a guild crest."] = "Chci vytvořit znak cechu.",
    ["How do I form a guild?"] = "Jak se zakládá cech?",
    ["I would like to purchase a guild charter."] = "Chci koupit zakládací listinu cechu.",
    ["I would like to go to the battleground."] = "Chci jít na bojiště.",
    ["Return me to life."] = "Vrať mě mezi živé.",
    ["Bring me back to life."] = "Přiveď mě zpátky k životu.",
    ["I would like to rent a mount."] = "Chci si půjčit jízdní zvíře.",
    ["Goodbye."] = "Sbohem.",
    ["Goodbye"] = "Sbohem",
    ["Farewell."] = "Sbohem.",
    ["Nevermind."] = "Nic, nevadí.",
    ["I have some questions."] = "Mám pár otázek.",
    ["Tell me more."] = "Řekni mi víc.",
    ["Tell me more about this place."] = "Řekni mi víc o tomhle místě.",
    ["Where can I find the bank?"] = "Kde najdu banku?",
    ["Where can I find the auction house?"] = "Kde najdu aukční síň?",
    ["Where is the inn?"] = "Kde je hostinec?",
    ["Where is the flight master?"] = "Kde je správce letů?",
    ["Where is the class trainer?"] = "Kde je učitel mého povolání?",
    ["Where is the profession trainer?"] = "Kde je učitel profesí?",
    ["Where is the mailbox?"] = "Kde je poštovní schránka?",
    ["Where is the stable master?"] = "Kde je správce stájí?",
    ["Where is the battlemaster?"] = "Kde je mistr bojišť?",
}

-- Volby se jménem povolání/profese ("I am interested in mage training.")
local GOSSIP_PATTERNS = {
    { "^I am interested in (.+) training%.$", "Mám zájem o výcvik: %1." },
    { "^I would like to train in (.+)%.$", "Chci se učit: %1." },
    { "^I seek (.+) training%.$", "Hledám výcvik: %1." },
    { "^Teach me the ways of the (.+)%.$", "Nauč mě cestu – %1." },
}

-- Úkoly v přehledu (anglický klient)
local OBJECTIVE_PATTERNS = {
    { "^(.-) slain: (%d+)/(%d+)(.*)$", "Zabito – %1: %2/%3%4" },
    { "^(.-) killed: (%d+)/(%d+)(.*)$", "Zabito – %1: %2/%3%4" },
    -- moderní přehled píše počet na začátek: "0/10 Kobold Vermin slain"
    { "^(%d+)/(%d+) (.-) slain(.*)$", "%1/%2 zabito – %3%4" },
    { "^(%d+)/(%d+) (.-) killed(.*)$", "%1/%2 zabito – %3%4" },
}
local OBJECTIVE_REPLACE = {
    { "%(Complete%)", "(splněno)" },
    { "%(Failed%)", "(nesplněno)" },
    { "^Complete$", "Splněno" },
    { "Ready for turn%-in", "Hotovo – odevzdej" },
    { "^Zabito – Players:", "Zabito hráčů:" },
}

-------------------------------------------------------------------------------
local function simplify(s)
    return ((s or ""):lower():gsub("[%s%p]", ""))
end

local fromToken = function(s) return WoWpoCesku_FromToken and WoWpoCesku_FromToken(s) or s end

-- Anglický název questu -> český (sestaví se jednou z Data.lua)
local titleMap
local function buildTitleMap()
    titleMap = {}
    for _, tr in pairs(WoWpoCesku_Data or {}) do
        if tr.en and tr.title then titleMap[simplify(tr.en)] = tr.title end
    end
end

local gossipLower = {}
for en, cs in pairs(GOSSIP_OPTIONS) do gossipLower[en:lower()] = cs end

-- Přeloží jeden řádek rozhraní; vrací nil, když nic nezná
local function translateLine(text)
    if not titleMap then buildTitleMap() end
    local trimmed = text:gsub("^%s+", ""):gsub("%s+$", "")

    -- Volba v rozhovoru
    local opt = gossipLower[trimmed:lower()]
    if opt then return opt end
    for _, p in ipairs(GOSSIP_PATTERNS) do
        if trimmed:find(p[1]) then return (trimmed:gsub(p[1], p[2])) end
    end

    -- Název questu (případně s předponou "[12] ", "- " nebo barvou)
    local prefix, core = trimmed:match("^(%[[^%]]*%]%s*)(.+)$")
    if not core then prefix, core = trimmed:match("^([%-%s]*)(.+)$") end
    if core then
        core = core:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        local cs = titleMap[simplify(core)]
        if cs then return prefix .. fromToken(cs) end
    end

    -- Úkol v přehledu (klasický přehled má na začátku " - ", ten zachovat)
    local lead, body = trimmed:match("^([%-%s]*)(.*)$")
    local out, changed = body, false
    for _, p in ipairs(OBJECTIVE_PATTERNS) do
        if out:find(p[1]) then out = out:gsub(p[1], p[2]); changed = true; break end
    end
    for _, r in ipairs(OBJECTIVE_REPLACE) do
        local n
        out, n = out:gsub(r[1], r[2])
        if n > 0 then changed = true end
    end
    if changed then return lead .. out end
end

-- Výměna písma: výchozí písma WoW nemají č/ř/ů. Velikost a styl zachovat.
local function setCzech(fs, text)
    local _, size, flags = fs:GetFont()
    if not size then return end
    fs:SetFont(FONT, size, flags or "")
    fs:SetText(text)
end

local function translateFrame(frame, depth)
    if not frame or depth > 14 or not frame:IsVisible() then return end
    for _, region in ipairs({ frame:GetRegions() }) do
        if region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and text ~= "" and not text:find("|T") then
                local cs = translateLine(text)
                if cs and cs ~= text then setCzech(region, cs) end
            end
        end
    end
    for _, child in ipairs({ frame:GetChildren() }) do translateFrame(child, depth + 1) end
end

local function enabled()
    return WoWpoCeskuSettings and WoWpoCeskuSettings.enabled and WoWpoCeskuSettings.ui ~= false
end

-- Obnovení se spojuje (hra aktualizuje přehled i několikrát za snímek)
local pending = {}
local function refresh(name)
    if pending[name] then return end
    pending[name] = true
    C_Timer.After(0.05, function()
        pending[name] = nil
        if not enabled() then return end
        local frame = _G[name]
        if name == "QuestMapFrame" then frame = QuestScrollFrame end
        translateFrame(frame, 0)
    end)
end

local TRACKERS = { "QuestWatchFrame", "WatchFrame", "ObjectiveTrackerFrame" }
local function refreshTrackers()
    for _, name in ipairs(TRACKERS) do
        if _G[name] then refresh(name) end
    end
end

local hooked = {}
local function hook(funcName, target)
    if hooked[funcName] or type(_G[funcName]) ~= "function" then return end
    hooksecurefunc(funcName, function() refresh(target) end)
    hooked[funcName] = true
end

local function hookAll()
    hook("QuestWatch_Update", "QuestWatchFrame")
    hook("WatchFrame_Update", "WatchFrame")
    hook("ObjectiveTracker_Update", "ObjectiveTrackerFrame")
    hook("QuestLog_Update", "QuestLogFrame")
    hook("QuestLogQuests_Update", "QuestMapFrame")
end

-- Moderní přehled úkolů (ObjectiveTracker) přepisuje texty ve vlastním cyklu, který se nedá
-- spolehlivě zachytit háčkem -> dokud je vidět, zkontrolovat ho dvakrát za vteřinu.
-- Mění se jen anglické texty, takže je to levné.
C_Timer.NewTicker(0.5, function()
    if not enabled() then return end
    for _, name in ipairs(TRACKERS) do
        local frame = _G[name]
        if frame and frame:IsVisible() then translateFrame(frame, 0) end
    end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("QUEST_LOG_UPDATE")
f:RegisterEvent("QUEST_WATCH_UPDATE")
f:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GOSSIP_SHOW")
f:RegisterEvent("QUEST_GREETING")
f:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" or event == "ADDON_LOADED" then
        hookAll()
        if event == "PLAYER_LOGIN" then titleMap = nil end
        return
    end
    if event == "GOSSIP_SHOW" then refresh("GossipFrame") return end
    if event == "QUEST_GREETING" then refresh("QuestFrame") return end
    refreshTrackers()
end)
