-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: rozšířené příběhy oblastí Azerothu – místa, postavy, zajímavosti a easter eggy.
-- Texty jsou psané vlastními slovy podle Warcraft Wiki (warcraft.wiki.gg); spoilery z pozdějších příběhů jsou označené.
-- Načítá se po DataLore.lua a jen DOPLŇUJE existující kapitoly (nic nepřepisuje).

local D = WoWpoCesku_Lore

local function chapters(zone, list)
    local L = D[zone]
    if not L then return end
    for _, c in ipairs(list) do L.ch[#L.ch + 1] = c end
end

local function secrets(zone, text)
    WoWpoCesku_LoreTajemstvi = WoWpoCesku_LoreTajemstvi or {}
    local old = WoWpoCesku_LoreTajemstvi[zone]
    WoWpoCesku_LoreTajemstvi[zone] = (old and (old .. "\n") or "") .. text
end

-------------------------------------------------------------------------------
-- Mulgore
-------------------------------------------------------------------------------
chapters("Mulgore", {
    { "Místa a jejich příběhy", [[Thunder Bluff je taurenské hlavní město postavené na vysokých mesách a zároveň politické i duchovní srdce země. Bloodhoof Village stojí u jezera Stonebull Lake a poskytuje zázemí i úkoly pro dobrodruhy. Red Cloud Mesa je pod tlakem kanců quilboar z Brambleblade Ravine a v jejím jižním cípu leží Camp Narache, kde se mladí taureni připravují na Great Hunt, svůj obřad dospělosti. Palemane Rock je jeskyně gnollů, kteří čas od času ohrožují okolní osady. Východní důl Venture Co. těží zdroje a přitom znesvěcuje taurenskou půdu. Studny Thunderhorn, Winterhoof a Wildmane jsou důležité zdroje vody, které bývají otravovány nebo obsazovány nepřáteli. Na Bael'dun Digsite pracují trpasličí vykopávky a Red Rocks jsou posvátné místo plné quilboarů.]] },
    { "Lidé, na kterých záleží", [[Cairne Bloodhoof je zakladatel moderní taurenské civilizace. Chief Hawkwind vede Camp Narache a posílá mladé taureny na jejich první dobrodružství. Mull Thunderhorn organizuje čištění studní v Bloodhoof Village, Morin Cloudstalker se soustředí na vyhnání Venture Co. a Dyami Windsoar je průvodce, který připomíná, proč je tahle země pro taureny důležitá.]] },
    { "Zajímavosti", [[• Název Mulgore prý hraje s latinským slovesem mulgere – „dojit“.
• Great Gate má formálně blokovat cestu do Southern Barrens.
• Malá enkláva kmene Dawnchaser sídlí na slunných pláních.
• SPOILER: Po Cataclysmu se tu objevují zvířata se zbraněmi: králíci se sekerami, veverky s přilbami a nože, myši se dvěma pistolemi.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Garrosh Hellscream porazil Cairna v souboji, do kterého ho zmanipulovala Magatha Grimtotem. Cairne zemřel a Magatha se zmocnila Thunder Bluffu; město ale dobyli zpět Baine Bloodhoof a spojenci Hordy. Baine od té doby vládne z High Rise. Po Cataclysmu zpustošil Red Cloud Mesa a quilboarové zesílili; Grimtotem otravovali studny. Pozdější příběhy ukazují i oddíl Venture Co. na útesech východně od Thunder Bluffu.]] },
})

secrets("Mulgore", [[• Název Mulgore připomíná latinské mulgere – „dojit“.
• Camp Narache je místo, kde se mladí taureni připravují na Great Hunt.
• SPOILER: Po Cataclysmu na mesách pobíhají králíci se sekerami a veverky s přilbami.]])

-------------------------------------------------------------------------------
-- Durotar
-------------------------------------------------------------------------------
chapters("Durotar", {
    { "Jak vznikl nový domov", [[Durotar se stal novým domovem Hordy po třetí válce. Válečný náčelník Thrall pojmenoval tuto východní část Kalimdoru po svém zavražděném otci Durotanovi a založil v ní Orgrimmar. Původně tu žily kmeny quilboarů; orkové, taureni a Darkspear trollové je zatlačili a vybudovali prosperující společnost. Region postupně přečkal lidské invaze, vnitřní zrady i živelné pohromy. Podle některých příběhů se orkové usadili v téhle drsné zemi jako pokání za svou minulost – a opravdu připomíná Draenor, jejich původní domov: suchá a nelítostná.]] },
    { "Místa a jejich příběhy", [[Razor Hill je křižovatka a vojenský bod, kolem kterého se točí hodně dění. Sen'jin Village založili Darkspear trollové po vyhnání z Echo Isles čarodějem Zalazanem; ostrovy později dobyli zpět s pomocí druidů a loa. Valley of Trials je místo, kde mladí orkové skládají zkoušky dospělosti. Skull Rock slouží jako sběrné místo, Drygulch Ravine je útočiště hromových ještěrů, kteří ztratili původní les v bojích s klanem Burning Blade, a Thunder Ridge nese stopy ohně, který klan při invazi pustil do lesů. Tiragarde Keep drží lidé z Kul Tiras navzdory tlaku Hordy a Northwatch Foothold je malá aliance pevnůstka, kterou Horda soustavně obtěžuje. Pod Orgrimmarem leží Ragefire Chasm, kde přítomnost troggů naznačuje, že jde možná o starou titánskou stavbu.]] },
    { "Lidé Durotaru", [[Thrall je vizionář, který zemi založil. Nazgrel je jeho generál a velitel ochrany. Vol'jin je hrdina z kmene Darkspear, který později povede povstání proti Garroshovi. Rokhan řídí záležitosti Darkspearů. Jaina Proudmoore je lidská diplomatka, která zabránila katastrofální válce tím, že pomohla Thrallovi proti vlastnímu otci.]] },
    { "Zajímavosti", [[• Obyvatelům se říká „Durotarians“.
• Přes sucho tu je výborná půda; orkové dřív obchodovali s přebytky úrody s lidmi z Theramore za ryby.
• Květina Heart's Ease rozkvétá po dešti jako jarní květiny v dalekém Kun-Lai.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu záplava Southfury River proměnila asi čtvrtinu Durotaru v mokřady a vyhubila hromové ještěry. Garrosh zesílil armádu, spojil se s klanem Dragonmaw a postavil proto-draky u Bladefist Bay. Při obléhání Orgrimmaru vedli Vol'jin a Baine povstání Darkspearů; Garrosh byl poražen a Vol'jin se stal válečným náčelníkem. Ve čtvrté válce Aliance krátce obsadila části Durotaru.]] },
})

secrets("Durotar", [[• Durotar nese jméno Thrallova otce Durotana.
• Heart's Ease je květina, která rozkvétá po dešti.
• Pod Orgrimmarem leží Ragefire Chasm; troggové by mohli značit starou titánskou stavbu.]])

-------------------------------------------------------------------------------
-- Elwynn Forest
-------------------------------------------------------------------------------
chapters("Elwynn Forest", {
    { "Dlouhá historie lesa", [[Příběh Elwynnu sahá do doby kolem roku 1200 před otevřením Temné brány (BDP), kdy potomci arathiské krve přišli z Lordaeronu a založili království Stormwind. V první válce (3 ADP) tudy prošly tisíce orků a obklíčily Stormwind, dokud Knight Champion Anduin Lothar nevedl protiútok, který nepřítele překvapil. Po druhé válce se kraj znovu postavil, ale cech kameníků zůstal nezaplacen – a z toho dluhu vzešlo bratrstvo Defias i vražda královny Tiffin. Do doby, kdy dorazí hrdinové, vlci utekli z temného Duskwoodu a prokletí pavouci vyrostli do obřích rozměrů.]] },
    { "Místa a jejich příběhy", [[Northshire Abbey obnovil arcibiskup Alonsus Faol a je duchovním středem údolí. Goldshire je největší osada kromě Stormwindu, v roce 75 BDP ji napadli gnollové z Redridge a dnes je hlavním shromaždištěm dobrodruhů; sídlí v ní Lion's Pride Inn. Fargodeep Mine a Jasperlode Mine zaplavili kobolti, u obou prý stojí Defiasové. Stonefield Farm a Maclure Vineyards jsou sousedé, kteří se hašteří jako reálné rody Hatfieldů a McCoyů. Eastvale Logging Camp je středisko dřevařského průmyslu, Tower of Azora je samotářská věž mágů, Crystal Lake dostali murlokové, Brackwell Pumpkin Patch dřív ovládali Defiasové a Westbrook Garrison chrání západní hranici před Westfallem.]] },
    { "Postavy a historky", [[Marshal Dughan hlídá pořádek v Goldshiru a na murloky u Stone Cairn Lake vypsal odměnu. Deputy Rainer mu pomáhá. Hogger, vůdce gnollů, byl později uvězněn v Stockade. Eagan Peltskinner řeší každodenní záležitosti osady a zadává úkoly.]] },
    { "Zajímavosti", [[• Ovoce Bimble Longberry pochází z lesů Elwynnu.
• Spor Stonefield Farm a Maclure Vineyards je narážka na skutečný konflikt Hatfieldů a McCoyů.
• V horách nad Northshire stojí malá ovčí farma gnóma Agee Tylera – narážka na zaměstnance Blizzardu jménem Tyler Agee.
• Elwynn se objevil i v díle South Parku „Make Love, Not Warcraft“.
• Goldshire se stal proslulým místem, kde se hráči schází, souboj za soubojem.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu zemětřesení otevřelo průrvu v horách a Blackrock orkové vedení Kurtokem the Slayer vtrhli do Northshire Valley a spálili vinice, než je Aliance zatlačila. V době válce o trny (33 ADP) se uprchlíci z Darnassu rozlili až ke Goldshiru a při „Death Rising“ (35 ADP) zaútočila na Elwynn Plaga, dokud ji nezastavila Stormwindská armáda a Argent Crusade.]] },
})

secrets("Elwynn Forest", [[• Agee Tyler je narážka na zaměstnance Blizzardu Tylera Ageea.
• Spor Stonefield Farm a Maclure Vineyards odkazuje na Hatfieldy a McCoye.
• Elwynn se objevil v South Parku v díle „Make Love, Not Warcraft“.
• Goldshire je legendární místo setkání hráčů.]])

-------------------------------------------------------------------------------
-- Westfall
-------------------------------------------------------------------------------
chapters("Westfall", {
    { "Obilnice království", [[Westfall byl kdysi obilnicí království Stormwind: úrodná pole živila království po staletí. Zemi sice poškodily války s gnolly (75 BDP) a s Gurubashi (18 BDP), ale vždy se zotavila. Zlomový bod přišel po obnově Stormwindu: cech kameníků nebyl zaplacen kvůli dluhům království a lady Katrana Prestor, ve skutečnosti černá dračice Onyxie, manipulovala šlechtu i dělníky a vyvolala nepokoje, při kterých zahynula královna Tiffin Wrynn. Vůdce cechu Edwin VanCleef uprchl do Westfallu, kde se jeho lidé stali Defias Brotherhood – teroristickou organizací, která kraj trápila deset let.]] },
    { "Jak Defiasové ovládli kraj", [[Bratrstvo držel Westfall v hrsti pomocí najatých gnollů, mechanických sklízecích golemů přeprogramovaných k terorizování obyvatel a systematického ničení úrody: pálením polí a solením země. Vzdorovala jen dobrovolná lidová milice pod vedením Gryana Stoutmantlea. Po událostech původní hry porazili dobrodruzi Edwina VanCleefa v Deadmines.]] },
    { "Místa a jejich příběhy", [[Sentinel Hill je velitelství Westfall Brigade, které Defiasové „spálili téměř do základů“ a které se pak znovu postavilo. Moonbrook je největší město, dřív prosperující, později Defiasovo sídlo; vchod do Deadmines je pod stodolou. Furlbrow's Pumpkin Patch je funkční farma s letištěm. Jangolode Mine je opuštěný důl. Saldean's Farm je aktivní farma, která dává ingredience pro questy kolem „Westfall Stew“. The Dagger Hills jsou jižní oblast, kde se sbírá chmel. Gold Coast Quarry se objevuje v komiksu Dark Riders a Westfall Lighthouse v Longshore hlídá duch kapitána Graysona, který verbuje dobrodruhy na ochranu námořníků.]] },
    { "Zajímavosti", [[• Oblast se při vývoji původně jmenovala „Westwood“ – složka s texturami si jméno nese dodnes.
• Vývojáři používali Westfall jako hlavní testovací zónu pro bossy a spawnovali je u Sentinel Tower.
• SPOILER: Raging Chasm, propast vzniklá po Cataclysmu mezi dvěma farmami, je trvalou ranou na krajině.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu přinesla chudoba, bezdomovectví a odliv po Northrendské kampani Defiasům novou sílu pod Edwinovou dcerou Vanessou VanCleef; Sentinel Hill spálila, ale byla poražena. Králem Anduinem Wrynnem uvedené reformy a odškodnění bývalým kameníkům kraj uklidnily a vznikla Breadbasket Guild. V pozdějších příbězích (Dragonflight) zkažený šlechtic Count Clessington zmanipuloval zbylé Defiasy, aby ukradli Drakefire Amulet; Vanessa pochopila, jak snadno šlechta Bratrstvo obrací, a z organizace odešla. Mathias Shaw s ní vyjednal klid v kraji.]] },
})

secrets("Westfall", [[• Původní název zóny byl „Westwood“ – složka textur ho drží dodnes.
• Vývojáři ve Westfallu testovali bosse.
• Deadmines mají vchod pod stodolou v Moonbrooku.
• SPOILER: Raging Chasm je následek Cataclysmu mezi farmami Alexston a Molsen.]])

-------------------------------------------------------------------------------
-- Dun Morogh
-------------------------------------------------------------------------------
chapters("Dun Morogh", {
    { "Ledoví trollové, gnómové a trpaslíci", [[Dun Morogh původně ovládali ledoví trollové Frostmane, kteří se oddělili od Drakkari. Zhruba 3000 let před Dark Portal vyšli z Uldamanu gnómové a usadili se v horách, přežívali díky rozumu. O pět století později z Uldamanu vyšli i trpaslíci, přitahovaní vrcholky, které viděli na obzoru. Postavili Ironforge pod nejvyšší horou, spřátelili se s gnómy a pomohli jim vybudovat Gnomeregan. Trpasličí armády nakonec zničily trollí říši Frostmane a zatlačily trolly do kopců.]] },
    { "Aliance, tramvaj a pád Gnomereganu", [[Za druhé války se oba národy připojily k Alianci Lordaeronu a společně obhájily obě hlavní města. Mezi válkami navrhl High Tinker Gelbin Mekkatorque Deeprun Tram, který spojuje Stormwind s Ironforge. Po zničení Gnomereganu ve třetí válce přeživší gnómové utekli do Ironforge.]] },
    { "Místa a jejich příběhy", [[Coldridge Valley je ochráněné startovní údolí pro úrovně 1–5; je tu Anvilmar, trpasličí kovářská osada, a Whitebeard's Encampment, odkud Grelin Whitebeard posílá nováčky. Kharanos je středisko úkolů; Senir Whitebeard tam vede snahu vymýtit ledové trolly. Ironforge je trpasličí hlavní město zasazené do hory a velké aliance obchodní uzel. Gnomeregan leží v Chill Breeze Valley, dnes zaplavený troggy. Gol'Bolar Quarry je lom plný troggů, Brewnall Village vede Rejold Barleybrew, který hledá nové recepty piva, a New Tinkertown je gnómská osada v Chill Breeze Valley po vyhnání z Gnomereganu. Frostmane Hold zůstává trollím sídlem.]] },
    { "Rada tří kladiv", [[Muradin Bronzebeard zastupuje v Radě tří kladiv (Council of Three Hammers) trpaslíky z Ironforge, Moira Thaurissan Dark Iron a Falstad Wildhammer trpaslíky Wildhammer. Gelbin Mekkatorque je vůdce gnómů a dřívější High Tinker. Magni Bronzebeard je bývalý vládce Ironforge.]] },
    { "Zajímavosti", [[• Dun Morogh byl původně plánován jako jedna zóna spolu s Loch Modan.
• Na skryté plošině na západě zní od roku 2014 hlášená „velmi strašidelná“ vyjící ozvěna – hráči se dohadují, jestli jde o chybu, nebo záměr.
• Newman's Landing je malé molo se třemi gobliny z Booty Bay, které není na mapě a má jiné počasí než zbytek zóny.
• Beran z Ironforge byl prý prvním domestikovaným beranem, který si dwarvové vypěstovali po usazení.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu se zvýšil tlak troggů a ledových trollů; do Dun Morogh vtrhla i Plaga a Plamenná legie. Ta byla poražena společnou silou Aliance, Hordy a Illidari – což je u frakčně oddělených oblastí vzácné.]] },
})

secrets("Dun Morogh", [[• Na skryté plošině na západě prý zní strašidelné vytí (souřadnice zhruba 25, 60).
• Newman's Landing není na mapě; sedí tam tři gobliní z Booty Bay.
• Dun Morogh byl původně jedna zóna s Loch Modanem.]])

-------------------------------------------------------------------------------
-- Teldrassil
-------------------------------------------------------------------------------
chapters("Teldrassil", {
    { "Strom, který měl nahradit Nordrassil", [[Když Malfurion Stormrage uvízl ve Smaragdovém snu (21 ADP), vedl arcidruid Fandral Staghelm snahu vypěstovat nový Světový strom. Circle of Ancients a druidové spojili síly a vypěstovali v moři Veiled Sea obrovský strom, který pojmenovali Teldrassil, „Koruna země“ v darnašštině. Nozdormu ale na rozdíl od Nordrassilu Teldrassil nepožehnal: viděl v přání nočních elfů arogantní touhu a odmítl jim vrátit nesmrtelnost. Noční elfové tak žijí na Světovém stromě, ale zůstali smrtelní.]] },
    { "Zkažená větev", [[Strom nakazil Fandral, který do jeho kořenů zasadil větev poskvrněnou démonem Xaviem a propojil ho tak s Emerald Nightmare. Malfurion zkázu později odstranil a Alexstrasza s Ysérou strom požehnaly, aby ho chránily až do jeho zničení.]] },
    { "Místa a jejich příběhy", [[Darnassus je noční elfí hlavní město v koruně stromu. Shadowglen je ochráněné startovní údolí pro úrovně 1–5. Dolanaar je vesnice, kde Tallonkai Swiftroot organizuje obranu proti zkaženým tvorům. Rut'theran Village je dopravní uzel s portálem do Darnassu a loděmi na pevninu. Ban'ethil Barrow Den je doupě zkažených furbolgů v Ban'ethil Hollow, u Lake Al'Ameth zkoumá nemoc stromu Denalan, Starbreeze Village zasáhla zkáza a Wellspring Lake i River živí rosa ze Světového stromu. Gnarlpine Hold je pevnost zkažených furbolgů a Pools of Arlithrien jsou přírodní jezírka v lese.]] },
    { "Zajímavosti", [[• Zóna je plochá kvůli omezením enginu: Chris Metzen chtěl, aby ve hře bylo vidět, že jde o obří strom, ale vývojáři tehdy nedokázali obří 3D strom prosadit přes technologii výškových map.
• Původní jméno ostrova bylo „Kalidar“; v souborech hry zůstala mapa nepoužitého battlegroundu Kalidar.
• Přípona „-drassil“ vychází z Yggdrasilu z nordické mytologie.
• Pine Nut Bread bývá tvarován jako list na počest Teldrassilu.
• V Teldrassilu nejsou žádné rudy; noční elfové nejsou známí kovářstvím ani těžbou.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Ve válce o trny (33 ADP) vypálili Teldrassil vojáci Hordy pod velením Sylvanas Windrunner pomocí demolishers s arkánně posílenou náloží, zatímco šamani v Darkshore vytvořili vítr, který oheň rozdmýchal. Byl to největší požár, jaký Azeroth viděl. Stovky nočních elfů uprchly do Darnassu, přeživší unikli portály do Stormwindu a usadili se u Olivia's Pond; další odplula na Azuremyst Isle. Po příměří (34 ADP) trosky stromu stále doutnaly a v roce 40 ADP Tyrande prohlásila, že noční elfové se vrátí a postaví nový domov v Bel'ameth na Dragon Isles, až se k pobřeží Teldrassilu vrátí život.]] },
})

secrets("Teldrassil", [[• Původní jméno ostrova bylo Kalidar; existuje nepoužitý battleground Kalidar.
• Přípona -drassil odkazuje na Yggdrasil z nordické mytologie.
• Zóna je plochá, protože engine nezvládl obří strom.
• V Teldrassilu nejsou žádné rudy.
• SPOILER: Teldrassil shořel ve válce o trny.]])

-------------------------------------------------------------------------------
-- Tirisfal Glades
-------------------------------------------------------------------------------
chapters("Tirisfal Glades", {
    { "Tyr's Fall: pád strážce", [[Tirisfal se jmenuje podle titánského strážce Tyra, který padl v boji proti C'Thraxovi generálu Zakajzovi; ve vrykulském jazyce se místo jmenovalo „Tyr's Fall“, později zkráceně Tirisfal. Kolem tohoto místa se podle příběhu vyvinulo lidstvo z prokletých vrykulských potomků a založilo království Lordaeron. Pod zemí se prý míchají energie Tyra i Zakajze.]] },
    { "Od království k Forsaken", [[Po třetí válce se oblast proměnila: její lidé byli zabiti a povstali jako nemrtví otroci Lich Kinga. Forsaken později Tirisfal prohlásili za svůj domov a pod ruinami Lordaeronu vybudovali Undercity. Předtím se tu lidé těšili poklidnému venkovu; vzpomínka na „pikniky mezi pahorky Tirisfalu na konci pozdního podzimu“ po příchodu Plagy zmizela.]] },
    { "Místa a jejich příběhy", [[Deathknell je startovní oblast, kde se noví Forsaken probouzejí. Brill je hlavní osada Forsaken, zničená v bitvě o Lordaeron a později znovu postavená. Undercity leží pod ruinami Lordaeronu a je neobyvatelná kvůli moru. Scarlet Monastery je pevnost fanatického Scarlet Crusade a hlavní protivník Forsaken. Agamand Mills je bohatý rodinný statek, dnes nemrtvé ruiny. Venomweb Vale je chráněné magické místo, které dříve využívala Council of Tirisfal. Pradávný mor se šířil jedem pavouků Night Web a zdecimoval obyvatelstvo.]] },
    { "Zajímavosti", [[• Brill spravuje Executor Zygand a pevnost Bulwark velí High Executor Derrington.
• Název Tirisfal je vrykulské „Tyr's Fall“.
• SPOILER: Po Cataclysmu se krajina výrazně změnila a v době Battle for Azeroth na ni zaútočila Aliance ze severních pláží.]] },
})

secrets("Tirisfal Glades", [[• Jméno Tirisfal znamená vrykulsky „Tyr's Fall“ (pád Tyra).
• Pod zemí prý bojují energie Tyra a Zakajze.
• Ruins of Lordaeron nad Undercity jsou ve WoW Forever nový dungeon (levely 15–22).]])

-------------------------------------------------------------------------------
-- Silverpine Forest
-------------------------------------------------------------------------------
chapters("Silverpine Forest", {
    { "Dávná a nedávná minulost", [[Před 2 600 lety před otevřením Temné brány rozpoutal tu démon Kathra'natir sarančí mor. Jižní části kraje patřily Gilneasu, dokud je Greymane Wall neodřízla a nevznikly izolované lidské osady Pyrewood Village a Ambermill. Za třetí války vojska Lich Kinga uvázla u Greymane Wall; když Genn Greymane otevřel brány, jeho vojáci padli a povstali jako nemrtví. Archmage Arugal tehdy z Emerald Dream přivolal worgeny, jejichž kletba se pak vymkla kontrole a nakonec nakazila i Gilneas. Po válce kraj obsadili Forsaken a Arugal se uchýlil do Shadowfang Keep se svými vlky, kde založil kult.]] },
    { "Místa a jejich příběhy", [[The Sepulcher je hlavní pevnost a dopravní uzel Forsaken. Ambermill býval osadou mágů z Dalaranu. Fenris Isle je ostrovní pevnost, kterou postupně držely zbytky nemrtvých, smečka Bloodfang a nakonec Scarlet Crusade, než ji Forsaken znovu získali. Pyrewood Village je lidská osada, odkud za úplňku zaznívá vytí. Shadowfang Keep je opuštěná pevnost barona Silverlainea, ve které Arugal vybudoval svůj vlčí kult. V Deep Elem Mine se za čtvrté války střetly Aliance a Horda. The Skittering Dark je pobřežní oblast plná nepřátel.]] },
    { "Lidé a historky", [[Sylvanas Windrunner vedla invazi do Gilneasu; Dalar Dawnweaver je Forsaken, který řídí operace proti worgenům. Halmish, starý poustevník, varuje, že les je prokletý jiným prokletím než morem: proměnou v bestie. Worgenská proměna přichází za úplňku a postižení se stávají „krvežíznivými monstry“ po těle i duchu, i když jsou přes den normální. Dalaranský čaroděj Alphus Wordwill prý teoreticky vymyslel „lék“, který by zachoval mysl při proměně a vytvořil by ovladatelné super-vojáky.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V Cataclysmu Garrosh rozkázal Forsaken dobýt Gilneas; první invaze selhala a Gilneas Liberation Front zatlačil Forsaken zpět k Undercity. Forsaken vzkřísili pomocí Val'kyr tři zrádné gilneaské šlechtice (Godfrey, Ashbury, Walden), kteří však Sylvanas zavraždili a zmocnili se Shadowfang Keep, než byla kouzelně obnovena. V Battle for Azeroth Aliance Silverpine cílila a smečka Bloodfang dobyla Fenris Keep; Shadowfang Keep se proměnil v moru zamořenou laboratoř. V Dragonflightu se znovu zvedlo Scarlet Crusade a dobylo Fenris Isle a Fenris Keep od smečky Bloodfang.]] },
})

secrets("Silverpine Forest", [[• Pyrewood Village: za úplňku se ozývá vytí jako od vlků.
• Halmish, starý poustevník, varuje před worgenským prokletím.
• SPOILER: Pozdější příběhy ukazují, jak se Shadowfang Keep proměňuje v laboratoř a pak ho získává smečka Bloodfang.]])

-------------------------------------------------------------------------------
-- Hillsbrad Foothills
-------------------------------------------------------------------------------
chapters("Hillsbrad Foothills", {
    { "Útočiště uprchlíků", [[Hillsbrad Foothills byly při druhé válce místem, kam přistáli stormwindští uprchlíci po prohrané první válce – velký exodus na břehy Lordaeronu. Orkové z klanů přepadali pobřežní města a nově vzniklá Aliance Lordaeronu zřídila obranné základny. Durnholde Keep přepadl válečník Orgrim Doomhammer, aby osvobodil trollího vůdce Zul'jina. Za třetí války Thrallova Horda ve zdejším kraji při cestě do Kalimdoru tajně v noci pronikla do Southshore a ukradla lodě.]] },
    { "Místa a jejich příběhy", [[Southshore býval hlavním městem Aliance v kraji. Tarren Mill drží Forsaken jako nejjižnější pevnost. Durnholde Keep je věznice, kterou za druhé války přepadl Orgrim a která byla později držena Syndicate; do jejího „starého“ stavu se dá dostat přes Caverns of Time. Hillsbrad Fields (Sludge Fields) jsou zemědělská půda přeměněná na pokusná pole Forsaken. Azurelode Mine byl dřív součástí Gilneasu. Dalaran Crater je rozvalina kdysi majestátního města zničeného démonem Archimondem. Ravenholdt Manor je útočiště zlodějů. Purgation Isle je malý ostrov u jižního pobřeží.]] },
    { "Gankbrad a Darkmoon Faire", [[Než vznikly battlegroundy, přezdívali Hillsbradu „Gankbrad“ a „Pwnshore“ pro neustálé boje frakcí – byl to „ground zero“ PvP na serverech. Darkmoon Faire se tu jednou utábořil poblíž Southshore; když ho obvinili z vraždy, objevil, že vinen je Cedrick Fallrook, a „zahrabal ho zaživa na hřbitově“. Cedrick zabil svého bratra Erika, syna vinaře Terrence Fallrooka, jehož panství ovládalo hospodářství na severu.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V Cataclysmu Forsaken zničili Southshore Novým morem a Aliance se stáhla k Alterac Mountains, kde ji drží klan Stormpike. Za invaze Plamenné legie byl Hillsbrad jedním z jejích cílů a obě frakce kraj ubránily. Po příměří začala Aliance Southshore znovu stavět.]] },
})

secrets("Hillsbrad Foothills", [[• Před battlegroundy se Hillsbrad přezdívalo „Gankbrad“ a „Pwnshore“.
• Darkmoon Faire se tu jednou utábořil a vyřešil vraždu (Cedrick Fallrook).
• Jihozápadní roh (Azurelode Mine) býval součástí Gilneasu.]])

-------------------------------------------------------------------------------
-- Alterac Mountains
-------------------------------------------------------------------------------
chapters("Alterac Mountains", {
    { "Království v horách", [[Království Alterac vzniklo po trollích válkách, když se kmen Alteraci připojil k Arathoru pod králem Thoradinem a později se osamostatnil v horských štítech. Při druhé válce odhalila Aliance Lordaeronu zradu alterackých šlechticů, kteří spolupracovali s Hordou. Po válce vznikla „alteracká krize“ kolem toho, co s krajem. Bývalé exilové alteracké šlechtice dnes představuje Syndicate, banditská frakce, která se snaží krajinu získat zpět krádežemi a násilím.]] },
    { "Zničení Dalaranu", [[Za třetí války Plaga vpadla do Alteracu při Arthasově pochodu na Dalaran. Když byl vyvolán Archimonde, seslal kouzlo, které Dalaran zničilo, a zůstal po něm kráter. Dnes Ruins of Alterac drží ogři Crushridge pod Mug'tholem a Syndicate ovládá jiné oblasti. Dwarfové Stormpike hájí Alterac Valley proti vyhnanému klanu Frostwolf.]] },
    { "Místa a jejich příběhy", [[Strahnbrad je ruina bývalé osady, kterou ovládají ogři nebo Syndicate. Crushridge Hold je ogří pevnost v horách. Ruins of Alterac je zničené hlavní město, které si přivlastnil ogří válečník Mug'thol. Dalaran Crater je místo, kde bylo kouzelnické město zničeno; magické pole brání vstupu. Alterac Valley je instancovaná PvP oblast, kde proti sobě stojí Stormpike a Frostwolf. Ravenholdt Manor je neutrální pevnost zlodějů. Na Uplands najdeš Dandred's Fold, základnu Syndicate. Lordamere Internment Camp je vězeňský tábor.]] },
    { "Zajímavosti", [[• Vzácná bylina Wintersbite roste ve vysokých polohách.
• Alteracké trávy dávají horkému čaji „silnou zemitou chuť“.
• Zasněžené štíty je vidět z Hearthglenu a Stratholme.
• Alterac se objevil v South Parku v díle „Make Love, Not Warcraft“.
• Ve Warcraftu II byl Alterac zelenější; dnes je převážně zasněžený.
• Ve WoW Forever se v Alterac Mountains objevuje i dungeon City of Dalaran (úrovně 28–33).]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Při čtvrté válce Horda převzala část kraje obnovením pevností v ruinách Alteracu a Strahnbradu pro tažení proti Alianci v Lordaeronu.]] },
})

secrets("Alterac Mountains", [[• Wintersbite je vzácná bylina z vysokých hor.
• Ve WoW Forever se v Alterac Mountains nachází nový dungeon City of Dalaran (levely 28–33).
• Alterac se objevil v South Parku v díle „Make Love, Not Warcraft“.]])

-------------------------------------------------------------------------------
-- Arathi Highlands
-------------------------------------------------------------------------------
chapters("Arathi Highlands", {
    { "Kolébka lidského impéria", [[Kolem roku 2 800 před otevřením Temné brány (BDP) sjednotil král Thoradin lidské kmeny a založil impérium Arathor s hlavním městem Strom. Polosuchá krajina byla nárazníkem proti trollím nájezdům. Kolem roku 1 200 BDP se Arathor rozpadl na městské státy a jeho dědicem se stala Stromgarde.]] },
    { "Stromgarde a Trollbaneové", [[Za druhé války byla Stromgarde pod králem Thorasem Trollbanem klíčová pro tažení Aliance. Horda oblast zprvu přeplavila, ale Aliance ji zatlačila zpět přes Thandol Span. Po třetí válce zemřel Thoras a jeho syn princ Galen Trollbane se nedokázal udržet proti Syndicate, ogrům Boulderfist ani domorodým trollům Witherbark. Přeživší se stáhli do Refuge Pointe a Horda zřídila Hammerfall v dřívějším internačním táboře.]] },
    { "Místa a jejich příběhy", [[Stromgarde Keep byla skvost impéria a dnes je to sporná zřícenina. Refuge Pointe je uprchlická osada Aliance. Hammerfall dostal jméno po Orgrimu Doomhammerovi. Dabyrie's Farmstead je alianční farma, Go'Shek Farm hordská. Boulderfist Hall a Witherbark Village jsou pevnosti ogrů a trollů. Circle of East Binding a další kruhy jsou prastaré elementální vazby, které drží uvězněný Myzrael. Thandol Span je obří trpasličí most spojující Lordaeron s Khaz Modanem a Faldir's Cove malá pobřežní osada Aliance. Galen's Fall je dřívější hordská základna na jihu a Northfold Manor zřícenina.]] },
    { "Zajímavosti", [[• Oblast se objevila v South Parku v díle „Make Love, Not Warcraft“.
• Na jihovýchodním pobřeží stojí odlehlá trpasličí farma, kterou jde navštívit jen s létajícím mountem – geografická kuriozita bez funkce.
• Region je sporné území: ani jedna frakce ho nikdy neovládla naplno.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Princ Galen zabil vlastního otce kvůli artefaktu Trol'kalar. V době Legionu krátce ovládly kraj Galenovy nemrtvé jednotky, než je zdecimovali Rytíři Ebon Bladeu. Ve čtvrté válce zvítězila Aliance a král Danath Trollbane obnovil vládu; Hammerfall později dostala Mag'har pod Overlord Geya'rah. Později se tu objevila krize Red Dawn s invazí gnollů, ogrů a koboldů.]] },
})

secrets("Arathi Highlands", [[• Arathor založil král Thoradin kolem roku 2 800 BDP.
• Prastaré kruhy elementální vazby drží uvězněného Myzraela.
• SPOILER: Galen Trollbane zabil vlastního otce kvůli artefaktu Trol'kalar.]])

-------------------------------------------------------------------------------
-- Wetlands
-------------------------------------------------------------------------------
chapters("Wetlands", {
    { "Nárazníková zem Khaz Modanu", [[Wetlands byly důležitou severní nárazníkovou zónou Khaz Modanu. Po Válce tří kladiv postavili trpaslíci Thandol Span, aby udrželi vztahy mezi Ironforge a územím Wildhammerů. Za druhé války si tu Orgrim Doomhammer zřídil výchozí bod invazního loďstva a nedaleký Grim Batol obsadil klan Dragonmaw. Zdejší divočina trpěla: orkové i jejich draci hojně žrali čerstvé maso, a zvěře ubylo.]] },
    { "Menethil Harbor", [[Po druhé válce vyrostl z přístaviště Menethil Harbor, pojmenovaný po králi Terenasi Menethilovi II. z Lordaeronu. Je to hlavní alianční přístav a dopravní uzel s loděmi do vzdálených měst.]] },
    { "Místa a jejich příběhy", [[Dun Modr byla kdysi prosperující trpasličí pevnost, později ji obsadili Dark Iron a nakonec Alianci vrátil Thargas Anvilmar. Whelgar's Excavation Site je výzkumné naleziště, kde prospektor Whelgar žádá pomoc proti Dragonmawům; právě nad ním leží vchod do nového dungeonu Excavation Site: Wetlands. Angerfang Encampment je pevnost izolovaných zbytků klanu Dragonmaw pod vedením Gorfaxe Angerfanga. Bluegill, Black Channel a Mosshide jsou murločí močály. Grim Batol, kdysi sídlo Dragonmawů, je prastará pevnost pod horou.]] },
    { "Zajímavosti", [[• V zemi jsou sporné ruiny a záhadné vraky lodí na pobřeží.
• Černí dračí mladíci pod drakem Pyrricionem se přeli o území s okupujícími orky.
• Rethiel the Greenwarden je legendární strážce z rostlin, jehož legenda inspirovala usazení nočních elfů.
• Ve WoW Forever tu nad vykopávkami najdeš dungeon Excavation Site: Wetlands (levely 26–31).]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Cataclysm způsobil zatopení a částečně potopil přístav a povodeň vytlačila mořské tvory do močálů. Grim Batol se stal pevností Twilight's Hammer, než ho společně dobyla Aliance a červení draci. Po Cataclysmu se řeší obnova, ekologie a boj s Dragonmawy a murloky.]] },
})

secrets("Wetlands", [[• Ve WoW Forever je nad Whelgar's Excavation Site nový dungeon Excavation Site: Wetlands.
• Rethiel the Greenwarden je legendární strážce z rostlin.
• SPOILER: Po Cataclysmu je Menethil Harbor částečně zatopený.]])

-------------------------------------------------------------------------------
-- Loch Modan
-------------------------------------------------------------------------------
chapters("Loch Modan", {
    { "Thelsamar a přehrada", [[Thelsamar je hlavní osada oblasti, kterou řídí Magistrate Bluntnose pod Radou tří kladiv. Za druhé války kraj ovládli orkové, než ho trpaslíci vítězně dobyli zpět. Stonewrought Dam, přehrada, „architektonický div, který nemá v Azerothu obdoby“, držela obrovské jezero Loch.]] },
    { "Místa a jejich příběhy", [[Dun Algaz je severní brána do oblasti. Ironband's Excavation Site je archeologické naleziště, kde prospektor Ironband bojuje s nebezpečím, které vykopávky přinesly: troggy. Mo'grosh Stronghold je obří věž ogrů. Farstrider Lodge je hostinec lovců, Algaz Station severní stanice, Silver Stream Mine důl. Ve Valley of Kings posílá kapitán Rugelfuss mladé trpaslíky vyhubit troggy. Grizzlepaw Ridge a North/South Gate Pass jsou úseky cest k Dun Morogh.]] },
    { "Zajímavosti", [[• Loch Modan byl původně zamýšlen jako jedna zóna spolu s Dun Morogh.
• Jméno prý znamená „horské jezero“ v trpasličím jazyce.
• Pod vodou jsou vidět rozbité katapulty a balisty z druhé války.
• V původním jezeře ležely tři velké ostrovy; na nejsevernějším jsou ruiny z druhé války.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Cataclysm: Deathwing zničil přehradu, Loch se z devadesáti procent vypustil a oblast obsadil Dark Iron s Twilight's Hammer. Gnolové Mosshide se přesunuli na západ a murlokové, gnolové a koboldi vytvořili neobvyklé spolky. V nově vzniklé jeskyni Ironwing Cavern se objevili proto-stridery a porouchaná bojová kuřata.]] },
})

secrets("Loch Modan", [[• Jméno Loch Modan prý znamená „horské jezero“.
• Pod hladinou jsou rozbité katapulty z druhé války.
• SPOILER: Po Cataclysmu je Loch z 90 % vypuštěný.]])

-------------------------------------------------------------------------------
-- Redridge Mountains
-------------------------------------------------------------------------------
chapters("Redridge Mountains", {
    { "Rudé hory pod Stormwindem", [[Redridge Mountains patří k území království Stormwind. Historicky sever zdevastovalo vyvolání Ragnarose trpaslíky Dark Iron, čímž vznikl Blackrock Mountain a Burning Steppes. Později klany Blackrock a Black Tooth Grin vybudovaly Temnou hordu: ovládly Stonewatch Keep a z pevnosti terorizovaly Lakeshire.]] },
    { "Morganth a gnolové", [[V době hry kontrolovali východní polovinu orkové spojení se zlým lidským černokněžníkem Morganthem a jeho gnolovými přisluhovači Shadowhide. Hrdinové je postupně zatlačují zpět.]] },
    { "Místa a jejich příběhy", [[Lakeshire je hlavní alianční středisko na západním břehu Lake Everstill. V radnici Lakeshire Town Hall verbuje Magistrate Solomon dobrodruhy na obranu kraje. Stonewatch Keep je lidská pevnost, kterou zajali orkové. Render's Camp a Render's Valley jsou orčí osady, zničené při konfliktu s Temnou hordou. Tower of Ilgalar drží gnolové Shadowhide. Three Corners je křižovatka cest. Lake Everstill obývají murlokové a legendy mluví o mořských netvorech. Redridge Canyons jsou nebezpečné horské cesty, Alther's Mill neutrální osada a Rethban Caverns jeskyně pod zemí.]] },
    { "Lidé a historky", [[Magistrate Solomon je stárnoucí vůdce Lakeshire, který přivolává pomoc z daleka. Marshal Marris u zřícené lávky vede mladé lidi proti gnollům a orkům a Verner Osgood mu pomáhá.]] },
    { "Zajímavosti", [[• Supi prý vidí lidské vlasy jako výborný materiál na hnízdo, proto se hodí helma.
• Warcraft III zmiňuje gnolly a koboldy, i když tam Redridge nikdy nebyl.
• Přechod do Burning Steppes býval jedním z nejstrmějších skoků úrovní ve hře (z 20 na 50).]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu vedla Temnou hordu drak Darkblaze; hrdinové ji zatlačili zpět do Burning Steppes. Most Everstill Bridge se po Cataclysmu stavěl pět let. Při „Death Rising“ zaútočila na Redridge Plaga a Stormwindská armáda spolu s Argent Crusade kraj ubránila.]] },
})

secrets("Redridge Mountains", [[• Přechod z Redridge do Burning Steppes býval skokem z úrovně 20 na 50.
• Supi se prý rádi hnízdí ve vlasech – hodí se helma.
• SPOILER: Everstill Bridge se po Cataclysmu stavěl pět let.]])

-------------------------------------------------------------------------------
-- Duskwood
-------------------------------------------------------------------------------
chapters("Duskwood", {
    { "Z Brightwoodu na Duskwood", [[Původně se oblast jmenovala Brightwood a byla úrodnou součástí Stormwindu. Po druhé válce se podle příběhu proměnila v prokletý les: temnota se rozšířila z blízkého Karazhanu po smrti čaroděje Medivha, a z mírumilovné krajiny se stal kraj nemrtvých a hrůz.]] },
    { "Klíčová zápletka", [[Artefakt Scythe of Elune přitahuje Dark Riders a worgeny. Nekromancer Morbent Fel vládne Raven Hill Cemetery, kde straší neklidné hroby. Oliver Harris, alchymista, zkoumá worgenskou kletbu u Raven Hill. Sven Yorgen je přeživší, jehož rodinu zabili Dark Riders; představuje civilní tragédii zdejšího kraje.]] },
    { "Místa a jejich příběhy", [[Darkshire je hlavní osada, radnice slouží jako středisko úkolů a město trápí nemrtví i worgeni. Raven Hill Cemetery je Morbentovo sídlo. Twilight Grove ukrývá Velký strom, který vede sílu Smaragdového snu a slouží jako portál pro druidy. Manor Mistmantle je spojený s vlčím kultem a legendou o Scythe of Elune. Roland's Doom je důl, kde se při operacích Defias ztratila kosa. Vul'Gol Ogre Mound je ogří osada a naleziště fosilií.]] },
    { "Zajímavosti", [[• Temnota od Karazhanu je v kraji stálá a v Duskwoodu se nikdy úplně nerozední.
• SPOILER: Po Cataclysmu se do Duskwoodu přistěhovali gilneajští uprchlíci, mezi nimi Tobias Mistmantle, který hledá bratra Stalvana.
• SPOILER: Při invazi Legionu tu Veiled Hand pod Sister Ebonlocke prováděli démonické rituály.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu se kolem Manoru Mistmantle objevily vlčí smečky Mistfang a vzácné květy, což svědčí o dlouhodobé nestabilitě spojené s magickými artefakty. Kraj dnes brání Commander Sarah Ladimore s milicí Night Watch.]] },
})

secrets("Duskwood", [[• Darkshire stráží Night Watch; původní vládce byl Lord Ello Ebonlocke.
• Artefakt Scythe of Elune se ztratil v dole Roland's Doom.
• SPOILER: Po Cataclysmu se tu usadili gilneajští uprchlíci.]])

-------------------------------------------------------------------------------
-- Stranglethorn Vale
-------------------------------------------------------------------------------
chapters("Stranglethorn Vale", {
    { "Srdce říše Gurubashi", [[Stranglethorn Vale bylo srdcem trollí říše Gurubashi, která kdysi ovládala jih Východních království. Zlomovým okamžikem byla občanská válka před 1 500 lety před otevřením Temné brány: skupina kněží přivolala Hakkara the Soulflayer, krvavého boha, který málem zničil celý trollí národ. Zandalarové nakonec Hakkara porazili u jeho svatyně v Zul'Gurub, ale fanatičtí stoupenci utekli a založili Temple of Atal'Hakkar v Swamp of Sorrows.]] },
    { "Místa a jejich příběhy", [[Booty Bay byl původně lidský přístav, který přemohli trollové; goblini ze Steamwheedle Cartel si ho vzali zpět jako středisko pro Východní království. Dnes se o něj přou Blackwater Raiders (gobliní piráti) a konkurenční Bloodsail Buccaneers. Grom'gol Base Camp je hordská osada, kde Kin'weelay bojuje s kmeny Bloodscalp a Skullsplitter. Rebel Camp založili vojáci, kteří se vzbouřili proti plukovníku Kurzenovi, jehož ovládl ogří mág Mai'Zoth pomocí artefaktu na kontrolu mysli; odboj vede Lieutenant Doren. Nesingwary's Expedition vede lovec Hemet Nesingwary Jr. a posílá dobrodruhy po vzácné exotické zvěři. Gurubashi Arena je stadion, kde „největší trollové z celého Azerothu bojovali jednou za generaci“.]] },
    { "Lidé a historky", [[Baron Revilgaz je současný goblí vládce Booty Bay. Jin'do, Bloodlord Mandokir a Var'gazul byli trollí vládcové; ti všichni jsou mrtví. Plukovník Kurzen je posedlý voják, který se později objeví jako protivník.]] },
    { "Zajímavosti", [[• Oblast je proslulá Stranglethorn Fever, nebezpečnou nemocí tamní džungle, a jedovatou zvěří i rostlinami.
• Vedle prastarých trollích ruin stojí moderní gobliní těžební a dřevařské podniky, takže se tu neustále bojuje o území.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Cataclysm (28 ADP) rozdělil Stranglethorn na dvě zóny „obrovskou propadlinou s vířivkou The Sundering“: Northern Stranglethorn a Cape of Stranglethorn. Zandalarové později znovu vystavěli Zul'Gurub a Venture Company rozšířila průmysl.]] },
})

secrets("Stranglethorn Vale", [[• Stranglethorn Fever je skutečná nemoc džungle.
• Hakkar the Soulflayer byl poražen v Zul'Gurub, jeho stoupenci založili Temple of Atal'Hakkar.
• Gurubashi Arena: bojuje se tu o truhlu každé tři hodiny.
• SPOILER: Po Cataclysmu se zóna dělí na Northern Stranglethorn a Cape of Stranglethorn.]])

-------------------------------------------------------------------------------
-- The Hinterlands
-------------------------------------------------------------------------------
chapters("The Hinterlands", {
    { "Z trollí říše k Aerie Peaku", [[Hinterlands původně ovládala říše lesních trollů Amani. Po porážce v trollích válkách (kolem 2 800 BDP) se trollové rozpadli na tři kmeny. V roce 230 BDP dorazili po Válce tří kladiv Wildhammer trpaslíci a založili Aerie Peak; spojení s gryfy se stalo základem jejich kultury.]] },
    { "Druhá válka a po ní", [[Za druhé války (5 ADP) obtěžovali jezdci na gryfech pod thanem Kurdranem Wildhammerem z oblohy invazní Hordu a stali se klíčoví pro vítězství Aliance. Horda neměla proti letcům obranu a stáhla se. Po třetí válce se kmen Revantusk spojil s novou Hordou a postavil Revantusk Village. Quel'Danil Lodge býval komunikačním uzlem vysokých elfů; v roce 25 ADP se z portálu Seradane vynořil zkažený zelený drak Ysondre.]] },
    { "Místa a jejich příběhy", [[Aerie Peak je gryfí pevnost a hlavní středisko Aliance. Revantusk Village je osada kmene Revantusk. Jintha'Alor je prastará pevnost Vilebranchů, „srdce“ bývalé říše Amani. Seradane je jeden ze čtyř Velkých stromů vedoucích do Smaragdového snu. Skulk Rock býval orčí základnou za druhé války. Shadra'Alor a Agol'watha jsou bývalé chrámy kmene Witherbark. Quel'Danil Lodge je lovecká chata vysokých elfů a diplomatické středisko.]] },
    { "Postavy", [[Falstad Wildhammer vede Wildhammery v Hinterlands a patří do Rady tří kladiv. Primal a Elder Torntusk vedou kmen Revantusk. Vile Priestess Hexx byla vůdkyní Vilebranchů.]] },
    { "Zajímavosti", [[• Zóna se při vývoji původně jmenovala „Aerie Peaks“.
• Akil'darah, orlí duch, nese v některých pramenech titul „Guardian of the Hinterlands“.
• Hinterlands zůstaly „klidné a mírumilovné“ i po Cataclysmu, na rozdíl od sousedních oblastí.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu Wildhammerové postavili Stormfeather Outpost, Forsaken přeměnili Hiri'watha na výzkumnou stanici a obě strany, Wildhammerové i Revantusk, oblehly Jintha'Alor, který nakonec získal kmen Revantusk. Witherbark nakonec Forsaken z Hinterlands vyhnali.]] },
})

secrets("The Hinterlands", [[• Původní název zóny byl „Aerie Peaks“.
• Seradane je jeden ze čtyř Velkých stromů vedoucích do Smaragdového snu.
• SPOILER: Po Cataclysmu obléhají Jintha'Alor Wildhammerové i Revantusk.]])

-------------------------------------------------------------------------------
-- Western Plaguelands
-------------------------------------------------------------------------------
chapters("Western Plaguelands", {
    { "Obilnice Lordaeronu", [[Western Plaguelands byly zemědělskou základnou Lordaeronu. Za Scourge invaze Lich King rozmístil „cauldrony moru“, kterými otrávil obilí exportované z Andorhalu, a úrodná pole se změnila v zkaženou pustinu. Region byl „jedním z prvních, který padl“ a zůstal zamořený dlouhé roky.]] },
    { "Místa a jejich příběhy", [[Andorhal býval distribučním střediskem obilí, dnes je spornou zříceninou. Caer Darrow je ostrovní pevnost, kde sídlí Scholomance, nekromantská akademie Plagy. Hearthglen je pevnost Scarlet Crusade (později Argent Crusade) v Mardenholde Keep. Sorrow Hill s Uther's Tomb je „jediné místo zdravého rozumu v Western Plaguelands“, posvěcený památník. Felstone Field, Dalson's Farm a Gahrron's Withering jsou místa cauldronů s nemrtvými. Chillwind Camp je alianční tábor na jižní hranici. The Weeping Cave a Writhing Haunt jsou jeskyně plné nemrtvých.]] },
    { "Lidé a historky", [[Tirion Fordring je neutrální vůdce, který hledá způsob, jak zachránit syna Taelana z vlivu Scarlet Crusade. Darkmaster Gandling ovládá Scholomance. Zóna proslula tím, že tu nechtěně umíral spousta zvědavých nováčků z Tirisfal Glades – v komunitě se tomu říká „Welcome Bear“ a ukazuje to, jak tvrdé jsou přechody mezi zónami.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po válce s Lich Kingem založil Argent Crusade v Hearthglenu hlavní pevnost. Při Cataclysmu Cenarion Circle obnovil velkou část vitality země. Thassarian (Aliance) a Koltira Deathweaver (Horda) velili ve Battle for Andorhal. Caer Darrow a Scholomance dál ovládá Gandling.]] },
})

secrets("Western Plaguelands", [[• Plaga se šířila otráveným obilím z Andorhalu.
• Sorrow Hill s Uther's Tomb je jediné klidné místo zóny.
• Zóna je proslulá tím, že tu zahynuli nováčci z Tirisfalu („Welcome Bear“).]])

-------------------------------------------------------------------------------
-- Eastern Plaguelands
-------------------------------------------------------------------------------
chapters("Eastern Plaguelands", {
    { "Eastweald a Očištění Stratholmu", [[Eastern Plaguelands se dřív jmenovaly Eastweald a byly úrodnou částí království Lordaeron. Za třetí války provedl princ Arthas „Očištění Stratholmu“ (Culling of Stratholme): pobil nakažené obyvatele a začal svůj pád do temnoty. Lich Kel'Thuzad poté vládl ze Stratholmu a jeho létající citadela Naxxramas se stala jižní baštou Scourge. Po válce založil Argent Dawn v Light's Hope Chapel odboj, který později splynul s dalšími frakcemi v Argent Crusade.]] },
    { "Místa a jejich příběhy", [[Light's Hope Chapel je neutrální útočiště a hlavní cestovní uzel; velitelství protiscourgových sil. Stratholme je zřícené hlavní město regionu a dnes dungeon, o který bojují nemrtví a odboj. Tyr's Hand je bývalá pevnost Scarlet Crusade, dnes z velké části znovu v rukou Argent Crusade. Plaguewood je nejzkaženější část zóny, plná morových tvorů a magické poskvrny. Quel'Lithien Lodge je východní hraniční místo s hlídaným průsmykem do Quel'Thalas. Věže Crown Guard, Northpass, Eastwall a Light's Shield jsou „body světla“ proti temnotě nemrtvých.]] },
    { "Lidé a historky", [[Lord Maxwell Tyrosus vede Argent v Light's Hope Chapel. Tirion Fordring působí od řeky Thondroril. SPOILER: Highlord Darion Mograine velí rytířům smrti z Acherusu.]] },
    { "Zajímavosti", [[• Zóna zachycuje staletý boj mezi okupací Scourge a organizovaným odporem.
• SPOILER: Po Cataclysmu zkáza pomalu slábne.]] },
})

secrets("Eastern Plaguelands", [[• Eastern Plaguelands se původně jmenovaly Eastweald.
• Naxxramas se vznáší nad zemí jako jižní bašta Scourge.
• Věže Crown Guard, Northpass, Eastwall a Light's Shield jsou „body světla“.]])

-------------------------------------------------------------------------------
-- Badlands
-------------------------------------------------------------------------------
chapters("Badlands", {
    { "Zelené údolí, které vypálil Ragnaros", [[Badlands byly kdysi „zelené údolí plné přírodního bohatství“. Příchod Ragnarose před 300 lety z nich udělal pustinu. Ukrývá také Uldaman, prastarou pevnost vytvořenou Titány. Prospektoři ji objevili „teprve před pár lety“ a našli „značky s tajemstvím pravého původu trpaslíků“, ale probudili primitivní troggy Stonevault, kteří ji nyní brání.]] },
    { "Druhá válka a classic", [[Za druhé války (5 ADP) vedli bojovníci klanu Black Tooth Grin Cho'galla Badlands, aby prohlédl rafinerie oleje u Grim Batolu. V době classic (25 ADP) vznikl Kargath jako jediná hordská základna v Khaz Modanu. Thrall tam poslal Kargath Expeditionary Force, aby zlikvidovala odpadlíka z klanu Blackrock Renda Blackhanda. Goblini založili Fuselight a Fuselight-by-the-Sea.]] },
    { "Místa a jejich příběhy", [[Uldaman je titánská pevnost, o kterou se přou Explorers' League, Dark Iron a další. Angor Fortress je ogří pevnost. Lethlor Ravine je místo, kde se objevuje černý dračí rod, a The Dustbowl je jeho lovecké území. Hammertoe's Digsite je naleziště trpasličího prospektora. Camp Boff, Kosh, Wurg a Cagg jsou ogří tábory. Agmond's End, Apocryphan's Rest, Valley of Fangs a Dustwind Gulch jsou menší zajímavosti. V Badlands se nachází i pohřbený trollí chrám s hadími sochami severozápadně od Dustbowlu, podobný stavbám z Hinterlands.]] },
    { "Zajímavosti", [[• Podle RPG je tu jediná trvalá osada: Kargath.
• Písečné bouře prý dokážou zmást orientaci podle krajinných bodů.
• Hearthstone si v non-kánonickém „Showdown in the Badlands“ vymyslel Bloodrock, kde Sheriff Barrelbrim těží Azerite.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Při Cataclysmu lavina zničila Kargath a nahradil ho New Kargath. Deathwingův průlet vytvořil roklinu Scar of the Worldbreaker.]] },
})

secrets("Badlands", [[• Ragnaros zpustošil zelené údolí před zhruba 300 lety.
• Uldaman je titánská pevnost; Stonevault troggové ji brání.
• Hearthstone: „Showdown in the Badlands“ (nekánon).
• SPOILER: Po Cataclysmu leží v zóně Scar of the Worldbreaker.]])

-------------------------------------------------------------------------------
-- Národy ve startovních oblastech
-------------------------------------------------------------------------------
chapters("Mulgore", {
    { "Národ: taureni (shu'halo)", [[Taureni, ve své řeči shu'halo, pocházejí od yaungolů, býčí rasy, kterou kdysi zotročila moguská říše. Po osvobození putovaly skupiny na sever. Ty, které se usadily u Well of Eternity, se od Cenaria naučily druidskou a šamanskou magii a staly se tím, čím jsou dnes.

Uctívají Matku Zemi. Podle mýtu si vyrvala oči a umístila je na oblohu: levé se stalo Mu'sha (měsíc) a pravé An'she (slunce). Ani jedno nepřevažuje; společně jsou symbolem vyváženého vidění. Srdcem jejich duchovní identity je Great Hunt, velký lov. Každý taurenský dospělý se chce lovem osvědčit a získat nauku Matky Země. Dospívající skládají Rites of the Earthmother (Síla, Odvaha, Čest, Větry, Vize, Moudrost), aby se stali bojovníky.

Dlouhé generace je trápili kentauři, zrození z neobvyklého svazku Zaetara (syna Cenaria) a princezny Theradras; kvůli nim byli taureni nuceni k nomádskému životu po Barrens. Teprve Cairne Bloodhoof se spojil s Thrallem a novou Hordou a s orčí pomocí získali Mulgore zpět.

Zajímavosti: mrtví se spalují obřadním způsobem a popel se vrací větrům a řekám. Taureni jedí hlavně pinie, kukuřičnou mouku a koření. Tauren je vysoký 9–10 stop, váží 400–800 liber, má kopyta, rohy, tříprsté ruce a ocas. Dobré vztahy mají s nočními elfy (sdílená druidská tradice v Cenarion Circle), horší s trpaslíky, kteří podle nich ryjí do Matky Země. SPOILER: Po Cataclysmu se objevili Sunwalkeři (paladinové) a Seers (kněží).]] },
})

chapters("Durotar", {
    { "Národ: orkové", [[Orkové údajně pocházejí z kamenných obrů vytvořených titánem Aggramarem: colossali, magnaroni, gronni, ogroni, ogrové a nakonec orkové, kteří se postupně zmenšovali a získávali rozum. Před 800 lety před Temnou branou se rozšířili na povrch Draenoru a vytvořili klany (Blackrock, Frostwolf, Shadowmoon, Warsong…). Klan Shadowmoon objevil šamanismus u Throne of the Elements a sjednotil klany pokojnou duchovní správou.

Pak přišel Kil'jaeden, který šamana Ner'zhula oklamal, že draenei kují spiknutí proti orkům. Následoval genocidní konflikt a démonická korupce: z kůže orků se stala zelená, šamany nahradili černokněžníci. Gul'dan vedl klany do Staré Hordy a po vypití krve Mannorothu se orkové dostali pod vůli Plamenné legie. Nezkažení potomci se jmenují Mag'har.

Horda napadla Azeroth přes Temnou bránu a dobyla Stormwind, ale Aliance ji porazila. Po osvobození z internačních táborů Thrallem (synem Durotana) se orkové přesunuli do Kalimdoru, založili Durotar a Orgrimmar a po poražení Mannorothu Gromem Hellscreamem se zbavili démonické kontroly. Vysoký asi 7 stop (muži), cení si cti, bojové zdatnosti a klanu; exil je pro ně největší hanba. Vzácně mají modré oči – znamení osudu.]] },
    { "Národ: Darkspear trollové", [[Darkspear jsou džunglovití trollové, kteří se připojili k Hordě po záchraně Thrallem před naga za třetí války. Původně je vedl náčelník Sen'jin, poté jeho syn Vol'jin, který se stal válečným náčelníkem. Heslem kmene je „Darkspear never die“ – Darkspear nikdy neumírají. Na rozdíl od jiných trollích kmenů nejsou tak divocí; po vstupu do Hordy opustili kanibalismus, ale ponechali si duchovní tradice.

Tři hlavní loa jsou Bwonsamdi (Duše, loa smrti), Lukou (Srdce, regenerace) a Kevo ya Siti (Hlava, lstivost). Domovem je Echo Isles a Sen'jin Village v Durotaru. SPOILER: Vol'jin padl v bitvě o Broken Shore a kmen dnes vede Rokhan.]] },
})

chapters("Elwynn Forest", {
    { "Národ: lidé", [[Lidé pocházejí z vrykulů, polobřích z Northrendu. Před 15 000 lety způsobila Curse of Flesh, že se vrykulské děti rodily malé a zdeformované. Místo vyhlazení je rodiče ukrývali v Tirisfal Glades, kde se za tisíciletí zvrhli v smrtelné lidi. Nomádské kmeny se pak sjednotily pod Thoradinem proti trollům Amani a vzniklo impérium Arathor kolem 2 800 BDP. Vysocí elfové z Quel'Thalas je naučili arkánní magii výměnou za vojenskou pomoc.

Kolem 1 200 BDP se Arathor rozpadl na Sedm království: Lordaeron, Stormwind, Dalaran, Kul Tiras, Gilneas, Stromgarde a Alterac. Po první válce vznikla Aliance Lordaeronu s trpaslíky, gnómy a vysokými elfy. Lidé mluví Common (společnou řečí) a věří v Church of the Holy Light; magickou tradici zastupuje Kirin Tor a bojovou Knights of the Silver Hand. SPOILER: Stormwind je dnes nejsilnější bašta lidí pod králem Anduinem Wrynnem.]] },
})

chapters("Dun Morogh", {
    { "Národ: trpaslíci", [[Trpaslíci pocházejí z Earthen, kamenných bytostí vytvořených titánskými Keepery. Po Curse of Flesh se z nich stali tělesní humanoidé, kteří se probudili a nazvali se trpaslíky. Khaz Modan se jmenuje podle titána Khaz'goroth. Klany jsou tři: Bronzebeardové vládnou Ironforge a Dun Morogh, Wildhammerové žijí v Hinterlands a proslavili je gryfové a Dark Iron, zotročení Ragnarosem po Válce tří kladiv, sídlili v Blackrock Mountain. Válka se rozhořela, když Sorcerer-Thane Thaurissan omylem vyvolal Ragnarose, který zničil hlavní město a vytvořil Burning Steppes. Trpaslíci vynikají v kovářství, kamenictví a těžbě; mají rádi pivo a dýmky a raději chodí po pevné zemi. SPOILER: Dnes jsou všechny tři klany zastoupeny v Radě tří kladiv.]] },
    { "Národ: gnómové", [[Gnómové pocházejí z mechagnómů, kovových tvorů vytvořených Keeperem Mimironem. Postižení Curse of Flesh se postupně proměnili v tělesné gnómy asi 3 000 let před Temnou branou. Trpaslíci je objevili v zasněžených horách západně od Uldamanu kolem 2 500 BDP, poznali příbuznost a pomohli jim založit Gnomeregan. Před pádem města „neměli žádnou historii vnitřního násilí“.

Pád Gnomereganu způsobila zrada Thermaplugga. Přeživší utekli do Tinker Town v Ironforge. Gelbin Mekkatorque nepřistoupil na okamžité dobývání, a raději se zaměřil na podporu Aliance a technologický pokrok. Gnómové jsou mistři techniky, malí (asi 3'4"–3'6"), mají čtyři prsty a velké zaoblené uši. Jsou optimističtí i přes všechna neštěstí a mají rivalitu s gobliny. SPOILER: Operation: Gnomeregan později město částečně získala zpět a gnómové objevili Mechagon.]] },
})

chapters("Teldrassil", {
    { "Národ: noční elfové (kaldorei)", [[Noční elfové, kaldorei neboli „děti hvězd“, se vyvinuli z temných trollů u Well of Eternity před zhruba 15 000 lety. Magie je změnila na vysoké bytosti s fialovou kůží, které uctívají měsíční bohyni Elune a pod královnou Azsharou vytvořily pokročilou civilizaci. Říše ovládla Kalimdor.

Azshařini Highborne ale zpyšněli a Sargeras je oklamal, aby otevřeli portál Plamenné legii. Spustila se Válka prastarých (War of the Ancients), kterou vedli Malfurion Stormrage (první druid) a velekněžka Tyrande Whisperwind. Well of Eternity při Velkém roztříštění implodoval a roztříštil Kalimdor. Přeživší se zřekli arkánní magie a vydali se cestou druidů a přírody. Malfurion a dračí Aspekty vytvořili Nordrassil, první Světový strom, který chránil nový Well a dal noční elfům nesmrtelnost.

Následovala Long Vigil, tisíce let izolace, kdy druidové spali ve Smaragdovém snu. Třetí válka je vyvedla z izolace a připojili se k Alianci. SPOILER: Teldrassil shořel za války o trny a noční elfové dnes budují nové hlavní město Bel'ameth u nového Světového stromu Amirdrassil na Dragon Isles; vede je Shandris Feathermoon.]] },
})

chapters("Tirisfal Glades", {
    { "Národ: Forsaken", [[Forsaken jsou inteligentní nemrtví, kteří se po třetí válce osvobodili z vůle Lich Kinga. Původně lidé a vysocí elfové z Lordaeronu; Undercity si postavili pod troskami hlavního města. Sylvanas Windrunner je sjednotila a vládla jim jako královna, dokud je nezradila za čtvrté války. Svobodná vůle je jejich nejdůležitější hodnota, díky níž se liší od zotročeného Scourge. Mluví Gutterspeak a často si berou nová jména jako symbol znovuzrození.

Forsaken nemohou přirozeně spát a mají otupělé vjemy. Živí se alchymií, štěpováním částí těla a kanibalismem; „všechno chutná po popelu“. Do Hordy je prosadil taurenský Hamuul Runetotem proti Lich Kingovi, ale důvěra utrpěla po moru u Wrathgate, který zabil Hordu i Alianci. Nejblíž mají krvavé elfy. SPOILER: Dnes je vede Desolate Council: Lilian Voss, Calia Menethil, Master Apothecary Faranell, Deathstalker Commander Belmont a Dark Ranger Velonara.]] },
})

-------------------------------------------------------------------------------
-- Searing Gorge
-------------------------------------------------------------------------------
chapters("Searing Gorge", {
    { "Jak se zelené údolí proměnilo v pálenou rokli", [[Před více než 230 lety se Sorcerer-Thane Thaurissan z klanu Dark Iron pokusil za Války tří kladiv přivolat nadpřirozeného sluhu. Místo toho vzbudil prastarého Firelorda Ragnarose; výbuch sopky „navždy zčernal okolní země“ a zničil dark ironskou metropoli Thaurissan. Kdysi úrodné údolí se proměnilo v spálenou pustinu.]] },
    { "Thorium Brotherhood", [[Thorium Brotherhood, Dark Iron trpaslíci, kteří se oddělili od klanu, založili Thorium Point jako neutrální základnu, odkud sledují těžbu Dark Iron v oblasti.]] },
    { "Místa a jejich příběhy", [[Thorium Point je neutrální středisko a hlavní zdroj questů; Hansel Heavyhands tu organizuje boj proti hrozbám. Iron Summit je druhá neutrální osada s alternativním letištěm. The Cauldron a Slag Pit jsou obrovská ironská těžba, ve které pracují otroci. Dustfire Valley ukazuje zkázu po sopečném výbuchu. Firewatch Ridge je scénický výhled, Grimesilt Dig Site je naleziště plné golemů, Tanner Camp malá osada a Blackchar Cave jeskyně. Smrt v instancích Blackrock Mountain tě vrací na hřbitov u Thorium Point.]] },
    { "Postavy a zajímavosti", [[• Hansel Heavyhands vede boj proti golemům, pavoukům a incendosaurům.
• Master Smith Burninate chce se spoluprací dobrodruhů vyrobit ohnivé tavidlo.
• Velarok Windblade posílá odvážlivce zapálit dark ironské hlídkové věže.
• Mountaineer Pebblebitty dřív hlídal průsmyk Stonewrought Pass, který byl před Cataclysmem uzamčen questovým klíčem.
• Charred Oak, památník nad Cauldronem, byl později odstraněn.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Během The Burning Crusade zaútočila Plamenná legie pod Highlordem Kruulem, než začalo tažení do Outlandu. Cataclysm odemkl Stonewrought Pass bez klíče.]] },
})

secrets("Searing Gorge", [[• Po smrti v instancích Blackrock Mountain se probudíš na hřbitově u Thorium Point.
• Thaurissan vzbudil Ragnarose omylem při pokusu o vyvolání sluhy.
• SPOILER: Po Cataclysmu je Stonewrought Pass volný.]])

-------------------------------------------------------------------------------
-- Burning Steppes
-------------------------------------------------------------------------------
chapters("Burning Steppes", {
    { "Hora, která roztavila hory", [[Sorcerer-Thane Thaurissan z klanu Dark Iron se za Války tří kladiv pokusil přivolat elementály. Plán se spektakulárně zvrtl: klan byl vyhnán z Ironforge a on vzbudil Firelorda Ragnarose, jehož příchod „roztavil několik hor v tomto pásmu a vykoval obrovskou sopku“.]] },
    { "Orkové a Anduin Lothar", [[Po první a druhé válce vybudoval klan Blackrock v oblasti stálá sídla. Warchief Orgrim Doomhammer zde poblíž sopky zabil lidského hrdinu Anduina Lothara; toto vítězství se ale nakonec obrátilo proti Hordě. Dnes je oblast sporná mezi Aliancí a Hordou a černý dračí rod sem sahá vlivem Nefariana, který obsadil horní patra Blackrock Spire.]] },
    { "Místa a jejich příběhy", [[Morgan's Vigil je alianční pevnost a poslední bašta lidí jižně od stepí. Flame Crest je malá hordská základna. Blackrock Mountain je aktivní sopka, kterou nejde přehlédnout. Blackrock Spire je dřívější hordská pevnost, dnes sporná mezi Nefarianovými draky a orky z Blackrocku. Altar of Storms je posvátné místo, Ruins of Thaurissan opuštěné hlavní město Dark Iron a pomník čarodějné pýchy. Dreadmaul Rock je pevnost ogrů Firegut, Terror Wing Path území černých draků a Pillar of Ash orientační bod u Black Tooth Hovel. Blackrock Stronghold je hlavní orčí osada, skrytá před hlavní cestou.]] },
    { "Zajímavosti", [[• Nižší hráči Aliance z Redridge Mountains se tu často dostanou rovnou mezi vysoké lávové elementály – klasická „past na nováčky“.
• Dokonce se plánovala oblast „Deathwing Scar“ na západě stepí, která ale nevznikla.
• Burning Steppes jsou jediným schůdným pozemním průchodem ze Stormwindu na sever do Khaz Modanu a Lordaeronu.
• SPOILER: Po Cataclysmu tu najdeš tvory z Outlandu: dva ravagery (Venomspine a Azelisk) a nether raye Ornata.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Eitrigg (Horda) dostal pro klan Blackrock milost. Moira Thaurissan vládne Dark Iron na straně Aliance. Po čtvrté válce panuje v oblasti nejistý „příměří a opatrná důvěra“.]] },
})

secrets("Burning Steppes", [[• Ragnaros roztavil hory a vykoval sopku Blackrock Mountain.
• Anduin Lothar padl od Orgrima Doomhammera poblíž sopky.
• Z Redridge sem chodí nováčci a končí u lávových elementálů.
• SPOILER: Po Cataclysmu zde najdeš tvory z Outlandu (ravagery a nether raye).]])

-------------------------------------------------------------------------------
-- Swamp of Sorrows
-------------------------------------------------------------------------------
chapters("Swamp of Sorrows", {
    { "Atal'ai a utopený chrám", [[Swamp of Sorrows vznikla v severní části prastarého mega-močálu Black Morass. Rozhodující událostí byli Atal'ai, odpadlá trollí frakce, která kolem 1 500 BDP uprchla před pádem říše Gurubashi a postavila Temple of Atal'Hakkar, kde uctívala temného loa Hakkara the Soulflayer. Dračí Aspekt Ysera se o rituálech dozvěděla a „uvolnila svou moc na kultisty“: utopila chrám v největší bažině a postavila zelené draky pod Eranikem, aby další vyvolání zabránili.]] },
    { "První válka a zrod Blasted Lands", [[Za první války zřídila Horda tři osady: Rockard, Stonard a Kyross. Po zničení Temné brány v 6 ADP se jižní část stala Blasted Lands a severní si ponechala jméno Swamp of Sorrows na památku obětí druhé války.]] },
    { "Místa a jejich příběhy", [[Stonard je orčí pevnost obnovená do dřívější slávy v roce 25 ADP a slouží jako základna pro badatele zkoumající artefakty, rostliny a zvěř. Splinterspear Junction je malá hordská osada. Temple of Atal'Hakkar (Sunken Temple) je prastará trollí svatyně a nejvýznamnější místo zóny – dungeon pro úrovně 50–60. Pool of Tears leží u chrámu a je spojený s magickým výzkumem. Stagalbog a Purespring Cavern/Itharius's Cave jsou divoké oblasti a jeskyně. The Shifting Mire a Misty Valley jsou pohyblivá bahnitá území.]] },
    { "Postavy a zajímavosti", [[• Jammal'an the Prophet býval vůdcem Atal'ai.
• Ysera a její družka Eranikus jsou historicky spojeni s utopením chrámu.
• Název zóny prý odkazuje na „Swamp of Sadness“ z Nekonečného příběhu, kde se utopí kůň Artax.
• Za druhé války potřebovala Turalyonova armáda týden na cestu k hranicím a dalších pár dní k Temné bráně.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V roce 26 ADP přistáli draenejové z havarovaného Exodaru a založili The Harborage (původně neutrální, později spojenec Aliance). Po Cataclysmu Aliance postavila Marshtide Watch proti Hordě a gobliní Bogpaddle je neutrální letovisko. Za čtvrté války se v Misty Reed Farm skrýval Varok Saurfang.]] },
})

secrets("Swamp of Sorrows", [[• Název odkazuje na „Swamp of Sadness“ z Nekonečného příběhu (kůň Artax).
• Chrám Atal'Hakkar utopila Ysera a postavila k němu zelené draky pod Eranikem.
• SPOILER: Po Cataclysmu vyrostlo gobliní letovisko Bogpaddle.]])

-------------------------------------------------------------------------------
-- Blasted Lands
-------------------------------------------------------------------------------
chapters("Blasted Lands", {
    { "Z močálu na rudou hlínu", [[Blasted Lands byly původně močálem Black Morass. Zničil je Medivh, když otevřel Temnou bránu a vpustil do Azerothu orkskou Hordu v první válce. Arkánní magie orků byla tak silná, že „pohltila močál a nechala suchou rudou hlínu“. Po zničení brány za druhé války vznikl Nethergarde Keep jako trvalý strážce.]] },
    { "Plamenná legie se vrací", [[Plamenná legie později znovu otevřela Temnou bránu kolem 26 ADP. Do roku 25 ADP stihly démonické síly pod Razelikhem the Defilerem zkazit místní ogry a členy Shadow Council v kult Shadowsworn.]] },
    { "Místa a jejich příběhy", [[Nethergarde Keep je hlavní alianční pevnost, postavená na žádost Archmage Khadgara a Kirin Tor, aby se invaze z Draenoru neopakovala. Dreadmaul Hold (Okril'lon Hold) je hordská pevnost; ogři Dreadmaul původně sloužili démonickým pánům. Rise of the Defiler je místo, kde dobrodruzi porazili Razelikha a zlomili moc Shadowsworn. The Dark Portal je dimenzionální brána do Outlandu, opakovaně ničená i obnovovaná. Surwich je rybářská vesnice následovníků zkaženého druida Marla Wormthorna. Altar of Storms je rituální místo Shadowsworn, které postavila Lady Sevine k vedení démonické moci. Serpent's Coil obývají nagové kmene Bloodwash.]] },
    { "Postavy a zajímavosti", [[• Lord Kazzak je mocný démon, který velí silám Plamenné legie v Tainted Scar.
• Lady Sevine, Archmage Allistarj a Grol the Destroyer vedli Shadowsworn a dostali nesmrtelnost za věčnou službu.
• Design Blasted Lands prý inspiroval kanadský Greater Sudbury v Ontariu, důlní město s pustou krajinou a zčernalými skalami.
• Původní manuál Warcraftu naznačoval, že Temná brána vytvořila močál, ne poušť – významná změna lore.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Za Cataclysmu se oblasti zmocnila Horda (Okril'lon) a snaha druida Marla Wormthorna o obnovu selhala a vytvořila zkažený Tainted Forest. Blood elfové z Reliquary zřídili tábor pro lov démonických artefaktů. V roce 31 ADP zaútočila Iron Horde přes Temnou bránu z jiného světa.]] },
})

secrets("Blasted Lands", [[• Původní manuál Warcraftu naznačoval, že Temná brána vytvořila močál.
• Lord Kazzak straší v Tainted Scar.
• Design zóny prý inspiroval kanadský Greater Sudbury.
• SPOILER: Po Cataclysmu zde vznikl Tainted Forest.]])

-------------------------------------------------------------------------------
-- Deadwind Pass
-------------------------------------------------------------------------------
chapters("Deadwind Pass", {
    { "Prokletí starší než Karazhan", [[Zkáza Deadwind Pass je starší než samotný Karazhan. Nekrolyt Sataiel s kosou Ulthalesh, kterou mu daroval Sargeras, systematicky požíral duše a vysával život ze země. Vznikl tak „pomník hněvu Legie“, magický uzel, ve kterém později stála věž Karazhan.]] },
    { "Karazhan a Medivh", [[Strážkyně Aegwynn postavila Karazhan zhruba 600 let před první válkou jako útočiště před Council of Tirisfal; čerpala z ley linií této oblasti. Její syn Medivh věž zdědil, ale posedl ho Sargeras. Když ho Anduin Lothar a Khadgar porazili, jeho smrt uvolnila fel energii, která prokletím zasáhla Deadwind Pass a proměnila nedaleký Brightwood v Duskwood. Věž se poté sama zapečetila.]] },
    { "Místa a jejich příběhy", [[Karazhan je centrální věž, kdysi Medivhovo sídlo, dnes dimenzionální uzel, který hlídá Violet Eye. Abandoned Kirin Tor Camp byl výzkumnou stanicí Archmage Arrexise; katastrofální démonický rituál tu zabil všechny učně. Ariden's Camp byl základnou obchodníka-šarlatána Aridena, kterého Medivh proklel, aby věčně lovil artefakty jako Dark Riders. Master's Cellar jsou ruiny lidského sídla; později tu sídlil kult černého draka Nalice. Grosh'gok Compound je pevnost ogrů Deadwind. Karazhan Catacombs jsou podzemní jeskyně plné agresivních duchů.]] },
    { "Zajímavosti", [[• V knize „The Last Guardian“ je oblast, kde stojí Karazhan, popsána jako tvar lebky; ve hře tomu tak není.
• V zóně nejsou žádné bylinky ani rudy.
• Oblast prý může představovat původní Borderlands z Warcraftu I.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V době Legionu se Dalaran přesunul přímo nad Karazhan a Medivh přerušil dimenzionální spojení, aby věž Legie nemohla použít jako bránu mezi světy. Poté oblast sužovali worgeni Nightbane, přitahovaní Scythe of Elune.]] },
})

secrets("Deadwind Pass", [[• V knize The Last Guardian má oblast tvar lebky (ve hře ne).
• Ariden a jeho Dark Riders jsou prokletí lovci artefaktů.
• SPOILER: V době Legionu se Dalaran přesunul nad Karazhan.]])
