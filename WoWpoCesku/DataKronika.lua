-- WoWpoCesku: data pro doplňky Kroniky Azerothu (Kronika.lua)
-- Vzácní mobové podle classic dat (foreverdb.net / CMaNGOS) a novinky WoW Forever: "Jméno|level|t" (t = lovec ochočí)

WoWpoCesku_RareList = {
    ["Durotar"] = { "Geolord Mottle|9", "Warlord Kolkanis|9", "Watch Commander Zalaphil|9", "Captain Flat Tusk|11",
        "Death Flayer|11|t", "Felweaver Scornn|11", "Dustwind Eggtender|5-10", "Shal'ma|?|t" },
    ["Mulgore"] = { "Mazzranache|9|t", "Snagglespear|9", "The Rake|10|t", "Enforcer Emilgund|11", "Sister Hatelash|11",
        "Ghost Howl|12", "Snarlsnout|?", "Stormherald Ukta|?", "Thornstarter Igleg|?" },
    ["The Barrens"] = { "Dishu|13|t", "Rathorian|15", "Elder Mystic Razorsnout|?", "Brokespear|?", "Stonearm|?",
        "Takk the Leaper|19", "Gesharahan|?", "Rocklance|?", "Swiftmane|21", "Trigore the Lasher|19", "Boahn|?",
        "Engineer Whirleygig|?", "Foreman Grills|?", "Humar the Pridelord|23|t", "Sludge Anomaly|?",
        "Lakota'mani|?", "Ishamuhale|?", "Geopriest Gukk'rok|19", "Swinegart Spearhide|22" },
    ["Teldrassil"] = { "Threggil|6", "Uruson|7", "Fury Shelda|8", "Duskstalker|9|t", "Grimmaw|11", "Blackmoss the Fetid|13",
        "Nightscreech|?|t", "Wrathvine|?" },
    ["Zephras Isle"] = { "Den'dralass|?", "Fernfeather|?|t", "Galemender Delanea|?", "Mystmane|?|t", "Slydris|?",
        "Tel'daeor the Stormspeaker|?", "The Lost One|?", "Snapbeak the Quick|3-12" },
    ["Darkshore"] = { "Shadowclaw|13|t", "Licillin|14", "Lord Sinslayer|15", "Carnivous the Breaker|16", "Flagglemurk the Cruel|16",
        "Lady Moongazer|17", "Firecaller Radison|19", "Strider Clutchmother|20|t", "Lady Vespira|22", "Baron Marinous|11-19" },
    ["Ashenvale"] = { "Apothecary Falthis|22", "Lady Vespia|22", "Mist Howler|22|t", "Mugglefin|23", "Branch Snapper|25",
        "Rorgish Jowl|25", "Akkrilus|26", "Eck'alom|27", "Oakpaw|27", "Terrowulf Packlord|31", "Ursol'lok|31|t",
        "Prince Raze|32" },
    ["Stonetalon Mountains"] = { "Sister Rathtalon|19", "Taskmaster Whipfang|22", "Foreman Rigger|24", "Pridewing Patriarch|25",
        "Sentinel Amarassan|27", "Sorrow Wing|27", "Sister Riven|28", "Brother Ravenoak|29", "Vengeful Ancient|29", "Nal'taszar|30" },
    ["Thousand Needles"] = { "Gibblesnik|28", "Achellios the Banished|31", "Heartrazor|32", "Vile Sting|35|t",
        "Silithid Ravager|36", "Ironeye the Invincible|37" },
    ["Desolace"] = { "Giggler|34|t", "Accursed Slitherblade|35", "Hissperak|37", "Kaskk|40", "Cursed Centaur|43", "Prince Kellen|33" },
    ["Dustwallow Marsh"] = { "Drogoth the Roamer|37", "Burgle Eye|38", "Dart|38|t", "Ripscale|39|t", "Hayoc|41|t",
        "Oozeworm|42", "The Rot|43", "Lord Angler|44", "Brimgore|45" },
    ["Feralas"] = { "Snarler|42|t", "Old Grizzlegut|43|t", "Gnarl Leafbrother|44", "Diamond Head|45", "Lady Szallah|46",
        "Qirot|47", "Antilus the Soarer|48", "Bloodroar the Stalker|48", "Arash-ethis|49|t" },
    ["Azshara"] = { "Varo'then's Ghost|48", "The Evalcharr|48", "Gatekeeper Rageroar|49", "Antilos|50", "General Fangferror|50", "Lady Sesspira|51",
        "Magister Hawkhelm|51", "Master Feardred|51", "Scalebeard|52", "Monnos the Elder|53" },
    ["Tanaris"] = { "Murderous Blisterpaw|43|t", "Warleader Krazzilak|45", "Greater Firebird|46|t", "Kregg Keelhaul|47",
        "Haarka the Ravenous|50" },
    ["Un'Goro Crater"] = { "Jin'Zallah the Sandbringer|46", "Cyclok the Mad|48", "Omgorn the Lost|50", "Ravasaur Matriarch|50",
        "Soriid the Devourer|50", "Uhk'loc|52|t", "Clutchmother Zavas|54", "Gruff|57", "King Mosh|60" },
    ["Silithus"] = { "Krellack|56|t", "Gretheer|57|t", "Rex Ashil|57", "Grubthor|58", "Huricanian|58", "Zora|59",
        "Lapress|60", "Twilight Lord Everun|60", "Setis|61" },
    ["Felwood"] = { "Death Howl|49|t", "Mongress|50|t", "Ragepaw|51", "The Ongar|51", "Olm the Wise|52|t",
        "Alshirr Banebreath|54", "Dessecus|56", "Immolatus|56" },
    ["Winterspring"] = { "Mezzir the Howler|55", "General Colbatann|56", "Rak'shiri|57|t", "Azurous|59", "Grizzle Snowpaw|59",
        "Kashoch the Reaver|60", "Lady Hederine|61" },

    ["Elwynn Forest"] = { "Morgaine the Sly|10", "Mother Fang|10|t", "Narg the Taskmaster|10", "Thuros Lightfingers|11",
        "Fedfennel|12", "Gruff Swiftbite|12", "Elmpaw|12" },
    ["Stormwind City"] = { "Sewer Beast|50|t" },
    ["Westfall"] = { "Slark|10", "Vultros|10|t", "Master Digger|11", "Leprithus|12", "Foe Reaper 4000|12",
        "Sergeant Brashclaw|13", "Brack|14" },
    ["Dun Morogh"] = { "Edan the Howler|9", "Timber|10|t", "Gibblewilt|11", "Great Father Arctikus|11", "Bjarn|12|t",
        "Hammerspine|12", "Ghostfang|?|t" },
    ["Tirisfal Glades"] = { "Lost Soul|6", "Farmer Solliden|8", "Tormented Spirit|8", "Bayne|10", "Muad|10",
        "Ressan the Needler|11|t", "Deeb|12", "Fellicent's Shade|12", "Sri'skulk|13|t", "Krethis Shadowspinner|15|t",
        "Blightsculler|?", "Coldrasp|?|t", "Decrepit Harvester|?", "The Condemned One|?" },
    ["Silverpine Forest"] = { "Gorefang|13|t", "Old Vicejaw|14|t", "Dalaran Spellscribe|21", "Ravenclaw Regent|22" },
    ["Hillsbrad Foothills"] = { "Creepthess|24|t", "Ro'Bark|28", "Tamra Stormpike|28", "Scargil|30", "Lady Zephris|33" },
    ["Alterac Mountains"] = { "Rot Hide Bruiser|22", "Jimmy the Bleeder|23", "Snarlmane|23", "Cranky Benj|32|t", "Araga|35|t",
        "Gravis Slipknot|36", "Skhowl|36", "Stone Fury|37", "Lo'Grosh|39", "Narillasanz|44" },
    ["Arathi Highlands"] = { "Big Samras|27|t", "Singer|34", "Kovork|36", "Nimar the Slayer|37", "Darbel Montrose|39",
        "Molok the Crusher|39", "Ruul Onestone|39", "Geomancer Flintdagger|40", "Zalas Witherbark|40", "Foulbelly|42" },
    ["Wetlands"] = { "Ma'ruk Wyrmscale|23", "Gnawbone|24", "Leech Widow|24|t", "Mirelow|25", "Garneg Charskull|29",
        "Dragonmaw Battlemaster|30", "Sludginn|30", "Razormaw Matriarch|31|t", "Prince Nazjak|41", "Nightveiled Rotheap|31-32" },
    ["Loch Modan"] = { "Lord Condar|15|t", "Emogg the Crusher|19", "Shanda the Spinner|19|t", "Magosh|21", "Boss Galgosh|22",
        "Large Loch Crocolisk|22|t" },
    ["Redridge Mountains"] = { "Ribchaser|17", "Snarlflare|18", "Squiddic|19", "Seeker Aqualon|21", "Chatter|23|t",
        "Boulderheart|25", "Rohh the Silent|26", "Kazon|27" },
    ["Duskwood"] = { "Lupos|23|t", "Naraxis|27|t", "Lord Malathrom|31", "Commander Felstrom|32", "Fenros|32", "Nefaru|34" },
    ["Stranglethorn Vale"] = { "Gluggle|37", "Roloch|38", "Kurmokk|42|t", "Verifonix|42", "Mosh'Ogg Butcher|44", "Rippa|44",
        "Lord Sakrasis|45", "Scale Belly|45" },
    ["The Hinterlands"] = { "Old Cliff Jumper|42|t", "Zul'arek Hatefowler|43", "Razortalon|44", "Witherheart the Stalker|45",
        "Retherokk the Berserker|48", "Jalinde Summerdrake|49", "The Reak|49", "Grimungous|50", "Ironback|51|t",
        "Mith'rethis the Enchanter|52" },
    ["Western Plaguelands"] = { "Foulmane|52", "Lord Maldazzar|56", "Foreman Marcrid|58", "Putridius|58", "Scarlet Smith|58",
        "Scarlet Executioner|60", "Scarlet Judge|60", "Scarlet Interrogator|61", "Foreman Jerris|62", "The Husk|62",
        "Scarlet High Clerist|63" },
    ["Eastern Plaguelands"] = { "Duggan Wildhammer|55", "Deathspeaker Selendre|56", "Gish the Unmoving|56", "Hed'mush the Rotting|57",
        "Lord Darkscythe|57", "Warlord Thresh'jin|58", "High General Abbendis|59", "Zul'Brin Warpbranch|59", "Ranger Lord Hawkspear|60" },
    ["Badlands"] = { "War Golem|36", "Broken Tooth|37|t", "Digmaster Shovelphlange|38", "Shadowforge Commander|40",
        "Siege Golem|40", "7:XT|41", "Anathemus|45", "Rumbler|45", "Zaricotl|55|t" },
    ["Searing Gorge"] = { "Faulty War Golem|46", "Shleipnarr|47", "Rekk'tilac|48|t", "Scald|49", "Slave Master Blackheart|50",
        "Smoldar|50", "Highlord Mastrogonde|51" },
    ["Burning Steppes"] = { "The Behemoth|50", "Deathmaw|53|t", "Gorgon'och|54", "Hahk'Zor|54", "Scarshield Quartermaster|55",
        "Terrorspark|55", "Malfunctioning Reaver|56", "Thauris Balgarr|57", "Gruklash|59", "Hematos|60", "Volchan|60" },
    ["Swamp of Sorrows"] = { "Lost One Cook|37", "Lost One Chieftain|39", "Molt Thorn|42", "Fingat|43", "Gilmorian|43",
        "Lord Captain Wyrmak|45", "Jade|47", "Veyzhak the Cannibal|48", "Zekkis|48" },
    ["Blasted Lands"] = { "Mojo the Twisted|48", "Deatheye|49", "Grunter|50|t", "Ravage|51|t", "Akubar the Seer|54",
        "Magronos the Unyielding|56" },
}

