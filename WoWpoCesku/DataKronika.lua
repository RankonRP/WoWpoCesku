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
    ["Captain Grayson"] = "Duch pirátského kapitána v majáku Westfallu. Jeho loď ztroskotala, protože maják té noci nesvítil. Teď plamen hlídá sám.",
    ["Old Murk-Eye"] = "Starý vůdce murloků na pobřeží Westfallu, který útočí na maják. Zabil i rodinu jeho strážce.",
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
P["Ahab Wheathoof"] = "Tauren v Mulgore, kterému utekl pes Kyle. Quest Kyle's Gone Missing! je jeden z nejroztomilejších v Mulgore."
P["Kyle the Frenzied"] = "Pes Ahaba Wheathoofa. Utekl a neposlouchá – dokud nedostane pamlsek."

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

-- Souřadnice míst Poutníkova deníku pro značky na mapě: {x, y} v % mapy (Warcraft Wiki)
-- nebo {"w", kontinent, x, y} světové souřadnice (CMaNGOS game_tele). Místa bez souřadnic
-- addon najde sám podle objevených oblastí na mapě.
WoWpoCesku_ObjevyPts = {
    ["Durotar"] = { ["Valley of Trials"] = { "w", 1, -601.3, -4296.8 }, ["Razor Hill"] = { "w", 1, 326.8, -4706.6 }, ["Sen'jin Village"] = { "w", 1, -813.1, -4880.1 }, ["Echo Isles"] = { "w", 1, -1041.6, -5346.7 }, ["Tiragarde Keep"] = { 58, 57 }, ["Skull Rock"] = { 55, 11 }, ["Drygulch Ravine"] = { 52.3, 27.3 }, ["Orgrimmar"] = { "w", 1, 1629.4, -4373.4 }, ["Ragefire Chasm"] = { "w", 1, 1811.8, -4410.5 } },
    ["Mulgore"] = { ["Camp Narache"] = { "w", 1, -2919.3, -264.5 }, ["Bloodhoof Village"] = { "w", 1, -2240.9, -399.2 }, ["Thunder Bluff"] = { "w", 1, -1277.4, 124.8 } },
    ["The Barrens"] = { ["The Crossroads"] = { "w", 1, -452.8, -2650.8 }, ["Ratchet"] = { "w", 1, -956.7, -3754.7 }, ["Camp Taurajo"] = { "w", 1, -2363.1, -1913.8 }, ["Wailing Caverns"] = { "w", 1, -731.6, -2218.4 }, ["Razorfen Kraul"] = { "w", 1, -4470.3, -1677.8 }, ["Razorfen Downs"] = { "w", 1, -4657.3, -2519.3 } },
    ["Teldrassil"] = { ["Shadowglen"] = { "w", 1, 10334, 833.9 }, ["Dolanaar"] = { "w", 1, 9848.4, 967 }, ["Darnassus"] = { "w", 1, 9949.6, 2284.2 }, ["Starbreeze Village"] = { 65, 49.6 } },
    ["Darkshore"] = { ["Auberdine"] = { "w", 1, 6501.4, 481.6 }, ["Ameth'Aran"] = { 43.6, 60.4 }, ["Bashal'Aran"] = { 45, 36 }, ["Tower of Althalaxx"] = { 56, 26 } },
    ["Ashenvale"] = { ["Astranaar"] = { "w", 1, 2676.2, -422.9 }, ["Splintertree Post"] = { "w", 1, 2270.9, -2538.2 }, ["Lake Falathim"] = { 21.4, 38.5 }, ["Warsong Lumber Camp"] = { 84.1, 62.6 }, ["Blackfathom Deeps"] = { "w", 1, 4250, 740.1 } },
    ["Stonetalon Mountains"] = { ["Sun Rock Retreat"] = { "w", 1, 966.1, 926.5 }, ["Stonetalon Peak"] = { "w", 1, 2678.4, 1497.5 }, ["Malaka'jin"] = { 70, 91 }, ["Mirkfallon Lake"] = { 47, 40 } },
    ["Thousand Needles"] = { ["Freewind Post"] = { "w", 1, -5431.8, -2449.4 }, ["Mirage Raceway"] = { "w", 1, -6221.3, -3927.6 }, ["Highperch"] = { 11, 37 }, ["Splithoof Crag"] = { 41, 39 }, ["Darkcloud Pinnacle"] = { 31.3, 37 }, ["Razorfen Downs"] = { "w", 1, -4657.3, -2519.3 } },
    ["Desolace"] = { ["Nijel's Point"] = { "w", 1, 176.4, 1309.8 }, ["Shadowprey Village"] = { "w", 1, -1664.8, 3091.7 }, ["Gelkis Village"] = { 35, 81 }, ["Maraudon"] = { "w", 1, -1419.1, 2908.1 } },
    ["Dustwallow Marsh"] = { ["Brackenwall Village"] = { "w", 1, -3130.7, -2908.4 }, ["Shady Rest Inn"] = { "w", 1, -3707.8, -2530.4 }, ["Onyxia's Lair"] = { "w", 1, -4708.3, -3727.6 } },
    ["Feralas"] = { ["Feathermoon Stronghold"] = { "w", 1, -4317.5, 3287.4 }, ["Camp Mojache"] = { "w", 1, -4396.7, 224.8 }, ["Dream Bough"] = { "w", 1, -2880.9, 1887.4 } },
    ["Azshara"] = { ["Valormok"] = { "w", 1, 3608.6, -4414.4 }, ["Talrendis Point"] = { "w", 1, 2735.1, -3867.4 } },
    ["Tanaris"] = { ["Gadgetzan"] = { "w", 1, -7177.1, -3785.3 }, ["Steamwheedle Port"] = { "w", 1, -6908.1, -4801.4 }, ["Caverns of Time"] = { "w", 1, -8204.9, -4495.2 }, ["Lost Rigger Cove"] = { 72.2, 46 }, ["Zul'Farrak"] = { "w", 1, -6801.2, -2893 } },
    ["Un'Goro Crater"] = { ["Marshal's Refuge"] = { "w", 1, -6152.2, -1087.6 } },
    ["Silithus"] = { ["Cenarion Hold"] = { "w", 1, -6818.1, 733.8 }, ["The Scarab Wall"] = { "w", 1, -8098.7, 1525.2 }, ["Hive'Regal"] = { 55, 87 } },
    ["Felwood"] = { ["Talonbranch Glade"] = { "w", 1, 6209.5, -1927 }, ["Bloodvenom Post"] = { "w", 1, 5128.9, -343.5 }, ["Emerald Sanctuary"] = { "w", 1, 3986.7, -1293.6 } },
    ["Winterspring"] = { ["Everlook"] = { "w", 1, 6725.7, -4619.4 }, ["Mazthoril"] = { 55, 62.1 } },
    ["Moonglade"] = { ["Nighthaven"] = { "w", 1, 7966.9, -2491 } },
    ["Elwynn Forest"] = { ["Northshire Valley"] = { "w", 0, -8921.1, -119.1 }, ["Goldshire"] = { "w", 0, -9448.5, 68.2 }, ["Brackwell Pumpkin Patch"] = { 70, 80 }, ["Tower of Azora"] = { 63, 70 } },
    ["Stormwind City"] = { ["Dwarven District"] = { 63, 31.6 }, ["The Stockade"] = { "w", 0, -8787.4, 828.4 } },
    ["Westfall"] = { ["Sentinel Hill"] = { "w", 0, -10624.5, 1096.7 }, ["Moonbrook"] = { "w", 0, -10986.7, 1542.8 }, ["The Deadmines"] = { "w", 0, -11208.7, 1673.5 } },
    ["Dun Morogh"] = { ["Coldridge Valley"] = { "w", 0, -6231.8, 333 }, ["Kharanos"] = { "w", 0, -5597.3, -483.4 }, ["Ironforge"] = { "w", 0, -4918.9, -940.4 }, ["Brewnall Village"] = { "w", 0, -5385, 310.3 }, ["Frostmane Hold"] = { 27, 53 }, ["Gnomeregan"] = { "w", 0, -5163.5, 925.4 } },
    ["Tirisfal Glades"] = { ["Deathknell"] = { "w", 0, 1843.5, 1590 }, ["Brill"] = { "w", 0, 2259.3, 290.4 }, ["Undercity"] = { "w", 0, 1584.1, 242 }, ["Scarlet Monastery"] = { "w", 0, 2872.6, -764.4 } },
    ["Silverpine Forest"] = { ["The Sepulcher"] = { "w", 0, 504.5, 1539.1 }, ["Pyrewood Village"] = { "w", 0, -388.1, 1543.7 }, ["Ambermill"] = { "w", 0, -129.1, 835.6 }, ["Fenris Isle"] = { "w", 0, 998.2, 736.5 }, ["Shadowfang Keep"] = { "w", 0, -234.7, 1561.6 } },
    ["Hillsbrad Foothills"] = { ["Southshore"] = { "w", 0, -853.2, -533.5 }, ["Tarren Mill"] = { "w", 0, -34.1, -923.4 }, ["Durnholde Keep"] = { "w", 0, -483.5, -1426.2 }, ["Azurelode Mine"] = { 33, 74 }, ["Dun Garok"] = { "w", 0, -1257, -1189.5 } },
    ["Alterac Mountains"] = { ["Ruins of Alterac"] = { "w", 0, 629.7, -348.1 }, ["Strahnbrad"] = { "w", 0, 659.8, -959.3 }, ["Dalaran"] = { "w", 0, 335.5, 204.8 }, ["Ravenholdt Manor"] = { "w", 0, -9.5, -1569.5 } },
    ["Arathi Highlands"] = { ["Refuge Pointe"] = { "w", 0, -1246.6, -2529.3 }, ["Hammerfall"] = { "w", 0, -941, -3526.7 }, ["Stromgarde Keep"] = { "w", 0, -1551.2, -1808.1 }, ["Circle of East Binding"] = { 58.5, 34.3 }, ["Circle of West Binding"] = { 18.8, 31 } },
    ["Wetlands"] = { ["Menethil Harbor"] = { "w", 0, -3769.3, -744.3 }, ["Dun Modr"] = { "w", 0, -2600.5, -2350.8 }, ["Grim Batol"] = { "w", 0, -4074.4, -3459.5 } },
    ["Loch Modan"] = { ["Stonewrought Dam"] = { "w", 0, -4750.1, -3328 } },
    ["Redridge Mountains"] = { ["Lakeshire"] = { "w", 0, -9266.6, -2188.8 }, ["Tower of Ilgalar"] = { "w", 0, -9284.8, -3346.9 }, ["Render's Valley"] = { 71, 78 } },
    ["Duskwood"] = { ["Darkshire"] = { "w", 0, -10573, -1182.5 }, ["Raven Hill"] = { "w", 0, -10742.2, 330.6 }, ["Twilight Grove"] = { "w", 0, -10384.3, -421.6 } },
    ["Stranglethorn Vale"] = { ["Booty Bay"] = { "w", 0, -14297.2, 531 }, ["Grom'gol Base Camp"] = { "w", 0, -12388.9, 172.6 }, ["Rebel Camp"] = { "w", 0, -11322.4, -202.5 }, ["Gurubashi Arena"] = { "w", 0, -13226.3, 232 }, ["Zul'Gurub"] = { "w", 0, -11916.7, -1215.7 }, ["Jaguero Isle"] = { 37, 79 } },
    ["The Hinterlands"] = { ["Aerie Peak"] = { "w", 0, 260.4, -2125.2 }, ["Revantusk Village"] = { "w", 0, -557.2, -4581.3 }, ["Jintha'Alor"] = { "w", 0, -233.8, -4121.9 }, ["Seradane"] = { "w", 0, 799.7, -3995.7 }, ["Quel'Danil Lodge"] = { "w", 0, 226.3, -2777.6 }, ["The Altar of Zul"] = { "w", 0, -271.7, -3438.5 } },
    ["Western Plaguelands"] = { ["Chillwind Camp"] = { "w", 0, 952.3, -1426.7 }, ["The Bulwark"] = { "w", 0, 1712, -719.8 }, ["Andorhal"] = { 44, 69 }, ["Caer Darrow"] = { "w", 0, 1248.8, -2604.1 }, ["Uther's Tomb"] = { 52, 83 }, ["Hearthglen"] = { "w", 0, 2793.1, -1621.4 } },
    ["Eastern Plaguelands"] = { ["Light's Hope Chapel"] = { "w", 0, 2279.7, -5310 }, ["Stratholme"] = { "w", 0, 3352.9, -3379 }, ["Darrowshire"] = { 34, 82 }, ["Tyr's Hand"] = { "w", 0, 1684.8, -5320.4 }, ["Corin's Crossing"] = { "w", 0, 2012.3, -4470.7 }, ["Plaguewood"] = { "w", 0, 3065.4, -3704 }, ["Terrordale"] = { "w", 0, 2957.9, -2794.8 } },
    ["Badlands"] = { ["Kargath"] = { "w", 0, -6692.5, -2175.3 }, ["Uldaman"] = { "w", 0, -6071.4, -2955.2 }, ["Angor Fortress"] = { "w", 0, -6398.5, -3166.7 } },
    ["Searing Gorge"] = { ["Thorium Point"] = { "w", 0, -6506.5, -1149.9 }, ["The Cauldron"] = { "w", 0, -6939.5, -1263.2 }, ["Blackrock Mountain"] = { "w", 0, -7494.9, -1123.5 } },
    ["Burning Steppes"] = { ["Morgan's Vigil"] = { "w", 0, -8372.8, -2754.5 }, ["Flame Crest"] = { "w", 0, -7501.5, -2183.1 }, ["Dreadmaul Rock"] = { "w", 0, -7734.8, -2609 }, ["Blackrock Stronghold"] = { "w", 0, -7733.4, -1510.2 }, ["Blackrock Spire"] = { "w", 0, -7527, -1226.8 } },
    ["Swamp of Sorrows"] = { ["Stonard"] = { "w", 0, -10446.9, -3261.9 }, ["The Temple of Atal'Hakkar"] = { "w", 0, -10450.3, -3825.4 } },
    ["Blasted Lands"] = { ["Nethergarde Keep"] = { "w", 0, -10999.8, -3380.1 }, ["The Dark Portal"] = { "w", 0, -11840.1, -3196.6 }, ["Dreadmaul Hold"] = { "w", 0, -10895, -2933.2 }, ["The Tainted Scar"] = { "w", 0, -11892.7, -2647.1 } },
    ["Deadwind Pass"] = { ["Karazhan"] = { "w", 0, -11118.9, -2010.3 } },
}

