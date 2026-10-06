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
