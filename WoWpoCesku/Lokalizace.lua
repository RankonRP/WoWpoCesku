-- WoWpoCesku: čeština v rozhraní hry (menu, tlačítka, …) po částech.
-- Každou část si hráč zapne/vypne v nastavení (WoWpoCeskuSettings.lok[část]).
--
-- Bezpečně: nemění texty uložené ve hře (GlobalStrings) – to by mohlo "zamořit" chráněné
-- části rozhraní (chyba "Interface action failed because of an AddOn"). Jen přepisuje
-- viditelný text, a to pouze tam, kde přesně zná anglický originál.

local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"

-------------------------------------------------------------------------------
-- Slovníky (přesný anglický text -> česky). Přeloženo ručně.
-------------------------------------------------------------------------------
local MENU = {
    -- Herní menu (Esc)
    ["Game Menu"] = "Herní menu",
    ["Main Menu"] = "Hlavní menu",
    ["Options"] = "Nastavení",
    ["Settings"] = "Nastavení",
    ["Support"] = "Podpora",
    ["Help"] = "Nápověda",
    ["Help Request"] = "Žádost o pomoc",
    ["Customer Support"] = "Zákaznická podpora",
    ["Shop"] = "Obchod",
    ["Store"] = "Obchod",
    ["What's New"] = "Novinky",
    ["Edit Mode"] = "Úprava rozložení",
    ["Macros"] = "Makra",
    ["AddOns"] = "Doplňky",
    ["Key Bindings"] = "Klávesové zkratky",
    ["Keybindings"] = "Klávesové zkratky",
    ["Interface"] = "Rozhraní",
    ["Video"] = "Obraz",
    ["Sound"] = "Zvuk",
    ["Log Out"] = "Odhlásit se",
    ["Logout"] = "Odhlásit se",
    ["Exit Game"] = "Ukončit hru",
    ["Quit"] = "Ukončit",
    ["Return to Game"] = "Zpět do hry",
    ["Ratings"] = "Hodnocení",
    -- Tlačítka na liště (popisky)
    ["Character Info"] = "Postava",
    ["Character"] = "Postava",
    ["Spellbook & Abilities"] = "Kniha kouzel a schopnosti",
    ["Spellbook"] = "Kniha kouzel",
    ["Talents"] = "Talenty",
    ["Specialization & Talents"] = "Specializace a talenty",
    ["Professions"] = "Profese",
    ["Achievements"] = "Úspěchy",
    ["Quest Log"] = "Deník questů",
    ["Map & Quest Log"] = "Mapa a deník questů",
    ["World Map"] = "Mapa světa",
    ["Guild & Communities"] = "Cech a komunity",
    ["Guild"] = "Cech",
    ["Social"] = "Přátelé",
    ["Friends"] = "Přátelé",
    ["Group Finder"] = "Hledání skupiny",
    ["Dungeon Finder"] = "Hledání dungeonu",
    ["Looking For Group"] = "Hledám skupinu",
    ["Player vs. Player"] = "Hráč proti hráči",
    ["PvP"] = "PvP",
    ["Collections"] = "Sbírky",
    ["Adventure Guide"] = "Průvodce dobrodružstvím",
    ["Bags"] = "Batohy",
    ["Backpack"] = "Batoh",
    -- Běžná tlačítka
    ["Accept"] = "Přijmout",
    ["Decline"] = "Odmítnout",
    ["Complete Quest"] = "Dokončit quest",
    ["Complete"] = "Dokončit",
    ["Continue"] = "Pokračovat",
    ["Goodbye"] = "Sbohem",
    ["Abandon"] = "Zahodit",
    ["Abandon Quest"] = "Zahodit quest",
    ["Share"] = "Sdílet",
    ["Share Quest"] = "Sdílet quest",
    ["Track"] = "Sledovat",
    ["Untrack"] = "Nesledovat",
    ["Back"] = "Zpět",
    ["Close"] = "Zavřít",
    ["Cancel"] = "Zrušit",
    ["Okay"] = "OK",
    ["Yes"] = "Ano",
    ["No"] = "Ne",
    ["Confirm"] = "Potvrdit",
    ["Apply"] = "Použít",
    ["Defaults"] = "Výchozí",
    ["Reset"] = "Obnovit",
    ["Delete"] = "Smazat",
    ["Rename"] = "Přejmenovat",
    ["Save"] = "Uložit",
    ["Send"] = "Odeslat",
    ["Reply"] = "Odpovědět",
    ["Next"] = "Další",
    ["Previous"] = "Předchozí",
    ["Prev"] = "Předch.",
    ["Buyback"] = "Zpětný odkup",
    ["Repair All"] = "Opravit vše",
    ["Merchant"] = "Obchodník",
    ["Inbox"] = "Pošta",
    ["Send Mail"] = "Poslat poštu",
    ["Open All"] = "Otevřít vše",
    ["Take All"] = "Vzít vše",
    ["Quest Objectives"] = "Úkoly questu",
    ["Description"] = "Popis",
    ["Rewards"] = "Odměny",
    ["You will receive:"] = "Obdržíš:",
    ["You will also receive:"] = "Obdržíš také:",
    ["You will be able to choose one of these rewards:"] = "Můžeš si vybrat jednu z těchto odměn:",
    ["Choose your reward:"] = "Vyber si odměnu:",
    ["Experience:"] = "Zkušenosti:",
    ["Required items:"] = "Požadované předměty:",
}

