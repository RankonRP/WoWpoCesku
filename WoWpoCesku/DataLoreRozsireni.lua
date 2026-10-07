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