-- Příběhy slavných předmětů – poznámka pod popiskem předmětu (klíč = přesný anglický název;
-- klíč končící * = začátek názvu, třeba všechny stránky knihy)
WoWpoCesku_Predmety = {
    ["Thunderfury, Blessed Blade of the Windseeker"] = "Legendární meč z esence prince Thunderaana, vládce větrů. Ragnaros ho kdysi porazil a jeho esenci uzavřel do dvou pout – Bindings of the Windseeker. Hrdina, který získá obě, je přinese Highlordu Demitrianovi v Silithu, vyvolá Thunderaana, porazí ho a z jeho moci vznikne Thunderfury.",
    ["Bindings of the Windseeker"] = "Jedno ze dvou pout, ve kterých je uvězněna esence prince Thunderaana. V Molten Core je u sebe mají Garr a Baron Geddon. S oběma pouty se vydej v Silithu za Highlordem Demitrianem – začíná cesta k legendárnímu meči Thunderfury.",
    ["Sulfuras, Hand of Ragnaros"] = "Kopie kladiva samotného Pána ohně. Kovář, který si získá přízeň Thorium Brotherhood, vyková Sulfuron Hammer a spojí ho s Eye of Sulfuras, které padá z Ragnarose. Jedna z nejslavnějších zbraní klasického WoW.",
    ["Eye of Sulfuras"] = "Oko z Ragnarosova kladiva, které padá z Pána ohně v Molten Core. Spolu se Sulfuron Hammer z něj vznikne legendární Sulfuras, Hand of Ragnaros.",
    ["Sulfuron Hammer"] = "Kladivo, které kováři vykovají z ingotů Sulfuron z Molten Core (plán prodává Thorium Brotherhood). Spojené s Eye of Sulfuras se změní v legendární Sulfuras, Hand of Ragnaros.",
    ["Atiesh, Greatstaff of the Guardian"] = "Hůl Strážců Tirisfalu, kterou nosil i Medivh. Po jeho smrti ji opatrovali mágové Kirin Tor v Dalaranu, ale za Třetí války se rozpadla na kusy. Hrdinové sbírají úlomky (Splinter of Atiesh) v Naxxramasu, bronzový drak Anachronos je spojí a hůl se nakonec očistí ve Stratholme v boji s démonem, který v ní přebýval.",
    ["Splinter of Atiesh"] = "Úlomek hole Atiesh, kterou nosili Strážci Tirisfalu včetně Medivha. Hůl se rozpadla za Třetí války. Když jich v Naxxramasu posbíráš čtyřicet, složíš z nich rám hole a bronzový drak Anachronos tě povede dál.",
    ["Corrupted Ashbringer"] = "Kdysi Ashbringer, svatý meč, kterým Highlord Alexandros Mograine drtil nemrtvé. Jeho vlastní syn Renault ho tímto mečem zradil a zabil – a čepel se zkazila. Kel'Thuzad pak Alexandrose vzkřísil jako rytíře smrti. V klasice meč padá z Four Horsemen v Naxxramasu a jeho uvězněný duch šeptá o zradě každému, kdo ho drží.",
    ["Benediction"] = "Kněžská hůl, která v sobě skrývá dvojče – Anathema. Vznikne spojením Eye of Divinity, Eye of Shadow a Splinter of Nordrassil. Kdo má obě podoby, může mezi nimi přepínat: Benediction léčí, Anathema slouží temnotě.",
    ["Anathema"] = "Temná podoba kněžské hole Benediction. Kdo má obě, může mezi nimi přepínat – světlo a stín v jednom předmětu.",
    ["Rhok'delar, Longbow of the Ancient Keepers"] = "Luk prastarých strážců lesa. Lovec, který v Molten Core získá Ancient Petrified Leaf, ho odnese pradávnému stromu Hastat the Ancient ve Felwoodu. Ten ho podrobí zkoušce: sám musí porazit čtyři démony.",
    ["Lok'delar, Stave of the Ancient Keepers"] = "Hůl prastarých strážců lesa, kterou lovec dostane spolu s lukem Rhok'delar od pradávného stromu Hastat the Ancient ve Felwoodu – po zkoušce se čtyřmi démony.",
    ["Ancient Petrified Leaf"] = "Zkamenělý list prastarého stromu z Molten Core. Lovec s ním vyrazí za Hastatem the Ancient do Felwoodu – začíná cesta k luku Rhok'delar.",
    ["Quel'Serrar"] = "Legendární elfí meč. Kdo najde v Dire Maul knihu Foror's Compendium of Dragon Slaying, může se od knihovníka Shen'dralar dozvědět, jak ho obnovit: nevypálenou čepel musí rozžhavit dech samotné Onyxie.",
    ["Foror's Compendium of Dragon Slaying"] = "Kniha o zabíjení draků z Dire Maul. Odnes ji knihovníkovi Shen'dralar – vede k obnovení legendárního meče Quel'Serrar v dechu Onyxie.",
    ["Dal'Rend's Sacred Charge"] = "Jeden ze dvou mečů Warchiefa Renda Blackhanda, syna Blackhanda, který si v Blackrock Spire říká náčelník Hordy. Spolu s Dal'Rend's Tribal Guardian tvoří sadu.",
    ["Dal'Rend's Tribal Guardian"] = "Druhý z mečů Warchiefa Renda Blackhanda z Blackrock Spire. Spolu s Dal'Rend's Sacred Charge tvoří sadu.",
    ["Deathcharger's Reins"] = "Uzda kostlivého oře barona Rivendara ze Stratholme. Padá z barona jen vzácně. Kvůli ní hráči chodili do Stratholme znovu a znovu – a mnozí ho nikdy nedostali.",
    ["Swift Razzashi Raptor"] = "Rychlý raptor, na kterém jezdí Bloodlord Mandokir v Zul'Gurubu. Padá z něj jen vzácně.",
    ["Swift Zulian Tiger"] = "Rychlý tygr velekněze Thekala ze Zul'Gurubu. Padá z něj jen vzácně.",
    ["Black Qiraji Resonating Crystal"] = "Krystal, kterým se přivolá černý qirajský brouk. Dostali ho jen ti, kdo prošli celou řadou questů k bránám Ahn'Qiraj a udeřili do gongu – Scarab Lords. Na každém serveru jich bylo jen pár.",
    ["Scepter of the Shifting Sands"] = "Žezlo, které po Válce pohyblivých písků zapečetilo Ahn'Qiraj. Fandral Staghelm, který v té válce ztratil syna, ho ve zlosti rozbil. Hrdinové ho skládají v dlouhé řadě questů od bronzového draka Anachronose a kdo jím udeří do gongu na Scarab Wall, otevře brány pro celý server.",
    ["Hearthstone"] = "Kámen, který tě vrátí do hostince, kde jsi doma. Nejpoužívanější předmět ve hře – a jediný, který má od začátku každá postava.",
    ["Mechanical Chicken"] = "Robotické kuře od gnóma Oglethorpa Obnoticuse z Booty Bay. Dostaneš ho, když zachráníš všechna tři porouchaná kuřata OOX – v Tanaris, Feralasu a Hinterlands.",
    ["Onyxia Scale Cloak"] = "Plášť ze šupin Onyxie. Chrání před stínovým plamenem jejího bratra Nefariana – bez něj se s ním v Blackwing Lair bojovat nedá.",
    ["Head of Onyxia"] = "Hlava černé dračice Onyxie. Hrdinové Aliance ji přinesou regentovi Bolvarovi do Stormwindu, Horda Thrallovi do Orgrimmaru. Hlava se pak vystaví u brány a celé město dostane buff.",
    ["Head of Nefarian"] = "Hlava černého draka Nefariana z Blackwing Lair. Vystaví se ve Stormwindu nebo v Orgrimmaru a celé město dostane buff – stejně jako u hlavy jeho sestry Onyxie.",
    ["An Unsent Letter"] = "Dopis, který Edwin VanCleef nikdy neodeslal. Je adresovaný Barosu Alexstonovi, městskému architektovi Stormwindu. Odnes mu ho – vede to k další stopě Bratrstva Defias.",
    ["Seal of Ascension"] = "Klíč do horní části Blackrock Spire. Prsten musíš doplnit drahokamy od bossů dolní části a nakonec ho posílit krví draka.",
    ["Carrot on a Stick"] = "Mrkev na klacku – trinket, který zrychlí jízdu na mountovi. Je to odměna za quest Gahz'rilla od Wizzla Brassboltse na Mirage Raceway v Thousand Needles: v Zul'Farraku musíš porazit obří hydru Gahz'rillu.",
    ["Arcanite Reaper"] = "Obouruční sekera z arkanitu, kterou vykovají zkušení kováři. V klasice symbol bohatství – kdo s ní v Barrens jezdil, toho všichni znali.",
    ["Blackhand's Breadth"] = "Trinket nesoucí jméno Blackhanda, prvního náčelníka Hordy. Padá z generála Drakkisatha na vrcholu Blackrock Spire.",
    ["Green Hills of Stranglethorn*"] = "Stránka z knihy Hemeta Nesingwaryho, která je rozházená po celé Stranglethorn. Kdo posbírá všechny stránky kapitoly, složí ji a odnese do Nesingwaryho tábora. Název odkazuje na Hemingwayovy „Zelené pahorky africké“.",
}

