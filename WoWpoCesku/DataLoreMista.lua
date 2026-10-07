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
