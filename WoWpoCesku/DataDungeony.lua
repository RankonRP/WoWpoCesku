-- WoWpoCesku: Kronika Azerothu – dungeony a raidy (klíč = název instance ze hry)
-- Stránka se otevře při vstupu do instance stejně jako u oblastí.

local D = WoWpoCesku_Lore
local A = WoWpoCesku_LoreAlias

D["Ragefire Chasm"] = {
    title = "Ragefire Chasm", tag = "Lávové jeskyně přímo pod Orgrimmarem – první dungeon Hordy (levely 13–18).",
    ch = {
        { "Příběh", [[Pod Orgrimmarem se táhnou sopečné jeskyně, ve kterých se usadili troggové a kultisté Searing Blade – odnož Burning Blade, která uctívá démony. Thrall chce vědět, kdo je vede a co chystají přímo pod jeho trůnem. Vchod je v Cleft of Shadow.]] },
        { "Bossové", [[• Oggleflint – vůdce troggů
• Taragaman the Hungerer – démon, kterému kultisté slouží
• Jergosh the Invoker – čaroděj kultu
• Bazzalan – satyr, který kult řídí]] },
        { "Tipy a zajímavosti", [[• Krátký dungeon, ideální na první pokus o skupinu.
• Questy dostaneš v Orgrimmaru (mimo jiné od Rahauro v Thunder Bluff a od lidí v Cleft of Shadow).
• Pozor na lávu – nedá se v ní stát.]] },
    },
}

D["Wailing Caverns"] = {
    title = "Wailing Caverns", tag = "Jeskyně nářků v Barrens, kde se sen druidů proměnil v noční můru (levely 15–25).",
    ch = {
        { "Příběh", [[Druid Naralex chtěl silou Smaragdového snu zazelenat Barrens. Ve snu ho ale zachvátila Noční můra a jeho žáci, Druidové Fangu, se zkazili. Z jeskyní se šíří zmutovaná „deviate“ zvířata. Jeden věrný žák, Disciple of Naralex, čeká u vchodu na pomoc.]] },
        { "Bossové", [[• Lady Anacondra, Lord Cobrahn, Lord Pythas a Lord Serpentis – čtyři Druidové Fangu
• Kresh – obří želva
• Skum – zmutovaný ještěr
• Verdan the Everliving – obří rostlinná bytost
• Mutanus the Devourer – objeví se při probouzení Naralexe
• Deviate Faerie Dragon – vzácný drak]] },
        { "Tipy a zajímavosti", [[• Po zabití všech čtyř Druidů Fangu promluv s Disciple of Naralex u vchodu – doprovodíš ho k Naralexovi a probudíš ho.
• Jeskyně jsou bludiště, drž se skupiny.
• Z deviate ryb (Deviate Fish) se dá uvařit jídlo, které tě náhodně promění. Kuchaři ho milují.]] },
    },
}

D["The Deadmines"] = {
    title = "The Deadmines", tag = "Skrýš Bratrstva Defias pod Moonbrookem (levely 17–26).",
    ch = {
        { "Příběh", [[Edwin VanCleef, kdysi mistr kameníků, kterým šlechta nezaplatila za obnovu Stormwindu, ukryl Bratrstvo Defias v dolech pod Moonbrookem. V obří jeskyni na konci staví válečnou loď, se kterou chce na Stormwind zaútočit.]] },
        { "Bossové", [[• Rhahk'Zor – ogr, který hlídá první dveře
• Miner Johnson – vzácný horník
• Sneed's Shredder a Sneed – goblin v obřím stroji
• Gilnid – goblinský tavič
• Mr. Smite – tauren, první důstojník, v boji mění zbraně
• Captain Greenskin – kapitán lodi
• Edwin VanCleef – vůdce Bratrstva
• Cookie – murlok kuchař]] },
        { "Tipy a zajímavosti", [[• Dveře do jeskyně s lodí vyhodí do vzduchu dělo Defias – stačí ho použít.
• Z VanCleefa padá An Unsent Letter, který spustí další questy ve Stormwindu.
• Questy dostaneš na Sentinel Hill ve Westfallu.]] },
    },
}
A["Deadmines"] = "The Deadmines"

