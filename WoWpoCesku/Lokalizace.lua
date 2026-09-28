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
    ["Passive"] = "Pasivní",
    ["Instant"] = "Okamžité",
    ["Instant cast"] = "Sesláno okamžitě",
    ["Channeled"] = "Vedené",
    ["Melee Range"] = "Na blízko",
    ["Requires Melee Weapon"] = "Vyžaduje zbraň na blízko",
    ["Requires Shield"] = "Vyžaduje štít",
}
for en, cs in pairs(TREES) do TALENT[en] = cs end

-- Kniha kouzel: okno (názvy kouzel zůstávají anglicky – kvůli makrům, návodům a domluvě)
local SPELLBOOK = {
    ["Spellbook"] = "Kniha kouzel",
    ["Spellbook & Abilities"] = "Kniha kouzel a schopnosti",
    ["Spells"] = "Kouzla",
    ["Abilities"] = "Schopnosti",
    ["General"] = "Obecné",
    ["Pet"] = "Mazlíček",
    ["Professions"] = "Profese",
    ["Passive"] = "Pasivní",
    ["Racial"] = "Rasové",
    ["Racial Passive"] = "Rasové pasivní",
    ["Search abilities, keywords"] = "Hledat schopnosti, klíčová slova",
    ["Search abilities, keywords…"] = "Hledat schopnosti, klíčová slova…",
    ["Search abilities, keywords..."] = "Hledat schopnosti, klíčová slova…",
    ["Show All Spell Ranks"] = "Zobrazit všechny úrovně kouzel",
}
for en, cs in pairs(TREES) do SPELLBOOK[en] = cs end
local SPELLBOOK_PATTERNS = {
    { "^Page (%d+)/(%d+)$", function(a, b) return ("Strana %s/%s"):format(a, b) end },
    { "^Page (%d+)$", function(a) return "Strana " .. a end },
    { "^Rank (%d+)$", function(a) return "Úroveň " .. a end },
}

