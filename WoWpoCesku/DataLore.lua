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
    tag = "Bývalá obilnice Stormwindu, dnes opuštěná pole, sláma ve větru a strach z červených šátků.",
    ch = {
        { "Obilnice království", [[Westfall je široká, mírně zvlněná krajina polí, luk a nízkých kopců na západ od Elwynn Forest. Na západě ji uzavírá pobřeží Longshore s útesy a starým majákem, na jihu se zvedají Dagger Hills a na severu skály, ve kterých se kdysi dolovalo. Půda je tu úrodná a slunce štědré – proto se Westfallu po generace říkalo obilnice Stormwindu.

Když se řeklo „chléb na stole královského města“, myslelo se tím westfallské obilí. Kukuřice, pšenice a dýně odtud putovaly vozy po silnici přes most do Elwynnu a dál do Stormwindu. Statky jako Saldean's Farm, Furlbrow's Pumpkin Patch nebo Jansen Stead patřily rodinám, které tu hospodařily od dob dědů. Uprostřed kraje leželo hornické městečko Moonbrook, kde se v okolních dolech kopalo železo a zlato.

Dnes po tom zbyly prázdné stodoly, ploty spadlé do trávy a pole, na kterých místo obilí roste plevel. Po cestách se točí prachové víry a mezi strašáky se pohybuje něco, co strašák není.]] },

        { "Staré války", [[Westfall poznal válku dávno předtím, než se objevili orkové. Za vlády krále Barathena Wrynna podnikali gnollové tak vytrvalé nájezdy, že Stormwind musel vést celou Válku s gnolly – a zatímco vojsko bojovalo jinde, westfallské statky hořely. O mnoho let později přepadla kraj loupeživá výprava trollů Gurubashi a vypálila tři městečka, což rozpoutalo válku s trolly z jihu.

Nejhorší ale přišlo s Temným portálem. V První válce táhla Horda pod velením Blackhanda přes celé lidské království a celé westfallské vesnice padly. Lidé byli pobiti nebo vyhnáni, pole spálena a stáda odehnána. Stormwind sám byl srovnán se zemí a přeživší uprchli lodí na sever do Lordaeronu.

Po Druhé válce se vrátili. Velitel Aliance Turalyon dohlížel na to, aby se uprchlíci mohli usadit zpátky na svých statcích, a mladý Varian Wrynn usedl na trůn obnoveného království. Westfall se začal pomalu vzpamatovávat – sedláci znovu orali a v Moonbrooku se znovu kopalo. Na chvíli to vypadalo, že nejhorší je za nimi.]] },

        { "Kameníci a zrada", [[Stormwind se musel postavit znovu od základů. Tu obrovskou práci odvedl cech kameníků (Stonemasons' Guild) pod vedením mistra Edwina VanCleefa. Postavili hradby, katedrálu, ulice i královský palác – bílé město, jaké dnes znáš.

Když ale přišli pro zaplacení, šlechta odmítla. Královská pokladna byla prázdná po válce a dluzích Aliance, a urození páni ze Sněmovny šlechticů (House of Nobles) měli jiné starosti než výplatu dělníků. Za vším navíc tahala za nitky lady Katrana Prestor – ve skutečnosti černá dračice Onyxia, která pomocí kouzelného amuletu ovlivňovala myšlenky šlechty a zasévala spory na obou stranách.

Když VanCleef trval na tom, co jeho lidem náleží, Sněmovna cech rozpustila. Kameníci vyšli do ulic a vypukla vzpoura. Královna Tiffin Wrynn se je pokusila uklidnit – a hozený kámen ji zasáhl do hlavy. Zemřela. Zdrcený král Varian dal kameníky pronásledovat a ti, kdo nechtěli skončit v žaláři, uprchli z města na venkov. Mnozí z nich skončili právě ve Westfallu.]] },

        { "Zrod Bratrstva Defias", [[Ve westfallských kopcích a opuštěných dolech se VanCleef postavil do čela rozhořčených vyhnanců. Byl to nejen stavitel, ale i muž zkušený v tichém pohybu a lsti – a ty dovednosti teď naučil i ostatní. Tak vzniklo Bratrstvo Defias, poznávací znamení: červený šátek přes tvář.

Zpočátku chtěli jen vymoci zlato, které jim král dlužil. Onyxia ale dál přiživovala jejich nenávist – postarala se, aby kraj nedostával zásoby, a tak se z výběrčích stali lupiči a vrazi. Úroda selhávala, doly se zavíraly a stormwindská stráž se z Westfallu stáhla. Kdo mohl, odešel do města. Kdo zůstal, žil ve strachu.

Pod Moonbrookem, ve starých dolech zvaných Deadmines, si Bratrstvo vybudovalo skrýš. V obrovské podzemní jeskyni u moře tam staví válečnou loď Juggernaut, se kterou chce jednoho dne připlout ke Stormwindu a vzít si, co mu patří. VanCleefovi slouží goblinský dřevař Sneed, tavič Gilnid, kapitán Greenskin, ogr Rhahk'Zor a tauren Mr. Smite. Ve stormwindském vězení pak velí jeho poručík Bazil Thredd.]] },

        { "Westfall v rukou Defias", [[Dnes Bratrstvo Defias ovládá skoro celý Westfall. Najalo si gnolly z kmene Riverpaw, aby přepadávali statky, pálí sedlákům pole a solí půdu, aby na ní už nic nevyrostlo. Moonbrook je jejich městem – v rozpadlých domech hlídkují Defias Pillagers a Defias Highwaymen a po silnicích běhají jejich poslové.

Nejstrašidelnějším nástrojem Bratrstva jsou žňoví strašáci – Harvest Watchers a Harvest Golems. Kdysi to byly užitečné stroje, které pomáhaly se sklizní. Goblini je ale přeprogramovali a teď se potulují po polích a útočí na každého, kdo se přiblíží.

Uprostřed toho všeho se drží ti nejodolnější. Saldeanovi na své farmě vzdorují – farmář Saldean bojuje se strašáky a jeho žena Salma vaří westfallský guláš pro každého, kdo pomůže. Furlbrowovi už o statek přišli a čekají u rozbitého vozu, až se budou moct odstěhovat. A trpasličí badatel Brann Bronzebeard, který tudy kdysi prošel, napsal, že viděl jen opuštěné farmy, nekonečná prázdná pole a v Moonbrooku agenty Defias a žňové golemy.]] },

        { "Lidová domobrana", [[Gryan Stoutmantle se narodil ve Westfallu, ale většinu života strávil daleko na severu. Stal se paladinem, rytířem Stříbrné ruky (Knights of the Silver Hand), a bojoval v Lordaeronu proti Pohromě. Byl svědkem toho, jak princ Arthas nechal vyvraždit Stratholme.

Když se doslechl, co se děje v jeho rodném kraji, opustil frontu a vrátil se domů. Zjistil, že Stormwind Westfallu nepošle ani vojáky, ani pomoc – šlechta, zmanipulovaná lady Prestor, se o venkov nestará. A tak založil Lidovou domobranu (People's Militia): sbor sedláků, zbylých obyvatel a dobrodruhů, kteří berou obranu kraje do vlastních rukou.

Domobrana sídlí na Sentinel Hill, opevněném kopci s věží uprostřed kraje. Kapitán Danuvin posílá hlídky proti gnollům, zvědka Galiaan sleduje Defiasy a na věži visí odměny za hlavy zločinců. Gryan nezůstal sám: spojil se se šéfem tajné služby SI:7 Mathiasem Shawem, jehož agent Kearnen hlídá kraj z Klaven's Tower, a s informátorem Wileym v Lakeshire. Kousek po kousku skládá důkazy, které vedou až do Deadmines – a možná ještě dál, ke královskému dvoru.]] },

        { "Maják a pobřeží", [[Na západním pobřeží Longshore stojí Westfallský maják (Westfall Lighthouse). Kdysi chránil lodě před útesy – dokud jedné bezměsíčné noci nezhasl. Loď kapitána Graysona narazila na skály a kapitán zahynul. Od té doby jeho duch zůstává u majáku a dívá se, jak na pobřeží útočí murlokové vedení starým Old Murk-Eyem. Zabili i rodinu strážce majáku. Grayson teď hlídá plamen, aby nikdo další nedopadl jako on.

Pobřeží láká i piráty. Podle jednoho příběhu odvlekli piráti z Bloodsail Buccaneers od majáku tři mladíky – Jamese Blackridge, Liama a Brama Woodringa. Měsíce je cvičili jako piráty, ale chlapci nezapomněli, odkud jsou: nakonec vtrhli do Deadmines, osvobodili vězně a dovedli je na Sentinel Hill.

Westfall je příběh o tom, co se stane, když se vládci přestanou starat o své lidi. Ale také o tom, že obyčejní lidé – sedláci, vdovy, duchové i dobrodruzi – dokážou kraj bránit, i když na ně všichni ostatní zapomněli.]] },
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
        { "Zajímavosti", [[Z věže u Trade District létají gryfové do celého království. V Cathedral Square se scházejí lidé, aby uctili Světlo, a na hradbách stojí stráže v modrých tabardech se lvem.

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

-- Z knih a legend – příběhy z románů a starších her (se spoilery), kniha je přidá před Tajemství
WoWpoCesku_LoreKnihy = {

["Mulgore"] = [[• Jak se potkali Cairne a Thrall (Warcraft III) – když orkové dorazili na Kalimdor, narazil Thrall na taureny, které štvali kentauři. Pomohl jim v boji a Cairne mu na oplátku poradil, kde hledat Orákulum. Tauren pak Thralla poslali dál a Cairne se svým lidem odešel do Mulgore. Od té chvíle platí, že kdo pomohl taurenům, má v nich přátele navždy.

• Hamuul Runetotem – první tauren, který se stal druidem. Učil se přímo u Malfuriona Stormrage, nočního elfa, a jeho přátelství s druidy Kalimdoru je jedním z mostů mezi Hordou a nočními elfy.

• Magatha Grimtotem – stará šamanka kmene Grimtotem v Thunder Bluff. Cairne ji toleruje, ale ona touží po moci. SPOILER: v budoucnu (Cataclysm) otráví zbraň, kterou ork Garrosh Hellscream zabije Cairna v souboji. Synovi Bainovi pak zůstane těžký úkol sjednotit taureny.

• Legenda o Matce Zemi – taureni vyprávějí, že Earth Mother stvořila svět a její oči, An'she (Slunce) a Mu'sha (Měsíc), se na něj dívají ve dne i v noci. Kdo bloudí, má se podívat na oblohu – Matka Země ho vidí.]],

["Durotar"] = [[• Rise of the Horde – na rodném Draenoru byl Durotan náčelníkem klanu Frostwolf. Čaroděj Gul'dan prodal orky démonům: náčelníci vypili krev démona Mannorotha a Horda propadla krvežíznivosti. Durotan krev odmítl. Když chtěl varovat ostatní, poslal na něj Gul'dan vrahy – Durotan i jeho žena Draka zemřeli a jejich malý syn zůstal v lese u těl rodičů.

• Lord of the Clans – dítě našel lidský šlechtic Aedelas Blackmoore, pojmenoval ho Thrall („otrok“) a vychoval v pevnosti Durnholde jako gladiátora. Jediný laskavý člověk v jeho životě byla dívka Taretha Foxton. Thrall utekl, našel Groma Hellscreama, klan Frostwolf a starého náčelníka Orgrima Doomhammera, který mu předal svou černou zbroj a kladivo. Osvobodil tábory, ale Blackmoore Tarethu zabil – a Thrall ho při dobytí Durnholde porazil.

• Orgrimmar – město nese jméno Orgrima Doomhammera, který padl v boji za osvobození orků. Thrall nosí jeho zbroj dodnes.

• Smrt Groma Hellscreama (Warcraft III) – na Kalimdoru Grom znovu vypil Mannorothovu krev a zabil poloboha Cenaria. Thrall s pomocí Jainy Proudmoore jeho ducha osvobodil a Grom pak Mannorotha zabil sekerou Gorehowl – a sám při tom zemřel. Horda tím byla konečně volná.

• Tiragarde Keep – pevnost na pobřeží je pozůstatek flotily admirála Daelina Proudmoora z Kul Tiras, otce Jainy. Admirál napadl Durotar, aby orky vyhladil. Jaina se postavila na stranu míru a admirál padl – Kul Tiras to Hordě nikdy neodpustil.]],

["Elwynn Forest"] = [[• The Last Guardian – Medivh, Strážce Tirisfalu a přítel krále Llana, byl od narození posedlý démonem Sargerasem, kterého kdysi porazila jeho matka Aegwynn. Z věže Karazhan (nedaleko, v Deadwind Pass) pomohl orkům otevřít Temný portál. Jeho učeň Khadgar a velitel Anduin Lothar ho nakonec ve věži zabili.

• Pád Stormwindu – král Llane zemřel rukou Garony, napůl orky a napůl draenei, která byla vyslankyní mezi lidmi a orky a jednala pod cizí magickou vládou. Orkové pak Stormwind vypálili. Lothar vyvedl uprchlíky lodí na sever do Lordaeronu, kde vznikla Aliance. Malý princ Varian přežil.

• Anduin Lothar – Lev z Azerothu, poslední potomek starých arathorských králů. Padl později v bitvě pod Blackrock Spire rukou Orgrima Doomhammera. Varian po něm pojmenoval svého syna Anduina.

• Tower of Azora – mág Theocritus ve věži slouží Stormwindu, ale v příbězích klasického WoW se říká, že má s lidmi i jiné plány. Kdo projde questy v okolí, sám posoudí.]],

["Westfall"] = [[• Edwin VanCleef – mistr cechu kameníků, který vedl obnovu Stormwindu po První válce. Když šlechta – na radu lady Prestor – odmítla dělníkům zaplatit, vypukla vzpoura. Při nepokojích zemřela královna Tiffin, Varianova žena. Kameníci byli vyhnáni z města a VanCleef z nich udělal Bratrstvo Defias.

• Deadmines – Defiasové v dolech pod Moonbrookem postavili válečnou loď, se kterou chtěli na Stormwind zaútočit. VanCleef na ní čeká na konci dungeonu – a u sebe má dopis, který prozradí, kdo za vším stojí.

• SPOILER do budoucna (Cataclysm) – VanCleefova dcera Vanessa, která byla svědkem otcovy smrti, se po letech vrátí do Westfallu a Bratrstvo obnoví. Westfall je tak po celou historii WoW krajem, kde se pomsta dědí z otce na dceru.

• Gryan Stoutmantle – westfallský rodák a paladin Stříbrné ruky, který viděl vyvraždění Stratholme. SPOILER: jeho Lidová domobrana se později stane oficiální Westfall Brigade, Gryan bude povýšen na maršála a za invaze Legie se vrátí k Rytířům Stříbrné ruky.]],

["Dun Morogh"] = [[• Válka tří kladiv – po smrti velekrále Modima Anvilmara se trpaslíci rozdělili na tři klany. Bronzebeardové ovládli Ironforge, Wildhammeři Grim Batol a Dark Ironové pod čarodějem Thaurissanem zaútočili na oba. Při bitvě Thaurissan vyvolal Ragnarose, pána ohně – výbuch zničil kraj a z něj vznikly Searing Gorge, Burning Steppes a hora Blackrock.

• Tři bratři – král Magni Bronzebeard vládne Ironforge. Brann Bronzebeard je slavný badatel a zakladatel Explorers' League. Muradin Bronzebeard odešel s princem Arthasem do Northrendu a zmizel ve chvíli, kdy Arthas vzal do ruky prokletý meč Frostmourne – všichni ho mají za mrtvého. SPOILER: Muradin přežil, jen ztratil paměť.

• Původ trpaslíků – v Uldamanu jsou ukryty disky titánů, které prozrazují, že trpaslíci pocházejí z earthen, kamenných služebníků titánů, kteří postupně „zkameněli v maso“. Proto mají trpaslíci kámen tak rádi.

• Princezna Moira – Magniho dcera zmizela. SPOILER: unesl ji Dagran Thaurissan, císař Dark Ironů, a vzal si ji za ženu. Magni posílá hrdiny do Blackrock Depths, aby ji „zachránili“ – jenže Moira nosí Dagranovo dítě a vůbec nechce být zachráněna.

• Gnomeregan – zrádce Sicco Thermaplugg byl poradcem krále gnómů Gelbina Mekkatorqua. Radil vypustit do města jedovaté záření a pak se prohlásil králem toho, co zbylo.

• SPOILER do budoucna (Cataclysm) – Magni při rituálu v Ironforge promění sám sebe v diamant a splyne s horou. Vládu převezme Rada tří kladiv.]],

["Teldrassil"] = [[• War of the Ancients – před deseti tisíci lety vládla nočním elfům královna Azshara. Se svými Highborne čerpala moc ze Studny věčnosti tak bezohledně, že tím přilákala Plamennou legii démona Sargerase. Proti ní stál Malfurion Stormrage, žák poloboha Cenaria, jeho bratr Illidan a kněžka Tyrande Whisperwind.

• Velké rozpoltění – Studna věčnosti explodovala a roztrhla jediný pravěký kontinent na části. Azshara se svými věrnými zmizela v moři a stali se z nich nagové. Illidan potají zachránil lahvičky vody ze Studny a založil na hoře Hyjal Studnu novou – za to byl na deset tisíc let uvězněn.

• Odchod Highborne – přeživší Highborne, kteří nedokázali žít bez magie, byli z Kalimdoru vyhnáni. Odpluli na východ a založili Quel'Thalas – stali se z nich vznešení elfové. (Shen'dorei z Forever tvrdí, že část Highborne odnesli duchové větru do nebe.)

• Nordrassil a ztráta nesmrtelnosti – draci požehnali stromu Nordrassil na Hyjalu a ten dal nočním elfům nesmrtelnost. Ve Třetí válce strom obětovali, aby zničili Archimonda.

• Teldrassil bez požehnání – Fandral Staghelm zasadil nový strom bez souhlasu draků, a proto je strom nemocný – odtud zkáza v lese. SPOILER (román Stormrage): Fandral je ve spojení s Emerald Nightmare, zlou silou ve Smaragdovém snu, a strom tím tráví úmyslně.

• SPOILER do daleké budoucnosti (Battle for Azeroth) – Teldrassil jednoho dne vypálí královna nemrtvých Sylvanas Windrunner. Tisíce elfů v něm zahynou.]],

["Stormwind City"] = [[• Lady Katrana Prestor – SPOILER: je to černá dračice Onyxia, dcera Deathwinga, v lidské podobě. Ovládla dvůr kouzly, zařídila, aby kameníci nedostali zaplaceno, a zinscenovala únos krále Variana. Její bratr Nefarian sídlí v Blackrock Spire jako „lord Victor Nefarius“.

• Day of the Dragon – Onyxia jen opakuje otcův trik. Deathwing kdysi žil na dvoře Lordaeronu jako lord Daval Prestor a málem se stal králem Alteraku. Prestorové jsou rodina, která existuje jen na papíře.

• Odhalení – v klasickém WoW vede quest od marshala Windsora (Burning Steppes, Blackrock Depths) až k „Velké maškarádě“ ve Stormwindu, kde se Prestor před Bolvarem promění v draka. Pak čeká Onyxia's Lair v Dustwallow Marsh.

• Kde je král Varian – SPOILER: Variana unesli Defiasové na objednávku Onyxie cestou do Theramore. Přežil, ztratil paměť a bojoval jako gladiátor Lo'Gosh. Vrátí se do Stormwindu až později.

• Bolvar Fordragon – SPOILER do budoucna (Wrath of the Lich King): Bolvar „zemře“ u Wrathgate v ohni červených draků a nakonec usedne na Frozen Throne jako nový Lich King, aby nemrtví nezůstali bez pána.]],

["Zephras Isle"] = [[• Skywall – nebeská říše živlů vzduchu, kde vládne Al'Akir Windlord, pán větrů. Je jedním ze čtyř živelních pánů (s Ragnarosem, Neptulonem a Therazane), které kdysi titáni uvěznili v Elementální rovině, protože sloužili Starým bohům.

• SPOILER do budoucna (Cataclysm) – Al'Akir se spojí s Deathwingem a hrdinové s ním budou bojovat v Throne of the Four Winds. Pokud shen'dorei žijí pod ochranou Skywallu, jejich příběh se s tímhle může jednou protnout.

• Highborne – shen'dorei se odvolávají na Highborne, elfy královny Azshary. Kanonicky skončila Azshara v moři jako vládkyně nagů a vyhnaní Highborne založili Quel'Thalas. Shen'dorei jsou třetí cesta, kterou přidal až WoW Forever.

• Al'Aketh – jméno kultu, který na Zephrasu dráždí větrné duchy, nápadně připomíná Al'Akira. Je to náhoda, nebo uctívají přímo Windlorda? To se zatím neví.]],

}

-- Tajemství, easter eggy a kam se podívat – kniha je přidá jako poslední kapitolu
-- (podle klasického WoW; ve Forever může být něco jinak)
WoWpoCesku_LoreTajemstvi = {

["Mulgore"] = [[• Bael'dun Digsite – na severozápadě kopou trpaslíci z Bael'dunu. Co tak hluboko v zemi taurenů hledají?

• Venture Co. Mine – goblinský důl, kde je vidět, jak bezohledně drancují posvátnou zemi.

• Red Rocks – posvátné pohřebiště taurenů na severovýchodě. Projdi se tu potichu.

• Thunder Bluff a Pools of Vision – pod Spirit Rise jsou jezírka vidění, kam se chodí šamani a druidové dívat do jiných světů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

["Durotar"] = [[• Líní peoni (Valley of Trials) – Foreman Thazz'ril ti dá obušek Foreman's Blackjack a pošle tě budit peony, kteří spí pod stromy místo práce. Po ráně zabrblají třeba „Ow! OK, I'll get back to work“ a jdou zase sekat dřevo. Peoni se točí v kruhu – spí, sekají, nosí dřevo – takže na spáče musíš občas chvíli počkat.

• Skrytí nepřátelé – v klasické verzi začíná u samotného Thralla řada questů Hidden Enemies. Najdeš u kultistů Burning Blade ve Skull Rock odznak Lieutenant's Insignia a postupně odhalíš, že kult není samostatný: Thrall ti řekne, že skutečným nepřítelem je Shadow Council. Řada vede až k Ragefire Chasm a v pozdějších verzích WoW byla odstraněna – je to kousek lore, který existuje jen v klasice.

• Ragefire Chasm – lávová jeskyně přímo pod Orgrimmarem, vchod je v Cleft of Shadow. První dungeon Hordy, plný troggů a kultistů Searing Blade.

• Cleft of Shadow – temná rokle v Orgrimmaru, kde sídlí čarodějové, lotři a pochybní obchodníci. Pro město, které se zřeklo démonů, je to dost podezřelá čtvrť.

• Tiragarde Keep – bílá kamenná pevnost Kul Tiras, která v rudém Durotaru vypadá úplně nepatřičně. Velí jí Lieutenant Benedict, který tu po smrti admirála Proudmoora vede jeho válku dál. Kdo prohledá pevnost, najde rozkazy admirála Proudmoora (Admiral Proudmoore's Orders) – a jejich obsah zajímá samotného Thralla.

• Echo Isles – ostrovy na jihu, odkud čaroděj Zalazane vyhnal Darkspear trolly. Svou magií ovládá část jejich lidu. Vol'jin a Master Gadrin v Sen'jin Village hledají někoho, kdo se mu postaví.

• Proč zrovna Durotar – orkové si vybrali drsnou, vyprahlou zemi úmyslně, jako pokání za svou krvavou minulost. Kraj byl původně součástí Barrens a vládli tu kančí lidé Razormane, dokud je Horda za Třetí války nevyhnala na západ.

• Obchod s Theramore – dokud mír držel, orkové posílali přebytky úrody lidem do Theramore a dostávali za ně ryby. Na drsné Hordě je to nečekaně mírumilovný detail.

• Zeppelíny – u Orgrimmaru stojí věž, odkud odlétají goblinské vzducholodě do Undercity a Stranglethorn Vale. Kdo nemá rád výšky, ať se nedívá dolů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net. Pokud ve Forever najdeš něco jinak, napiš mi.]],

["Elwynn Forest"] = [[• Hogger – nejslavnější gnoll Warcraftu. Vede gnolly z Riverpaw v jihozápadních lesích a na nástěnce v Goldshire visí plakát Wanted: Hogger. Je elitní – sám na něj nechoď.

• Princezna musí zemřít – Ma Stonefield tě pošle na dýňové pole Brackwell Pumpkin Patch, kde se vykrmuje obrovská prasnice Princess. Defiasové si ji přivlastnili a quest „Princess Must Die!“ patří k nejvtipnějším v kraji.

• Mladí milenci – rodiny Stonefieldových a Maclureových se nesnášejí, ale Tommy Joe Stonefield a Maybell Maclure se do sebe zamilovali. Quest Young Lovers je elwynnská verze Romea a Julie.

• Tower of Azora – věž mága Theocrita na východě kraje. Questy kolem ní tě zavedou ke koboldům a k jeho podivným experimentům.

• Rolf a Malakai – ztracení vojáci z hlídky u murločích jezer. Najít je a zjistit, co se jim stalo, je úkol pro odvážné.

• Northshire – vinice kolem kláštera obsadili Defiasové. Už první kroky hrdiny vedou k tomu, co Bratrstvo provádí po celém království.

• Lion's Pride Inn – hostinec v Goldshire, kde se potkávají všichni noví hrdinové Aliance. Nejrušnější hostinec ve hře.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

["Westfall"] = [[• Bratrstvo Defias – celý příběh – řada questů The Defias Brotherhood začíná u Gryana Stoutmantla na Sentinel Hill. Pošle tě až do Redridge za informátorem Wileym do hostince v Lakeshire, pak po stopě defiasského posla (Defias Messenger), který běhá po cestách Westfallu, a nakonec doprovázíš zrádce Defias Traitor do Moonbrooku, kde ti ukáže skrýš Bratrstva. Konec je v Deadmines u Edwina VanCleefa.

• Dopis, který VanCleef nestihl poslat – z VanCleefa padá An Unsent Letter adresovaný Barosu Alexstonovi, stavitelům Stormwindu. Odstartuje další questy ve Stormwindu a vede ke stopám, které míří až ke královskému dvoru. V pozdějších verzích WoW dopis zmizel – je to kousek příběhu, který zůstal jen v klasice.

• Deadmines – vchod je v domě v Moonbrooku. Uvnitř: goblinský inženýr Sneed se svým Shredderem, tauren první důstojník Mr. Smite, který v boji mění zbraně, murlok kuchař Cookie a kapitán Greenskin. Na konci obrovská jeskyně s válečnou lodí Defias Juggernaut.

• Kapitán Grayson – duch pirátského kapitána v majáku Westfall Lighthouse na pobřeží Longshore. Jeho loď ztroskotala na skalách za bezměsíčné noci, když maják nesvítil. Od té doby se dívá, jak murloci pod vedením Old Murk-Eye útočí na maják – zabili i rodinu strážce. Teď hlídá plamen, aby nikdo nedopadl jako on. Questy: Keeper of the Flame, The Coast Isn't Clear, The Coastal Menace (ta poslední je právě na Old Murk-Eye).

• Westfallský guláš a Saldeanovi – Salma Saldean ti uvaří Westfall Stew, když jí doneseš maso supů, rypáky kanců Goretusk, oči murloků a okru. Na stejné farmě farmář Saldean bojuje se zbláznivšími se strašáky Harvest Watcher. A Verna Furlbrow u rozbitého vozu potřebuje ovesy pro svého starého koně – quest Poor Old Blanchy.

• Novinky ve WoW Forever (podle průvodců k becie):
  – Vaření tu dává smysl: kančí a murločí maso je všude a vařené jídlo ve Forever dává staty a po deseti vteřinách jídla i +5 % zkušeností za zabití.
  – Campsites – tábořiště v otevřeném světě s buffy, opravami a stanicemi profesí.
  – Příběh Defias pokračuje dál: nový dungeon Alcaz Prison (levely 48–53) má navazovat na příběh Bratrstva a mluví se o souvislosti s králem Varianem. Zatím jde spíš o pověsti.

• Moonbrook – zpustlé město, kdysi srdce Westfallu. Kdysi se tu žilo, dnes jsou ulice plné Defiasů.

• Jangolode Mine a Gold Coast Quarry – doly, kde kopou koboldi i Defiasové. V Jangolode hledej Master Diggera.

• Dust Devils – po polích se točí prachové víry. Jsou to živí elementálové – dávej pozor, ať tě neodfouknou.

Zdroj: Warcraft Wiki, Wowhead (classic), games.gg a foreverdb.net. Pokud ve Forever najdeš něco jinak, napiš mi.]],

["Dun Morogh"] = [[• Deeprun Tram – z Tinker Town v Ironforge jezdí gnómská podzemní dráha až do Stormwindu. Vede pod mořem, takže cestou vidíš skleněnými stěnami vodu a ryby.

• Hall of Explorers – sál v Ironforge plný kostí pravěkých tvorů, map a starožitností. Sídlí tu Explorers' League a knihovna.

• Legendární letiště – hráči kdysi našli vysoko na horách nad Ironforge nedokončené, prázdné „letiště“, kam se normálně nedá dostat. Je to jedno z nejslavnějších tajemství klasického WoW.

• Gnomeregan – vchod do ztraceného gnómského města je na západě kraje. Dungeon plný troggů, robotů a radiace se zrádcem Thermapluggem na konci.

• Thunderbrew Distillery – pivovar v Kharanosu, kde se vaří pivo, o kterém se zpívá po celém Azerothu.

• Amberstill Ranch – farma, kde trpaslíci chovají berany. Odtud pochází jejich slavné jízdní zvíře.

• Brewnall Village – vesnička u zamrzlého jezera, kde trpaslíci zkoušejí nové druhy piva.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

["Teldrassil"] = [[• Ban'ethil Barrow Den – podzemní doupě, kde se skrývají ti, kdo šíří zkázu mezi furbolgy. Na konci se dozvíš, odkud Fel Moss pochází.

• Oracle Glade – tichá mýtina na severozápadě s měsíční studnou.

• Lake Al'Ameth – velké jezero uprostřed ostrova, rybáři tu tráví celé noci.

• Temple of the Moon – chrám Elune v Darnassu s fontánou a sochou Haidene, první velekněžky.

• Rut'theran Village – portál nahoru do Darnassu a hipogryfové přes moře do Darkshore.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

["Stormwind City"] = [[• The Slaughtered Lamb – hostinec v Mage Quarter, který vypadá nevinně. Ve sklepě ale sídlí čarodějové a jejich démoni.

• Deeprun Tram – z Dwarven District jezdí podzemní dráha pod mořem až do Ironforge.

• The Stockade – vězení ve městě, kde se vzbouřili vězni pod vedením Defiasů. Dungeon přímo pod nosem stráží.

• Lady Katrana Prestor (spoiler) – je to černá dračice Onyxia v lidské podobě. Ovládá dvůr kouzly a stála za tím, že kameníci nedostali zaplaceno. Pozorně čti, co říká Bolvarovi.

• SI:7 – tajná služba Stormwindu v Old Town. Lotři tu dostávají své tajné úkoly.

• Stormwind Keep – v trůnním sále sedí malý král Anduin a regent Bolvar Fordragon. A po jejich boku lady Prestor.

• Cathedral of Light – chrám Svatého světla, domov kněží a paladinů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

["Zephras Isle"] = [[• Živelní soutok – u stojících kamenů na severovýchodě je nebeský zrak (skysight) mnohem silnější. Duchové ti tam prý občas prozradí i střípek jiné moudrosti.

• Padání se stylem – z vrcholu strážní věže v Thendal Grove se dá skočit a díky chůzi po vzduchu doplachtit daleko. Kdo přistane přímo před Rorianem the Dayseeker a vyleká ho, dostane od Myriaal „bonusové body“.

• Kotevní pylony – hraničář Halaan Hawk-Eye ti ukáže obrovský pylon v dálce. Na ostrově jich je víc.

• Ostrov je nový – tajemství Zephrasu se teprve objevují. Když najdeš něco zvláštního, napiš mi.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]],

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

-------------------------------------------------------------------------------
-- Eastern Kingdoms – sever (Lordaeron a okolí)
-------------------------------------------------------------------------------

WoWpoCesku_Lore["Tirisfal Glades"] = {
    title = "Tirisfal Glades",
    tag = "Mlhavé lesy, kde mrtví vstali z hrobů – a rozhodli se žít po svém.",
    ch = {
        { "Kdysi srdce Lordaeronu", [[Tirisfal Glades bývaly klidným krajem lesů, farem a vesnic na severu lidského království Lordaeron. Nad nimi stálo hlavní město Lordaeron a jeho bílé hradby byly vidět zdaleka. Dnes je tu věčný podzim, šedé stromy a mlha, ze které se ozývají kroky těch, kdo už dávno nemají dýchat.

Kraj zničila Pohroma (Scourge). Mor, který rozšířil Kult zatracených, proměnil obyvatele v nemrtvé a princ Arthas, posedlý runovým mečem Frostmourne, zavraždil vlastního otce, krále Terenase, přímo v trůnním sále.]] },
        { "Forsaken a Undercity", [[Když moc Lich Kinga na chvíli zeslábla, část nemrtvých se probudila ze sevření jeho vůle. Vedla je Sylvanas Windrunner, bývalá generálka hraničářů z Quel'Thalas, kterou Arthas zabil a proměnil v banshee. Říkají si Forsaken – Opuštění.

Pod troskami hlavního města si postavili Undercity, labyrint kanálů, krypt a laboratoří. Spojili se s Hordou, ale jen proto, že potřebují spojence. Jejich lékárníci (Royal Apothecary Society) potají vyvíjejí nový mor – prý proti Pohromě. Kdo ví, proti komu ještě.]] },
        { "Brill a Deathknell", [[Nově probuzení Forsaken začínají v Deathknell, hřbitově na severozápadě, kde se probouzejí z hrobů a učí se znovu chodit. Brill je ponuré městečko s hostincem Gallows' End Tavern a hřbitovem, kde se nikdo nedivi, když se mrtví procházejí po ulicích.]] },
        { "Hrozby", [[Šarlatový křižácký řád (Scarlet Crusade) považuje každého nemrtvého za zrůdu, kterou je nutno spálit. Na západě drží Scarlet Monastery a jejich hlídky obsadily i okolí Tirisfalu. Kromě nich tu řádí zbytky Pohromy, zdivočelí nemrtví (Scourge), murlokové u jezera Brightwater a gnollové.]] },
    },
}
WoWpoCesku_LoreKnihy["Tirisfal Glades"] = [[• Arthas: Rise of the Lich King – princ Arthas Menethil chtěl svůj lid zachránit za každou cenu. Ve Stratholme nechal vyvraždit obyvatele, aby se nestali nemrtvými, v Northrendu zradil své muže a vzal do ruky Frostmourne. Domů se vrátil jako rytíř smrti a jeho prvním činem bylo zabít otce.

• Sylvanas – Arthas ji zabil při útoku na Quel'Thalas a z trestu jí nedopřál klid, ale proměnil ji v banshee. Když se vymanila, přísahala mu pomstu. Forsaken pro ni nejsou jen lid – jsou to její zbraň.

• Tirisfal a Strážci – jméno kraje nesl i tajný řád Strážců Tirisfalu (Guardians of Tirisfal), jehož posledním členem byl Medivh. Řád se tu kdysi scházel.

• SPOILER (Wrath of the Lich King) – nový mor lékárníků jednoho dne zasáhne u Wrathgate Hordu i Alianci najednou. Za zradou stojí lékárník Putress a démon Varimathras.]]
WoWpoCesku_LoreTajemstvi["Tirisfal Glades"] = [[• Ruiny Lordaeronu – nad vchodem do Undercity stojí trosky trůnního sálu. Tady zemřel král Terenas rukou svého syna.

• Scarlet Monastery – na severovýchodním okraji kraje leží klášter Šarlatových se čtyřmi křídly: hřbitov, knihovna, zbrojnice a katedrála.

• Agamand Mills – opuštěný mlýn rodu Agamandů. Nemrtví členové rodiny tu stále bloudí a questy o nich vyprávějí rodinnou tragédii.

• Lékárníci v Undercity – Royal Apothecary Society vyvíjí „lék“ proti Pohromě. Kdo pozorně čte jejich questy, pozná, že to žádný lék není.

• Brill – hostinec Gallows' End Tavern je jediné místo, kde se ti nemrtvý barman usměje.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Silverpine Forest"] = {
    title = "Silverpine Forest",
    tag = "Temný jehličnatý les, kde vyje něco, co není vlk ani člověk.",
    ch = {
        { "Les pod mrakem", [[Silverpine Forest je hustý, deštivý jehličnatý les jižně od Tirisfalu, který se táhne podél pobřeží až k Hillsbradu. Kdysi tudy vedla obchodní cesta z Lordaeronu do Gilneasu. Dnes je les plný mlhy, polorozpadlých vesnic a opuštěných statků.]] },
        { "Forsaken a Sepulcher", [[Forsaken tu drží základnu The Sepulcher – kryptu ukrytou v lese, odkud vysílají hlídky proti všem, kdo ohrožují cestu k Undercity. Velí tu Deathstalkerové, lovci a zvědové Sylvaniny armády. Podél pobřeží stojí Pyrewood Village, vesnice, ve které se v noci děje něco zvláštního.]] },
        { "Gilneas a Greymane Wall", [[Na jihu les uzavírá obrovská zeď Greymane Wall. Postavil ji král Genn Greymane z Gilneasu, když se jeho království odtrhlo od Aliance – nechtěl platit za válku ani za tábory pro orky. Za zdí se Gilneas uzavřel před světem a nikdo neví, co se tam děje.]] },
        { "Hrozby", [[V horách a lesích žijí worgeni – vlkodlaci z Gilneasu. Kult mága Arugala, pod vedením samotného Arugala, sídlí v Shadowfang Keep, temném hradu nad lesem. Na pobřeží řádí murlokové, gnollové z kmene Moonrage a Rot Hide se svými nemocnými psy. Z jihu se tlačí Dalaranští mágové, kteří nad svým zničeným městem postavili kouzelnou bariéru.]] },
    },
}
WoWpoCesku_LoreKnihy["Silverpine Forest"] = [[• Arugal a worgeni – arcimág Arugal z Dalaranu chtěl za Třetí války zastavit Pohromu. Vyvolal z jiného světa worgeny, divoké vlčí bytosti, a ztratil nad nimi kontrolu. Worgeni zabíjeli všechny bez rozdílu a Arugal, zničený vinou, se jich ujal jako „svých dětí“ a usadil se v Shadowfang Keep.

• Pyrewood Village – SPOILER: obyvatelé vesnice jsou za denního světla normální lidé, ale v noci se mění ve worgeny. Je to první náznak, že prokletí se šíří.

• SPOILER (Cataclysm) – prokletí worgenů nakonec zasáhne celý Gilneas včetně krále Genna Greymana. Gilneas se pak vrátí do Aliance a worgeni se stanou hratelnou rasou.]]
WoWpoCesku_LoreTajemstvi["Silverpine Forest"] = [[• Shadowfang Keep – hrad na kopci uprostřed lesa je dungeon. Cestou potkáš barona Silverlaina a Commandera Springvala, na konci čeká arcimág Arugal.

• Greymane Wall – na jihu les uzavírá obrovská zeď Gilneasu. Přes ni se v klasice nedalo dostat a hráči léta spekulovali, co je za ní.

• Pyrewood Village – vesnice, jejíž obyvatelé se v noci mění ve worgeny. Přijď za tmy a uvidíš.

• Ambermill – vesnice dalaranských mágů, kteří tu kouzlí bez dovolení Forsaken.

• Fenris Isle – ostrov na jezeře se zničenou pevností, kde sídlí Thule Ravenclaw a jeho kult.

• The Sepulcher – krypta Forsaken ukrytá v lese, odkud vyrážejí Deathstalkerové.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Hillsbrad Foothills"] = {
    title = "Hillsbrad Foothills",
    tag = "Zelené kopce, kde Thrall kdysi vybojoval svobodu – a kde se dnes válčí o každý statek.",
    ch = {
        { "Kraj sadů a rybníků", [[Hillsbrad Foothills jsou mírné zelené kopce s jabloňovými sady, farmami a jezery na jihu bývalého Lordaeronu. Hlavním lidským městem je Southshore u moře, kde se schází Aliance. Horda drží Tarren Mill, vesnici obsazenou Forsaken na východě kraje.]] },
        { "Durnholde", [[Nad krajem se tyčí trosky pevnosti Durnholde Keep. Tady Aedelas Blackmoore věznil orky a tady vyrůstal malý Thrall jako gladiátor. Když Thrall utekl a osvobodil své lidi, vrátil se a pevnost dobyl. Dnes v ruinách sídlí Syndikát (Syndicate) – zločinecká organizace bývalé šlechty z Alteracu.]] },
        { "Southshore a Tarren Mill", [[Mezi Southshore a Tarren Millem panuje neustálé napětí. Aliance i Horda tu bojují o každou farmu a v klasickém WoW byla cesta mezi nimi místem nekonečných bitev hráčů – legendárních „Tarren Mill vs Southshore“ šarvátek, na které se vzpomíná dodnes.]] },
        { "Hrozby", [[Syndikát přepadává poutníky a ovládá farmy. V horách řádí yetiové a trollové z Alteracu, na pobřeží murlokové. V Azurelode Mine se dolování zvrhlo a v sadech straší nemrtví.]] },
    },
}
WoWpoCesku_LoreKnihy["Hillsbrad Foothills"] = [[• Lord of the Clans – Thrall vyrůstal v Durnholde a jako gladiátor bojoval v aréně pro zábavu Blackmoora. Taretha Foxton, mladá služebná, mu potají psala dopisy a nakonec mu pomohla utéct.

• Taretha Foxton – žila se svou rodinou v Southshore a Hillsbradu. Když Thrall dobyl Durnholde, Blackmoore ji zabil a hodil Thrallovi pod nohy její hlavu. Thrall to nikdy nezapomněl.

• Caverns of Time – v budoucnosti (The Burning Crusade) se hrdinové vrátí časem do Old Hillsbrad Foothills a pomohou Thrallovi utéct z Durnholde. Uvidí i mladou Tarethu a orka, který se s ní setkal.]]
WoWpoCesku_LoreTajemstvi["Hillsbrad Foothills"] = [[• Durnholde Keep – trosky pevnosti, kde Blackmoore věznil orky a kde vyrůstal Thrall. Dnes tu sídlí Syndikát.

• Southshore vs Tarren Mill – na PvP serverech bývala silnice mezi městy nejrušnější bitevní frontou klasického WoW.

• Ravenholdt Manor – skryté sídlo lotrů v horách na severu. Najdou ho jen lotři přes speciální úkoly.

• Dun Garok – opuštěná trpasličí pevnost na jihu.

• Azurelode Mine – důl, kde se dolování zvrhlo a horníci ho přenechali nepřátelům.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Alterac Mountains"] = {
    title = "Alterac Mountains",
    tag = "Zasněžené hory zrádného království, které prodalo Alianci orkům.",
    ch = {
        { "Zrádné království", [[Alterac bylo jedno ze sedmi lidských království. Jeho král Aiden Perenolde za Druhé války uzavřel tajnou dohodu s Hordou – doufal, že tak své království ochrání. Zrada byla odhalena, Aliance Alterac obsadila a království přestalo existovat. Perenoldovi šlechtici se od té doby schovávají a z jejich zbytků vznikl Syndikát.]] },
        { "Ruiny a hory", [[Hory jsou zasněžené a nehostinné. V údolích leží ruiny Alterac City, kde dnes sídlí ogrové a Syndikát. Na jihu kraje stojí ruiny města Dalaran, které obklopuje fialová kouzelná bariéra.]] },
        { "Dalaran", [[Dalaran bývalo městem mágů. Za Třetí války ho démon Archimonde srovnal se zemí. Přeživší mágové ho teď za neprostupnou kopulí opravují a zkoumají, co zbylo. Do města nikdo nesmí.]] },
        { "Hrozby", [[V horách žijí yetiové, ogrové, Syndikát a trollové z kmene Witherbark. Na severu, v Alterac Valley, spolu bojují trpaslíci ze Stormpike a orkové z Frostwolf klanu.]] },
    },
}
WoWpoCesku_LoreKnihy["Alterac Mountains"] = [[• Zrada Perenolda (Warcraft II a Tides of Darkness) – Aiden Perenolde dovolil Hordě projít přes své území, aby zaútočila na Lordaeron. Když Aliance zradu odhalila, Lothar s Turalyonem Alterac obsadili.

• Frostwolf klan v Alterac Valley – po vyhnání Gul'danem žil Durotanův klan v horách severně od Alteracu. Tady Thrall poprvé potkal svůj lid a starého šamana Drek'thara, který ho naučil šamanismu.

• Dalaran a Antonidas – v Dalaranu žil velký arcimág Antonidas, učitel Jainy Proudmoore. Zabil ho Arthas, když přišel pro knihu kouzel Kel'Thuzada. SPOILER: Dalaran se v budoucnu (Wrath) vznese do vzduchu a odletí do Northrendu.]]
WoWpoCesku_LoreTajemstvi["Alterac Mountains"] = [[• Alterac Valley – na severu leží legendární bitevní pole Aliance proti Hordě. Bitvy v klasice trvaly hodiny i dny.

• Ravenholdt Manor – skryté sídlo lotrů v horách. Lotrovský quest tě k němu dovede.

• Bariéra Dalaranu – fialová kopule nad zničeným městem mágů. Zevnitř je vidět město a mágové, kteří ho opravují.

• Strahnbrad – vesnice obsazená Syndikátem, zbytkem alteracké šlechty.

• Ruins of Alterac – trosky hlavního města zrádného království, dnes plné ogrů Crushridge a Syndikátu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Arathi Highlands"] = {
    title = "Arathi Highlands",
    tag = "Kolébka lidstva – kopce, kde stálo první lidské království.",
    ch = {
        { "Arathor", [[Arathi Highlands jsou travnaté kopce se skalami a ruinami. Kdysi tu stálo Arathorské císařství, první lidský stát. Jeho hlavním městem byl Strom, a právě odtud se lidé rozšířili po celém kontinentu. Strom byl za Druhé války zničen a lidé se do něj nevrátili.]] },
        { "Thoradin's Wall a Stromgarde", [[Na severní hranici stojí Thoradin's Wall, zeď, kterou postavil první lidský král Thoradin proti trollům. Na západě leží Stromgarde, hlavní město království Stromgarde, potomků Arathoru. Dnes je napůl v troskách a bojují o něj ogrové, Syndikát a zbytky lidí.]] },
        { "Kdo tu žije", [[Aliance drží Refuge Pointe, malý tábor uprostřed kraje. Horda má Hammerfall na východě – osadu orků, kteří tu kdysi trpěli v internačních táborech. Mezi nimi leží Arathi Basin, bitevní pole o zdroje.]] },
        { "Hrozby", [[Trollové Witherbark žijí na východě, ogrové v Circle of East Binding a jinde. Syndikát ovládá část kraje a mágové z Dalaranu staví na kopcích tajemné kruhy. Na pobřeží řádí piráti a nagové.]] },
    },
}
WoWpoCesku_LoreKnihy["Arathi Highlands"] = [[• Válka trollů – před téměř třemi tisíci lety bojovali lidé Arathoru spolu s vysokými elfy proti trollí říši Amani. Elfové lidi naučili magii a sto lidí z Arathoru se stalo prvními lidskými mágy. Spojenectví lidí a elfů trvá dodnes.

• Sedm království – po válce se Arathor rozpadl na Gilneas, Alterac, Dalaran, Kul Tiras, Lordaeron, Stromgarde a Stormwind (tehdy Azeroth). Všechna mají kořeny tady.

• Anduin Lothar – poslední potomek krále Thoradina. Mohl si nárokovat trůn celého lidstva, ale místo toho bojoval za všechny jako velitel Aliance.]]
WoWpoCesku_LoreTajemstvi["Arathi Highlands"] = [[• Stromgarde – ruiny města potomků Arathoru, plné ogrů a Syndikátu. Na vrcholu stojí Tower of Arathor.

• Arathi Basin – bitevní pole o pět zdrojů (kovárna, farma, důl, stáje, pila).

• Circle of Binding – kamenné kruhy na kopcích, kde mágové kdysi drželi uvězněné síly. Questy ti ukážou, co se stane, když se kruhy poruší.

• Witherbark Village – trollí vesnice na východě plná vúdú magie.

• Thandol Span – na jihu kraje most do Wetlands, který Dark Ironové poškodili.

• Faldir's Cove – pirátská zátoka na jihozápadním pobřeží.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Wetlands"] = {
    title = "Wetlands",
    tag = "Bažiny plné krokodýlů, raptorů a trpaslíků, kteří tu už nechtějí být.",
    ch = {
        { "Brána na sever", [[Wetlands jsou deštivé bažiny a mokřady na severní hranici trpasličí říše Khaz Modan. Je to jediná suchozemská cesta mezi Ironforge a severními královstvími. Proto tu trpaslíci postavili most Thandol Span a přístav Menethil Harbor, odkud plují lodě na Kalimdor a Northrend.]] },
        { "Grim Batol", [[Na východě se tyčí hora Grim Batol, kdysi pevnost Wildhammerů. Po Válce tří kladiv ji obsadili Dark Ironové a jejich prokletí horu otrávilo. Za Druhé války tu klan Dragonmaw držel v zajetí dračí královnu Alexstraszu a nutil její děti bojovat za Hordu.]] },
        { "Kdo tu žije", [[Menethil Harbor je malé lidské městečko na pobřeží. Trpaslíci z Ironforge mají hlídky podél silnice a ve Whelgar's Excavation Site kopou badatelé Explorers' League. Dragonmaw orkové stále drží několik pevností na východě.]] },
        { "Hrozby", [[Klan Dragonmaw, murlokové, raptoři, krokodýli (crocolisk) a gnollové z Mosshide. V ruinách Dun Modr sídlí Dark Ironové a v jeskyních se skrývají draci.]] },
    },
}
WoWpoCesku_LoreKnihy["Wetlands"] = [[• Day of the Dragon – ork Nekros Skullcrusher držel Alexstraszu v Grim Batol pomocí artefaktu Demon Soul. Mág Rhonin (později velký hrdina) se tam vydal sám, s pomocí trpaslíků, elfky Vereesy a draka Korialstrasze, a Alexstraszu osvobodil. Deathwing se mezitím pokusil ukrást dračí vejce.

• Rhonin a Vereesa – po tomto dobrodružství se Rhonin s Vereesou Windrunner, sestrou Sylvanas, vzali. SPOILER: Rhonin později vede Dalaran.

• Thandol Span – most přes rokli byl dříve celý. Dark Ironové ho při útoku vyhodili do vzduchu a dodnes je jeho část zničená.]]
WoWpoCesku_LoreTajemstvi["Wetlands"] = [[• Wetlands Excavation Site (novinka WoW Forever) – nový dungeon pro levely 24–29.

• Grim Batol – vchod do hory je v klasice zavřený. Tady klan Dragonmaw kdysi držel dračí královnu Alexstraszu.

• Menethil Harbor – lodě plují do Theramore a do Auberdine.

• Thandol Span – most přes rokli, jehož část Dark Ironové vyhodili do vzduchu.

• Thelgen Rock – jeskyně plná pavouků, troggů a jezírek.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Loch Modan"] = {
    title = "Loch Modan",
    tag = "Klidné jezero za gigantickou hrází, kterou trpaslíci postavili s kladivem v ruce.",
    ch = {
        { "Jezero za hrází", [[Loch Modan je hornatý kraj jezer, borovic a pastvin východně od Dun Morogh. Uprostřed leží velké jezero, které vzniklo, když trpaslíci postavili obrovskou hráz Stonewrought Dam. Kraj je klidnější než bažiny na severu a trpaslíci tu chovají horské kozy a beraní.]] },
        { "Thelsamar", [[Hlavním městečkem je Thelsamar, malá vesnice se stájemi a hostincem. Na severu leží Stonesplinter Valley a v horách výzkumná stanice Explorers' League, která pátrá po původu trpaslíků.]] },
        { "Kdo tu žije", [[Kromě trpaslíků tu žijí gnómové, kteří utekli z Gnomereganu, a horníci v dole Silver Stream Mine. Mountaineers – trpasličí horalové – hlídají průsmyky a silnice.]] },
        { "Hrozby", [[Troggové z kmene Stonesplinter se tlačí z hlubin. Koboldi z Tunnel Rat obsadili doly, gnollové a Dark Ironové škodí na hrázi. Na jihu se ozývají útoky ogrů a Dark Ironů z Badlands.]] },
    },
}
WoWpoCesku_LoreKnihy["Loch Modan"] = [[• Hráz Stonewrought Dam – trpaslíci ji postavili, aby zachytili vodu pro Ironforge a zemědělství. SPOILER (Cataclysm): hráz se při kataklyzmatu protrhne a jezero vyteče – z kraje zůstane bahnité údolí.

• Původ trpaslíků – Explorers' League v Loch Modan vede výzkum, který vyvrcholí v Uldamanu (Badlands). Disky Norgannona tam prozradí, že trpaslíci jsou potomci earthen, služebníků titánů.

• Brann Bronzebeard – slavný badatel a Magniho bratr kdysi začal své výpravy právě odsud.]]
WoWpoCesku_LoreTajemstvi["Loch Modan"] = [[• Stonewrought Dam – vyjdi nahoru na hráz. Výhled na jezero patří k nejhezčím v Khaz Modanu.

• Valley of Kings – průsmyk z Dun Morogh hlídají obrovské sochy trpasličích králů.

• Farstrider Lodge – lovecká chata u jezera, kde se scházejí lovci.

• Ironband's Excavation Site – výkop Explorers' League s artefakty i troggy.

• Mo'grosh Stronghold – ogří pevnost na severovýchodě.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Redridge Mountains"] = {
    title = "Redridge Mountains",
    tag = "Rudé skály a jezero, kde se Stormwind snaží uhájit svou východní hranici.",
    ch = {
        { "Kraj rudých skal", [[Redridge Mountains jsou rudé kopce a jehličnaté lesy s velkým jezerem Lake Everstill uprostřed, východně od Elwynn Forest. Je to pohraničí lidského království – za horami leží Burning Steppes, odkud útočí ogrové a orkové z Blackrock.]] },
        { "Lakeshire", [[Hlavním městem je Lakeshire, malebné městečko na jezeře s mostem a radnicí. Starosta a velitelé stráže se snaží kraj ubránit, ale Stormwind jim posílá jen málo vojáků. Proto vypisují odměny a hledají dobrodruhy.]] },
        { "Kdo tu žije", [[Žijí tu rybáři, dřevorubci a farmáři. Kraj byl za První války prvním, kudy orkové táhli na Stormwind, a starší obyvatelé si to dobře pamatují.]] },
        { "Hrozby", [[Gnollové z kmene Redridge napadají farmy, orkové Blackrock zakládají pevnosti v horách a stále se šíří zvěsti o drakonidech z Burning Steppes. V jezeře řádí murlokové.]] },
    },
}
WoWpoCesku_LoreKnihy["Redridge Mountains"] = [[• První válka – po otevření Temného portálu prošla Horda Redridge na cestě ke Stormwindu. Mnoho vesnic tehdy shořelo.

• Klan Blackrock – pod náčelníkem Blackhandem vedl Hordu v První válce. Jeho potomci dnes sídlí v Blackrock Spire a do Redridge posílají své oddíly.

• Lakeshire a Stormwind – město trpí stejným problémem jako Westfall: šlechta ve Stormwindu se o pohraničí nestará.]]
WoWpoCesku_LoreTajemstvi["Redridge Mountains"] = [[• Lakeshire – městečko na jezeře s mostem. Kuchařka v hostinci má quest na slavný Redridge Goulash.

• Stonewatch Keep – pevnost na východě obsazená orky Blackrock.

• Tower of Ilgalar – věž zrádného mága Ilgalara na severu kraje.

• Render's Valley – údolí na jihovýchodě, kde Redridge sousedí s Burning Steppes.

• Alther's Mill – dřevařský mlýn na severu kraje, kolem kterého se potulují nepřátelé.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Duskwood"] = {
    title = "Duskwood",
    tag = "Les věčného soumraku, kde se z hrobů zvedají mrtví a v noci vyjí worgeni.",
    ch = {
        { "Les, který potemněl", [[Duskwood býval zelený les plný farem a vesnic – prý se mu kdysi říkalo Brightwood. Pak do něj vstoupila temná síla a les potemněl. Teď je tu věčný soumrak, hřbitovy plné nemrtvých a vlci s rudýma očima.]] },
        { "Darkshire", [[Hlavním městem je Darkshire, ponuré městečko s hlídkou Night Watch. Lidé tu žijí ve strachu, ale nevzdávají se. Ve městě najdeš hrobníky, kouzelníky i vdovy po vojácích.]] },
        { "Proč les potemněl", [[Za temnotou stojí Medivh. Jeho sídlo Karazhan leží hned za horami v Deadwind Pass a jeho zlo prosáklo do okolí. A na severu, v Twilight Grove, se objevili zelení draci, kteří se chovají podivně – jako by je ovládal zlý sen. Nekromanti využili zkázy a začali oživovat mrtvé ze hřbitova Raven Hill.]] },
        { "Hrozby", [[Nemrtví, kostlivci, ghúlové, worgeni, gnollové a nekromanti. V horách sídlí Defiasové a v lesích pavouci velcí jako koně. A pak je tu Stitches – obrovská zrůda sešitá z mrtvol.]] },
    },
}
WoWpoCesku_LoreKnihy["Duskwood"] = [[• Stitches – nekromant Abercrombie, který žije v chatrči v lese, sešil obří zrůdu z těl mrtvých. SPOILER: když ji pustí, vydá se po silnici do Darkshire a strážníci ji musí zastavit. Je to jeden z nejpamátnějších questů klasického WoW.

• Morbent Fel – nekromant, který ovládá ruiny vesnice Raven Hill. Na jeho zabití potřebuješ speciální zbraň od kněze.

• Worgeni v Duskwood – SPOILER: jsou propojeni s Arugalovým kultem ze Silverpine. Kult pomalu šíří prokletí na jih.

• Karazhan – Medivhova věž v Deadwind Pass je nedaleko. Temnota lesa je její stín.]]
WoWpoCesku_LoreTajemstvi["Duskwood"] = [[• Stitches – nekromant Abercrombie, který žije v chatrči na západě lesa, sešil obří zrůdu z mrtvol. Když ji pustí, vydá se po silnici do Darkshire a stráže ji musí zastavit.

• Příběh Stalvana Mistmantla – dlouhá řada questů začínající v Darkshire tě provede přes Westfall, Elwynn i Stormwind a odhalí temné tajemství.

• Morbent Fel – nekromant na hřbitově Raven Hill. Bez speciální zbraně Morbent's Bane na něj nestačíš.

• Twilight Grove – háj na severu, kde se objevují zelení draci posedlí Noční můrou (Emeriss, Lethon, Taerar nebo Ysondre).

• Roland's Doom – opuštěný důl na severu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Stranglethorn Vale"] = {
    title = "Stranglethorn Vale",
    tag = "Džungle trollích ruin, pirátů a lovců, kde se soupeří o každou trofej.",
    ch = {
        { "Džungle na jihu", [[Stranglethorn Vale je obrovská tropická džungle na jihu Eastern Kingdoms. Kdysi tu stála trollí říše Gurubashi, jedna z největších na světě. Dnes zbyly jen ruiny chrámů zarostlé lianami, tygři, raptoři a gorily.]] },
        { "Booty Bay", [[Na jižním cípu leží Booty Bay, goblinské pirátské město postavené kolem zátoky. Vchod je skrytý v tlamě obří žraločí lebky. Platí tu jediný zákon: obchod. Kdo zaútočí ve městě, toho rozsekají stráže kartelu Steamwheedle. Piráti z Bloodsail Buccaneers jsou jejich úhlavní nepřátelé.]] },
        { "Kdo tu žije", [[Lovci z Nesingwary's Expedition pořádají velký hon na zvěř. Aliance drží Rebel Camp a Horda Grom'gol Base Camp na pobřeží. Uprostřed džungle stojí Gurubashi Arena, kde se bojuje o poklad.]] },
        { "Hrozby", [[Trollové Bloodscalp, Skullsplitter a Gurubashi, piráti Bloodsail Buccaneers, nagové na pobřeží a Kurzen's Mercenaries – bývalí vojáci, kteří se v džungli zbláznili. A v srdci džungle se probouzí krvavý bůh Hakkar.]] },
    },
}
WoWpoCesku_LoreKnihy["Stranglethorn Vale"] = [[• Říše Gurubashi – trollové Gurubashi kdysi ovládali jih kontinentu. Ve válce s jinými kmeny vyvolali krvavého boha Hakkara Soulflayera. Hakkar začal vraždit vlastní uctívače, a tak ho trollové zahnali. Říše se rozpadla na menší kmeny.

• Zul'Gurub – kněží Atal'ai se Hakkara snaží znovu vyvolat. SPOILER: v klasickém WoW se Hakkar vrátil v Zul'Gurub, velkém raidu v severovýchodní části džungle.

• Hemet Nesingwary – lovec s legendárními úlovky. Jméno je odkaz na Ernesta Hemingwaye a jeho lovecké knihy. Jeho questy na zabití desítek tygrů jsou proslulé.]]
WoWpoCesku_LoreTajemstvi["Stranglethorn Vale"] = [[• Green Hills of Stranglethorn – stránky knihy Hemeta Nesingwaryho jsou rozházené po celé džungli. Kdo posbírá všechny kapitoly, složí knihu. Název odkazuje na Hemingwayovy „Zelené pahorky africké“.

• Gurubashi Arena – každé tři hodiny se v aréně objeví truhla s pokladem a všichni uvnitř o ni bojují.

• Zul'Gurub – trollí chrám na severovýchodě, raid pro 20 hráčů s bohem Hakkarem.

• King Bangalash – bílý tygr, „král tygrů“, vrchol Nesingwaryho lovu.

• Booty Bay – vchod vede tlamou obří žraločí lebky. Piráti Bloodsail Buccaneers a goblinský kartel spolu vedou válku.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

-------------------------------------------------------------------------------
-- Eastern Kingdoms – Plaguelands, Hinterlands a jih
-------------------------------------------------------------------------------

WoWpoCesku_Lore["The Hinterlands"] = {
    title = "The Hinterlands",
    tag = "Divoké vrchoviny gryfích jezdců a trollů, kteří si pamatují dávnou slávu.",
    ch = {
        { "Divočina na severu", [[The Hinterlands jsou zelené, hornaté lesy na severovýchodě Lordaeronu, daleko od měst a silnic. Vzduch je tu čistý a na nebi krouží gryfové. Kdysi tu vládla trollí říše Amani, jejíž ruiny jsou rozeseté po celém kraji.]] },
        { "Aerie Peak", [[Na skalách na západě leží Aerie Peak, domov trpaslíků Wildhammer. Na rozdíl od svých bratranců z Ironforge žijí venku, v souladu s přírodou, a létají na gryfech. Jsou to divocí, hrdí válečníci a Ironforge si moc nerozumějí – ale v nouzi stojí za Aliancí.]] },
        { "Revantusk", [[Na východním pobřeží žijí trollové z kmene Revantusk. Jsou to Amani, kteří se oddělili od svých bratří a přidali se k Hordě. Jejich vesnice je jedním z mála míst Hordy v tomto kraji.]] },
        { "Hrozby", [[Trollové Witherbark a Vilebranch sídlí v obřích pevnostech Shadra'Alor a Jintha'Alor. Kněží Atal'ai uctívají Hakkara, v lesích žijí vlci, sovy a divocí gryfové. Na severu se tlačí zbytky Pohromy.]] },
    },
}
WoWpoCesku_LoreKnihy["The Hinterlands"] = [[• Válka trollů – Amani kdysi ovládali celý sever kontinentu. Vysocí elfové z Quel'Thalas s nimi bojovali po staletí a zvítězili až s pomocí lidí z Arathoru.

• Wildhammeři – po Válce tří kladiv odešli z Grim Batolu, když ho prokleli Dark Ironové. Usadili se v Hinterlands a z divokých gryfů si udělali věrné druhy. Za Druhé války bojoval jejich gryfí jezdec Kurdran Wildhammer v čele Aliance.

• Zul'jin – legendární trollí náčelník Amani, který za Druhé války vedl trolly v Hordě. SPOILER: v budoucnu (The Burning Crusade) ho najdeš v Zul'Aman, kde se mstí elfům.]]
WoWpoCesku_LoreTajemstvi["The Hinterlands"] = [[• Jintha'Alor – obří trollí pevnost na jihovýchodě, kde sídlí kněží Hakkara.

• Seradane – jeden ze čtyř stromů snu, kde se objevuje zlý zelený drak.

• Aerie Peak – domov trpaslíků Wildhammer a jejich gryfů.

• Quel'Danil Lodge – lovecká chata vznešených elfů, kteří tu stále bojují s trolly Amani.

• OOX-09/HL – v kraji najdeš porouchaného robotického kuřete. Kdo ho doprovodí (spolu s dalšími dvěma v Tanaris a Feralas), dostane od gnóma v Booty Bay vlastního mechanického kuřete.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Western Plaguelands"] = {
    title = "Western Plaguelands",
    tag = "Mrtvá pole Lordaeronu, kde se bojuje o každou vesnici s nemrtvými.",
    ch = {
        { "Země moru", [[Western Plaguelands jsou zpustlé kopce a pole východně od Tirisfalu. Kdysi tu byly bohaté farmy a vesnice; mor je proměnil v šedé, nemocné kraje plné rozpadlých stodol a mrtvých stromů. Uprostřed kraje se tyčí Andorhal, město, kde začal mor.]] },
        { "Chillwind Camp a Bulwark", [[Aliance drží Chillwind Camp na jihu – malý tábor Argent Dawn a Aliance, odkud se plánují útoky. Horda a Forsaken hlídají The Bulwark, opevněnou hranici s Tirisfalem. Obě strany mají stejného nepřítele: Pohromu.]] },
        { "Hearthglen a Scholomance", [[Na severu leží Hearthglen, pevnost Šarlatového křižáckého řádu. Na ostrově v jezeře Darrowmere stojí Caer Darrow s ruinami hradu rodu Barov – pod ním je Scholomance, škola nekromancie, kde Kult zatracených učí nové nekromanty.]] },
        { "Hrozby", [[Pohroma, nekromanti, Šarlatoví, zdivočelí nemrtví, mutovaní vlci a medvědi. V Andorhalu se bojuje nejvíc – mrtví tam jsou všude.]] },
    },
}
WoWpoCesku_LoreKnihy["Western Plaguelands"] = [[• Andorhal a Kel'Thuzad – arcimág Kel'Thuzad z Dalaranu propadl nekromancii a založil Kult zatracených. Rozšířil mor přes obilí ze sýpek v Andorhalu. Arthas ho tu zabil – ale Kel'Thuzad se vrátil jako lich a vládne v Naxxramas.

• Rod Barovů – šlechtici z Caer Darrow prodali svůj hrad Kultu výměnou za nesmrtelnost. Teď jsou z nich nemrtví učitelé v Scholomance.

• Uther Lightbringer – první paladin a velitel Rytířů Stříbrné ruky. Arthas ho zabil, když se postavil proti jeho šílenství. Uther's Tomb stojí na jihu kraje a jeho duch tam promlouvá k těm, kdo přijdou s úctou.]]
WoWpoCesku_LoreTajemstvi["Western Plaguelands"] = [[• Uther's Tomb – hrobka Uthera Lightbringera na jihu kraje.

• Scholomance – škola nekromancie pod Caer Darrow. Na konci Darkmaster Gandling.

• Farmy kolem Andorhalu – Felstone Field, Dalson's Tears a Gahrron's Withering mají každá svůj tragický příběh. V Dalson's Tears najdi deník.

• Andorhal – město, kde Kel'Thuzad rozšířil mor přes obilí.

• Sada Rider of the Plaguelands (novinka WoW Forever) – 2 kusy: +5 % rychlosti jízdy v obou Plaguelands, 3 kusy: šance při útoku způsobit 140 temného poškození. Kusy se v betě zatím nenašly.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Eastern Plaguelands"] = {
    title = "Eastern Plaguelands",
    tag = "Srdce Pohromy – kraj, nad kterým se vznáší létající nekropole.",
    ch = {
        { "Nejhorší místo Lordaeronu", [[Eastern Plaguelands jsou nejvíc zasažená část bývalého Lordaeronu. Půda je tu zelená morem, stromy mrtvé a řeky otrávené. Nad krajem se vznáší Naxxramas, létající nekropole Kel'Thuzada, odkud Pohroma řídí své armády.]] },
        { "Light's Hope Chapel", [[Na východě stojí Light's Hope Chapel, kaple, kde se Argent Dawn drží proti Pohromě. Je to jediné bezpečné místo v kraji – Světlo tu je tak silné, že nemrtví neprojdou. Tady se scházejí hrdinové obou frakcí.]] },
        { "Stratholme", [[Na severu leží Stratholme, kdysi druhé největší lidské město. Tady Arthas nechal vyvraždit obyvatele, aby je mor nezměnil v nemrtvé – a tady se začal měnit v to, čím se stal. Dnes je město plné Pohromy a Šarlatových.]] },
        { "Hrozby", [[Všechno. Pohroma, ghúlové, obludy sešité z mrtvol, nekromanti, nemrtví draci a Šarlatoví z Tyr's Hand. Mrtví tu převyšují živé stokrát.]] },
    },
}
WoWpoCesku_LoreKnihy["Eastern Plaguelands"] = [[• Vyčištění Stratholme (Warcraft III) – Arthas zjistil, že obilí v Stratholme je otrávené. Nařídil zabít všechny obyvatele, než se promění. Uther a Jaina ho odmítli následovat. Pro mnohé je to okamžik, kdy princ padl.

• Bitva u Light's Hope – kaple stojí na místě, kde se kdysi ubránila malá skupina rytířů proti obrovské armádě Pohromy. Jejich víra posvětila zem.

• Tirion Fordring – paladin, který byl vyhnán z řádu za to, že chránil orka Eitrigga. Žije jako poustevník v chatrči u jezera v tomto kraji. SPOILER: Tirion později vede Argent Crusade proti Lich Kingovi.

• Naxxramas – SPOILER: létající nekropole je posledním raidem klasického WoW. Na konci čeká Kel'Thuzad.]]
WoWpoCesku_LoreTajemstvi["Eastern Plaguelands"] = [[• Tirion Fordring – v chatrči u jezera žije muž, který vypadá jako starý rybář. Jeho questová řada Redemption je jedna z nejkrásnějších v klasice.

• Stratholme – dungeon rozdělený na živou a nemrtvou část. Z barona Rivendara vzácně padá kůň Deathcharger.

• Darrowshire – řada questů o bitvě u Darrowshire ti dovolí znovu prožít bitvu, ve které vesnice padla. Dojemný příběh o dívce Pamele.

• Naxxramas – létající nekropole nad krajem, poslední raid klasiky.

• Light's Hope Chapel – jediné bezpečné místo v kraji, kde se scházejí hrdinové obou frakcí.

• Sada Rider of the Plaguelands platí i tady (viz Western Plaguelands).

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Badlands"] = {
    title = "Badlands",
    tag = "Rudá vyprahlá poušť, kde draci odpočívají a trpaslíci hledají svou minulost.",
    ch = {
        { "Spálená země", [[Badlands jsou rudá, rozpraskaná poušť jižně od Loch Modan. Žádné stromy, žádná tráva, jen skály, kaňony a kosti obřích tvorů. Kdysi tu byla úrodná krajina, ale válka a ohnivá magie ji spálily.]] },
        { "Uldaman", [[Na severu leží Uldaman, prastarý trezor titánů. Trpaslíci z Explorers' League tu kopou a hledají důkazy o tom, odkud pocházejí. A Dark Ironové sem posílají své lidi, aby je předběhli.]] },
        { "Kdo tu žije", [[Horda má Kargath na západě – pevnost orků, kteří utekli z Blackrock. Aliance drží jen malé tábory badatelů. Goblini kopou v dolech a draci z Lethlor Ravine se slunci na skalách.]] },
        { "Hrozby", [[Dark Ironové, ogrové, troggové, kojoti, supi, buvoli a draci. Na jihu se Badlands potkávají se Searing Gorge, odkud se valí oheň a láva.]] },
    },
}
WoWpoCesku_LoreKnihy["Badlands"] = [[• Disky Norgannona – v Uldamanu leží disky titánů, které prozrazují, že titáni stvořili earthen (kamenné bytosti) a že trpaslíci jsou jejich potomci. Prokletí masa (Curse of Flesh) z nich udělalo smrtelné tvory.

• Ironaya – kamenná strážkyně Uldamanu, kterou postavili titáni. Hrdinové ji musí probudit, aby se dostali k diskům.

• Draci z Lethlor Ravine – tady sídlí černí a rudí draci, kteří se navzájem nesnášejí. Rudí jsou spojenci Alexstraszy, černí slouží Deathwingovi.]]
WoWpoCesku_LoreTajemstvi["Badlands"] = [[• Uldaman – trezor titánů s kamennými golemy a Archaedasem na konci. Disky Norgannona tu prozradí původ trpaslíků.

• Lethlor Ravine – rokle s obří dračí kostrou, kde hnízdí draci.

• Kargath – orčí pevnost pojmenovaná po Kargathu Bladefistovi, náčelníkovi klanu Shattered Hand.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Searing Gorge"] = {
    title = "Searing Gorge",
    tag = "Rozžhavená roklina, kde Dark Ironové otrocky dolují pro svého ohnivého pána.",
    ch = {
        { "Kraj ohně", [[Searing Gorge je kaňon rozžhavené skály, láv a kouře na sever od Blackrock Mountain. Vzduch tu pálí a země hoří. Kdysi to byla část trpasličí říše, ale Válka tří kladiv ji proměnila v peklo.]] },
        { "Thorium Brotherhood", [[V Thorium Point sídlí Thorium Brotherhood – trpasličí kováři, kteří se odtrhli od Dark Ironů. Hledají spojence a nabízejí nejlepší kovářské recepty na světě. Ale aby ti uvěřili, musíš si získat jejich důvěru.]] },
        { "The Cauldron", [[Uprostřed kraje je The Cauldron, obrovský důl, kde Dark Ironové nutí otroky – i jiné trpaslíky – kopat rudu. Nad ním stojí stroje a mosty a dýmá z něj černý kouř.]] },
        { "Hrozby", [[Dark Ironové, ohniví elementálové, golemové a pavouci. Na jihu se tyčí Blackrock Mountain, kde sídlí Ragnaros i Nefarian.]] },
    },
}
WoWpoCesku_LoreKnihy["Searing Gorge"] = [[• Vyvolání Ragnarose – na konci Války tří kladiv vyvolal Dark Ironský čaroděj Thaurissan pána ohně Ragnarose. Výbuch zničil tento kraj a Ragnaros zotročil samotné Dark Irony.

• Blackrock Mountain – hora je dnes rozdělená: dole Dark Ironové a Ragnaros (Molten Core), nahoře orkové klanu Blackrock a drak Nefarian (Blackwing Lair).

• Thorium Brotherhood – trpaslíci, kteří se vzepřeli Ragnarosovi a Dark Ironskému císaři.]]
WoWpoCesku_LoreTajemstvi["Searing Gorge"] = [[• Vstup do Blackrock Mountain – na jihu vede řetězový most do hory, kde jsou dungeony Blackrock Depths a Blackrock Spire a raidy Molten Core a Blackwing Lair.

• Franclorn Forgewright – uvnitř hory se zjevuje duch trpasličího stavitele. Jeho quest Dark Iron Legacy tě dovede ke klíči Shadowforge Key.

• Thorium Point – reputace s Thorium Brotherhood odemkne slavné recepty.

• The Cauldron – obrovský důl, kde Dark Ironové nutí otroky kopat rudu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Burning Steppes"] = {
    title = "Burning Steppes",
    tag = "Spálené pláně pod Blackrock Mountain, kde se orkové a draci perou o horu.",
    ch = {
        { "Popel a láva", [[Burning Steppes jsou černé, spálené pláně na jih od Blackrock Mountain. Láva tu teče potoky, kouř zakrývá slunce a všude je cítit síra. Kraj vznikl při stejném výbuchu jako Searing Gorge.]] },
        { "Blackrock", [[Klan Blackrock tu má svou pevnost v horách a v Blackrock Spire. Vede je Warchief Rend Blackhand, syn Blackhanda – a slouží drakovi Nefarianovi, i když to sami nepřiznají.]] },
        { "Kdo tu žije", [[Aliance drží Morgan's Vigil na jihovýchodě, kde Marshal Maxwell hlídá cestu do Redridge. Horda má jen malý tábor Flame Crest u hory, kde orkové plánují pomstu Blackrocku.]] },
        { "Hrozby", [[Orkové Blackrock, černí draci a drakonidi, ohniví elementálové a obří psi. Nad horou vládne Nefarian a pod ní Ragnaros.]] },
    },
}
WoWpoCesku_LoreKnihy["Burning Steppes"] = [[• Blackhand – náčelník klanu Blackrock a velitel Hordy v První válce. Zabil ho Orgrim Doomhammer v souboji, aby převzal vládu nad Hordou. Jeho synové Rend a Maim sídlí v Blackrock Spire.

• Marshal Windsor – hrdina Aliance, který byl zajat v Blackrock. SPOILER: jeho osvobození vede k odhalení Lady Prestor jako dračice Onyxie ve Stormwindu.

• Nefarian – Deathwingův syn, který v Blackwing Lair provádí experimenty na dracích a vytváří chromatické draky ze všech barev.]]
WoWpoCesku_LoreTajemstvi["Burning Steppes"] = [[• Blackrock Spire a Blackwing Lair – horní část hory: dungeon a raid draka Nefariana.

• Marshal Windsor – questová řada od Marshala Maxwella v Morgan's Vigil vede až k odhalení lady Prestor jako dračice Onyxie ve Stormwindu.

• Dreadmaul Rock – ogří pevnost na skále s výhledem na celý kraj.

• Ruins of Thaurissan – trosky starého města Dark Ironů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Swamp of Sorrows"] = {
    title = "Swamp of Sorrows",
    tag = "Smutná bažina, kde leží potopený chrám boha, kterého trollové chtěli vrátit.",
    ch = {
        { "Bažina smutku", [[Swamp of Sorrows je tmavá bažina plná mechu, zkroucených stromů a jezírek na jihovýchodě Eastern Kingdoms. Mlha tu nikdy nezmizí a ze stromů visí liány. Kraj nese jméno po smutku a zkáze, které tu zanechala válka trollů a potopení chrámu.]] },
        { "Sunken Temple", [[Uprostřed bažiny leží Temple of Atal'Hakkar, potopený chrám, kde kněží Atal'ai kdysi uctívali krvavého boha Hakkara. Zelený drak Eranikus ho po staletí hlídal, aby se Hakkar nevrátil. Pod hladinou jezera stále sídlí trollové a draci.]] },
        { "Stonard", [[Horda tu má Stonard, velkou orkskou pevnost postavenou z kamene a dřeva. Aliance má jen malé tábory. Z jihu se táhne cesta k Blasted Lands a Temnému portálu.]] },
        { "Hrozby", [[Trollové Atal'ai, zelení draci, krokodýli, nagové, ještěři a Lost Ones – zbloudilí draenei, kteří přežili zkázu svého světa.]] },
    },
}
WoWpoCesku_LoreKnihy["Swamp of Sorrows"] = [[• Zkáza chrámu – když se trollové Atal'ai pokusili vyvolat Hakkara, Ysera, aspekt snů, potopila celý chrám do bažiny. Pověřila draka Eranika, aby chrám hlídal. Eranikus ale za staletí zahořkl a jeho mysl ovládla Noční můra.

• SPOILER – v dlouhé questové řadě k bránám Ahn'Qiraj se Eranikus objeví v Moonglade, posedlý Noční můrou. Po bitvě, které se účastní i Tyrande a Remulos, se z ní nakonec vymaní.

• Lost Ones – draenei, kteří přišli z Draenoru. Patří k nejstarším stopám, že draenei vůbec existují.]]
WoWpoCesku_LoreTajemstvi["Swamp of Sorrows"] = [[• Sunken Temple – potopený chrám Atal'Hakkar s avatarem Hakkara a zeleným drakem Eranikem.

• Fallen Hero of the Horde – u silnice blízko Stonardu stojí duch padlého hrdiny Hordy. Jeho questy vyprávějí příběh, který vede až do Blasted Lands.

• Galen's Fall – tábor, kde doprovodíš Galena Goodwarda do bezpečí.

• Itharius – zelený drak, který hlídá okolí potopeného chrámu.

• Fallow Sanctuary – úkryt Lost Ones, zbloudilých draenei.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Blasted Lands"] = {
    title = "Blasted Lands",
    tag = "Pustina, kde stojí Temný portál – brána, kterou orkové přišli na Azeroth.",
    ch = {
        { "Spálená země", [[Blasted Lands jsou rudá, mrtvá pustina na jihovýchodě Eastern Kingdoms. Nic tu neroste, voda je otrávená a nebe rudé. Kraj zničila démonická magie, která proudila Temným portálem.]] },
        { "Temný portál", [[Na jihu kraje stojí obrovská brána – Temný portál. Otevřeli ho čaroděj Gul'dan s Medivhem a orkové jím přišli na Azeroth. Brána je dnes neaktivní, ale démoni kolem ní stále krouží.]] },
        { "Nethergarde Keep", [[Na severu stojí Nethergarde Keep, pevnost mágů z Dalaranu, kteří hlídají portál, aby se znovu neotevřel. Jsou to jediní, kdo v kraji žije dobrovolně.]] },
        { "Hrozby", [[Démoni, ogrové, kolosální štíři, hyeny, satyrové a Shadowsworn kultisté, kteří se snaží portál znovu otevřít.]] },
    },
}
WoWpoCesku_LoreKnihy["Blasted Lands"] = [[• Otevření portálu (Rise of the Horde, The Last Guardian) – Medivh, posedlý Sargerasem, se spojil s Gul'danem. Spolu otevřeli Temný portál a orkové táhli na Azeroth.

• Uzavření portálu – po Druhé válce Aliance portál zničila. Pak ho šaman Ner'zhul znovu otevřel a odvedl orky zpátky na Draenor. Draenor se při tom roztrhal na kusy – a stal se z něj Outland.

• SPOILER (The Burning Crusade) – Temný portál se znovu otevře a hrdinové jím projdou do Outlandu.]]
WoWpoCesku_LoreTajemstvi["Blasted Lands"] = [[• Temný portál – v klasice neaktivní brána, kterou orkové přišli na Azeroth.

• Lord Kazzak – v The Tainted Scar na severozápadě sídlí obří démon, world boss klasického WoW.

• Nethergarde Keep – mágové tu hlídají portál. Bloodmage Lynnore a Bloodmage Drazial ti za suroviny z kraje (třeba Snickerfang Jowls) udělají silné elixíry.

• Altar of Storms – oltář spojený s Gul'danovými rytíři smrti.

• Dreadmaul Hold – ogří pevnost blízko portálu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Deadwind Pass"] = {
    title = "Deadwind Pass",
    tag = "Průsmyk mrtvého větru, kde stojí věž, ve které začalo všechno zlo.",
    ch = {
        { "Průsmyk smrti", [[Deadwind Pass je pustý průsmyk mezi Duskwoodem a Swamp of Sorrows. Stromy jsou mrtvé, vítr kvílí a nad krajem visí věčné šero. Uprostřed se tyčí Karazhan, věž Medivha.]] },
        { "Karazhan", [[Medivh, Strážce Tirisfalu, žil v Karazhanu se svými služebníky. Ve věži se odehrály hostiny, kouzla i šílenství, které nakonec vedlo k otevření Temného portálu. Když Medivh zemřel, věž opustili všichni – kromě duchů.]] },
        { "Kdo tu žije", [[Nikdo. Jen duchové, ogrové a záhadné bytosti, které přitahuje magie věže. Občas sem zavítají badatelé a mágové.]] },
        { "Hrozby", [[Duchové, ogrové, nemrtví a záhadné stínové bytosti. A ve věži něco, co se probouzí.]] },
    },
}
WoWpoCesku_LoreKnihy["Deadwind Pass"] = [[• The Last Guardian – Khadgar, mladý mág z Dalaranu, přišel do Karazhanu jako Medivhův učeň. Postupně zjistil, že jeho mistr je posedlý Sargerasem. Spolu s Anduinem Lotharem a Garonou Medivha ve věži zabili.

• Aegwynn – Medivhova matka, předchozí Strážkyně, kdysi porazila Sargerase. Netušila, že duch démona se ukryl v jejím synovi.

• SPOILER (The Burning Crusade) – Karazhan se stane raidem pro deset hráčů. Uvidíš hostiny duchů, divadlo, šachy a samotného Medivhova démona.]]
WoWpoCesku_LoreTajemstvi["Deadwind Pass"] = [[• Karazhan – v klasice byla věž zavřená. Pod ní jsou krypty, které hráči léta prozkoumávali a hledali tajné chodby.

• Ariden's Camp – tábor tajemného Aridena na jihu kraje.

• Grosh'gok Compound – ogří tábor v horách.

• Deadman's Crossing – rozcestí, kde začínají cesty do Duskwoodu i Swamp of Sorrows.

• Jezero pod Karazhanem – nejlepší místo, odkud je vidět věž v celé výšce.

• Žádní vzácní mobové tu nejsou – jen duchové a ticho.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

-------------------------------------------------------------------------------
-- Kalimdor – střed a sever
-------------------------------------------------------------------------------

WoWpoCesku_Lore["The Barrens"] = {
    title = "The Barrens",
    tag = "Nekonečná savana, kde je cesta dlouhá, slunce pálí a chat se nikdy nezastaví.",
    ch = {
        { "Savana", [[The Barrens jsou obrovská vyprahlá savana uprostřed Kalimdoru. Žlutá tráva, akácie, termitiště a ojedinělé oázy – a mezi nimi stáda zeber, žiraf a kodo. Je to největší kraj klasického WoW a pro mnoho hráčů Hordy první opravdová cesta do světa.]] },
        { "Crossroads a Ratchet", [[Uprostřed kraje stojí The Crossroads, orkská pevnost na křižovatce cest z Orgrimmaru, Mulgore a jihu. Na pobřeží leží Ratchet, goblinský přístav, odkud pluje loď do Booty Bay. Na jihu mají taureni Camp Taurajo.]] },
        { "Oázy a Wailing Caverns", [[Oázy napájí voda z puklin u Wailing Caverns. Druid Naralex chtěl silou Smaragdového snu celou savanu znovu zazelenat – kdysi tu totiž byl les, který zničila válka a Velké rozpoltění. Ve Wailing Caverns se ale jeho sen proměnil v noční můru a z jeskyní se šíří zkažená příroda. Jeho žáci, Druidové Fangu, se z dobrých léčitelů stali zlými.]] },
        { "Hrozby", [[Kentauři Kolkar, kančí lidé quilboar z Razorfen, harpyje, Venture Company, Bael'dunští trpaslíci a lidé z Northwatch Hold, kteří se připravují k útoku na Hordu.]] },
    },
}
WoWpoCesku_LoreKnihy["The Barrens"] = [[• Thrallova cesta (Warcraft III) – orkové táhli přes Barrens, když hledali Orákulum na hoře Stonetalon. Grom Hellscream tu postavil předsunutou základnu proti nočním elfům.

• Quilboar a Agamaggan – kančí lidé uctívají poloboha Agamaggana, obřího kance, který zemřel za Války starověku. Z jeho trnitých kořenů vyrostly Razorfen Kraul a Razorfen Downs.

• Northwatch Hold – pevnost lidí z Kul Tiras, kteří přišli s admirálem Proudmoorem. Po jeho smrti zůstali a dál bojují proti Hordě.]]
WoWpoCesku_LoreTajemstvi["The Barrens"] = [[• Kde je Mankrikova žena? – ork Mankrik v Crossroads tě v questu Lost in Battle prosí, abys našel jeho ženu Olgru. Spolu bojovali s kančími lidmi Bristleback a v boji se rozdělili. Hráči ji hledali tak dlouho, že se z otázky „Where is Mankrik's wife?“ stal jeden z nejstarších memů v historii her.
  Nápověda (spoiler): z Crossroads jdi na jih přes most u stezky z Lushwater Oasis. Na západní straně uvidíš dvě chatrče – před jednou z nich leží Beaten Corpse (zhruba 49, 50). Olgra už nežije.
  Do budoucna: v Cataclysm Mankrik Olgru konečně pohřbí a v Hearthstone má vlastní legendární kartu s popiskem, že svou noční můru prožívá znovu pokaždé, když vznikne nová postava Hordy.

• Sada „Blessing of Kalimdor“ (novinka WoW Forever) – vzácní mobové tu padají kusy sady (plášť, prsten, náhrdelník). Už dva kusy dají +5 % rychlosti pohybu v Barrens a Stonetalon Mountains. Padají z Humar the Pridelord, Swiftmane a Takk the Leaper – proto se je vyplatí lovit.

• Wailing Caverns – dungeon jihozápadně od Crossroads. Naralexovi žáci, Druidové Fangu, propadli Smaragdové noční můře a z jeskyní se šíří zmutovaní „deviate“ tvorové. Na konci můžeš s Disciple of Naralex probudit Naralexe.

• Barrens chat – kanál General v Barrens byl proslulý nekonečnými hloupými debatami, vtipy o Chucku Norrisovi a otázkami na Mankrikovu ženu.

• Ratchet – neutrální goblinský přístav. Loď odtud pluje do Booty Bay a v přístavu se potkávají obě frakce.

• Field of Giants – na jihu leží obří kosti a fosilie, které zkoumají badatelé.

Zdroj: Warcraft Wiki, Wowhead (classic), wowclassicforever.info a foreverdb.net.]]

WoWpoCesku_Lore["Darkshore"] = {
    title = "Darkshore",
    tag = "Mlhavé pobřeží, kde se noční elfové snaží udržet poslední pevnosti své dávné slávy.",
    ch = {
        { "Pobřeží v šeru", [[Darkshore je dlouhé pobřeží s tmavými lesy a mlhou na severozápadě Kalimdoru. Moře je tu studené, noci dlouhé a v lesích jsou ruiny elfích měst z doby, kdy noční elfové vládli celému světu.]] },
        { "Auberdine", [[Hlavní osadou je Auberdine, malé elfské městečko s přístavem. Lodě odtud plují do Teldrassilu, Stormwindu a Menethil Harbor. Je to brána, kterou noční elfové vycházejí do světa.]] },
        { "Ruiny", [[Ameth'Aran, Bashal'Aran a další ruiny jsou pozůstatky měst z doby před Velkým rozpoltěním. V některých stále straší duchové Highborne, kteří nedokázali opustit svou minulost.]] },
        { "Hrozby", [[Kult Twilight's Hammer zkazil furbolgy z kmene Blackwood. Murlokové, nagové, satyrové a zdivočelí medvědi. V lesích se objevují pavouci a v ruinách duchové.]] },
    },
}
WoWpoCesku_LoreKnihy["Darkshore"] = [[• Highborne a jejich duchové – po Velkém rozpoltění zůstaly ruiny Highborne opuštěné. Duchové některých z nich ještě dnes kouzlí a šíří prokletí.

• Twilight's Hammer – kult, který uctívá Staré bohy a chce zničení světa. SPOILER: v budoucnu (Cataclysm) se kult spojí s Deathwingem.

• SPOILER (Cataclysm a Battle for Azeroth) – Darkshore bude zničen kataklyzmatem a později vypálen Hordou při válce o Teldrassil.]]
WoWpoCesku_LoreTajemstvi["Darkshore"] = [[• For Love Eternal – druid Cerellean Whiteclaw v Auberdine truchlí pro svou lásku Anayu Dawnrunner, která zahynula při zkáze Ameth'Aran za Války starověku. Její duch v ruinách stále bloudí – osvoboď ho a přines Cerelleanovi její přívěsek. Smutný milostný příběh starý deset tisíc let (v pozdějších verzích WoW zmizel).

• Prospector Remtravel – gnómský badatel, který tvrdí, že našel něco úžasného. Jeho řada končí překvapením.

• Tower of Althalaxx – věž, kde kult Twilight's Hammer provádí rituály.

• Grove of the Ancients – háj, kde odpočívají Ancients, živé stromy.

• Cliffspring Falls – vodopád na severu s jeskyní nag.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Ashenvale"] = {
    title = "Ashenvale",
    tag = "Prastarý les nočních elfů, kde Horda kácí stromy a kde zemřel polobůh.",
    ch = {
        { "Les, který pamatuje", [[Ashenvale je hustý, věčně soumračný les fialových a modrých stromů na severu Kalimdoru. Pro noční elfy je posvátný. Ve stínu stromů jsou měsíční studny, ruiny a háje, kde žijí dryády a Ancients.]] },
        { "Astranaar a Splintertree", [[Astranaar je elfí osada na ostrově v jezeře Mystral. Horda má Splintertree Post na východě a Warsong Lumber Camp, kde orkové kácejí stromy – což elfové považují za válečný zločin.]] },
        { "Srdce lesa", [[Raynewood Retreat je obydlí dryád a Cenariových dětí. V hlubinách lesa, na pobřeží Zoram Strand, leží Blackfathom Deeps, chrám, kde Twilight's Hammer uctívá Staré bohy.]] },
        { "Hrozby", [[Satyrové, furbolgové Thistlefur a Foulweald, démoni, nagové, kultisté a orkové z Warsongu.]] },
    },
}
WoWpoCesku_LoreKnihy["Ashenvale"] = [[• Smrt Cenaria (Warcraft III) – orkové pod Gromem Hellscreamem začali kácet stromy. Polobůh Cenarius se postavil na obranu lesa. Grom vypil krev Mannorotha a Cenaria zabil.

• Smrt Mannorotha – Thrall a Jaina Groma osvobodili. Grom Mannorotha zabil v Demon Fall Canyon a sám zemřel. Je to místo, kde Horda získala svobodu.

• War of the Ancients – Ashenvale je zbytkem pravěkého lesa, který obklopoval Studnu věčnosti. Mnohé ruiny pamatují Azsharu.]]
WoWpoCesku_LoreTajemstvi["Ashenvale"] = [[• Demon Fall Canyon – kaňon, kde Grom Hellscream zabil Mannorotha a sám zemřel. Na dně leží Mannorothova obří zbroj.

• Warsong Gulch – bitevní pole o vlajky mezi elfy a orky.

• Blackfathom Deeps – dungeon na Zoram Strand, kde kult Twilight's Hammer uctívá Staré bohy. Na konci Aku'mai.

• Raynewood Retreat – obydlí dryád a Cenariových dětí.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Stonetalon Mountains"] = {
    title = "Stonetalon Mountains",
    tag = "Hory, kde goblini kácejí lesy a kde Thrall našel svého proroka.",
    ch = {
        { "Kamenné hory", [[Stonetalon Mountains jsou vysoké, skalnaté hory západně od Barrens. Na vrcholcích leží zelené údolí Stonetalon Peak, posvátné pro druidy, a pod ním vyhořelé údolí Charred Vale.]] },
        { "Kdo tu žije", [[Horda má Sun Rock Retreat, tauren osadu ve skalách. Noční elfové drží Stonetalon Peak. Venture Company tu kácí lesy ve Windshear Crag a ničí krajinu tak rychle, jak jen mohou.]] },
        { "Orákulum", [[Na vrcholu hory čekalo Orákulum – tajemný prorok, který vedl Thralla i Jainu na Kalimdor. Byl to Medivh, který se vrátil z mrtvých, aby napravil své chyby.]] },
        { "Hrozby", [[Venture Company, harpyje, kentauři Kolkar, elementálové a obří pavouci.]] },
    },
}
WoWpoCesku_LoreKnihy["Stonetalon Mountains"] = [[• Medivh jako prorok (Warcraft III) – po smrti se Medivh vrátil jako prorok v podobě havrana. Varoval lidi i orky před Plamennou legií a vedl je na Kalimdor. Na hoře Hyjal pak spolu bojovali proti Archimondovi.

• Venture Company – goblinská obchodní společnost, která ničí přírodu za zisk. Patří k nejstarším nepřátelům v klasickém WoW.

• SPOILER (Cataclysm) – Stonetalon zasáhne bomba Hordy a Windshear Crag shoří.]]
WoWpoCesku_LoreTajemstvi["Stonetalon Mountains"] = [[• Sada Blessing of Kalimdor (novinka WoW Forever) – sada ze vzácných mobů z Barrens dává +5 % rychlosti i tady ve Stonetalonu.

• Nové předměty ve Forever: z Taskmaster Whipfang padá dýka Whipfang's Skinsearer, z Foreman Rigger kroužková helma Foreman's Helm.

• Stonetalon Peak – nejvyšší místo kraje s hájem druidů. Kdysi tu Orákulum radilo Thrallovi.

• Talondeep Path – tunel pod horami z Ashenvale do Stonetalonu.

• Windshear Crag – lesy, které kácí Venture Company.

• Malaka'jin – trollí vesnička Hordy na jihu kraje.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Thousand Needles"] = {
    title = "Thousand Needles",
    tag = "Kaňon tisíce skalních jehel, kde taureni žijí na vrcholcích a goblini pořádají závody.",
    ch = {
        { "Kaňon jehel", [[Thousand Needles je obrovský kaňon plný vysokých skalních pilířů – jehel – na jihu Barrens. Na vrcholcích jehel žijí taureni a ptáci, dole se prohánějí kentauři a ještěři.]] },
        { "Freewind Post", [[Taureni z Freewind Post žijí na vrcholcích jehel, propojených provazovými mosty. Je to jedno z nejkrásnějších míst Hordy – a nejlepší místo na výhled.]] },
        { "Shimmering Flats", [[Na východě je vyschlé solné jezero Shimmering Flats, kde goblini a gnómové pořádají závody na Mirage Raceway. Soupeří, kdo má rychlejší auto.]] },
        { "Hrozby", [[Kentauři Galak, Grimtotem taureni, harpyje, štíři a quilboar z Razorfen Downs.]] },
    },
}
WoWpoCesku_LoreKnihy["Thousand Needles"] = [[• Grimtotem – kmen taurenů, kteří odmítají spojenectví s Hordou. Vede je Magatha Grimtotem z Thunder Bluff. Chtějí, aby taureni byli samostatní – a sami chtějí vládnout Mulgore.

• Razorfen Downs – kančí lidé tu spolupracují s Pohromou. Lich Amnennar the Coldbringer se je snaží převést na nemrtvé.

• SPOILER (Cataclysm) – Thousand Needles zaplaví voda a kaňon se promění v jezero s ostrovy.]]
WoWpoCesku_LoreTajemstvi["Thousand Needles"] = [[• Mirage Raceway – na solném jezeře Shimmering Flats spolu závodí gnómové a goblini. Questy ti dovolí pomoct jednomu z týmů.

• Freewind Post – tauren osada na vrcholcích jehel s provazovými mosty. Nejlepší výhled v kraji.

• Razorfen Downs – dungeon na severu, kde lich Amnennar the Coldbringer převádí kančí lidi k Pohromě.

• Highperch – hnízdiště wyvern na západě.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Desolace"] = {
    title = "Desolace",
    tag = "Šedá pustina kentaurů, démonů a kostí – kraj, který se zdá mrtvý, ale není.",
    ch = {
        { "Pustina", [[Desolace je šedá, vyprahlá pustina na západě Kalimdoru. Nebe je zatažené, země prasklá a po krajině leží obří kosti. Není tu nic krásného – ale je tu spousta příběhů.]] },
        { "Kentauři", [[Kentauři z pěti klanů (Gelkis, Magram, Kolkar, Galak a Maraudine) tu žijí a válčí mezi sebou. Pro hrdiny je to šance – pomoct jednomu klanu proti druhému.]] },
        { "Kdo tu žije", [[Aliance drží Nijel's Point na severu, Horda Shadowprey Village na pobřeží. Kodo Graveyard uprostřed je hřbitovem obřích kodo.]] },
        { "Hrozby", [[Kentauři, démoni v Mannoroc Coven, Burning Blade v Thunder Axe Fortress, satyrové, nagové a obří štíři.]] },
    },
}
WoWpoCesku_LoreKnihy["Desolace"] = [[• Zrození kentaurů – Zaetar, syn Cenaria, se zamiloval do Theradras, princezny živlu země. Jejich děti byly kentauři – a zabili svého otce. Theradras pohřbila Zaetara v Maraudonu a dodnes tam truchlí.

• Maraudon – hluboké jeskyně plné krystalů a zkažené přírody. Theradras je na konci dungeonu.

• Rexxar – v klasickém WoW se po silnici Desolace potuluje Rexxar, poloviční ork a poloviční ogr se svou medvědicí Mishou. Je to hrdina z Warcraftu III (The Frozen Throne).]]
WoWpoCesku_LoreTajemstvi["Desolace"] = [[• Kodo Graveyard – goblin Smeed Scrabblescrew ti dá kouzlo na zkrocení umírajících kodo (Kodo Roundup). Vtipný a trochu smutný quest.

• Maraudon – jeskyně, kde princezna Theradras truchlí za Zaetarem. Fialová a oranžová cesta vedou ke stejnému cíli.

• Kentauří klany – Gelkis a Magram spolu válčí a ty si můžeš vybrat stranu. Reputace u jednoho klanu ti udělá nepřítele z druhého.

• Rexxar – po silnici mezi Stonetalonem a Feralasem se potuluje poloviční ork a ogr Rexxar s medvědicí Mishou, hrdina z Warcraft III. Pro Hordu je součástí řady questů The Champion of the Horde, která vede k Onyxii.

• Mannoroc Coven – démonický kráter na jihu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Dustwallow Marsh"] = {
    title = "Dustwallow Marsh",
    tag = "Bažina mezi Theramore a Onyxiiným doupětem, kde se Jaina snaží udržet mír.",
    ch = {
        { "Bažiny", [[Dustwallow Marsh jsou tmavé bažiny na východním pobřeží Kalimdoru. Mlha, kroutící se kořeny, krokodýli a žáby. Na pobřeží stojí lidské město Theramore.]] },
        { "Theramore", [[Theramore založila Jaina Proudmoore po Třetí válce. Je to přístav, kde lidé a orkové žijí v míru – nebo aspoň v příměří. Jaina tu vládne jako lady a snaží se udržet mír s Thrallem.]] },
        { "Kdo tu žije", [[Horda má Brackenwall Village, vesnici Darkspear trollů. V bažinách žijí murlokové, ještěři, ogři a draci. Na jihu leží Onyxia's Lair, doupě dračice Onyxie.]] },
        { "Hrozby", [[Draci a drakonidi, ogři z Stonemaul, murlokové, krokodýli a pavouci. A pak je tu Witch Hill s čarodějnicemi.]] },
    },
}
WoWpoCesku_LoreKnihy["Dustwallow Marsh"] = [[• Cycle of Hatred – kniha o tom, jak se mezi Theramore a Durotarem udržuje křehký mír. Kult Burning Blade se ho snaží zničit.

• Smrt Daelina Proudmoora – Jainin otec, admirál Kul Tiras, zaútočil na Durotar. Jaina se postavila na stranu Thralla a admirál padl. Jaina si to nikdy neodpustila.

• Onyxia – SPOILER: dračice v lidské podobě je Lady Prestor ve Stormwindu. Její doupě je raid v jižní části bažin.

• SPOILER (Mists of Pandaria) – Theramore zničí Horda pod Garroshem bombou many.]]
WoWpoCesku_LoreTajemstvi["Dustwallow Marsh"] = [[• Onyxia's Lair – raid na jihu. Slavná hláška „Many whelps! Handle it!“ pochází odtud.

• The Missing Diplomat – dlouhá řada questů, která začíná ve Stormwindu a vede přes Theramore. Pátráš po zmizelém diplomatovi a narazíš na zradu.

• Shady Rest Inn – vyhořelý hostinec na cestě. Za jeho zkázou je příběh, který odhalí questy v okolí.

• Alcaz Island – ostrov u pobřeží Theramore. Ve WoW Forever tu má vzniknout nový dungeon Alcaz Prison (levely 48–53), který navazuje na příběh Defias.

• Witch Hill – kopec s čarodějnicemi a opuštěným sídlem Swamplight Manor na severu.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Feralas"] = {
    title = "Feralas",
    tag = "Deštný prales obrů, kde se v ruinách elfího města skrývá prastará magie.",
    ch = {
        { "Prales", [[Feralas je zelený deštný prales s obřími stromy na jihozápadě Kalimdoru. Pršelo tu vždycky a prší pořád. V hloubi lesa jsou ruiny elfích měst a dvě obří sochy, Twin Colossals.]] },
        { "Kdo tu žije", [[Aliance drží Feathermoon Stronghold na ostrově u pobřeží. Horda má Camp Mojache, tauren tábor ve vnitrozemí. Grimtotem a ogři Gordunni žijí v lesích.]] },
        { "Dire Maul", [[Uprostřed lesa leží Dire Maul – ruiny Eldre'Thalas, města Highborne, kteří přežili Velké rozpoltění. Uvnitř je ještě několik Highborne naživu a drží uvězněného démona.]] },
        { "Hrozby", [[Ogři Gordunni, Grimtotem, yetiové, obří hydry, satyrové, nagové a Woodpaw gnollové.]] },
    },
}
WoWpoCesku_LoreKnihy["Feralas"] = [[• Eldre'Thalas – po Velkém rozpoltění se část Highborne ukryla v Eldre'Thalas. Aby udrželi svou magii, uvěznili démona Immol'thara a čerpali z něj sílu. Jejich princ Tortheldrin vládne zbytku.

• Spojení s shen'dorei – jiní Highborne se podle Forever dostali do nebe. Dire Maul je kanonický příklad Highborne, kteří zůstali na zemi.

• Isle of Dread – ostrov u pobřeží, kde žijí chiméry Chimaerok a jeden ze čtyř stromů snu.]]
WoWpoCesku_LoreTajemstvi["Feralas"] = [[• Dire Maul – ruiny elfího města Eldre'Thalas se třemi křídly. V severní části můžeš projít bez zabití stráží („tribute run“) a získat poklad od krále ogrů.

• OOX-22/FE – porouchané robotické kuře v kraji. Spolu s dalšími dvěma (Tanaris a Hinterlands) tě dovede k mechanickému kuřeti jako mazlíčkovi.

• Dream Bough a Isle of Dread – jeden ze čtyř stromů snu a ostrov chimér Chimaerok.

• Twin Colossals – obří sochy uprostřed lesa.

• Feathermoon Stronghold – elfí pevnost na ostrově, sídlo Shandris Feathermoon.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Azshara"] = {
    title = "Azshara",
    tag = "Podzimní pobřeží zničené královny, kde jsou ruiny, satyrové a modří draci.",
    ch = {
        { "Věčný podzim", [[Azshara je kraj s rudými a zlatými stromy na severovýchodě Kalimdoru. Je pojmenovaná po královně Azsharé a kdysi tu stálo hlavní město Highborne. Dnes jsou tu ruiny, satyrové a nagové.]] },
        { "Ruiny", [[Ruiny Eldarath, Temple of Zin-Malor a další stavby připomínají slávu Highborne. Moře na východě skrývá ruiny potopeného města.]] },
        { "Kdo tu žije", [[Horda má Valormok, malý tábor. Noční elfové drží Talrendis Point. Modří draci žijí u Lake Mennar a Azuregos, obří modrý drak, se potuluje po kraji.]] },
        { "Hrozby", [[Satyrové Haldarr, nagové, harpyje, modří draci, obři a Timbermaw furbolgové.]] },
    },
}
WoWpoCesku_LoreKnihy["Azshara"] = [[• Královna Azshara – před deseti tisíci lety byla nejkrásnější a nejmocnější bytostí na světě. Pozvala Plamennou legii, aby jí pomohla „očistit“ svět. Když Studna explodovala, Azshara se se svými Highborne potopila do moře a stala se královnou nagů.

• SPOILER (Battle for Azeroth) – Azshara se vrátí a hrdinové s ní budou bojovat v Nazjatar.

• Azuregos – modrý drak, který chrání magické artefakty. V klasice je to world boss.]]
WoWpoCesku_LoreTajemstvi["Azshara"] = [[• Azuregos – obří modrý drak, world boss klasického WoW. Když ho najdeš, zavolej přátele.

• Duke Hydraxis – na ostrově u východního pobřeží sídlí vodní elementál, který posílá hrdiny proti Ragnarosovým služebníkům (příprava na Molten Core).

• Kim'jael – goblin v kraji, který ztratil své vybavení. Quest Kim'jael Indeed! je drobná komedie.

• Ruins of Eldarath – sochy a nápisy Highborne.

• Bay of Storms – zátoka, kde kdysi ležel okraj Studny věčnosti.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Moonglade"] = {
    title = "Moonglade",
    tag = "Posvátné údolí druidů, kde se všichni setkávají v míru.",
    ch = {
        { "Údolí míru", [[Moonglade je malé, klidné údolí na severu Kalimdoru, obklopené horami. Je posvátné pro druidy a je to neutrální území – ani Aliance, ani Horda tu nebojují.]] },
        { "Nighthaven", [[Nighthaven je vesnice Cenarion Circle, kruhu druidů. Žijí tu noční elfové i taureni a učí se spolu. Remulos, syn Cenaria, tu bdí nad svatyní.]] },
        { "Barrow Dens", [[Pod Moonglade leží Stormrage Barrow Dens, kde druidové spí a sní ve Smaragdovém snu. Malfurion Stormrage tu odpočívá – a nevrací se.]] },
        { "Hrozby", [[Téměř žádné – jen občasní satyrové z Felwoodu a zlý sen, který se plíží.]] },
    },
}
WoWpoCesku_LoreKnihy["Moonglade"] = [[• Malfurion ztracený ve snu – Malfurion se ponořil do Smaragdového snu a nevrátil se. SPOILER: uvěznila ho tam Noční můra. V knize Stormrage se konečně probudí.

• Cenarion Circle – kruh druidů, kteří chrání přírodu. Vede ho Remulos a Fandral Staghelm v Darnassu.

• Lunar Festival – každý rok o Lunárním festivalu se v Moonglade slaví Elune a předkové.]]
WoWpoCesku_LoreTajemstvi["Moonglade"] = [[• Druidský teleport – druidové mají kouzlo, které je okamžitě přenese do Moonglade.

• Lunar Festival – při festivalu přicházejí do Moonglade hráči obou frakcí a po celém světě se hledají Elders.

• Shrine of Remulos – svatyně Remula na severu údolí.

• Stormrage Barrow Dens – podzemí, kde druidové spí ve Smaragdovém snu. Odpočívá tu i Malfurion.

• Lake Elune'ara – posvátné jezero uprostřed údolí.

• Žádní vzácní mobové tu nejsou – Moonglade je místo míru.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

-------------------------------------------------------------------------------
-- Kalimdor – jih a sever
-------------------------------------------------------------------------------

WoWpoCesku_Lore["Tanaris"] = {
    title = "Tanaris",
    tag = "Písečná poušť, kde goblini prodávají vodu a draci hlídají samotný čas.",
    ch = {
        { "Poušť", [[Tanaris je nekonečná poušť zlatého písku na jihovýchodě Kalimdoru. Duny, kaktusy, vyschlé kosti a slunce, které nepromine. Kdysi tu byla moře a lesy; dnes jen písek a ruiny.]] },
        { "Gadgetzan", [[Uprostřed pouště stojí Gadgetzan, goblinské město kartelu Steamwheedle. Je neutrální, takže se tu potkávají hráči obou frakcí. Goblini tu čerpají vodu z hlubin a prodávají ji dráž než zlato.]] },
        { "Caverns of Time", [[Na východě leží Caverns of Time, jeskyně bronzových draků. Jejich vládce Nozdormu hlídá tok času, aby ho nikdo nezměnil. Draci jsou tajemní a do jeskyní nikoho nepouštějí.]] },
        { "Hrozby", [[Trollové Sandfury ze Zul'Farraku, bandité Wastewander, piráti z Lost Rigger Cove, silithidi, obří štíři, hyeny a písečné bouře.]] },
    },
}
WoWpoCesku_LoreKnihy["Tanaris"] = [[• Bronzoví draci – Nozdormu dostal od titánů úkol hlídat čas. Zná budoucnost i svou vlastní smrt. SPOILER: z jeho strachu z vlastní smrti vznikne Infinite Dragonflight, draci, kteří chtějí čas změnit.

• Zul'Farrak – trollové Sandfury uctívají boha Gahz'rillu, obří hydru. Jejich město je jedno z mála trollích měst, které dodnes stojí.

• SPOILER (The Burning Crusade a Cataclysm) – Caverns of Time se otevřou a hrdinové se vrátí do minulosti: k Thrallovu útěku, k Temnému portálu, na Hyjal i ke Stratholme. Na jihu se otevře Uldum.]]
WoWpoCesku_LoreTajemstvi["Tanaris"] = [[• OOX-17/TN – porouchané robotické kuře v poušti. Doprovoď ho domů a spolu s dalšími dvěma (Feralas a Hinterlands) získáš od Oglethorpa Obnoticuse v Booty Bay mechanické kuře.

• Tooga – ztracená želva, kterou doprovodíš k její družce. Pomalá, ale roztomilá.

• Uldum – na jihu stojí obrovská zeď se zavřenou branou titánů. V klasice byla neprostupná.

• Zul'Farrak – trollí město, kde gongem přivoláš obří hydru Gahz'rillu.

• Caverns of Time – jeskyně bronzových draků, v klasice zavřené.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Un'Goro Crater"] = {
    title = "Un'Goro Crater",
    tag = "Pravěký kráter plný dinosaurů, kde titáni kdysi zkoušeli, jak stvořit život.",
    ch = {
        { "Ztracený svět", [[Un'Goro Crater je obrovský kráter s džunglí uprostřed pouště. Žijí tu dinosauři – devilsauři, stegodoni a pterodaktylové – a obří rostliny. Je to jako cesta do minulosti.]] },
        { "Zahrada titánů", [[Podle legend titáni Un'Goro používali jako zahradu – laboratoř, kde zkoušeli tvořit život. Krystalové pylony, které tu stojí, jsou pozůstatky jejich zařízení.]] },
        { "Marshal's Refuge", [[Malý tábor uprostřed kráteru, kde žijí badatelé a trosečníci, kteří tu přežili. Zkoumají krystaly a dinosaury a z jeskyně nad táborem je vidět celý kráter.]] },
        { "Hrozby", [[Devilsauři, raptoři, silithidi, ohniví elementálové z Fire Plume Ridge, gorily a obří brouci.]] },
    },
}
WoWpoCesku_LoreKnihy["Un'Goro Crater"] = [[• Titáni a Un'Goro – titáni vytvářeli na Azerothu život a Un'Goro byl jednou z jejich laboratoří. Pylony slouží k ovládání energií v kráteru.

• Silithidi z jihu – hmyzí bytosti z Silithusu se šíří do Un'Goro. Za nimi stojí Qiraji a Starý bůh C'Thun.

• SPOILER (Cataclysm) – Un'Goro souvisí s Uldumem: obě jsou zařízení titánů.]]
WoWpoCesku_LoreTajemstvi["Un'Goro Crater"] = [[• Linken – na severu žije podivný „chlapec“ s mečem a štítem. Je to odkaz na Linka ze Zeldy – v questech padne i hláška „It's dangerous to go alone“.

• A-Me 01 – robot, kterého doprovázíš do bezpečí.

• Ringo – ztracený tvor, kterého musíš cestou polévat vodou, aby neusnul.

• Krystaly a pylony – J.D. Collie v Marshal's Refuge zkoumá energetické krystaly a pylony titánů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Silithus"] = {
    title = "Silithus",
    tag = "Poušť hmyzích bytostí, za jejichž zdí spí Starý bůh.",
    ch = {
        { "Hmyzí poušť", [[Silithus je rudá poušť na jihu Kalimdoru, plná úlů silithidů – obřího hmyzu. Země je rozrytá, z kopců vystupují věže úlů a ve vzduchu bzučí.]] },
        { "Cenarion Hold", [[Cenarion Circle tu má Cenarion Hold, pevnost druidů obou frakcí. Hlídají Scarab Wall – zeď, za kterou je uvězněn Ahn'Qiraj.]] },
        { "Ahn'Qiraj", [[Za Scarab Wall leží Ahn'Qiraj, pevnost Qiraji. Jejich pánem je C'Thun, Starý bůh, který spí pod zemí. Kdysi se pokusil dobýt Kalimdor.]] },
        { "Hrozby", [[Silithidi, Qiraji, Twilight's Hammer kultisté, elementálové a obří brouci.]] },
    },
}
WoWpoCesku_LoreKnihy["Silithus"] = [[• Válka pohyblivých písků (War of the Shifting Sands) – před tisícem let silithidi a Qiraji zaútočili na noční elfy. Fandral Staghelm vedl obranu a ztratil v ní svého syna Valstanna. Draci čtyř barev nakonec Qiraji uzavřeli za Scarab Wall.

• Scepter of the Shifting Sands – žezlo, kterým lze zeď otevřít. Anachronos z bronzových draků ho střeží.

• SPOILER – v klasickém WoW se Ahn'Qiraj otevřel velkou událostí, kdy celý server sbíral suroviny a jeden hráč udeřil do gongu.]]
WoWpoCesku_LoreTajemstvi["Silithus"] = [[• Gong na Scarab Wall – po dlouhé řadě questů může jeden hráč udeřit do gongu a otevřít brány Ahn'Qiraj pro celý server.

• Thunderfury – legendární meč, jehož části padají v Molten Core, se dokončuje tady: Highlord Demitrian tě pošle vyvolat a porazit prince Thunderaana.

• Twilight's Hammer – kultisté vyvolávají elementální pány. S jejich artefakty můžeš vyvolat elementály a bojovat s nimi.

• Hive'Ashi, Hive'Zora, Hive'Regal – úly silithidů.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Felwood"] = {
    title = "Felwood",
    tag = "Les otrávený démony, kde Illidan sežral lebku a stal se něčím jiným.",
    ch = {
        { "Zkažený les", [[Felwood býval částí Ashenvale – krásný les nočních elfů. Za Třetí války sem přišli démoni a les otrávili. Stromy jsou zkřivené, potoky zelené a vzduch je cítit sírou.]] },
        { "Kdo tu žije", [[Aliance drží Talonbranch Glade, Horda Bloodvenom Post. Cenarion Circle má Emerald Sanctuary, kde se snaží les vyléčit. Na severu je Timbermaw Hold, tunel furbolgů do Winterspring a Moonglade.]] },
        { "Jaedenar", [[Na jihu leží Jaedenar, opuštěná elfí svatyně, kterou obsadil Shadow Council – čarodějové, kteří slouží Plamenné legii. Uvnitř drží démona.]] },
        { "Hrozby", [[Satyrové Jadefire, démoni, Shadow Council, zkažení furbolgové Deadwood, zkažení medvědi a vlci, slizy a jedovaté rostliny.]] },
    },
}
WoWpoCesku_LoreKnihy["Felwood"] = [[• Illidan a Lebka Gul'dana (Warcraft III) – Illidan, vězněný deset tisíc let, byl osvobozen Tyrande. V Felwoodu našel Lebku Gul'dana, artefakt plný démonické magie, a vstřebal ji. Stal se napůl démonem, zabil démona Tichondria a byl za to Malfurionem vyhnán.

• Zkáza lesa – Lebka Gul'dana a démoni po bitvě o Hyjal les prokleli.

• Shadow Council – tajná rada čarodějů, kterou kdysi vedl Gul'dan. Pořád existuje a slouží Legii.]]
WoWpoCesku_LoreTajemstvi["Felwood"] = [[• Songflowers – zkažené květiny, které můžeš očistit a získat silný buff Songflower Serenade.

• Whipper Root Tubers a Night Dragon's Breath – léčivé rostliny u zkažených stromů.

• Rescue From Jaedenar – v Shadow Hold je uvězněná elfka Arko'narin. Kdo ji osvobodí, dozví se, co Shadow Council chystá.

• Jaedenar a Shadow Hold – svatyně obsazená čaroději Shadow Council.

• Emerald Sanctuary – útočiště druidů, kteří se snaží les vyléčit.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

WoWpoCesku_Lore["Winterspring"] = {
    title = "Winterspring",
    tag = "Zasněžené údolí pod Hyjalem, kde goblini obchodují a sněhoví levharti loví.",
    ch = {
        { "Sněžné údolí", [[Winterspring je zasněžené horské údolí na severovýchodě Kalimdoru. Sníh tu leží celý rok, jezera jsou zamrzlá a nad krajem se tyčí hora Hyjal se zničeným Světovým stromem.]] },
        { "Everlook", [[Everlook je goblinské městečko, kde se obchoduje se vším. Je to neutrální území, takže se tu potkávají Aliance i Horda.]] },
        { "Kdo tu žije", [[Noční elfové ve Frostsaber Rock cvičí sněhové levharty. Furbolgové Winterfall žijí v lesích. Modří draci sídlí v jeskyni Mazthoril.]] },
        { "Hrozby", [[Furbolgové Winterfall, yetiové, chiméry, sněhoví levharti, modří draci a démoni v Darkwhisper Gorge.]] },
    },
}
WoWpoCesku_LoreKnihy["Winterspring"] = [[• Bitva o Hyjal (Warcraft III) – nad Winterspring, na hoře Hyjal, se odehrála poslední bitva Třetí války. Lidé, orkové a noční elfové bojovali spolu proti Archimondovi. Noční elfové obětovali Nordrassil a Archimonde zahynul.

• Lake Kel'Theril – ruiny u jezera pamatují Highborne, kteří tu žili po Velkém rozpoltění, než odpluli na východ.

• Modří draci – Malygos, aspekt magie, je jejich vůdce. Jeho draci hlídají artefakty v Mazthoril.]]
WoWpoCesku_LoreTajemstvi["Winterspring"] = [[• Frostsaber Rock – noční elfové s Rivern Frostwind cvičí sněhové levharty. Za reputaci získáš vzácný mount.

• Mazthoril – jeskyně modrých draků. Runa hluboko uvnitř tě přenese na vrchol hory k dračici Haleh, ochránkyni doupěte.

• Darkwhisper Gorge – rokle s démony na jihu kraje, odkud vede cesta na Hyjal.

• Everlook – goblinské městečko, kde se potkávají obě frakce.

• Lake Kel'Theril – ruiny u jezera pamatují Highborne.

Zdroj: Warcraft Wiki, Wowhead (classic) a foreverdb.net.]]

-- města a podoblasti nových oblastí
for k, v in pairs({
    ["Undercity"] = "Tirisfal Glades", ["Brill"] = "Tirisfal Glades", ["Deathknell"] = "Tirisfal Glades",
    ["The Sepulcher"] = "Silverpine Forest", ["Pyrewood Village"] = "Silverpine Forest",
    ["Southshore"] = "Hillsbrad Foothills", ["Tarren Mill"] = "Hillsbrad Foothills",
    ["Refuge Pointe"] = "Arathi Highlands", ["Hammerfall"] = "Arathi Highlands",
    ["Menethil Harbor"] = "Wetlands", ["Thelsamar"] = "Loch Modan", ["Lakeshire"] = "Redridge Mountains",
    ["Darkshire"] = "Duskwood", ["Booty Bay"] = "Stranglethorn Vale", ["Grom'gol Base Camp"] = "Stranglethorn Vale",
    ["Aerie Peak"] = "The Hinterlands", ["Chillwind Camp"] = "Western Plaguelands",
    ["Light's Hope Chapel"] = "Eastern Plaguelands", ["Kargath"] = "Badlands", ["Thorium Point"] = "Searing Gorge",
    ["Morgan's Vigil"] = "Burning Steppes", ["Stonard"] = "Swamp of Sorrows", ["Nethergarde Keep"] = "Blasted Lands",
    ["Karazhan"] = "Deadwind Pass",
    ["The Crossroads"] = "The Barrens", ["Ratchet"] = "The Barrens", ["Camp Taurajo"] = "The Barrens",
    ["Auberdine"] = "Darkshore", ["Astranaar"] = "Ashenvale", ["Splintertree Post"] = "Ashenvale",
    ["Sun Rock Retreat"] = "Stonetalon Mountains", ["Freewind Post"] = "Thousand Needles",
    ["Nijel's Point"] = "Desolace", ["Shadowprey Village"] = "Desolace",
    ["Theramore Isle"] = "Dustwallow Marsh", ["Brackenwall Village"] = "Dustwallow Marsh",
    ["Feathermoon Stronghold"] = "Feralas", ["Camp Mojache"] = "Feralas",
    ["Gadgetzan"] = "Tanaris", ["Marshal's Refuge"] = "Un'Goro Crater", ["Cenarion Hold"] = "Silithus",
    ["Everlook"] = "Winterspring", ["Nighthaven"] = "Moonglade",
}) do WoWpoCesku_LoreAlias[k] = v end