-- Pečetě kronikáře – Legendy Azerothu (slavné questové příběhy) a skryté pečetě.
-- Legenda: q = čísla questů z classic DB (stačí kterýkoli; víc čísel = varianty frakcí/povolání),
-- f = "A"/"H" jen pro jednu frakci, gold = vzácná (zlatý vosk), pts = body.
WoWpoCesku_SealLegends = {
    -- obě frakce
    { id = "oox", q = { 3721 }, name = "Kuře z plechu", pts = 10,
      desc = "Zachraň všechna tři porouchaná robotická kuřata OOX (Tanaris, Feralas, Hinterlands)." },
    { id = "greenhills", q = { 338 }, name = "Zelené pahorky", pts = 10,
      desc = "Slož celou knihu Hemeta Nesingwaryho Green Hills of Stranglethorn." },
    { id = "tirion", q = { 5944 }, name = "Vykoupení", pts = 25, gold = true,
      desc = "Dokonči příběh Tiriona Fordringa až do konce (quest In Dreams)." },
    { id = "darrowshire", q = { 5721 }, name = "Bitva u Darrowshire", pts = 10,
      desc = "Prožij znovu bitvu u Darrowshire (quest The Battle of Darrowshire)." },
    { id = "linken", q = { 3962 }, name = "Je nebezpečné jít sám", pts = 10,
      desc = "Pomoz podivnému chlapci Linkenovi v Un'Goro (quest It's Dangerous to Go Alone)." },
    { id = "gahzrilla", q = { 2770 }, name = "Mrkev na klacku", pts = 10,
      desc = "Poraz v Zul'Farraku hydru Gahz'rillu pro Wizzla Brassboltse (quest Gahz'rilla)." },
    { id = "tooga", q = { 1560 }, name = "Pomalu, ale jistě", pts = 5,
      desc = "Doprovoď v Tanaris ztracenou želvu Toogu k její družce (quest Tooga's Quest)." },
    { id = "kodo", q = { 5561 }, name = "Kodí hřbitov", pts = 5,
      desc = "Zkroť umírající kodo v Desolace (quest Kodo Roundup)." },
    { id = "galen", q = { 1393 }, name = "Galenův útěk", pts = 5,
      desc = "Doprovoď Galena Goodwarda bažinami do bezpečí (quest Galen's Escape)." },
    { id = "darkiron", q = { 3802 }, name = "Odkaz Dark Ironů", pts = 10,
      desc = "Získej klíč Shadowforge Key pro ducha Franclorna Forgewrighta (quest Dark Iron Legacy)." },
    { id = "onyattune", q = { 6502, 6602 }, name = "Proti dračici", pts = 25, gold = true,
      desc = "Dokonči dlouhou řadu questů ke vstupu do Onyxia's Lair (Drakefire Amulet nebo Blood of the Black Dragon Champion)." },
    { id = "onyhead", q = { 7495, 7490 }, name = "Drakobijce", pts = 25, gold = true,
      desc = "Přines hlavu Onyxie do svého hlavního města (Victory for the Alliance / Victory for the Horde)." },
    { id = "nefhead", q = { 7782, 7784 }, name = "Pán Blackrocku padl", pts = 25, gold = true,
      desc = "Přines hlavu Nefariana do svého hlavního města (quest The Lord of Blackrock)." },
    { id = "thunderfury", q = { 7787 }, name = "Požehnaný větrem", pts = 50, gold = true,
      desc = "Probuď legendární meč Thunderfury (quest Rise, Thunderfury!)." },
    { id = "atiesh", q = { 9257, 9269, 9270, 9271 }, name = "Strážce Tirisfalu", pts = 50, gold = true,
      desc = "Očisti a slož hůl Atiesh, Greatstaff of the Guardian." },
    { id = "gong", q = { 8743 }, name = "Pán skarabů", pts = 50, gold = true,
      desc = "Udeř do gongu na Scarab Wall a otevři brány Ahn'Qiraj (quest Bang a Gong!)." },
    -- Aliance
    { id = "defias", q = { 166 }, f = "A", name = "Konec Bratrstva", pts = 10,
      desc = "Dokonči celý příběh The Defias Brotherhood a poraz Edwina VanCleefa." },
    { id = "unsent", q = { 373 }, f = "A", name = "Neodeslaný dopis", pts = 5,
      desc = "Doruč VanCleefův dopis architektovi Barosu Alexstonovi (quest The Unsent Letter)." },
    { id = "princess", q = { 88 }, f = "A", name = "Princezna musí zemřít", pts = 5,
      desc = "Zbav Ma Stonefield obří prasnice Princess (quest Princess Must Die!)." },
    { id = "lovers", q = { 114 }, f = "A", name = "Mladí milenci", pts = 5,
      desc = "Pomoz Maybell Maclure utéct za Tommym Joem (quest The Escape)." },
    { id = "hogger", q = { 176 }, f = "A", name = "Hoggerova hlava", pts = 5,
      desc = "Přines Marshalu Dughanovi hlavu Hoggera (quest Wanted: \"Hogger\")." },
    { id = "diplomat", q = { 1267 }, f = "A", name = "Zmizelý diplomat", pts = 10,
      desc = "Dokonči celou řadu questů The Missing Diplomat od Stormwindu až po Theramore." },
    { id = "loveeternal", q = { 963 }, f = "A", name = "Láska věčná", pts = 5,
      desc = "Přines druidovi Cerelleanovi přívěsek jeho lásky Anayi (quest For Love Eternal)." },
    { id = "morbent", q = { 55 }, f = "A", name = "Morbentova zhouba", pts = 10,
      desc = "Poraz nekromanta Morbenta Fela v Duskwoodu (quest Morbent Fel)." },
    { id = "masquerade", q = { 6403 }, f = "A", name = "Velká maškaráda", pts = 25, gold = true,
      desc = "Odhal ve Stormwindu pravou tvář lady Prestor (quest The Great Masquerade)." },
    { id = "prospector", q = { 943 }, f = "A", name = "Roztržitý prospektor", pts = 10,
      desc = "Dokonči řadu questů The Absent Minded Prospector s Remtravelem." },
    { id = "althalaxx", q = { 981 }, f = "A", name = "Věž Althalaxx", pts = 10,
      desc = "Dokonči celý příběh The Tower of Althalaxx proti kultu Dark Strand." },
    -- Horda
    { id = "mankrik", q = { 4921 }, f = "H", name = "Mankrikova žena", pts = 10,
      desc = "Najdi Olgru, ženu orka Mankrika (quest Lost in Battle). Konečně víš, kde je!" },
    { id = "hidden", q = { 5730 }, f = "H", name = "Skrytí nepřátelé", pts = 10,
      desc = "Odhal pro Thralla, kdo stojí za kultem Burning Blade (quest Hidden Enemies)." },
    { id = "peons", q = { 5441 }, f = "H", name = "Líní peoni", pts = 5,
      desc = "Probuď spící peony v Valley of Trials (quest Lazy Peons)." },
    { id = "admiral", q = { 831 }, f = "H", name = "Admirálovy rozkazy", pts = 5,
      desc = "Doruč Thrallovi rozkazy admirála Proudmoora z Tiragarde Keep (quest The Admiral's Orders)." },
    { id = "mazzranache", q = { 766 }, f = "H", name = "Lov na Mazzranache", pts = 5,
      desc = "Ulov obrovskou pumu Mazzranache pro Maura Raincallera (quest Mazzranache)." },
    { id = "agamand", q = { 354 }, f = "H", name = "Smrt v rodině", pts = 5,
      desc = "Ukonči trápení nemrtvého rodu Agamandů (quest Deaths in the Family)." },
    { id = "hillsbrad", q = { 550 }, f = "H", name = "Bitva o Hillsbrad", pts = 10,
      desc = "Dokonči celou řadu questů Battle of Hillsbrad." },
    { id = "arugal", q = { 1014 }, f = "H", name = "Arugal musí zemřít", pts = 10,
      desc = "Poraz v Shadowfang Keep arcimága Arugala (quest Arugal Must Die)." },
    { id = "crown", q = { 521 }, f = "H", name = "Koruna vůle", pts = 10,
      desc = "Dokonči celou řadu questů The Crown of Will." },
    { id = "agony", q = { 524 }, f = "H", name = "Elixír agónie", pts = 10,
      desc = "Dokonči celou řadu questů Elixir of Agony." },
}