-- Místa k objevení (anglické názvy podoblastí, jak je ukazuje hra; dungeon se počítá při vstupu)
WoWpoCesku_Objevy = {
    ["Durotar"] = { "Valley of Trials", "Razor Hill", "Sen'jin Village", "Echo Isles", "Tiragarde Keep", "Skull Rock",
        "Drygulch Ravine", "Thunder Ridge", "Orgrimmar", "Ragefire Chasm" },
    ["Mulgore"] = { "Camp Narache", "Bloodhoof Village", "Thunder Bluff", "Red Rocks", "Bael'dun Digsite", "The Venture Co. Mine",
        "Windfury Ridge", "Palemane Rock", "Stonebull Lake" },
    ["The Barrens"] = { "The Crossroads", "Ratchet", "Camp Taurajo", "Lushwater Oasis", "The Forgotten Pools", "Northwatch Hold",
        "Bael Modan", "Field of Giants", "The Merchant Coast", "Wailing Caverns", "Razorfen Kraul", "Razorfen Downs" },
    ["Teldrassil"] = { "Shadowglen", "Dolanaar", "Darnassus", "Rut'theran Village", "Ban'ethil Barrow Den", "Oracle Glade",
        "Lake Al'Ameth", "Starbreeze Village", "Fel Rock" },
    ["Zephras Isle"] = { "Thendal Grove" },
    ["Darkshore"] = { "Auberdine", "Ameth'Aran", "Bashal'Aran", "Tower of Althalaxx", "Grove of the Ancients", "Cliffspring Falls",
        "Mist's Edge", "Twilight Vale" },
    ["Ashenvale"] = { "Astranaar", "Splintertree Post", "Demon Fall Canyon", "Raynewood Retreat", "Zoram Strand", "Lake Falathim",
        "Satyrnaar", "Warsong Lumber Camp", "Blackfathom Deeps" },
    ["Stonetalon Mountains"] = { "Sun Rock Retreat", "Stonetalon Peak", "Windshear Crag", "The Charred Vale", "Malaka'jin",
        "Talondeep Path", "Mirkfallon Lake" },
    ["Thousand Needles"] = { "Freewind Post", "The Shimmering Flats", "Mirage Raceway", "Highperch", "Splithoof Crag",
        "Darkcloud Pinnacle", "Razorfen Downs" },
    ["Desolace"] = { "Nijel's Point", "Shadowprey Village", "Kodo Graveyard", "Mannoroc Coven", "Thunder Axe Fortress",
        "Gelkis Village", "Magram Village", "Maraudon" },
    ["Dustwallow Marsh"] = { "Theramore Isle", "Brackenwall Village", "Witch Hill", "Shady Rest Inn", "Alcaz Island",
        "Wyrmbog", "Onyxia's Lair" },
    ["Feralas"] = { "Feathermoon Stronghold", "Camp Mojache", "The Twin Colossals", "Dream Bough", "Isle of Dread",
        "Lower Wilds", "Dire Maul" },
    ["Azshara"] = { "Valormok", "Talrendis Point", "Ruins of Eldarath", "Bay of Storms", "Lake Mennar", "Haldarr Encampment",
        "Temple of Zin-Malor" },
    ["Tanaris"] = { "Gadgetzan", "Steamwheedle Port", "Caverns of Time", "Lost Rigger Cove", "Noxious Lair",
        "Valley of the Watchers", "Zul'Farrak" },
    ["Un'Goro Crater"] = { "Marshal's Refuge", "Fire Plume Ridge", "Golakka Hot Springs", "The Slithering Scar",
        "Lakkari Tar Pits", "Terror Run", "Fungal Rock" },
    ["Silithus"] = { "Cenarion Hold", "The Scarab Wall", "Hive'Ashi", "Hive'Zora", "Hive'Regal", "Southwind Village",
        "Twilight Base Camp" },
    ["Felwood"] = { "Talonbranch Glade", "Bloodvenom Post", "Emerald Sanctuary", "Jaedenar", "Shadow Hold", "Irontree Woods",
        "Bloodvenom Falls" },
    ["Winterspring"] = { "Everlook", "Frostsaber Rock", "Mazthoril", "Darkwhisper Gorge", "Lake Kel'Theril", "Owl Wing Thicket",
        "Winterfall Village" },
    ["Moonglade"] = { "Nighthaven", "Shrine of Remulos", "Stormrage Barrow Dens", "Lake Elune'ara" },

    ["Elwynn Forest"] = { "Northshire Valley", "Goldshire", "Jasperlode Mine", "Fargodeep Mine", "Brackwell Pumpkin Patch",
        "Tower of Azora", "Eastvale Logging Camp", "Stone Cairn Lake", "Crystal Lake" },
    ["Stormwind City"] = { "Trade District", "Mage Quarter", "Old Town", "Dwarven District", "Cathedral Square",
        "Stormwind Keep", "The Canals", "The Stockade" },
    ["Westfall"] = { "Sentinel Hill", "Moonbrook", "Saldean's Farm", "Westfall Lighthouse", "Jangolode Mine", "Gold Coast Quarry",
        "The Dagger Hills", "The Deadmines" },
    ["Dun Morogh"] = { "Coldridge Valley", "Kharanos", "Ironforge", "Brewnall Village", "Amberstill Ranch", "Frostmane Hold",
        "Gnomeregan" },
    ["Tirisfal Glades"] = { "Deathknell", "Brill", "Undercity", "Agamand Mills", "Scarlet Monastery",
        "Garren's Haunt", "Brightwater Lake" },
    ["Silverpine Forest"] = { "The Sepulcher", "Pyrewood Village", "Ambermill", "Fenris Isle", "Shadowfang Keep",
        "The Greymane Wall" },
    ["Hillsbrad Foothills"] = { "Southshore", "Tarren Mill", "Durnholde Keep", "Azurelode Mine", "Dun Garok", "Hillsbrad Fields" },
    ["Alterac Mountains"] = { "Ruins of Alterac", "Strahnbrad", "Dalaran", "Ravenholdt Manor", "Crushridge Hold" },
    ["Arathi Highlands"] = { "Refuge Pointe", "Hammerfall", "Stromgarde Keep", "Witherbark Village", "Faldir's Cove",
        "Circle of East Binding", "Circle of West Binding" },
    ["Wetlands"] = { "Menethil Harbor", "Thandol Span", "Dun Modr", "Thelgen Rock", "Whelgar's Excavation Site", "Dragonmaw Gates",
        "Grim Batol" },
    ["Loch Modan"] = { "Thelsamar", "Stonewrought Dam", "Valley of Kings", "Farstrider Lodge", "Ironband's Excavation Site",
        "Mo'grosh Stronghold", "Silver Stream Mine" },
    ["Redridge Mountains"] = { "Lakeshire", "Stonewatch Keep", "Tower of Ilgalar", "Render's Valley", "Alther's Mill",
        "Lake Everstill" },
    ["Duskwood"] = { "Darkshire", "Raven Hill", "Raven Hill Cemetery", "Twilight Grove", "Roland's Doom", "Sven's Camp",
        "Brightwood Grove" },
    ["Stranglethorn Vale"] = { "Booty Bay", "Grom'gol Base Camp", "Rebel Camp", "Nesingwary's Expedition", "Gurubashi Arena",
        "Zul'Gurub", "Mosh'Ogg Ogre Mound", "Jaguero Isle" },
    ["The Hinterlands"] = { "Aerie Peak", "Revantusk Village", "Jintha'Alor", "Shadra'Alor", "Seradane", "Quel'Danil Lodge",
        "The Altar of Zul" },
    ["Western Plaguelands"] = { "Chillwind Camp", "The Bulwark", "Andorhal", "Caer Darrow", "Uther's Tomb", "Hearthglen",
        "Sorrow Hill", "Dalson's Tears" },
    ["Eastern Plaguelands"] = { "Light's Hope Chapel", "Stratholme", "Darrowshire", "Tyr's Hand", "Corin's Crossing",
        "Plaguewood", "Terrordale" },
    ["Badlands"] = { "Kargath", "Uldaman", "Lethlor Ravine", "Angor Fortress", "Camp Kosh", "Dustbelch Grotto" },
    ["Searing Gorge"] = { "Thorium Point", "The Cauldron", "Firewatch Ridge", "Grimesilt Dig Site", "Blackrock Mountain" },
    ["Burning Steppes"] = { "Morgan's Vigil", "Flame Crest", "Dreadmaul Rock", "Ruins of Thaurissan", "Blackrock Stronghold",
        "Blackrock Spire" },
    ["Swamp of Sorrows"] = { "Stonard", "Fallow Sanctuary", "Pool of Tears", "Misty Reed Strand", "Splinterspear Junction",
        "The Temple of Atal'Hakkar" },
    ["Blasted Lands"] = { "Nethergarde Keep", "The Dark Portal", "Dreadmaul Hold", "The Tainted Scar", "Altar of Storms",
        "Serpent's Coil" },
    ["Deadwind Pass"] = { "Karazhan", "Ariden's Camp", "Deadman's Crossing", "Grosh'gok Compound", "Sleeping Gorge" },
}

