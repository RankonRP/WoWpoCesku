-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: kořist bossů ve WoW Forever (ověřeno v databázi Forever; liší se od classic).
-- WoWpoCesku_BossLootForever[instance][boss] = { { "Název", kvalita (3 = modrý), ID předmětu }, ... }
-- Když pro bosse záznam existuje, nahrazuje classic databázi (DataKoristi.lua).

WoWpoCesku_BossLootForever = {

["Ragefire Chasm"] = {
    ["Oggleflint"] = { { "Trogg Scepter", 3, 272996 }, { "Bone Knuckles", 3, 272998 }, { "Barbaric Crossbow", 3, 272999 } },
    ["Taragaman the Hungerer"] = { { "Cursed Felblade", 3, 14145 }, { "Crystalline Cuffs", 3, 14148 }, { "Subterranean Cape", 3, 14149 } },
    ["Jergosh the Invoker"] = { { "Cavedweller Bracers", 3, 14147 }, { "Robe of Evocation", 3, 14150 }, { "Chanting Blade", 3, 14151 } },
    ["Bazzalan"] = { { "Searing Dagger", 3, 273003 }, { "Satyrskin Cloak", 3, 273005 }, { "Chasm Walkers", 3, 273007 } },
},

}
