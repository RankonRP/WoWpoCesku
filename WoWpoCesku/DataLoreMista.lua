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