-- Skryté pečetě: do získání jen „???“ a nápověda. npc = potkat (zaměřit / najet myší),
-- misto = navštívit podoblast.
WoWpoCesku_SealHidden = {
    { id = "tirionmet", npc = "Tirion Fordring", name = "Muž u řeky", pts = 10,
      hint = "Prý u řeky na západě Eastern Plaguelands žije poustevník, který kdysi býval paladinem…",
      desc = "Potkal(a) jsi Tiriona Fordringa." },
    { id = "azuregos", npc = "Azuregos", name = "Modrá bouře", pts = 10,
      hint = "V Azsharu prý žije obří modrý drak, strážce magických tajemství…", desc = "Spatřil(a) jsi draka Azuregose." },
    { id = "kazzak", npc = "Lord Kazzak", name = "Démon v jizvě", pts = 10,
      hint = "V Blasted Lands po válce zůstal obrovský démon, kterého nikdo nevyhnal…", desc = "Spatřil(a) jsi Lorda Kazzaka." },
    { id = "rexxar", npc = "Rexxar", name = "Šampion Hordy", pts = 10,
      hint = "Po cestách Desolace chodí napůl ork, napůl ogr – a s ním medvědice…", desc = "Potkal(a) jsi Rexxara." },
    { id = "grayson", npc = "Captain Grayson", name = "Strážce plamene", pts = 5,
      hint = "V majáku na pobřeží Westfallu prý straší duch kapitána…", desc = "Potkal(a) jsi ducha kapitána Graysona." },
    { id = "murkeye", npc = "Old Murk-Eye", name = "Postrach pobřeží", pts = 5,
      hint = "Starý murlok, který kdysi vedl útoky na maják…", desc = "Našel(a) jsi Old Murk-Eye." },
    { id = "karazhan", misto = "Karazhan", name = "Ve stínu věže", pts = 10,
      hint = "Prokletá věž v Deadwind Pass. Přijdi až k jejím branám…", desc = "Stál(a) jsi u brány Karazhanu." },
    { id = "arena", misto = "Gurubashi Arena", name = "Gladiátor", pts = 5,
      hint = "Uprostřed džungle je aréna, kde se každé tři hodiny bojuje o truhlu…", desc = "Vstoupil(a) jsi do Gurubashi Arena." },
}

