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

-- Části rozhraní: které okna patří ke které části a jaký slovník používají
local PARTS = {
    menu = {
        dict = MENU,
        frames = { "GameMenuFrame", "QuestFrame", "QuestLogFrame", "QuestMapFrame", "GossipFrame",
                   "MerchantFrame", "MailFrame", "StaticPopup1", "StaticPopup2", "StaticPopup3", "StaticPopup4" },
        tooltip = true,   -- popisky tlačítek na liště
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

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event)
    hookFrames()   -- některá okna patří do addonů Blizzardu, které se načítají později
    if event == "PLAYER_LOGIN" then
        WoWpoCeskuSettings.lok = WoWpoCeskuSettings.lok or {}
        GameTooltip:HookScript("OnShow", translateTooltip)
    end
end)

-- Pro okno nastavení: seznam částí a jejich názvy
WoWpoCesku_LokParts = {
    { key = "menu", label = "Menu, tlačítka a popisky na liště", note = "Herní menu (Esc), Accept/Decline, Yes/No… (projeví se po /reload)" },
}

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
