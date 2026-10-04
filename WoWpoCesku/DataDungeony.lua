-- WoWpoCesku: Kronika Azerothu – dungeony a raidy (klíč = název instance ze hry)
-- Stránka se otevře při vstupu do instance stejně jako u oblastí.

local D = WoWpoCesku_Lore
local A = WoWpoCesku_LoreAlias

D["Ragefire Chasm"] = {
    title = "Ragefire Chasm", tag = "Lávové jeskyně přímo pod Orgrimmarem – první dungeon Hordy (levely 13–18).",
    ch = {
        { "Sopečné jeskyně", [[Ragefire Chasm je sopečná jeskyně přímo pod Orgrimmarem. Vchod je v temné rokli Cleft of Shadow a uvnitř teče láva, z puklin stoupá dým a v hlubinách žijí tvorové, kteří se Hordě nikdy nepodřídili.]] },
        { "Troggové", [[Z hlubin jeskyně vylezli troggové z Ragefire. Šamani Hordy se s nimi pokoušeli uzavřít mír, ale narazili jen na nepřátelství. Kdyby je Horda nechala být, mohli by se stát hrozbou pro celý Orgrimmar.]] },
        { "Kult Searing Blade", [[V jeskyni si zřídila základnu sekta Searing Blade – odnož Shadow Council, tajné rady čarodějů, kteří slouží démonům. Jejich cílem je svrhnout a zničit všechno, co Horda v Durotaru vybudovala.

Vedou je tři postavy: Taragaman the Hungerer, mocný démon felguard, Jergosh the Invoker, čaroděj, a Bazzalan, satyr. Troggy vede Oggleflint.]] },
        { "Zrádce v Orgrimmaru", [[Nejhorší na tom je, že kult má spojence přímo ve městě. Neeru Fireblade z Cleft of Shadow je ve skutečnosti skrytým vůdcem klanu Burning Blade. Do jeskyně posílal Thrallovy věrné, aby se jich zbavil – a zároveň vyzkoušel, jak silní kultisté Searing Blade jsou.

Válečný náčelník nakonec vyslal dobrodruhy, aby vůdce kultu zlikvidovali. Ragefire Chasm je tak první místo, kde mladí hrdinové Hordy zjistí, že nepřítel může číhat i pod jejich vlastním městem.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Ragefire Chasm"] = [[• Krátký dungeon, ideální na první pokus o skupinu.
• Questy dostaneš v Orgrimmaru (Cleft of Shadow) a v Thunder Bluff (Rahauro).
• Pozor na lávu – nedá se v ní stát.]]

D["Wailing Caverns"] = {
    title = "Wailing Caverns", tag = "Jeskyně nářků v Barrens, kde se sen druidů proměnil v noční můru (levely 15–25).",
    ch = {
        { "Jeskyně nářků", [[Wailing Caverns jsou rozlehlé jeskyně jihozápadně od Crossroads v Barrens. Jméno dostaly podle podivného kvílení, které z nich vychází – vítr v puklinách zní jako nářek. Z jeskyní vyvěrají prameny, které napájejí oázy kolem.]] },
        { "Naralexův sen", [[Druid Naralex z rodu nočních elfů jeskyně objevil a rozhodl se, že skrze ně propojí podzemní vody přímo se Smaragdovým snem. Doufal, že tak vyprahlé Barrens znovu zazelená.

Ve snu ho ale zachvátila Smaragdová noční můra. Naralex se nedokázal probudit a jeho spící mysl začala do jeskyní šířit zkaženou energii Noční můry.]] },
        { "Druidové Fangu", [[Naralexovi žáci se pod vlivem Noční můry změnili v Druidy Fangu – zkažené druidy, kteří Noční můře slouží. Vedou je čtyři Fanglordi: Lady Anacondra v Screaming Gully, Lord Cobrahn a Lord Pythas v Pit of Fangs a Lord Serpentis v Crag of the Everliving.

Zkaženou energií zmutovala i zvířata. Jeskyně jsou plné „deviate“ tvorů – raptorů, hadů i krokodýlů, kteří vypadají, jako by vylezli z noční můry.]] },
        { "Probuzení Naralexe", [[Jeden Naralexův žák zůstal věrný a čeká u vchodu do jeskyně. Když hrdinové porazí všechny čtyři Fanglordy, doprovodí ho k Naralexovi a chrání ho, zatímco se ho pokouší probudit. Přitom se z hlubin vynoří zrůdy Noční můry – a nakonec i obří murlok Mutanus the Devourer.

V jeskyních žijí i další bytosti: rostlinný obr Verdan the Everliving, mírumilovná želva Kresh a zmutovaný ještěr Skum.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Wailing Caverns"] = [[• Po zabití všech čtyř Druidů Fangu promluv s Disciple of Naralex u vchodu – doprovodíš ho k Naralexovi a probudíš ho.
• Jeskyně jsou bludiště, drž se skupiny.
• Z deviate ryb (Deviate Fish) se dá uvařit jídlo, které tě náhodně promění. Kuchaři ho milují.]]

D["The Deadmines"] = {
    title = "The Deadmines", tag = "Skrýš Bratrstva Defias pod Moonbrookem (levely 17–26).",
    ch = {
        { "Zlatý důl Stormwindu", [[Před První válkou byly Deadmines největším zlatým dolem lidských zemí. Jejich zlato tvořilo třetinu pokladu království Stormwind a v okolí se těžilo i vzácné dřevo Whitestone oak, které se používalo při stavbách. Za První války byly doly opuštěny.]] },
        { "Skrýš Bratrstva", [[Po válce si doly vzalo Bratrstvo Defias – kdysi dělníci a kameníci, dnes lupiči. Jejich vůdce Edwin VanCleef tu s pomocí goblinů staví v hlubinách obrovskou válečnou loď Juggernaut, se kterou chce zaútočit na Stormwind.

Ještě nedávno tu pracoval spolek Miners' League pod vedením předáka Thistlenettla. Když Defiasové zaútočili, část tunelu se zřítila a horníci, kteří v něm zahynuli, se proměnili v neklidné mrtvé.]] },
        { "Důstojníci VanCleefa", [[VanCleefovi slouží ogr Rhahk'Zor, který hlídá první dveře, goblinský dřevař Sneed se svým obřím strojem Shredder, goblinský tavič Gilnid, tauren Mr. Smite, který v boji mění zbraně, a kapitán lodi Greenskin. V kuchyni lodi vaří murlok Cookie.

Na konci obří jeskyně u moře stojí loď Juggernaut – a na ní čeká sám Edwin VanCleef.]] },
        { "Piráti a konec", [[Podle jednoho příběhu vtrhl do dolů pirát Jerias Bloodvein, aby se VanCleefovi pomstil za podvod. Při útoku padli Rhahk'Zor, Sneed i Gilnid a mladík James Blackridge, kterého piráti kdysi unesli od westfallského majáku, Jeriase nakonec zabil.

V klasickém WoW posílá Gryan Stoutmantle dobrodruhy, aby VanCleefa zabili a přinesli jeho hlavu jako důkaz. Z VanCleefa padá i dopis, který nikdy neodeslal – a ten vede až ke Stormwindu.]] },
    },
}
WoWpoCesku_LoreTajemstvi["The Deadmines"] = [[• Dveře do jeskyně s lodí vyhodí do vzduchu dělo Defias – stačí ho použít.
• Z VanCleefa padá An Unsent Letter, který spustí další questy ve Stormwindu.
• Questy dostaneš na Sentinel Hill ve Westfallu.]]
A["Deadmines"] = "The Deadmines"

D["Shadowfang Keep"] = {
    title = "Shadowfang Keep", tag = "Hrad arcimága Arugala nad Silverpine Forest (levely 22–30).",
    ch = {
        { "Silverlaine Keep", [[Shadowfang Keep se kdysi jmenoval Silverlaine Keep a byl domovem barona Silverlaina a jeho rodiny v království Gilneas. Páni hradu podléhali rodu Crowleyů a spravovali i vesnici Pyrewood pod hradem.]] },
        { "Arugalův omyl", [[Za Třetí války zkoumal královský arcimág Arugal výzkum mága jménem Ur a s požehnáním krále Genna Greymana vyvolal worgeny, aby bojovali proti Pohromě.

Worgeni se ale vymkli kontrole. Napadli gilnejské vojsko, zaplavili hrad a zabili barona Silverlaina i celou jeho domácnost. Arugal, zdrcený vinou, přijal worgeny jako „své děti“, stáhl se do hradu a pojmenoval ho Shadowfang Keep.]] },
        { "Vlčí kult", [[Arugal proměnil obyvatele Silverpine Forest ve worgeny – hlavně smečky Moonrage a Shadowfang. Obyvatelé Pyrewood Village podlehli kletbě také: ve dne jsou lidmi a v noci šelmami. Všichni slouží Arugalovu vlčímu kultu.

V hradu žije i duch barona Silverlaina, padlý paladin Commander Springvale ze Stříbrné ruky a Arugalovi služebníci – Wolf Master Nandos, Razorclaw the Butcher, Odo the Blindwatcher a Rethilgore.]] },
        { "Vězni a konec", [[V kobkách hradu drží vězně – pro Alianci čaroděje Ashcrombeho, pro Hordu Deathstalkera Adamanta. Když je hrdinové osvobodí, otevřou jim cestu na nádvoří.

Na vrcholu hradu čeká Arugal. Forsaken i mágové z Dalaranu chtějí, aby kletba skončila – a cesta k tomu vede přes šíleného arcimága.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Shadowfang Keep"] = [[• V kobkách jsou vězni (Sorcerer Ashcrombe pro Alianci, Deathstalker Adamant pro Hordu) – otevřou ti dveře na nádvoří.
• Arugal se teleportuje po místnosti, nestůjte na jednom místě.]]

D["Blackfathom Deeps"] = {
    title = "Blackfathom Deeps", tag = "Zatopený chrám na pobřeží Ashenvale (levely 20–30).",
    ch = {
        { "Lathar'Lazal", [[Blackfathom Deeps byly kdysi chrámem nočních elfů zasvěceným Elune. Jmenoval se Lathar'Lazal – „Sídlo nebe“. Byl to rozlehlý komplex mostů posázených drahokamy a jiskřivých jezer s měsíční studnou a na jeho stavbu dohlížela sama královna Azshara.

Při Velkém rozpoltění se chrám zřítil a potopil pod hladinu moře u pobřeží Zoram Strand v Ashenvale.]] },
        { "Kult Twilight's Hammer", [[Asi před pár lety přilákaly do ruin členy kultu Twilight's Hammer šepoty a zlé sny. Kult se spojil s nagami a pustil se do zlověstného díla.

V hlubinách chrámu žije Aku'mai the Devourer, obří tříhlavá hydra, služebnice Starých bohů. Je obávaná pro svou bezduchou krutost a nenasytný hlad – ale kult ji uctívá jako božské znamení.]] },
        { "Kdo tu vládne", [[Kult vede Twilight Lord Kelris, který osobně dohlíží na růst Aku'mai a krmí ji obětovanými kultisty. Naga Lady Sarevess má vlastní zátoku, kde provádí rituály na kouzelnou ochranu. Obří želvu Ghamoo-ra kult uvěznil a dohnal k šílenství, aby chrám střežila.

Murlok Gelihast vyslyšel volání Starých bohů a postavil si vlastní oltář k obětem. Ve vodách měsíční svatyně plave nepolapitelný žralok Old Serra'kis a v hlubinách sídlí i vodní elementál Baron Aquanis.]] },
        { "Cesta k Aku'mai", [[Kdo se chce dostat k Aku'mai, musí zapálit čtyři ohně u sochy v srdci chrámu – a každý z nich přivolá vlnu nepřátel. Chrám je plný vody, takže se hodí lektvary na dýchání pod vodou.

Blackfathom Deeps jsou smutným místem: posvátný chrám Elune se stal doupětem kultu, který chce zničení světa.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackfathom Deeps"] = [[• Hodně plavání – lektvary na dýchání pod vodou se hodí.
• Před Aku'mai zapálíte čtyři ohně u sochy – každý přivolá vlnu nepřátel.]]

D["The Stockade"] = {
    title = "The Stockade", tag = "Vězení Stormwindu, kde se vzbouřili vězni (levely 22–30).",
    ch = {
        { "Vězení Stormwindu", [[Stormwind Stockade je přísně střežené vězení pod čtvrtí kanálů ve Stormwindu. Drží v něm drobné zloděje, politické vzbouřence, vrahy a několik nejnebezpečnějších zločinců království.]] },
        { "Vzpoura", [[Nedávno v něm vypukla vzpoura, kterou zosnovalo Bratrstvo Defias. Vězni přemohli stráže a volně se pohybují po chodbách. Stráže drží jen vchod a hledají dobrodruhy, kteří odstraní strůjce vzpoury – Bazila Thredda, VanCleefova poručíka. O celé věci se před obyvateli města mlčí.]] },
        { "Vězni", [[Mezi vězni jsou i zvláštní případy. Kam Deepfury z klanu Dark Iron je politický vězeň – agenti z Ironforge ho chtějí odstranit, aby nemuseli čekat na stormwindské úřady. Dextren Ward je vykradač hrobů, který prodával mrtvoly nekromantovi Morbentu Felovi, a rada Duskwoodu chce jeho popravu. Targorr the Dread je ork z klanu Blackrock, jehož poprava se zdržuje kvůli zkorumpovaným úředníkům.

Mezi vězni jsou i Hamhock a vzácně Bruegal Ironknuckle.]] },
        { "Úkoly", [[Questy vedoucí do Stockade přicházejí z mnoha míst – z Redridge (Targorr), z Duskwoodu (Dextren Ward), z Ironforge (Kam Deepfury) i ze samotného Stormwindu (Bazil Thredd). A quest The Color of Blood se týká strážného Maca, kterého vězni zavraždili.

Stockade je krátký dungeon, ale propojuje příběhy celého kraje – a Bazil Thredd navazuje na příběh VanCleefova dopisu.]] },
    },
}
WoWpoCesku_LoreTajemstvi["The Stockade"] = [[• Krátký dungeon s hodně nepřáteli ve stísněných chodbách.
• Bazil Thredd navazuje na příběh VanCleefova dopisu.]]
A["Stormwind Stockade"] = "The Stockade"

D["Gnomeregan"] = {
    title = "Gnomeregan", tag = "Ztracené město gnómů, plné troggů, robotů a radiace (levely 24–34).",
    ch = {
        { "Město vynálezců", [[Gnomeregan je ztracené podzemní město gnómů v Dun Morogh. Podle pozdějších objevů pocházejí gnómové z mechagnómů, kteří uprchli z Uldamanu pod kletbou masa. Trpaslíci je objevili v jeskyních Dun Morogh a pomohli jim postavit město, které je důkazem gnómské geniality, ctižádosti a vynalézavosti – plné obřích strojů a důmyslných ventilačních systémů.]] },
        { "Troggové", [[Za Třetí války probudily trpasličí vykopávky v Uldamanu troggy, kteří pak prorazili do spodních pater Gnomereganu. Gnómská armáda se jim bránila pět let, ale proti jejich hrabání tunelů neměla dost sil.]] },
        { "Záření a zrada", [[Vrchní mechanik Gelbin Mekkatorque nakonec schválil zoufalý plán svého poradce Sicca Thermaplugga: vypustit do spodních pater jedovaté záření, které útočníky otráví. Plán se katastrofálně obrátil – během několika dní zemřelo téměř osmdesát procent gnómů. Přeživší uprchli do Ironforge a další se proměnili v šílené, zlé „leper gnomes“.

Thermaplugg, sžíraný závistí, počítal jen s třiceti procenty mrtvých gnómů. Chtěl zbylé troggy porazit sám a převzít vládu. Při evakuaci ale uvízl ve městě, záření ho změnilo a prohlásil se „králem Gnomereganu“. Dnes vede troggy i leper gnomes z otráveného města.]] },
        { "Výprava do Gnomereganu", [[Do města vede hlavní vchod i zadní výtah, kterým se dostane i Horda. Cestou potkáš trogga Grubbise s krokodýlem, radioaktivní sliz Viscous Fallout, roboty Electrocutioner 6000 a Crowd Pummeler 9-60, vzácně i Dark Iron Ambassadora – a na konci Mekgineera Thermaplugga.

Gnómové sbírají ve městě děrné štítky (punchcards) pro sérii questů a hledají lék na následky záření.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Gnomeregan"] = [[• Do Gnomereganu vede i zadní vchod výtahem, kterým se dostane i Horda.
• Děrné štítky (Punchcards) – sbírej je a vlož do Matrix Punchograph 3005 pro sérii questů.
• Pozor na radiaci (Irradiated).]]

D["Razorfen Kraul"] = {
    title = "Razorfen Kraul", tag = "Trnité bludiště kančích lidí na jihu Barrens (levely 25–35).",
    ch = {
        { "Trny poloboha", [[Před deseti tisíci lety, za Války starověku, vystoupil proti Plamenné legii mocný polobůh Agamaggan – obří kanec. V boji padl, ale z jeho krve vyrostly trnité šlahouny, ze kterých vzniklo Razorfen. Kančí lidé (quilboar) jsou smrtelnými potomky poloboha a Razorfen je pro ně posvátnou říší.]] },
        { "Charlga Razorflank", [[Razorfen Kraul na jihu Barrens dobyla stará kněžka Charlga Razorflank a vládne kančím lidem, kteří tu žijí. Pod její vládou kmen útočí na soupeřící klany i na osady Hordy.

Podle některých zpráv Charlga dokonce vyjednává s agenty Pohromy – a to by znamenalo spojenectví s mnohem temnějšími silami.]] },
        { "Bludiště trnů", [[Kraul je bludiště chodeb mezi obřími trny. Žijí v něm šamani, lovci a válečníci kančích lidí a jejich bojová zvířata. Cestou potkáš Roogug, Aggem Thorncurse, Death Speaker Jargba, Overlord Ramtusk a obřího kance Agathelos the Raging, než se dostaneš ke Charlze. Vzácně se tu objevuje Blind Hunter a Earthcaller Halmgar.]] },
        { "Willix", [[Uvnitř je uvězněný Willix the Importer, který potřebuje doprovod ven. Duch poloboha Agamaggana je v trnitých koloniích stále přítomen – proto je Razorfen pro kančí lidi náboženským místem a proto ho tak zuřivě brání.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Razorfen Kraul"] = [[• Uvnitř je uvězněný Willix the Importer – doprovoď ho ven.
• Bludiště chodeb, mapa se hodí.]]

D["Scarlet Monastery"] = {
    title = "Scarlet Monastery", tag = "Klášter Šarlatového křižáckého řádu v Tirisfalu – čtyři křídla (levely 26–45).",
    ch = {
        { "Příběh", [[Šarlatový křižácký řád vznikl z rytířů, kteří přežili Pohromu – a z jejich zuřivosti. Každého, kdo není jako oni, považují za nemrtvého nebo zrádce. Klášter je jejich pevností.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Scarlet Monastery"] = [[• Do zbrojnice a katedrály potřebuješ Scarlet Key z knihovny.
• Když porazíte Mograina, přiběhne Whitemane a vzkřísí ho slavným „Arise, my champion!“.
• Herod křičí „Blades of Light!“ a točí se jako vír – utíkejte.]]

D["Razorfen Downs"] = {
    title = "Razorfen Downs", tag = "Kančí lidé v područí Pohromy, na hranici Barrens (levely 35–45).",
    ch = {
        { "Příběh", [[Lich Amnennar the Coldbringer převádí kančí lidi na stranu Pohromy. Drak Belnistrasz z bronzového rodu chce jeho rituál zastavit.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Razorfen Downs"] = [[• Quest Extinguishing the Idol – braňte Belnistrasze, zatímco ruší modlu.
• Tuten'kash je odkaz na Tutanchamona.]]

D["Uldaman"] = {
    title = "Uldaman", tag = "Trezor titánů v Badlands, kde se skrývá původ trpaslíků (levely 35–47).",
    ch = {
        { "Příběh", [[Uldaman postavili titáni. Trpaslíci z Explorers' League tu hledají Disky Norgannona, které prozrazují, že trpaslíci pocházejí z kamenných earthen. Dark Ironové a troggové jim jdou po krku.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Uldaman"] = [[• Baelog, Eric a Olaf jsou odkaz na hru The Lost Vikings od Blizzardu!
• Disk Norgannona tě provede jedním z nejdůležitějších příběhů o trpaslících.]]

D["Zul'Farrak"] = {
    title = "Zul'Farrak", tag = "Trollí město v poušti Tanaris (levely 44–54).",
    ch = {
        { "Příběh", [[Trollové Sandfury přežili v poušti díky kruté magii a uctívání hydry Gahz'rilla. Drží zajatce a připravují rituály.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Zul'Farrak"] = [[• Slavná bitva na schodech: osvoboď Sergeanta Blye a jeho druhy z klece a pak společně odrážejte vlny trollů.
• Z dungeonu padá Carrot on a Stick – trinket na rychlejší jízdu.]]

D["Maraudon"] = {
    title = "Maraudon", tag = "Jeskyně Theradras a Zaetara v Desolace (levely 46–55).",
    ch = {
        { "Příběh", [[Zaetar, syn Cenaria, a princezna země Theradras měli děti – kentaury, kteří otce zabili. Theradras ho pohřbila v Maraudonu a dodnes tu truchlí. Její žal zkazil celé jeskyně.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Maraudon"] = [[• Scepter of Celebras otevře portál, který zkrátí cestu dovnitř.
• Po zabití Theradras se objeví duch Zaetara.]]

D["Sunken Temple"] = {
    title = "Sunken Temple", tag = "Potopený chrám Atal'Hakkar v Swamp of Sorrows (levely 50–56).",
    ch = {
        { "Příběh", [[Kněží Atal'ai chtěli vyvolat krvavého boha Hakkara. Ysera chrám potopila do bažiny a drak Eranikus ho hlídá – jenže jeho mysl ovládla Noční můra.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Sunken Temple"] = [[• Šest trollích kněží na balkonech je třeba porazit, aby se otevřela cesta.
• Avatara Hakkara přivoláte díky předmětu Egg of Hakkar z questové řady.]]
A["The Temple of Atal'Hakkar"] = "Sunken Temple"
A["Temple of Atal'Hakkar"] = "Sunken Temple"

D["Blackrock Depths"] = {
    title = "Blackrock Depths", tag = "Podzemní říše Dark Ironů pod Blackrock Mountain (levely 52–60).",
    ch = {
        { "Příběh", [[Hluboko pod horou leží město Shadowforge, sídlo Dark Ironů a jejich císaře Dagrana Thaurissana. Vládne mu ale Ragnaros, pán ohně, kterého kdysi vyvolal jeho předek. Ve městě je i princezna Moira, dcera krále Magniho.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackrock Depths"] = [[• Grim Guzzler – hospoda uprostřed dungeonu. Ukradni pivo Dark Iron Ale a uvidíš, co se stane.
• Shadowforge Key otevře velkou část dungeonu.
• Quest Attunement to the Core: úlomek z jádra tě pustí do Molten Core.]]

D["Blackrock Spire"] = {
    title = "Blackrock Spire", tag = "Pevnost klanu Blackrock a černých draků v hoře (levely 55–60).",
    ch = {
        { "Příběh", [[Horní část hory drží orkové klanu Blackrock pod Warchiefem Rendem Blackhandem. Za nimi stojí černý drak Nefarian a jeho generál Drakkisath.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackrock Spire"] = [[• Do horní části potřebuješ pečeť Seal of Ascension.
• Pro vstup do Blackwing Lair musíš porazit Drakkisatha a dotknout se Orb of Command (quest Blackhand's Command).]]

D["Dire Maul"] = {
    title = "Dire Maul", tag = "Ruiny elfího města Eldre'Thalas ve Feralas (levely 55–60).",
    ch = {
        { "Příběh", [[Eldre'Thalas bylo městem Highborne, kteří přežili Velké rozpoltění. Aby si udrželi magii, uvěznili démona Immol'thara a čerpali z něj sílu. Dnes je město rozdělené mezi ogry, satyry a poslední Highborne.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Dire Maul"] = [[• Pusillin – skřítek, kterého honíš celým východním křídlem. Má u sebe Crescent Key.
• „Tribute run“ v severní části: projdi bez zabití stráží a král ogrů ti dá poklad.
• V knihovně Shen'dralar najdeš knihy (librams) na vylepšení výstroje.]]

D["Scholomance"] = {
    title = "Scholomance", tag = "Škola nekromancie pod Caer Darrow (levely 58–60).",
    ch = {
        { "Příběh", [[Rod Barovů prodal svůj hrad Kultu zatracených. Pod ním vznikla Scholomance, kde se učí noví nekromanti Pohromy pod vedením Darkmastera Gandlinga.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Scholomance"] = [[• Do školy potřebuješ Skeleton Key.
• Gandling teleportuje hráče do zamčených místností.]]

D["Stratholme"] = {
    title = "Stratholme", tag = "Prokleté město, kde Arthas začal svou cestu do temnoty (levely 58–60).",
    ch = {
        { "Příběh", [[Tady Arthas nechal vyvraždit obyvatele, aby se nestali nemrtvými. Dnes je město rozdělené: v živé části drží Šarlatoví, v nemrtvé vládne baron Rivendare.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Stratholme"] = [[• Baron run: když se dostaneš k baronovi do 45 minut, zachráníš Ysidu Harmon.
• Z barona vzácně padá kůň Deathcharger.
• SPOILER: Grand Crusader Dathrohan je ve skutečnosti démon Balnazzar.]]

D["Molten Core"] = {
    title = "Molten Core", tag = "Ohnivé srdce hory – raid pro 40 hráčů s Ragnarosem na konci.",
    ch = {
        { "Příběh", [[Hluboko pod Blackrock Mountain sídlí Ragnaros, pán ohně, kterého vyvolal Thaurissan na konci Války tří kladiv. Jeho služebníci tu hlídají cestu k jeho trůnu.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Molten Core"] = [[• Runy u bossů je třeba uhasit pomocí Aqual Quintessence od Duka Hydraxise (Azshara).
• Ragnarosovo „TOO SOON!“ a „BY FIRE BE PURGED!“ zná každý hráč klasiky.
• Baron Geddon z vás udělá bombu – utíkejte od skupiny.]]

D["Onyxia's Lair"] = {
    title = "Onyxia's Lair", tag = "Doupě černé dračice v Dustwallow Marsh – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Onyxia, dcera Deathwinga, se ve Stormwindu vydává za lady Prestor. Ve svém doupěti v Dustwallow Marsh na ni hrdinové čekají v pravé podobě.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Onyxia's Lair"] = [[• Slavná nahrávka „Many whelps! Handle it!“ a „50 DKP minus!“ pochází odtud.
• Deep Breath – ohnivý dech přes celou jeskyni. Nestůjte před ní.
• Hlava Onyxie dá celému městu buff.]]

D["Blackwing Lair"] = {
    title = "Blackwing Lair", tag = "Laboratoř Nefariana na vrcholu Blackrock Spire – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Nefarian, syn Deathwinga, tu vytváří chromatické draky ze všech dračích rodů. Jeho zajatcem je i rudý drak Vaelastrasz, kterého Nefarian zkazil.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackwing Lair"] = [[• Vaelastrasz vám na začátku dá Essence of the Red a během boje sesílá na hráče Burning Adrenaline, která je po chvíli zabije. Smutný souboj s dobrým drakem, kterého Nefarian donutil bojovat.
• Na Nefariana potřebujete Onyxia Scale Cloak proti jeho ohni.]]

D["Zul'Gurub"] = {
    title = "Zul'Gurub", tag = "Hlavní město trollů Gurubashi ve Stranglethorn – raid pro 20 hráčů.",
    ch = {
        { "Příběh", [[Kněží Hakkara vyvolali krvavého boha zpět na Azeroth. Jeho velekněží, kteří získali sílu zvířecích bohů, mu slouží v srdci džungle.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Zul'Gurub"] = [[• Z Mandokira padá Swift Razzashi Raptor a z Thekala Swift Zulian Tiger – vzácné mounty.
• Hakkar kdysi nechtěně rozšířil „krvavý mor“ po celém serveru – slavná chyba z roku 2005.]]

D["Ruins of Ahn'Qiraj"] = {
    title = "Ruins of Ahn'Qiraj", tag = "Vnější ruiny pevnosti Qiraji v Silithu – raid pro 20 hráčů.",
    ch = {
        { "Příběh", [[Po otevření Scarab Wall vede Cenarion Circle útok do ruin. Qiraji tu hlídají cestu k chrámu, kde spí Starý bůh C'Thun.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Ruins of Ahn'Qiraj"] = [[• Ossiriana oslabíte krystaly, které se objevují po místnosti.
• General Rajaxx má s sebou armádu – a s vámi bojuje i Lieutenant General Andorov.]]

D["Ahn'Qiraj Temple"] = {
    title = "Temple of Ahn'Qiraj", tag = "Chrám, kde spí Starý bůh C'Thun – raid pro 40 hráčů.",
    ch = {
        { "Příběh", [[Uvnitř chrámu vládnou císaři Vek'lor a Vek'nilash a pod nimi spí C'Thun, Starý bůh, který stojí za silithidy i Qiraji.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Ahn'Qiraj Temple"] = [[• C'Thun vám šeptá do hlavy („You will die.“) – zprávy se objevují v chatu.
• Viscidus se musí zmrazit a pak rozbít.]]
A["Temple of Ahn'Qiraj"] = "Ahn'Qiraj Temple"
A["Ahn'Qiraj"] = "Ahn'Qiraj Temple"

D["Naxxramas"] = {
    title = "Naxxramas", tag = "Létající nekropole Kel'Thuzada – poslední raid klasiky (40 hráčů).",
    ch = {
        { "Příběh", [[Nad Eastern Plaguelands se vznáší Naxxramas, citadela Pohromy. Vládne jí lich Kel'Thuzad, který odsud řídí nemrtvé armády Lich Kinga.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Naxxramas"] = [[• Heiganův „tanec“ – utíkání před výbuchy v rytmu, noční můra mnoha raidů.
• Thaddius rozdělí raid na plus a minus náboj – stůjte se stejným znaménkem.
• SPOILER: Kel'Thuzad po porážce uteče do Northrendu.]]

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

-- Bossové dungeonů pro záložku Bestiář: { jméno, poznámka } nebo { sekce = "…" }
WoWpoCesku_DungeonBosses = {
    ["Ragefire Chasm"] = {
        { "Oggleflint", "vůdce troggů" },
        { "Taragaman the Hungerer", "démon, kterému kultisté slouží" },
        { "Jergosh the Invoker", "čaroděj kultu" },
        { "Bazzalan", "satyr, který kult řídí" },
    },
    ["Wailing Caverns"] = {
        { "Lady Anacondra", "čtyři Druidové Fangu" },
        { "Lord Cobrahn", "čtyři Druidové Fangu" },
        { "Lord Pythas", "čtyři Druidové Fangu" },
        { "Lord Serpentis", "čtyři Druidové Fangu" },
        { "Kresh", "obří želva" },
        { "Skum", "zmutovaný ještěr" },
        { "Verdan the Everliving", "obří rostlinná bytost" },
        { "Mutanus the Devourer", "objeví se při probouzení Naralexe" },
        { "Deviate Faerie Dragon", "vzácný drak" },
    },
    ["The Deadmines"] = {
        { "Rhahk'Zor", "ogr, který hlídá první dveře" },
        { "Miner Johnson", "vzácný horník" },
        { "Sneed's Shredder", "goblin v obřím stroji" },
        { "Sneed", "goblin v obřím stroji" },
        { "Gilnid", "goblinský tavič" },
        { "Mr. Smite", "tauren, první důstojník, v boji mění zbraně" },
        { "Captain Greenskin", "kapitán lodi" },
        { "Edwin VanCleef", "vůdce Bratrstva" },
        { "Cookie", "murlok kuchař" },
    },
    ["Shadowfang Keep"] = {
        { "Rethilgore", "stráž kobek" },
        { "Razorclaw the Butcher", "" },
        { "Baron Silverlaine", "duch bývalého pána hradu" },
        { "Commander Springvale", "padlý paladin" },
        { "Odo the Blindwatcher", "" },
        { "Fenrus the Devourer", "obří vlk" },
        { "Wolf Master Nandos", "" },
        { "Archmage Arugal", "" },
        { "Deathsworn Captain", "vzácný" },
    },
    ["Blackfathom Deeps"] = {
        { "Ghamoo-ra", "obří želva" },
        { "Lady Sarevess", "naga" },
        { "Gelihast", "murlok" },
        { "Lorgus Jett", "kultista" },
        { "Baron Aquanis", "vodní elementál" },
        { "Twilight Lord Kelris", "vůdce kultu" },
        { "Old Serra'kis", "obří žralok" },
        { "Aku'mai", "hydra Starých bohů" },
    },
    ["The Stockade"] = {
        { "Targorr the Dread", "" },
        { "Kam Deepfury", "Dark Iron" },
        { "Hamhock", "" },
        { "Bazil Thredd", "vůdce vzpoury, spojený s VanCleefem" },
        { "Dextren Ward", "" },
        { "Bruegal Ironknuckle", "vzácný" },
    },
    ["Gnomeregan"] = {
        { "Grubbis", "trogg s krokodýlem" },
        { "Viscous Fallout", "radioaktivní sliz" },
        { "Electrocutioner 6000", "robot" },
        { "Crowd Pummeler 9-60", "robot v aréně" },
        { "Dark Iron Ambassador", "vzácný" },
        { "Mekgineer Thermaplugg", "zrádce" },
    },
    ["Razorfen Kraul"] = {
        { "Roogug", "" },
        { "Aggem Thorncurse", "" },
        { "Death Speaker Jargba", "" },
        { "Overlord Ramtusk", "" },
        { "Agathelos the Raging", "obří kanec" },
        { "Charlga Razorflank", "" },
        { "Blind Hunter", "vzácní" },
        { "Earthcaller Halmgar", "vzácní" },
    },
    ["Scarlet Monastery"] = {
        { sekce = "Hřbitov (Graveyard)" },
        { "Interrogator Vishas", "" },
        { "Bloodmage Thalnos", "" },
        { "Ironspine", "vzácný" },
        { "Azshir the Sleepless", "vzácný" },
        { "Fallen Champion", "vzácný" },
        { sekce = "Knihovna (Library)" },
        { "Houndmaster Loksey", "" },
        { "Arcanist Doan", "" },
        { sekce = "Zbrojnice (Armory)" },
        { "Herod", "" },
        { sekce = "Katedrála (Cathedral)" },
        { "High Inquisitor Fairbanks", "" },
        { "Scarlet Commander Mograine", "" },
        { "High Inquisitor Whitemane", "" },
    },
    ["Razorfen Downs"] = {
        { "Tuten'kash", "obří pavouk (přivolá ho gong)" },
        { "Mordresh Fire Eye", "" },
        { "Glutton", "" },
        { "Ragglesnout", "vzácný" },
        { "Plaguemaw the Rotting", "" },
        { "Amnennar the Coldbringer", "lich" },
    },
    ["Uldaman"] = {
        { "Revelosh", "" },
        { "Baelog", "ztracení trpaslíci" },
        { "Eric „The Swift“", "ztracení trpaslíci" },
        { "Olaf", "ztracení trpaslíci" },
        { "Ironaya", "kamenná strážkyně" },
        { "Obsidian Sentinel", "" },
        { "Ancient Stone Keeper", "" },
        { "Galgann Firehammer", "" },
        { "Grimlok", "" },
        { "Archaedas", "kamenný obr na konci" },
    },
    ["Zul'Farrak"] = {
        { "Antu'sul", "" },
        { "Theka the Martyr", "" },
        { "Witch Doctor Zum'rah", "" },
        { "Nekrum Gutchewer", "" },
        { "Shadowpriest Sezz'ziz", "" },
        { "Hydromancer Velratha", "" },
        { "Gahz'rilla", "hydra (přivolá ji Mallet of Zul'Farrak u gongu)" },
        { "Chief Ukorz Sandscalp", "" },
        { "Ruuzlu", "" },
        { "Zerillis", "vzácný" },
    },
    ["Maraudon"] = {
        { "Noxxion", "" },
        { "Razorlash", "" },
        { "Lord Vyletongue", "" },
        { "Celebras the Cursed", "" },
        { "Landslide", "" },
        { "Tinkerer Gizlock", "" },
        { "Rotgrip", "" },
        { "Princess Theradras", "" },
        { "Meshlok the Harvester", "vzácný" },
    },
    ["Sunken Temple"] = {
        { "Atal'alarion", "strážce (sochy v hádance)" },
        { "Dreamscythe", "zelení draci" },
        { "Weaver", "zelení draci" },
        { "Jammal'an the Prophet", "" },
        { "Ogom the Wretched", "" },
        { "Morphaz", "" },
        { "Hazzas", "" },
        { "Avatar of Hakkar", "" },
        { "Shade of Eranikus", "" },
    },
    ["Blackrock Depths"] = {
        { "High Interrogator Gerstahn", "" },
        { "Lord Roccor", "" },
        { "Houndmaster Grebmar", "" },

        { "Pyromancer Loregrain", "" },
        { "Lord Incendius", "" },
        { "Fineous Darkvire", "" },
        { "Bael'Gar", "" },
        { "General Angerforge", "" },
        { "Golem Lord Argelmach", "" },
        { "Hurley Blackbreath", "" },
        { "Plugger Spazzring", "hospoda Grim Guzzler" },
        { "Ambassador Flamelash", "" },
        { "Magmus", "" },
        { "Emperor Dagran Thaurissan", "" },
        { "Princess Moira Bronzebeard", "" },
    },
    ["Blackrock Spire"] = {
        { sekce = "Dolní část" },
        { "Highlord Omokk", "" },
        { "Shadow Hunter Vosh'gajin", "" },
        { "War Master Voone", "" },
        { "Mother Smolderweb", "" },
        { "Urok Doomhowl", "" },
        { "Quartermaster Zigris", "" },
        { "Halycon", "" },
        { "Gizrul the Slavener", "" },
        { "Overlord Wyrmthalak", "" },
        { sekce = "Horní část" },
        { "Pyroguard Emberseer", "" },
        { "Solakar Flamewreath", "" },
        { "Goraluk Anvilcrack", "" },
        { "Warchief Rend Blackhand", "" },
        { "Gyth", "" },
        { "The Beast", "" },
        { "General Drakkisath", "" },
    },
    ["Dire Maul"] = {
        { sekce = "Východ" },
        { "Pusillin", "" },
        { "Zevrim Thornhoof", "" },
        { "Hydrospawn", "" },
        { "Lethtendris", "" },
        { "Alzzin the Wildshaper", "" },
        { sekce = "Západ" },
        { "Tendris Warpwood", "" },
        { "Illyanna Ravenoak", "" },
        { "Magister Kalendris", "" },
        { "Immol'thar", "" },
        { "Prince Tortheldrin", "" },
        { sekce = "Sever" },
        { "Guard Mol'dar", "" },
        { "Stomper Kreeg", "" },
        { "Guard Fengus", "" },
        { "Guard Slip'kik", "" },
        { "Captain Kromcrush", "" },
        { "King Gordok", "" },
    },
    ["Scholomance"] = {
        { "Kirtonos the Herald", "přivolá ho Blood of Innocents" },
        { "Jandice Barov", "" },
        { "Rattlegore", "" },
        { "Marduk Blackpool", "" },
        { "Vectus", "" },
        { "Ras Frostwhisper", "lich" },
        { "Instructor Malicia", "" },
        { "Doctor Theolen Krastinov", "" },
        { "Lorekeeper Polkelt", "" },
        { "The Ravenian", "" },
        { "Lord Alexei Barov", "" },
        { "Lady Illucia Barov", "" },
        { "Darkmaster Gandling", "" },
    },
    ["Stratholme"] = {
        { sekce = "Živá část" },
        { "The Unforgiven", "" },
        { "Timmy the Cruel", "" },
        { "Cannon Master Willey", "" },
        { "Archivist Galford", "" },
        { "Balnazzar", "skrytý za Grand Crusader Dathrohan" },
        { sekce = "Nemrtvá část" },
        { "Magistrate Barthilas", "" },
        { "Nerub'enkan", "" },
        { "Baroness Anastari", "" },
        { "Maleki the Pallid", "" },
        { "Ramstein the Gorger", "" },
        { "Baron Rivendare", "" },
        { "Postmaster Malown", "přivoláš ho poštovními klíči" },
    },
    ["Molten Core"] = {
        { "Lucifron", "" },
        { "Magmadar", "" },
        { "Gehennas", "" },
        { "Garr", "" },
        { "Shazzrah", "" },
        { "Baron Geddon", "" },
        { "Golemagg the Incinerator", "" },
        { "Sulfuron Harbinger", "" },
        { "Majordomo Executus", "" },
        { "Ragnaros", "" },
    },
    ["Onyxia's Lair"] = {
        { "Onyxia", "tři fáze: na zemi, ve vzduchu s mláďaty a znovu na zemi" },
    },
    ["Blackwing Lair"] = {
        { "Razorgore the Untamed", "" },
        { "Vaelastrasz the Corrupt", "" },
        { "Broodlord Lashlayer", "" },
        { "Firemaw", "" },
        { "Ebonroc", "" },
        { "Flamegor", "" },
        { "Chromaggus", "" },
        { "Nefarian", "" },
    },
    ["Zul'Gurub"] = {
        { "High Priestess Jeklik", "netopýr" },
        { "High Priest Venoxis", "had" },
        { "High Priestess Mar'li", "pavouk" },
        { "Bloodlord Mandokir", "" },
        { "Edge of Madness", "náhodný boss" },
        { "Gahz'ranka", "vyloví se rybařením" },
        { "High Priest Thekal", "tygr" },
        { "High Priestess Arlokk", "panter" },
        { "Jin'do the Hexxer", "" },
        { "Hakkar the Soulflayer", "" },
    },
    ["Ruins of Ahn'Qiraj"] = {
        { "Kurinnaxx", "" },
        { "General Rajaxx", "" },
        { "Moam", "" },
        { "Buru the Gorger", "" },
        { "Ayamiss the Hunter", "" },
        { "Ossirian the Unscarred", "" },
    },
    ["Ahn'Qiraj Temple"] = {
        { "The Prophet Skeram", "" },
        { "Silithid Royalty", "tři brouci" },
        { "Battleguard Sartura", "" },
        { "Fankriss the Unyielding", "" },
        { "Viscidus", "" },
        { "Princess Huhuran", "" },
        { "Twin Emperors", "Vek'lor a Vek'nilash" },
        { "Ouro", "" },
        { "C'Thun", "" },
    },
    ["Naxxramas"] = {
        { sekce = "Pavoučí křídlo" },
        { "Anub'Rekhan", "" },
        { "Grand Widow Faerlina", "" },
        { "Maexxna", "" },
        { sekce = "Morové křídlo" },
        { "Noth the Plaguebringer", "" },
        { "Heigan the Unclean", "" },
        { "Loatheb", "" },
        { sekce = "Vojenské křídlo" },
        { "Instructor Razuvious", "" },
        { "Gothik the Harvester", "" },
        { "Four Horsemen", "" },
        { sekce = "Konstrukční křídlo" },
        { "Patchwerk", "" },
        { "Grobbulus", "" },
        { "Gluth", "" },
        { "Thaddius", "" },
        { sekce = "Doupě mrazivého draka" },
        { "Sapphiron", "nemrtvý drak" },
        { "Kel'Thuzad", "" },
    },
}