-- Pečetě kronikáře – postava, řemesla, reputace, kontinenty a města
WoWpoCesku_SealContinents = {
    { id = "kalimdor", name = "Poutník Kalimdoru", zones = { "Durotar", "Mulgore", "The Barrens", "Teldrassil", "Darkshore",
        "Ashenvale", "Stonetalon Mountains", "Thousand Needles", "Desolace", "Dustwallow Marsh", "Feralas", "Azshara",
        "Tanaris", "Un'Goro Crater", "Silithus", "Felwood", "Winterspring", "Moonglade" } },
    { id = "ek", name = "Poutník Východních království", zones = { "Elwynn Forest", "Westfall", "Dun Morogh", "Tirisfal Glades",
        "Silverpine Forest", "Hillsbrad Foothills", "Alterac Mountains", "Arathi Highlands", "Wetlands", "Loch Modan",
        "Redridge Mountains", "Duskwood", "Stranglethorn Vale", "The Hinterlands", "Western Plaguelands",
        "Eastern Plaguelands", "Badlands", "Searing Gorge", "Burning Steppes", "Swamp of Sorrows", "Blasted Lands",
        "Deadwind Pass" } },
}

WoWpoCesku_SealCapitals = {
    Alliance = { "Stormwind City", "Ironforge", "Darnassus" },
    Horde = { "Orgrimmar", "Undercity", "Thunder Bluff" },
}

