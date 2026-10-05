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
WoWpoCesku_LoreTajemstvi["Gnomeregan"] = [[• Kromě hlavního vchodu má Gnomeregan i zadní vchod výtahem.
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
        { "Bašta kněží", [[Scarlet Monastery na severovýchodě Tirisfalu byl kdysi pyšnou baštou kněžstva Lordaeronu – centrem učenosti a osvícení. Mladý Alexandros Mograine tu strávil měsíce výcviku.]] },
        { "Zrod Šarlatových", [[Po Třetí válce vedl lord Alexandros Mograine zbytky Rytířů Stříbrné ruky do kláštera a udělal z něj obrannou základnu proti Pohromě. Z jeho křížové výpravy se později oddělily dvě frakce: nemilosrdný Šarlatový křižácký řád a Argent Dawn.

Šarlatoví považují každého nemrtvého za zrůdu a každého, kdo s nimi nesouhlasí, za zrádce. Klášter je dnes jejich pevností. Kdysi tu Brigitte Abbendis a Maxwell Tyrosus dokonce vedli spor o osud trolla Zabry Hexxe, který se z knih kláštera naučil Světlu – Alexandros ho nakonec ušetřil.]] },
        { "Čtyři křídla", [[Klášter má čtyři křídla. Na hřbitově (Graveyard) vládnou Interrogator Vishas a Bloodmage Thalnos. V knihovně (Library) Houndmaster Loksey a Arcanist Doan, u kterého najdeš Scarlet Key. Ve zbrojnici (Armory) čeká šampion Herod a v katedrále (Cathedral) High Inquisitor Fairbanks, Scarlet Commander Mograine a High Inquisitor Whitemane.

Když hrdinové porazí Mograina, přiběhne Whitemane a vzkřísí ho slavným „Arise, my champion!“.]] },
        { "Temná tajemství", [[Za Šarlatovými stojí víc, než si sami přiznávají. SPOILER: jejich vrchní velitel Grand Crusader Saidan Dathrohan je ve skutečnosti démon Balnazzar.

A Renault Mograine, syn Alexandrose, svého otce kdysi zradil. Podle legendy ho za tu zradu nakonec v kapli kláštera popravil otcův duch skrze meč Ashbringer.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Scarlet Monastery"] = [[• Do zbrojnice a katedrály potřebuješ Scarlet Key z knihovny.
• Když porazíte Mograina, přiběhne Whitemane a vzkřísí ho slavným „Arise, my champion!“.
• Herod křičí „Blades of Light!“ a točí se jako vír – utíkejte.]]

D["Razorfen Downs"] = {
    title = "Razorfen Downs", tag = "Kančí lidé v područí Pohromy, na hranici Barrens (levely 35–45).",
    ch = {
        { "Hlavní město kančích lidí", [[Razorfen Downs na hranici Barrens a Thousand Needles bylo dávným hlavním městem kančích lidí (quilboar) – posvátným místem v trnech poloboha Agamaggana.]] },
        { "Pohroma v trnech", [[Po Třetí válce dobyl Razorfen Downs lich Amnennar the Coldbringer se silami Pohromy. Kančí lidé svedli zoufalý boj, aby své milované město získali zpět dřív, než Amnennar rozšíří svou moc po celých Barrens.

Kmen Death's Head, nejvyšší kněží kančích lidí, se zkazil a dnes slouží Pohromě. Kančí lidé v Downs jsou nakažení morem a zajímají vězně.]] },
        { "Belnistrasz", [[Mezi vězni je i drak Belnistrasz. Chce zastavit Amnennarův vliv a zničit modlu, skrze kterou lich působí. V questu Extinguishing the Idol ho hrdinové musí bránit před vlnami nepřátel, zatímco modlu ruší.]] },
        { "Bossové", [[Cestou potkáš obřího pavouka Tuten'kashe, kterého přivolá gong (jméno je odkazem na Tutanchamona), Mordreshe Fire Eye v části Bone Pile, nenasytného Gluttona, vzácně Ragglesnouta a Plaguemaw the Rotting. Na konci čeká sám Amnennar. Jeho fylaktérium ale zůstalo celé – a lich se tak může jednou vrátit.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Razorfen Downs"] = [[• Quest Extinguishing the Idol – braňte Belnistrasze, zatímco ruší modlu.
• Tuten'kash je odkaz na Tutanchamona.]]

D["Uldaman"] = {
    title = "Uldaman", tag = "Trezor titánů v Badlands, kde se skrývá původ trpaslíků (levely 35–47).",
    ch = {
        { "Trezor titánů", [[Uldaman je obrovský prastarý trezor, který postavili strážci titánů. Leží v Badlands a ukrývá jedno z největších tajemství trpaslíků.]] },
        { "Probuzení troggů", [[Explorers' League tu při prvních vykopávkách nechtěně probudila troggy, kteří pak zaplavili okolní kraje – mimo jiné i Gnomeregan. O vykopávky se zajímají i Dark Ironové pod vedením Galganna Firehammera, kteří tu hledají artefakty titánů.]] },
        { "Disky Norgannona", [[V hloubi trezoru leží Disky Norgannona – obrovské artefakty titánů, které zaznamenávají tajemství stvoření trpaslíků. Trezor skrývá i spící earthen, kamenné bytosti, ze kterých se po probuzení stali trpaslíci.

Disky střeží kamenná obryně Ironaya, která pomáhala Uldaman rozšiřovat, a nejhlubší komnaty hlídá Archaedas, myslící strážce z kamene.]] },
        { "Ztracení Vikingové", [[V Uldamanu potkáš i tři ztracené trpaslíky – Baeloga, Erica „The Swift“ a Olafa. Je to odkaz na hru The Lost Vikings od Blizzardu.

Dalšími bossy jsou Revelosh, trogg Grimlok, Obsidian Sentinel a Ancient Stone Keeper. Questy tě pošlou pro Staff of Prehistoria, Power Stones a Platinum Discs.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Uldaman"] = [[• Baelog, Eric a Olaf jsou odkaz na hru The Lost Vikings od Blizzardu!
• Disk Norgannona tě provede jedním z nejdůležitějších příběhů o trpaslících.]]

D["Zul'Farrak"] = {
    title = "Zul'Farrak", tag = "Trollí město v poušti Tanaris (levely 44–54).",
    ch = {
        { "Město písečných trollů", [[Zul'Farrak je město trollů Sandfury na severozápadě Tanaris. Kmen Sandfury se po Velkém rozpoltění, kdy se džungle změnila v poušť, za tisíce let přizpůsobil životu v písku a stali se z nich písečtí trollové.]] },
        { "Gahz'rilla", [[V posvátném jezírku spí Gahz'rilla – prastará hydra, kterou trollové uctívají jako poloboha. Kdo ji probudí, toho čeká zkáza. Probudit ji lze kladivem Mallet of Zul'Farrak u gongu.]] },
        { "Vládci města", [[Městu vládne náčelník Ukorz Sandscalp se svým pomocníkem Ruuzlu. Dalšími bossy jsou Theka the Martyr, čaroděj Witch Doctor Zum'rah s kostlivci, Antu'sul se svými baziliškami, Hydromancer Velratha a nemrtvý troll Nekrum Gutchewer se Shadowpriestem Sezz'zizem.]] },
        { "Bitva na pyramidě", [[Ve městě uvízla skupina žoldnéřů z Gadgetzanu – Sergeant Bly, Raven, trpaslík Murta Grimgut, ork Oro Eyegouge a goblin Weegli Blastfuse. Když je hrdinové osvobodí z klece, společně odrážejí na schodech pyramidy vlny trollů. Je to jedna z nejslavnějších bitev klasických dungeonů.

Questy tě pošlou pro skarabeové krunýře, Tiaru Tiara of the Deep a součásti Divino-matic Rod.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Zul'Farrak"] = [[• Slavná bitva na schodech: osvoboď Sergeanta Blye a jeho druhy z klece a pak společně odrážejte vlny trollů.
• Za porážku Gahz'rilly dostaneš od Wizzla Brassboltse z Mirage Raceway (quest Gahz'rilla) slavný trinket Carrot on a Stick na rychlejší jízdu.]]

D["Maraudon"] = {
    title = "Maraudon", tag = "Jeskyně Theradras a Zaetara v Desolace (levely 46–55).",
    ch = {
        { "Jeskyně v Desolace", [[Maraudon leží ve Valley of Spears v Desolace. Je rozdělený na tři části, do kterých vedou různé portály: Wicked Grotto (fialová část), Foulspore Cavern (oranžová část) a Earth Song Falls (vnitřní část).]] },
        { "Hrob Zaetara", [[Podle legendy stvořili kentaury Zaetar, syn Cenaria, a princezna země Theradras. Krátce po svém zrození kentauři svého otce zavraždili. Truchlící Theradras uvěznila Zaetarova ducha v Maraudonu – a kraj zkazil vliv Starých bohů.

Kentauři z kmene Maraudine toto posvátné místo hlídají, zatímco kmen Magram se vlivu Theradras staví na odpor.]] },
        { "Bossové", [[Ve Wicked Grotto čeká goblin Tinkerer Gizlock, satyr Lord Vyletongue, agent Plamenné legie, a Celebras the Cursed, Zaetarův potomek. Vzácně se tu objevuje Meshlok the Harvester. Ve Foulspore Cavern žijí Noxxion a Razorlash. V Earth Song Falls čeká horský obr Landslide, obří krokodýl Rotgrip a nakonec Princess Theradras.]] },
        { "Vykoupení", [[Duch Zaetara dává quest Corruption in Maraudon a vykoupený Celebras the Redeemed quest The Scepter of Celebras – žezlo otevře portál, který zkrátí cestu dovnitř. Po porážce Theradras se Zaetarův duch konečně může rozloučit.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Maraudon"] = [[• Scepter of Celebras otevře portál, který zkrátí cestu dovnitř.
• Po zabití Theradras se objeví duch Zaetara.]]

D["Sunken Temple"] = {
    title = "Sunken Temple", tag = "Potopený chrám Atal'Hakkar v Swamp of Sorrows (levely 50–56).",
    ch = {
        { "Chrám Atal'ai", [[Atal'ai byli mocnou sektou kněží, kteří se pokusili vzkřísit Hakkara Soulflayera, svého krvavého boha. Po porážce v občanské válce říše Gurubashi uprchli na sever do Swamp of Sorrows a postavili chrám Atal'Hakkar jako ohnisko svých temných rituálů.]] },
        { "Ysera", [[Dračí aspekt Ysera jejich plány odhalila a chrám potopila pod bažinu, aby vyvolání zabránila. Na stráž postavila zelené draky, kteří brání každému vstupu.

Strážci ale podlehli Smaragdové noční můře. Dreamscythe a Weaver hlídají vnější komnatu, Hazzas a Morphaz komnatu posledního souboje – a všechny je ovládla Noční můra stejně jako jejich vůdce Eranika.]] },
        { "Kněží Atal'ai", [[Kult vede Jammal'an the Prophet, který dokáže ovládnout mysl hrdinů, a jeho nemrtvý poručík Ogom the Wretched. Nad jámou Pit of Sacrifice stojí na balkonech šest trollích kněží a dokud nepadnou, Jammal'an je nezranitelný.

V jámě Pit of Refuse je potřeba aktivovat hadí sochy ve správném pořadí, aby se objevil Atal'alarion, zlověstný troll.]] },
        { "Avatar a Eranikus", [[S předmětem Egg of Hakkar z questu The Blood God Hakkar mohou hrdinové v komnatě Sanctum of the Fallen God přivolat Avatara Hakkara.

Na konci čeká Shade of Eranikus – kdysi vznešený zelený drak, kterého Noční můra dohnala k šílenství. Je to poslední a největší výzva chrámu.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Sunken Temple"] = [[• Šest trollích kněží na balkonech je třeba porazit, aby se otevřela cesta.
• Avatara Hakkara přivoláte díky předmětu Egg of Hakkar z questové řady.]]
A["The Temple of Atal'Hakkar"] = "Sunken Temple"
A["Temple of Atal'Hakkar"] = "Sunken Temple"

D["Blackrock Depths"] = {
    title = "Blackrock Depths", tag = "Podzemní říše Dark Ironů pod Blackrock Mountain (levely 52–60).",
    ch = {
        { "Shadowforge City", [[Blackrock Depths jsou nejhlubší částí hory Blackrock, kde vládnou Dark Ironové. Jejich město Shadowforge City navrhl stavitel Franclorn Forgewright.

Po Válce tří kladiv Dark Ironové pošetile vyvolali Ragnarose, pána ohně – a od té doby mu musí sloužit.]] },
        { "Císař a princezna", [[Městu vládne císař Dagran Thaurissan, ale vždy jen jako služebník Ragnarose. Dark Ironové unesli princeznu Moiru Bronzebeard, dceru krále Magniho. Moira ale odmítá záchranu – čeká totiž císařovo dítě, dědice trůnu. To hodně komplikuje plány Aliance.

Marshal Windsor vede výpravy Aliance a trpaslík Kharan Mighthammer hrdinům vypráví, co se s Moirou stalo.]] },
        { "Grim Guzzler", [[Uprostřed dungeonu je hospoda Grim Guzzler – neutrální místo, kde působí hostinský Plugger Spazzring, Hurley Blackbreath a Ribbly Screwspigot. Lokhtos Darkbargainer tu obchoduje pro Thorium Brotherhood a prodává slavné recepty.

Hospoda je slavná i tím, co se stane, když někdo ukradne pivo Dark Iron Ale.]] },
        { "Vojsko a oheň", [[Vojsku velí General Angerforge a Golem Lord Argelmach se svými golemy. V aréně Ring of Law se bojuje podle tajemných zvyků Dark Ironů. Ambassador Flamelash zastupuje ve městě ohnivé elementály.

Shadowforge Key otevře velkou část dungeonu a quest Attunement to the Core dá hrdinům přístup do Molten Core, kde sídlí sám Ragnaros.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackrock Depths"] = [[• Grim Guzzler – hospoda uprostřed dungeonu. Ukradni pivo Dark Iron Ale a uvidíš, co se stane.
• Shadowforge Key otevře velkou část dungeonu.
• Quest Attunement to the Core: úlomek z jádra tě pustí do Molten Core.]]

D["Blackrock Spire"] = {
    title = "Blackrock Spire", tag = "Pevnost klanu Blackrock a černých draků v hoře (levely 55–60).",
    ch = {
        { "Pevnost Dark Ironů", [[Blackrock Spire byl pevností Dark Ironů, kterou navrhl mistr stavitel Franclorn Forgewright. Za První války si v ní Shadow Council zřídil tajné útočiště.

Když přišla Horda, Dark Ironové pod vládou Ragnarose jí dovolili, aby si z Blackrock Spire udělala své nové velitelství.]] },
        { "Vládci hory", [[V Blackrock Spire postupně vládli Blackhand, vůdce Staré Hordy, pak Orgrim Doomhammer a dnes Rend Blackhand, válečný náčelník Temné Hordy (Dark Horde). Horní patra ale ovládl černý drak Nefarian, který si nechává říkat lord Victor Nefarius.]] },
        { "Dolní část", [[V dolní části (Lower Blackrock Spire) sídlí síly Temné Hordy – orkové, ogrové a trollové. Bossy jsou Highlord Omokk, Shadow Hunter Vosh'gajin, War Master Voone, pavoučice Mother Smolderweb, Urok Doomhowl, Quartermaster Zigris, Halycon, Gizrul the Slavener a Overlord Wyrmthalak.]] },
        { "Horní část", [[Horní část (Upper Blackrock Spire) ovládá Nefarianův dračí rod. Čekají tu Pyroguard Emberseer, Solakar Flamewreath, Goraluk Anvilcrack, Warchief Rend Blackhand se svým drakem Gythem, The Beast a General Drakkisath.

Do horní části potřebuješ pečeť Seal of Ascension. Kdo chce dál do Blackwing Lair, potřebuje Blackhand's Command.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackrock Spire"] = [[• Do horní části potřebuješ pečeť Seal of Ascension.
• Pro vstup do Blackwing Lair musíš porazit Drakkisatha a dotknout se Orb of Command (quest Blackhand's Command).]]

D["Dire Maul"] = {
    title = "Dire Maul", tag = "Ruiny elfího města Eldre'Thalas ve Feralas (levely 55–60).",
    ch = {
        { "Eldre'Thalas", [[Eldre'Thalas postavila před dvanácti tisíci lety tajná sekta čarodějů nočních elfů, aby chránila tajemství magie královny Azshary. Když přišlo Velké rozpoltění, princ Tortheldrin a jeho věrní seslali ochranné kouzlo, které město před zkázou uchránilo.

Highborne v městě sloužila mocná skupina mágů Shen'dralar. Jedna z nich, Millicent Serene, vytvořila Fruit of Fertility – kouzelnou révu plnou ochranné a růstové síly, která živila celé město.]] },
        { "Immol'thar", [[Odříznutí od Studny věčnosti uvěznili Highborne démona Immol'thara a jeho sílu čerpali skrze pět kouzelných pylonů, aby si udrželi nesmrtelnost. Když asi 1200 let před otevřením Temného portálu začala energie docházet, Tortheldrin pobil mnoho svých lidí – aby na přeživší zbylo víc démonické moci.]] },
        { "Tři části města", [[Dnes je Dire Maul rozdělený na tři části. Ve východní Warpwood Quarter proměnil satyr Alzzin the Wildshaper kouzelnou révu ve zkaženou Felvine. Najdeš tu i skřítka Pusillina, který má u sebe Crescent Key, a zkaženého Ancienta Tendrise Warpwooda.

V západní části Capital Gardens straší duchové Highborne a je tu vězení Immol'thara, Illyanna Ravenoak, Magister Kalendris a princ Tortheldrin. Severní Gordok Commons obsadili ogrové pod vedením krále Gordoka.]] },
        { "Tribute run", [[V severní části se dá projít, aniž bys zabil stráže – a pak ti král ogrů dá poklad. Tomu se říká „tribute run“ a patří k nejzábavnějším věcem klasického WoW. V knihovně Shen'dralar najdeš knihy (librams), které vylepší tvou výstroj.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Dire Maul"] = [[• Pusillin – skřítek, kterého honíš celým východním křídlem. Má u sebe Crescent Key.
• „Tribute run“ v severní části: projdi bez zabití stráží a král ogrů ti dá poklad.
• V knihovně Shen'dralar najdeš knihy (librams) na vylepšení výstroje.]]

D["Scholomance"] = {
    title = "Scholomance", tag = "Škola nekromancie pod Caer Darrow (levely 58–60).",
    ch = {
        { "Škola nekromancie", [[Scholomance, Škola nekromancie, leží v kryptách pod Caer Darrow ve Western Plaguelands. Po Druhé válce byl hrad šlechtického rodu Barovů obnoven – ale postupně propadl temnotě. Samotné jméno znamená „škola magie“.]] },
        { "Úmluva Barovů", [[Aristokratičtí Barovové chtěli své bohatství a moc udržet i po smrti, a tak uzavřeli zlověstnou smlouvu s Kel'Thuzadem, vůdcem Kultu zatracených. Z jejich přepychového sídla se stala akademie nekromancie, kde se kultisté učili temné magii.

Před plánovanou návštěvou Uthera Lightbringera vypustila škola na Caer Darrow ničivý mor. Hrad zchátral, zaplnili ho nemrtví a služebnictvo se stalo pokusnými objekty pro výzkum moru.]] },
        { "Kdo tu vládne", [[Ředitelem školy je Darkmaster Gandling a místo pro Pohromu spravuje lich Ras Frostwhisper. Sami Barovové – Lord Alexei Barov a Lady Illucia Barov – se proměnili v nemrtvé zrůdy.

Dalšími bossy jsou Kirtonos the Herald, kterého přivolá Blood of Innocents, Jandice Barov, Rattlegore, Marduk Blackpool, Vectus, Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt a The Ravenian.]] },
        { "Zajímavosti", [[Do školy potřebuješ Skeleton Key. Darkmaster Gandling při souboji teleportuje hráče do zamčených místností.

Během vývoje WoW se dungeonu skoro půl roku interně říkalo „keep micro dungeon“, než mu Chris Metzen dal jméno Scholomance.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Scholomance"] = [[• Do školy potřebuješ Skeleton Key.
• Gandling teleportuje hráče do zamčených místností.]]

D["Stratholme"] = {
    title = "Stratholme", tag = "Prokleté město, kde Arthas začal svou cestu do temnoty (levely 58–60).",
    ch = {
        { "Vyčištění", [[Princ Arthas zjistil, že Stratholme je nakažené morem skrze otrávené obilí. Nařídil vyvraždit celé obyvatelstvo. Město zachvátil oheň a ulicemi se valil popel a jiskry. Tady Arthas udělal první velký krok do temnoty.]] },
        { "Nemrtvá část", [[Ve východní části města vládne Pohromě rytíř smrti Baron Rivendare. Nad morem zamořenými lesy kousek odsud se vznáší Naxxramas, nekropole Kel'Thuzada.

V nemrtvé části čekají Magistrate Barthilas, Nerub'enkan, Baroness Anastari, Maleki the Pallid a Ramstein the Gorger, než se hrdinové dostanou k baronovi. Z barona vzácně padá kůň Deathcharger.]] },
        { "Živá část", [[V západní části drží Šarlatoví. Vede je Grand Crusader Saidan Dathrohan – SPOILER: ve skutečnosti pán hrůzy Balnazzar, který se za něj vydává.

Cestou potkáš The Unforgiven, Timmyho the Cruel, Cannon Master Willeyho a Archivist Galforda. Poštovními klíči se dá přivolat Postmaster Malown.]] },
        { "Baron run", [[Když se hrdinové dostanou k baronovi do 45 minut, zachrání Ysidu Harmon, kterou Pohroma drží v zajetí. Tomuto závodu s časem se říká „baron run“ a hráči klasiky ho znají nazpaměť.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Stratholme"] = [[• Baron run: když se dostaneš k baronovi do 45 minut, zachráníš Ysidu Harmon.
• Z barona vzácně padá kůň Deathcharger.
• SPOILER: Grand Crusader Dathrohan je ve skutečnosti démon Balnazzar.]]

D["Molten Core"] = {
    title = "Molten Core", tag = "Ohnivé srdce hory – raid pro 40 hráčů s Ragnarosem na konci.",
    ch = {
        { "Vyvolání", [[Ragnaros byl vyvolán za Války tří kladiv, asi 230 let před otevřením Temného portálu. Čaroděj Thaurissan se snažil získat kouzelnou zbraň, aby vyhrál trpasličí občanskou válku. Jeho zuřivost nad smrtí manželky způsobila, že kouzlo prorazilo až do Firelands – a vtáhlo pána ohně na Azeroth. Ragnarosův prudký příchod vyvolal výbuchy, které roztříštily hory Redridge.]] },
        { "Brána do Firelands", [[Molten Core je brána z Firelands, říše ohně, na Azeroth. Hořící jezero tu slouží jako trhlina mezi světy, kterou mohou procházet elementálové. Ragnaros tu zůstal uvězněný, zotročil Dark Irony a velí ohnivým silám.]] },
        { "Ragnarosovi služebníci", [[Majordomo Executus je Ragnarosovým hlavním poručíkem – jediným, kdo dokáže pána ohně probudit. Dalšími strážci jsou Lucifron, Magmadar, Gehennas, Garr, Baron Geddon, Shazzrah, Sulfuron Harbinger a Golemagg the Incinerator.

Vodní elementálové Hydraxian Waterlords hledají dobrodruhy, kteří ohnivou hrozbu zastaví. Runy, které přivolávají Majordoma, je potřeba uhasit pomocí Aqual Quintessence.]] },
        { "Legendy", [[V Molten Core padají dvě legendární zbraně: Sulfuras, Hand of Ragnaros a části meče Thunderfury, Blessed Blade of the Windseeker. Ragnarosovo „BY FIRE BE PURGED!“ a „TOO SOON!“ zná každý hráč klasiky.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Molten Core"] = [[• Runy u bossů je třeba uhasit pomocí Aqual Quintessence od Duka Hydraxise (Azshara).
• Ragnarosovo „TOO SOON!“ a „BY FIRE BE PURGED!“ zná každý hráč klasiky.
• Baron Geddon z vás udělá bombu – utíkejte od skupiny.]]

D["Onyxia's Lair"] = {
    title = "Onyxia's Lair", tag = "Doupě černé dračice v Dustwallow Marsh – raid pro 40 hráčů.",
    ch = {
        { "Matka černých draků", [[Onyxia, dcera Deathwinga a sestra Nefariana, je matkou černého dračího rodu. Pod jménem lady Katrana Prestor manipulovala politikou Stormwindu, dokud ji neodhalil Marshal Windsor.]] },
        { "Doupě", [[Doupě leží v bažinách Wyrmbog v Dustwallow Marsh. Vchod je vytesaný tak, aby připomínal tlamu samotné dračí matky, a cesta dovnitř je lemovaná lávou.]] },
        { "Cesta k Onyxii", [[V klasickém WoW potřebovali hráči Aliance amulet Drakefire Amulet, který získali v řadě questů Great Masquerade, začínající u Marshala Windsora. Hráči Hordy prošli řadou questů s Rexxarem a Warlord's Command.

Souboj má tři fáze – na zemi, ve vzduchu s mláďaty a znovu na zemi. Slavné jsou ohnivý dech Deep Breath a nahrávka „Many whelps! Handle it!“.]] },
        { "Trofej", [[Hlava Onyxie se po vítězství pověsí u bran Stormwindu (nebo Orgrimmaru) a dá všem kolem buff Rallying Cry of the Dragonslayer. Z Onyxie padají i helmy sady Tier 2.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Onyxia's Lair"] = [[• Slavná nahrávka „Many whelps! Handle it!“ a „50 DKP minus!“ pochází odtud.
• Deep Breath – ohnivý dech přes celou jeskyni. Nestůjte před ní.
• Hlava Onyxie dá celému městu buff.]]

D["Blackwing Lair"] = {
    title = "Blackwing Lair", tag = "Laboratoř Nefariana na vrcholu Blackrock Spire – raid pro 40 hráčů.",
    ch = {
        { "Nefarianův plán", [[Nefarian, nejstarší syn Deathwinga, chtěl rozdrtit Ragnarose, svého soupeře o horu Blackrock, a posílit černý dračí rod. Experimentoval proto s krví všech dračích rodů, aby vytvořil nepřemožitelné válečníky – chromatický dračí rod, což se nepodařilo ani jeho otci.]] },
        { "Laboratoř", [[V doupěti kombinuje vejce a krev různých dračích rodů a pracuje s dračími kostmi. Celé Blackwing Lair je jedním obrovským chovným programem.

Razorgore the Untamed hlídá dračí vejce, drakonid Broodlord Lashlayer střeží potlačovací komory a chromatičtí draci Firemaw, Ebonroc a Flamegor jsou pokusy z Crimson Laboratories. Chromaggus je Nefarianův nejúspěšnější výtvor.]] },
        { "Vaelastrasz", [[Vaelastrasz je rudý drak, kterého Nefarian zajal a zkazil. Na začátku souboje dá hráčům Essence of the Red a pak sesílá Burning Adrenaline, která je po chvíli zabije. Je to smutný souboj s dobrým drakem, kterého Nefarian donutil bojovat.]] },
        { "Nefarian", [[Na konci čeká Nefarian, který se v Blackrock Spire vydává za lorda Victora Nefaria. Pro vstup do doupěte potřebovali hráči quest Blackhand's Command a proti Nefarianovu ohni plášť Onyxia Scale Cloak.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Blackwing Lair"] = [[• Vaelastrasz vám na začátku dá Essence of the Red a během boje sesílá na hráče Burning Adrenaline, která je po chvíli zabije. Smutný souboj s dobrým drakem, kterého Nefarian donutil bojovat.
• Na Nefariana potřebujete Onyxia Scale Cloak proti jeho ohni.]]

D["Zul'Gurub"] = {
    title = "Zul'Gurub", tag = "Hlavní město trollů Gurubashi ve Stranglethorn – raid pro 20 hráčů.",
    ch = {
        { "Hlavní město Gurubashi", [[Zul'Gurub na severovýchodě Stranglethorn byl před tisíci lety hlavním městem říše Gurubashi, kde civilizace džunglových trollů dosáhla vrcholu.]] },
        { "Hakkar", [[Kněží Atal'ai kdysi vyvolali Hakkara Soulflayera, prastarého krvavého boha. Rozpoutali tím občanskou válku a říše se zhroutila. Vyhnaní kněží uprchli na sever a postavili chrám Atal'Hakkar ve Swamp of Sorrows.]] },
        { "Návrat krvavého boha", [[Teď se Hakkar vrací. Jin'do the Hexxer zotročil v dávném hlavním městě velekněze, aby dokončil Hakkarovo vyvolání. Pět šampionů – každý s mocí prastarého zvířecího boha loa: netopýra (Jeklik), hada (Venoxis), pavouka (Mar'li), tygra (Thekal) a pantera (Arlokk) – podlehlo vlivu boha a začalo ho krmit svou silou.

Trollové Zandalari se se svými spojenci vydali město dobýt, aby Hakkarovu plnou manifestaci zastavili. Ve městě čeká i Bloodlord Mandokir, Gahz'ranka, kterého lze vylovit rybařením, a náhodný boss Edge of Madness.]] },
        { "Zajímavosti", [[Z Mandokira padá Swift Razzashi Raptor a z Thekala Swift Zulian Tiger – vzácné mounty. A Hakkar v roce 2005 nechtěně rozšířil „krvavý mor“ (Corrupted Blood) po celých serverech – slavná chyba, kterou dokonce studovali vědci zabývající se epidemiemi.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Zul'Gurub"] = [[• Z Mandokira padá Swift Razzashi Raptor a z Thekala Swift Zulian Tiger – vzácné mounty.
• Hakkar kdysi nechtěně rozšířil „krvavý mor“ po celém serveru – slavná chyba z roku 2005.]]

D["Ruins of Ahn'Qiraj"] = {
    title = "Ruins of Ahn'Qiraj", tag = "Vnější ruiny pevnosti Qiraji v Silithu – raid pro 20 hráčů.",
    ch = {
        { "Qiraji", [[Qiraji jsou prastará hmyzí rasa, uvězněná za kouzelnými bariérami asi před tisíci lety. Ve Válce pohyblivých písků je noční elfové spolu se čtyřmi dračími rody zahnali do jejich pevnostního města a uzavřeli tam.]] },
        { "Otevření brány", [[Když se objevily důkazy, že starodávná pečeť povoluje, začal Cenarion Circle koordinovat boj proti obnovené hrozbě Qiraji. Bronzový drak Anachronos pomohl dobrodruhům otevřít Scarab Wall a smrtelné rasy pak zahnaly Qiraji zpět do ruin.

V ruinách bojuje po boku hrdinů lidský generál Lieutenant General Andorov.]] },
        { "Bossové", [[Šest hlavních nepřátel představuje různé části velení Qiraji: písečný požírač Kurinnaxx, vojevůdce General Rajaxx se svými důstojníky, obsidiánový ničitel Moam, silithidský kolos Buru the Gorger, vosí královna Ayamiss the Hunter a nakonec Ossirian the Unscarred.]] },
        { "Odměny", [[Reputace u Cenarion Circle rozhoduje o přístupu k odměnám z questů. Ossiriana oslabíte krystaly, které se objevují po místnosti.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Ruins of Ahn'Qiraj"] = [[• Ossiriana oslabíte krystaly, které se objevují po místnosti.
• General Rajaxx má s sebou armádu – a s vámi bojuje i Lieutenant General Andorov.]]

D["Ahn'Qiraj Temple"] = {
    title = "Temple of Ahn'Qiraj", tag = "Chrám, kde spí Starý bůh C'Thun – raid pro 40 hráčů.",
    ch = {
        { "C'Thun", [[Po tisících letech spánku se Starý bůh C'Thun probudil a rychle obnovuje svou sílu. Je posledním a největším nepřítelem chrámu – a stojí za silithidy i Qiraji.]] },
        { "Císaři", [[Uvnitř chrámu vládnou říši Qiraji císaři Vek'lor a Vek'nilash. Asi tisíc let od Války pohyblivých písků byli uvězněni ve svém chrámu, sotva zadržovaní kouzelnou bariérou.]] },
        { "Bossové", [[U bran chrámu stráží The Prophet Skeram. V podzemí úlu čekají Silithid Royalty – Lord Kri, Princess Yauj a Vem. Dalšími nepřáteli jsou Battleguard Sartura, Fankriss the Unyielding, Viscidus, kterého je potřeba zmrazit a rozbít, Princess Huhuran a Ouro.

C'Thun hráčům šeptá do hlavy – zprávy jako „You will die.“ se objevují v chatu.]] },
        { "Brány Ahn'Qiraj", [[Chrám se otevřel až poté, co hráči znovu sestavili Scepter of the Shifting Sands a celý server sbíral suroviny pro válečné úsilí. Hráč, který udeřil do gongu, získal titul Scarab Lord – jedno z nejprestižnějších ocenění v historii WoW.]] },
    },
}
WoWpoCesku_LoreTajemstvi["Ahn'Qiraj Temple"] = [[• C'Thun vám šeptá do hlavy („You will die.“) – zprávy se objevují v chatu.
• Viscidus se musí zmrazit a pak rozbít.]]
A["Temple of Ahn'Qiraj"] = "Ahn'Qiraj Temple"
A["Ahn'Qiraj"] = "Ahn'Qiraj Temple"

D["Naxxramas"] = {
    title = "Naxxramas", tag = "Létající nekropole Kel'Thuzada – poslední raid klasiky (40 hráčů).",
    ch = {
        { "Nekropole", [[Naxxramas byl původně prastarý podzemní zikkurat nerubianů. Síly Lich Kinga vedené Anub'arakem ho proměnily v létající nekropoli pod velením Kel'Thuzada, který odsud založil Kult zatracených v Lordaeronu. Dnes se vznáší nad Eastern Plaguelands.]] },
        { "Čtyři křídla", [[V pavoučím křídle čekají Anub'Rekhan, Grand Widow Faerlina a Maexxna. V morovém Noth the Plaguebringer, Heigan the Unclean a Loatheb. Ve vojenském Instructor Razuvious, Gothik the Harvester a Čtyři jezdci – v klasické verzi Highlord Mograine, Thane Korth'azz, Lady Blaumeux a Sir Zeliek. V konstrukčním Patchwerk, Grobbulus, Gluth a Thaddius s pomocníky Feugenem a Stalaggem.]] },
        { "Sapphiron a Kel'Thuzad", [[Doupě mrazivého draka (Frostwyrm Lair) hlídají nemrtvý drak Sapphiron a sám Kel'Thuzad. Je to poslední souboj klasického WoW. SPOILER: Kel'Thuzad po porážce uteče do Northrendu.]] },
        { "Vstup", [[Argent Dawn objevila kouzelné maskování, kterým lze obejít ochranné bariéry runového portálu do nekropole – a tak mohou hrdinové na pevnost zaútočit.

Heiganův „tanec“ a Thaddiovo rozdělení na plus a minus náboj patří k nejslavnějším soubojům celé historie WoW.]] },
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

-- Questy k dungeonům (classic DB, ZoneOrSort dungeonu): { id, název, level, min. level, frakce, kdo ho dává, odměny }
-- generuje gen-dungquesty.js; třídní a opakovatelné questy vynechány
WoWpoCesku_DungeonQuests = {
    ["Ragefire Chasm"] = {
        { 5728, "Hidden Enemies", 16, 9, "H", "Thrall", "" },
        { 5724, "Returning the Lost Satchel", 16, 9, "H", "Maur Grimtotem", "Featherbead Bracers, Savannah Bracers" },
        { 5722, "Searching for the Lost Satchel", 16, 9, "H", "Rahauro", "" },
        { 5761, "Slaying the Beast", 16, 9, "H", "Neeru Fireblade", "" },
        { 5723, "Testing an Enemy's Strength", 15, 9, "H", "Rahauro", "" },
        { 5725, "The Power to Destroy...", 16, 9, "H", "Varimathras", "Ghastly Trousers, Dredgemire Leggings, Gargoyle Leggings" },
    },
    ["Wailing Caverns"] = {
        { 914, "Leaders of the Fang", 22, 11, "H", "Nara Wildmane", "Crescent Staff, Wingblade" },
        { 1489, "Hamuul Runetotem", 16, 12, "H", "Tonga Runetotem", "" },
        { 1490, "Nara Wildmane", 16, 12, "H", "Arch Druid Hamuul Runetotem", "" },
        { 1486, "Deviate Hides", 17, 13, nil, "Nalpak", "Slick Deviate Leggings" },
        { 1491, "Smart Drinks", 18, 13, nil, "Mebok Mizzyrix", "" },
        { 962, "Serpentbloom", 18, 14, "H", "Apothecary Zamah", "Apothecary Gloves" },
        { 959, "Trouble at the Docks", 18, 14, nil, "Crane Operator Bigglefuzz", "" },
        { 1487, "Deviate Eradication", 21, 15, nil, "Ebru", "Pattern: Deviate Scale Belt, Sizzle Stick, Dagmire Gauntlets" },
        { 6981, "The Glowing Shard", 26, 15, nil, "", "" },
    },
    ["The Deadmines"] = {
        { 168, "Collecting Memories", 18, 14, "A", "Wilder Thistlenettle", "Tunneler's Boots, Dusty Mining Gloves" },
        { 214, "Red Silk Bandanas", 17, 14, "A", "Scout Riell", "Solid Shortblade, Scrimshaw Dagger, Piercing Axe" },
        { 166, "The Defias Brotherhood", 22, 14, "A", "Gryan Stoutmantle", "Chausses of Westfall, Tunic of Westfall, Staff of Westfall" },
        { 167, "Oh Brother. . .", 20, 15, "A", "Wilder Thistlenettle", "Miner's Revenge" },
        { 2040, "Underground Assault", 20, 15, "A", "Shoni the Shilent", "Polar Gauntlets, Sable Wand" },
    },
    ["Shadowfang Keep"] = {
        { 1013, "The Book of Ur", 26, 16, "H", "Keeper Bel'dugur", "Grizzled Boots, Steel-clasped Bracers" },
        { 1014, "Arugal Must Die", 27, 18, "H", "Dalar Dawnweaver", "Seal of Sylvanas" },
        { 1098, "Deathstalkers in Shadowfang", 25, 18, "H", "High Executor Hadrec", "Ghostly Mantle" },
    },
    ["Blackfathom Deeps"] = {
        { 971, "Knowledge in the Deeps", 23, 10, "A", "Gerrig Bonegrip", "Sustaining Ring" },
        { 6564, "Allegiance to the Old Gods", 22, 17, "H", "", "" },
        { 6565, "Allegiance to the Old Gods", 26, 17, "H", "Je'neu Sancrea", "Band of the Fist, Chestnut Mantle" },
        { 6563, "The Essence of Aku'Mai", 22, 17, "H", "Je'neu Sancrea", "" },
        { 6562, "Trouble in the Deeps", 22, 17, "H", "Tsunaman", "" },
        { 1200, "Blackfathom Villainy", 27, 18, "A", "Argent Guard Thaelrid", "Gravestone Scepter, Arctic Buckler" },
        { 6561, "Blackfathom Villainy", 27, 18, "H", "Argent Guard Thaelrid", "Gravestone Scepter, Arctic Buckler" },
        { 1198, "In Search of Thaelrid", 24, 18, "A", "Dawnwatcher Shaedlass", "" },
        { 1275, "Researching the Corruption", 24, 18, "A", "Gershala Nightwhisper", "Beetle Clasps, Prelacy Cape" },
        { 1199, "Twilight Falls", 25, 20, "A", "Argent Guard Manados", "Nimbus Boots, Heartwood Girdle" },
        { 6921, "Amongst the Ruins", 27, 21, "H", "Je'neu Sancrea", "" },
    },
    ["The Stockade"] = {
        { 391, "The Stockade Riots", 29, 16, "A", "Warden Thelwater", "" },
        { 377, "Crime and Punishment", 26, 22, "A", "Councilman Millstipe", "Ambassador's Boots, Darkshire Mail Leggings" },
        { 387, "Quell The Uprising", 26, 22, "A", "Warden Thelwater", "" },
        { 388, "The Color of Blood", 26, 22, "A", "Nikova Raskol", "" },
        { 378, "The Fury Runs Deep", 27, 22, "A", "Motley Garmason", "Belt of Vindication, Headbasher" },
        { 386, "What Comes Around...", 25, 22, "A", "Guard Berton", "Lucine Longsword, Hardened Root Staff" },
    },
    ["Gnomeregan"] = {
        { 2926, "Gnogaine", 27, 20, "A", "Ozzie Togglevolt", "" },
        { 2843, "Gnomer-gooooone!", 35, 20, "H", "Scooty", "" },
        { 2928, "Gyrodrillmatic Excavationators", 30, 20, "A", "Shoni the Shilent", "Shoni's Disarming Tool, Shilly Mitts" },
        { 2922, "Save Techbot's Brain!", 26, 20, "A", "Tinkmaster Overspark", "" },
        { 2927, "The Day After", 27, 20, "A", "Gnoarn", "" },
        { 2962, "The Only Cure is More Green Glow", 30, 20, "A", "Ozzie Togglevolt", "" },
        { 2923, "Tinkmaster Overspark", 26, 20, "A", "Brother Sarno", "" },
        { 2904, "A Fine Mess", 30, 24, nil, "Kernobee", "Fire-welded Bracers, Fairywing Mantle" },
        { 2924, "Essential Artificials", 30, 24, "A", "Klockmort Spannerspan", "" },
        { 2925, "Klockmort's Essentials", 30, 24, "A", "Mathiel", "" },
        { 2931, "Castpipe's Task", 28, 25, "A", "Gaxim Rustfizzle", "" },
        { 2930, "Data Rescue", 30, 25, "A", "Master Mechanic Castpipe", "Repairman's Cape, Mechanic's Pipehammer" },
        { 2842, "Chief Engineer Scooty", 35, 25, "H", "Sovik", "" },
        { 2841, "Rig Wars", 35, 25, "H", "Nogg", "Civinad Robes, Triprunner Dungarees, Dual Reinforced Leggings" },
        { 2929, "The Grand Betrayal", 35, 25, "A", "High Tinker Mekkatorque", "Civinad Robes, Triprunner Dungarees, Dual Reinforced Leggings" },
        { 2951, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 2952, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 4601, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 4602, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 4605, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 4606, "The Sparklematic 5200!", 30, 25, nil, "[The Sparklematic 5200]", "" },
        { 2945, "Grime-Encrusted Ring", 34, 28, nil, "", "" },
        { 2947, "Return of the Ring", 34, 28, "A", "[The Sparklematic 5200]", "" },
        { 2949, "Return of the Ring", 34, 28, "H", "[The Sparklematic 5200]", "" },
    },
    ["Razorfen Kraul"] = {
        { 1221, "Blueleaf Tubers", 26, 20, nil, "Mebok Mizzyrix", "" },
        { 1144, "Willix the Importer", 30, 23, nil, "Willix the Importer", "Monkey Ring, Snake Hoop, Tiger Band" },
        { 1142, "Mortality Wanes", 30, 25, "A", "Heralath Fallowbrook", "Mourning Shawl, Lancer Boots" },
        { 1102, "A Vengeful Fate", 34, 29, "H", "Auld Stonespire", "Berylline Pads, Stonefist Girdle, Marbled Buckler" },
        { 1101, "The Crone of the Kraul", 34, 29, "A", "Falfindel Waywarder", "Berylline Pads, Stonefist Girdle, Marbled Buckler" },
        { 1109, "Going, Going, Guano!", 33, 30, "H", "Master Apothecary Faranell", "" },
    },
    ["Scarlet Monastery"] = {
        { 1160, "Test of Lore", 36, 25, "H", "Parqual Fintallas", "" },
        { 1051, "Vorrel's Revenge", 33, 25, "H", "Vorrel Sengutz", "Vorrel's Boots, Mantle of Woe, Grimsteel Cape" },
        { 1049, "Compendium of the Fallen", 38, 28, "H", "Sage Truthseeker", "Vile Protector, Forcestone Buckler, Omega Orb" },
        { 1050, "Mythology of the Titans", 38, 28, "A", "Librarian Mae Paledust", "Explorers' League Commendation" },
        { 1113, "Hearts of Zeal", 33, 30, "H", "Master Apothecary Faranell", "" },
        { 1048, "Into The Scarlet Monastery", 42, 33, "H", "Varimathras", "Sword of Omen, Prophetic Cane, Dragon's Blood Necklace" },
        { 1053, "In the Name of the Light", 40, 34, "A", "Raleigh the Devout", "Sword of Serenity, Bonebiter, Black Menace, Orb of Lorica" },
    },
    ["Razorfen Downs"] = {
        { 6626, "A Host of Evil", 35, 28, nil, "Myriam Moonsinger", "" },
        { 6521, "An Unholy Alliance", 36, 28, "H", "Varimathras", "Skullbreaker, Nail Spitter, Zealot's Robe" },
        { 6522, "An Unholy Alliance", 36, 28, "H", "", "" },
        { 3525, "Extinguishing the Idol", 37, 32, nil, "Belnistrasz", "Dragonclaw Ring" },
        { 3523, "Scourge of the Downs", 37, 32, nil, "Belnistrasz", "" },
        { 3341, "Bring the End", 42, 37, "H", "Andrew Brownell", "Vanquisher's Sword, Amberglow Talisman" },
        { 3636, "Bring the Light", 42, 39, "A", "Archbishop Benedictus", "Vanquisher's Sword, Amberglow Talisman" },
    },
    ["Uldaman"] = {
        { 704, "Agmond's Fate", 38, 30, "A", "Prospector Ironband", "Prospector Gloves" },
        { 2418, "Power Stones", 36, 30, nil, "Rigglefuzz", "Energized Stone Circle, Duracin Bracers, Everlast Boots" },
        { 709, "Solution to Doom", 40, 30, nil, "Theldurin the Lost", "Doomsayer's Robe" },
        { 1360, "Reclaimed Treasures", 43, 33, "A", "Krom Stoutarm", "" },
        { 2342, "Reclaimed Treasures", 43, 33, "H", "Patrick Garrett", "" },
        { 721, "A Sign of Hope", 35, 35, "A", "Prospector Ryedol", "" },
        { 722, "Amulet of Secrets", 40, 35, "A", "Hammertoe Grez", "" },
        { 2240, "The Hidden Chamber", 40, 35, "A", "Baelog", "Dwarven Charge, Explorer's League Lodestar" },
        { 2398, "The Lost Dwarves", 40, 35, "A", "Prospector Stormpike", "" },
        { 1139, "The Lost Tablets of Will", 45, 35, "A", "Advisor Belgrum", "Medal of Courage" },
        { 17, "Uldaman Reagent Run", 42, 36, "A", "Ghak Healtouch", "" },
        { 2202, "Uldaman Reagent Run", 42, 36, "H", "Jarkal Mossmeld", "" },
        { 2200, "Back to Uldaman", 42, 37, "A", "Talvash del Kissel", "" },
        { 2340, "Deliver the Gems", 44, 37, "H", "Jarkal Mossmeld", "" },
        { 2339, "Find the Gems and Power Source", 44, 37, "H", "Jarkal Mossmeld", "" },
        { 2199, "Lore for a Price", 41, 37, "A", "Talvash del Kissel", "" },
        { 2283, "Necklace Recovery", 41, 37, "H", "Dran Droffers", "" },
        { 2284, "Necklace Recovery, Take 2", 41, 37, "H", "Dran Droffers", "" },
        { 2204, "Restoring the Necklace", 44, 37, "A", "[Talvash's Scrying Bowl]", "" },
        { 2361, "Restoring the Necklace", 44, 37, "A", "Talvash del Kissel", "Talvash's Enhancing Necklace" },
        { 2198, "The Shattered Necklace", 41, 37, "A", "", "" },
        { 2318, "Translating the Journal", 42, 37, "H", "Remains of a Paladin", "" },
        { 2338, "Translating the Journal", 42, 37, "H", "Jarkal Mossmeld", "" },
        { 2201, "Find the Gems", 43, 40, "A", "Remains of a Paladin", "" },
        { 2341, "Necklace Recovery, Take 3", 44, 40, "H", "Dran Droffers", "Jarkal's Enhancing Necklace" },
        { 2278, "The Platinum Discs", 47, 40, nil, "[The Discs of Norgannon]", "" },
        { 2279, "The Platinum Discs", 47, 40, "A", "[The Discs of Norgannon]", "" },
        { 2280, "The Platinum Discs", 47, 40, "H", "[The Discs of Norgannon]", "" },
    },
    ["Zul'Farrak"] = {
        { 2768, "Divino-matic Rod", 47, 40, nil, "Chief Engineer Bilgewhizzle", "Masons Fraternity Ring, Engineer's Guild Headpiece" },
        { 2770, "Gahz'rilla", 50, 40, nil, "Wizzle Brassbolts", "Carrot on a Stick" },
        { 2991, "Nekrum's Medallion", 47, 40, "A", "Thadius Grimshade", "" },
        { 2865, "Scarab Shells", 45, 40, nil, "Tran'rek", "" },
        { 2861, "Tabetha's Task", 46, 40, nil, "Ursyn Ghull / Anastasia Hartwell", "" },
        { 3527, "The Prophecy of Mosh'aru", 47, 40, nil, "Yeh'kinya", "" },
        { 2936, "The Spider God", 45, 40, "H", "Master Gadrin", "" },
        { 2846, "Tiara of the Deep", 46, 40, nil, "Tabetha", "Spellshifter Rod, Gemshale Pauldrons" },
        { 2864, "Tran'rek", 45, 40, nil, "Krazek", "" },
        { 3042, "Troll Temper", 45, 40, nil, "Trenton Lighthammer", "" },
    },
    ["Maraudon"] = {
        { 7068, "Shadowshard Fragments", 42, 38, "H", "Uthel'nay", "Zealous Shadowshard Pendant, Prodigious Shadowshard Pendant" },
        { 7070, "Shadowshard Fragments", 42, 38, "A", "Archmage Tervosh", "Zealous Shadowshard Pendant, Prodigious Shadowshard Pendant" },
        { 7067, "The Pariah's Instructions", 48, 39, nil, "Centaur Pariah", "Mark of the Chosen" },
        { 7044, "Legends of Maraudon", 49, 41, nil, "Cavindra", "" },
        { 7046, "The Scepter of Celebras", 49, 41, nil, "Celebras the Redeemed", "Scepter of Celebras" },
        { 7028, "Twisted Evils", 47, 41, nil, "Willow", "Acumen Robes, Sprightring Helm, Relentless Chain, Hulkstone Pauldrons" },
        { 7029, "Vyletongue Corruption", 47, 41, "H", "Vark Battlescar", "Woodseed Hoop, Sagebrush Girdle, Branchclaw Gauntlets" },
        { 7041, "Vyletongue Corruption", 47, 41, "A", "Talendria", "Woodseed Hoop, Sagebrush Girdle, Branchclaw Gauntlets" },
        { 7064, "Corruption of Earth and Seed", 51, 45, "H", "Selendra", "Thrash Blade, Resurgence Rod, Verdant Keeper's Aim" },
        { 7065, "Corruption of Earth and Seed", 51, 45, "A", "Keeper Marandis", "Thrash Blade, Resurgence Rod, Verdant Keeper's Aim" },
        { 7066, "Seed of Life", 51, 45, nil, "Zaetar's Spirit", "" },
    },
    ["Sunken Temple"] = {
        { 1446, "Jammal'an the Prophet", 53, 38, nil, "Atal'ai Exile", "Rainstrider Leggings, Helm of Exile" },
        { 1445, "The Temple of Atal'Hakkar", 50, 38, "H", "Fel'zerul", "Guardian Talisman" },
        { 3528, "The God Hakkar", 53, 40, nil, "Yeh'kinya", "Avenguard Helm, Lifeforce Dirk, Gemburst Circlet" },
        { 1475, "Into The Temple of Atal'Hakkar", 50, 41, "A", "Brohann Caskbelly", "Guardian Talisman" },
        { 3446, "Into the Depths", 51, 46, nil, "Marvon Rivetseeker", "" },
        { 3447, "Secret of the Circle", 51, 46, nil, "Marvon Rivetseeker", "Hakkari Urn" },
        { 3380, "The Sunken Temple", 51, 46, "H", "Witch Doctor Uzer'i", "" },
        { 4146, "Zapper Fuel", 52, 47, "H", "Liv Rizzlefix", "" },
        { 3373, "The Essence of Eranikus", 55, 48, nil, "", "Chained Essence of Eranikus" },
        { 8733, "Eranikus, Tyrant of the Dream", 60, 60, nil, "Malfurion Stormrage", "" },
    },
    ["Blackrock Depths"] = {
        { 4083, "The Spectral Chalice", 55, 40, nil, "[Spectral Chalice]", "" },
        { 4242, "Abandoned Hope", 54, 48, "A", "Marshal Windsor", "Conservator Helm, Shieldplate Sabatons, Windshear Leggings" },
        { 3981, "Commander Gor'shak", 52, 48, "H", "Galamav the Marksman", "" },
        { 3801, "Dark Iron Legacy", 52, 48, nil, "Franclorn Forgewright", "" },
        { 3802, "Dark Iron Legacy", 52, 48, nil, "Franclorn Forgewright", "" },
        { 3907, "Disharmony of Fire", 56, 48, "H", "Thunderheart", "Sunborne Cape, Nightfall Gloves, Crypt Demon Bracers, Stalwart Clutch" },
        { 4263, "Incendius!", 56, 48, "A", "Jalinda Sprig", "Sunborne Cape, Nightfall Gloves, Crypt Demon Bracers, Stalwart Clutch" },
        { 4081, "KILL ON SIGHT: Dark Iron Dwarves", 52, 48, "H", "[WANTED]", "" },
        { 4241, "Marshal Windsor", 54, 48, "A", "Marshal Maxwell", "" },
        { 4136, "Ribbly Screwspigot", 53, 48, nil, "Yuka Screwspigot", "Rancor Boots, Penance Spaulders, Splintsteel Armor" },
        { 4002, "The Eastern Kingdom", 54, 48, "H", "Thrall", "" },
        { 7201, "The Last Element", 54, 48, "H", "Shadowmage Vivian Lagrave", "Lagrave's Seal" },
        { 4004, "The Princess Saved?", 60, 48, "H", "Princess Moira Bronzebeard", "Thrall's Resolve, Eye of Orgrimmar" },
        { 4003, "The Royal Rescue", 59, 48, "H", "Thrall", "" },
        { 4001, "What Is Going On?", 54, 48, "H", "Commander Gor'shak", "" },
        { 4324, "Yuka Screwspigot", 53, 48, nil, "Yorba Screwspigot", "" },
        { 4264, "A Crumpled Up Note", 58, 50, "A", "", "" },
        { 4282, "A Shred of Hope", 58, 50, "A", "Marshal Windsor", "" },
        { 4126, "Hurley Blackbreath", 55, 50, "A", "Ragnar Thunderbrew", "Swiftstrike Cudgel, Limb Cleaver" },
        { 4322, "Jail Break!", 58, 50, "A", "Marshal Windsor", "Ward of the Elements, Blade of Reckoning, Skilled Fighting Blade" },
        { 4341, "Kharan Mighthammer", 59, 50, "A", "King Magni Bronzebeard", "" },
        { 4342, "Kharan's Tale", 59, 50, "A", "Kharan Mighthammer", "" },
        { 4082, "KILL ON SIGHT: High Ranking Dark Iron Officials", 54, 50, "H", "[KILL ON SIGHT]", "" },
        { 4134, "Lost Thunderbrew Recipe", 55, 50, "H", "Shadowmage Vivian Lagrave", "Swiftstrike Cudgel, Limb Cleaver" },
        { 4128, "Ragnar Thunderbrew", 55, 50, "A", "Enohar Thunderbrew", "" },
        { 4361, "The Bearer of Bad News", 59, 50, "A", "Kharan Mighthammer", "" },
        { 4362, "The Fate of the Kingdom", 59, 50, "A", "King Magni Bronzebeard", "" },
        { 4286, "The Good Stuff", 56, 50, "A", "Oralius", "" },
        { 4123, "The Heart of the Mountain", 55, 50, nil, "Maxwort Uberglint", "" },
        { 4201, "The Love Potion", 54, 50, nil, "Mistress Nagmara", "Manacle Cuffs, Nagmara's Whipping Belt" },
        { 4363, "The Princess's Surprise", 59, 50, "A", "Princess Moira Bronzebeard", "Magni's Will, Songstone of Ironforge" },
        { 4133, "Vivian Lagrave", 55, 50, "H", "Apothecary Zinge", "" },
        { 4024, "A Taste of Flame", 58, 52, nil, "Cyrus Therepentous", "Shaleskin Cape, Wyrmhide Spaulders, Valconian Sash" },
        { 4122, "Grark Lorkrub", 58, 52, "H", "Lexlort", "" },
        { 4132, "Operation: Death to Angerforge", 58, 52, "H", "Warlord Goretooth", "Conqueror's Medallion" },
        { 4121, "Precarious Predicament", 58, 52, "H", "Grark Lorkrub", "" },
        { 4063, "The Rise of the Machines", 58, 52, "H", "Lotwil Veriatus", "Azure Moon Amice, Raincaster Drape, Basaltscale Armor, Lavaplate Gauntlets" },
        { 9015, "The Challenge", 60, 58, nil, "Falrin Treeshaper", "" },
    },
    ["Blackrock Spire"] = {
        { 4788, "The Final Tablets", 58, 40, nil, "Prospector Ironboot", "" },
        { 4982, "Bijou's Belongings", 59, 55, "H", "Bijou", "" },
        { 5001, "Bijou's Belongings", 59, 55, "A", "Bijou", "" },
        { 4983, "Bijou's Reconnaissance Report", 59, 55, "H", "Bijou", "Freewind Gloves, Seapost Girdle" },
        { 7761, "Blackhand's Command", 60, 55, nil, "", "" },
        { 6602, "Blood of the Black Dragon Champion", 60, 55, "H", "Rexxar", "Drakefire Amulet" },
        { 4862, "En-Ay-Es-Tee-Why", 59, 55, nil, "Kibler", "" },
        { 5047, "Finkle Einhorn, At Your Service!", 60, 55, nil, "Finkle Einhorn", "" },
        { 4974, "For The Horde!", 60, 55, "H", "Thrall", "Mark of Tyranny, Eye of the Beast, Blackhand's Breadth" },
        { 5089, "General Drakkisath's Command", 60, 55, "A", "", "" },
        { 5102, "General Drakkisath's Demise", 60, 55, "A", "Marshal Maxwell", "Mark of Tyranny, Eye of the Beast, Blackhand's Breadth" },
        { 4729, "Kibler's Exotic Pets", 59, 55, nil, "Kibler", "" },
        { 5081, "Maxwell's Mission", 60, 55, "A", "Marshal Maxwell", "Wyrmthalak's Shackles, Omokk's Girth Restrainer, Halycon's Muzzle, Vosh'gajin's Strand" },
        { 5002, "Message to Maxwell", 59, 55, "A", "Bijou", "" },
        { 4866, "Mother's Milk", 60, 55, nil, "Ragged John", "Ragged John's Neverending Cup" },
        { 6569, "Oculus Illusions", 60, 55, "H", "Myranda the Hag", "" },
        { 4981, "Operative Bijou", 59, 55, "H", "Lexlort", "" },
        { 4701, "Put Her Down", 59, 55, "A", "Helendis Riverhorn", "Astoria Robes, Traphook Jerkin, Jadescale Breastplate" },
        { 5127, "The Demon Forge", 60, 55, nil, "Lorax", "Plans: Demon Forged Breastplate, Demon Kissed Sack" },
        { 4724, "The Pack Mistress", 59, 55, "H", "Galamav the Marksman", "Astoria Robes, Traphook Jerkin, Jadescale Breastplate" },
        { 4867, "Urok Doomhowl", 60, 55, nil, "Warosh", "Prismcharm" },
        { 4903, "Warlord's Command", 60, 55, "H", "", "Wyrmthalak's Shackles, Omokk's Girth Restrainer, Halycon's Muzzle, Vosh'gajin's Strand" },
        { 4765, "Delivery to Ridgewell", 60, 57, "A", "Mayara Brightwing", "Swiftfoot Treads, Blinkstrike Armguards" },
        { 4764, "Doomrigger's Clasp", 60, 57, "A", "Mayara Brightwing", "" },
        { 4735, "Egg Collection", 60, 57, nil, "Tinkee Steamboil", "" },
        { 4734, "Egg Freezing", 60, 57, nil, "Tinkee Steamboil", "" },
        { 4766, "Mayara Brightwing", 60, 57, "A", "Count Remington Ridgewell", "" },
        { 4742, "Seal of Ascension", 60, 57, nil, "Vaelan", "" },
        { 4768, "The Darkstone Tablet", 60, 57, "H", "Shadowmage Vivian Lagrave", "Swiftfoot Treads, Blinkstrike Armguards" },
        { 5160, "The Matron Protectorate", 60, 57, nil, "Awbee", "" },
        { 4907, "Tinkee Steamboil", 60, 57, nil, "Felnok Steelspring", "" },
        { 4769, "Vivian Lagrave and the Darkstone Tablet", 60, 57, "H", "Apothecary Zinge", "" },
        { 8995, "Mea Culpa, Lord Valthalak", 60, 58, nil, "Bodley", "" },
        { 8966, "The Left Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
        { 8989, "The Right Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
    },
    ["Dire Maul"] = {
        { 7492, "Camp Mojache", 57, 54, "H", "Warcaller Gorlach", "" },
        { 7481, "Elven Legends", 60, 54, "H", "Sage Korolusk", "" },
        { 7482, "Elven Legends", 60, 54, "A", "Scholar Runethorn", "" },
        { 7494, "Feathermoon Stronghold", 57, 54, "A", "Crier Goodman / Courier Hammerfall", "" },
        { 7488, "Lethtendris's Web", 57, 54, "A", "Latronicus Moonspear", "Lorespinner" },
        { 7489, "Lethtendris's Web", 57, 54, "H", "Talo Thornhoof", "Lorespinner" },
        { 7441, "Pusillin and the Elder Azj'Tordin", 58, 54, nil, "Azj'Tordin", "Spry Boots, Sprinter's Sword" },
        { 1193, "A Broken Trap", 60, 56, nil, "[Broken Trap]", "" },
        { 5518, "The Gordok Ogre Suit", 60, 56, nil, "Knot Thimblejack", "Gordok Ogre Suit" },
        { 7461, "The Madness Within", 60, 56, nil, "Shen'dralar Ancient", "" },
        { 7462, "The Treasure of the Shen'dralar", 60, 56, "A", "Shen'dralar Ancient", "Bonecrusher, Backwood Helm, Sedge Boots" },
        { 7877, "The Treasure of the Shen'dralar", 60, 56, "H", "Shen'dralar Ancient", "Bonecrusher, Backwood Helm, Sedge Boots" },
        { 1318, "Unfinished Gordok Business", 60, 56, nil, "", "Gordok's Handguards, Gordok's Gauntlets, Gordok's Gloves, Gordok's Handwraps" },
        { 7703, "Unfinished Gordok Business", 60, 56, nil, "Captain Kromcrush", "Gordok's Handguards, Gordok's Gauntlets, Gordok's Gloves, Gordok's Handwraps" },
        { 5525, "Free Knot!", 60, 57, nil, "Knot Thimblejack", "" },
        { 5528, "The Gordok Taste Test", 60, 57, nil, "Stomper Kreeg", "Gordok Green Grog, Kreeg's Stout Beatdown" },
        { 8948, "Anthion's Old Friend", 60, 58, nil, "Anthion Harmon", "" },
        { 8949, "Falrin's Vendetta", 60, 58, nil, "Falrin Treeshaper", "Beads of Ogre Might, Beads of Ogre Mojo" },
        { 8950, "The Instigator's Enchantment", 60, 58, nil, "Falrin Treeshaper", "" },
        { 8967, "The Left Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
        { 8990, "The Right Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
        { 7507, "Foror's Compendium", 60, 60, nil, "", "" },
        { 7508, "The Forging of Quel'Serrar", 60, 60, nil, "", "" },
    },
    ["Scholomance"] = {
        { 5341, "Barov Family Fortune", 60, 52, "H", "Alexi Barov", "" },
        { 5343, "Barov Family Fortune", 60, 52, "A", "Weldon Barov", "" },
        { 5382, "Doctor Theolen Krastinov, the Butcher", 60, 55, nil, "Eva Sarkhoff", "" },
        { 5384, "Kirtonos the Herald", 60, 55, nil, "Eva Sarkhoff", "Spectral Essence, Penelope's Rose, Mirah's Song" },
        { 5515, "Krastinov's Bag of Horrors", 60, 55, nil, "Eva Sarkhoff", "" },
        { 5529, "Plagued Hatchlings", 58, 55, nil, "Betina Bigglezink", "" },
        { 5531, "Betina Bigglezink", 60, 57, nil, "Leonid Barthalomew the Revered", "" },
        { 4771, "Dawn's Gambit", 60, 57, nil, "Betina Bigglezink", "Windreaper, Dancing Sliver" },
        { 5466, "The Lich, Ras Frostwhisper", 60, 57, nil, "Magistrate Marduke", "Darrowshire Strongguard, Warblade of Caer Darrow, Crown of Caer Darrow, Darrowspike" },
        { 8969, "The Left Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
        { 8992, "The Right Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
    },
    ["Stratholme"] = {
        { 5848, "Of Love and Family", 60, 52, nil, "Artist Renfray", "" },
        { 5263, "Above and Beyond", 60, 55, nil, "Duke Nicholas Zverenhoff", "" },
        { 5125, "Aurius' Reckoning", 60, 55, nil, "Aurius", "Will of the Martyr, Blood of the Martyr" },
        { 5243, "Houses of the Holy", 60, 55, nil, "Leonid Barthalomew the Revered", "Crown of the Penitent, Band of the Penitent" },
        { 5213, "The Active Agent", 60, 55, nil, "Betina Bigglezink", "Seal of the Dawn, Rune of the Dawn" },
        { 5251, "The Archivist", 60, 55, nil, "Duke Nicholas Zverenhoff", "" },
        { 5212, "The Flesh Does Not Lie", 60, 55, nil, "Betina Bigglezink", "" },
        { 5214, "The Great Fras Siabi", 60, 55, nil, "Smokey LaRue", "Smokey's Lighter" },
        { 5282, "The Restless Souls", 60, 55, nil, "Egan", "Testament of Hope" },
        { 5262, "The Truth Comes Crashing Down", 60, 55, nil, "", "" },
        { 6163, "Ramstein", 60, 56, "H", "Nathanos Blightcaller", "Royal Seal of Alexis, Elemental Circle" },
        { 5463, "Menethil's Gift", 60, 57, nil, "Leonid Barthalomew the Revered", "" },
        { 8945, "Dead Man's Plea", 60, 58, nil, "Anthion Harmon", "" },
        { 8968, "The Left Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
        { 8991, "The Right Piece of Lord Valthalak's Amulet", 60, 58, nil, "Bodley", "" },
    },
    ["Molten Core"] = {
        { 7848, "Attunement to the Core", 60, 55, nil, "Lothos Riftwaker", "" },
        { 8578, "Scrying Goggles? No Problem!", 60, 60, nil, "[Inconspicuous Crate]", "" },
    },
    ["Blackwing Lair"] = {
        { 8730, "Nefarius's Corruption", 60, 60, nil, "Vaelastrasz the Corrupt", "Onyx Embedded Leggings, Amulet of Shadow Shielding" },
        { 8288, "Only One May Rise", 60, 60, nil, "Baristolth of the Shifting Sands", "" },
    },
    ["Ruins of Ahn'Qiraj"] = {
        { 8791, "The Fall of Ossirian", 60, 60, nil, "", "Charm of the Shifting Sands, Amulet of the Shifting Sands, Choker of the Shifting Sands, Pendant of the Shifting Sands" },
    },
    ["Ahn'Qiraj Temple"] = {
        { 8801, "C'Thun's Legacy", 60, 60, nil, "", "" },
        { 8579, "Mortal Champions", 60, 60, nil, "Kandrostrasz", "" },
        { 8802, "The Savior of Kalimdor", 60, 60, nil, "Caelestrasz", "Amulet of the Fallen God, Cloak of the Fallen God, Ring of the Fallen God" },
    },
    ["Naxxramas"] = {
        { 9033, "Echoes of War", 60, 60, nil, "Commander Eligor Dawnbringer", "" },
        { 9233, "Omarion's Handbook", 60, 60, nil, "", "" },
        { 9120, "The Fall of Kel'Thuzad", 60, 60, nil, "", "Mark of the Champion, Mark of the Champion" },
        { 9229, "The Fate of Ramaladni", 60, 60, nil, "Korfax, Champion of the Light", "" },
        { 9232, "The Only Song I Know...", 60, 60, nil, "Craftsman Wilhelm", "Glacial Leggings, Icebane Leggings, Icy Scale Leggings, Polar Leggings" },
    },
}

-- Řady questů Legend Azerothu (od prvního po poslední quest): [poslední] = { { id, název, kdo ho dává }, … }
WoWpoCesku_SealChains = {
    [3721] = { { 351, "Find OOX-17/TN!", "" }, { 648, "Rescue OOX-17/TN!", "Homing Robot OOX-17/TN" }, { 836, "Rescue OOX-09/HL!", "Homing Robot OOX-09/HL" }, { 2767, "Rescue OOX-22/FE!", "Homing Robot OOX-22/FE" }, { 3721, "An OOX of Your Own", "Oglethorpe Obnoticus" } },
    [338] = { { 583, "Welcome to the Jungle", "Barnil Stonepot" }, { 338, "The Green Hills of Stranglethorn", "Barnil Stonepot" } },
    [5944] = { { 5542, "Demon Dogs", "Tirion Fordring" }, { 5543, "Blood Tinged Skies", "Tirion Fordring" }, { 5544, "Carrion Grubbage", "Tirion Fordring" }, { 5742, "Redemption", "Tirion Fordring" }, { 5781, "Of Forgotten Memories", "Tirion Fordring" }, { 5845, "Of Lost Honor", "Tirion Fordring" }, { 5846, "Of Love and Family", "Tirion Fordring" }, { 5848, "Of Love and Family", "Artist Renfray" }, { 5861, "Find Myranda", "Tirion Fordring" }, { 5862, "Scarlet Subterfuge", "Myranda the Hag" }, { 5944, "In Dreams", "Highlord Taelan Fordring" } },
    [5721] = { { 5142, "Little Pamela", "Marlene Redpath" }, { 5149, "Pamela's Doll", "Pamela Redpath" }, { 5152, "Auntie Marlene", "Pamela Redpath" }, { 5153, "A Strange Historian", "Marlene Redpath" }, { 5154, "The Annals of Darrowshire", "Chromie" }, { 5210, "Brother Carlin", "Chromie" }, { 5168, "Heroes of Darrowshire", "Carlin Redpath" }, { 5181, "Villains of Darrowshire", "Carlin Redpath" }, { 5206, "Marauders of Darrowshire", "Carlin Redpath" }, { 5941, "Return to Chromie", "Carlin Redpath" }, { 5721, "The Battle of Darrowshire", "Chromie" } },
    [3962] = { { 3844, "It's a Secret to Everybody", "[A Wrecked Raft]" }, { 3845, "It's a Secret to Everybody", "[A Small Pack]" }, { 3908, "It's a Secret to Everybody", "Linken" }, { 3909, "The Videre Elixir", "Donova Snowden" }, { 3912, "Meet at the Grave", "Donova Snowden" }, { 3913, "A Grave Situation", "Gaeriyan" }, { 3914, "Linken's Sword", "[A Conspicuous Gravestone]" }, { 3941, "A Gnome's Assistance", "Linken" }, { 3942, "Linken's Memory", "J.D. Collie" }, { 4084, "Silver Heart", "Eridan Bluewind" }, { 4005, "Aquementas", "Eridan Bluewind" }, { 3961, "Linken's Adventure", "J.D. Collie" }, { 3962, "It's Dangerous to Go Alone", "Linken" } },
    [2770] = { { 2769, "The Brassbolts Brothers", "Klockmort Spannerspan" }, { 2770, "Gahz'rilla", "Wizzle Brassbolts" } },
    [3802] = { { 3801, "Dark Iron Legacy", "Franclorn Forgewright" }, { 3802, "Dark Iron Legacy", "Franclorn Forgewright" } },
    [6502] = { f = "A", { 4182, "Dragonkin Menace", "Helendis Riverhorn" }, { 4183, "The True Masters", "Helendis Riverhorn" }, { 4184, "The True Masters", "Magistrate Solomon" }, { 4185, "The True Masters", "Highlord Bolvar Fordragon" }, { 4186, "The True Masters", "Highlord Bolvar Fordragon" }, { 4223, "The True Masters", "Magistrate Solomon" }, { 4224, "The True Masters", "Marshal Maxwell" }, { 4241, "Marshal Windsor", "Marshal Maxwell" }, { 4242, "Abandoned Hope", "Marshal Windsor" }, { 4264, "A Crumpled Up Note", "" }, { 4282, "A Shred of Hope", "Marshal Windsor" }, { 4322, "Jail Break!", "Marshal Windsor" }, { 6402, "Stormwind Rendezvous", "Marshal Maxwell" }, { 6403, "The Great Masquerade", "Reginald Windsor" }, { 6501, "The Dragon's Eye", "Highlord Bolvar Fordragon" }, { 6502, "Drakefire Amulet", "Haleh" } },
    [6602] = { f = "H", { 4903, "Warlord's Command", "" }, { 4941, "Eitrigg's Wisdom", "Warlord Goretooth" }, { 4974, "For The Horde!", "Thrall" }, { 6566, "What the Wind Carries", "Thrall" }, { 6567, "The Champion of the Horde", "Thrall" }, { 6568, "The Testament of Rexxar", "Rexxar" }, { 6569, "Oculus Illusions", "Myranda the Hag" }, { 6570, "Emberstrife", "Myranda the Hag" }, { 6582, "The Test of Skulls, Scryer", "Emberstrife" }, { 6583, "The Test of Skulls, Somnus", "Emberstrife" }, { 6584, "The Test of Skulls, Chronalis", "Emberstrife" }, { 6585, "The Test of Skulls, Axtroz", "Emberstrife" }, { 6601, "Ascension...", "Emberstrife" }, { 6602, "Blood of the Black Dragon Champion", "Rexxar" } },
    [7782] = { f = "A", { 7781, "The Lord of Blackrock", "" }, { 7782, "The Lord of Blackrock", "Highlord Bolvar Fordragon" } },
    [7784] = { f = "H", { 7783, "The Lord of Blackrock", "" }, { 7784, "The Lord of Blackrock", "Thrall" } },
    [7787] = { { 7785, "Examine the Vessel", "" }, { 7786, "Thunderaan the Windseeker", "Highlord Demitrian" }, { 7787, "Rise, Thunderfury!", "" } },
    [9257] = { { 9250, "Frame of Atiesh", "" }, { 9251, "Atiesh, the Befouled Greatstaff", "Anachronos" }, { 9257, "Atiesh, Greatstaff of the Guardian", "Anachronos" } },
    [9269] = { { 9250, "Frame of Atiesh", "" }, { 9251, "Atiesh, the Befouled Greatstaff", "Anachronos" }, { 9269, "Atiesh, Greatstaff of the Guardian", "Anachronos" } },
    [9270] = { { 9250, "Frame of Atiesh", "" }, { 9251, "Atiesh, the Befouled Greatstaff", "Anachronos" }, { 9270, "Atiesh, Greatstaff of the Guardian", "Anachronos" } },
    [9271] = { { 9250, "Frame of Atiesh", "" }, { 9251, "Atiesh, the Befouled Greatstaff", "Anachronos" }, { 9271, "Atiesh, Greatstaff of the Guardian", "Anachronos" } },
    [8743] = { { 8575, "Azuregos's Magical Ledger", "" }, { 8576, "Translating the Ledger", "Narain Soothfancy" }, { 8597, "Draconic for Dummies", "Narain Soothfancy" }, { 8598, "rAnS0m", "[Freshly Dug Dirt]" }, { 8606, "Decoy!", "Narain Soothfancy" }, { 8620, "The Only Prescription", "Narain Soothfancy" }, { 8728, "The Good News and The Bad News", "Narain Soothfancy" }, { 8729, "The Wrath of Neptulon", "Narain Soothfancy" }, { 8730, "Nefarius's Corruption", "Vaelastrasz the Corrupt" }, { 8741, "The Champion Returns", "Keeper Remulos" }, { 8742, "The Might of Kalimdor", "Anachronos" }, { 8743, "Bang a Gong!", "[The Scarab Gong]" } },
    [166] = { f = "A", { 65, "The Defias Brotherhood", "Gryan Stoutmantle" }, { 132, "The Defias Brotherhood", "Wiley the Black" }, { 135, "The Defias Brotherhood", "Gryan Stoutmantle" }, { 141, "The Defias Brotherhood", "Master Mathias Shaw" }, { 142, "The Defias Brotherhood", "Gryan Stoutmantle" }, { 155, "The Defias Brotherhood", "The Defias Traitor" }, { 166, "The Defias Brotherhood", "Gryan Stoutmantle" } },
    [114] = { f = "A", { 106, "Young Lovers", "Maybell Maclure" }, { 111, "Speak with Gramma", "Tommy Joe Stonefield" }, { 107, "Note to William", "Gramma Stonefield" }, { 112, "Collecting Kelp", "William Pestle" }, { 114, "The Escape", "William Pestle" } },
    [1267] = { f = "A", { 1274, "The Missing Diplomat", "Thomas" }, { 1241, "The Missing Diplomat", "Bishop DeLavey" }, { 1242, "The Missing Diplomat", "Jorgen" }, { 1243, "The Missing Diplomat", "Elling Trias" }, { 1244, "The Missing Diplomat", "Watcher Backus" }, { 1245, "The Missing Diplomat", "Watcher Backus" }, { 1246, "The Missing Diplomat", "Elling Trias" }, { 1447, "The Missing Diplomat", "Dashel Stonefist" }, { 1247, "The Missing Diplomat", "Dashel Stonefist" }, { 1248, "The Missing Diplomat", "Elling Trias" }, { 1249, "The Missing Diplomat", "Mikhail" }, { 1250, "The Missing Diplomat", "Tapoke \"Slim\" Jahn" }, { 1264, "The Missing Diplomat", "Mikhail" }, { 1265, "The Missing Diplomat", "Commander Samaul" }, { 1266, "The Missing Diplomat", "Archmage Tervosh" }, { 1324, "The Missing Diplomat", "Private Hendel" }, { 1267, "The Missing Diplomat", "Archmage Tervosh" } },
    [55] = { f = "A", { 95, "Sven's Revenge", "Sven Yorgen" }, { 230, "Sven's Camp", "[Mound of loose dirt]" }, { 262, "The Shadowy Figure", "Sven Yorgen" }, { 265, "The Shadowy Search Continues", "Madame Eva" }, { 266, "Inquire at the Inn", "Clerk Daltry" }, { 453, "Finding the Shadowy Figure", "Tavernkeep Smitts" }, { 268, "Return to Sven", "Jitters" }, { 323, "Proving Your Worth", "Sven Yorgen" }, { 269, "Seeking Wisdom", "Sven Yorgen" }, { 270, "The Doomed Fleet", "Bishop Farthing" }, { 321, "Lightforge Iron", "Glorin Steelbrow" }, { 324, "The Lost Ingots", "[Waterlogged Chest]" }, { 526, "Lightforge Ingots", "Glorin Steelbrow" }, { 322, "Blessed Arm", "Glorin Steelbrow" }, { 325, "Armed and Ready", "Grimand Elmore" }, { 55, "Morbent Fel", "Sven Yorgen" } },
    [6403] = { f = "A", { 4182, "Dragonkin Menace", "Helendis Riverhorn" }, { 4183, "The True Masters", "Helendis Riverhorn" }, { 4184, "The True Masters", "Magistrate Solomon" }, { 4185, "The True Masters", "Highlord Bolvar Fordragon" }, { 4186, "The True Masters", "Highlord Bolvar Fordragon" }, { 4223, "The True Masters", "Magistrate Solomon" }, { 4224, "The True Masters", "Marshal Maxwell" }, { 4241, "Marshal Windsor", "Marshal Maxwell" }, { 4242, "Abandoned Hope", "Marshal Windsor" }, { 4264, "A Crumpled Up Note", "" }, { 4282, "A Shred of Hope", "Marshal Windsor" }, { 4322, "Jail Break!", "Marshal Windsor" }, { 6402, "Stormwind Rendezvous", "Marshal Maxwell" }, { 6403, "The Great Masquerade", "Reginald Windsor" } },
    [943] = { f = "A", { 730, "Trouble In Darkshore?", "Chief Archaeologist Greywhisker" }, { 729, "The Absent Minded Prospector", "Archaeologist Hollee" }, { 731, "The Absent Minded Prospector", "Prospector Remtravel" }, { 741, "The Absent Minded Prospector", "Archaeologist Hollee" }, { 942, "The Absent Minded Prospector", "Chief Archaeologist Greywhisker" }, { 943, "The Absent Minded Prospector", "Archaeologist Flagongut" } },
    [981] = { f = "A", { 965, "The Tower of Althalaxx", "Sentinel Elissa Starbreeze" }, { 966, "The Tower of Althalaxx", "Balthule Shadowstrike" }, { 967, "The Tower of Althalaxx", "Balthule Shadowstrike" }, { 970, "The Tower of Althalaxx", "Delgren the Purifier" }, { 973, "The Tower of Althalaxx", "Delgren the Purifier" }, { 1140, "The Tower of Althalaxx", "Delgren the Purifier" }, { 1167, "The Tower of Althalaxx", "Delgren the Purifier" }, { 1143, "The Tower of Althalaxx", "Balthule Shadowstrike" }, { 981, "The Tower of Althalaxx", "Balthule Shadowstrike" } },
    [5730] = { f = "H", { 5726, "Hidden Enemies", "Thrall" }, { 5727, "Hidden Enemies", "Thrall" }, { 5728, "Hidden Enemies", "Thrall" }, { 5729, "Hidden Enemies", "Thrall" }, { 5730, "Hidden Enemies", "Neeru Fireblade" } },
    [831] = { f = "H", { 830, "The Admiral's Orders", "" }, { 831, "The Admiral's Orders", "Gar'Thok" } },
    [550] = { f = "H", { 527, "Battle of Hillsbrad", "High Executor Darthalia" }, { 528, "Battle of Hillsbrad", "High Executor Darthalia" }, { 529, "Battle of Hillsbrad", "High Executor Darthalia" }, { 532, "Battle of Hillsbrad", "High Executor Darthalia" }, { 539, "Battle of Hillsbrad", "High Executor Darthalia" }, { 541, "Battle of Hillsbrad", "High Executor Darthalia" }, { 550, "Battle of Hillsbrad", "High Executor Darthalia" } },
    [521] = { f = "H", { 495, "The Crown of Will", "Sharlindra" }, { 518, "The Crown of Will", "Melisara" }, { 519, "The Crown of Will", "Melisara" }, { 520, "The Crown of Will", "Melisara" }, { 521, "The Crown of Will", "Melisara" } },
    [524] = { f = "H", { 509, "Elixir of Agony", "Apothecary Lydon" }, { 513, "Elixir of Agony", "Apothecary Lydon" }, { 515, "Elixir of Agony", "Master Apothecary Faranell" }, { 517, "Elixir of Agony", "Apothecary Lydon" }, { 524, "Elixir of Agony", "Apothecary Lydon" } },
}