-- Pevné řádky popisků kouzel (cena, sesílání, obnovení, dosah…)
local SPELL_LINES = {
    -- Staty a zdroje (Mana, Rage, Energy, Strength…) zůstávají anglicky – přání hráčů
    { "^(%d+)%% of base mana$", "%1 %% základní Mana" },
    { "^([%d%.]+) sec cast$", "Sesílání %1 s" },
    { "^([%d%.]+) min cooldown$", "Obnovení %1 min" },
    { "^([%d%.]+) sec cooldown$", "Obnovení %1 s" },
    { "^([%d%.]+) yd range$", "Dosah %1 yd" },
    { "^([%d%.]+)%-([%d%.]+) yd range$", "Dosah %1–%2 yd" },
    { "^Requires level (%d+)$", "Vyžaduje úroveň %1" },
    { "^Rank (%d+)$", "Úroveň %1" },
    { "^Next Rank:?$", "Další úroveň:" },
}

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
    kouzla = {
        dict = SPELLBOOK,
        patterns = SPELLBOOK_PATTERNS,
        frames = { "SpellBookFrame", "SpellbookFrame" },
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
    -- Ikonka v textu (|A…|a atlas, |T…|t textura) – přeložit text a ikonku zachovat
    local pre, word, post = text:match("^(%s*[|][AT][^|]*[|][at]%s*)(.-)(%s*)$")
    if not pre then word, post = text:match("^(.-)(%s*[|][AT][^|]*[|][at]%s*)$"); pre = "" end
    if word and dict[word] then return pre .. dict[word] .. post end
    local core, suffix = text:match("^(.-)(%s*|c%x%x%x%x%x%x%x%x%(.-%)|r)$")
    if not core then core, suffix = text:match("^(.-)(%s*%(.-%))$") end
    if core and dict[core] then return dict[core] .. suffix end
    -- Cokoli jiného (barvy, víc ikonek): najít čistý text a nahradit ho na místě
    local plain = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|[AT].-|[at]", "")
    plain = plain:match("^%s*(.-)%s*$")
    local cs2 = plain ~= "" and dict[plain]
    if cs2 then
        local s, e = text:find(plain, 1, true)
        if s then return text:sub(1, s - 1) .. cs2 .. text:sub(e + 1) end
    end
end

local function translateFrame(frame, dict, depth, patterns)
    if not frame or depth > 12 or not frame:IsVisible() then return end
    for _, region in ipairs({ frame:GetRegions() }) do
        if region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and text ~= "" then
                local cs = lookup(dict, text)
                if not cs and patterns then
                    for _, p in ipairs(patterns) do
                        local a, b = text:match(p[1])
                        if a then cs = p[2](a, b) break end
                    end
                end
                if cs then setCzech(region, cs) end
            end
        end
    end
    for _, child in ipairs({ frame:GetChildren() }) do translateFrame(child, dict, depth + 1, patterns) end
end

local function translatePart(name, frame)
    if not enabled(name) then return end
    -- Hra často nastavuje texty až při zobrazení -> přeložit v příštím snímku
    C_Timer.After(0, function() translateFrame(frame, PARTS[name].dict, 0, PARTS[name].patterns) end)
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

-- Je šablona už náš český překlad? (např. „Spojenec: dosah {1} yd“ nemá diakritiku)
local czechValues
local function isKnownCzech(key)
    if not czechValues then
        czechValues = {}
        for _, cs in pairs(WoWpoCesku_UI or {}) do czechValues[cs] = true end
    end
    return czechValues[key] or false
end

-- Přeloží jeden řádek popisku talentu; nil = nechat (a případně zařadit do fronty)
local function translateTalentLine(text, queueMissing)
    local plain = plainText(text)
    if plain == "" or not plain:find("%a") then return nil end
    if plain:find("^Press F%d+ to submit") then return nil end   -- řádek jen v betě
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
    -- Český text (už přeložený, i bez diakritiky) nebo text jen z čísel nezařazovat
    if queueMissing and not plain:find("[\128-\255]") and not isKnownCzech(key) then queueUi(key) end
end

-- Okno talentů, jakmile ho najdeme (pro poznání, že popisek patří k talentu)
local talentFrameRef

-- Patří vlastník popisku k oknu talentů? (tlačítka talentů nemusí mít vlastní jméno)
local function isTalentOwner(owner)
    local f = owner
    for _ = 1, 15 do
        if not f then return false end
        if talentFrameRef and f == talentFrameRef then return true end
        local name = f.GetName and f:GetName()
        if name and name:find("Talent") then return true end
        f = f.GetParent and f:GetParent()
    end
    return false
end

-- Pro /czq info: od jakého prvku přišel poslední popisek (ladění, když popisky talentů nechytáme)
local lastOwnerChain = "zatim zadny"
function WoWpoCesku_TalentDebug()
    return "posledni popisek: " .. lastOwnerChain .. " | okno talentu: " .. tostring(talentFrameRef and (talentFrameRef:GetName() or "bez-jmena") or "nenalezeno")
end

local function ownerChain(owner)
    local names, f = {}, owner
    for _ = 1, 6 do
        if not f then break end
        names[#names + 1] = (f.GetName and f:GetName()) or "?"
        f = f.GetParent and f:GetParent()
    end
    return table.concat(names, " < ")
end

local function translateTalentTooltip(tip, force)
    if not enabled("talenty") then return end
    local owner = tip:GetOwner()
    lastOwnerChain = owner and ownerChain(owner) or "bez vlastnika"
    if not force and (not owner or not isTalentOwner(owner)) then return end
    for i = 1, tip:NumLines() or 0 do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local fs = _G[tip:GetName() .. side .. i]
            local text = fs and fs:IsShown() and fs:GetText()
            if text and text ~= "" then
                -- 1. řádek = název talentu: zůstává anglicky, do fronty nepatří
                local cs = translateTalentLine(text, not (i == 1 and side == "TextLeft"))
                if cs then setCzech(fs, cs) end
            end
        end
    end
    tip:Show()   -- přepočítat velikost po změně textu
end

-------------------------------------------------------------------------------
-- Kniha kouzel: popisky kouzel (název = 1. řádek zůstává anglicky)
-------------------------------------------------------------------------------
local spellbookRef

local function isSpellbookOwner(owner)
    local f = owner
    for _ = 1, 15 do
        if not f then return false end
        if spellbookRef and f == spellbookRef then return true end
        local name = f.GetName and f:GetName()
        if name and (name:find("SpellBook") or name:find("Spellbook")) then return true end
        f = f.GetParent and f:GetParent()
    end
    return false
end

-- Jeden řádek popisku kouzla: pevné řádky (cena, obnovení…) ručně, zbytek přes šablony
local function translateSpellLine(text, queueMissing)
    local plain = plainText(text)
    for _, p in ipairs(SPELL_LINES) do
        if plain:find(p[1]) then return (plain:gsub(p[1], p[2])) end
    end
    return translateTalentLine(text, queueMissing)
end

local function translateSpellTooltip(tip)
    if not enabled("kouzla") then return end
    local owner = tip:GetOwner()
    if not owner or not isSpellbookOwner(owner) or isTalentOwner(owner) then return end
    for i = 1, tip:NumLines() or 0 do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            if not (i == 1 and side == "TextLeft") then   -- název kouzla nechat anglicky
                local fs = _G[tip:GetName() .. side .. i]
                local text = fs and fs:IsShown() and fs:GetText()
                if text and text ~= "" then
                    local cs = translateSpellLine(text, true)
                    if cs then setCzech(fs, cs) end
                end
            end
        end
    end
    tip:Show()
end

-- Okno knihy kouzel: najít, přeložit a při listování stránkami překládat znovu
local function findFrameByName(pattern)
    for _, top in ipairs({ UIParent:GetChildren() }) do
        local ok, found = pcall(function() return top:IsVisible() and (top:GetName() or ""):find(pattern) ~= nil end)
        if ok and found then return top end
    end
end

local function translateSpellbookFrame()
    if not enabled("kouzla") then return end
    C_Timer.After(0.05, function()
        local fr
        for _, frameName in ipairs(PARTS.kouzla.frames) do
            if _G[frameName] and _G[frameName]:IsVisible() then fr = _G[frameName] break end
        end
        fr = fr or findFrameByName("Spell")
        if fr then
            spellbookRef = fr
            translateFrame(fr, SPELLBOOK, 0, SPELLBOOK_PATTERNS)
        end
    end)
end

-- Okna talentů a knihy kouzel se ve Forever můžou jmenovat a otevírat jinak -> hledat průběžně.
-- Stránky knihy se při listování přepisují -> dokud je kniha otevřená, překládat průběžně.
local lastSearch = 0
C_Timer.NewTicker(0.5, function()
    if (not spellbookRef or not talentFrameRef) and GetTime() - lastSearch > 1 then
        lastSearch = GetTime()
        for _, top in ipairs({ UIParent:GetChildren() }) do
            local ok, name = pcall(function() return top:IsVisible() and top:GetName() or nil end)
            if ok and name then
                if not talentFrameRef and name:find("Talent") then talentFrameRef = top end
                if not spellbookRef and (name:find("SpellBook") or name:find("Spellbook") or name == "PlayerSpellsFrame") then spellbookRef = top end
            end
        end
    end
    if spellbookRef and spellbookRef:IsVisible() and enabled("kouzla") then
        translateFrame(spellbookRef, SPELLBOOK, 0, SPELLBOOK_PATTERNS)
    end
    if talentFrameRef and talentFrameRef:IsVisible() and enabled("talenty") then
        translateFrame(talentFrameRef, TALENT, 0)
    end
end)

-- Ke kterému oknu popisek patří: podle vlastníka, jinak podle toho, nad kterým oknem je myš
local function mouseOver(frame)
    return frame and frame:IsVisible() and frame.IsMouseOver and frame:IsMouseOver()
end

local function tooltipContext(tip)
    local owner = tip.GetOwner and tip:GetOwner()
    if owner and isTalentOwner(owner) then return "talent" end
    if owner and isSpellbookOwner(owner) then return "spell" end
    if mouseOver(talentFrameRef) then return "talent" end
    if mouseOver(spellbookRef) then return "spell" end
end

-- Přeloží řádky libovolného popisku (GameTooltip i jiné) podle kontextu.
-- Obaleno pcall: chyba v překladu nesmí nikdy rozbít popisek hry.
local function translateAnyTooltipUnsafe(tip)
    local ctx = tooltipContext(tip)
    if not ctx then return end
    if ctx == "talent" and not enabled("talenty") then return end
    if ctx == "spell" and not enabled("kouzla") then return end
    local name = tip:GetName()
    if not name then return end
    lastOwnerChain = ctx .. " / " .. name
    local changed = false
    for i = 1, tip:NumLines() or 0 do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            -- Název kouzla (1. řádek) v knize kouzel nechat anglicky
            if not (ctx == "spell" and i == 1 and side == "TextLeft") then
                local fs = _G[name .. side .. i]
                local text = fs and fs:IsShown() and fs:GetText()
                if text and text ~= "" then
                    local cs = (ctx == "spell") and translateSpellLine(text, true) or translateTalentLine(text, true)
                    if cs and cs ~= text then setCzech(fs, cs); changed = true end
                end
            end
        end
    end
    if changed then tip:Show() end
end

local function translateAnyTooltip(tip)
    local ok, err = pcall(translateAnyTooltipUnsafe, tip)
    if not ok then lastOwnerChain = "CHYBA: " .. tostring(err) end
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
            if fr and fr:IsVisible() then talentFrameRef = fr; translateFrame(fr, TALENT, 0) return end
        end
        local fr = findTalentFrame()
        if fr then
            talentFrameRef = fr
            translateFrame(fr, TALENT, 0)
            if not hookedFrames[fr] then
                fr:HookScript("OnShow", function(self) translatePart("talenty", self) end)
                hookedFrames[fr] = true
            end
        end
    end)
end

-- Obal pro háčky na popisky: chyba v překladu nesmí nikdy rozbít popisek hry
local function safe(fn)
    return function(...)
        local ok, err = pcall(fn, ...)
        if not ok then lastOwnerChain = "CHYBA: " .. tostring(err) end
    end
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
    for _, fn in ipairs({ "ToggleSpellBook", "ToggleSpellbook" }) do
        if type(_G[fn]) == "function" and not hookedFrames[fn] then
            hooksecurefunc(fn, translateSpellbookFrame)
            hookedFrames[fn] = true
        end
    end
    if event == "PLAYER_LOGIN" then
        WoWpoCeskuSettings.lok = WoWpoCeskuSettings.lok or {}
        GameTooltip:HookScript("OnShow", safe(translateTooltip))
        GameTooltip:HookScript("OnShow", safe(function(tip) translateTalentTooltip(tip) end))
        -- Popisek talentu: klasicky přes SetTalent, ve Forever jako kouzlo (SetSpellByID / SetSpell…)
        -- -> přeložit hned po naplnění, SetTalent vždy, kouzla jen nad oknem talentů
        if GameTooltip.SetTalent then
            hooksecurefunc(GameTooltip, "SetTalent", safe(function(tip) translateTalentTooltip(tip, true) end))
        end
        for _, method in ipairs({ "SetSpellByID", "SetSpell", "SetSpellBookItem" }) do
            if GameTooltip[method] then
                hooksecurefunc(GameTooltip, method, safe(function(tip)
                    translateTalentTooltip(tip)
                    translateSpellTooltip(tip)
                end))
            end
        end
        GameTooltip:HookScript("OnShow", safe(function(tip) translateSpellTooltip(tip) end))
        -- Moderní systém popisků: zachytí každý popisek kouzla/talentu, ať ho hra vytvoří jakkoli
        if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum and Enum.TooltipDataType then
            for _, t in ipairs({ "Spell", "Talent", "Macro" }) do
                if Enum.TooltipDataType[t] then
                    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType[t], function(tip) translateAnyTooltip(tip) end)
                end
            end
        end
        GameTooltip:HookScript("OnShow", function(tip) translateAnyTooltip(tip) end)
    end
