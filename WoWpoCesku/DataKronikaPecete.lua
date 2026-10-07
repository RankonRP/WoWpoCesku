-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: další pečetě kronikáře – skryté pečetě (potkat postavu, navštívit místo) a další Legendy Azerothu.
-- Načítá se po DataKronika.lua a jen DOPLŇUJE existující seznamy.

-- další Legendy Azerothu (slavné questové příběhy): q = čísla questů z classic DB
do
    local L = WoWpoCesku_SealLegends
    L[#L + 1] = { id = "eitrigg", q = { 4941 }, f = "H", name = "Eitriggova moudrost", pts = 10,
        desc = "Vyslechni starého orka Eitrigga a předej jeho radu Thrallovi (quest Eitrigg's Wisdom)." }
    L[#L + 1] = { id = "andorhal", q = { 105, 211 }, name = "Zkáza Andorhalu", pts = 10,
        desc = "Dokonči příběh zničeného města Andorhalu v Western Plaguelands (quest Alas, Andorhal)." }
    L[#L + 1] = { id = "windsor", q = { 4241 }, name = "Vězeň z Blackrocku", pts = 10,
        desc = "Dokonči příběh maršála Windsora, jehož stopa vede z Burning Steppes až do vězení v Blackrock Depths." }
    L[#L + 1] = { id = "loveandfamily", q = { 5846, 5848 }, name = "O lásce a rodině", pts = 10,
        desc = "Dokonči příběh Of Love and Family z Eastern Plaguelands." }
end