-- profese (anglický název ve hře -> mistr česky)
WoWpoCesku_SealProfese = {
    { "Alchemy", "Mistr alchymista", "alchymie" }, { "Blacksmithing", "Mistr kovář", "kovářství" },
    { "Enchanting", "Mistr očarovatel", "očarování" }, { "Engineering", "Mistr inženýr", "inženýrství" },
    { "Herbalism", "Mistr bylinkář", "bylinkářství" }, { "Leatherworking", "Mistr koželuh", "koželužství" },
    { "Mining", "Mistr horník", "hornictví" }, { "Skinning", "Mistr stahovač", "stahování kůží" },
    { "Tailoring", "Mistr krejčí", "krejčovství" }, { "Fishing", "Mistr rybář", "rybaření" },
    { "Cooking", "Mistr kuchař", "vaření" }, { "First Aid", "Mistr ranhojič", "první pomoc" },
}

-- reputace Exalted: { anglický název frakce ve hře, frakce hráče (A/H/nil), vzácná }
WoWpoCesku_SealRep = {
    { "Argent Dawn", nil, true }, { "Timbermaw Hold", nil, true }, { "Thorium Brotherhood", nil, true },
    { "Cenarion Circle", nil, true }, { "Hydraxian Waterlords", nil, false }, { "Brood of Nozdormu", nil, true },
    { "Zandalar Tribe", nil, false }, { "Bloodsail Buccaneers", nil, false }, { "Booty Bay", nil, false },
    { "Gadgetzan", nil, false }, { "Ratchet", nil, false }, { "Everlook", nil, false },
    { "Stormwind", "A", false }, { "Ironforge", "A", false }, { "Darnassus", "A", false }, { "Gnomeregan Exiles", "A", false },
    { "Wintersaber Trainers", "A", true }, { "Stormpike Guard", "A", false }, { "Silverwing Sentinels", "A", false },
    { "League of Arathor", "A", false },
    { "Orgrimmar", "H", false }, { "Thunder Bluff", "H", false }, { "Undercity", "H", false }, { "Darkspear Trolls", "H", false },
    { "Frostwolf Clan", "H", false }, { "Warsong Outriders", "H", false }, { "The Defilers", "H", false },
}

