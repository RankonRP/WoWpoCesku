-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: rozšířené lore dungeonů – další kapitoly příběhu, příběhy bossů navíc a easter eggy.
-- Texty jsou psané vlastními slovy podle Warcraft Wiki (warcraft.wiki.gg) a dalších veřejných zdrojů; ve WoW Forever se může něco lišit.
-- Načítá se po DataDungeony a DataBossLore a jen DOPLŇUJE existující text (nic nepřepisuje).

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
-- The Deadmines
-------------------------------------------------------------------------------
chapters("The Deadmines", {
    { "Zlato, které živilo království", [[Před První válkou patřily Deadmines k největším zlatým dolům lidských zemí. Podle kronik z nich pocházela zhruba třetina pokladu Stormwindu, takže jejich ztráta byla pro království citelná. Když doly za války opustili, začaly se o nich vyprávět historky o duchách a prokletí – a právě tahle pověst z nich později udělala ideální úkryt.]] },
    { "Edwin VanCleef: stavitel, který se stal rebelem", [[VanCleef nebyl od začátku zločinec. Byl zvolen předsedou cechu kameníků (Stonemasons' Guild), který po zničení Stormwindu Hordou stavěl město znovu a podílel se i na stavbě pevnosti Nethergarde u Temné brány. Šlechta ale stavitele odbyla: za práci se nezaplatilo a království se utápělo v dluzích za válku. Když VanCleef žádal vyplacení mezd, Dům šlechty cech rozpustil.

Následovaly nepokoje, při kterých zahynula královna Tiffin a král Varian přísahal pomstu. VanCleef a jeho lidé se ukryli ve Westfallu a z tuláků bez práce se stali Defiasové – bratrstvo, které z dovedností stavitelů (tajné chodby, zámky, nenápadné pohyby) vybudovalo zlodějskou organizaci. Zlaté doly se jim hodily jako základna i jako zdroj peněz.]] },
    { "Loď, která měla změnit válku", [[V hlubinách dolů nechal VanCleef s pomocí goblinů stavět obří válečnou loď, nazývanou Juggernaut, se kterou chtěl vyplout proti Stormwindu. Proto se v dolech potkávají hornické stroje, goblinské dílny a nakonec námořní kajuty: doly se pomalu proměnily v loděnici. Dřevo dodával Sneed ze své pily, železo Gilnid ze své slévárny a o posádku se staral kapitán Greenskin se svým prvním důstojníkem a kuchařem.]] },
    { "Pomsta na obou stranách (spoiler z pozdějšího příběhu)", [[SPOILER: V dalších příbězích se ukazuje, že padnout může i ten, kdo sám podvádí. VanCleef kdysi oklamal pirátského kapitána Jeriase Bloodveina a Bloodvein se do dolů vydal pomstít se. Podle jednoho výkladu při tom padli Sneed, Gilnid i Rhahk'Zor a mladík James Blackridge nakonec Bloodveina zabil.

Když hrdinové VanCleefa v klasickém WoW zabili, jeho malá dcera Vanessa celou scénu viděla. Po letech převzala Defiasy a plán s lodí oživila – to už ale patří do pozdějších verzí hry a ve WoW Forever (klasika) to nezažiješ.]] },
})

boss("The Deadmines", "Rhahk'Zor", [[Je to první a nejsnazší překážka v dolech: ogr, kterého si VanCleef najal jako předáka dělníků, protože umí nést těžké kameny i těžké rány. Hlídá dveře do hlubšího dolu a bojuje bez rafinovanosti, hrubou silou. Právě na něm se nováčci učí, že Deadmines nejsou jen hluboká jeskyně, ale pevnost.]])

boss("The Deadmines", "Sneed", [[Goblinský dřevorubec (lumbermaster), který VanCleefovi zajišťuje dřevo na loď. Jezdí v obřím stroji Sneed's Shredder a teprve po jeho zničení bojuje pěšky. Mezi hráči koluje známý vtip: ve stroji měl vlasy, ale po zničení stroje je najednou holohlavý. Podle příběhu ho později zabil pirát Jerias Bloodvein.]])

boss("The Deadmines", "Gilnid", [[Podle příběhu byl vyhnán z Booty Bay, když jeho šílené experimenty vymkly z rukou. VanCleef mu nabídl práci i peníze na výzkum, a tak Gilnid řídí slévárnu, kde se odlévají děla a střelivo pro loď. Je nezvykle velký i na goblina a pracovní morálku vynucuje hláškami – o přestávce nechce ani slyšet.]])

boss("The Deadmines", "Mr. Smite", [[Tauren, který z lodní kajuty vyrostl na pirátského prvního důstojníka. Jeho bojový styl je divadelní: nejdřív bojuje se slabou zbraní a před zraky hrdinů si běhá pro stále hrozivější nářadí. Při poklesu životů přeskočí k dvojici sekáčů a nakonec sáhne po obřím kladivu. Pozdější příběhy naznačují, že se pod jiným jménem objevil znovu – fanoušci si ho spojují s taurenem Yorikem Sharpeyem.]])

boss("The Deadmines", "Captain Greenskin", [[Goblinský kapitán z Booty Bay, který dřív velel celé pirátské flotile, než si ho VanCleef najal. Veliteluje na palubě Juggernauta a posádku tvoří Smite jako první důstojník a Cookie jako kuchař. Za svého působení v dolech se údajně družil i s pirátskými Bloodsail Buccaneers.]])

boss("The Deadmines", "Cookie", [[Murlok, který na VanCleefově lodi dělá kuchaře pod kapitánem Greenskinem. Používá kuchyňské vybavení jako zbraně (podle jeho kořisti: paličku na maso, vařečku a ochucovadla) a když je zraněný, utíká a přitáhne s sebou další nepřátele. Je to jediný volitelný boss původních Deadmines.]])

boss("The Deadmines", "Edwin VanCleef", [[Jméno VanCleef prý odkazuje na herce Lee Van Cleefa ze spaghetti westernů. V příběhu je to především tragická postava: dobrý stavitel, kterému odmítli zaplatit, a vůdce, který místo soudu zvolil pomstu. Jeho přítel z mládí, mistr špionů Mathias Shaw, v něm viděl budoucího člena tajné služby SI:7, ale VanCleef zvolil jinou cestu.]])

secrets("The Deadmines", [[• Obří vodní brána, kterou vidíš ze severního Stranglethornu, vede do Deadmines – hrdinům je ale uzavřená.
• Zkratka „VC“ pro Deadmines vznikla proto, aby se dungeon nepletl s Dire Maul („DM“).
• Pod Deadmines se prý skrývá pozůstatek testovací oblasti původního Outlandu z doby vývoje hry.
• Mathias Shaw, šéf SI:7, se do dolů údajně vydal sám.
• SPOILER: Cookie je v pozdějších verzích povýšen na kapitána; jeho syn se jmenuje Souplrgr.]])

-------------------------------------------------------------------------------
-- Wailing Caverns
-------------------------------------------------------------------------------
chapters("Wailing Caverns", {
    { "Sen o zelených Barrens", [[Za celým příběhem stojí Naralex, noční elf, arcidruid Cenarionského kruhu. Barrens považoval za hřích proti přírodě: kdysi tu prý rostly lesy a on chtěl vyprahlou zemi vrátit zpět. Objevil proto podzemní prameny pod jeskyněmi a rozhodl se je propojit se Smaragdovým snem, říší, ve které příroda žije v nedotčené podobě. Věřil, že když sen napojí na vodu, země se zazelená.]] },
    { "Noční můra, která si vzala jeho žáky", [[Když Naralex upadl do hluboké meditace, aby cesty spojil, zasáhla ho Smaragdová noční můra – zkažená zrcadlová podoba snu. Podle jeho vlastních slov ho uchopila drápy a rozervala mu mysl. Naralex nemohl procitnout a jeho nejbližší žáci se kolem něj proměnili: stali se hadími kultisty, Druidy Fangu, a zvířata v jeskyních zmutovala v „deviate“ tvory, kteří vypadají jako výplod snu.]] },
    { "Jak se v jeskyních žije", [[Vchod do jeskyní z čelního pohledu připomíná hadí lebku, což k pověsti místa sedí. Uvnitř se dungeon větví: kromě hlavní cesty ke čtyřem Fanglordům jsou tu volitelní bossové, třeba želva Kresh nebo Verdan Everliving, strážce místní vegetace, který se po zkáze proměnil z mírumilovného obra v hrozbu. Cesta bývá hodně klikatá – pro nováčky to bývá jedna z nejdelších cest na první dungeony.]] },
    { "Probuzení a poslední zkouška", [[Po zabití čtyř Fanglordů doprovodíš Naralexova věrného žáka do centrální komnaty, kde mistr spí. Zatímco se ho snaží probudit, vynoří se ze snu noční můry – a nakonec obří albín-murlok Mutanus the Devourer, který se z Naralexových nočních můr dostal přímo do Azerothu. Podle příběhu ho vyslala neznámá síla zkaženého snu, aby nikdo Naralexe neprobudil.

Po probuzení se Naralex promění v sovu a odletí; jeho žák se (podle známého vtipu hráčů) vznese jako stojící tauren – mezi hráči se mu říká „hovercow“.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Naralex se v dalších příbězích vrací v hlavní roli. Po Cataclysmu se podzemní zásobníky vody protrhly a v jeskyních rostlo všechno bez kontroly, takže se Naralex musel starat hlavně o zastavení škod. Zkáza se ale nezastavila: na přelomu pozdějších příběhů o Azerite se o jeskyně přely obě frakce a zkaženost tam stále doutnala. Verdan Everliving je v pozdějších příbězích potvrzen jako mrtvý.]] },
})

boss("Wailing Caverns", "Lord Serpentis", [[Serpentis byl původně Naralexův žák. Chtěl se stát shan'do, uctívaným učitelem, jako jeho mistr – a právě tahle touha ho zlomila a vedla do šílenství. Do hry přinesl i proslulou hlášku „I am the serpent king, I can do anything“, parodii na citát Jima Morrisona. Dabuje ho Chris Metzen, významný člověk z vývoje Warcraftu.]])

boss("Wailing Caverns", "Lady Anacondra", [[Jedna ze čtyř Fanglordů, hadích druidek, které sloužily Naralexovi. Bydlí v části jeskyní zvané Screaming Gully a z učednice, která chtěla pomáhat přírodě, se stala služebnicí noční můry.]])

boss("Wailing Caverns", "Lord Cobrahn", [[Další z Druidů Fangu, který se proměnil v hadí podobu. Před zkažením byl žákem Naralexe a dnes drží s Lordem Pythasem Pit of Fangs.]])

boss("Wailing Caverns", "Lord Pythas", [[Žák Naralexe, který s Cobrahnem hlídá Pit of Fangs. Z učedníka se stal druid slibující mistrovi věrnost – a nakonec jeho zkaženým stínem.]])

boss("Wailing Caverns", "Mutanus the Devourer", [[Obří albín-murlok, který se vynořuje ze zkaženého snu přesně ve chvíli, kdy se hrdinové snaží Naralexe probudit. Uzavírá celé putování a je to hmatatelná podoba zkaženosti Smaragdového snu – tvor, který přišel z nočních můr přímo do Barrens. Vzpomínka na něj se objevuje i v pozdějších instancích a Hearthstone si z něj udělal legendární kartu s poznámkou, že dokud Naralex spí, nemůže se k němu Mutanus dostat.]])

boss("Wailing Caverns", "Verdan the Everliving", [[Strážce jeskyní vzniklý z místní vegetace, kdysi mírumilovný obr. Noční můra z něj udělala nepřítele všeho, co do jeskyní vstoupí. Jeho Grasping Vines srazí a na chvíli znehybní všechny kolem.]])

secrets("Wailing Caverns", [[• Vchod z čelního pohledu vypadá jako hadí lebka.
• Naralex je v cestovní podobě los; po probuzení se v dungeonu proměňuje v sovu.
• Kresh je želva, kterou může ochočit lovec.
• SPOILER: Po Cataclysmu se jeskyně změnily; Naralex je v pozdějších příbězích důležitou postavou.]])

-------------------------------------------------------------------------------
-- Shadowfang Keep
-------------------------------------------------------------------------------
chapters("Shadowfang Keep", {
    { "Původně Silverlaine Keep", [[Dnešní Shadowfang Keep se původně jmenoval Silverlaine Keep, podle barona Silverlainea, který tu sídlil se svou rodinou a vojáky. Hrad stál ve Silverpine Forest a patřil k šlechtickému zázemí království Gilneas. Za třetí války, kdy Plaga ohrožovala celý svět, se tohle tiché místo změnilo v jedno z největších tragických míst celé země.]] },
    { "Arugal a vlkodlaci", [[Archmage Arugal byl vážený čaroděj z Gilneasu, který se přidal ke Kirin Tor v Dalaranu. Když se Plaga začala blížit ke Gilneasu, požádal ho král Genn Greymane o ochranu. Arugal navrhl, že přivolá worgeny, záhadné tvory, které dlouho studoval, aby bránili království před nemrtvými.

Plán se zvrtl. Worgeni sice Plagu odrazili, ale pak se obrátili proti samotným obráncům a začali šířit kletbu po zemi. Zničili i hrad barona Silverlainea; ten nakonec padl do tmy a zříceniny.]] },
    { "Otec vlků", [[Plný viny nazval Arugal hrad Shadowfang Keep a worgeny přijal za své „děti“. Založil kult, který kletbu šířil dál, a z kdysi respektovaného mága se stal šílený vládce zříceniny. V původním WoW ho nakonec zabili dobrodruzi. Forsaken ho nechali zlikvidovat poté, co zjistili, že za proměnou jejich agenta stojí právě on.

Arugal se prý spoléhal na kouzelné předměty, které nahrazovaly jeho slabší magii. Některé z jeho worgenů navíc zachovaly lidský rozum díky jeho zaříkadlům – tajemství, které zmizelo spolu s ním.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Arugala vzkřísil Lich King jako stín a poslal ho do Grizzly Hills, kde měl lovce měnit na worgeny. Po Cataclysmu hrad obsadili gilneaští šlechtici Vincent Godfrey, baron Ashbury a lord Walden. Později z něj Forsaken udělali továrnu na mor proti Gilneasu a nakonec se v něm usadila smečka Bloodfang. To už ale patří k pozdějším příběhům a ve WoW Forever (klasika) to nezažiješ.]] },
})

boss("Shadowfang Keep", "Baron Silverlaine", [[Pán hradu dřív než padl. Zabili ho worgeni, které přivolal Arugal z Emerald Dream, a s ním padla i jeho rodina. Podle zpráv se jeho duch vrací: dnes sám přivolává worgeny, aby potrestal vetřelce ve svém bývalém domově. Baronku Silverlaine připomíná kořist jako medailon, takže jeho žena v příběhu hrála větší roli, než by se zdálo.]])

boss("Shadowfang Keep", "Odo the Blindwatcher", [[Slepý worgen, který dřív bydlel ve dřevěné stavbě u hradu se dvěma netopýry. Slepota ho naučila spoléhat na ostatní smysly, stejně jako netopýry. Po smrti ho přivolává duch Silverlainea jako ducha vlkodlaka; v pozdějších verzích hry z něj proto není samostatný boss, ale pomocník v boji s baronem.]])

boss("Shadowfang Keep", "Archmage Arugal", [[Viz kapitola o příběhu: z mága, který zachraňoval Gilneas, se stal šílený otec vlků. Rozmetala ho vlastní pýcha: chtěl obranu, vytvořil kletbu. I jeho vzhled v dungeonu připomíná, že se spoléhal na kouzelné předměty víc než na vlastní magii.]])

secrets("Shadowfang Keep", [[• Hrad se původně jmenoval Silverlaine Keep.
• Odo the Blindwatcher kdysi býval samostatný boss, dnes ho Silverlaine přivolává při souboji.
• Baronku Silverlaine připomíná kořist (Baroness Silverlaine's Locket).
• SPOILER: Po Cataclysmu zde sídlí gilneaští šlechtici a později Forsaken.]])

-------------------------------------------------------------------------------
-- Blackfathom Deeps
-------------------------------------------------------------------------------
chapters("Blackfathom Deeps", {
    { "Lathar'Lazal – Sídlo nebes", [[Dnešní Blackfathom Deeps byly kdysi chrámem nočních elfů zasvěceným bohyni Elune a jmenovaly se Lathar'Lazal, „Sídlo nebes“. Podle příběhu ho vystavěla královna Azshara na západním okraji dávné Kalimdoru, se schodišti a mosty zdobenými drahokamy a magickými jezery. Při Velkém roztříštění (Great Sundering) se chrám propadl pod hladinu Veiled Sea a zůstal tam ležet jako ruina.]] },
    { "Twilight's Hammer a hydra", [[Do potopeného chrámu se stahovaly šepoty a temné vize. Přilákaly kult Twilight's Hammer, který tu chtěl vykrmit tříhlavou hydru Aku'mai the Devourer – prastarého tvora nesoucího moc Starých bohů. Vůdce kultu, Twilight Lord Kelris, dohlížel na její růst obětními rituály.

Chrám ale nepatřil jen kultu. V jeskyních žije želva Ghamoo-Ra, kdysi mírumilovný obr, kterého kultisté týráním dohnali k šílenství, nagská badatelka Lady Sarevess, murloc Gelihast, který se do chrámu vtrhl násilím a postavil si tu vlastní svatyni, a legendární ryba Old Serra'kis, kterou nikdo nedokáže chytit.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V pozdějších příbězích převzal vedení kultu Twilight Lord Bathiel, který vlastního předchůdce Kelrise hodil Aku'mai k snědku. Hydra rostla a kult potřeboval stále víc obětí. Po Cataclysmu se proti kultu postavil Earthen Ring a pozdější příběhy ukazují, že Aku'mai nakonec zahynul (Rexxar a Zekhan potvrdili, že jeho mršina zůstala mrtvá). Mezi fanoušky se mluví i o nesrovnalosti, že Aku'mai bývá psán jednou jako „ona“ (Princess of the Deep) a jindy jako „on“.]] },
})

boss("Blackfathom Deeps", "Aku'mai", [[Tříhlavá hydra, o které se říká, že je darem prastarých Starých bohů. Kult Twilight's Hammer ji nacházel jako střed uctívání a Kelris ji krmil vlastními členy. Je to symbol toho, že pod mořem leží starší a horší zlo než kdy dřív: ne démon z jiného světa, ale prastará bytost z hlubin Azerothu.]])

boss("Blackfathom Deeps", "Twilight Lord Kelris", [[Vůdce kultu Twilight's Hammer v hlubinách chrámu. Vede obřadní rituály, kterými vykrmuje hydru Aku'mai, a sám se na ně nechce dívat zblízka. V pozdějších příbězích ho jeho vlastní nástupce Bathiel předhodí hydře.]])

boss("Blackfathom Deeps", "Lady Sarevess", [[Nagská badatelka, která v chrámu zkoumá magické ochrany. Nagové v hlubinách chrámu hledají prastará tajemství.]])

boss("Blackfathom Deeps", "Gelihast", [[Murloc, který se do chrámu vloudil násilím a postavil si tu vlastní svatyni.]])

boss("Blackfathom Deeps", "Ghamoo-ra", [[Obří želva, která byla dřív mírumilovná. Kultisté ji týrali, až ji dohnali k šílenství, a z hlídače jezera se stalo nebezpečné zvíře. Je to hořká připomínka, že kult ničí i to, co nepatří k jeho nepřátelům.]])

boss("Blackfathom Deeps", "Old Serra'kis", [[Legendární ryba (thresher), kterou se mnozí snažili chytit, ale nikdo nedokázal. V příběhu je to spíš pověst než nepřítel: o jeskyni se říká, že tu žije něco, co nelze ulovit.]])

secrets("Blackfathom Deeps", [[• Chrám se původně jmenoval Lathar'Lazal – „Sídlo nebes“.
• Postavila ho podle příběhu královna Azshara pro bohyni Elune.
• Aku'mai bývá v různých pramenech označována jako „ona“ nebo „on“.
• SPOILER: V pozdějších příbězích hydru krmí Twilight Lord Bathiel, který hodil Kelrise Aku'mai.]])

-------------------------------------------------------------------------------
-- The Stockade
-------------------------------------------------------------------------------
chapters("The Stockade", {
    { "Vězení pod kanály Stormwindu", [[Stormwind Stockade je městské vězení pod kanály Stormwindu. Slouží jako opravdové vězení i jako politický nástroj: šlechta tu drží zajatce, které nechce nebo nemůže popravit, a rozhoduje, kdy je pustí. Dlouho tu byl klid, dokud jeden mladý strážce jménem Mac nebyl zabit vězni, kteří si vyráběli šátky s odznakem Defias.]] },
    { "Povstání ve vězení", [[V roce 25 po Dark Portal (ADP) vypuklo ve vězení povstání vedené Bazilem Threddem, jedním z poručíků Edwina VanCleefa. Thredd byl zadržen při nepokojích, při kterých zemřela královna Tiffin, a ve vězení vedl bandity Defias. Správce věznice Thelwater chtěl jeho popravu. Několik měsíců před povstáním ho pravidelně navštěvoval podivný návštěvník jménem Maelik, který se později ukázal jako defiaský agent Marzon the Silent Blade.]] },
    { "Zajatci s politickou váhou", [[Targorr the Dread, orc z Blackrocku, čekal na popravu, ale šlechtici odkládali rozsudek jako páku v politických hrách. Dextren Ward, vykradač hrobů, byl uvězněn, přestože měla Rada Darkshire pravomoc ho potrestat sama, takže na něj nakonec poslali nájemné vrahy. Kam Deepfury, vězeň z Dark Iron, byl tajně cílem atentátu agentů z Ironforge, kteří obcházeli oficiální cestu.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Při Cataclysmu zemětřesení rozzuřilo živly pod vězením a spousta vězňů zahynula. V pozdějších příbězích tu seděl i Varok Saurfang po bitvě o Lordaeron, ale s tajnou pomocí SI:7 uprchl kanály. A po válce Anduin osobně dohlížel na spravedlivé zacházení s vězni z řad Forsaken.]] },
})

boss("The Stockade", "Bazil Thredd", [[Poručík Edwina VanCleefa a poslední boss Stockade. Do vězení se dostal po nepokojích, při kterých zahynula královna Tiffin, ale i za mřížemi vedl defiaské bandity jako vůdce. Boj s ním je přímočarý: dva strážní po boku, Smoke Bomb a Battle Shout. Jeho hlava je důkazem pro quest The Stockade Riots.]])

boss("The Stockade", "Targorr the Dread", [[Orc z Blackrocku, který čekal na popravu. Šlechta ji ale odkládala, protože ho potřebovala jako páku v politických hrách.]])

boss("The Stockade", "Dextren Ward", [[Vykradač hrobů uvězněný v Stockade. Rada Darkshire měla dost moci, aby ho potrestala sama, a přesto ho tu nechala; nakonec na něj poslala nájemné vrahy.]])

boss("The Stockade", "Kam Deepfury", [[Vězeň z Dark Iron, na kterého tajně míří atentát: agenti z Ironforge obcházejí oficiální cestu a chtějí ho zlikvidovat bez soudu.]])

secrets("The Stockade", [[• Povstání vězňů vypuklo v roce 25 po Dark Portal (ADP).
• Bazil Thredd byl poručíkem Edwina VanCleefa a jeho návštěvník Maelik byl ve skutečnosti defiaský agent.
• Za quest The Stockade Riots potřebuješ hlavu Bazila Thredda.
• SPOILER: V pozdějších příbězích tu byl uvězněn i Varok Saurfang.]])

-------------------------------------------------------------------------------
-- Gnomeregan
-------------------------------------------------------------------------------
chapters("Gnomeregan", {
    { "Technické hlavní město gnómů", [[Gnomeregan býval proslulým technickým městem gnómů v severozápadním Dun Morogh. Gnómové z něj vládli vynálezům, výtahům, strojům a vůbec všemu, co funguje na páru a ozubená kola. Dnešní dungeon působí jako jedna velká komediální dílna: stroje tu bučí, blikají a občas vybuchují.]] },
    { "Zrada zevnitř", [[Když město napadli troggové, přišel Sicco Thermaplugg, nejbližší přítel a hlavní rádce High Tinkera Gelbina Mekkatorquea, s návrhem: zaplavit město radioaktivním plynem. Thermaplugg ale tajně žárlil, že vládne jiný, a údaje o bezpečnosti zfalšoval. Chtěl, aby plyn zabil spoustu gnómů, a pak z toho mohl obvinit Gelbina a převzít moc.

Plán se zhroutil. Záření zahubilo většinu obyvatel (příběh uvádí zhruba osm z deseti gnómů) a zbylé proměnilo v „leper gnomes“, i samotného Thermaplugga. Gnómové zůstali Gelbinovi věrní a šílený Thermaplugg se prohlásil králem gnómů.]] },
    { "Operace Gnomeregan", [[Přeživší gnómové uprchli do Ironforge s přísahou, že se jednou vrátí. Thermaplugg vládl zničenému městu z Tinkers' Court a ovládal leper gnómy i troggy. Nakonec ho porazili hrdinové během takzvané Operation: Gnomeregan. Jeden román popisuje, jak mu Gelbin usekl nohy a nechal ho napospas toxické pustině, kterou sám vytvořil.]] },
    { "Zajímavosti", [[• Jméno Thermaplugg je slovní hříčka na „sicko“ (cvok).
• V instanci je bezpečná zóna s obchodníky a NPC přátelská k Alianci.
• Hůl Hydrocane z Viscous Fallout dává trvalé dýchání pod vodou a hodí se na každé úrovni.
• Pozdější doplněk: tajný boss Endgineer Omegaplugg pro hráče s maximální úrovní.
• Pozor na Dark Iron agenty, kteří pokládají nášlapné miny, a na Arcane Nullifiers, které odráží kouzla zpět na čaroděje.]] },
})

boss("Gnomeregan", "Mekgineer Thermaplugg", [[Dřív se jmenoval Sicco a byl nejbližším přítelem a hlavním poradcem High Tinkera Gelbina Mekkatorquea. V tichosti ho ale žrala závist. Když troggové napadli město, navrhl záplavu radioaktivním plynem a zfalšoval, že je bezpečný. Plán se obrátil proti němu, zasáhl i jeho samotného a z Thermaplugga se stal zmutovaný šílenec, který se prohlásil králem gnómů. Jeho jméno hraje na „sicko“ a Hearthstone si z něj udělal postavu posedlou pletením.]])

boss("Gnomeregan", "Grubbis", [[Troggský náčelník, který se usadil ve vyvrženém Gnomeregan poté, co gnómové město opustili.]])

boss("Gnomeregan", "Viscous Fallout", [[Zmutovaná radioaktivní bytost z toxických zbytků v Gnomeregan. Padá z ní hůl Hydrocane, která dává trvalé dýchání pod vodou.]])

secrets("Gnomeregan", [[• Jméno Thermaplugg je slovní hříčka na „sicko“.
• Hůl Hydrocane z Viscous Fallout dává trvalé dýchání pod vodou.
• Dark Iron agenti pokládají miny – ničí je hned, jak je vidíš.
• SPOILER: Později se gnómové do města vracejí při Operation: Gnomeregan; Thermaplugg je v dalších příbězích mrtvý.]])

-------------------------------------------------------------------------------
-- Razorfen Kraul
-------------------------------------------------------------------------------
chapters("Razorfen Kraul", {
    { "Trnitý domov quilboarů", [[Razorfen Kraul leží v jižních Barrens a je pradávným domovem quilboarů. Celý komplex prorůstají obrovské trnité liány, o kterých se věří, že vyrostly z těla polobožského Agamaggana. Před deseti tisíci lety tento prastarý polobůh bojoval proti Plamenné legii a padl; z jeho krve vyrašily trnité vinice, které quilboarové uctívají jako posvátné.]] },
    { "Charlga Razorflank", [[Vládne tu Charlga Razorflank, stará šamanka zvaná „the Crone“. Ovládla osadu a vede quilboary šamanským způsobem; pod jejím vedením útočí na rivalské kmeny i na osady Hordy. Dungeon je plný quilboarů, bažinných tvorů a krystalových nestvůr.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Krátce před válkou o trny (War of the Thorns) se do dungeonu vkradla Sylvanas Windrunner s Nathaniem Blightcallerem a útočili na quilboary, aby poslali anima do Maw k Žalářníkovi. To už patří do pozdějších příběhů a ve WoW Forever (klasika) to nezažiješ.]] },
})

boss("Razorfen Kraul", "Charlga Razorflank", [[Stará šamanka, která ovládla Razorfen Kraul. Říká se jí „the Crone“ a quilboary vede šamanským způsobem. Pod jejím vedením quilboarové útočí na rivalské kmeny i na osady Hordy.]])

boss("Razorfen Kraul", "Roogug", [[Quilboarský šaman, který dohlíží v dungeonu na rituály (v pozdějších verzích se mu říká Geomagus Overseer).]])

secrets("Razorfen Kraul", [[• Trnité vinice vyrostly podle legendy z krve polobožského Agamaggana.
• Quilboarové Agamaggana uctívají jako polobožského předka.
• SPOILER: Před válkou o trny sem vtrhli Sylvanas a Nathanos.]])

-------------------------------------------------------------------------------
-- Ragefire Chasm
-------------------------------------------------------------------------------
chapters("Ragefire Chasm", {
    { "Troggové a Magatha", [[Sopečné jeskyně pod Orgrimmarem původně obývali nepřátelští troggové zvaní Ragefire. Taurenská věštkyně Magatha se s nimi pokusila vyjednat mír, ale našla jen nepřátelství, které by mohlo Hordě v budoucnu hrozit.]] },
    { "Searing Blade a Burning Blade", [[Do jeskyní se uchýlila frakce Shadow Council jménem Searing Blade. Vedli ji tři vůdci: Taragaman the Hungerer (felguard), Jergosh the Invoker (černokněžník) a Bazzalan (satyr). Podle příběhu plánovali rozvrátit a zničit všechno, co Horda v těchto zemích vybudovala.

Neeru Fireblade, skrytý vůdce klanu Burning Blade, posílal do jeskyně Thrallovy věrné s dvojím záměrem: zbavit se přívrženců válečného náčelníka a otestovat, jak jsou kultisté Searing Blade schopní. Válečný náčelník nakonec nasadil dobrodruhy, aby vůdce kultu zlikvidovali.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu se Dark Shaman ujali jeskyní, vyčistili troggy i Searing Blade a podle zpráv shromáždili armádu nebezpečnou i pro samotný Orgrimmar – později se ukázalo, že stála na straně Garrosha Hellscreama. Mezi fanoušky se také mluví o tom, že přítomnost Ragefire troggů může znamenat titánský trezor pod Orgrimmarem, podobný Uldamanu.]] },
})

secrets("Ragefire Chasm", [[• Neeru Fireblade je skrytý vůdce Burning Blade a testoval Searing Blade, zatímco posílal do jeskyně Thrallovy věrné.
• Přítomnost Ragefire troggů prý může naznačovat titánský trezor pod Orgrimmarem.
• SPOILER: Po Cataclysmu se tu usadili Dark Shaman se spojenci Garrosha Hellscreama.]])

-------------------------------------------------------------------------------
-- Scarlet Monastery (platí pro Graveyard i Library – ty se z tohoto textu odvozují v DataNove.lua)
-------------------------------------------------------------------------------
chapters("Scarlet Monastery", {
    { "Starý klášter Světla", [[Budova začínala jako „Old Monastery“: katedrála a seminář Církve Svatého světla. Arcibiskup Alonsus Faol v ní měl své sídlo a paladinové se tu učili, než se stali rytíři. Dlouho to byl klidný, uctívaný dům víry.]] },
    { "Silver Hand a pád Lordaeronu", [[Po třetí válce a pádu Lordaeronu klášter převzali Rytíři Stříbrné ruky (Knights of the Silver Hand) pod vedením Highlorda Alexandrose Mograinea a změnili ho v obrannou základnu. Řád se později rozštěpil na Scarlet Crusade a Argent Dawn. Šarlatoví si klášter nechali a dali mu nové jméno a smysl.]] },
    { "Pevnost fanatiků", [[Pod vedením High Inquisitor Whitemane a Scarlet Commandera Mograinea se klášter stal vojenskou posádkou a zároveň výslechovým střediskem. Fanatismus Šarlatových rostl: v každém cizinci viděli možného přenašeče moru. Z kláštera se tak stala pevnost podezíravosti, ve které se výslechy a popravy staly rutinou.]] },
    { "Čtyři křídla", [[Klášter má čtyři křídla: Graveyard, Library, Armory a Cathedral. Ve WoW Forever jsou Graveyard a Library samostatné dungeony. Armory a Cathedral zatím do průvodce nepřidáváme.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V dalších příbězích se zbytky Šarlatových seskupily pod High Commanderem Goodchildem, ale zdecimovali je Rytíři Ebon Bladeu, kteří pobili poslední zélóty a vzkřísili některé klíčové postavy včetně Whitemane. Dnes klášter stojí opuštěný.]] },
})

boss("Scarlet Monastery", "Interrogator Vishas", [[Hlavní vyslýchač kláštera (Chief Interrogator) a muž s pronikavým vysokým hlasem. Své řemeslo prý dělá s hrdostí a bez špetky lítosti. Dlouho mučil vězně Vorrela Sengutze a jeho snubní prsten odnesl vlastní ženě Nancy Vishas – právě to je základ questu Vorrel's Revenge, kde jeho zlo vyvrcholí.]])

boss("Scarlet Monastery", "Arcanist Doan", [[Lidský mág, rytíř Stříbrné ruky a později člen Scarlet Crusade, strážce Athenaea v knihovně kláštera. Podle příběhu se podílel na očištění temného krystalu, ze kterého vznikl legendární Ashbringer. Považují ho za jednoho z nejmocnějších mágů Křižáků a věřil, že arkánní magie je klíč k porážce Plagy. Vlastní důležitý klíč, který odemyká přístup k šarlatovým operacím v Plaguelands. Dabuje ho Chris Metzen.]])

secrets("Scarlet Monastery", [[• Původní klášter byl katedrála a seminář Církve Svatého světla.
• Arcanist Doan se prý podílel na očištění krystalu, z něhož vznikl Ashbringer.
• SPOILER: Pozdější příběhy ukazují, jak Rytíři Ebon Bladeu klášter dobyli a vzkřísili Whitemane.]])

-------------------------------------------------------------------------------
-- DRUHÝ PRŮCHOD: hlubší příběhy lokací a bossů
-------------------------------------------------------------------------------

-- The Deadmines: příběh Defias od začátku do konce
chapters("The Deadmines", {
    { "Moonbrook: město nad zlatem", [[Moonbrook je městečko v jihozápadním Westfallu, které dlouho žilo z hornictví a zemědělství. Zlatý důl pod ním dával Stormwindu zhruba třetinu pokladů. Když cech kameníků rozpustili, moc ve městě převzali Defiasové a z opuštěných dolů si udělali velitelství. Po jejich porážce Moonbrook na čas osvobodili hrdinové Aliance, ale hospodářské potíže po válce s Lich Kingem do města přivedly bezdomovce a podmínky pro nový nepokoj byly zase na světě.]] },
    { "Rudé šátky a hodnosti", [[Defiasové nosili rudé šátky a podle materiálu masky se poznávala hodnost. Působili v Elwynn Forest, Duskwoodu a dokonce i ve Dustwallow Marsh. Byli mezi nimi lidé, goblini a další rasy, zkušení zloději i nájemní vojáci. VanCleef je vedl heslem, že si zaplacení vezmou „po jednom poutníkovi“ – loupežemi, ne dobýváním.]] },
    { "Intriky ve Stormwindu", [[Bratrstvo mělo spojence i ve Stormwindu. Podle příběhu vedla ke vzniku problému korupce šlechty a politické machinace kolem lady Katrany Prestor (ve skutečnosti draka Onyxie v lidské podobě), která šlechtu nutila odmítat výplatu. Spiklenci zůstali aktivní i po VanCleefově smrti – to je jeden z důvodů, proč dopis z jeho těla vede ve Stormwindu dál.]] },
    { "Pirát, který chtěl pomstu", [[Jerias Bloodvein, nemrtvý kapitán lodi Garrote a člen pirátů Bloodsail Buccaneers, měl s VanCleefem nevyřízené účty: VanCleef ho podle příběhu podvedl, vzal mu zlato i ženu. Po ztrátách v bojích s Defiasy unesl mladého Jimmyho Blackridge a dva jeho společníky jako náhradní posádku. Při útoku na doly pak Bloodvein padl v souboji na život a na smrt s Jimmym Blackridgem – a tak se únosce stal obětí svého zajatce.]] },
    { "Konec a dědictví", [[Po VanCleefově smrti převzala Defiasy jeho dcera Vanessa a snažila se organizaci obnovit s novým ideovým zaměřením. Jak ale spravedliví členové odcházeli kvůli královským milostem a reformám, Bratrstvo zdegenerovalo v obyčejné lupiče a rozpadlo se na skupiny jako Red Dawn. SPOILER: V pozdějších příbězích se zbylí Defiasové vzdali banditismu a vrátili se k rodinám.]] },
})

boss("The Deadmines", "Rhahk'Zor", [[Jeho pokřik „VanCleef pay big for your heads!“ je jedna z nejznámějších hlášek prvního dungeonu Aliance. V příběhu ho zabili piráti Jeriase Bloodveina při útoku na doly, takže z VanCleefova předáka zbyl jen duch hrozby, kterou vyřvával.]])

boss("The Deadmines", "Miner Johnson", [[Vzácný (náhodný) člen Defias Brotherhood, který čeká v zákoutí před Shredderem mezi horníky. Jeho kořist – pokovený štít Gold-plated Buckler a hornický plášť – ukazuje, že hornictví a zlato v dolech pořád patřily k jádru celého příběhu. Pierce Armor mu umožňuje oslabit brnění nepřátel.]])

boss("The Deadmines", "Edwin VanCleef", [[Podle příběhu byl původně volen předsedou cechu kameníků a stavěl i pevnost Nethergarde. Šlechta mu ale odmítla zaplatit a po rozpuštění cechu vyvolal nepokoje, při kterých zahynula královna Tiffin. Od té doby žije skryt ve Westfallu a vede bratrstvo, které chce Stormwindu „vyúčtovat“ všechno, co mu dluží. Jeho slova, že „celé království Stormwind zaplatí“, jsou důvodem, proč se jeho jméno stalo synonymem pomsty.]])

secrets("The Deadmines", [[• Rudé šátky Defiasů označují příslušnost; materiál masky určuje hodnost.
• Jerias Bloodvein je nemrtvý pirát (Forsaken), který unesl Jimmyho Blackridge – příběh je z komiksu Legends.
• Rhahk'Zor křičí „VanCleef pay big for your heads!“.
• Miner Johnson je náhodný vzácný spawn (nemusí se objevit).]])

-- Wailing Caverns: další příběh
chapters("Wailing Caverns", {
    { "Muyoh, věrný žák", [[Na začátku dungeonu tě potká Muyoh, taurenský druid a Naralexův žák, který se v jeskyních zkažení vyhnul. Vysvětlí, že jeho mistr upadl do zkaženého spánku, kde se jeho myšlenky zamořily hadími vizemi. Požádá tě, abys porazil čtyři Fanglordy, než bude moci provést obřad probuzení. Na cestu ti dá požehnání Mark of the Wild.]] },
    { "Obřad probuzení", [[Po poražení čtyř Fanglordů tě Muyoh provede jeskyní až do Naralexovy komnaty a tam musíš bránit jeho obřad. Přijdou tři vlny nepřátel a nakonec Mutanus the Devourer. Až je po všem, Muyoh se přesune do Overgrown Camp v jižním Barrens, kde dává úkoly na léčení zdejší krajiny. Zmiňuje, že je Naralex tak rozrušený, že už nechce riskovat.]] },
    { "Deviate: stvoření z noční můry", [[Tvorům v jeskyních se říká „deviate“. Podle příběhu vznikli z obyčejných zvířat v době, kdy Naralex sestoupil do své noční můry, kolem roku 25 po Dark Portal (ADP). Za příčinu se považuje látka zvaná Wailing Essence, kterou objevil Mebok Mizzyrix. Deviate zvířata mají „nezemské vlastnosti“ a údajně působí zemi velkou bolest.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Po Cataclysmu (28 ADP) se zkažení zesílilo a vzniklo Overgrowth, divoká džungle. V době Legionu (32 ADP) deviate zvířata přibývala a množila se. A když jeskyněmi během čtvrté války proudil Azerite, začali se deviate tvorové chovat zvláštně.]] },
})

boss("Wailing Caverns", "Lady Anacondra", [[Před zkažením se jmenovala Scarletleaf. Byla mladou učednicí Naralexe, ale když její mistr upadl do nočních můr, zlomilo to její mysl a ona odhodila své jméno. Zbyl z ní had Lady Anacondra, jedna z Fanglordů a první boss Wailing Caverns. Používá léčení, blesky, Druid's Slumber (uspání) a Thorns Aura, která odráží zranění na ty, kdo ji bijí zblízka. Dabuje ji Kath Soucie. Její Belt of the Fang je proslulý nízkou šancí na zisk a tvoří součást pětidílné sady Embrace of the Viper.]])

secrets("Wailing Caverns", [[• Lady Anacondra se dřív jmenovala Scarletleaf; po zlomení mysli „odhodila své jméno“.
• Pásek Belt of the Fang z ní padá jen vzácně a patří do sady Embrace of the Viper.
• Muyoh dává při vstupu požehnání Mark of the Wild.
• SPOILER: Po Cataclysmu jeskyně zarůstají džunglí Overgrowth a Naralex řeší škody.]])

-- Shadowfang Keep: další příběh
chapters("Shadowfang Keep", {
    { "Silverpine Forest: země pod hradem", [[Silverpine Forest se táhne podél západního pobřeží Lordaeronu. Na jihu sousedí s Gilneasem, na jihovýchodě s Hillsbrad Foothills, na severu s Tirisfal Glades a na východě s jezerem Lordamere. Krajina je plná vysokých borovic se stříbrnou kůrou, travnatých pahorků a opuštěných statků.]] },
    { "Zeď Gilneasu", [[Země se stala sporným územím poté, co král Genn Greymane za třetí války otevřel Greymane Wall. Arugalovi worgeni se kletbou rozšířili po lidské populaci a Greymane musel Gilneas znovu zapečetit. Silverpine tak ztělesňuje kletbu, která z Gilneanů udělala worgeny: tvory rozpolcené mezi lidskou a zvířecí povahou, zvlášť za měsíčního světla.]] },
    { "Obyvatelé hradu", [[Za barona Silverlainea hradu velel paladin Commander Springvale, který zahynul spolu s ostatními obyvateli, když worgeni zaútočili. Jeho duch dnes straší v hradní kapli; paladinové a kněží prý později bojovali s jeho přízrakem, aby získali jeho svatý symbol a vytvořili zvláštní zbraň na památku svých činů. Na zdech hlídkuje duch Deathsworn Captaina, který padl při Arugalově nájezdu.]] },
    { "Věrné smečky", [[V hradě se pohybuje i Fenrus the Devourer, obrovský worg a mazlíček Arugala. Podle příběhu byl nepředstavitelně velký, možná posílený temnou magií. Když se přiblížíš, zařve, aby Arugala varoval, a ten ti na pomoc přivolá voidwalkery.]] },
    { "Pyrewood, Sepulcher, Ambermill", [[V okolí dungeonu leží Pyrewood Village, lidská osada pod vlivem worgenů, Sepulcher, hlavní cestovní uzel Forsaken, a Ambermill, domov čarodějů z Dalaranu. Dohromady z krajiny vzniká obraz země, kde každý bojuje se vším, co ji ohrožuje.]] },
})

boss("Shadowfang Keep", "Commander Springvale", [[Paladin a velitel hradu za barona Silverlainea. Zahynul spolu s ostatními obyvateli hradu, když worgeni zaútočili. Jeho duch straší v hradní kapli. Paladinové a kněží prý později bojovali s jeho přízrakem, aby získali jeho svatý symbol.]])

boss("Shadowfang Keep", "Fenrus the Devourer", [[Obří worg a mazlíček Archmage Arugala, o kterém se říká, že byl nepředstavitelně velký a možná i temnou magií posílený. Jeho Toxic Saliva ubírá zdraví i manu. Jméno odkazuje na Fenrira z nordické mytologie. SPOILER: Po smrti vstoupil spolu s Arugalem do Shadowlands.]])

boss("Shadowfang Keep", "Deathsworn Captain", [[Vzácný duch kapitána, který padl při Arugalově nájezdu na hrad, a dodnes hlídá hradby. Používá Cleave a Hamstring. Padá z něj Phantom Armor a meč Haunting Blade.]])

secrets("Shadowfang Keep", [[• Jméno Fenrus odkazuje na vlka Fenrira z nordické mytologie.
• Deathsworn Captain je vzácný duch na hradbách; z něj padá Phantom Armor a Haunting Blade.
• V Silverpine najdeš Pyrewood Village, Sepulcher a Ambermill.]])

-- Blackfathom Deeps: další příběh
chapters("Blackfathom Deeps", {
    { "Příchod kultistů", [[Do chrámu přišli věřící Twilight's Hammer a zbylí poklidní obyvatelé Eluniny svatyně museli ustoupit. Kultisté uvěznili jednu z posledních mírumilovných bytostí chrámu, obří želvu, a týrali ji tak dlouho, až se zbláznila. Pak ji vycvičili, aby hlídala jejich svatyni. Je to dobrý příklad toho, jak kult nemění jen to, kdo chrám ovládá, ale i to, co z něj zůstane.]] },
    { "Gelihast a Pool of Ask'ar", [[Murloc Gelihast z kmene Blindlight vtrhl do chrámu hnán voláním Starých bohů a pozabíjel téměř tucet překvapených kultistů. Jeho brutalita kult tak zaujala, že mu dovolil zřídit vlastní svatyni pro oběti. Bojuje se dvěma meči s vysokou rychlostí, a dokáže tak velmi rychle umlčet kouzelníky.]] },
    { "Lady Sarevess a svatyně", [[Lady Sarevess byla nagská kouzelnice ve službách kultu a prováděla magický výzkum na ochranu uctívačů Aku'mai. Podle záznamů ji Domina obětovala Starým bohům, protože neposkytla dostatečnou magickou ochranu. Když ji vyprovokuješ, zavolá na své stoupence, že tu nemáš co dělat, a rozkáže vás zabít.]] },
    { "Moonshrine a oltářní hádanka", [[V Moonshrine Sanctum sídlí Twilight Lord Kelris v meditativním transu; je posedlý Aku'mai a věří, že hydra představuje návrat Starých bohů do Azerothu. Po jeho porážce čeká klasická hádanka: svíce na oltáři se zapalují po jedné, protože každá vyvolá velkou skupinu elitních nepřátel. Zapálení víc svící naráz znamená jistou smrt skupiny.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Gelihasta později v pozdějších verzích zabil Subjugator Kor'ul, který převzal jeho murloky. Kelris přežil první střet a později řídil Flamebringery v Searing Gorge během Blackrock Eruption. Konec mu připravil Bathiel: jeho prvním činem po převzetí velení bylo hodit Kelrise do žravé tlamy Aku'mai.]] },
})

boss("Blackfathom Deeps", "Twilight Lord Kelris", [[Orčí vůdce kultu v Moonshrine Sanctum, posedlý hydrou Aku'mai, protože v ní vidí návrat Starých bohů do Azerothu. Do boje vstupuje v meditativním transu, používá Mind Blast a Sleep. Po jeho smrti následuje oltářní hádanka se svícemi. SPOILER: V pozdějších příbězích ho jeho nástupce hodí hydře.]])

boss("Blackfathom Deeps", "Lady Sarevess", [[Nagská kouzelnice, která pro kult zkoumala magické ochrany uctívačů Aku'mai. Podle záznamů ji Domina obětovala Starým bohům za nedostatečnou ochranu; po smrti leží na oltáři. Používá Forked Lightning. Dabuje ji Kath Soucie.]])

boss("Blackfathom Deeps", "Gelihast", [[Murloc z kmene Blindlight, který do chrámu vtrhl na zavolání Starých bohů a pozabíjel téměř tucet kultistů. Jeho brutalita zapůsobila tak, že mu dovolili zřídit vlastní svatyni pro oběti. Bojuje s dvěma meči a síť (Net) tě na dvě vteřiny znehybní. SPOILER: V pozdějších příbězích ho zabije Subjugator Kor'ul.]])

boss("Blackfathom Deeps", "Ghamoo-ra", [[Jedna z posledních mírumilovných bytostí Eluniny svatyně, obří želva. Kultisté ji uvěznili a týrali, až se zbláznila, a pak ji vycvičili jako strážce své svatyně. Její Trample zraňuje všechny kolem. Jméno odkazuje na filmovou příšeru Gameru. Lovec ji může ochočit a naučit se Shell Shield.]])

secrets("Blackfathom Deeps", [[• Jméno Ghamoo-ra odkazuje na filmovou příšeru Gameru.
• V oltářní hádance po Kelrisovi zapaluj svíce VŽDY po jedné.
• Ghamoo-ra může ochočit lovec (Shell Shield, Bite).
• Gelihast je z kmene Blindlight.]])

-- The Stockade: další příběh
chapters("The Stockade", {
    { "Celý příběh jednoho povstání", [[Příběh Stockade začíná v politice. Šlechta drží ve vězení lidi, které potřebuje jako páku, a vězení se postupně stává místem, kde se potkávají zločinci z celého království. Když se k tomu přidají Defiasové, kteří mají důvod nenávidět samotný Stormwind, stačí jediná jiskra. Tou byl strážce Mac, kterého vězni zabili při výrobě šátků s odznakem Bratrstva, a o chvíli později vypuklo plné povstání, ve kterém se spojili vězni z různých světů.]] },
    { "Targorr: popravčí Blackrocku", [[Targorr the Dread býval nejvyšším popravčím klanu Blackrock pod Gath'Ilzoggem a při válce na obránce Stormwindu používal brutální mučení. Zajali ho a zavřeli do Stockade, ale nikdy ho nepopravili – selhal systém, protože šlechta rozsudek odkládala. Při povstání se postavil na stranu defiaských vzbouřenců. Strážný Berton z Lakeshire po jeho hlavě touží v questu What Comes Around... Zajímavost: Targorr používá proto-orčí model z alfy hry.]] },
    { "Kam Deepfury a most Thandol Span", [[Kam Deepfury, trpaslík z klanu Dark Iron, podle zpravodajských záznamů zorganizoval výbuch, který zničil jeden z mostů přes Thandol Span a způsobil smrt rodiny Longbrada Grima. Do Stockade se dostal jako jediný z bossů bez vazby na Defias. Hlavu Kama pak chce quest The Fury Runs Deep jako odplatu dwarvské komunity.]] },
    { "Bruegal a ostatní vězni", [[Bruegal Ironknuckle je vzácný trpaslík, který ve vězení vede vzpouru: jeho hlášky jako „Death to the Warden's men!“ nebo „Tell the Warden this prison is ours now!“ ukazují, že už vězení považuje za své. Z celé věznice jsou rare drops právě od něj a od Kama (Kam's Walking Stick). Hamhock je dvouhlavý ogr; fanoušci spekulují, že jde o zajatého ogra z Duskwoodu nebo o spojence Defiasů.]] },
})

boss("The Stockade", "Targorr the Dread", [[Dřív nejvyšší popravčí klanu Blackrock pod Gath'Ilzoggem, který mučil obránce Stormwindu. Zajali ho a zavřeli do Stockade, ale nikdy ho nepopravili – selhal systém. Při povstání se spojil s defiaskými vzbouřenci. Bojuje se dvěma zbraněmi, má Thrash a Enrage. Hlavu po něm chce Guard Berton z Lakeshire (quest What Comes Around...). Používá proto-orčí model z alfy hry.]])

boss("The Stockade", "Kam Deepfury", [[Trpaslík z Dark Iron, který podle záznamů uspořádal výbuch zničivšího most v Thandol Span a způsobil smrt rodiny Longbrada Grima. V Stockade je jedním z mála zajatců bez vazby na Defias. Bojuje jako obránce: má Defensive Stance, Shield Slam a Shield Wall. Jeho hlavu chce quest The Fury Runs Deep.]])

boss("The Stockade", "Bruegal Ironknuckle", [[Vzácný trpaslík, který vede ve vězení vzpouru: křičí „Death to the Warden's men!“ a „Tell the Warden this prison is ours now!“. Jako jediný v celé věznici dává pozoruhodnou kořist (Iron Knuckles, Jimmied Handcuffs, Prison Shank).]])

boss("The Stockade", "Hamhock", [[Dvouhlavý ogr, mini-boss, který nemá žádnou významnou kořist ani quest. Na stránkách fanoušků se spekuluje, že jde o zajatého ogra z Duskwoodu nebo o někoho spojeného s Defias. Bojuje s Bloodlust a Chain Lightning.]])

secrets("The Stockade", [[• Targorr používá proto-orčí model z alfy hry.
• Bruegal je jediný mob ve věznici s významnou kořistí (spolu s Kam's Walking Stick).
• Quest What Comes Around... (Lakeshire) chce hlavu Targorra, The Fury Runs Deep hlavu Kama Deepfuryho.
• Hamhock je dvouhlavý ogr; původ je předmětem spekulací.]])

-- Gnomeregan: další příběh
chapters("Gnomeregan", {
    { "Gelbin Mekkatorque, král gnómů", [[Gelbin Mekkatorque je High Tinker a král gnómů, geniální vynálezce, jehož výtvory zahrnují Mechanostridera, Deeprun Tram a obléhací stroje. Pád Gnomereganu je jeho největší tragédie: jeho důvěryhodný rádce Sicco Thermaplugg ho přesvědčil, aby vypustil toxické záření jako obranu proti troggům, a Thermapluggova zrada z žárlivé ambice zabila asi 80 % gnómů. Mekkatorque to nese jako vinu.

Po katastrofě odvedl přeživší do Tinker Town v Ironforge a roky plánoval Operation: Gnomeregan, aby dobyl domov zpět. Jeho slavná věta zní: „Naše věrnost přátelům je naše nejpravdivější a největší síla… Je to moc, kterou čísla nepřekonají.“ Zvláštní detail: když je ve stresu, počítá prvočísla.]] },
    { "Grubbis a Chomper", [[Grubbis je obří troggský boss, doprovázený baziliškem Chomperem. Příběh uvádí, že plyn, který zaplavil město, měl rozzlobit troggy a zabít gnómy, ale Grubbis kvůli němu nečekaně vyrostl do obrovských rozměrů. Objevuje se na konci události Blastmaster Emi Shortfuse; opravdová obtíž je ve spoustě troggů před ním i s ním a v závalu tunelu, který se spustí po varování v chatu.]] },
    { "Stroje Gnomereganu", [[Electrocutioner 6000 stojí v Launch Bay, řídí ho poručík Tom „Sizzlepants“ Crankle, leper gnóm ve službách Thermaplugga. Původně držel Workshop Key, jediný přístup k zadnímu vchodu do instance. Podle příběhu byl stroj zničen a jeho noha je vystavena v Tinker Town. Při střetu zakřičí „Electric justice!“. V Warcraft Rumble pilota nahradil Rotgear.]] },
    { "Cesta k Operaci", [[Gnomeregan zůstává živou ruinou: radioaktivní plyn, leper gnómové, troggové a Dark Iron agenti si ho dělí. Bezpečná zóna v instanci ukazuje, že ne všichni gnómové odešli; část zůstala a bojuje, aby se město jednou vrátilo.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: Mekkatorque byl vážně zraněn v bitvě o Dazar'alor a zachránil ho Spark Reactor z Mechagonu. Poté sjednotil rozdělená gnómská království a byl vyhlášen prvním králem od krále Mechagona před čtyřmi stoletími.]] },
})

boss("Gnomeregan", "Grubbis", [[Obří troggský boss, doprovázený baziliškem Chomperem. Podle příběhu měl radioaktivní plyn rozzlobit troggy a zabít gnómy, ale Grubbis kvůli němu nečekaně vyrostl do obrovských rozměrů. Objevuje se na konci události Blastmaster Emi Shortfuse.]])

boss("Gnomeregan", "Electrocutioner 6000", [[Mechanický tank v Launch Bay, kterého řídí poručík Tom „Sizzlepants“ Crankle, leper gnóm ve službách Thermaplugga. Používá Chain Bolt, Megavolt a Shock; při souboji křičí „Electric justice!“. Původně držel Workshop Key k zadnímu vchodu. Podle příběhu byl později zničen a jeho noha je vystavena v Tinker Town.]])

secrets("Gnomeregan", [[• Gelbin Mekkatorque počítá prvočísla, když je pod stresem.
• Electrocutioner 6000 drží Workshop Key k zadnímu vchodu do instance.
• Grubbis vyrostl do obřích rozměrů kvůli toxickému plynu; Chomper je jeho bazilišek.
• Thermaplugg plánoval zradu předem: údaje o plynu zfalšoval.]])

-- Razorfen Kraul: další příběh
chapters("Razorfen Kraul", {
    { "Agamaggan: kanec, který padl za svět", [[Agamaggan byl jedním z Prastarých strážců, obří kanec a Divoký bůh, později uctívaný i jako loa. Za Války prastarých (War of the Ancients) se spolu s dalšími Divokými bohy postavil Plamenné legii. Rozsápal tisíce doomguardů a felguardů, ale nakonec padl při obraně těch, kdo se snažili dostat k Well of Eternity. Z jeho těla vznikl Razorfen, obří trnitý shluk posvátný pro quilboary. Podle jejich víry „Agamaggan nechal své tělo, aby nás chránilo“, a vchod do Razorfen Downs považují za jeho obří tlamu. Uctívají ho i některé orčí klany a noční elfové, a Blood Shards z jeho esence jsou mezi věrnými zvlášť ceněné.]] },
    { "Charlga a Razorfen Downs", [[Za Charlgy Razorflank quilboarové vyhnali taureny z jižních Barrens. Svým stoupencům prý lhala, že potřebují krev, aby Agamaggana oživili, a tím je poštvala proti obyvatelům Barrens. Vytvořila velkou část trnité kopule Razorfen Downs a dceru Chugaru cvičila, aby ji udržovala. Jednala i s agenty Plagy a spojila svůj kmen s nemrtvými; formálně byla vůdkyní, ale kmen Death's Head ve skutečnosti řídil Amnennar the Coldbringer.]] },
    { "Willix a eskorta", [[Goblin Willix the Importer z Ratchetu skončil ve vězení Razorfen Kraul, když hledal modrolisté hlízy pro Mebok Mizzyrixe. Při eskortním questu si stěžuje, že to tu strašně smrdí, a před Charlgou varuje. Lze ho zachránit a vyvést ven.]] },
    { "Válečníci kmene Death's Head", [[Overlord Ramtusk velí vojskům Death's Head v Razorfen Kraul. Při střetu volá „For Victory! For Agamaggan!“ a jeho Thunderclap zpomaluje. Hlídají ho dva elitní Razorfen Spearhide se Thorns Aura a Whirling Barrage, takže se doporučuje je nejdřív vyřadit. Z Ramtuska padá obouruční sekera Corpsemaker a přilba Tusken Helm.]] },
    { "Co bylo dál (spoilery z pozdějšího příběhu)", [[SPOILER: V pozdějších příbězích porazili Charlgu hrdinové vedení Spirit of Agamaggan a Auld Stonespirem; duch Agamaggana si vyžádal, aby jí vyrvali srdce. Krátce před válkou o trny sem vtrhli Sylvanas a Nathanos.]] },
})

boss("Razorfen Kraul", "Charlga Razorflank", [[„The Crone“, šamanka zaměřená na geomancii, která vyhnala taureny z jižních Barrens. Podle pozdějšího příběhu lhala quilboarům, že potřebují krev k oživení Agamaggana, a tak je poštvala proti Barrens. Vyjednávala s Plagou, i když kmen Death's Head ve skutečnosti řídil Amnennar. Její dcera Chugara udržuje trnitou kopuli Razorfen Downs. Dabuje ji Julie Granata. SPOILER: Později ji porazili hrdinové vedení Spirit of Agamaggan.]])

boss("Razorfen Kraul", "Overlord Ramtusk", [[Velitel vojsk Death's Head v Razorfen Kraul. Při boji křičí „For Victory! For Agamaggan!“, používá Battle Shout a Thunderclap (zpomalení) a má dvě strážkyně se Thorns Aura. Padá z něj Corpsemaker a Tusken Helm. Dabuje ho Marc Graue.]])

secrets("Razorfen Kraul", [[• Quilboarové věří, že vchod do Razorfen Downs je tlama Agamaggana.
• Ramtusk volá „For Victory! For Agamaggan!“.
• Willix the Importer je goblin z Ratchetu, kterého můžeš eskortovat ven.
• Charlga ve skutečnosti nevládla kmeni Death's Head, ten řídil Amnennar.]])

-- Ragefire Chasm: další příběh
chapters("Ragefire Chasm", {
    { "Orgrimmar nad vulkánem", [[Ragefire Chasm leží pod Orgrimmarem. Vchod je v Cleft of Shadow, kde sídlí Neeru Fireblade; uvnitř teče láva a v hlubinách žijí tvorové, kteří se Hordě nikdy nepodřídili.]] },
    { "Dvojí hra Neerua", [[Neeru Fireblade je v Cleft of Shadow považován za důvěryhodného, ve skutečnosti ale vede klan Burning Blade. Do Ragefire Chasm posílá Thrallovy věrné, aby se jich zbavil, a zároveň zkouší, jak silní kultisté Searing Blade jsou. Válečný náčelník nakonec nasadí dobrodruhy, aby vůdce kultu zlikvidovali.]] },
})

secrets("Ragefire Chasm", [[• Neeru Fireblade sedí v Cleft of Shadow a je skrytý vůdce klanu Burning Blade.
• Magatha, taurenská věštkyně, se pokoušela s troggy vyjednávat.]])