-- Krátké české poznámky k důležitým postavám (klíč = jméno NPC ve hře)
WoWpoCesku_Postavy = {
    -- Horda
    ["Thrall"] = "Válečný náčelník Hordy, syn Durotana. Vyrůstal jako otrok a gladiátor v Durnholde, utekl, osvobodil orky z táborů a dovedl je na Kalimdor. Šaman, který chce pro svůj lid mír.",
    ["Vol'jin"] = "Vůdce trollů Darkspear. Thrall jeho kmen kdysi zachránil a Vol'jin mu od té doby věrně slouží.",
    ["Cairne Bloodhoof"] = "Náčelník taurenů a moudrý stařešina Thunder Bluff. S Thrallovou pomocí dovedl svůj lid do Mulgore.",
    ["Lady Sylvanas Windrunner"] = "Královna Forsaken. Bývalá generálka hraničářů z Quel'Thalas, kterou Arthas zabil a proměnil v banshee. Touží po pomstě.",
    ["Varimathras"] = "Démon, poradce Sylvanas. Slouží jí, protože musí – ale věrnost démona je vždy podezřelá.",
    ["Master Apothecary Faranell"] = "Vede lékárníky Royal Apothecary Society v Undercity. Jejich „lék“ proti Pohromě je ve skutečnosti nový mor.",
    ["Magatha Grimtotem"] = "Stará šamanka kmene Grimtotem. Cairne ji toleruje, ale ona touží po moci nad taureny.",
    ["Hamuul Runetotem"] = "První tauren druid po deseti tisících letech. Učil se u Malfuriona Stormrage a spojuje taureny s nočními elfy.",
    ["Arch Druid Hamuul Runetotem"] = "První tauren druid po deseti tisících letech. Učil se u Malfuriona Stormrage a spojuje taureny s nočními elfy.",
    ["Nazgrel"] = "Orkský generál, šéf Thrallovy bezpečnosti v Orgrimmaru.",
    ["Eitrigg"] = "Starý ork, kterého kdysi zachránil paladin Tirion Fordring – a za to byl Tirion vyhnán z řádu.",
    ["Rexxar"] = "Napůl ork a napůl ogr, šampion Hordy z Warcraft III. Toulá se po Desolace se svou medvědicí Mishou.",
    ["Mankrik"] = "Ork, který hledá svou ženu Olgru. Hráči ji hledali tak dlouho, že se z toho stal slavný meme.",
    ["Gazlowe"] = "Goblinský šéf Ratchetu. Postavil Thrallovi Orgrimmar – a za pořádnou cenu.",
    ["Neeru Fireblade"] = "Orkský čaroděj v Cleft of Shadow. SPOILER: ve skutečnosti skrytý vůdce klanu Burning Blade, který posílal Thrallovy věrné do Ragefire Chasm na smrt.",
    ["Zalazane"] = "Šílený čaroděj, který vyhnal trolly Darkspear z Echo Isles a ovládá část jejich lidu.",
    ["Drek'Thar"] = "Slepý šaman klanu Frostwolf, který Thralla naučil šamanismu.",

    -- Aliance
    ["Highlord Bolvar Fordragon"] = "Regent Stormwindu, který vládne za malého krále Anduina. Statečný paladin, který nese tíhu celého království.",
    ["Lady Katrana Prestor"] = "Vlivná šlechtična u dvora. SPOILER: je to černá dračice Onyxia, dcera Deathwinga.",
    ["Anduin Wrynn"] = "Malý král Stormwindu. Jeho otec Varian zmizel na cestě do Theramore.",
    ["King Magni Bronzebeard"] = "Král trpaslíků v Ironforge. Jeho bratr Muradin zmizel v Northrendu a Brann putuje po světě.",
    ["High Tinker Mekkatorque"] = "Král gnómů. Gnomeregan ztratil kvůli troggům a zradě svého poradce Thermaplugga.",
    ["Tyrande Whisperwind"] = "Velekněžka Elune a vůdkyně nočních elfů. Bojovala už ve Válce starověku před deseti tisíci lety.",
    ["Arch Druid Fandral Staghelm"] = "Arcidruid, který zasadil Teldrassil. Strom ale nemá požehnání draků – a les choří.",
    ["Lady Jaina Proudmoore"] = "Vládkyně Theramore a mocná čarodějka. Postavila se na stranu míru s Thrallem – i proti vlastnímu otci.",
    ["Master Mathias Shaw"] = "Šéf tajné služby SI:7 ve Stormwindu.",
    ["Gryan Stoutmantle"] = "Velitel Lidové domobrany na Sentinel Hill. Brání Westfall, když Stormwind nepomáhá.",
    ["Marshal Dughan"] = "Velitel stráží v Goldshire. Jeho nástěnka je místo, kde visí plakát na Hoggera.",
    ["Shandris Feathermoon"] = "Generálka strážkyň nočních elfů, velí Feathermoon Stronghold ve Feralas.",
    ["Conservator Ilthalaine"] = "Strážce Shadowglenu, první učitel mladých nočních elfů.",

    -- Padouši a legendy
    ["Hogger"] = "Nejslavnější gnoll Warcraftu, vůdce gnollů Riverpaw v Elwynn Forest. Mnoho hrdinů na něj nestačilo.",
    ["Edwin VanCleef"] = "Vůdce Bratrstva Defias. Kdysi mistr kameníků, kterým šlechta nezaplatila za obnovu Stormwindu.",
    ["Captain Grayson"] = "Duch kapitána, který straší v majáku na pobřeží Westfallu.",
    ["Old Murk-Eye"] = "Obávaný starý murlok z pobřeží Westfallu.",
    ["Stitches"] = "Obří zrůda sešitá z mrtvol nekromantem Abercrombiem v Duskwoodu.",
    ["Morbent Fel"] = "Nekromant, který žije v domě na vršku Forlorn Rowe nad hřbitovem Raven Hill v Duskwoodu.",
    ["Tirion Fordring"] = "Paladin vyhnaný z řádu za to, že zachránil orka Eitrigga. Dnes žije jako poustevník – jeho příběh ještě neskončil.",
    ["Lord Victor Nefarius"] = "Tajemný lord v Blackrock Spire. SPOILER: je to černý drak Nefarian, syn Deathwinga.",
    ["Ragnaros"] = "Pán ohně, vyvolaný Dark Ironským čarodějem Thaurissanem. Vládne v Molten Core.",
    ["Onyxia"] = "Černá dračice, dcera Deathwinga. Ve Stormwindu se vydává za lady Prestor.",
    ["Kel'Thuzad"] = "Arcimág, zakladatel Kultu zatracených. Po smrti se vrátil jako lich a vládne z Naxxramas.",
    ["Baron Rivendare"] = "Pán nemrtvých ve Stratholme. Z jeho koně Deathcharger se stal sen každého hráče.",
    ["Darkmaster Gandling"] = "Ředitel Scholomance, školy nekromancie pod Caer Darrow.",
    ["Emperor Dagran Thaurissan"] = "Císař Dark Ironů v Blackrock Depths. SPOILER: vzal si princeznu Moiru, dceru krále Magniho.",
    ["Princess Moira Bronzebeard"] = "Dcera krále Magniho. Nechce být „zachráněna“ – je ženou císaře Thaurissana.",
    ["Lord Kazzak"] = "Obří démon v Blasted Lands, který zůstal na Azerothu po zničení Temného portálu.",
    ["Azuregos"] = "Modrý drak v Azshara, ochránce magických artefaktů.",
    ["Hemet Nesingwary Jr."] = "Slavný lovec ve Stranglethorn. Jméno je odkaz na Ernesta Hemingwaye.",
    ["Hemet Nesingwary"] = "Slavný lovec ve Stranglethorn. Jméno je odkaz na Ernesta Hemingwaye.",
    ["Linken"] = "Podivný „chlapec“ v Un'Goro s mečem a štítem – odkaz na Linka ze Zeldy.",
    ["Keeper Remulos"] = "Syn poloboha Cenaria, strážce Moonglade.",
    ["Highlord Demitrian"] = "Strážce v Silithu, který zná tajemství legendárního meče Thunderfury.",
    ["Anachronos"] = "Bronzový drak v Tanaris, strážce Žezla pohyblivých písků.",
    ["Mr. Smite"] = "Tauren, první důstojník Defias v Deadmines. V boji mění zbraně.",
    ["Cookie"] = "Murlok kuchař lodi Defias v Deadmines.",
    ["Princess"] = "Obrovská prasnice z Brackwell Pumpkin Patch, kterou chce Ma Stonefield mrtvou.",
    ["Maybell Maclure"] = "Dívka z Elwynnu, zamilovaná do Tommyho Joea Stonefielda ze znepřátelené rodiny.",

    -- Zephras Isle (WoW Forever)
    ["Rorian the Dayseeker"] = "Vůdce Thendal Grove, který vede mladé shen'dorei.",
    ["Aetheen of the Gales"] = "Členka Rady starších, přišla číst proudění větrů a posoudit, kdo je připraven sloužit ostrovu.",
    ["Halaan Hawk-Eye"] = "Hraničář, který ti půjčí svůj dar a ukáže kotevní pylon v dálce.",
    ["Myriaal"] = "Shen'dorei z Thendal Grove. Dává „bonusové body“ tomu, kdo vyleká Roriana skokem z věže.",
}