-- další skryté pečetě: potkat slavnou postavu (zaměřit ji nebo na ni najet myší)
do
    local H = WoWpoCesku_SealHidden
    local function npc(id, nm, name, pts, hint, desc)
        H[#H + 1] = { id = id, npc = nm, name = name, pts = pts, hint = hint, desc = desc }
    end
    npc("thrallmet", "Thrall", "Válečný náčelník", 10,
        "Vůdce Hordy sídlí v nejvyšší věži hlavního města orků a stará se o to, aby jeho lid našel nový domov…",
        "Potkal(a) jsi válečného náčelníka Thralla.")
    npc("cairnemet", "Cairne Bloodhoof", "Náčelník plání", 10,
        "Moudrý taurenský náčelník sídlí na vrcholku mesy, odkud je vidět celé pláně…",
        "Potkal(a) jsi Cairna Bloodhoofa.")
    npc("sylvanasmet", "Lady Sylvanas Windrunner", "Temná paní", 10,
        "Bývalá generálka hraničářů vládne v hlubinách pod ruinami Lordaeronu…",
        "Potkal(a) jsi Lady Sylvanas Windrunner.")
    npc("jainamet", "Jaina Proudmoore", "Čarodějka z Theramore", 10,
        "Mocná čarodějka, dcera admirála, vládne městu u moře v bažinách Dustwallow Marsh…",
        "Potkal(a) jsi Jainu Proudmoore.")
    npc("bolvarmet", "Highlord Bolvar Fordragon", "Regent Stormwindu", 10,
        "Rytíř, který hlídá trůn, dokud se pravý král nevrátí…",
        "Potkal(a) jsi Highlorda Bolvara Fordragona.")
    npc("katranamet", "Lady Katrana Prestor", "Šlechtična u dvora", 10,
        "U dvora ve Stormwindu žije šlechtična, o které se šeptá, že není tím, čím se zdá…",
        "Potkal(a) jsi lady Katranu Prestor.")
    npc("magnimet", "King Magni Bronzebeard", "Král pod horou", 10,
        "Král trpaslíků z rodu Bronzebeardů sídlí v hlubinách Ironforge…",
        "Potkal(a) jsi krále Magniho Bronzebearda.")
    npc("remulosmet", "Keeper Remulos", "Strážce Moonglade", 10,
        "Strážce posvátného jezera ve skrytém údolí, kde se potkává druidská moudrost…",
        "Potkal(a) jsi Keepera Remulose.")
    npc("eitriggmet", "Eitrigg", "Rádce čestného orka", 5,
        "Stařešina orků, který Thrallovi radí a připomíná mu, co je skutečná čest…",
        "Potkal(a) jsi Eitrigga.")
    npc("varimathrasmet", "Varimathras", "Dreadlord v podzemí", 10,
        "V podzemním městě sídlí dreadlord, který Temné paní slouží – nebo si to alespoň myslí…",
        "Potkal(a) jsi Varimathrase.")
    npc("windsormet", "Marshal Windsor", "Maršál v řetězech", 10,
        "Hluboko v Blackrock Depths čeká v cele muž, který kdysi velel stormwindským vojákům…",
        "Potkal(a) jsi maršála Windsora.")
end

-- další skryté pečetě: navštívit slavné místo (název podoblasti)
do
    local H = WoWpoCesku_SealHidden
    local function misto(id, place, name, pts, hint, desc)
        H[#H + 1] = { id = id, misto = place, name = name, pts = pts, hint = hint, desc = desc }
    end
    misto("lightshope", "Light's Hope Chapel", "Poslední naděje", 10,
        "V Eastern Plaguelands stojí kaple, kolem které se shromáždili ti, kdo se Plaze nevzdají…",
        "Došel(a) jsi do Light's Hope Chapel.")
    misto("gadgetzan", "Gadgetzan", "Město goblinů v poušti", 5,
        "V poušti Tanaris vyrostlo město, které pro zlato obchoduje s kýmkoli…",
        "Navštívil(a) jsi Gadgetzan.")
    misto("everlook", "Everlook", "Město pod sněhem", 5,
        "Vysoko ve sněhu Winterspring stojí osada goblinů…",
        "Navštívil(a) jsi Everlook.")
    misto("bootybay", "Booty Bay", "Přístav bez zákonů", 5,
        "Na jihu džungle leží přístav, kde se nerozlišuje Horda ani Aliance…",
        "Navštívil(a) jsi Booty Bay.")
    misto("theramore", "Theramore Isle", "Pevnost u moře", 5,
        "Na pobřeží bažin leží alianční město, které se zrodilo z víry v mír…",
        "Navštívil(a) jsi Theramore Isle.")
    misto("hearthglen", "Hearthglen", "Pevnost Křižáků", 10,
        "Daleko v Plaguelands drží pevnost fanatici, kteří každého cizince podezírají z moru…",
        "Došel(a) jsi do Hearthglenu.")
    misto("southshore", "Southshore", "Břeh jižního moře", 5,
        "Alianční městečko na pobřeží Hillsbradu, které za války vystřídalo mnoho vlajek…",
        "Navštívil(a) jsi Southshore.")
    misto("tarrenmill", "Tarren Mill", "Mlýn pod zříceninou", 5,
        "V Hillsbradu leží osada, kterou po válce obsadili nemrtví…",
        "Navštívil(a) jsi Tarren Mill.")
    misto("menethil", "Menethil Harbor", "Brána Wetlands", 5,
        "Přístav v bažinách, odkud se lodí plaví do Darkshore i na Theramore…",
        "Navštívil(a) jsi Menethil Harbor.")
    misto("auberdine", "Auberdine", "Přístav noční elfů", 5,
        "Pobřežní osada v Darkshore, kde přistávají lodě z Menethil Harbor…",
        "Navštívil(a) jsi Auberdine.")
    misto("sentinelhill", "Sentinel Hill", "Strážní kopec", 5,
        "Na kopci ve Westfallu stojí věž, kam se hrdinové vracejí po bojích s Defiasy…",
        "Navštívil(a) jsi Sentinel Hill.")
    misto("nethergarde", "Nethergarde Keep", "Pevnost u brány", 10,
        "V Blasted Lands stojí pevnost, která hlídá portál do jiného světa…",
        "Došel(a) jsi do Nethergarde Keep.")
    misto("chillwind", "Chillwind Camp", "Tábor mrazivého větru", 5,
        "V Western Plaguelands stojí alianční tábor uprostřed mrtvé země…",
        "Došel(a) jsi do Chillwind Camp.")
end

-- easter eggy a zajímavá místa (skryté pečetě)
do
    local H = WoWpoCesku_SealHidden
    local function misto(id, place, name, pts, hint, desc)
        H[#H + 1] = { id = id, misto = place, name = name, pts = pts, hint = hint, desc = desc }
    end
    local function npc(id, nm, name, pts, hint, desc)
        H[#H + 1] = { id = id, npc = nm, name = name, pts = pts, hint = hint, desc = desc }
    end
    misto("newman", "Newman's Landing", "Dok mimo mapu", 10,
        "Na pobřeží Dun Morogh stojí malé molo, které není na mapě a má jiné počasí než okolí…",
        "Našel(a) jsi Newman's Landing.")
    misto("deeprun", "Deeprun Tram", "Podzemní tramvaj", 5,
        "Pod zemí jezdí tramvaj mezi dvěma hlavními městy Aliance – jízda stojí za to…",
        "Svezl(a) ses Deeprun Tramem.")
    misto("ravenholdt", "Ravenholdt Manor", "Doupě zlodějů", 10,
        "V horách u Hillsbradu leží neutrální panství, kde se scházejí ti nejlepší zloději…",
        "Došel(a) jsi do Ravenholdt Manor.")
    misto("explorers", "Hall of Explorers", "Síň badatelů", 5,
        "V Ironforge sídlí badatelé, kteří hledají tajemství titánů…",
        "Navštívil(a) jsi Hall of Explorers.")
    misto("thandol", "Thandol Span", "Most přes propast", 5,
        "Obří trpasličí most spojuje dva kontinenty a nese jméno, které se nedá snadno zapomenout…",
        "Přešel/přešla jsi Thandol Span.")
    npc("gazlowe", "Gazlowe", "Pán Ratchetu", 5,
        "Goblinský podnikatel vládne přístavu v Barrens a o všem rád smlouvá…",
        "Potkal(a) jsi Gazlowa.")
    npc("revilgaz", "Baron Revilgaz", "Baron přístavu", 5,
        "Na jihu džungle vládne přístavu goblin s titulem barona…",
        "Potkal(a) jsi barona Revilgaze.")
    npc("noggenfogger", "Marin Noggenfogger", "Alchymista z pouště", 5,
        "V pouštním městě vládne goblin, po kterém se jmenuje slavný lektvar…",
        "Potkal(a) jsi Marina Noggenfoggera.")
end
