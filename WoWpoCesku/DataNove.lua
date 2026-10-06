-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: nové dungeony WoW Forever (Ruins of Lordaeron …) – bossové, kořist, questy, příběh.
-- Kořist je z databáze Forever, potvrzuje ji teprve zlatá hvězdička z lootu ve hře.

local KEY = "Ruins of Lordaeron"

WoWpoCesku_Lore[KEY] = {
    title = KEY, tag = "Zničené horní město Lordaeronu nad Undercity – nový dungeon WoW Forever (levely 15–22).",
    ch = {
        { "Zničené hlavní město", [[Ruins of Lordaeron jsou zřícená horní část hlavního města starého království Lordaeron. Nad dnešním Undercity stojí mrtvé ulice, rozpadlé tržiště a královská čtvrť, kterou dávno zaplavil mor.]] },
        { "Mor a nemrtví", [[Po pádu království se městem plouží ghúlové, kostlivci a bolestné bansheeové. Mor tu nadělal z mrtvých zrůdy a z živých dávno nezbyl nikdo. Dobrodruzi sem chodí hlavně pro Apothecary Society z Undercity, která v ruinách shání vzorky nákazy.]] },
        { "Vládci ruin", [[Ruinám vládnou jednotlivé potvory: The Baron v čele nemrtvých, jedovatý pavouk Witherfang, The Abandoned, Bjork, Rath'mael a Viktor the Vile. Mezi nimi se potuluje i vzácný Lordaeron Captain, poslední z kdysi hrdé stráže.]] },
    },
}
WoWpoCesku_LoreTajemstvi[KEY] = [[• Questy dostaneš hlavně v Undercity (Apothecary Society) a u Alianční strany v Kirin Tor.
• Počítej s hordou nemrtvých – hodí se plošné kouzlení a léčitel.
• Údaje o kořisti jsou z databáze Forever; potvrzuje je až zlatá hvězdička z lootu.]]

WoWpoCesku_DungeonBosses[KEY] = {
    { "The Baron", "velitel nemrtvých" },
    { "Witherfang", "jedovatý pavouk" },
    { "The Abandoned", "zlomená duše z ruin" },
    { "Bjork", "brutální hlídač ruin" },
    { "Rath'mael", "nemrtvý mučitel" },
    { "Viktor the Vile", "zlý zvrhlík z ulic" },
    { "Lordaeron Captain", "vzácný, poslední z hlídky" },
}

WoWpoCesku_BossNpc[KEY] = { ["The Baron"] = 250660, ["Witherfang"] = 250483, ["The Abandoned"] = 250631, ["Bjork"] = 256097, ["Rath'mael"] = 250657, ["Viktor the Vile"] = 256035 }
WoWpoCesku_BossLevel[KEY] = { ["The Baron"] = 17, ["Witherfang"] = 17, ["The Abandoned"] = 18, ["Bjork"] = 19, ["Rath'mael"] = 20, ["Viktor the Vile"] = 19, ["Lordaeron Captain"] = 19 }

WoWpoCesku_BossLootForever[KEY] = {
    ["The Baron"] = { { "Meathook Slicer", 3, 271204 }, { "Abomination Bones", 3, 271205 }, { "Leftover Abomination Skin", 3, 271206 } },
    ["Witherfang"] = { { "Atrophic Girdle", 3, 271201 }, { "Witherbite Bracers", 3, 271202 }, { "Segmented Spider Leg", 3, 271203 } },
    ["The Abandoned"] = { { "Rotmender's Leggings", 3, 271207 }, { "Grip of Fear", 3, 271208 }, { "Scepter of the Abandoned", 3, 271216 } },
    ["Bjork"] = { { "Bonerust Leggings", 3, 271209 }, { "Tuskwrap Belt", 3, 271210 }, { "Corpse Chopper", 3, 271217 } },
    ["Rath'mael"] = { { "Mirror of Rath'mael", 3, 271213 }, { "Rotmender's Treads", 3, 271214 }, { "Coldspire Staff", 3, 271215 } },
    ["Viktor the Vile"] = { { "Vilewalkers", 3, 271211 }, { "Bloodied Chestwraps", 3, 271212 }, { "Vileblood Scimitar", 3, 271218 } },
}

-- { id, název, level, min. level, frakce (nil = obě), kdo ho dává, odměny }
WoWpoCesku_DungeonQuests[KEY] = {
    { 92415, "Remember That I Love You", 22, 15, "A", "", "" },
    { 92421, "Light's Justice", 22, 15, "H", "", "" },
    { 92422, "The Wrath of Rath'mael", 22, 15, "H", "", "" },
    { 95189, "Crest of Lordaeron", 22, 16, "A", "", "" },
    { 95204, "Crest of Lordaeron", 22, 16, "H", "", "" },
    { 95195, "Bloodied Insignia", 22, 16, "A", "", "" },
    { 95216, "The New Plague", 22, 16, "H", "", "" },
    { 95250, "Abominable Creatures", 21, 16, "A", "", "" },
    { 97288, "Unending Torment", 21, 16, "H", "Abominable Head", "" },
}

-------------------------------------------------------------------------------
-- Hall of Thanes
-------------------------------------------------------------------------------
KEY = "Hall of Thanes"
WoWpoCesku_Lore[KEY] = {
    title = KEY, tag = "Zničená síň trpasličích thanů pod Ironforge – nový dungeon WoW Forever (levely 13–20).",
    ch = {
        { "Síň thanů", [[Hall of Thanes je stará trpasličí síň, kde kdysi zasedali thanové klanů. Dnes ji obývají duchové, kteří nenašli klid, a kameni prostoupení strážci.]] },
        { "Neklidní mrtví", [[Duch Faldrima Anvilmara a další zbloudilé duše prosí hrdiny o pomoc. Jejich rod je uvězněný v dávné křivdě a bez odpočinku se nemůže vrátit mezi živé.]] },
        { "Vetřelci z Dark Iron", [[Do síně se vloudili Dark Iron trpaslíci, zloději a inženýři, kteří rabují cennosti thanů a přivolávají živly. Mezi bossy je Magmatus, ohnivá bytost z hlubin.]] },
    },
}
WoWpoCesku_LoreTajemstvi[KEY] = [[• Questy jsou hlavně o duších thanů a o vyrabovaných rodinných cennostech.
• Údaje o kořisti jsou z databáze Forever; potvrzuje je až zlatá hvězdička z lootu.]]
WoWpoCesku_DungeonBosses[KEY] = {
    { "Faldrim Anvilmar", "duch thana" },
    { "Plunder", "golem, který hlídá poklady" },
    { "Magmatus", "ohnivý živel" },
    { "Durgen Dirgehammer", "zneuctěný thane" },
}
WoWpoCesku_BossNpc[KEY] = { ["Faldrim Anvilmar"] = 261306, ["Plunder"] = 261311, ["Magmatus"] = 261316, ["Durgen Dirgehammer"] = 261319 }
WoWpoCesku_BossLootForever[KEY] = {
    ["Faldrim Anvilmar"] = { { "Ephemeral Choker", 3, 270227 }, { "Aetherwisp Bracers", 3, 271096 }, { "Spiritwraith Drape", 3, 271097 } },
    ["Plunder"] = { { "Golemheart Stave", 3, 270228 }, { "Treads of the Protector Golem", 3, 270229 }, { "Golemguard Chest", 3, 271098 } },
    ["Magmatus"] = { { "Kindlegem Girdle", 3, 270230 }, { "Flamefist Grips", 3, 270231 }, { "Fang of Magmatus", 3, 271095 } },
    ["Durgen Dirgehammer"] = { { "Durgen's Crescent Axe", 3, 270256 }, { "Direhammer Leggings", 3, 270260 }, { "Robes of the Disgraced Thane", 3, 270261 } },
}
WoWpoCesku_DungeonQuests[KEY] = {
    { 96393, "Old Ironforge Incursion", 16, 9, "A", "", "" },
    { 96394, "The Restless Dead", 15, 10, "A", "", "" },
    { 96395, "An Ancient Grudge", 15, 10, nil, "", "" },
    { 96403, "Important Heirlooms", 15, 10, "A", "", "" },
}

-------------------------------------------------------------------------------
-- Excavation Site: Wetlands
-------------------------------------------------------------------------------
KEY = "Excavation Site: Wetlands"
WoWpoCesku_Lore[KEY] = {
    title = KEY, tag = "Vykopávky ve Wetlands – nový dungeon WoW Forever (levely 26–31).",
    ch = {
        { "Vykopávky", [[Ve Wetlands se na vykopávkách hledají pozůstatky dávné minulosti. Do hlubin se ale nastěhovala divoká zvěř, ještěři a ozbrojenci z klanu Dragonmaw.]] },
        { "Hrozby v bažině", [[Krokodýli, raptoři a další šelmy z bažin pronikly do vykopávek. Hlídají je ale i strážní golemové, které tu zanechali dávní badatelé.]] },
    },
}
WoWpoCesku_LoreTajemstvi[KEY] = [[• Questy dostaneš v okolí vykopávek ve Wetlands.
• Údaje o kořisti jsou z databáze Forever; potvrzuje je až zlatá hvězdička z lootu.]]
WoWpoCesku_DungeonBosses[KEY] = {
    { "Saltspine", "ještěří šelma z bažin" },
    { "Shadetooth", "raptor" },
    { "Relic Guardian", "golem střežící relikvie" },
}
WoWpoCesku_BossNpc[KEY] = { ["Saltspine"] = 260322, ["Shadetooth"] = 260325, ["Relic Guardian"] = 260326 }
WoWpoCesku_BossLootForever[KEY] = {
    ["Saltspine"] = { { "Supple Bellyskin Leggings", 3, 273022 }, { "Saltscale Girdle", 3, 273023 }, { "Glinteye Slippers", 3, 273024 } },
    ["Shadetooth"] = { { "Raptorclaw Greaves", 3, 273025 }, { "Garb of Florid Feathers", 3, 273026 }, { "Raptor's Gaze", 3, 273027 } },
    ["Relic Guardian"] = { { "Reliquary Mantle", 3, 273028 }, { "Golemsight Long Gun", 3, 273029 }, { "Ring of Power Regulation", 3, 273030 } },
}
WoWpoCesku_DungeonQuests[KEY] = {
    { 95646, "Horrors in the Highland", 31, 24, "A", "", "" },
    { 95647, "Lost in the Thicket Things", 31, 24, "A", "", "" },
    { 95663, "Dragonmaw Rumors", 31, 24, nil, "", "" },
    { 95664, "Elder Knowledge", 31, 24, "H", "", "" },
    { 95682, "Open the Maw", 31, 24, nil, "", "" },
    { 95697, "Changing Tastes", 31, 24, "H", "", "" },
    { 95737, "Seeking Caitlin", 31, 24, nil, "", "" },
    { 95772, "Songblade Search", 31, 24, nil, "", "" },
    { 95795, "Fallen in the Fen", 31, 24, "A", "", "" },
    { 95809, "Heartwoven", 31, 24, "A", "", "" },
    { 95810, "Lost Relic Carry", 31, 24, "A", "", "" },
    { 98815, "Highland Hides", 28, 24, nil, "", "" },
    { 98823, "Earthen Echo", 31, 24, "H", "", "" },
    { 98824, "Prehistoric Prism", 31, 24, "A", "", "" },
}

-------------------------------------------------------------------------------
-- City of Dalaran
-------------------------------------------------------------------------------
KEY = "City of Dalaran"
WoWpoCesku_Lore[KEY] = {
    title = KEY, tag = "Zničené kouzelnické město v Alterac – nový dungeon WoW Forever (levely 28–33).",
    ch = {
        { "Město kouzelníků", [[Dalaran bylo kdysi sídlo Kirin Tor, rady mágů. Dnes jsou jeho ruiny plné nestabilní magie a nemrtvých, kteří tu zůstali po pádu města.]] },
        { "Zbloudilá magie", [[Questy se točí kolem zkažené arkánní energie, zdrojů moci a nemrtvých rytířů. Hlídají je i rozbouřené živly, které z magie vznikly.]] },
    },
}
WoWpoCesku_LoreTajemstvi[KEY] = [[• Questy jsou hlavně o magických vzorcích a zdrojích moci.
• Bossy sem doplním, až je v dungeonu uvidím ve hře.]]
WoWpoCesku_DungeonBosses[KEY] = {}
WoWpoCesku_DungeonQuests[KEY] = {
    { 92456, "A Green Sample", 33, 24, "A", "", "" },
    { 92457, "Starving Arcane", 33, 24, nil, "", "" },
    { 92458, "Heart of Disruption", 33, 24, "A", "", "" },
    { 92489, "Power Overwhelming", 33, 24, "A", "", "" },
    { 96984, "Heart of Disruption", 33, 24, "H", "", "" },
    { 96986, "The Grave Knight", 33, 24, "H", "", "" },
    { 96987, "Opportunistic Education", 33, 24, "H", "", "" },
    { 96988, "Source of Power", 33, 24, "H", "", "" },
}

-------------------------------------------------------------------------------
-- Scarlet Monastery: Graveyard a Library (ve Forever dvě samostatné instance; data se odvodí z původního "Scarlet Monastery")
-------------------------------------------------------------------------------
do
    local SRC = "Scarlet Monastery"
    local WINGS = {
        ["Scarlet Monastery: Graveyard"] = {
            levels = "30–38", tag = "Hřbitov Šarlatového kláštera – nemrtví a křižáci",
            bosses = { "Interrogator Vishas", "Azshir the Sleepless", "Fallen Champion", "Ironspine", "Bloodmage Thalnos" },
            quests = { [1051] = true, [1113] = true },
        },
        ["Scarlet Monastery: Library"] = {
            levels = "33–41", tag = "Knihovna Šarlatového kláštera – psovodi a mágové",
            bosses = { "Houndmaster Loksey", "Arcanist Doan" },
            quests = { [1160] = true, [1049] = true, [1050] = true, [1113] = true },
        },
    }
    for key, w in pairs(WINGS) do
        local want = {}
        for _, b in ipairs(w.bosses) do want[b] = true end
        local L = WoWpoCesku_Lore[SRC]
        if L then
            local copy = {}
            for k, v in pairs(L) do copy[k] = v end
            copy.title = key
            copy.tag = w.tag .. " (levely " .. w.levels .. ")."
            WoWpoCesku_Lore[key] = copy
        end
        WoWpoCesku_LoreTajemstvi[key] = WoWpoCesku_LoreTajemstvi[SRC]
        if WoWpoCesku_DungeonGuide then WoWpoCesku_DungeonGuide[key] = WoWpoCesku_DungeonGuide[SRC] end
        local function pick(tbl)
            local t = tbl and tbl[SRC]
            if not t then return end
            local out = {}
            for name, v in pairs(t) do if want[name] then out[name] = v end end
            tbl[key] = out
        end
        pick(WoWpoCesku_BossNpc); pick(WoWpoCesku_BossLevel); pick(WoWpoCesku_BossLoot)
        pick(WoWpoCesku_BossLootForever); pick(WoWpoCesku_BossLore); pick(WoWpoCesku_BossPos)
        local bl = {}
        for _, b in ipairs(WoWpoCesku_DungeonBosses[SRC] or {}) do if b.sekce or want[b[1]] then bl[#bl + 1] = b end end
        WoWpoCesku_DungeonBosses[key] = bl
        local ql = {}
        for _, q in ipairs(WoWpoCesku_DungeonQuests[SRC] or {}) do if w.quests[q[1]] then ql[#ql + 1] = q end end
        WoWpoCesku_DungeonQuests[key] = ql
        for _, name in ipairs({ "WoWpoCesku_DungeonEntry", "WoWpoCesku_DungeonEntryOut" }) do
            local t = _G[name]
            if t and t[SRC] then t[key] = t[SRC] end
        end
    end
end