-- Novinky WoW Forever (nejsou v classic datech): souřadnice na mapě oblasti v procentech (foreverchanges.pro)
WoWpoCesku_RareMapPts = {
    ["Elmpaw"] = { "Elwynn Forest", 81.6, 85.4, 75, 38.4 },
    ["Ghostfang"] = { "Dun Morogh", 74.2, 63.2 },
    ["Baron Marinous"] = { "Darkshore", 59.2, 22.6 },
    ["Dustwind Eggtender"] = { "Durotar", 51.2, 20.6, 52.2, 24 },
    ["Shal'ma"] = { "Durotar", 59.8, 91 },
    ["Nightscreech"] = { "Teldrassil", 46.4, 33.6 },
    ["Wrathvine"] = { "Teldrassil", 53.4, 70.4 },
    ["Den'dralass"] = { "Zephras Isle", 61.2, 37.2, 56.3, 31.7 },
    ["Fernfeather"] = { "Zephras Isle", 48, 85.4, 53.8, 78.8 },
    ["Galemender Delanea"] = { "Zephras Isle", 62.4, 62 },
    ["Mystmane"] = { "Zephras Isle", 60.2, 34.6 },
    ["Slydris"] = { "Zephras Isle", 50.2, 51 },
    ["Tel'daeor the Stormspeaker"] = { "Zephras Isle", 66, 53.8 },
    ["The Lost One"] = { "Zephras Isle", 52, 46.4 },
}

