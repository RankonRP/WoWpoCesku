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