D["Shadowfang Keep"] = {
    title = "Shadowfang Keep", tag = "Hrad arcimága Arugala nad Silverpine Forest (levely 22–30).",
    ch = {
        { "Příběh", [[Arcimág Arugal z Dalaranu vyvolal worgeny, aby bojovali proti Pohromě, a ztratil nad nimi kontrolu. Usadil se s nimi v hradě barona Silverlaina, kterého zabil, a worgenům říká „své děti“.]] },
        { "Bossové", [[• Rethilgore – stráž kobek
• Razorclaw the Butcher
• Baron Silverlaine – duch bývalého pána hradu
• Commander Springvale – padlý paladin
• Odo the Blindwatcher
• Fenrus the Devourer – obří vlk
• Wolf Master Nandos
• Archmage Arugal
• Deathsworn Captain – vzácný]] },
        { "Tipy a zajímavosti", [[• V kobkách jsou vězni (Sorcerer Ashcrombe pro Alianci, Deathstalker Adamant pro Hordu) – otevřou ti dveře na nádvoří.
• Arugal se teleportuje po místnosti, nestůjte na jednom místě.]] },
    },
}

D["Blackfathom Deeps"] = {
    title = "Blackfathom Deeps", tag = "Zatopený chrám na pobřeží Ashenvale (levely 20–30).",
    ch = {
        { "Příběh", [[Starý chrám nočních elfů, zasvěcený Elune, se po Velkém rozpoltění potopil. Dnes se v něm usadili nagové a kult Twilight's Hammer, který tu uctívá Staré bohy a jejich obří hydru Aku'mai.]] },
        { "Bossové", [[• Ghamoo-ra – obří želva
• Lady Sarevess – naga
• Gelihast – murlok
• Lorgus Jett – kultista
• Baron Aquanis – vodní elementál
• Twilight Lord Kelris – vůdce kultu
• Old Serra'kis – obří žralok
• Aku'mai – hydra Starých bohů]] },
        { "Tipy a zajímavosti", [[• Hodně plavání – lektvary na dýchání pod vodou se hodí.
• Před Aku'mai zapálíte čtyři ohně u sochy – každý přivolá vlnu nepřátel.]] },
    },
}

D["The Stockade"] = {
    title = "The Stockade", tag = "Vězení Stormwindu, kde se vzbouřili vězni (levely 22–30).",
    ch = {
        { "Příběh", [[Ve vězení uprostřed Stormwindu se vzbouřili vězni pod vedením Defiasů. Stráže drží jen vchod a hledají dobrodruhy, kteří vzpouru potlačí.]] },
        { "Bossové", [[• Targorr the Dread
• Kam Deepfury – Dark Iron
• Hamhock
• Bazil Thredd – vůdce vzpoury, spojený s VanCleefem
• Dextren Ward
• Bruegal Ironknuckle – vzácný]] },
        { "Tipy a zajímavosti", [[• Krátký dungeon s hodně nepřáteli ve stísněných chodbách.
• Bazil Thredd navazuje na příběh VanCleefova dopisu.]] },
    },
}
A["Stormwind Stockade"] = "The Stockade"

D["Gnomeregan"] = {
    title = "Gnomeregan", tag = "Ztracené město gnómů, plné troggů, robotů a radiace (levely 24–34).",
    ch = {
        { "Příběh", [[Gnomeregan byl technickým zázrakem, dokud ho nezaplavili troggové z hlubin. Na radu Sicca Thermaplugga vypustili gnómové do města jedovaté záření – a zabili tím i velkou část vlastního lidu. Thermaplugg se pak prohlásil králem toho, co zbylo.]] },
        { "Bossové", [[• Grubbis – trogg s krokodýlem
• Viscous Fallout – radioaktivní sliz
• Electrocutioner 6000 – robot
• Crowd Pummeler 9-60 – robot v aréně
• Dark Iron Ambassador – vzácný
• Mekgineer Thermaplugg – zrádce]] },
        { "Tipy a zajímavosti", [[• Do Gnomereganu vede i zadní vchod výtahem (pro Hordu z Dun Morogh).
• Děrné štítky (Punchcards) – sbírej je a vlož do Matrix Punchograph 3005 pro sérii questů.
• Pozor na radiaci (Irradiated).]] },
    },
}

D["Razorfen Kraul"] = {
    title = "Razorfen Kraul", tag = "Trnité bludiště kančích lidí na jihu Barrens (levely 25–35).",
    ch = {
        { "Příběh", [[Kančí lidé (quilboar) žijí v obrovských trnitých kořenech, které vyrostly z těla poloboha Agamaggana. Vede je Charlga Razorflank, mocná kněžka, která chce kančí lidi sjednotit.]] },
        { "Bossové", [[• Roogug
• Aggem Thorncurse
• Death Speaker Jargba
• Overlord Ramtusk
• Agathelos the Raging – obří kanec
• Charlga Razorflank
• Blind Hunter a Earthcaller Halmgar – vzácní]] },
        { "Tipy a zajímavosti", [[• Uvnitř je uvězněný Willix the Importer – doprovoď ho ven.
• Bludiště chodeb, mapa se hodí.]] },
    },
}

D["Scarlet Monastery"] = {
    title = "Scarlet Monastery", tag = "Klášter Šarlatového křižáckého řádu v Tirisfalu – čtyři křídla (levely 26–45).",
    ch = {
        { "Příběh", [[Šarlatový křižácký řád vznikl z rytířů, kteří přežili Pohromu – a z jejich zuřivosti. Každého, kdo není jako oni, považují za nemrtvého nebo zrádce. Klášter je jejich pevností.]] },
        { "Bossové", [[• Hřbitov (Graveyard): Interrogator Vishas, Bloodmage Thalnos (vzácní Ironspine, Azshir the Sleepless, Fallen Champion)
• Knihovna (Library): Houndmaster Loksey, Arcanist Doan
• Zbrojnice (Armory): Herod
• Katedrála (Cathedral): High Inquisitor Fairbanks, Scarlet Commander Mograine, High Inquisitor Whitemane]] },
        { "Tipy a zajímavosti", [[• Do zbrojnice a katedrály potřebuješ Scarlet Key z knihovny.
• Když porazíte Mograina, přiběhne Whitemane a vzkřísí ho slavným „Arise, my champion!“.
• Herod křičí „Blades of Light!“ a točí se jako vír – utíkejte.]] },
    },
}

D["Razorfen Downs"] = {
    title = "Razorfen Downs", tag = "Kančí lidé v područí Pohromy, na hranici Barrens (levely 35–45).",
    ch = {
        { "Příběh", [[Lich Amnennar the Coldbringer převádí kančí lidi na stranu Pohromy. Drak Belnistrasz z bronzového rodu chce jeho rituál zastavit.]] },
        { "Bossové", [[• Tuten'kash – obří pavouk (přivolá ho gong)
• Mordresh Fire Eye
• Glutton
• Ragglesnout – vzácný
• Plaguemaw the Rotting
• Amnennar the Coldbringer – lich]] },
        { "Tipy a zajímavosti", [[• Quest Extinguishing the Idol – braňte Belnistrasze, zatímco ruší modlu.
• Tuten'kash je odkaz na Tutanchamona.]] },
    },
}

D["Uldaman"] = {
    title = "Uldaman", tag = "Trezor titánů v Badlands, kde se skrývá původ trpaslíků (levely 35–47).",
    ch = {
        { "Příběh", [[Uldaman postavili titáni. Trpaslíci z Explorers' League tu hledají Disky Norgannona, které prozrazují, že trpaslíci pocházejí z kamenných earthen. Dark Ironové a troggové jim jdou po krku.]] },
        { "Bossové", [[• Revelosh
• Baelog, Eric „The Swift“ a Olaf – ztracení trpaslíci
• Ironaya – kamenná strážkyně
• Obsidian Sentinel
• Ancient Stone Keeper
• Galgann Firehammer
• Grimlok
• Archaedas – kamenný obr na konci]] },
        { "Tipy a zajímavosti", [[• Baelog, Eric a Olaf jsou odkaz na hru The Lost Vikings od Blizzardu!
• Disk Norgannona tě provede jedním z nejdůležitějších příběhů o trpaslících.]] },
    },
}

D["Zul'Farrak"] = {
    title = "Zul'Farrak", tag = "Trollí město v poušti Tanaris (levely 44–54).",
    ch = {
        { "Příběh", [[Trollové Sandfury přežili v poušti díky kruté magii a uctívání hydry Gahz'rilla. Drží zajatce a připravují rituály.]] },
        { "Bossové", [[• Antu'sul
• Theka the Martyr
• Witch Doctor Zum'rah
• Nekrum Gutchewer a Shadowpriest Sezz'ziz
• Hydromancer Velratha
• Gahz'rilla – hydra (přivolá ji Mallet of Zul'Farrak u gongu)
• Chief Ukorz Sandscalp a Ruuzlu
• Zerillis – vzácný]] },
        { "Tipy a zajímavosti", [[• Slavná bitva na schodech: osvoboď Sergeanta Blye a jeho druhy z klece a pak společně odrážejte vlny trollů.
• Z dungeonu padá Carrot on a Stick – trinket na rychlejší jízdu.]] },
    },
}

D["Maraudon"] = {
    title = "Maraudon", tag = "Jeskyně Theradras a Zaetara v Desolace (levely 46–55).",
    ch = {
        { "Příběh", [[Zaetar, syn Cenaria, a princezna země Theradras měli děti – kentaury, kteří otce zabili. Theradras ho pohřbila v Maraudonu a dodnes tu truchlí. Její žal zkazil celé jeskyně.]] },
        { "Bossové", [[• Noxxion
• Razorlash
• Lord Vyletongue
• Celebras the Cursed
• Landslide
• Tinkerer Gizlock
• Rotgrip
• Princess Theradras
• Meshlok the Harvester – vzácný]] },
        { "Tipy a zajímavosti", [[• Scepter of Celebras otevře portál, který zkrátí cestu dovnitř.
• Po zabití Theradras se objeví duch Zaetara.]] },
    },
}

D["Sunken Temple"] = {
    title = "Sunken Temple", tag = "Potopený chrám Atal'Hakkar v Swamp of Sorrows (levely 50–56).",
    ch = {
        { "Příběh", [[Kněží Atal'ai chtěli vyvolat krvavého boha Hakkara. Ysera chrám potopila do bažiny a drak Eranikus ho hlídá – jenže jeho mysl ovládla Noční můra.]] },
        { "Bossové", [[• Atal'alarion – strážce (sochy v hádance)
• Dreamscythe a Weaver – zelení draci
• Jammal'an the Prophet a Ogom the Wretched
• Morphaz a Hazzas
• Avatar of Hakkar
• Shade of Eranikus]] },
        { "Tipy a zajímavosti", [[• Šest trollích kněží na balkonech je třeba porazit, aby se otevřela cesta.
• Avatara Hakkara přivoláte díky předmětu Egg of Hakkar z questové řady.]] },
    },
}
A["The Temple of Atal'Hakkar"] = "Sunken Temple"
A["Temple of Atal'Hakkar"] = "Sunken Temple"

D["Blackrock Depths"] = {
    title = "Blackrock Depths", tag = "Podzemní říše Dark Ironů pod Blackrock Mountain (levely 52–60).",
    ch = {
        { "Příběh", [[Hluboko pod horou leží město Shadowforge, sídlo Dark Ironů a jejich císaře Dagrana Thaurissana. Vládne mu ale Ragnaros, pán ohně, kterého kdysi vyvolal jeho předek. Ve městě je i princezna Moira, dcera krále Magniho.]] },
        { "Bossové", [[• High Interrogator Gerstahn, Lord Roccor, Houndmaster Grebmar
• Ring of Law – aréna, kde bojuješ s náhodnými soupeři
• Pyromancer Loregrain, Lord Incendius, Fineous Darkvire
• Bael'Gar, General Angerforge, Golem Lord Argelmach
• Hurley Blackbreath a Plugger Spazzring (hospoda Grim Guzzler)
• Ambassador Flamelash, Magmus
• Emperor Dagran Thaurissan a Princess Moira Bronzebeard]] },
        { "Tipy a zajímavosti", [[• Grim Guzzler – hospoda uprostřed dungeonu. Ukradni pivo Dark Iron Ale a uvidíš, co se stane.
• Shadowforge Key otevře velkou část dungeonu.
• Quest Attunement to the Core: úlomek z jádra tě pustí do Molten Core.]] },
    },
}

D["Blackrock Spire"] = {
    title = "Blackrock Spire", tag = "Pevnost klanu Blackrock a černých draků v hoře (levely 55–60).",
    ch = {
        { "Příběh", [[Horní část hory drží orkové klanu Blackrock pod Warchiefem Rendem Blackhandem. Za nimi stojí černý drak Nefarian a jeho generál Drakkisath.]] },
        { "Bossové", [[• Dolní část: Highlord Omokk, Shadow Hunter Vosh'gajin, War Master Voone, Mother Smolderweb, Urok Doomhowl, Quartermaster Zigris, Halycon, Gizrul the Slavener, Overlord Wyrmthalak
• Horní část: Pyroguard Emberseer, Solakar Flamewreath, Goraluk Anvilcrack, Warchief Rend Blackhand a Gyth, The Beast, General Drakkisath]] },
        { "Tipy a zajímavosti", [[• Do horní části potřebuješ pečeť Seal of Ascension.
• Drakkisathův znak je potřeba pro vstup do Blackwing Lair.]] },
    },
}

D["Dire Maul"] = {
    title = "Dire Maul", tag = "Ruiny elfího města Eldre'Thalas ve Feralas (levely 55–60).",
    ch = {
        { "Příběh", [[Eldre'Thalas bylo městem Highborne, kteří přežili Velké rozpoltění. Aby si udrželi magii, uvěznili démona Immol'thara a čerpali z něj sílu. Dnes je město rozdělené mezi ogry, satyry a poslední Highborne.]] },
        { "Bossové", [[• Východ: Pusillin, Zevrim Thornhoof, Hydrospawn, Lethtendris, Alzzin the Wildshaper
• Západ: Tendris Warpwood, Illyanna Ravenoak, Magister Kalendris, Immol'thar, Prince Tortheldrin
• Sever: Guard Mol'dar, Stomper Kreeg, Guard Fengus, Guard Slip'kik, Captain Kromcrush, King Gordok]] },
        { "Tipy a zajímavosti", [[• Pusillin – skřítek, kterého honíš celým východním křídlem. Má u sebe Crescent Key.
• „Tribute run“ v severní části: projdi bez zabití stráží a král ogrů ti dá poklad.
• V knihovně Shen'dralar najdeš knihy (librams) na vylepšení výstroje.]] },
    },
}

D["Scholomance"] = {
    title = "Scholomance", tag = "Škola nekromancie pod Caer Darrow (levely 58–60).",
    ch = {
        { "Příběh", [[Rod Barovů prodal svůj hrad Kultu zatracených. Pod ním vznikla Scholomance, kde se učí noví nekromanti Pohromy pod vedením Darkmastera Gandlinga.]] },
        { "Bossové", [[• Kirtonos the Herald (přivolá ho Blood of Innocents)
• Jandice Barov, Rattlegore, Marduk Blackpool, Vectus
• Ras Frostwhisper – lich
• Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian
• Lord Alexei Barov a Lady Illucia Barov
• Darkmaster Gandling]] },
        { "Tipy a zajímavosti", [[• Do školy potřebuješ Skeleton Key.
• Gandling teleportuje hráče do zamčených místností.]] },
    },
}

D["Stratholme"] = {
    title = "Stratholme", tag = "Prokleté město, kde Arthas začal svou cestu do temnoty (levely 58–60).",
    ch = {
        { "Příběh", [[Tady Arthas nechal vyvraždit obyvatele, aby se nestali nemrtvými. Dnes je město rozdělené: v živé části drží Šarlatoví, v nemrtvé vládne baron Rivendare.]] },
        { "Bossové", [[• Živá část: The Unforgiven, Timmy the Cruel, Cannon Master Willey, Archivist Galford, Balnazzar (skrytý za Grand Crusader Dathrohan)
• Nemrtvá část: Magistrate Barthilas, Nerub'enkan, Baroness Anastari, Maleki the Pallid, Ramstein the Gorger, Baron Rivendare
• Postmaster Malown – přivoláš ho poštovními klíči]] },
        { "Tipy a zajímavosti", [[• Baron run: když se dostaneš k baronovi do 45 minut, zachráníš Ysidu Harmon.
• Z barona vzácně padá kůň Deathcharger.
• SPOILER: Grand Crusader Dathrohan je ve skutečnosti démon Balnazzar.]] },
    },
}

D["Molten Core"] = {
    title = "Molten Core", tag = "Ohnivé srdce hory – raid pro 40 hráčů s Ragnarosem na konci.",
    ch = {
        { "Příběh", [[Hluboko pod Blackrock Mountain sídlí Ragnaros, pán ohně, kterého vyvolal Thaurissan na konci Války tří kladiv. Jeho služebníci tu hlídají cestu k jeho trůnu.]] },
        { "Bossové", [[• Lucifron, Magmadar, Gehennas, Garr
• Shazzrah, Baron Geddon, Golemagg the Incinerator
• Sulfuron Harbinger
• Majordomo Executus
• Ragnaros]] },
        { "Tipy a zajímavosti", [[• Runy u bossů je třeba uhasit pomocí Aqual Quintessence od Duka Hydraxise (Azshara).
• Ragnarosovo „TOO SOON!“ a „BY FIRE BE PURGED!“ zná každý hráč klasiky.
• Baron Geddon z vás udělá bombu – utíkejte od skupiny.]] },
    },
}

D["Onyxia's Lair"] = {
    title = "Onyxia's Lair", tag = "Doupě černé dračice v Dustwallow Marsh – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Onyxia, dcera Deathwinga, se ve Stormwindu vydává za lady Prestor. Ve svém doupěti v Dustwallow Marsh na ni hrdinové čekají v pravé podobě.]] },
        { "Bossové", [[• Onyxia – tři fáze: na zemi, ve vzduchu (s mláďaty) a znovu na zemi]] },
        { "Tipy a zajímavosti", [[• Slavná nahrávka „Many whelps! Handle it!“ a „50 DKP minus!“ pochází odtud.
• Deep Breath – ohnivý dech přes celou jeskyni. Nestůjte před ní.
• Hlava Onyxie dá celému městu buff.]] },
    },
}

D["Blackwing Lair"] = {
    title = "Blackwing Lair", tag = "Laboratoř Nefariana na vrcholu Blackrock Spire – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Nefarian, syn Deathwinga, tu vytváří chromatické draky ze všech dračích rodů. Jeho zajatcem je i rudý drak Vaelastrasz, kterého Nefarian zkazil.]] },
        { "Bossové", [[• Razorgore the Untamed
• Vaelastrasz the Corrupt
• Broodlord Lashlayer
• Firemaw, Ebonroc, Flamegor
• Chromaggus
• Nefarian]] },
        { "Tipy a zajímavosti", [[• Vaelastrasz vám na začátku dá buff, který vás pomalu zabíjí – smutný souboj s dobrým drakem.
• Na Nefariana potřebujete Onyxia Scale Cloak proti jeho ohni.]] },
    },
}

D["Zul'Gurub"] = {
    title = "Zul'Gurub", tag = "Hlavní město trollů Gurubashi ve Stranglethorn – raid pro 20 hráčů.",
    ch = {
        { "Příběh", [[Kněží Atal'ai vyvolali krvavého boha Hakkara. Jeho velekněží, kteří získali sílu zvířecích bohů, mu slouží v srdci džungle.]] },
        { "Bossové", [[• High Priestess Jeklik (netopýr), High Priest Venoxis (had), High Priestess Mar'li (pavouk)
• Bloodlord Mandokir
• Edge of Madness – náhodný boss
• Gahz'ranka – vyloví se rybařením
• High Priest Thekal (tygr), High Priestess Arlokk (panter)
• Jin'do the Hexxer
• Hakkar the Soulflayer]] },
        { "Tipy a zajímavosti", [[• Z Mandokira padá Swift Razzashi Raptor a z Thekala Swift Zulian Tiger – vzácné mounty.
• Hakkar kdysi nechtěně rozšířil „krvavý mor“ po celém serveru – slavná chyba z roku 2005.]] },
    },
}

D["Ruins of Ahn'Qiraj"] = {
    title = "Ruins of Ahn'Qiraj", tag = "Vnější ruiny pevnosti Qiraji v Silithu – raid pro 20 hráčů.",
    ch = {
        { "Příběh", [[Po otevření Scarab Wall vede Cenarion Circle útok do ruin. Qiraji tu hlídají cestu k chrámu, kde spí Starý bůh C'Thun.]] },
        { "Bossové", [[• Kurinnaxx, General Rajaxx, Moam
• Buru the Gorger, Ayamiss the Hunter
• Ossirian the Unscarred]] },
        { "Tipy a zajímavosti", [[• Ossiriana oslabíte krystaly, které se objevují po místnosti.
• General Rajaxx má s sebou armádu – a s vámi bojuje i Lieutenant General Andorov.]] },
    },
}

D["Ahn'Qiraj Temple"] = {
    title = "Temple of Ahn'Qiraj", tag = "Chrám, kde spí Starý bůh C'Thun – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Uvnitř chrámu vládnou císaři Vek'lor a Vek'nilash a pod nimi spí C'Thun, Starý bůh, který stojí za silithidy i Qiraji.]] },
        { "Bossové", [[• The Prophet Skeram
• Silithid Royalty (tři brouci)
• Battleguard Sartura, Fankriss the Unyielding, Viscidus
• Princess Huhuran
• Twin Emperors – Vek'lor a Vek'nilash
• Ouro
• C'Thun]] },
        { "Tipy a zajímavosti", [[• C'Thun vám šeptá do hlavy („You will die.“) – zprávy se objevují v chatu.
• Viscidus se musí zmrazit a pak rozbít.]] },
    },
}
A["Temple of Ahn'Qiraj"] = "Ahn'Qiraj Temple"
A["Ahn'Qiraj"] = "Ahn'Qiraj Temple"

D["Naxxramas"] = {
    title = "Naxxramas", tag = "Létající nekropole Kel'Thuzada – poslední raid klasiky (40 hráčů).",
    ch = {
        { "Příběh", [[Nad Eastern Plaguelands se vznáší Naxxramas, citadela Pohromy. Vládne jí lich Kel'Thuzad, který odsud řídí nemrtvé armády Lich Kinga.]] },
        { "Bossové", [[• Pavoučí křídlo: Anub'Rekhan, Grand Widow Faerlina, Maexxna
• Morové křídlo: Noth the Plaguebringer, Heigan the Unclean, Loatheb
• Vojenské křídlo: Instructor Razuvious, Gothik the Harvester, Four Horsemen
• Konstrukční křídlo: Patchwerk, Grobbulus, Gluth, Thaddius
• Sapphiron – nemrtvý drak
• Kel'Thuzad]] },
        { "Tipy a zajímavosti", [[• Heiganův „tanec“ – utíkání před výbuchy v rytmu, noční můra mnoha raidů.
• Thaddius rozdělí raid na plus a minus náboj – stůjte se stejným znaménkem.
• SPOILER: Kel'Thuzad po porážce uteče do Northrendu.]] },
    },
}

-- Nové dungeony WoW Forever (zatím o nich víme málo)
D["Hall of Thanes"] = {
    title = "Hall of Thanes", tag = "Nový dungeon WoW Forever (levely 13–18).",
    ch = {
        { "Novinka WoW Forever", [[Tento dungeon v klasickém WoW nebyl – přidal ho WoW Forever. Zatím o něm víme jen to, že je pro levely 13–18. Až v něm budeš, napiš mi, co jsi viděl, a doplním ho do kroniky.]] },
    },
}
D["Wetlands Excavation Site"] = {
    title = "Wetlands Excavation Site", tag = "Nový dungeon WoW Forever ve Wetlands (levely 24–29).",
    ch = {
        { "Novinka WoW Forever", [[Nový dungeon ve Wetlands, který v klasice nebyl. Podle názvu jde o vykopávky – nejspíš souvisí s badateli z Explorers' League. Až ho navštívíš, napiš mi, co v něm je.]] },
    },
}
D["Alcaz Prison"] = {
    title = "Alcaz Prison", tag = "Nový dungeon WoW Forever na ostrově Alcaz (levely 48–53).",
    ch = {
        { "Novinka WoW Forever", [[Vězení na ostrově Alcaz u pobřeží Theramore. Má navazovat na příběh Bratrstva Defias a mluví se o souvislosti s králem Varianem. Zatím jde spíš o pověsti – až tam budeš, napiš mi.]] },
    },
}