-- Poznámky ke vzácným mobům (ukazují se v Bestiáři pod jménem)
WoWpoCesku_RareNotes = {
    ["Slark"] = [[Murločí lovec na severu kraje. Padá z něj Slarkskin nebo Coral Claymore.]],
    ["Master Digger"] = [[Kobold vzadu v Jangolode Mine.]],
    ["Leprithus"] = [[Ghúl, který se objevuje jen v noci.]],
    ["Foe Reaper 4000"] = [[Zbláznivší se strašák Harvest Golem. Průvodci k WoW Forever ho doporučují – může z něj padat taška Large Rucksack.]],
    ["Warlord Kolkanis"] = [[Kentaur z Kolkar Crag. Ve WoW Forever už potvrzený!]],
    ["Watch Commander Zalaphil"] = [[Velitel stráže v Tiragarde Keep.]],
    ["Geolord Mottle"] = [[Kančí geomancer kmene Razormane.]],
    ["Death Flayer"] = [[Štír u Southfury Watershed.]],
    ["Felweaver Scornn"] = [[Kultista Burning Blade.]],
    ["Takk the Leaper"] = [[Novinka WoW Forever: padá z něj kus sady Blessing of Kalimdor (2 ze 3 kusů = +5 % rychlosti v Barrens a Stonetalonu).]],
    ["Mother Fang"] = [[Pavoučice v Jasperlode Mine.]],
    ["Mazzranache"] = [[Obrovská puma, na kterou ti v Bloodhoof Village dá quest Maur Raincaller. Je to vzácný mob a lovec si ji může ochočit.]],
    ["Ghost Howl"] = [[Přízračný bílý vlk, vzácný mob, který se toulá po pláních Mulgore.]],
    ["Elmpaw"] = [[Novinka WoW Forever: nový elitní vzácný mob (level 12) na východě kraje (zhruba 81, 85 a 75, 38). Padá z něj Elmpaw's Head, který spustí quest za zkušenosti a reputaci se Stormwindem.]],
    ["Ghostfang"] = [[Novinka WoW Forever: nový vzácný kocour, kterého si lovec může ochočit (zhruba 74, 63). Zatím z něj nic vlastního nepadá.]],
    ["Sewer Beast"] = [[V kanálech pod městem žije vzácné zvíře (level 50), kterého si lovec může ochočit. Mezi lovci je to legenda – hledat ho v kanálech plných nízkých hráčů je zážitek.]],
    ["Nightveiled Rotheap"] = [[Novinka WoW Forever: nový vzácný mob (level 31–32). Padá z něj Rotheap Innards, které vyměníš za prsten Malignant Root.]],
    ["Broken Tooth"] = [[Vzácný kočkovitý mob, kterého si lovci v klasice ochočovali kvůli nejrychlejšímu útoku.]],
    ["7:XT"] = [[Vzácný mechanický robot. Jedno z nejzvláštnějších jmen ve hře.]],
    ["Scarshield Quartermaster"] = [[Vzácný mob, který se objevuje každých 10–15 minut. Hledej ho v okolí Blackrock Spire.]],
    ["Humar the Pridelord"] = [[Vzácný lev v Barrens, oblíbený cíl lovců. Novinka WoW Forever: padá z něj kus sady Blessing of Kalimdor.]],
    ["Swiftmane"] = [[Vzácná zhevra v Barrens, která obchází kraj po své trase. Novinka WoW Forever: padá z ní kus sady Blessing of Kalimdor.]],
    ["Ishamuhale"] = [[Raptor z questu Jorna Skyseera v Crossroads: u starého stromu použiješ čerstvé tělo zhevry a Ishamuhale se objeví.]],
    ["Lakota'mani"] = [[Obří šedý kodo u chatrčí jižně od rokle, která protíná Barrens od západu na východ. Z něj padá Hoof of Lakota'mani.]],
    ["Baron Marinous"] = [[Novinka WoW Forever: nový elitní vzácný mob, kterého se dá vyvolat (zhruba 59, 22). Padají z něj úlomky, ze kterých se skládá Mathystral Amulet na jeho vyvolání.]],
    ["Varo'then's Ghost"] = [[Vzácný duch (level 48) kapitána Varo'thena, velitele stráží královny Azshary z doby Války starověku. Straší u jezera Lake Mennar v Azsharu – odkaz na knihy War of the Ancients.]],
    ["King Mosh"] = [[Obrovský devilsaurus (level 60), vzácný a velmi nebezpečný.]],
    ["Twilight Lord Everun"] = [[Vzácný kultista, který se objevuje často (15–45 min).]],
}

-- Další zajímavé postavy světa (klíč = přesné jméno NPC ve hře)
do
local P = WoWpoCesku_Postavy

-- Durotar a Orgrimmar
P["Gornek"] = "Ork, který v Valley of Trials vítá mladé bojovníky Hordy. Pamatuje si časy internačních táborů."
P["Foreman Thazz'ril"] = "Předák v Valley of Trials. Dá ti obušek na líné peony, kteří spí pod stromy."
P["Master Gadrin"] = "Trollí šaman v Sen'jin Village. Chce, aby se Darkspear vrátili na Echo Isles."
P["Gar'Thok"] = "Velitel Razor Hill, posílá mladé bojovníky proti kentaurům a lidem z Tiragarde Keep."
P["Orgnil Soulscar"] = "Šaman v Razor Hill. Sleduje kult Burning Blade a jeho temné rituály."
P["Overlord Runthak"] = "Orkský velitel v Orgrimmaru. Když hrdinové přinesou hlavu Onyxie, vyhlásí to celému městu."

-- Barrens
P["Thork"] = "Ork v Crossroads, jeden z hlavních zadavatelů questů v Barrens."
P["Sergra Darkthorn"] = "Orkská lovkyně v Crossroads. Posílá tě lovit zvěř a kančí lidi z Razorfen."
P["Tonga Runetotem"] = "Tauren druid v Crossroads, sleduje, jak se příroda Barrens mění."
P["Mebok Mizzyrix"] = "Goblin v Ratchetu, který chce zkoumat zvířata Barrens – za peníze, samozřejmě."
P["Disciple of Naralex"] = "Poslední věrný žák druida Naralexe. Čeká u Wailing Caverns na hrdiny, kteří mu pomohou."
P["Naralex"] = "Druid, který chtěl Barrens zazelenat silou Smaragdového snu – a uvízl v Noční můře."
P["Mangletooth"] = "Zajatý kančí člověk v Camp Taurajo. Za Blood Shards ti dá posilující požehnání."

-- Mulgore a Thunder Bluff
P["Chief Hawkwind"] = "Náčelník Camp Narache, kde mladí taureni začínají svou cestu."
P["Grull Hawkwind"] = "Tauren z Camp Narache z rodu Hawkwindů."
P["Mull Thunderhorn"] = "Tauren v Bloodhoof Village, zadavatel questů pro mladé taureny."

-- Undercity a Tirisfal
P["Executor Zygand"] = "Velitel Forsaken v Brillu, posílá hrdiny proti Šarlatovým."
P["Coleman Farthing"] = "Forsaken v hostinci v Brillu, který zná příběh rodu Agamandů."
P["Apothecary Johaan"] = "Lékárník v Brillu. Jeho pokusy jsou prvním náznakem, co Royal Apothecary Society chystá."
P["Bethor Iceshard"] = "Bývalý mág z Dalaranu, dnes Forsaken v Undercity. Mágové, kteří ho kdysi vyhnali, by si měli dát pozor."
P["Gordo"] = "Obří zrůda (abomination) v Tirisfalu. Pomáhá Forsaken – svým zvláštním způsobem."
P["High Executor Hadrec"] = "Velitel Forsaken v The Sepulcher v Silverpine Forest."
P["Dalar Dawnweaver"] = "Forsaken mág v The Sepulcher, který zkoumá Arugala a jeho worgeny."
P["High Executor Darthalia"] = "Velitelka Forsaken v Tarren Mill."
P["Nathanos Blightcaller"] = "Jediný člověk, kterého Sylvanas učinila hraničářským lordem. Dnes je Forsaken a její nejvěrnější šampion."

-- Stormwind a Elwynn
P["Marshal McBride"] = "Velitel stráží v Northshire, první, kdo pošle mladé lidi do boje."
P["Deputy Willem"] = "Strážný u kláštera v Northshire, který ti dá úplně první quest."
P["Remy \"Two Times\""] = "Obchodník v Goldshire, který všechno říká dvakrát. Všechno říká dvakrát."
P["William Pestle"] = "Alchymista v Goldshire, který namíchá Maybell Maclure lektvar neviditelnosti, aby mohla utéct za Tommym Joem."
P["Ma Stonefield"] = "Hlava rodiny Stonefieldových. Chce, aby někdo konečně skoncoval s prasnicí Princess."
P["Tommy Joe Stonefield"] = "Mladík ze Stonefieldovy farmy, zamilovaný do Maybell z nepřátelské rodiny Maclureových."
P["Baros Alexston"] = "Městský architekt Stormwindu. Jemu byl adresován dopis, který VanCleef nikdy neposlal."
P["Archbishop Benedictus"] = "Arcibiskup v katedrále Svatého světla ve Stormwindu."
P["Gakin the Darkbinder"] = "Čaroděj ve sklepě hostince The Slaughtered Lamb. Učí čaroděje, o kterých stráže raději nevědí."
P["Lord Grayson Shadowbreaker"] = "Paladin v katedrále, učitel paladinů Aliance."
P["Marshal Windsor"] = "Hrdina Aliance zajatý v Blackrock. Jeho osvobození vede k odhalení lady Prestor."

-- Westfall, Redridge, Duskwood
P["Salma Saldean"] = "Farmářka ve Westfallu, která vaří slavný Westfall Stew pro každého, kdo pomůže."
P["Farmer Saldean"] = "Farmář ve Westfallu, kterého trápí zbláznivší se strašáci Harvest Watcher."
P["Verna Furlbrow"] = "Žena z Westfallu, která přišla o statek a čeká u rozbitého vozu. Její starý kůň potřebuje ovesy."
P["Farmer Furlbrow"] = "Farmář, kterého Defiasové vyhnali z vlastního statku."
P["Captain Danuvin"] = "Kapitán Lidové domobrany na Sentinel Hill."
P["Scout Galiaan"] = "Zvědka Lidové domobrany, sleduje Defiasy po celém Westfallu."
P["Magistrate Solomon"] = "Starosta Lakeshire. Píše do Stormwindu o pomoc, ale odpověď nepřichází."
P["Marshal Marris"] = "Velitel stráží v Redridge, bojuje s gnolly a orky Blackrock."
P["Wiley the Black"] = "Zloděj v hostinci v Lakeshire. Splácí dluh Gryanu Stoutmantlovi, a tak ti prozradí, co ví o Bratrstvu Defias."
P["Commander Althea Ebonlocke"] = "Velitelka hlídky Night Watch v Darkshire. Drží město pohromadě."
P["Madame Eva"] = "Věštkyně v Darkshire, která ví o temných silách v Duskwood víc, než prozradí."
P["Abercrombie"] = "Milý stařík v chatrči v Duskwood. SPOILER: je to nekromant, který sešil Stitches."
P["Sven Yorgen"] = "Muž, kterému v Duskwood zničili rodinu. Hledá pomstu na nekromantu Morbentu Felovi."

-- Ironforge a Dun Morogh
P["Royal Historian Archesonus"] = "Královský historik v Ironforge. Rád ti vypráví příběh Války tří kladiv."
P["Prospector Stormpike"] = "Badatel Explorers' League v Hall of Explorers."
P["Historian Karnik"] = "Historik Explorers' League, který sbírá artefakty z celého Azerothu."
P["Ragnar Thunderbrew"] = "Pivovarník z Kharanosu, z rodu slavných Thunderbrewů."
P["Senir Whitebeard"] = "Starý trpaslík v Dun Morogh."
P["Prospector Ironband"] = "Trpasličí badatel, jehož výkop v Loch Modan zaplavili troggové."
P["Captain Rugelfuss"] = "Trpasličí kapitán v Loch Modan."
P["Falstad Wildhammer"] = "Náčelník trpaslíků Wildhammer v Aerie Peak, legendární gryfí jezdec."

-- Teldrassil, Darkshore, Darnassus
P["Tarindrella"] = "Tajemná dryáda, která se vrátila do Shadowglen, aby bojovala se zkázou lesa."
P["Tenaron Stormgrip"] = "Noční elf na vrcholu stromu Aldrassil v Shadowglen."
P["Melithar Staghelm"] = "Druid v Shadowglen z rodu Staghelmů."
P["Corithras Moonrage"] = "Strážce Dolanaar, vesnice na cestě do Darnassu."
P["Mathrengyl Bearwalker"] = "Druid v Darnassu, učitel druidů Aliance."
P["Thundris Windweaver"] = "Starý druid v Auberdine, který zkoumá, proč je Darkshore nemocný."
P["Cerellean Whiteclaw"] = "Druid v Auberdine, který truchlí pro svou lásku Anayu Dawnrunner. Zemřela před deseti tisíci lety."
P["Prospector Remtravel"] = "Trpasličí badatel v Darkshore, který tvrdí, že našel něco úžasného. Jeho výkopy končí překvapením."
P["Gershala Nightwhisper"] = "Noční elfka v Auberdine, zadavatelka questů."
P["Terenthis"] = "Noční elf v Auberdine, který posílá hrdiny zjistit, jak velkou hrozbou jsou furbolgové."

-- Theramore, Dustwallow
P["Archmage Tervosh"] = "Mág v Theramore, věrný pomocník lady Jainy."
P["Captain Garran Vimes"] = "Kapitán stráží v Theramore. Jméno je odkaz na kapitána Samuela Vimese z knih Terryho Pratchetta."
P["Overlord Mok'Morokk"] = "Ogr, velitel Hordy v Brackenwall Village. Velký, silný a ne moc chytrý."
P["Tabetha"] = "Mágyně, která žije sama na farmě v bažinách Dustwallow."

-- Booty Bay, Stranglethorn, Tanaris, Ratchet
P["Baron Revilgaz"] = "Goblin, vládce Booty Bay. Platí tu jen jeho zákony a obchod."
P["Fleet Master Seahorn"] = "Velitel flotily Booty Bay ve válce proti pirátům Bloodsail."
P["Sir S. J. Erlgadin"] = "Lovec z Nesingwaryho výpravy ve Stranglethorn."
P["Barnil Stonepot"] = "Trpasličí lovec z Nesingwaryho výpravy."
P["Krazek"] = "Goblin, sekretář barona Revilgaze v Booty Bay. Tvrdí, že ví o všem, co se v džungli děje."
P["Crank Fizzlebub"] = "Goblinský inženýr v Booty Bay, má kousek pro každého, kdo mu pomůže."
P["Oglethorpe Obnoticus"] = "Gnóm v Booty Bay. Za tři zachráněná robotická kuřata OOX ti dá mechanické kuře."
P["Old Man Heming"] = "Starý rybář v Booty Bay, který ví o rybaření všechno."
P["Marin Noggenfogger"] = "Obchodní princ Gadgetzanu. Jeho Noggenfogger Elixir tě může zmenšit, zpomalit pád – nebo z tebe udělat kostlivce."
P["Chief Engineer Bilgewhizzle"] = "Hlavní inženýr Gadgetzanu, který hlídá čerpání vody z hlubin."
P["Krinkle Goodsteel"] = "Goblinský kovář v Gadgetzanu."
P["Wharfmaster Dizzywig"] = "Správce přístavu v Ratchetu."
P["Lieutenant Doren"] = "Velitel Rebel Camp ve Stranglethorn, posílá hrdiny proti Kurzenovým žoldákům."
P["Commander Aggro'gosh"] = "Velitel Hordy v Grom'gol Base Camp."

-- Severní a jižní kraje
P["Kalaran Windblade"] = "Muž v Searing Gorge, jehož příběh o Dark Ironech a jejich prokletí stojí za vyslechnutí."
P["Lothos Riftwaker"] = "Strážce vstupu do Molten Core v Blackrock Mountain. Kdo má úlomek jádra, toho přenese dovnitř."
P["Franclorn Forgewright"] = "Duch trpasličího stavitele v Blackrock Mountain. Jeho quest vede ke klíči Shadowforge Key."
P["Kharan Mighthammer"] = "Trpasličí vězeň v Blackrock Depths, který zná pravdu o princezně Moiře."
P["Lokhtos Darkbargainer"] = "Obchodník Thorium Brotherhood v Blackrock Depths. Prodává recepty na nejlepší zbraně a zbroje."
P["Plugger Spazzring"] = "Hospodský v Grim Guzzler v Blackrock Depths. Nesahej mu na pivo."
P["Marshal Maxwell"] = "Velitel Aliance v Morgan's Vigil v Burning Steppes."
P["Ragged John"] = "Podivný tulák v Burning Steppes, který vypráví veršované historky."
P["Shakes O'Breen"] = "Pirátský kapitán ve Faldir's Cove v Arathi."
P["Professor Phizzlethorpe"] = "Gnómský vědec v Arathi, kterého doprovázíš při jeho pokusech."
P["Magistrate Henry Maleb"] = "Starosta Southshore."
P["Farmer Ray"] = "Farmář na polích Hillsbradu. Hráči Hordy na něj dostanou quest v bitvě o Hillsbrad."
P["Lord Aliden Perenolde"] = "Šlechtic z rodu zrádných králů Alteracu, dnes ve spojení se Syndikátem."
P["Primal Torntusk"] = "Vůdce trollů Revantusk v Hinterlands."
P["Gryphon Master Talonaxe"] = "Chovatel gryfů v Aerie Peak."
P["Commander Ashlam Valorfist"] = "Velitel Aliance v Chillwind Camp v Western Plaguelands."
P["High Executor Derrington"] = "Velitel Forsaken v The Bulwark."
P["Alchemist Arbington"] = "Alchymista v Chillwind Camp, který zkoumá mor."
P["Highlord Taelan Fordring"] = "Syn Tiriona Fordringa, velitel Šarlatových v Hearthglen. Jeho příběh s otcem je jedním z nejsmutnějších v klasice."
P["Lord Maxwell Tyrosus"] = "Velitel Argent Dawn v Light's Hope Chapel."
P["Duke Nicholas Zverenhoff"] = "Šlechtic z Argent Dawn v Light's Hope Chapel."
P["Pamela Redpath"] = "Duch malé holčičky v Darrowshire, která hledá svou panenku a svou rodinu."
P["Joseph Redpath"] = "Pamelin otec, hrdina bitvy u Darrowshire. Jeho osud je smutný."
P["Fallen Hero of the Horde"] = "Duch orka u Stonardu v Swamp of Sorrows. Jeho příběh vede až do Blasted Lands."
P["Itharius"] = "Zelený drak, který hlídá potopený chrám Atal'Hakkar."
P["Galen Goodward"] = "Muž uvězněný v Swamp of Sorrows. Doprovoď ho do bezpečí."
P["Bloodmage Lynnore"] = "Mág v Nethergarde Keep. Za suroviny z Blasted Lands ti udělá silné elixíry."
P["Bloodmage Drazial"] = "Druhý z mágů v Nethergarde Keep, kteří vaří elixíry z ingrediencí Blasted Lands."

-- Kalimdor
P["Pozzik"] = "Goblinský závodník na Mirage Raceway v Thousand Needles."
P["Kravel Koalbeard"] = "Gnómský inženýr, soupeř goblinů na Mirage Raceway."
P["Pao'ka Swiftmountain"] = "Mladý tauren ztracený v Thousand Needles. Doprovoď ho domů."
P["Smeed Scrabblescrew"] = "Goblin v Desolace, který ti dá kouzlo na zkrocení umírajících kodo."
P["Kim'jael"] = "Goblin v Azshara, kterému ukradli vybavení."
P["Duke Hydraxis"] = "Vodní elementál na ostrově u Azshary. Posílá hrdiny proti služebníkům Ragnarose."
P["Loramus Thalipedes"] = "Démonolog v Azshara, který o démonech ví víc, než je zdrávo."
P["Arko'narin"] = "Noční elfka uvězněná v Shadow Hold ve Felwood. Kdo ji osvobodí, dozví se, co chystá Shadow Council."
P["Eridan Bluewind"] = "Druid v Emerald Sanctuary, který se snaží vyléčit Felwood."
P["Winna Hazzard"] = "Goblinka ve Felwood, která učí očišťovat zkažené rostliny."
P["Donova Snowden"] = "Badatelka ve Winterspring, která zkoumá furbolgy a jejich zkázu."
P["Rivern Frostwind"] = "Cvičitel sněhových levhartů ve Frostsaber Rock. Za reputaci ti prodá vzácného mounta."
P["Haleh"] = "Modrá dračice, ochránkyně doupěte Mazthoril ve Winterspring."
P["Rabine Saturna"] = "Druid Cenarion Circle v Nighthaven."
P["Torwa Pathfinder"] = "Tauren v Un'Goro, který zkoumá pravěkou zvěř kráteru."
P["J.D. Collie"] = "Badatel v Marshal's Refuge, který zkoumá krystaly a pylony Un'Goro."
P["Larion"] = "Mág v Marshal's Refuge, který se hádá se svým sousedem Muiginem."
P["Muigin"] = "Druid v Marshal's Refuge, věčný soupeř mága Lariona."
P["A-Me 01"] = "Robot v Un'Goro, kterého doprovázíš do bezpečí. Jeho hlášky stojí za to."
P["Spraggle Frock"] = "Goblin v Marshal's Refuge, který hledá ztraceného Ringa."
P["Commander Mar'alith"] = "Velitel Cenarion Hold v Silithu."

-- Bossové a legendy
P["Hakkar"] = "Krvavý bůh trollů Gurubashi, který se vrátil v Zul'Gurub."
P["C'Thun"] = "Starý bůh, který spí pod Ahn'Qiraj a ovládá silithidy i Qiraji."
P["Archmage Arugal"] = "Arcimág z Dalaranu, který vyvolal worgeny a teď jim říká „své děti“."
P["Mekgineer Thermaplugg"] = "Gnóm, který zradil Gnomeregan a prohlásil se králem toho, co zbylo."
P["Charlga Razorflank"] = "Kněžka kančích lidí v Razorfen Kraul, která je chce sjednotit."
P["Archaedas"] = "Kamenný obr, strážce trezoru titánů v Uldamanu."
P["Princess Theradras"] = "Princezna živlu země, která v Maraudonu truchlí za Zaetarem."
P["Gahz'rilla"] = "Obří hydra, kterou uctívají trollové Sandfury v Zul'Farrak."
P["High Inquisitor Whitemane"] = "Inkvizitorka Šarlatových. Umí vzkřísit Mograina slavným „Arise, my champion!“."
P["Scarlet Commander Mograine"] = "Velitel Šarlatového kláštera, syn hrdiny Alexandrose Mograina."
P["Herod"] = "Šampion Šarlatových ve zbrojnici. „Blades of Light!“"
P["Nefarian"] = "Černý drak, syn Deathwinga, pán Blackwing Lair."
P["Vaelastrasz the Corrupt"] = "Rudý drak, kterého Nefarian zkazil. Dobrý drak v zajetí zla."
P["Majordomo Executus"] = "Správce Molten Core, který přivolá samotného Ragnarose."
P["General Drakkisath"] = "Generál černých draků na vrcholu Blackrock Spire."
P["Warchief Rend Blackhand"] = "Syn Blackhanda, který si v Blackrock Spire říká válečný náčelník Hordy."
P["Grand Crusader Dathrohan"] = "Velitel Šarlatových ve Stratholme. SPOILER: ve skutečnosti démon Balnazzar."
P["Bazil Thredd"] = "Vůdce vzpoury ve stormwindském vězení, spojenec Edwina VanCleefa."
P["Ysondre"] = "Zelená dračice posedlá Noční můrou. Objevuje se u stromů snu."
P["Emeriss"] = "Zelená dračice zkažená Noční můrou. Objevuje se u stromů snu."
P["Lethon"] = "Zelený drak posedlý Noční můrou. Objevuje se u stromů snu."
P["Taerar"] = "Zelený drak posedlý Noční můrou. Objevuje se u stromů snu."
end
