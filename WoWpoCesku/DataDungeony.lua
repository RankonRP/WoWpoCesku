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
• Z dungeonu padá Carrot on a Stick – trinket na rychlejší jízdu.]]

D["Maraudon"] = {
    title = "Maraudon", tag = "Jeskyně Theradras a Zaetara v Desolace (levely 46–55).",
    ch = {
        { "Jeskyně v Desolace", [[Maraudon leží v Valley of Spears v Desolace. Je rozdělený na tři části, do kterých vedou různé portály: Wicked Grotto (fialová část), Foulspore Cavern (oranžová část) a Earth Song Falls (vnitřní část).]] },
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
