-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: rozšířené lore NOVÝCH dungeonů WoW Forever (Ruins of Lordaeron, Hall of Thanes, Excavation Site: Wetlands, City of Dalaran).
-- Vychází z textů questů ve hře a z veřejných průvodců; dungeony jsou nové, takže se podrobnosti mohou ještě měnit.
-- Načítá se PO DataNove.lua (tam se tyto instance vytvářejí) a jen doplňuje existující text.

local D = WoWpoCesku_Lore

local function chapters(inst, list)
    local L = D[inst]
    if not L then return end
    for _, c in ipairs(list) do L.ch[#L.ch + 1] = c end
end

local function boss(inst, name, text)
    WoWpoCesku_BossLore = WoWpoCesku_BossLore or {}
    local t = WoWpoCesku_BossLore[inst]
    if not t then t = {}; WoWpoCesku_BossLore[inst] = t end
    t[name] = (t[name] and (t[name] .. "\n\n") or "") .. text
end

local function secrets(inst, text)
    WoWpoCesku_LoreTajemstvi = WoWpoCesku_LoreTajemstvi or {}
    local old = WoWpoCesku_LoreTajemstvi[inst]
    WoWpoCesku_LoreTajemstvi[inst] = (old and (old .. "\n") or "") .. text
end

-------------------------------------------------------------------------------
-- Ruins of Lordaeron
-------------------------------------------------------------------------------
chapters("Ruins of Lordaeron", {
    { "Hrob padlého království", [[Ruins of Lordaeron jsou zřícená hlavní město Lordaeronu nad dnešním Undercity v Tirisfal Glades. Je to otevřený dungeon: mezi rozpadlými ulicemi, tržištěm a královskou čtvrtí se potulují pavouci, kostlivci, duchové, ghúlové a ohavné zrůdy poskládané z mrtvol. Každé rozbité okno tu připomíná, že tohle město bylo kdysi nejlidnatějším místem severního Lordaeronu.]] },
    { "Cesta sem", [[Horda má cestu jednoduchou: do Undercity se dostane zeppelinem z Orgrimmaru. Aliance to má složitější a musí z Southshore v Hillsbrad Foothills, takže se mnozí spoléhají na portály z Dalaranu. Vstup do dungeonu leží těsně nad Undercity, na místě, kde dnes vidíš značku vstupu na mapě Tirisfalu.]] },
    { "Mrtvé město a jeho vládci", [[Ruinám vládne několik zrůd. Witherfang, jedovatý pavouk, hlídkuje v King's Alley; Baron je mohutný velitel nemrtvých; The Abandoned, zlomená duše, vyvolává pomocníky na Market Square; Bjork brutálně obchází střed ruin; a nekromancer Rath'mael, ukrytý v Lordamere Overlook, je podle zvědů novou silou mezi nemrtvými a je nejhorší z nich. Volitelný Viktor the Vile se objeví jen tehdy, když se spustí událost u komína v domě jihozápadně od Lordamere Overlook.]] },
    { "Mor, který zůstal", [[Ulice a hřbitov zalévá nepřirozená mlha, která tu pohromě poskytuje utajení. Apothecarium v Undercity prý sbírá vzorky: pavouk, který tu žije, má podle zpráv jed, který ničí i nemrtvé maso. Forsaken by rádi věděli, co všechno tu mor ještě dokáže.]] },
    { "Dědictví Lordaeronu", [[Z pádu království zbylo málo relikvií. Hřeben Lordaeronu (Crest of Lordaeron) se v ruinách skrývá na několika místech a ve Stormwindu po něm touží. Pergamen z hřbitova zase připomíná pohřešované dítě rodiny Heartweaverů – trosky Lordaeronu stále ukrývají osudy těch, kdo zde zůstali.]] },
})

boss("Ruins of Lordaeron", "Witherfang", [[Obří jedovatý pavouk, který hlídkuje v King's Alley. Jeho jed (Leech Poison) se zaměřuje na toho, kdo drží první linii. Apothecarium chce vzorek jeho toxinu, protože prý ničí i nemrtvé maso.]])

boss("Ruins of Lordaeron", "The Baron", [[Mohutný velitel nemrtvých v ruinách. Má těžké údery a mocný Knockout, který srazí i dobře chráněného tanka. Jeho hlava je cílem questu a symbolem toho, že ruiny stále vládne starý řád – jen mrtvý.]])

boss("Ruins of Lordaeron", "The Abandoned", [[Zlomená duše, která bloudí po Market Square. Povolává pomocníky a seslání mrazu a vysátí života jsou jeho zbraněmi.]])

boss("Ruins of Lordaeron", "Bjork", [[Brutální tvor, který se potlouká středem ruin. Nemá žádné rafinované schopnosti – jen krátký štít proti magii – a spoléhá se na hrubou sílu.]])

boss("Ruins of Lordaeron", "Rath'mael", [[Nekromancer, který podle Forsaken přišel jako nová síla mezi nemrtvými a ukrývá se v Lordamere Overlook hluboko v ruinách. Zavolal na ulice bezbožnou mlhu, která zahalila pohromu, a Forsaken proti němu nemají čas čekat. Je to poslední a nejnebezpečnější boss dungeonu.]])

boss("Ruins of Lordaeron", "Viktor the Vile", [[Volitelný boss, který se objeví jen tehdy, když skupina spustí událost u komína v domě jihozápadně od Lordamere Overlook.]])

boss("Ruins of Lordaeron", "Lordaeron Captain", [[Vzácná nemrtvá postava z řad bývalé lordaeronské stráže.]])

secrets("Ruins of Lordaeron", [[• Viktor the Vile se objeví jen po události u komína v domě jihozápadně od Lordamere Overlook.
• Crest of Lordaeron se skrývá na několika místech ruin.
• Vstup do dungeonu je těsně nad Undercity; Horda se tam dostane zeppelinem, Aliance přes Southshore nebo portály z Dalaranu.]])

-------------------------------------------------------------------------------
-- Hall of Thanes
-------------------------------------------------------------------------------
chapters("Hall of Thanes", {
    { "Zapečetěný Old Ironforge", [[Hall of Thanes leží v Old Ironforge, dřív zapečetěné části města skryté pod High Seat, vládním sídlem trpasličí metropole. Je to hrobka dávných trpasličích králů a thanů, kde odpočívali největší hrdinové klanů. Dnes je zaplněná nemrtvými, Dark Iron trpaslíky a elementálními strážci.]] },
    { "Vpád Dark Iron trpaslíků", [[Dark Iron trpaslíci se do hrobek vlámali v krtčích strojích, vynořili se z hlubin a začali rabovat. Do nižších trezorů mají namířeno i proto, že tam leží cenná kořist a dědictví dávných klanů. Velení podle quest textu patří Durgenu Dirgehammerovi – jeho hlava má skončit u krále Magniho Bronzebearda v Ironforge.]] },
    { "Neklidní mrtví", [[Něco narušilo hrobky a z hlubin kleneb se ozývají podivné zvuky. Duchové jsou lehcí spáči, a zdá se, že je to všechno vyděsilo. Duch jednoho z thanů, Faldrim Anvilmar, prosí hrdiny, aby ho uložili k odpočinku – pohlcen prastarou záští nemůže najít klid.]] },
    { "Dědictví pod zámky", [[Ve trezorech leží dědictví trpasličích klanů, ve hře zmiňované jako „důležité kulturní dědictví“. Jeden z místních strážců pokladů prosí dobrodruhy, aby je přinesli zpět – a ujišťuje, že všechno bude katalogizováno. Mnohé relikvie se skrývají za trezory v komnatě Durgena Dirgehammera.]] },
    { "Cesta sem", [[Aliance se do Hall of Thanes dostane snadno přes Ironforge. Horda musí buď projít nepřátelským územím, nebo najít tajný teleport z questové linie. Dungeon je lineární a má čtyři bossy.]] },
})

boss("Hall of Thanes", "Faldrim Anvilmar", [[Nemrtvý trpaslík, první boss, patroluje svou hrobku. V quest „An Ancient Grudge“ musíš ducha Faldrima uložit k odpočinku. Používá mentální útoky (Mind Blast) a vlastní kletbu Anvilmar's Curse.]])

boss("Hall of Thanes", "Plunder", [[Elementální strážce hrobek s jednoduchými schopnostmi, hlavně odhozením. Hlídá cestu k hlubším trezorům.]])

boss("Hall of Thanes", "Magmatus", [[Ohnivý živel v doprovodu Dark Iron vyvolávačů. Sesílá okamžité ohnivé kruhy, které zraňují všechny kolem, a označuje jednotlivce zápalnou kletbou.]])

boss("Hall of Thanes", "Durgen Dirgehammer", [[Velitel vpádu Dark Iron do Old Ironforge. Podle questu je třeba vzít jeho hlavu a doručit ji králi Magnimu Bronzebeardovi. Má po boku kamenné golemy, vyvolává strach a způsobuje krvácení. Za jeho komnatou se skrývají vzácná trpasličí dědictví.]])

secrets("Hall of Thanes", [[• V komnatě Durgena Dirgehammera jsou za trezory ukryté trpasličí relikvie.
• Quest „Important Heirlooms“ chce všechna dědictví vrátit k úředníkovi u vchodu.
• Horda se sem může dostat přes tajný teleport z questové linie.
• Dungeon je lineární se čtyřmi bossy.]])

-------------------------------------------------------------------------------
-- Excavation Site: Wetlands
-------------------------------------------------------------------------------
chapters("Excavation Site: Wetlands", {
    { "Nedodělané tajemství Wetlands", [[Excavation Site: Wetlands leží nad Whelgar's Excavation Site ve Wetlands, v oblasti, která byla v klasice nepřístupná. Vchod je poblíž Thelgen Rock. Je to venkovní dungeon pro úrovně 26–33 a rozvíjí jedno z míst, které klasika slibovala, ale nikdy plně nenaplnila.]] },
    { "Titánské stroje a mlha", [[Z hor se valí mlha, na obzoru blikají podivná světla a po okolí bloudí poškozené konstrukty Titánů a stroje, které se vymkly kontrole. Zvědavý Explorers' League má na místě své zájmy – když je tu tolik prastaré techniky, nabízí se otázka, co přesně Titáni v těchto horách zanechali.]] },
    { "Hrozby v bažině", [[Okolní příroda je stejně divoká jako stroje: krokodýli, raptoři a další šelmy z bažin pronikly mezi vykopávky. Podle quest textů se v oblasti pohybuje i klan Dragonmaw. Ve hře se objevují úkoly, které tyto stopy spojují dohromady: staré hrobky, Dragonmaw a probuzené stroje.]] },
})

boss("Excavation Site: Wetlands", "Saltspine", [[První boss venkovního dungeonu.]])

boss("Excavation Site: Wetlands", "Shadetooth", [[Raptor, který se objevuje se dvěma Thicket Hunters; druhý boss dungeonu.]])

boss("Excavation Site: Wetlands", "Highland Horror", [[Třetí boss dungeonu, zrůda z vysočiny nad vykopávkami.]])

boss("Excavation Site: Wetlands", "Relic Guardian", [[Strážce relikvie, poslední boss dungeonu. Poškozený konstrukt Titánů, který stále hlídá to, co kdysi hlídat měl.]])

secrets("Excavation Site: Wetlands", [[• Vchod je pod velkým stromem v kopcích jihovýchodně od Whelgar's Excavation, přístupný od Thelgen Rock.
• Dungeon je venkovní a leží v části Wetlands, která byla v klasice nepřístupná.
• Bossové v pořadí: Saltspine, Shadetooth, Highland Horror, Relic Guardian.]])

-------------------------------------------------------------------------------
-- City of Dalaran
-------------------------------------------------------------------------------
chapters("City of Dalaran", {
    { "Návrat zmizelého města", [[City of Dalaran se objevuje v Alterac Mountains: ochranná bariéra města prý konečně padla a Dalaran se vrátil. Kirin Tor ale nemají všechno pod kontrolou. Ulice a budovy ničí arkánní anomálie a nekromanti z řad Kirin Tor a hrdinové vstupují řešit nestabilní zaklínadla, neovládané konstrukty, arkánní chaos a démonickou činnost.]] },
    { "Vstup stokami", [[Do dungeonu se vstupuje stokami: spadneš roštem v ulici a pokračuješ potrubím Underbelly až k portálu. Začínáš v Underbelly, kde bojuješ proti nekromantům Kirin Tor a jejich nemrtvým. Dungeon je téměř nelineární, takže postup volíš sám.]] },
    { "Plány na zkažené mágy", [[Quest texty se točí kolem vzorků arkánní energie, zdrojů moci a nemrtvých rytířů. Mezi bossy se podle zdrojů objevují Arcane Anomaly, Fel Ancient, Mana Devourer, Unstable Sentinel, Shade of the Archmage, Lyn the Ignored, Atrexis the Grave Knight a Mana Wraith.]] },
})

boss("City of Dalaran", "Atrexis the Grave Knight", [[Hrobový rytíř, nemrtvý bojovník, kolem kterého se točí jeden z questů dungeonu (The Grave Knight).]])

boss("City of Dalaran", "Lyn the Ignored", [[Čarodějka a jeden z bossů dungeonu.]])

boss("City of Dalaran", "Shade of the Archmage", [[Stín archmága, jeden z bossů dungeonu.]])

boss("City of Dalaran", "Mana Devourer", [[Boss dungeonu spojený s arkánním chaosem ve městě.]])

secrets("City of Dalaran", [[• Do dungeonu se vstupuje stokami: rošt v ulici, potrubí Underbelly a portál.
• Dungeon je téměř nelineární.
• Seznam bossů se u různých zdrojů liší; Atrexis the Grave Knight a Lyn the Ignored se objevují ve všech.]])

-- doplnění seznamů bossů (podle průvodců k WoW Forever)
do
    local list = WoWpoCesku_DungeonBosses["Excavation Site: Wetlands"]
    if list then
        local have = false
        for _, b in ipairs(list) do if b[1] == "Highland Horror" then have = true end end
        if not have then table.insert(list, 3, { "Highland Horror", "zrůda z vysočiny" }) end
    end
    local dal = WoWpoCesku_DungeonBosses["City of Dalaran"]
    if dal and #dal == 0 then
        for _, b in ipairs({ { "Arcane Anomaly", "arkánní anomálie" }, { "Fel Ancient", "zkažený prastarý strážce" }, { "Mana Devourer", "požírač many" },
            { "Unstable Sentinel", "nestabilní strážce" }, { "Shade of the Archmage", "stín archmága" }, { "Lyn the Ignored", "čarodějka" },
            { "Atrexis the Grave Knight", "hrobový rytíř" }, { "Mana Wraith", "přízrak many" } }) do dal[#dal + 1] = b end
    end
end

-------------------------------------------------------------------------------
-- DRUHÝ PRŮCHOD: příběhy questů nových dungeonů
-------------------------------------------------------------------------------
chapters("Ruins of Lordaeron", {
    { "Questy Hordy: příběh hlavy Barona", [[Nejzajímavější příběh Hordy začíná, když z poraženého Barona padne ohavná hlava. Jak zrůda padá, hlava se odtrhne; zdá se, že byla několikrát znovu připojena a s každým připojením držela hůř. Nese ji mistr lékárník Faranell v Undercity, který ji označí za výjimečnou: prý kdysi patřila velkému maršálovi Aliance (jméno si vybavuje jako Othmar), a sama Temná paní mu prý udělala radost, že ji poslala. Hlava prý zná tajemství, a promluví, pokud ji znovu připojí k vhodnému hostiteli.

Faranell ji uloží vedle dostupného těla v další místnosti, ale ještě nepřipojí. Pak potřebuje „motivovat“ bestii lektvarem: Toxic Skullcap od Tawny Grisette v Trade Quarter, Blisterweed od místních bylinkářů a Essence of Agony od prodejce jedů v Rogues' Quarter. Dohromady je to recept na to, jak přivázat hlavu k vůli Temné paní.]] },
    { "Questy Hordy: Světlá spravedlnost a Rath'mael", [[Forsaken paladin Morbin Lightbane vysvětluje, že nad Undercity se Plaga pořád potuluje ve velkém počtu a síly Forsaken se ztenčují. Rozkládající se maso se podle něj nedá obnovit bez náhrady, proto chce, aby hrdinové sbírali Intact Limbs v Ruins of Lordaeron. Vzpomíná na kapitána Gareka Bandariona, který by chtěl dokončit, co začal, a uzdravit své příbuzné.

Zprávy z Lordamere Overlook zase říkají, že ulice a hřbitov zalila bezbožná mlha, která pohromě poskytuje kryt. Zvědové tvrdí, že ji vyvolává nová síla mezi nemrtvými, nekromancer Rath'mael, a Forsaken si nemohou dovolit čekat.]] },
    { "Questy Aliance: dědictví, která nikdo nechce ztratit", [[Aliance sbírá relikvie. Staré insignie patřily vojákům Lordaeronu a ruiny jsou jich pravděpodobně plné: generál Marcus Jonathan ve Stormwindu je rád vezme, aby je vrátil rodinám. Hřeben Lordaeronu (Crest of Lordaeron) je zvětralý hřeben se znamením království; po pádu království jich zbylo tak málo, že po něm touží kdokoli, kdo chce zachovat historii. A krví potřísněný dopis z hřbitova odkazuje na pohřešované dítě rodiny Heartweaverů a posílá hrdiny za Orphan Matron Nightingale ve Stormwind City.]] },
})

chapters("Hall of Thanes", {
    { "Příběhy questů", [[Quest „Old Ironforge Incursion“ posílá hrdiny do jeskyní pod Old Ironforge, kde se v Hall of Thanes mají dostat až do nižších trezorů. Podle questu je tamním velitelem Durgen Dirgehammer: jeho hlavu je třeba doručit králi Magnimu Bronzebeardovi a k tomu ho pozdravit od starého přítele Farsena.

Quest „The Restless Dead“ vypráví o tom, že něco narušilo hrobky a z hlubin kleneb slyšet podivné zvuky. Duchové jsou lehcí spáči a nyní jsou vyděšení; hrdinové mají zjistit, co se děje, a pokud někdo z mrtvých procitl, uložit ho zase k spánku. Navazuje „An Ancient Grudge“, ve kterém duch jednoho z thanů prosí o pomoc pro svého pána (Faldrima Anvilmara), pohlceného prastarou záští.

A „Important Heirlooms“ uvádí komickou postavu: hlídače, který se sám raději přiznává, že se v trezorech „plížil“ a „hlídkoval“. Když z hlubin v krtčích strojích vylezla Dark Iron síla, uvědomil si, že dole leží neocenitelná kořist, alespoň „důležité kulturní dědictví“, a prosí hrdiny, aby všechna dědictví zachránili.]] },
})

-------------------------------------------------------------------------------
-- DRUHÝ PRŮCHOD: příběhy questů Excavation Site: Wetlands a City of Dalaran
-------------------------------------------------------------------------------
chapters("Excavation Site: Wetlands", {
    { "Questy: titánská relikvie", [[Hlavní nit příběhu tvoří Titan Relic, předmět, který hrdinové z vykopávek odnášejí. Aliance ho nese Prospectoru Whelgarovi do vykopávek ve Wetlands (quest Lost Relic Carry) nebo High Explorerovi Magellasovi do Hall of Explorers v Ironforge (Prehistoric Prism). Horda ho vozí na Elder Rise v Thunder Bluffu, kde má taurenským starším říct víc (Elder Knowledge), a taurenský Earthen Ring u Muln Earthfuryho na Skywatcher Plateau v Mulgore chce vědět, co všechno relikvie o zemi vypovídá (Earthen Echo).]] },
    { "Questy: Dragonmaw a odboj", [[Horda se o Dragonmawy zajímá skrz Forsaken: Deathstalker Agent ve svahu nad táborem Dragonmaw ji najde po příjezdu do Wetlands (Dragonmaw Rumors) a pak po tobě chce, abys zlikvidoval Dragonmaw uvnitř vykopávek a vrátil se s tím, co najdeš (Open the Maw).]] },
    { "Questy: Songbladeové a Grassmanové", [[Dorin Songblade hledá svého bratra Daewyna ve Whelgar's Excavation Site (Songblade Search); když ho najdeš, vrátíš se k Dorinovi (Fallen in the Fen) a dostaneš jako odměnu Daewyn's Girdle nebo Songblade Stabilizer. Caitlin Grassman z Menethil Harbor se bojí o své příbuzné: nejdřív mluvíš s ní (Seeking Caitlin), pak hledáš Ardina Grassmana v Excavation Sites (Lost in the Thicket Things) a nakonec se k Caitlin vracíš s odpovědí (Heartwoven).]] },
    { "Questy: lov", [[Prospektoři ve Wetlands potřebují i obyčejné věci: Thicket Raptor Meat (Changing Tastes) a čtyři Thicket Raptor Hides pro koželuha Jamese Hallorana v Menethil Harbor (Highland Hides, quest pro úroveň 28). Rethiel the Greenwarden žádá po zabití Highland Horrora jeho „root core“ (Horrors in the Highland).]] },
})

boss("Excavation Site: Wetlands", "Highland Horror", [[Podle questu Horrors in the Highland je to tvor, jehož „root core“ chce legendární strážce rostlin Rethiel the Greenwarden. Zrůda z vysočiny nad vykopávkami je tedy zkažená příroda, kterou je potřeba zlikvidovat.]])

boss("Excavation Site: Wetlands", "Relic Guardian", [[Hlídá Titan Relic, kolem které se točí řada questů: relikvii chtějí Prospector Whelgar, Explorers' League i taurenští starší. Je to poškozený konstrukt Titánů, který stále střeží to, co měl střežit.]])

chapters("City of Dalaran", {
    { "Questy: Kirin Tor a zkažená magie", [[Archmage Modera před Dalaranem vysílá hrdiny proti arkánním pozůstatkům: osm Seeking Remnants, osm Saturated Remnants a osm Mana Echoes (Starving Arcane) a její obraz (Image of Archmage Modera) chce Arcane Mote z města (Heart of Disruption). Aliance nese podobné úkoly mágům ve Stormwindu: Shylamiir chce Fel Infused Blossom (A Green Sample) a High Sorcerer Andromath chce, abys zabil Mana Elemental (Power Overwhelming).]] },
    { "Questy Hordy z Tarren Mill a Undercity", [[Horda dostává úkoly od svých: Magus Wordeen Voidglare v Tarren Mill chce Arcane Mote (Heart of Disruption), Melisara v Tarren Mill žádá hlavu Atrexise the Grave Knighta (The Grave Knight; odměna Gravewalker Boots nebo Undead Knight's Bracers) a Doctor Martin Felben v Undercity šest Cracked Sentry Cores (Source of Power). Rexxie Copperclutch u vchodu do stok chce knihu Founding of Dalaran z města (Opportunistic Education).]] },
})

boss("City of Dalaran", "Atrexis the Grave Knight", [[Hrobový rytíř, kterého chce Melisara z Tarren Mill porazit (quest The Grave Knight). Za jeho porážku dostaneš Gravewalker Boots nebo Undead Knight's Bracers.]])

secrets("City of Dalaran", [[• Rexxie Copperclutch u stok chce knihu Founding of Dalaran.
• Atrexis the Grave Knight dává Gravewalker Boots a Undead Knight's Bracers.
• Cracked Sentry Cores sbírá Doctor Martin Felben z Undercity.]])