-- Talenty: okno a názvy větví všech povolání (ručně, podle voleb správce)
local TREES = {
    ["Holy"] = "Svatost", ["Protection"] = "Ochrana", ["Retribution"] = "Pomsta",
    ["Arms"] = "Zbraně", ["Fury"] = "Zuřivost",
    ["Arcane"] = "Arkána", ["Fire"] = "Oheň", ["Frost"] = "Mráz",
    ["Discipline"] = "Disciplína", ["Shadow"] = "Stín",
    ["Assassination"] = "Zabíjení", ["Combat"] = "Boj", ["Subtlety"] = "Lstivost",
    ["Beast Mastery"] = "Ovládání zvířat", ["Marksmanship"] = "Střelba", ["Survival"] = "Přežití",
    ["Affliction"] = "Utrpení", ["Demonology"] = "Démonologie", ["Destruction"] = "Zkáza",
    ["Balance"] = "Rovnováha", ["Feral Combat"] = "Divoký boj", ["Feral"] = "Divoký boj", ["Restoration"] = "Obnova",
    ["Elemental"] = "Živly", ["Enhancement"] = "Posílení",
}
local TALENT = {
    ["Talents"] = "Talenty",
    ["Primary"] = "Primární",
    ["Secondary"] = "Sekundární",
    ["Search"] = "Hledat",
    ["Unspent Talents"] = "Nevyužité body",
    ["Apply Changes"] = "Použít změny",
    ["Learn"] = "Naučit",
    ["Reset"] = "Obnovit",
    ["Reset Talents"] = "Obnovit talenty",
    ["Next Rank:"] = "Další úroveň:",
    ["Next rank:"] = "Další úroveň:",
    ["Click to learn"] = "Klikni pro naučení",
    ["Click to learn this talent"] = "Klikni pro naučení talentu",
}
for en, cs in pairs(TREES) do TALENT[en] = cs end

-- Pevné řádky popisků talentů se šablonou (čísla a názvy větví se dosadí)
local TALENT_PATTERNS = {
    { "^Rank (%d+)/(%d+)$", function(a, b) return ("Úroveň %s/%s"):format(a, b) end },
    { "^Requires (%d+) points? in (.+) Talents$", function(n, tree) return ("Vyžaduje %s bodů v talentech %s"):format(n, TREES[tree] or tree) end },
    { "^Requires (.+)$", function(x) return "Vyžaduje: " .. x end },
}

-- Části rozhraní: které okna patří ke které části a jaký slovník používají
local PARTS = {
    menu = {
        dict = MENU,
        frames = { "GameMenuFrame", "QuestFrame", "QuestLogFrame", "QuestMapFrame", "GossipFrame",
                   "MerchantFrame", "MailFrame", "StaticPopup1", "StaticPopup2", "StaticPopup3", "StaticPopup4" },
        tooltip = true,   -- popisky tlačítek na liště
    },
    talenty = {
        dict = TALENT,
        frames = { "PlayerTalentFrame", "TalentFrame", "ClassTalentFrame", "PlayerSpellsFrame" },
    },
}

-------------------------------------------------------------------------------
local function enabled(part)
    local s = WoWpoCeskuSettings
    return s and s.enabled and s.lok and s.lok[part] ~= false
end

-- Výměna písma (výchozí písma WoW nemají č/ř/ů); velikost a styl zachovat
local function setCzech(fs, text)
    local _, size, flags = fs:GetFont()
    if not size then return end
    fs:SetFont(FONT, size, flags or "")
    fs:SetText(text)
end

-- Přeloží text, pokud ho slovník přesně zná. Zachová barvu a klávesovou zkratku na konci,
-- např. "Character Info |cffffd200(C)|r" -> "Postava |cffffd200(C)|r".
local function lookup(dict, text)
    local cs = dict[text]
    if cs then return cs end
    local core, suffix = text:match("^(.-)(%s*|c%x%x%x%x%x%x%x%x%(.-%)|r)$")
    if not core then core, suffix = text:match("^(.-)(%s*%(.-%))$") end
    if core and dict[core] then return dict[core] .. suffix end