-- další skryté pečetě (doplňují WoWpoCesku_SealHidden)
do
    local H = WoWpoCesku_SealHidden
    H[#H + 1] = { id = "noncni", npcs = { "Ysondre", "Emeriss", "Lethon", "Taerar" }, name = "Strážci snu", pts = 25,
        hint = "Čtyři zelení draci, které pohltila Noční můra, se zjevují u velkých stromů snu…",
        desc = "Spatřil(a) jsi všechny čtyři draky Noční můry: Ysondre, Emeriss, Lethon a Taerar." }
    H[#H + 1] = { id = "olgra", npc = "Beaten Corpse", name = "Konečně nalezena", pts = 5,
        hint = "Celý Barrens se ptá, kde je Mankrikova žena. Možná ji najdeš ty…",
        desc = "Našel(a) jsi tělo Mankrikovy ženy Olgry." }
    H[#H + 1] = { id = "hoggermet", npc = "Hogger", name = "Postrach Elwynnu", pts = 5,
        hint = "Nejslavnější gnoll Warcraftu prý číhá v lesích na jihozápadě Elwynnu…", desc = "Potkal(a) jsi Hoggera." }
    H[#H + 1] = { id = "princessmet", npc = "Princess", name = "Královna dýňového pole", pts = 5,
        hint = "Na jednom dýňovém poli v Elwynnu se vykrmuje obrovská prasnice…", desc = "Potkal(a) jsi prasnici Princess." }
    H[#H + 1] = { id = "natpagle", npc = "Nat Pagle", name = "Rybářská legenda", pts = 5,
        hint = "Nejslavnější rybář Azerothu chytá ryby na ostrůvku v bažinách Dustwallow…", desc = "Potkal(a) jsi Nata Pagleho." }
    H[#H + 1] = { id = "linkenmet", npc = "Linken", name = "Chlapec v zeleném", pts = 5,
        hint = "V pravěkém kráteru žije podivný chlapec s mečem a štítem…", desc = "Potkal(a) jsi Linkena." }
    H[#H + 1] = { id = "spy", spy = true, name = "Špeh", pts = 10,
        hint = "Někteří odvážlivci se vplíží až do hlavního města nepřítele…",
        desc = "Vstoupil(a) jsi do hlavního města nepřátelské frakce." }
    H[#H + 1] = { id = "tamer", tameRare = true, name = "Krotitel vzácností", pts = 10,
        hint = "Jen lovci vědí, jaké to je mít po boku zvíře, které jiní jen loví…",
        desc = "Ochočil(a) sis vzácné zvíře." }
end
