-- WoWpoCesku: příběhy oblastí (lore) česky – psáno vlastními slovy, jména míst a postav anglicky
-- WoWpoCesku_Lore["Název oblasti v klientu"] = { title, tag (úvodní věta), ch = { { "Kapitola", [[text]] }, … } }
-- Klíč je anglický název zóny ze hry (C_Map). WoWpoCesku_LoreAlias = podoblasti a města -> oblast s příběhem.

WoWpoCesku_Lore = {

["Mulgore"] = {
    title = "Mulgore",
    tag = "Travnaté pláně, kde se taureni po staletích putování konečně usadili.",
    ch = {
        { "Domov taurenů", [[Mulgore je zvlněná zelená krajina obklopená horami na západním okraji Kalimdoru. Tráva tu sahá do pasu, vítr nese vůni deště a po pláních se prohánějí stáda kodo, plainstriderů a pumy. Pro taureny je to posvátná země – místo, kde podle nich Earth Mother vdechla světu život.

Ještě nedávno ale taureni žádný pevný domov neměl. Kmeny putovaly za stády napříč Kalimdorem a stále ustupovaly před kentaury, kteří jim brali pastviny i životy.]] },
        { "Cairne Bloodhoof a spojenectví s orky", [[Obrat přinesl až Cairne Bloodhoof, náčelník kmene Bloodhoof. Když na Kalimdor připluli orkové pod vedením Thralla, pomohli Cairnovým lidem ubránit se kentaurům a doprovodili je až sem, do Mulgore. Taureni ten dluh nikdy nezapomněli – od té doby stojí po boku Hordy.

Cairne pak sjednotil rozptýlené kmeny a dal jim to, co nikdy neměli: domov, který není třeba opouštět. Moudrý a klidný stařec je dnes nejváženějším hlasem svého lidu.]] },
        { "Thunder Bluff a vesnice", [[Nad pláněmi se zvedají strmé stolové hory, na jejichž vrcholcích taureni postavili Thunder Bluff. Město ze stanů, totemů a dřevěných mostů nad propastí je přístupné jen výtahy – ideální obrana proti kentaurům. Na jednotlivých plošinách sídlí šamani, druidové i obchodníci.

Dole v pláních leží Bloodhoof Village, srdce venkovského Mulgore, kde se taureni starají o stáda a pole. Mladí taureni začínají na Red Cloud Mesa v táboře Camp Narache, kde podstupují první zkoušky dospělosti – a jednou z nich je i Rite of Vision, rituál, při němž se mladý tauren pokouší zahlédnout svou cestu.]] },
        { "Hrozby", [[I na posvátné zemi je dost nepřátel. Goblini z Venture Company sem přišli kácet lesy a dolovat a o posvátnost země se nestarají. Gnollové z kmene Palemane přepadávají poutníky, harpyje z klanu Windfury hnízdí na skalách a ohrožují každého, kdo se přiblíží.

Studny, z nichž pije zvěř i lidé, občas otráví zlé síly – očišťování studny Winterhoof patří mezi první úkoly, které mladí taureni dostávají. A uvnitř samotného lidu doutná nesvár: klan Grimtotem pod vedením Magathy nesouhlasí s Cairnovým spojenectvím s Hordou a jeho hlas sílí.]] },
        { "Zajímavosti", [[Red Rocks na severovýchodě jsou posvátným pohřebištěm taurenů – kdo je znesvětí, nemá v Mulgore zastání. Taureni uctívají Earth Mother a jejíma očima jsou Slunce (An'she) a Měsíc (Mu'sha).

Až budeš stát na okraji Thunder Bluff a dívat se do plání, zkus si představit, že ještě před pár lety tu žádné město nestálo – jen vítr, tráva a lid, který neměl kam patřit.]] },
    },
},

["Durotar"] = {
    title = "Durotar",
    tag = "Rudá vyprahlá země, kterou si orkové po letech otroctví vybojovali jako svůj domov.",
    ch = {
        { "Země pojmenovaná po otci", [[Durotar je drsný kraj rudých skal, trnitých keřů a rozpálené prašné půdy na východním pobřeží Kalimdoru. Nese jméno Durotana, náčelníka klanu Frostwolf a otce Thralla, současného válečného náčelníka Hordy. Durotan zemřel ještě v době, kdy byl Thrall malé dítě, a jeho syn mu tímto jménem vzdal poctu.

Pro orky je to země nového začátku. Nehostinná, ale svobodná – a právě proto si jí váží.]] },
        { "Od internačních táborů ke Kalimdoru", [[Po prohraných válkách na Azerothu skončili orkové v lidských internačních táborech, zlomení a bez vůle. Thrall, vychovaný mezi lidmi jako gladiátor, utekl, našel svůj lid a probudil v něm dávného ducha šamanů. Osvobodil tábory a s nově sjednocenou Hordou se plavil přes moře na Kalimdor.

Tam bojoval po boku taurenů i trollů a nakonec se svým lidem usadil právě tady. Hlavním městem se stal Orgrimmar, postavený v kaňonu na severu a pojmenovaný po Orgrimu Doomhammerovi, Thrallově příteli a předchůdci.]] },
        { "Kdo tu žije", [[Kromě orků tu žijí trollové z kmene Darkspear pod vedením Vol'jina. Thrall jim kdysi pomohl uniknout ze zkázy a od té doby jsou věrnými spojenci Hordy. Jejich vesnice Sen'jin Village leží na jižním pobřeží; jejich původní domov, Echo Isles, ovládl šílený čaroděj Zalazane, který svými kouzly zotročil část jejich lidu.

Mladí orkové a trollové začínají ve Valley of Trials – údolí zkoušek, kde se ze slabých stávají bojovníci hodní Hordy. Kdo neobstojí, toho prý údolí semele.]] },
        { "Nepřátelé", [[Durotar není klidná země. Na jihu se usadili kultisté Burning Blade – orkové, kteří znovu propadli démonům, jimž kdysi Horda sloužila. Skrývají se v jeskyních a pro Thralla jsou připomínkou temné minulosti jeho lidu.

Na pobřeží stojí pevnost Tiragarde Keep, kde se drží vojáci z Kul Tiras – zbytek lidské flotily admirála Proudmoora, která na orky zaútočila po jejich příchodu. Po krajině se potulují kanci, štíři a quilboarové z kmene Razormane, kteří bojují o každý kousek půdy.]] },
        { "Zajímavosti", [[Razor Hill je vojenská osada mezi Valley of Trials a Orgrimmarem, kde se mladí bojovníci učí, že Horda je rodina. Na severu kraje, u vstupu do Orgrimmaru, se tyčí mohutné hradby z rudého kamene.

Orkové tu žijí podle šamanských tradic, uctívají živly a duchy předků. Durotar je pro ně důkazem, že i národ, který propadl temnotě, může znovu najít čest.]] },
    },
},

["Elwynn Forest"] = {
    title = "Elwynn Forest",
    tag = "Klidné lesy u bran Stormwindu – na první pohled idyla, ve skutečnosti kraj plný starostí.",
    ch = {
        { "Srdce království", [[Elwynn Forest je zelený, mírný kraj dubových lesů, polí a potoků, který obklopuje Stormwind, hlavní město lidského království. Je to nejbezpečnější kout Eastern Kingdoms – aspoň se to o něm říká. Sedláci tu pěstují obilí, dřevorubci kácejí stromy a v hostincích se zpívá.

Pod tou idylou se ale skrývá kraj, kterému chybějí vojáci. Velká část armády je daleko od domova a stráže v Elwynnu musí zvládat čím dál víc problémů jen s hrstkou mužů.]] },
        { "Válka, která všechno změnila", [[Za První války sem přišli orkové temným portálem a Stormwind vyplenili do základů. Lidé uprchli na sever a království se muselo celé postavit znovu. Obnovu města vedli kameníci, kterým za jejich práci nakonec šlechta odmítla zaplatit.

Z rozhořčení ukřivděných kameníků se zrodilo Bratrstvo Defias. Vedené tajemným mistrem kameníkem Edwinem VanCleefem se z cechu stala zločinecká síť, která dnes okrádá doly, přepadává sedláky a rozkládá kraj zevnitř. Když najdeš u zloděje prsten Cechu kameníků, víš, odkud vítr vane.]] },
        { "Místa", [[Northshire Abbey je klášter v údolí na severu, kde kněží Světla vychovávají nové bojovníky a kde začíná většina lidí. Goldshire je rušné městečko na křižovatce cest s hostincem Lion's Pride Inn – nejlepší místo, kde si odpočinout a vyslechnout drby.

Na východě leží Eastvale Logging Camp, tábor dřevorubců, a na jihovýchodě Tower of Azora, věž mága Theocrita. U Stone Cairn Lake si murlokové postavili vesnici, v dolech Fargodeep a Jasperlode řádí koboldi a na dýňovém poli Brackwell se ukrývají Defiasové.]] },
        { "Problémy kraje", [[Koboldi – drobní tvorové se svíčkou na hlavě – obsadili doly a vyhání z nich horníky. Murlokové od jezer napadají stráže; při jedné výpravě zmizeli vojáci Rolf a Malakai a jejich osud zůstal na těch, kdo se odvážili jít je hledat. Vlci a medvědi jsou čím dál troufalejší, jako by je z lesa něco vyhánělo.

Maršál Dughan v Goldshire dělá, co může, ale bez pomoci dobrodruhů by kraj nejspíš neudržel.]] },
        { "Zajímavosti", [[Elwynn je místo, kde lidé poznávají, že svět je větší a nebezpečnější, než se zdá z oken Stormwindu. Zprávy z kraje se často týkají věcí, o kterých šlechta ve městě nechce slyšet – a stopy Defiasů vedou až k těm, kdo by měli království chránit.]] },
    },
},

["Westfall"] = {
    title = "Westfall",
    tag = "Bývalá obilnice Stormwindu, dnes opuštěná pole, sláma ve větru a zločinci na každém kroku.",
    ch = {
        { "Obilnice, která zpustla", [[Westfall býval zlatou obilnicí lidského království. Nekonečná pole kukuřice a pšenice živila Stormwind a farmářské rodiny tu hospodařily po generace. Dnes je to kraj prázdných statků, rozpadlých plotů a polí, po nichž se potulují jen strašáci.

Když Stormwind po válce zapomněl na své venkovské poddané, Westfall zůstal bez ochrany. A tu mezeru vyplnil zločin.]] },
        { "Bratrstvo Defias", [[Do opuštěného kraje se nastěhovalo Bratrstvo Defias. Jeho členové vyhnali sedláky ze statků, kradou úrodu a nosí červené šátky, podle nichž je poznáš na první pohled. Spolupracují s gnolly z kmene Riverpaw a v ruinách města Moonbrook mají svou základnu.

Pod Moonbrookem se skrývají Deadmines – staré doly, kde si Edwin VanCleef staví obrovskou válečnou loď. Odtud chce Bratrstvo vést válku proti království, které ho kdysi okradlo.]] },
        { "Lidová domobrana", [[Proti Defiasům se postavili ti, kdo ve Westfallu zůstali. Gryan Stoutmantle, bývalý voják, založil na Sentinel Hill Lidovou domobranu – sbor sedláků a dobrodruhů, který se snaží kraji vrátit mír, když to nedělá Stormwind. Na věži Sentinel Hill visí odměny za hlavy zločinců a kapitán Danuvin posílá hlídky do plání.

Domobrana nemá peníze ani vojáky, ale má odhodlání. A každého, kdo je ochoten pomoct.]] },
        { "Lidé a jejich trápení", [[Rodina Furlbrowových přišla o statek a teď čeká u rozbitého vozu, až se bude moct odstěhovat do města. Saldeanovi na své farmě vzdorují – farmář Saldean bojuje s Harvest Watchers, strašidelnými mechanickými strašáky, kteří se zbláznili a útočí na každého, a Salma vaří slavný westfallský guláš pro každého, kdo pomůže.

Na pobřeží žijí murlokové a v kopcích supi a kanci goretusk. Ve Forever navíc do kraje přišla nová starost: půdu, studny a možná i moře otravuje cosi neznámého. Sedláci i vyslanci z Darnassu pátrají, odkud ta zkáza pochází.]] },
        { "Zajímavosti", [[Westfallský maják na jihu svítí nad pobřežím, kde dřív kotvily rybářské lodě. Cesta ze Stormwindu do Westfallu vede přes most nad řekou, za nímž začíná svět, na který šlechta zapomněla.

Westfall je příběh o tom, co se stane, když se vládci přestanou starat o své lidi – a o tom, že obyčejní lidé dokážou vzít osud do vlastních rukou.]] },
    },
},

["Dun Morogh"] = {
    title = "Dun Morogh",
    tag = "Zasněžené hory trpaslíků a gnómů, kde se v ohni kováren a pivovarů rodí odvaha.",
    ch = {
        { "Kraj sněhu a kamene", [[Dun Morogh je mrazivá horská krajina v jižní části Eastern Kingdoms, součást trpasličí říše Khaz Modan. Zasněžená údolí, zamrzlá jezera a jehličnaté lesy skrývají vchody do dolů a do nitra hor, kde trpaslíci po tisíciletí kutají rudu a drahokamy.

Je to drsný kraj, ale jeho obyvatelé jsou ještě drsnější. Trpaslíci milují kov, pivo, příběhy a dobrý boj – v tomhle pořadí, nebo v jakémkoli jiném.]] },
        { "Ironforge a Bronzebeardové", [[V srdci hory leží Ironforge, hlavní město trpaslíků, vytesané přímo do skály kolem obrovské kovárny Great Forge. Vládne mu král Magni Bronzebeard z klanu Bronzebeard. Kdysi trpaslíci tvořili jeden národ, ale ve Válce tří kladiv se rozdělili na tři klany: Bronzebeardy v Ironforge, Wildhammery v Grim Batol a Dark Irony, kteří zahořkli v hlubinách a dodnes trpaslíkům škodí.

Trpaslíci patří k pilířům Aliance a mezi lidmi mají věrné přátele.]] },
        { "Gnómové bez domova", [[V Dun Morogh žijí i gnómové – drobný, chytrý národ vynálezců. Jejich podzemní město Gnomeregan bylo technickým zázrakem, dokud ho nezaplavili troggové, kteří vylezli z hlubin. Ve snaze město zachránit vypustili gnómové jedovaté záření, které zabilo i velkou část jich samých – a navíc je zradil jeden z jejich vlastních, Sicco Thermaplugg.

Přeživší gnómové pod vedením High Tinker Mekkatorquea našli útočiště v Ironforge a sní o dni, kdy svůj domov získají zpět.]] },
        { "Hrozby", [[Troggové se nevynořili jen v Gnomereganu – objevují se po celém Khaz Modanu. V Coldridge Valley, kde začínají mladí trpaslíci a gnómové, napadli tábor a obsadili kopce kolem zamrzlého jezera. V horách žijí trollové z kmene Frostmane, kteří trpaslíkům odjakživa nepřejí, a po lesích se toulají vlci a medvědi.

Hlídky z Anvilmaru, trpasličí pevnosti v údolí, se snaží troggy zahnat zpátky do děr, odkud přišli.]] },
        { "Zajímavosti", [[Kharanos je útulná vesnice s hostincem Thunderbrew Distillery, kde se vaří pivo, o kterém se zpívá po celém Azerothu. Lovci z Dun Morogh mají hluboký vztah k divočině – učí se stopovat medvěda horami a vážit si zvířat, která s nimi bojují bok po boku.

V Dun Morogh poznáš, že trpasličí srdce je stejně pevné jako kámen, ze kterého je postavené jejich město.]] },
    },
},

["Teldrassil"] = {
    title = "Teldrassil",
    tag = "Obrovský strom uprostřed moře – nový domov nočních elfů, v jehož stínu klíčí zkáza.",
    ch = {
        { "Strom, který se dotýká nebe", [[Teldrassil je obrovský Světový strom, který vyrůstá z moře u severozápadního pobřeží Kalimdoru. Jeho kořeny sahají do vody a v koruně, vysoko nad oblaky, leží celý kraj lesů, jezer a mýtin – i město Darnassus, nový domov nočních elfů.

Les tu má stříbřitý nádech, noc je dlouhá a světlo měsíce prostupuje vším. Pro noční elfy, kteří uctívají Elune, bohyni Měsíce, je to místo klidu a rozjímání.]] },
        { "Proč vznikl", [[Za Třetí války noční elfové obětovali svůj původní Světový strom, Nordrassil, aby porazili démona Archimonda. Spolu s ním ztratili i nesmrtelnost, kterou jim strom dával. Arcidruid Fandral Staghelm pak zasadil nový strom, Teldrassil, v naději, že jim nesmrtelnost vrátí.

Udělal to ale bez požehnání draků, kteří kdysi požehnali Nordrassilu. Strom vyrostl, ale něco v něm není v pořádku – a příroda kolem to cítí jako první.]] },
        { "Místa", [[Mladí noční elfové začínají v Shadowglen, posvátném údolí u stromu Aldrassil, kde se o rovnováhu přírody stará ochránce Ilthalaine. Dolanaar je klidná vesnice na cestě do Darnassu a samotné město je plné chrámů, zahrad a měsíčních studní.

Nad městem bdí Tyrande Whisperwind, velekněžka Elune, a její Sentinely – válečnice, které chrání noční elfy. Druidové se mezitím učí cestě drápu, tesáku a peří.]] },
        { "Zkáza v lese", [[Furbolgové z kmene Gnarlpine bývali mírumilovnými spojenci nočních elfů. Teď opustili svá obydlí a obrátili se proti nim. Za proměnou stojí Fel Moss – zkažený mech, který otravuje zvířata i bytosti, a grellové s grellkiny, kteří zamořili les. Dryáda Tarindrella, tajemná ochránkyně lesa, se kvůli tomu po letech vrátila do Shadowglenu.

V Ban'ethil Barrow Den a dalších místech se skrývají ti, kdo zkázu šíří. Zdá se, že s Teldrassilem je něco hluboce v nepořádku.]] },
        { "Zajímavosti", [[Jediná cesta ven z Teldrassilu vede lodí z přístavu Rut'theran Village u kořenů stromu – nebo hipogryfem. Noční elfové jsou národ s nejdelší pamětí v Azerothu a mnozí z nich pamatují věci, o kterých ostatní národy čtou jen v legendách.

Teldrassil je krásný, ale je to krása s otazníkem: strom, zasazený bez požehnání, nese v sobě stín.]] },
    },
},

["Stormwind City"] = {
    title = "Stormwind",
    tag = "Bílé hradby a modré střechy – hlavní město lidí, postavené z popela První války.",
    ch = {
        { "Město, které povstalo z trosek", [[Stormwind je největší lidské město Eastern Kingdoms a sídlo krále. Za První války ho orkové srovnali se zemí, ale lidé se vrátili a postavili ho znovu – vyšší, bělejší a pevnější než dřív. Obnovu vedli kameníci; když jim šlechta odmítla zaplatit, zrodilo se z jejich hořkosti Bratrstvo Defias.

Do města se vstupuje přes Valley of Heroes, most lemovaný sochami hrdinů. U vstupu stojí památník těm, kdo padli při obraně Stormwindu.]] },
        { "Kdo vládne", [[Král Varian Wrynn zmizel na diplomatické cestě a na trůn usedl jeho malý syn Anduin. Za něj vládne regent, lord Bolvar Fordragon, statečný paladin, který nese tíhu království na svých bedrech. U dvora má velký vliv tajemná lady Katrana Prestor – a ne všichni věří, že má s královstvím dobré úmysly.

Lidé ve městě se ptají, proč se vojáci nevracejí a proč kraje mimo hradby trpí bez pomoci.]] },
        { "Čtvrti", [[Stormwind se dělí na čtvrti. V Trade District bije srdce obchodu, v Mage Quarter se učí mágové, v Dwarven District mají dílny trpaslíci a v Old Town sídlí tajná služba SI:7 a vojáci. Cathedral of Light je chrám Svatého světla a domov kněží a paladinů.

Městem protékají kanály, na kterých najdeš obchody jako krejčovství u kanálu, a ve vězení Stockade drží zločince – kteří se tam ovšem nedávno vzbouřili.]] },
        { "Pod povrchem", [[Pod lesklou fasádou se skrývají problémy. Šlechta se stará víc o své zisky než o venkov, Defiasové mají ve městě své lidi a v kanálech a sklepeních se šíří kulty. Obchodníci si všímají, že lidé skupují zbroj a teplé oblečení, jako by čekali zlé časy.

Kdo chce Stormwindu pomoct, musí se dívat i tam, kam se šlechta dívat nechce.]] },
        { "Zajímavosti", [[Z přístavu Stormwind Harbor vyplouvají lodě k ostatním břehům a z věže u Trade District létají gryfové do celého království. V Cathedral Square se scházejí lidé, aby uctili Světlo, a na hradbách stojí stráže v modrých tabardech se lvem.

Stormwind je symbolem lidské odvahy – národa, který se nikdy nevzdal, i když přišel o všechno.]] },
    },
},

["Zephras Isle"] = {
    title = "Ostrov Zephras",
    tag = "Létající ostrov ve Skywallu, poslední útočiště shen'dorei – a jeho magie pomalu vyhasíná.",
    ch = {
        { "Lid, který utekl do nebe", [[Shen'dorei jsou potomci vznešených elfů Highborne, kteří kdysi žili na Kalimdoru. Podle toho, co si vyprávějí místní, jejich předkové v dávných časech uprchli – nebo museli uprchnout – a živelní duchové větru je odnesli do Skywallu, nebeské říše vzduchu, kde žijí na létajících ostrovech už mnoho tisíc let.

Jejich historie je složitá a plná pronásledování. Proto si tak váží tradic, které je drží pohromadě – třeba relikvie dospělosti, kterou každý mladý shen'dorei dostane, jakmile ho jeho lid uzná za dospělého.]] },
        { "Ostrov bez duchů", [[Duchové větru, kteří kdysi na Zephrasu žili se shen'dorei, před několika staletími zmizeli. Od té doby magie, která ostrov drží ve vzduchu, pomalu slábne. Ostrov poutají a živí kotevní pylony – dary duchů – ale jejich magie je teď nestálá.

Shen'dorei přišli o spojení s ostatními ostrovními provinciemi. Těch pár Windshaperů, kteří mají dar nebeského zraku (skysight), se marně snaží dovolat bratrů na jiných ostrovech. Mnozí se bojí, že Zephras je to poslední, co z jejich lidu zbylo.]] },
        { "Windshapeři a High Order", [[Lid se rozdělil na dva tábory. Windshapeři věří, že shen'dorei dluží duchům za jejich pomoc a musí ten dluh splatit a vrátit svět do starých kolejí. Naslouchají živlům a užívají darů, které jim duchové dali.

High Order naopak chce získat zpět dědictví Highborne, ovládnout magii ostrova a stát se pánem vlastního osudu. Windshapeři je mají za arogantní, oni Windshapery za pokrytce. Mimo klidný Thendal Grove ten spor někdy přeroste v násilí.]] },
        { "Thendal Grove", [[Thendal Grove je vesnice v háji kolem obrovského stromu praotce, kde mladí shen'dorei dospívají. Vede ji Rorian the Dayseeker a nad mladými bdí Aetheen of the Gales z Rady starších, která přišla číst proudění větrů a posoudit, kdo je připraven sloužit ostrovu.

V háji se těží větrné kameny – surová energie větru, stále vzácnější. U stojících kamenů na severovýchodě je živelní soutok, kde je nebeský zrak nejsilnější. A shen'dorei umí chodit po vzduchu – vrozený dar, se kterým by se ale nemělo plýtvat.]] },
        { "Hrozby", [[Kult Al'Aketh dráždí prosté větrné skřítky a obrací je proti obyvatelům – a v háji se kvůli němu poprvé prolévá krev shen'dorei. Zvířata vycítí, že magie ve větrech je mimo rovnováhu: vuldreni, kteří bývají krotcí, se přemnožili, v lese se rozrostl roj cirrusfly s královnou a v jeskyních na jihu útočí ursery, hladové a zoufalé.

Ostrov se zdá klidný, ale všechno ukazuje na to, že se blíží něco velkého. A shen'dorei potřebují každého mladého dobrodruha, který je ochoten pomoct.]] },
    },
},

}

-- Podoblasti, města a starší názvy -> oblast s příběhem
WoWpoCesku_LoreAlias = {
    ["Thunder Bluff"] = "Mulgore", ["Red Cloud Mesa"] = "Mulgore", ["Camp Narache"] = "Mulgore", ["Bloodhoof Village"] = "Mulgore",
    ["Orgrimmar"] = "Durotar", ["Valley of Trials"] = "Durotar", ["Razor Hill"] = "Durotar", ["Sen'jin Village"] = "Durotar",
    ["Northshire Valley"] = "Elwynn Forest", ["Northshire"] = "Elwynn Forest", ["Goldshire"] = "Elwynn Forest",
    ["Sentinel Hill"] = "Westfall", ["Moonbrook"] = "Westfall",
    ["Ironforge"] = "Dun Morogh", ["Coldridge Valley"] = "Dun Morogh", ["Kharanos"] = "Dun Morogh",
    ["Darnassus"] = "Teldrassil", ["Shadowglen"] = "Teldrassil", ["Dolanaar"] = "Teldrassil",
    ["Stormwind"] = "Stormwind City",
    ["Zephras"] = "Zephras Isle", ["Thendal Grove"] = "Zephras Isle", ["Skywall"] = "Zephras Isle", ["Thendal Village"] = "Zephras Isle",
}