end)

-- Pro okno nastavení: seznam částí a jejich názvy
WoWpoCesku_LokParts = {
    { key = "menu", label = "Menu, tlačítka a popisky na liště", note = "Herní menu (Esc), Accept/Decline, Yes/No… (projeví se po /reload)" },
    { key = "talenty", label = "Talenty", note = "Okno talentů, větve a popisky talentů (nové se přeloží přes Pomocníka)" },
    { key = "kouzla", label = "Kniha kouzel", note = "Okno a popisky kouzel – názvy kouzel zůstávají anglicky" },
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
    -- Kniha kouzel: popisy kouzel (bez názvu – ten zůstává anglicky)
    if GetNumSpellTabs and GetSpellTabInfo and tip.SetSpellBookItem then
        for t = 1, GetNumSpellTabs() do
            local _, _, offset, numSpells = GetSpellTabInfo(t)
            for s = (offset or 0) + 1, (offset or 0) + (numSpells or 0) do
                tip:SetOwner(WorldFrame, "ANCHOR_NONE")
                if pcall(tip.SetSpellBookItem, tip, s, BOOKTYPE_SPELL or "spell") then
                    for l = 2, tip:NumLines() or 0 do
                        for _, side in ipairs({ "TextLeft", "TextRight" }) do
                            local fs = _G["WoWpoCeskuScanTip" .. side .. l]
                            local text = fs and fs:GetText()
                            if text and text ~= "" and not translateSpellLine(text, false) then
                                local plain = plainText(text)
                                if plain:find("%a") and not plain:find("^Press F%d+") then
                                    queueUi((toTemplate(plain))); count = count + 1
                                end
                            end
                        end
                    end
                end
                tip:Hide()
            end
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