end

local function translateFrame(frame, dict, depth)
    if not frame or depth > 12 or not frame:IsVisible() then return end
    for _, region in ipairs({ frame:GetRegions() }) do
        if region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and text ~= "" then
                local cs = lookup(dict, text)
                if cs then setCzech(region, cs) end
            end
        end
    end
    for _, child in ipairs({ frame:GetChildren() }) do translateFrame(child, dict, depth + 1) end
end

local function translatePart(name, frame)
    if not enabled(name) then return end
    -- Hra často nastavuje texty až při zobrazení -> přeložit v příštím snímku
    C_Timer.After(0, function() translateFrame(frame, PARTS[name].dict, 0) end)
end

local hookedFrames = {}
local function hookFrames()
    for name, part in pairs(PARTS) do
        for _, frameName in ipairs(part.frames) do
            local frame = _G[frameName]
            if frame and not hookedFrames[frame] then
                frame:HookScript("OnShow", function(self) translatePart(name, self) end)
                hookedFrames[frame] = true
            end
        end
    end
end

-- Popisky (tooltipy) tlačítek na liště
local function translateTooltip(tip)
    -- Jen tlačítka na liště (MicroButton), ne předměty/kouzla se stejným názvem
    local owner = tip:GetOwner()
    local ownerName = owner and owner.GetName and owner:GetName() or ""
    if not (ownerName:find("Micro") or ownerName:find("MainMenu")) then return end
    for name, part in pairs(PARTS) do
        if part.tooltip and enabled(name) then
            for i = 1, math.min(tip:NumLines() or 0, 3) do
                local fs = _G[tip:GetName() .. "TextLeft" .. i]
                local text = fs and fs:GetText()
                local cs = text and lookup(part.dict, text)
                if cs then setCzech(fs, cs) end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- Talenty: popisky přes šablony. Čísla v textu -> {1}, {2}…, šablona se přeloží jednou
-- (Pomocník přes Google + pravidla, uloží do DataRozhrani.lua) a čísla se dosadí zpět.
-------------------------------------------------------------------------------
WoWpoCesku_UI = WoWpoCesku_UI or {}
local QUEUE_MAX = 600

local function plainText(s)
    return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", ""))
end

-- "Increases block by 10%." -> "Increases block by {1}%.", { "10" }
local function toTemplate(text)
    local nums = {}
    local key = text:gsub("%d+[%.,]?%d*", function(d)
        nums[#nums + 1] = d
        return "{" .. #nums .. "}"
    end)
    return key, nums
end

local function fromTemplate(cs, nums)
    return (cs:gsub("{(%d+)}", function(i) return nums[tonumber(i)] or "" end))
end

-- Nepřeložená šablona -> fronta pro Pomocníka (stejně jako nepřeložené questy)
local function queueUi(key)
    WoWpoCeskuQueue = WoWpoCeskuQueue or {}
    local qkey = "CZU#" .. key:sub(1, 60)
    if WoWpoCeskuQueue[qkey] then return end
    local n = 0
    for _ in pairs(WoWpoCeskuQueue) do n = n + 1 end
    if n < QUEUE_MAX then WoWpoCeskuQueue[qkey] = "CZU#1\n##ui\n" .. key end
end

-- Přeloží jeden řádek popisku talentu; nil = nechat (a případně zařadit do fronty)
local function translateTalentLine(text, queueMissing)
    local plain = plainText(text)
    if plain == "" or not plain:find("%a") then return nil end
    -- Zapamatovat si, co hráč viděl (šablona), pro ruční kvalitní překlad
    if queueMissing and not plain:find("[\128-\255]") then
        WoWpoCeskuSeen = WoWpoCeskuSeen or {}
        WoWpoCeskuSeen.u = WoWpoCeskuSeen.u or {}
        local key = (toTemplate(plain))
        if not WoWpoCeskuSeen.u[key] then WoWpoCeskuSeen.u[key] = time() end
    end
    local cs = lookup(TALENT, plain)
    if cs then return cs end
    for _, p in ipairs(TALENT_PATTERNS) do
        local a, b = plain:match(p[1])
        if a then return p[2](a, b) end
    end
    local key, nums = toTemplate(plain)
    cs = WoWpoCesku_UI[key]
    if cs then return fromTemplate(cs, nums) end
    -- Český text (už přeložený) nebo text jen z čísel nezařazovat
    if queueMissing and not plain:find("[\128-\255]") then queueUi(key) end
end

-- Patří vlastník popisku k oknu talentů? (tlačítka talentů nemusí mít vlastní jméno)
local function isTalentOwner(owner)
    local f = owner
    for _ = 1, 10 do
        if not f then return false end
        local name = f.GetName and f:GetName()
        if name and name:find("Talent") then return true end
        f = f.GetParent and f:GetParent()
    end
    return false
end

local function translateTalentTooltip(tip)
    if not enabled("talenty") then return end
    local owner = tip:GetOwner()
    if not owner or not isTalentOwner(owner) then return end
    for i = 1, tip:NumLines() or 0 do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local fs = _G[tip:GetName() .. side .. i]
            local text = fs and fs:IsShown() and fs:GetText()
            if text and text ~= "" then
                local cs = translateTalentLine(text, true)
                if cs then setCzech(fs, cs) end
            end
        end
    end
    tip:Show()   -- přepočítat velikost po změně textu
end

-- Okno talentů se může jmenovat různě -> po otevření ho najít podle textu "Unspent Talents"
local function findTalentFrame()
    for _, top in ipairs({ UIParent:GetChildren() }) do
        local ok, found = pcall(function()
            if not top:IsVisible() then return false end
            local name = top:GetName() or ""
            return name:find("Talent") ~= nil
        end)
        if ok and found then return top end
    end
end

local function translateTalentFrame()
    if not enabled("talenty") then return end
    C_Timer.After(0.05, function()
        for _, frameName in ipairs(PARTS.talenty.frames) do
            local fr = _G[frameName]
            if fr and fr:IsVisible() then translateFrame(fr, TALENT, 0) return end
        end
        local fr = findTalentFrame()
        if fr then
            translateFrame(fr, TALENT, 0)
            if not hookedFrames[fr] then
                fr:HookScript("OnShow", function(self) translatePart("talenty", self) end)
                hookedFrames[fr] = true
            end
        end
    end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_TALENT_UPDATE")
f:RegisterEvent("CHARACTER_POINTS_CHANGED")
f:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_TALENT_UPDATE" or event == "CHARACTER_POINTS_CHANGED" then
        translateTalentFrame()
        return
    end
    hookFrames()   -- některá okna patří do addonů Blizzardu, které se načítají později
    if type(ToggleTalentFrame) == "function" and not hookedFrames.toggleTalent then
        hooksecurefunc("ToggleTalentFrame", translateTalentFrame)
        hookedFrames.toggleTalent = true
    end
    if event == "PLAYER_LOGIN" then
        WoWpoCeskuSettings.lok = WoWpoCeskuSettings.lok or {}
        GameTooltip:HookScript("OnShow", translateTooltip)
        GameTooltip:HookScript("OnShow", translateTalentTooltip)
    end
end)

-- Pro okno nastavení: seznam částí a jejich názvy
WoWpoCesku_LokParts = {
    { key = "menu", label = "Menu, tlačítka a popisky na liště", note = "Herní menu (Esc), Accept/Decline, Yes/No… (projeví se po /reload)" },
    { key = "talenty", label = "Talenty", note = "Okno talentů, větve a popisky talentů (nové se přeloží přes Pomocníka)" },
}

-- /czq vypis: všechny talenty vlastního povolání do fronty k překladu (skrytý popisek)
function WoWpoCesku_QueueAllTalents()
    if not (GetNumTalentTabs and GetNumTalents and GetTalentInfo) then return 0 end
    local tip = WoWpoCeskuScanTip or CreateFrame("GameTooltip", "WoWpoCeskuScanTip", nil, "GameTooltipTemplate")
    local count = 0
    for tab = 1, GetNumTalentTabs() do
        for i = 1, GetNumTalents(tab) do
            tip:SetOwner(WorldFrame, "ANCHOR_NONE")
            local ok = pcall(tip.SetTalent, tip, tab, i)
            if ok then
                for l = 1, tip:NumLines() or 0 do
                    local fs = _G["WoWpoCeskuScanTipTextLeft" .. l]
                    local text = fs and fs:GetText()
                    if text and text ~= "" and not translateTalentLine(text, false) then
                        local plain = plainText(text)
                        if plain:find("%a") then queueUi((toTemplate(plain))); count = count + 1 end
                    end
                end
            end
            tip:Hide()
        end
    end
    return count
end

-------------------------------------------------------------------------------
-- /czq vypis: uloží všechny texty rozhraní hry (GlobalStrings) do WoWpoCeskuDump.
-- Po /reload je Claude přečte ze souboru SavedVariables a připraví další části překladu.
-------------------------------------------------------------------------------
function WoWpoCesku_DumpStrings()
    local dump, n = {}, 0
    for k, v in pairs(_G) do
        if type(k) == "string" and type(v) == "string" and k:match("^[A-Z][A-Z0-9_]+$") and #v > 0 and #v < 400 then
            dump[k] = v
            n = n + 1
        end
    end
    WoWpoCeskuDump = { build = select(2, GetBuildInfo()), strings = dump }
    return n
end
