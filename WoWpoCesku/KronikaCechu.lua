-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- Cechovní kronika (TESTOVACÍ VERZE – zatím není v gitu ani na CurseForge).
-- Zapisuje události cechu (přijetí, odchody, povýšení, úrovně 10/20/…/60) z hlášení hry a ze seznamu členů,
-- k tomu bossy a pečetě členů, kteří mají addon (posílají si je přes cechovní kanál). Okno: /czq cech, ukázka: /czq cech ukazka.
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local NUMFONT = "Fonts\\FRIZQT__.TTF"
local CINZEL = "Interface\\AddOns\\WoWpoCesku\\Fonts\\Cinzel.ttf"                 -- nadpisy, záložky, tlačítka (umí česká písmena)
local CINZELDEC = "Interface\\AddOns\\WoWpoCesku\\Fonts\\CinzelDecorative.ttf"    -- název cechu, když Morpheus nestačí
local TEX = "Interface\\AddOns\\WoWpoCesku\\Textures\\"
local PARCHMENT = TEX .. "pergamen.tga"
local ATLAS2 = TEX .. "cech-ikony2.tga"     -- 2. sada (index 101+): vchod do dungeonu, raid, čistý průchod, náhrobek, stopky, skupina, boss, truhla
local ATLAS = TEX .. "cech-ikony.tga"      -- 8 medailonů 64x64: přijetí, odchod, vyhození, povýšení, snížení, úroveň, boss, pečeť
local RIBBON = TEX .. "cech-stuha.tga"
local MEDALS = TEX .. "cech-medaile.tga"   -- 4 medaile: zlatá, stříbrná, bronzová, hnědá
local MASK = "Interface\\CharacterFrame\\TempPortraitAlphaMask"
local WHITE = "Interface\\Buttons\\WHITE8x8"
local PREFIX = "WPCG"
local MAXLOG = 500
local INK = { 0.20, 0.13, 0.07 }
local SEPIA = { 0.32, 0.22, 0.12 }
local RED = { 0.50, 0.12, 0.05 }
local GOLD = { 0.85, 0.62, 0.20 }

local function seen()
    WoWpoCeskuSeen = WoWpoCeskuSeen or {}
    return WoWpoCeskuSeen
end

local function shortName(n)
    if type(n) ~= "string" then return n end
    n = n:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H.-|h(.-)|h", "%1"):gsub("^%[(.-)%]$", "%1")
    return (n:gsub("%-.*$", ""))
end

local function guildKey()
    local ok, name = pcall(GetGuildInfo, "player")
    if not ok or type(name) ~= "string" or name == "" then return nil end
    local okR, realm = pcall(GetRealmName)
    return name .. "-" .. ((okR and type(realm) == "string") and realm or ""), name
end

local function guildData(create)
    local key, name = guildKey()
    if not key then return nil end
    local S = seen()
    S.guild = S.guild or {}
    local g = S.guild[key]
    if not g and create then
        g = { name = name, log = {}, members = {}, baseline = false, created = time() }
        S.guild[key] = g
    end
    return g
end

local frame, refresh
local demo   -- ukázková data pro /czq cech ukazka (neukládají se)

local function addEvent(kind, who, a, b, t)
    local g = guildData(true)
    if not g or not who then return end
    t = t or time()
    for i = #g.log, math.max(1, #g.log - 60), -1 do
        local e = g.log[i]
        if e.k == kind and e.who == who and e.a == a and e.b == b and math.abs((e.t or 0) - t) < 30 then return end
    end
    g.log[#g.log + 1] = { t = t, k = kind, who = who, a = a, b = b }
    while #g.log > MAXLOG do table.remove(g.log, 1) end
    if frame and frame:IsShown() and refresh then refresh() end
end

-------------------------------------------------------------------------------
-- Cechovní pečetě (cíle cechu) a statistiky
-------------------------------------------------------------------------------
-- příznaky jedné výpravy pro pečetě (tempo, noc, víkend, raidy…)
local function runFlags(r)
    local f = {}
    local nb = #(r.bosses or {})
    if not r.raid and nb >= 1 and (r.dur or 0) <= 1200 then f.fast = 1 end
    if #(r.who or {}) >= 5 then f.full = 1 end
    local d = date("*t", r.t or 0)
    if d.hour < 5 then f.night = 1 end
    if d.wday == 1 or d.wday == 7 then f.weekend = 1 end
    if (r.dur or 0) >= 10800 then f.long = 1 end
    if r.raid and nb >= 1 then f.raidBoss = 1 end
    if r.raid and nb >= 1 and (r.nd or 0) == 0 then f.raidIron = 1 end
    if r.raid and nb >= 3 and (r.dur or 0) <= 7200 then f.raidFast = 1 end
    if r.last then f.last = 1 end
    return f
end

local function guildStats(g)
    local s = { runs = 0, clean = 0, bosses = 0, members = 0, n60 = 0, n40 = 0, avg = 0, online = 0, days = 0, hours = 0, deaths = 0,
        raids = 0, records = 0, unique = 0, pseals = 0, fast = 0, full = 0, night = 0, weekend = 0, long = 0,
        raidBoss = 0, raidIron = 0, raidFast = 0, last = 0, streak = 0, weeks = 0, maxdeath = 0 }
    local list = {}
    for _, r in ipairs(g.runs or {}) do list[#list + 1] = r end
    table.sort(list, function(a, b) return (a.t or 0) < (b.t or 0) end)
    local secs, deaths, raids, clean = 0, 0, 0, 0
    local streak, best = 0, 0
    local weeksSet, byPlayer = {}, {}
    for _, r in ipairs(list) do
        secs = secs + (r.dur or 0)
        deaths = deaths + (r.nd or 0)
        if r.raid then raids = raids + 1 end
        if (r.nd or 0) == 0 then
            clean = clean + 1
            streak = streak + 1
            if streak > best then best = streak end
        else
            streak = 0
        end
        for k, v in pairs(runFlags(r)) do s[k] = s[k] + v end
        weeksSet[math.floor(((r.t or 0) - 345600) / 604800)] = true
        for n, d in pairs(r.deaths or {}) do byPlayer[n] = (byPlayer[n] or 0) + d end
    end
    for k, v in pairs(g.cnt or {}) do if s[k] ~= nil then s[k] = math.max(s[k], v) end end
    s.runs = math.max(#list, g.runTotal or 0)
    s.clean = math.max(clean, g.runClean or 0)
    s.hours = math.floor(math.max(secs, g.runSecs or 0) / 3600)
    s.deaths = math.max(deaths, g.deathTotal or 0)
    s.raids = math.max(raids, g.raidTotal or 0)
    s.streak = math.max(best, g.streakBest or 0)
    local ws = {}
    for w in pairs(weeksSet) do ws[#ws + 1] = w end
    table.sort(ws)
    local wbest, wcur = 0, 0
    for i, w in ipairs(ws) do
        if i > 1 and w == ws[i - 1] + 1 then wcur = wcur + 1 else wcur = 1 end
        if wcur > wbest then wbest = wcur end
    end
    s.weeks = math.max(wbest, g.weekBest or 0)
    for n, d in pairs(g.deathBy or {}) do byPlayer[n] = math.max(byPlayer[n] or 0, d) end
    for _, d in pairs(byPlayer) do if d > s.maxdeath then s.maxdeath = d end end
    for _ in pairs(g.records or {}) do s.records = s.records + 1 end
    local seen = {}
    for _, e in ipairs(g.log or {}) do
        if e.k == "boss" then
            s.bosses = s.bosses + 1
            if e.a and not seen[e.a] then seen[e.a] = true; s.unique = s.unique + 1 end
        elseif e.k == "seal" then s.pseals = s.pseals + 1 end
    end
    local lvlSum, lvlN, onl = 0, 0, 0
    for _, m in pairs(g.members or {}) do
        s.members = s.members + 1
        local lv = tonumber(m.lvl)
        if lv then
            lvlSum = lvlSum + lv
            lvlN = lvlN + 1
            if lv >= 60 then s.n60 = s.n60 + 1 end
            if lv >= 40 then s.n40 = s.n40 + 1 end
        end
        if m.online then onl = onl + 1 end
    end
    s.avg = lvlN > 0 and math.floor(lvlSum / lvlN) or 0
    s.online = math.max(g.maxOnline or 0, onl)
    s.days = math.floor((time() - (g.created or time())) / 86400)
    return s
end

-- { id, název, popis, ukazatel, cíl, ikona }
local SEALS = {
    { "v1", "První výprava", "Dokončit první cechovní výpravu", "runs", 1, 101 },
    { "v5", "Pětice výprav", "Dokončit 5 cechovních výprav", "runs", 5, 101 },
    { "v10", "Desítka výprav", "Dokončit 10 cechovních výprav", "runs", 10, 101 },
    { "v25", "Čtvrt stovky", "Dokončit 25 cechovních výprav", "runs", 25, 101 },
    { "v50", "Padesát výprav", "Dokončit 50 cechovních výprav", "runs", 50, 101 },
    { "v100", "Stovka výprav", "Dokončit 100 cechovních výprav", "runs", 100, 101 },
    { "w4", "Měsíc každý týden", "Výprava každý týden 4 týdny po sobě", "weeks", 4, 101 },
    { "we5", "Víkendoví bojovníci", "5 výprav o víkendu", "weekend", 5, 101 },
    { "r1", "První raid", "Dokončit první cechovní raid", "raids", 1, 102 },
    { "r5", "Raidoví veteráni", "Dokončit 5 cechovních raidů", "raids", 5, 102 },
    { "rb", "První boss v raidu", "Porazit bosse v cechovním raidu", "raidBoss", 1, 102 },
    { "ri", "Raid bez úmrtí", "Raid s poraženým bossem a bez jediného úmrtí", "raidIron", 1, 102 },
    { "rf", "Rychlý raid", "Raid se 3 bossy do 2 hodin", "raidFast", 1, 102 },
    { "c1", "Čistá práce", "Výprava bez jediného úmrtí", "clean", 1, 103 },
    { "c5", "Bez škrábnutí", "5 výprav bez jediného úmrtí", "clean", 5, 103 },
    { "c20", "Nezranitelní", "20 výprav bez jediného úmrtí", "clean", 20, 103 },
    { "s3", "Trojitá čistota", "3 výpravy po sobě bez úmrtí", "streak", 3, 103 },
    { "s5", "Pětice čistých", "5 výprav po sobě bez úmrtí", "streak", 5, 103 },
    { "s10", "Neporazitelní", "10 výprav po sobě bez úmrtí", "streak", 10, 103 },
    { "b10", "Začínající lovci", "Porazit 10 bossů", "bosses", 10, 107 },
    { "b25", "Lovci bossů", "Porazit 25 bossů", "bosses", 25, 107 },
    { "b100", "Páni bossů", "Porazit 100 bossů", "bosses", 100, 107 },
    { "b250", "Postrach Azerothu", "Porazit 250 bossů", "bosses", 250, 107 },
    { "u10", "Sběratelé bossů", "Porazit 10 různých bossů", "unique", 10, 107 },
    { "u30", "Encyklopedie bossů", "Porazit 30 různých bossů", "unique", 30, 107 },
    { "f1", "Bleskovka", "Dungeon dokončit pod 20 minut", "fast", 1, 105 },
    { "f5", "Rychlé tempo", "5 dungeonů pod 20 minut", "fast", 5, 105 },
    { "n1", "Noční směna", "Výprava mezi půlnocí a pátou ránem", "night", 1, 105 },
    { "l1h", "Nejdelší noc", "Výprava delší než 3 hodiny", "long", 1, 105 },
    { "h5", "Pět hodin pod zemí", "Strávit ve výpravách 5 hodin", "hours", 5, 105 },
    { "h24", "Celý den v podzemí", "Strávit ve výpravách 24 hodin", "hours", 24, 105 },
    { "h100", "Sto hodin dobrodružství", "Strávit ve výpravách 100 hodin", "hours", 100, 105 },
    { "k3", "Rekordmani", "Mít rekord ve 3 různých instancích", "records", 3, 105 },
    { "k10", "Králové času", "Mít rekord v 10 různých instancích", "records", 10, 105 },
    { "p1", "Plná skupina", "Výprava s 5 členy cechu", "full", 1, 106 },
    { "p10", "Věrná pětka", "10 výprav s 5 členy cechu", "full", 10, 106 },
    { "z1", "Poslední zhasne", "Přežít jako jediný, když ostatní padli", "last", 1, 104 },
    { "d50", "Věrní hrobaři", "Dohromady 50 úmrtí ve výpravách", "deaths", 50, 104 },
    { "d200", "Hřbitovní stálice", "Dohromady 200 úmrtí ve výpravách", "deaths", 200, 104 },
    { "g20", "Hrobník roku", "Jeden hráč dosáhl 20 úmrtí ve výpravách", "maxdeath", 20, 104 },
    { "g50", "Věčný hrobník", "Jeden hráč dosáhl 50 úmrtí ve výpravách", "maxdeath", 50, 104 },
    { "l1", "První šedesátka", "První člen na úrovni 60", "n60", 1, 6 },
    { "l3", "Veteráni", "3 členové na úrovni 60", "n60", 3, 6 },
    { "l5", "Pětka šedesátek", "5 členů na úrovni 60", "n60", 5, 6 },
    { "l10", "Elita Azerothu", "10 členů na úrovni 60", "n60", 10, 6 },
    { "l20", "Dvacet šedesátek", "20 členů na úrovni 60", "n60", 20, 6 },
    { "q1", "První čtyřicítka", "První člen na úrovni 40", "n40", 1, 6 },
    { "q5", "Pět čtyřicítek", "5 členů na úrovni 40 a výš", "n40", 5, 6 },
    { "a30", "Průměr 30", "Průměrná úroveň cechu 30", "avg", 30, 6 },
    { "a50", "Průměr 50", "Průměrná úroveň cechu 50", "avg", 50, 6 },
    { "s10p", "Sběratelé pečetí", "Členové získali dohromady 10 pečetí kronikáře", "pseals", 10, 8 },
    { "m5", "Parta", "5 členů v cechu", "members", 5, 1 },
    { "m10", "Rostoucí cech", "10 členů v cechu", "members", 10, 1 },
    { "m25", "Silný cech", "25 členů v cechu", "members", 25, 1 },
    { "m50", "Velký cech", "50 členů v cechu", "members", 50, 1 },
    { "o5", "Dobrá parta", "5 členů online najednou", "online", 5, 1 },
    { "o10", "Plný sál", "10 členů online najednou", "online", 10, 1 },
    { "t7", "Týden v kronice", "7 dní v kronice", "days", 7, 105 },
    { "t30", "Měsíc pospolu", "30 dní v kronice", "days", 30, 105 },
    { "t100", "Sto dní", "100 dní v kronice", "days", 100, 105 },
    { "t180", "Půl roku", "Půl roku v kronice", "days", 180, 105 },
    { "t365", "Rok pospolu", "Rok v kronice", "days", 365, 105 },
}

local function sealStatus(g)
    local s, out, now = guildStats(g), {}, time()
    for _, d in ipairs(SEALS) do
        local val = s[d[4]] or 0
        local done = val >= d[5]
        out[#out + 1] = { id = d[1], name = d[2], desc = d[3], val = math.min(val, d[5]), goal = d[5], done = done, icon = d[6],
            t = done and ((g.seals and g.seals[d[1]]) or now) or nil }
    end
    return out
end

-- zapíše nově splněné pečetě (a hlášku do letopisu)
local function checkSeals(g)
    if not g then return end
    g.seals = g.seals or {}
    local now = time()
    for _, st in ipairs(sealStatus(g)) do
        if st.done and not g.seals[st.id] then
            g.seals[st.id] = now
            if g.baseline then addEvent("gseal", st.name, st.id, nil, now) end
        end
    end
end

-------------------------------------------------------------------------------
-- Hlášení hry o dění v cechu (texty se berou z jazyka klienta)
-------------------------------------------------------------------------------
local function toPattern(fmt)
    if type(fmt) ~= "string" then return nil end
    local p = fmt:gsub("%%%d?%$?s", "\1")
    p = p:gsub("([%^%$%(%)%.%[%]%*%+%-%?%%])", "%%%1")
    p = p:gsub("\1", "(.+)")
    return "^" .. p .. "$"
end

local rules
local function buildRules()
    rules = {}
    for _, d in ipairs({
        { "ERR_GUILD_JOIN_S", "join" }, { "ERR_GUILD_LEAVE_S", "leave" }, { "ERR_GUILD_REMOVE_SS", "kick" },
        { "ERR_GUILD_PROMOTE_SSS", "promote" }, { "ERR_GUILD_DEMOTE_SSS", "demote" },
    }) do
        local p = toPattern(_G[d[1]])
        if p then rules[#rules + 1] = { p, d[2] } end
    end
end

local function onSystem(msg)
    if type(msg) ~= "string" or not guildKey() then return end
    if not rules then buildRules() end
    local clean = msg:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H.-|h(.-)|h", "%1")
    for _, r in ipairs(rules) do
        local a, b, c = clean:match(r[1])
        if a then
            local g = guildData(true)
            if r[2] == "join" then
                local n = shortName(a)
                if g and not g.members[n] then g.members[n] = { since = time() } end
                addEvent("join", n)
            elseif r[2] == "leave" then
                local n = shortName(a)
                if g then g.members[n] = nil end
                addEvent("leave", n)
            elseif r[2] == "kick" then
                local n = shortName(a)
                if g then g.members[n] = nil end
                addEvent("kick", n, shortName(b))
            elseif r[2] == "promote" then
                addEvent("promote", shortName(b), c, shortName(a))
            elseif r[2] == "demote" then
                addEvent("demote", shortName(b), c, shortName(a))
            end
            return
        end
    end
end

-------------------------------------------------------------------------------
-- Seznam členů: sledování úrovní (10/20/…/60) a změn mezi přihlášeními
-------------------------------------------------------------------------------
local function requestRoster()
    if C_GuildInfo and C_GuildInfo.GuildRoster then pcall(C_GuildInfo.GuildRoster)
    elseif GuildRoster then pcall(GuildRoster) end
end

local lastSnap = 0
local function snapshot()
    if GetTime() - lastSnap < 5 then return end
    lastSnap = GetTime()
    local g = guildData(true)
    if not g or not GetNumGuildMembers or not GetGuildRosterInfo then return end
    local total = GetNumGuildMembers()
    if not total or total == 0 then return end
    local present, count, t, onl = {}, 0, time(), 0
    for i = 1, total do
        local full, rank, rankIdx, level, class, _, _, _, online, _, cf = GetGuildRosterInfo(i)
        if full then
            count = count + 1
            if online then onl = onl + 1 end
            local name = shortName(full)
            present[name] = true
            local m = g.members[name]
            if not m then
                g.members[name] = { lvl = level, class = class, cf = cf, rank = rank, ri = rankIdx, online = online, since = g.baseline and t or nil }
                if g.baseline then addEvent("join", name, nil, nil, t) end
            else
                if level and m.lvl and level > m.lvl then
                    for L = m.lvl + 1, level do
                        if L % 10 == 0 then addEvent("level", name, L) end
                    end
                end
                m.lvl, m.class, m.cf, m.rank, m.ri, m.online = level or m.lvl, class or m.class, cf or m.cf, rank or m.rank, rankIdx or m.ri, online
            end
        end
    end
    -- odchody se hlásí jen při úplném seznamu (když jsou vidět i offline členové)
    if g.baseline and count >= total then
        for name in pairs(g.members) do
            if not present[name] then
                g.members[name] = nil
                addEvent("leave", name)
            end
        end
    end
    if onl > (g.maxOnline or 0) then g.maxOnline = onl end
    pcall(checkSeals, g)
    g.baseline = true
    if frame and frame:IsShown() and refresh then refresh() end
end

-------------------------------------------------------------------------------
-- Vlastní události (bossové, pečetě) + výměna mezi členy s addonem
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Výpravy: cechovní dungeon nebo raid (doba, úmrtí, bossové, účastníci)
-- Výprava se zapíše, když je ve skupině aspoň 3 členové cechu a aspoň 60 % skupiny. Čas se měří od vstupu do instance,
-- úmrtí se počítají sledováním členů skupiny, bossové z vlastního Bestiáře. Když se skupina do 10 minut vrátí do stejné
-- instance, jde o tutéž výpravu (konec spojení, wipe).
-------------------------------------------------------------------------------
local MIN_GUILD, MIN_SHARE, RESUME_SECS = 3, 0.6, 600
local runCur
local deadState = {}

local function isSecret(v)
    return issecretvalue ~= nil and issecretvalue(v) == true
end

local function groupUnits()
    local units = {}
    local n = GetNumGroupMembers and GetNumGroupMembers() or 0
    if n > 0 and IsInRaid and IsInRaid() then
        for i = 1, n do units[#units + 1] = "raid" .. i end
    else
        units[1] = "player"
        for i = 1, math.max(0, n - 1) do units[#units + 1] = "party" .. i end
    end
    return units
end

local function unitName(u)
    local ok, name = pcall(UnitName, u)
    if ok and type(name) == "string" and not isSecret(name) then return shortName(name) end
end

-- kdo je ve skupině a kolik z nich je z cechu
local function scanGroup()
    if not runCur then return end
    local total, mine, seenN = 0, 0, {}
    for _, u in ipairs(groupUnits()) do
        local okE, exists = pcall(UnitExists, u)
        if okE and exists == true then
            local name = unitName(u)
            if name and not seenN[name] then
                seenN[name] = true
                total = total + 1
                local inGuild = (u == "player")
                if not inGuild and UnitIsInMyGuild then
                    local okG, v = pcall(UnitIsInMyGuild, u)
                    inGuild = okG and not isSecret(v) and v == true
                end
                if inGuild then
                    mine = mine + 1
                    runCur.who[name] = true
                end
            end
        end
    end
    runCur.total, runCur.mine = total, mine
end

-- úmrtí: přechod živý -> mrtvý u členů cechu ve skupině
local function pollDeaths()
    if not runCur then return end
    local nDead, nAlive, lastAlive = 0, 0, nil
    for _, u in ipairs(groupUnits()) do
        local name = unitName(u)
        if name and runCur.who[name] then
            local okD, dead = pcall(UnitIsDeadOrGhost, u)
            if okD and not isSecret(dead) then
                if dead == true and not deadState[name] then
                    runCur.deaths[name] = (runCur.deaths[name] or 0) + 1
                end
                deadState[name] = (dead == true)
                if dead == true then nDead = nDead + 1 else nAlive = nAlive + 1; lastAlive = name end
            end
        end
    end
    if nAlive == 1 and nDead >= 2 and lastAlive and not runCur.last then runCur.last = lastAlive end
end

local pollFrame = CreateFrame("Frame")
local acc = 0
pollFrame:SetScript("OnUpdate", function(_, dt)
    if not runCur then return end
    acc = acc + dt
    if acc < 0.5 then return end
    acc = 0
    pcall(pollDeaths)
end)

local function qualifies(r)
    local total = math.max(1, r.total or 0)
    return (r.mine or 0) >= MIN_GUILD and (r.mine / total) >= MIN_SHARE
        and (#(r.bosses or {}) >= 1 or ((r.stop or 0) - (r.start or 0)) >= 600)
end

-- uloží hotovou výpravu do kroniky
local function commitRun(cur)
    local g = guildData(true)
    if not g or not cur or not qualifies(cur) then return end
    local names, nd = {}, 0
    for n in pairs(cur.who) do names[#names + 1] = n end
    table.sort(names)
    for _, d in pairs(cur.deaths) do nd = nd + d end
    local run = { t = cur.start, dur = cur.stop - cur.start, name = cur.name, who = names, deaths = cur.deaths, nd = nd,
        bosses = cur.bosses, total = cur.total, raid = cur.raid, last = cur.last }
    g.records = g.records or {}
    local rec = g.records[cur.name]
    if #cur.bosses >= 1 then
        if not rec then
            g.records[cur.name] = { dur = run.dur, t = run.t }
        elseif run.dur < rec.dur then
            run.record = true
            g.records[cur.name] = { dur = run.dur, t = run.t }
        end
    end
    g.runs = g.runs or {}
    g.runs[#g.runs + 1] = run
    while #g.runs > 100 do table.remove(g.runs, 1) end
    g.runTotal = (g.runTotal or 0) + 1
    g.runSecs = (g.runSecs or 0) + (run.dur or 0)
    g.deathTotal = (g.deathTotal or 0) + nd
    if cur.raid then g.raidTotal = (g.raidTotal or 0) + 1 end
    if nd == 0 then g.runClean = (g.runClean or 0) + 1 end
    g.cnt = g.cnt or {}
    for k in pairs(runFlags(run)) do g.cnt[k] = (g.cnt[k] or 0) + 1 end
    g.deathBy = g.deathBy or {}
    for n, d in pairs(cur.deaths) do g.deathBy[n] = (g.deathBy[n] or 0) + d end
    local st = guildStats(g)
    g.streakBest, g.weekBest = st.streak, st.weeks
    addEvent("run", cur.name, run.dur, nd, run.t)
    pcall(checkSeals, g)
end

-- čekající výprava (po odchodu z instance se 10 minut čeká, jestli se skupina nevrátí)
local function commitStale(force)
    local g = guildData(false)
    if not g or not g.pending then return end
    if force or time() - (g.pending.stop or 0) >= RESUME_SECS then
        local cur = g.pending
        g.pending = nil
        pcall(commitRun, cur)
    end
end

local function startRun(name, raid)
    if runCur then return end
    local g = guildData(true)
    if not g then return end
    if g.pending and g.pending.name == name and time() - (g.pending.stop or 0) < RESUME_SECS then
        runCur = g.pending
        g.pending = nil
        runCur.stop = nil
    else
        commitStale(true)
        runCur = { name = name, raid = raid or nil, start = time(), bosses = {}, deaths = {}, who = {}, total = 0, mine = 0 }
    end
    wipe(deadState)
    scanGroup()
end

local function endRun()
    if not runCur then return end
    local cur = runCur
    runCur = nil
    cur.stop = time()
    local g = guildData(false)
    if not g then return end
    if qualifies(cur) then
        g.pending = cur
        C_Timer.After(RESUME_SECS + 5, function() commitStale(false) end)
    end
end

local function onWorld()
    if not guildKey() then return end
    local ok, inInst, itype = pcall(IsInInstance)
    if ok and inInst and (itype == "party" or itype == "raid") then
        local okI, name = pcall(GetInstanceInfo)
        if okI and type(name) == "string" and not isSecret(name) then startRun(name, itype == "raid") end
    else
        endRun()
    end
    commitStale(false)
end

-- boss poražený ve výpravě (z Bestiáře)
local function runBoss(name)
    if not runCur or not name then return end
    scanGroup()
    runCur.bosses[#runCur.bosses + 1] = { name, time() }
end

local function send(kind, a, b)
    if not (IsInGuild and IsInGuild() and C_ChatInfo and C_ChatInfo.SendAddonMessage) then return end
    local msg = table.concat({ kind, a or "", b or "" }, "\t")
    pcall(C_ChatInfo.SendAddonMessage, PREFIX, msg:sub(1, 240), "GUILD")
end

-- členové cechu v mé skupině (i bez addonu)
local function guildMatesInGroup(me)
    local out = {}
    for _, u in ipairs(groupUnits()) do
        local name = unitName(u)
        if name and name ~= me and UnitIsInMyGuild then
            local okG, v = pcall(UnitIsInMyGuild, u)
            if okG and not isSecret(v) and v == true then out[#out + 1] = name end
        end
    end
    return out
end

function WoWpoCesku_GuildFeed(kind, a, b)
    if kind ~= "boss" and kind ~= "seal" then return end
    if not guildKey() then return end
    local ok, me = pcall(UnitName, "player")
    if not ok or type(me) ~= "string" then return end
    addEvent(kind, me, a, b)
    if kind == "boss" then
        pcall(runBoss, a)
        -- bossové se zapíšou všem členům cechu ve skupině, i když nemají addon (jejich vlastní zpráva se dubluje a zahodí)
        local okM, mates = pcall(guildMatesInGroup, me)
        if okM then for _, name in ipairs(mates) do addEvent("boss", name, a, b) end end
        pcall(checkSeals, guildData(false))
    end
    send(kind, a, b)
end

local function onAddon(prefix, text, channel, sender)
    if prefix ~= PREFIX or channel ~= "GUILD" or type(text) ~= "string" then return end
    local who = shortName(sender)
    local ok, me = pcall(UnitName, "player")
    if ok and who == me then return end
    local k, a, b = strsplit("\t", text)
    if k ~= "boss" and k ~= "seal" then return end
    addEvent(k, who, (a and a ~= "") and a or nil, (b and b ~= "") and b or nil)
    if k == "boss" then pcall(checkSeals, guildData(false)) end
end

-------------------------------------------------------------------------------
-- Pomocné funkce pro vzhled
-------------------------------------------------------------------------------
local MONTHS = { "ledna", "února", "března", "dubna", "května", "června", "července", "srpna", "září", "října", "listopadu", "prosince" }
local function longDate(t)
    local d = date("*t", t or 0)
    return ("%d. %s %d"):format(d.day, MONTHS[d.month] or "?", d.year)
end
local function dayLabel(t)
    local now = date("*t", time())
    local d = date("*t", t or 0)
    local label = longDate(t)
    if d.year == now.year and d.yday == now.yday then return "Dnes  ·  " .. label end
    local y = date("*t", time() - 86400)
    if d.year == y.year and d.yday == y.yday then return "Včera  ·  " .. label end
    return label
end

local function fmtDur(secs)
    secs = math.max(0, math.floor(secs or 0))
    if secs >= 3600 then return ("%d h %02d min"):format(math.floor(secs / 3600), math.floor(secs % 3600 / 60)) end
    return ("%d min %02d s"):format(math.floor(secs / 60), secs % 60)
end

local KIND = {
    run = { icon = 101, label = "Výprava", accent = { 0.44, 0.15, 0.17 } },
    join = { icon = 1, label = "Přijetí", accent = { 0.27, 0.59, 0.31 } },
    leave = { icon = 2, label = "Odchod", accent = { 0.54, 0.46, 0.38 } },
    kick = { icon = 3, label = "Vyhazov", accent = { 0.69, 0.17, 0.16 } },
    promote = { icon = 4, label = "Povýšení", accent = { 0.26, 0.44, 0.75 } },
    demote = { icon = 5, label = "Snížení", accent = { 0.77, 0.44, 0.17 } },
    level = { icon = 6, label = "Úroveň", accent = { 0.81, 0.63, 0.17 } },
    boss = { icon = 107, label = "Boss", accent = { 0.44, 0.15, 0.17 } },
    seal = { icon = 8, label = "Pečeť", accent = { 0.62, 0.12, 0.12 } },
    gseal = { icon = 108, label = "Pečeť cechu", accent = { 0.85, 0.62, 0.20 } },
}

local function setIcon(tex, idx)
    tex:SetTexture(idx > 100 and ATLAS2 or ATLAS)
    if idx > 100 then idx = idx - 100 end
    local col, row = (idx - 1) % 4, math.floor((idx - 1) / 4)
    tex:SetTexCoord(col / 4, (col + 1) / 4, row / 2, (row + 1) / 2)
end
local function setMedal(tex, idx)
    tex:SetTexture(MEDALS)
    tex:SetTexCoord((idx - 1) / 4, idx / 4, 0, 1)
end

-- barva třídy ztmavená, aby byla čitelná na pergamenu
local function classHex(cf)
    local c = cf and RAID_CLASS_COLORS and RAID_CLASS_COLORS[cf]
    if not c then return "3a2812", 0.23, 0.16, 0.07 end
    local r, g, b = c.r * 0.62, c.g * 0.62, c.b * 0.62
    local lum = 0.3 * r + 0.59 * g + 0.11 * b
    if lum > 0.30 then local k = 0.30 / lum; r, g, b = r * k, g * k, b * k end
    return ("%02x%02x%02x"):format(math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)), r, g, b
end

local function nameText(g, who)
    local m = g.members and g.members[who]
    local hex = classHex(m and m.cf)
    return "|cff" .. hex .. who .. "|r"
end

local function eventLine(g, e)
    local n = nameText(g, e.who or "?")
    local k = e.k
    if k == "join" then return ("Nový člen cechu: %s"):format(n)
    elseif k == "leave" then return ("Odchod z cechu: %s"):format(n)
    elseif k == "kick" then return ("%s byl vyhozen z cechu (%s)"):format(n, e.a or "?")
    elseif k == "promote" then return ("%s povýšen na hodnost |cff801f0d%s|r"):format(n, e.a or "?")
    elseif k == "demote" then return ("%s snížen na hodnost |cff801f0d%s|r"):format(n, e.a or "?")
    elseif k == "level" then return ("%s dosáhl úrovně |cff801f0d%s|r"):format(n, tostring(e.a))
    elseif k == "boss" then return ("%s porazil bosse |cff801f0d%s|r%s"):format(n, e.a or "?", e.b and ("  |cff6b4d2e(" .. e.b .. ")|r") or "")
    elseif k == "seal" then return ("%s získal pečeť |cff801f0d%s|r"):format(n, e.a or "?")
    elseif k == "gseal" then return ("Cech získal pečeť: |cff801f0d%s|r"):format(e.who or "?")
    elseif k == "run" then return ("Cechovní výprava: |cff801f0d%s|r  |cff6b4d2e(%s, úmrtí: %s)|r"):format(e.who or "?", fmtDur(e.a), tostring(e.b or 0))
    end
end

local function eventPlain(e)
    local k = e.k
    if k == "join" then return ("Nový člen cechu: %s"):format(e.who)
    elseif k == "leave" then return ("Odchod z cechu: %s"):format(e.who)
    elseif k == "kick" then return ("%s byl vyhozen z cechu (%s)"):format(e.who, e.a or "?")
    elseif k == "promote" then return ("%s povýšen na hodnost %s"):format(e.who, e.a or "?")
    elseif k == "demote" then return ("%s snížen na hodnost %s"):format(e.who, e.a or "?")
    elseif k == "level" then return ("%s dosáhl úrovně %s"):format(e.who, tostring(e.a))
    elseif k == "boss" then return ("%s porazil bosse %s%s"):format(e.who, e.a or "?", e.b and (" (" .. e.b .. ")") or "")
    elseif k == "seal" then return ("%s získal pečeť %s"):format(e.who, e.a or "?")
    elseif k == "gseal" then return ("Cech získal pečeť: %s"):format(e.who or "?")
    elseif k == "run" then return ("Cechovní výprava: %s (%s, úmrtí: %s)"):format(e.who or "?", fmtDur(e.a), tostring(e.b or 0))
    end
end

-- prostý text letopisu pro zkopírování
local function plainLetopis(g)
    local lines = { "LETOPIS CECHU " .. (g.name or "") }
    local day
    for i = #(g.log or {}), 1, -1 do
        local e = g.log[i]
        local text = eventPlain(e)
        if text then
            local d = longDate(e.t)
            if d ~= day then day = d; lines[#lines + 1] = ""; lines[#lines + 1] = d end
            lines[#lines + 1] = "  • " .. text
        end
    end
    return table.concat(lines, "\n")
end

-------------------------------------------------------------------------------
-- Ukázková data pro testování vzhledu bez cechu
-------------------------------------------------------------------------------
local function demoData()
    local now = time()
    local D = 86400
    local g = { name = "Strážci Azerothu", members = {}, log = {}, created = now - 30 * D }
    local roster = {
        { "Rankon", "Warrior", "WARRIOR", 60, 0, "Guild Master" }, { "Thorgrim", "Paladin", "PALADIN", 58, 1, "Důstojník" },
        { "Elaria", "Priest", "PRIEST", 52, 1, "Důstojník" }, { "Murgash", "Shaman", "SHAMAN", 60, 2, "Člen" },
        { "Selene", "Mage", "MAGE", 47, 2, "Člen" }, { "Bronn", "Hunter", "HUNTER", 44, 2, "Člen" },
        { "Zuldar", "Warlock", "WARLOCK", 38, 3, "Nováček" }, { "Mirabel", "Druid", "DRUID", 29, 3, "Nováček" }, { "Vex", "Rogue", "ROGUE", 21, 3, "Nováček" },
    }
    for i, r in ipairs(roster) do
        g.members[r[1]] = { class = r[2], cf = r[3], lvl = r[4], ri = r[5], rank = r[6], since = now - (30 - i * 3) * D, online = (i % 3 ~= 0) }
    end
    local L = g.log
    local function add(dt, hh, k, who, a, b) L[#L + 1] = { t = now - dt * D - hh * 3600, k = k, who = who, a = a, b = b } end
    add(14, 2, "join", "Elaria"); add(12, 5, "level", "Thorgrim", 50); add(11, 1, "boss", "Rankon", "Oggleflint", "Ragefire Chasm")
    add(9, 4, "seal", "Selene", "Čtenář kroniky"); add(8, 3, "level", "Murgash", 60); add(6, 6, "promote", "Bronn", "Důstojník", "Rankon")
    add(5, 2, "boss", "Rankon", "Taragaman the Hungerer", "Ragefire Chasm"); add(5, 0, "boss", "Thorgrim", "Bazzalan", "Ragefire Chasm")
    add(3, 7, "leave", "Dragan"); add(2, 2, "join", "Mirabel"); add(1, 3, "level", "Rankon", 60)
    add(1, 1, "seal", "Rankon", "Vládce Ragefire"); add(0, 4, "kick", "Brutus", "Rankon"); add(0, 1, "level", "Elaria", 50)
    -- ukázkové výpravy
    local function run(dt, name, dur, who, deaths, bosses, record)
        local nd = 0
        for _, d in pairs(deaths) do nd = nd + d end
        local bs = {}
        for i, b in ipairs(bosses) do bs[i] = { b, now - dt * D } end
        g.runs[#g.runs + 1] = { t = now - dt * D - dur, dur = dur, name = name, who = who, deaths = deaths, nd = nd, bosses = bs, record = record }
    end
    g.runs = {}
    run(12, "Ragefire Chasm", 1620, { "Elaria", "Murgash", "Rankon", "Thorgrim", "Zuldar" }, { Zuldar = 3, Elaria = 1 }, { "Oggleflint", "Taragaman the Hungerer" })
    run(8, "The Deadmines", 2490, { "Bronn", "Elaria", "Rankon", "Selene", "Thorgrim" }, { Bronn = 2 }, { "Rhahk'Zor", "Sneed", "Gilnid", "Mr. Smite", "Edwin VanCleef" })
    run(3, "Ragefire Chasm", 1172, { "Elaria", "Murgash", "Rankon", "Thorgrim", "Selene" }, {}, { "Oggleflint", "Bazzalan", "Taragaman the Hungerer", "Jergosh the Invoker" }, true)
    run(0, "Ragefire Chasm", 1259, { "Elaria", "Murgash", "Rankon", "Thorgrim" }, {}, { "Oggleflint" })
    g.records = { ["Ragefire Chasm"] = { dur = 1172 }, ["The Deadmines"] = { dur = 2490 } }
    return g
end

-------------------------------------------------------------------------------
-- Okno
-------------------------------------------------------------------------------
local tab = "letopis"
local tabs = { { "letopis", "Letopis" }, { "vypravy", "Výpravy" }, { "sin", "Síň slávy" }, { "clenove", "Členové" } }
local content, scroll
local pools = {}
local BOX = { bgFile = WHITE, edgeFile = WHITE, edgeSize = 1 }
local CONTENT_W = 672

local function resetPools()
    for _, p in pairs(pools) do
        for i = 1, #p.items do p.items[i]:Hide() end
        p.n = 0
    end
end

local function get(name, create)
    local p = pools[name]
    if not p then p = { items = {}, n = 0 }; pools[name] = p end
    p.n = p.n + 1
    local w = p.items[p.n]
    if not w then w = create(); p.items[p.n] = w end
    w:Show()
    return w
end

local function fs(parent, size, r, g, b, flags)
    local t = parent:CreateFontString(nil, "OVERLAY")
    t:SetFont(FONT, size, flags or "")
    t:SetTextColor(r or INK[1], g or INK[2], b or INK[3])
    t:SetJustifyH("LEFT")
    return t
end

local function card(parent)
    local c = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    c:SetBackdrop(BOX)
    c:SetBackdropColor(0.42, 0.27, 0.12, 0.13)
    c:SetBackdropBorderColor(0.42, 0.27, 0.13, 0.55)
    return c
end

local function gradient(tex, r, g, b, a1, a2, orient)
    tex:SetColorTexture(r, g, b, math.max(a1, a2))
    if tex.SetGradient and CreateColor then
        if pcall(tex.SetGradient, tex, orient or "HORIZONTAL", CreateColor(r, g, b, a1), CreateColor(r, g, b, a2)) then return end
    end
    if tex.SetGradientAlpha then pcall(tex.SetGradientAlpha, tex, orient or "HORIZONTAL", r, g, b, a1, r, g, b, a2) end
end

local function ornamentLine(parent, width)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(width, 12)
    local d = f:CreateTexture(nil, "ARTWORK")
    d:SetColorTexture(RED[1], RED[2], RED[3], 0.85)
    d:SetSize(7, 7)
    d:SetPoint("CENTER")
    d:SetRotation(math.rad(45))
    for _, side in ipairs({ -1, 1 }) do   -- linky se roztáhnou podle šířky rámečku
        local l = f:CreateTexture(nil, "ARTWORK")
        l:SetColorTexture(SEPIA[1], SEPIA[2], SEPIA[3], 0.7)
        l:SetHeight(1)
        if side < 0 then
            l:SetPoint("LEFT", f, "LEFT", 0, 0)
            l:SetPoint("RIGHT", d, "CENTER", -10, 0)
        else
            l:SetPoint("LEFT", d, "CENTER", 10, 0)
            l:SetPoint("RIGHT", f, "RIGHT", 0, 0)
        end
    end
    return f
end

-- záhlaví dne v letopisu: linka – kosočtverec – datum
local function dateHeader(text)
    local h = get("dh", function()
        local f = CreateFrame("Frame", nil, content)
        f:SetSize(CONTENT_W, 30)
        f.text = fs(f, 14, RED[1], RED[2], RED[3])
        f.text:SetPoint("LEFT", 14, 0)
        f.line = f:CreateTexture(nil, "ARTWORK")
        f.line:SetHeight(1)
        f.line:SetPoint("LEFT", f.text, "RIGHT", 10, 0)
        f.line:SetPoint("RIGHT", f, "RIGHT", -6, 0)
        gradient(f.line, SEPIA[1], SEPIA[2], SEPIA[3], 0.8, 0.0)
        f.dot = f:CreateTexture(nil, "ARTWORK")
        f.dot:SetColorTexture(RED[1], RED[2], RED[3], 0.9)
        f.dot:SetSize(7, 7)
        f.dot:SetRotation(math.rad(45))
        f.dot:SetPoint("LEFT", 2, 0)
        return f
    end)
    h.text:SetText(text)
    return h
end

local function eventRow(g, e)
    local r = get("ev", function()
        local c = card(content)
        c:SetSize(CONTENT_W - 12, 44)
        c.accent = c:CreateTexture(nil, "ARTWORK")
        c.accent:SetPoint("TOPLEFT", 1, -1)
        c.accent:SetPoint("BOTTOMLEFT", 1, 1)
        c.accent:SetWidth(4)
        c.icon = c:CreateTexture(nil, "ARTWORK")
        c.icon:SetSize(40, 40)
        c.icon:SetPoint("LEFT", 10, 0)
        c.text = fs(c, 13)
        c.text:SetPoint("TOPLEFT", 58, -8)
        c.text:SetWidth(CONTENT_W - 12 - 58 - 16)
        c.text:SetWordWrap(false)
        c.sub = fs(c, 10.5, SEPIA[1], SEPIA[2], SEPIA[3])
        c.sub:SetPoint("TOPLEFT", c.text, "BOTTOMLEFT", 0, -3)
        c.hl = c:CreateTexture(nil, "ARTWORK", nil, 2)
        c.hl:SetAllPoints()
        c.hl:SetColorTexture(1, 0.92, 0.7, 0.14)
        c.hl:Hide()
        c:EnableMouse(true)
        c:SetScript("OnEnter", function(self) self.hl:Show() end)
        c:SetScript("OnLeave", function(self) self.hl:Hide() end)
        return c
    end)
    local k = KIND[e.k] or KIND.join
    r.accent:SetColorTexture(k.accent[1], k.accent[2], k.accent[3], 0.95)
    setIcon(r.icon, k.icon)
    r.text:SetText(eventLine(g, e) or "")
    r.sub:SetText(k.label .. "  ·  " .. date("%H:%M", e.t or 0))
    return r
end

local function tile(x, y, w, number, caption)
    local t = get("tile", function()
        local c = card(content)
        c.num = c:CreateFontString(nil, "OVERLAY")
        c.num:SetFont(NUMFONT, 28, "")
        c.num:SetTextColor(RED[1], RED[2], RED[3])
        c.num:SetPoint("TOP", 0, -10)
        c.cap = fs(c, 11, SEPIA[1], SEPIA[2], SEPIA[3])
        c.cap:SetJustifyH("CENTER")
        c.cap:SetPoint("BOTTOM", 0, 9)
        c.shine = c:CreateTexture(nil, "BACKGROUND")
        c.shine:SetPoint("TOPLEFT", 1, -1)
        c.shine:SetPoint("TOPRIGHT", -1, -1)
        c.shine:SetHeight(26)
        gradient(c.shine, 1, 0.9, 0.6, 0.20, 0.0, "VERTICAL")
        return c
    end)
    t:SetSize(w, 72)
    t:ClearAllPoints()
    t:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
    t.num:SetText(number)
    t.cap:SetText(caption)
    return t
end

-- žebříček: karta s hlavičkou a pěti řádky (medaile, jméno, hodnota)
local function board(g, x, y, w, iconIdx, title, rows, emptyText)
    local b = get("board", function()
        local c = card(content)
        c.icon = c:CreateTexture(nil, "ARTWORK")
        c.icon:SetSize(30, 30)
        c.icon:SetPoint("TOPLEFT", 10, -10)
        c.title = fs(c, 13, RED[1], RED[2], RED[3])
        c.title:SetPoint("LEFT", c.icon, "RIGHT", 8, 0)
        c.orn = ornamentLine(c, 100)
        c.rows = {}
        for i = 1, 5 do
            local row = {}
            row.medal = c:CreateTexture(nil, "ARTWORK")
            row.medal:SetSize(26, 26)
            row.num = c:CreateFontString(nil, "OVERLAY")
            row.num:SetFont(NUMFONT, 12, "OUTLINE")
            row.num:SetTextColor(1, 1, 1)
            row.num:SetPoint("CENTER", row.medal, "CENTER", 0, 0)
            row.name = fs(c, 13)
            row.name:SetPoint("LEFT", row.medal, "RIGHT", 8, 0)
            row.name:SetWidth(100)
            row.name:SetWordWrap(false)
            row.val = fs(c, 12, RED[1], RED[2], RED[3])
            row.val:SetJustifyH("RIGHT")
            c.rows[i] = row
        end
        c.empty = fs(c, 12, SEPIA[1], SEPIA[2], SEPIA[3])
        c.empty:SetJustifyH("CENTER")
        c.empty:SetWidth(w - 24)
        return c
    end)
    b:SetSize(w, 234)
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
    setIcon(b.icon, iconIdx)
    b.title:SetText(title)
    b.orn:ClearAllPoints()
    b.orn:SetWidth(w - 28)
    b.orn:SetPoint("TOP", b, "TOP", 0, -50)
    b.empty:SetShown(#rows == 0)
    b.empty:ClearAllPoints()
    b.empty:SetPoint("TOP", b, "TOP", 0, -110)
    b.empty:SetText(emptyText)
    for i = 1, 5 do
        local row, data = b.rows[i], rows[i]
        row.medal:SetShown(data ~= nil)
        row.num:SetShown(data ~= nil)
        row.name:SetShown(data ~= nil)
        row.val:SetShown(data ~= nil)
        if data then
            local yy = 66 + (i - 1) * 32
            row.medal:ClearAllPoints()
            row.medal:SetPoint("TOPLEFT", b, "TOPLEFT", 14, -yy)
            setMedal(row.medal, i <= 3 and i or 4)
            row.num:SetText(tostring(i))
            row.name:SetWidth(w - 14 - 26 - 8 - 60)
            row.name:SetText(nameText(g, data[1]))
            row.val:ClearAllPoints()
            row.val:SetPoint("RIGHT", b, "TOPRIGHT", -12, -yy - 13)
            row.val:SetText(data[2])
        end
    end
    return b
end

-- třídy vždy anglicky (Warrior, Mage…), bez ohledu na jazyk hry
local CLASS_EN = { WARRIOR = "Warrior", PALADIN = "Paladin", HUNTER = "Hunter", ROGUE = "Rogue", PRIEST = "Priest",
    SHAMAN = "Shaman", MAGE = "Mage", WARLOCK = "Warlock", DRUID = "Druid" }

local function memberRow(g, name, m, header)
    local r = get("mem", function()
        local c = card(content)
        c:SetSize(CONTENT_W - 12, 30)
        c.dot = c:CreateTexture(nil, "ARTWORK")
        c.dot:SetSize(9, 9)
        c.dot:SetPoint("LEFT", 10, 0)
        c.name = fs(c, 13)
        c.name:SetPoint("LEFT", 28, 0)
        c.name:SetWidth(150)
        c.name:SetWordWrap(false)
        c.lvl = c:CreateFontString(nil, "OVERLAY")
        c.lvl:SetFont(NUMFONT, 13, "")
        c.lvl:SetTextColor(RED[1], RED[2], RED[3])
        c.lvl:SetWidth(26)
        c.lvl:SetJustifyH("CENTER")
        c.lvl:SetPoint("LEFT", 186, 0)
        c.barBg = c:CreateTexture(nil, "ARTWORK")
        c.barBg:SetSize(150, 8)
        c.barBg:SetPoint("LEFT", 218, 0)
        c.barBg:SetColorTexture(0.2, 0.12, 0.05, 0.28)
        c.bar = c:CreateTexture(nil, "OVERLAY")
        c.bar:SetHeight(8)
        c.bar:SetPoint("LEFT", c.barBg, "LEFT", 0, 0)
        c.class = fs(c, 12, SEPIA[1], SEPIA[2], SEPIA[3])
        c.class:SetPoint("LEFT", 384, 0)
        c.class:SetWidth(120)
        c.since = fs(c, 11, SEPIA[1], SEPIA[2], SEPIA[3])
        c.since:SetJustifyH("RIGHT")
        c.since:SetPoint("RIGHT", -12, 0)
        c.hl = c:CreateTexture(nil, "ARTWORK", nil, 2)
        c.hl:SetAllPoints()
        c.hl:SetColorTexture(1, 0.92, 0.7, 0.14)
        c.hl:Hide()
        c:EnableMouse(true)
        c:SetScript("OnEnter", function(self) self.hl:Show() end)
        c:SetScript("OnLeave", function(self) self.hl:Hide() end)
        return c
    end)
    r.name:SetText(nameText(g, name))
    r.class:SetText(CLASS_EN[m.cf or ""] or m.class or "")
    r.dot:SetColorTexture(m.online and 0.30 or 0.45, m.online and 0.70 or 0.40, m.online and 0.30 or 0.32, m.online and 1 or 0.7)
    local lvl = tonumber(m.lvl)
    r.lvl:SetText(lvl and tostring(lvl) or "?")
    local f = lvl and math.min(1, lvl / 60) or 0
    r.bar:SetWidth(math.max(1, 150 * f))
    r.bar:SetShown(lvl ~= nil)
    r.bar:SetColorTexture(0.30 + 0.62 * f, 0.58 + 0.12 * f, 0.88 - 0.68 * f, 0.95)   -- modrá -> zlatá
    r.since:SetText(m.rank or (m.since and ("od " .. date("%d.%m.%Y", m.since))) or "")
    return r
end

local function currentData()
    if demo then return demoData() end
    return guildData(false)
end

local function boardRows(counts)
    local arr = {}
    for who, c in pairs(counts) do arr[#arr + 1] = { who, c } end
    table.sort(arr, function(a, b) if a[2] ~= b[2] then return a[2] > b[2] end return a[1] < b[1] end)
    local out = {}
    for i = 1, math.min(5, #arr) do out[i] = { arr[i][1], tostring(arr[i][2]) .. "×" } end
    return out
end

local function renderLetopis(g)
    local y = 4
    local list = g.log or {}
    local shown = 0
    local day
    for i = #list, 1, -1 do
        local e = list[i]
        if KIND[e.k] then
            local d = longDate(e.t)
            if d ~= day then
                day = d
                local h = dateHeader(dayLabel(e.t))
                h:ClearAllPoints()
                h:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
                y = y + 32
            end
            local r = eventRow(g, e)
            r:ClearAllPoints()
            r:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
            y = y + 48
            shown = shown + 1
            if shown >= 250 then break end
        end
    end
    if shown == 0 then
        local c = get("emptyL", function()
            local f = card(content)
            f:SetSize(CONTENT_W - 12, 130)
            f.icon = f:CreateTexture(nil, "ARTWORK")
            f.icon:SetSize(48, 48)
            f.icon:SetPoint("TOP", 0, -16)
            f.text = fs(f, 13, SEPIA[1], SEPIA[2], SEPIA[3])
            f.text:SetJustifyH("CENTER")
            f.text:SetWidth(CONTENT_W - 80)
            f.text:SetPoint("TOP", f.icon, "BOTTOM", 0, -10)
            return f
        end)
        setIcon(c.icon, 6)
        c.text:SetText("Letopis je zatím prázdný.\nZapisuje se sám, jakmile se v cechu něco stane: přijetí a odchody, povýšení,\núrovně členů a bossové či pečetě členů, kteří mají addon.")
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
        y = y + 140
    end
    return y
end

local MONTH_NOM = { "leden", "únor", "březen", "duben", "květen", "červen", "červenec", "srpen", "září", "říjen", "listopad", "prosinec" }

-- nadpis sekce (ikona, název, tenká linka)
local function head(y, text, iconIdx)
    local h = get("head", function()
        local f = CreateFrame("Frame", nil, content)
        f:SetSize(CONTENT_W - 12, 34)
        f.icon = f:CreateTexture(nil, "ARTWORK")
        f.icon:SetSize(30, 30)
        f.icon:SetPoint("LEFT", 2, 0)
        f.label = f:CreateFontString(nil, "OVERLAY")
        f.label:SetFont(CINZEL, 15, "")
        f.label:SetTextColor(RED[1], RED[2], RED[3])
        f.label:SetPoint("LEFT", f.icon, "RIGHT", 8, 0)
        f.line = f:CreateTexture(nil, "ARTWORK")
        f.line:SetColorTexture(0.42, 0.27, 0.13, 0.5)
        f.line:SetHeight(1)
        f.line:SetPoint("LEFT", f.label, "RIGHT", 12, 0)
        f.line:SetPoint("RIGHT", f, "RIGHT", 0, 0)
        return f
    end)
    h:ClearAllPoints()
    h:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
    setIcon(h.icon, iconIdx)
    h.label:SetText(text)
    return h
end

-- karta s ikonou, názvem, popisem, textem vpravo a volitelným ukazatelem postupu (frac 0–1)
local function wall(x, y, w, iconIdx, title, text, right, frac, dim)
    local c = get("wall", function()
        local f = card(content)
        f.icon = f:CreateTexture(nil, "ARTWORK")
        f.icon:SetSize(46, 46)
        f.icon:SetPoint("LEFT", 10, 0)
        f.title = fs(f, 14, RED[1], RED[2], RED[3])
        f.title:SetPoint("TOPLEFT", 66, -11)
        f.title:SetWordWrap(false)
        f.text = fs(f, 12, SEPIA[1], SEPIA[2], SEPIA[3])
        f.text:SetPoint("TOPLEFT", 66, -34)
        f.text:SetWordWrap(false)
        f.right = fs(f, 12, SEPIA[1], SEPIA[2], SEPIA[3])
        f.right:SetJustifyH("RIGHT")
        f.right:SetPoint("TOPRIGHT", -12, -12)
        f.barBg = f:CreateTexture(nil, "ARTWORK")
        f.barBg:SetHeight(6)
        f.barBg:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 66, 10)
        f.barBg:SetColorTexture(0.2, 0.12, 0.05, 0.28)
        f.bar = f:CreateTexture(nil, "OVERLAY")
        f.bar:SetHeight(6)
        f.bar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 66, 10)
        return f
    end)
    c:SetSize(w, 72)
    c:ClearAllPoints()
    c:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
    setIcon(c.icon, iconIdx)
    c.icon:SetDesaturated(dim and true or false)
    c.icon:SetAlpha(dim and 0.5 or 1)
    c.title:SetWidth(w - 66 - 110)
    if dim then c.title:SetTextColor(SEPIA[1], SEPIA[2], SEPIA[3]) else c.title:SetTextColor(RED[1], RED[2], RED[3]) end
    c.title:SetText(title)
    c.text:SetWidth(w - 80)
    c.text:SetText(text or "")
    c.right:SetText(right or "")
    c.barBg:SetWidth(w - 80)
    c.barBg:SetShown(frac ~= nil)
    c.bar:SetShown(frac ~= nil and frac > 0)
    if frac then
        c.bar:SetWidth(math.max(1, (w - 80) * math.min(1, frac)))
        c.bar:SetColorTexture(0.30 + 0.62 * frac, 0.58 + 0.12 * frac, 0.88 - 0.68 * frac, 0.95)
    end
    return c
end

-- hráč měsíce: body za výpravy (2, bez úmrtí +1), bossy (1) a úrovně (3) v kalendářním měsíci
local function monthPlayers(g)
    local now = date("*t", time())
    local pts = {}
    local function slot(who)
        pts[who] = pts[who] or { p = 0, runs = 0, bosses = 0, lv = 0 }
        return pts[who]
    end
    local function inMonth(t)
        local d = date("*t", t or 0)
        return d.year == now.year and d.month == now.month
    end
    for _, e in ipairs(g.log or {}) do
        if inMonth(e.t) and e.who then
            if e.k == "boss" then local s = slot(e.who); s.bosses = s.bosses + 1; s.p = s.p + 1
            elseif e.k == "level" then local s = slot(e.who); s.lv = s.lv + 1; s.p = s.p + 3 end
        end
    end
    for _, r in ipairs(g.runs or {}) do
        if inMonth(r.t) then
            for _, who in ipairs(r.who or {}) do
                local s = slot(who)
                s.runs = s.runs + 1
                s.p = s.p + 2 + ((r.nd or 0) == 0 and 1 or 0)
            end
        end
    end
    local sorted = {}
    for who, s in pairs(pts) do sorted[#sorted + 1] = { who, s } end
    table.sort(sorted, function(a, b) if a[2].p ~= b[2].p then return a[2].p > b[2].p end return a[1] < b[1] end)
    return sorted, MONTH_NOM[now.month]
end

-- prvenství cechu z letopisu a výprav
local function guildFirsts(g)
    local boss, l60
    for _, e in ipairs(g.log or {}) do
        if e.k == "boss" and (not boss or (e.t or 0) < (boss.t or 0)) then boss = e end
        if e.k == "level" and tonumber(e.a) == 60 and (not l60 or (e.t or 0) < (l60.t or 0)) then l60 = e end
    end
    local firstRun, firstClean, fast
    for _, r in ipairs(g.runs or {}) do
        if not firstRun or (r.t or 0) < (firstRun.t or 0) then firstRun = r end
        if (r.nd or 0) == 0 and (not firstClean or (r.t or 0) < (firstClean.t or 0)) then firstClean = r end
    end
    for name, rec in pairs(g.records or {}) do
        if not fast or rec.dur < fast.dur then fast = { dur = rec.dur, t = rec.t, name = name } end
    end
    -- statistiky z výprav a členů
    local longest, bigRun, worstRun
    local pairCount, perPlayer = {}, {}
    for _, run in ipairs(g.runs or {}) do
        if not longest or (run.dur or 0) > longest.dur then longest = run end
        if not bigRun or #(run.who or {}) > #(bigRun.who or {}) then bigRun = run end
        if not worstRun or (run.nd or 0) > (worstRun.nd or 0) then worstRun = run end
        local w = run.who or {}
        for i = 1, #w do
            for j = i + 1, #w do
                local key = w[i] < w[j] and (w[i] .. "\1" .. w[j]) or (w[j] .. "\1" .. w[i])
                pairCount[key] = (pairCount[key] or 0) + 1
            end
        end
        for n, dd in pairs(run.deaths or {}) do perPlayer[n] = (perPlayer[n] or 0) + dd end
    end
    for n, dd in pairs(g.deathBy or {}) do perPlayer[n] = math.max(perPlayer[n] or 0, dd) end
    local topPair, topPairN
    for key, n in pairs(pairCount) do
        if not topPairN or n > topPairN or (n == topPairN and key < topPair) then topPair, topPairN = key, n end
    end
    local grave, graveN
    for n, dd in pairs(perPlayer) do
        if not graveN or dd > graveN or (dd == graveN and n < grave) then grave, graveN = n, dd end
    end
    local fast60, fast60d
    for _, e in ipairs(g.log or {}) do
        local m = e.k == "level" and tonumber(e.a) == 60 and g.members and g.members[e.who]
        if m and m.since and (e.t or 0) > m.since then
            local days = math.floor((e.t - m.since) / 86400)
            if not fast60d or days < fast60d then fast60, fast60d = e.who, days end
        end
    end
    local oldest
    for who, m in pairs(g.members or {}) do
        if m.since and (not oldest or m.since < oldest[2] or (m.since == oldest[2] and who < oldest[1])) then oldest = { who, m.since } end
    end
    local firstSeal
    for _, e in ipairs(g.log or {}) do
        if e.k == "seal" and (not firstSeal or (e.t or 0) < (firstSeal.t or 0)) then firstSeal = e end
    end
    local st = guildStats(g)
    local out = {}
    local function d(t) return t and date("%d.%m.%Y", t) or "" end
    if boss then out[#out + 1] = { 107, "První boss cechu", ("%s porazil %s"):format(nameText(g, boss.who), boss.a or "?"), d(boss.t) } end
    if l60 then out[#out + 1] = { 6, "První na úrovni 60", nameText(g, l60.who), d(l60.t) } end
    if firstRun then out[#out + 1] = { 101, "První cechovní výprava", ("%s  ·  %s"):format(firstRun.name or "?", fmtDur(firstRun.dur)), d(firstRun.t) } end
    if firstClean then out[#out + 1] = { 103, "První čistý průchod", ("%s  ·  bez úmrtí"):format(firstClean.name or "?"), d(firstClean.t) } end
    if fast then out[#out + 1] = { 105, "Nejrychlejší výprava", ("%s  ·  %s"):format(fast.name, fmtDur(fast.dur)), d(fast.t) } end
    if longest then out[#out + 1] = { 101, "Nejdelší výprava", ("%s  ·  %s"):format(longest.name or "?", fmtDur(longest.dur)), d(longest.t) } end
    if st.streak >= 2 then out[#out + 1] = { 103, "Nejdelší čistá série", ("%d výprav po sobě bez úmrtí"):format(st.streak), "" } end
    if bigRun and #(bigRun.who or {}) >= 2 then out[#out + 1] = { 106, "Největší skupina", ("%d členů cechu  ·  %s"):format(#bigRun.who, bigRun.name or "?"), d(bigRun.t) } end
    if topPair and topPairN >= 2 then
        local x, y = topPair:match("^(.-)\1(.*)$")
        out[#out + 1] = { 106, "Nejčastější dvojice", ("%s a %s"):format(nameText(g, x), nameText(g, y)), ("%d× spolu"):format(topPairN) }
    end
    if worstRun and (worstRun.nd or 0) >= 3 then out[#out + 1] = { 104, "Nejvíc úmrtí ve výpravě", ("%s  ·  %d úmrtí"):format(worstRun.name or "?", worstRun.nd), d(worstRun.t) } end
    if grave and graveN >= 3 then out[#out + 1] = { 104, "Rekordní hrobník", nameText(g, grave), ("%d úmrtí"):format(graveN) } end
    if fast60 then out[#out + 1] = { 6, "Nejrychlejší k šedesátce", nameText(g, fast60), ("%d dní od přijetí"):format(fast60d) } end
    if oldest then out[#out + 1] = { 1, "Pamětník cechu", nameText(g, oldest[1]), "od " .. d(oldest[2]) } end
    if firstSeal then out[#out + 1] = { 8, "První pečeť kronikáře", ("%s získal %s"):format(nameText(g, firstSeal.who), firstSeal.a or "?"), d(firstSeal.t) } end
    return out
end

-- Hráč měsíce, Zeď slávy a Cechovní pečetě (pod žebříčky v Síni slávy)
local function sinExtra(g, y)
    local full = CONTENT_W - 12
    local cw = math.floor((full - 12) / 2)
    local sorted, month = monthPlayers(g)
    head(y, ("Hráč měsíce · %s"):format(month), 6)
    y = y + 38
    if #sorted == 0 then
        wall(6, y, full, 6, "Zatím nikdo", "Body: výprava 2 (bez úmrtí +1), boss 1, nová úroveň 3. Počítá se za kalendářní měsíc.", nil, nil, true)
    else
        local top, others = sorted[1], {}
        for i = 2, math.min(3, #sorted) do others[#others + 1] = ("%s %d"):format(nameText(g, sorted[i][1]), sorted[i][2].p) end
        wall(6, y, full, 6, ("%s  ·  %d bodů"):format(nameText(g, top[1]), top[2].p),
            ("výprav %d, bossů %d, úrovní %d%s"):format(top[2].runs, top[2].bosses, top[2].lv,
                #others > 0 and ("   ·   dál: " .. table.concat(others, ", ")) or ""), nil)
    end
    y = y + 84

    head(y, "Zeď slávy", 105)
    y = y + 38
    local firsts = guildFirsts(g)
    if #firsts == 0 then
        wall(6, y, full, 105, "Zatím nic", "Prvenství se zapíšou, jakmile cech něco dokáže.", nil, nil, true)
        y = y + 80
    else
        for i, it in ipairs(firsts) do
            wall(6 + ((i - 1) % 2) * (cw + 12), y + math.floor((i - 1) / 2) * 80, cw, it[1], it[2], it[3], it[4])
        end
        y = y + math.ceil(#firsts / 2) * 80
    end
    y = y + 8

    head(y, "Cechovní pečetě", 108)
    y = y + 38
    local st = sealStatus(g)
    table.sort(st, function(a, b)
        if a.done ~= b.done then return a.done end
        if a.done then return (a.t or 0) < (b.t or 0) end
        return a.val / a.goal > b.val / b.goal
    end)
    for i, s in ipairs(st) do
        wall(6 + ((i - 1) % 2) * (cw + 12), y + math.floor((i - 1) / 2) * 80, cw, s.icon or 8, s.name, s.desc,
            s.done and date("%d.%m.%Y", s.t) or ("%d / %d"):format(s.val, s.goal), s.val / s.goal, not s.done)
    end
    y = y + math.ceil(#st / 2) * 80
    return y + 8
end

local function renderSin(g)
    local y = 6
    local bosses, seals, first60 = {}, {}, {}
    for _, e in ipairs(g.log or {}) do
        if e.k == "boss" then bosses[e.who] = (bosses[e.who] or 0) + 1
        elseif e.k == "seal" then seals[e.who] = (seals[e.who] or 0) + 1
        elseif e.k == "level" and tonumber(e.a) == 60 then first60[#first60 + 1] = e end
    end
    local bw = math.floor((CONTENT_W - 12 - 2 * 12) / 3)
    local rows60 = {}
    for i = 1, math.min(5, #first60) do rows60[i] = { first60[i].who, date("%d.%m.%y", first60[i].t or 0) } end
    board(g, 6, y, bw, 107, "Nejvíc bossů", boardRows(bosses), "Zatím žádný boss.\nZapisují se bossové\nčlenů s addonem.")
    board(g, 6 + bw + 12, y, bw, 8, "Nejvíc pečetí", boardRows(seals), "Zatím žádná pečeť.\nZapisují se pečetě\nčlenů s addonem.")
    board(g, 6 + (bw + 12) * 2, y, bw, 6, "První na úrovni 60", rows60, "Zatím nikdo.\nZapisuje se od chvíle,\nkdy se kronika spustila.")
    y = y + 234 + 16
    return sinExtra(g, y)
end

local function shortDur(secs)
    secs = math.max(0, math.floor(secs or 0))
    if secs >= 3600 then return ("%d:%02d:%02d"):format(math.floor(secs / 3600), math.floor(secs % 3600 / 60), secs % 60) end
    return ("%d:%02d"):format(math.floor(secs / 60), secs % 60)
end

-- karta jedné výpravy: medailon, název, čas a úmrtí, účastníci v barvách tříd a odznaky ocenění
local BADGE = {
    gold = { 0.85, 0.62, 0.20, "Cinzel" }, green = { 0.30, 0.62, 0.30 }, red = { 0.69, 0.20, 0.17 },
}
-- podrobnosti výpravy po najetí myší: bossové s časem od vstupu, úmrtí podle hráčů
local function showRunTip(card)
    local r = card.run
    if not r or not GameTooltip then return end
    GameTooltip:SetOwner(card, "ANCHOR_RIGHT")
    GameTooltip:AddLine(r.name or "?", 1, 0.82, 0.3)
    GameTooltip:AddLine(("%s  ·  %s"):format(longDate(r.t), fmtDur(r.dur)), 0.8, 0.8, 0.8)
    if #(r.bosses or {}) > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Poražení bossové", 1, 1, 1)
        for _, b in ipairs(r.bosses) do
            local name, bt = b, nil
            if type(b) == "table" then name, bt = b[1], b[2] end
            local off = bt and math.max(0, bt - (r.t or bt)) or nil
            GameTooltip:AddDoubleLine(tostring(name), off and shortDur(off) or "", 0.9, 0.9, 0.9, 0.6, 0.8, 1)
        end
    end
    GameTooltip:AddLine(" ")
    local list = {}
    for n, d in pairs(r.deaths or {}) do list[#list + 1] = { n, d } end
    table.sort(list, function(a, b) if a[2] ~= b[2] then return a[2] > b[2] end return a[1] < b[1] end)
    if #list == 0 then
        GameTooltip:AddLine("Bez jediného úmrtí", 0.4, 0.85, 0.4)
    else
        GameTooltip:AddLine("Úmrtí", 1, 1, 1)
        for _, it in ipairs(list) do GameTooltip:AddDoubleLine(it[1], it[2] .. "×", 0.9, 0.9, 0.9, 1, 0.45, 0.4) end
    end
    GameTooltip:Show()
    for i = 1, GameTooltip:NumLines() do
        for _, side in ipairs({ "Left", "Right" }) do
            local line = _G["GameTooltipText" .. side .. i]
            if line then line:SetFont(FONT, i == 1 and 14 or 12, "") end
        end
    end
end

local function runCard(g, r)
    local c = get("run", function()
        local f = card(content)
        f:SetSize(CONTENT_W - 12, 114)
        f.icon = f:CreateTexture(nil, "ARTWORK")
        f.icon:SetSize(56, 56)
        f.icon:SetPoint("TOPLEFT", 12, -12)
        f.title = fs(f, 16, RED[1], RED[2], RED[3])
        f.title:SetPoint("TOPLEFT", 82, -12)
        f.title:SetWidth(330)
        f.title:SetWordWrap(false)
        f.sub = fs(f, 12, SEPIA[1], SEPIA[2], SEPIA[3])
        f.sub:SetPoint("TOPLEFT", f.title, "BOTTOMLEFT", 0, -6)
        f.sub:SetWidth(330)
        f.sub:SetWordWrap(false)
        f.who = fs(f, 13)
        f.who:SetPoint("TOPLEFT", f.sub, "BOTTOMLEFT", 0, -10)
        f.who:SetWidth(CONTENT_W - 12 - 82 - 250)
        f.who:SetSpacing(3)
        f.chips = {}
        for i = 1, 3 do
            local chip = CreateFrame("Frame", nil, f)
            chip:SetSize(230, 34)
            chip:SetPoint("TOPRIGHT", -10, -10 - (i - 1) * 40)
            chip.bg = chip:CreateTexture(nil, "BACKGROUND")
            chip.bg:SetAllPoints()
            chip.bg:SetTexture(TEX .. "cech-odznaky.tga")
            chip.text = chip:CreateFontString(nil, "OVERLAY")
            chip.text:SetFont(CINZEL, 12, "OUTLINE")
            chip.text:SetTextColor(1, 1, 1)
            chip.text:SetShadowColor(0, 0, 0, 1)
            chip.text:SetShadowOffset(1, -1)
            chip.text:SetPoint("CENTER", 20, 0)
            chip.text:SetWidth(172)
            chip.text:SetWordWrap(false)
            f.chips[i] = chip
        end
        f.hl = f:CreateTexture(nil, "ARTWORK", nil, 2)
        f.hl:SetAllPoints()
        f.hl:SetColorTexture(1, 0.92, 0.7, 0.12)
        f.hl:Hide()
        f:EnableMouse(true)
        f:SetScript("OnEnter", function(self) self.hl:Show(); showRunTip(self) end)
        f:SetScript("OnLeave", function(self) self.hl:Hide(); if GameTooltip then GameTooltip:Hide() end end)
        return f
    end)
    c.run = r
    local nb = #(r.bosses or {})
    local clean = (r.nd or 0) == 0 and nb >= 1
    setIcon(c.icon, clean and 103 or (r.raid and 102 or 101))
    c.title:SetText(r.name or "?")
    c.sub:SetText(("%s  ·  %s  ·  bossů: %d  ·  úmrtí: %d"):format(longDate(r.t), fmtDur(r.dur), nb, r.nd or 0))
    local names = {}
    for _, n in ipairs(r.who or {}) do names[#names + 1] = nameText(g, n) end
    c.who:SetText(table.concat(names, ", "))
    -- odznaky
    local chips = {}
    if clean then chips[#chips + 1] = { "Čistý průchod", 0 } end
    if r.record then chips[#chips + 1] = { "Nový rekord", 1 } end
    local worst, wn = nil, 0
    for n, d in pairs(r.deaths or {}) do if d > wn or (d == wn and worst and n < worst) then worst, wn = n, d end end
    if worst and wn >= 2 then chips[#chips + 1] = { ("Host hřbitova: %s"):format(worst), 2 } end
    for i = 1, 3 do
        local chip, def = c.chips[i], chips[i]
        chip:SetShown(def ~= nil)
        if def then
            local col = def[2]
            chip.bg:SetTexCoord(0, 870 / 1024, col * 0.25, col * 0.25 + 0.25)
            chip.text:SetText(def[1])
        end
    end
    return c
end

local function renderVypravy(g)
    local y = 6
    local runs = g.runs or {}
    if #runs == 0 then
        local c = get("emptyR", function()
            local f = card(content)
            f:SetSize(CONTENT_W - 12, 150)
            f.icon = f:CreateTexture(nil, "ARTWORK")
            f.icon:SetSize(48, 48)
            f.icon:SetPoint("TOP", 0, -16)
            f.text = fs(f, 13, SEPIA[1], SEPIA[2], SEPIA[3])
            f.text:SetJustifyH("CENTER")
            f.text:SetWidth(CONTENT_W - 80)
            f.text:SetPoint("TOP", f.icon, "BOTTOM", 0, -10)
            return f
        end)
        setIcon(c.icon, 101)
        c.text:SetText("Zatím žádná cechovní výprava.\nZapíše se sama, když půjdeš do dungeonu nebo raidu se skupinou,\nkde jsou aspoň 3 členové cechu a většina skupiny (60 %).\nZměří se čas, úmrtí a poražení bossové a rozdají se ocenění.")
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
        return y + 160
    end
    local clean, bosses, secs = 0, 0, 0
    local part, deathsBy = {}, {}
    for _, r in ipairs(runs) do
        if (r.nd or 0) == 0 then clean = clean + 1 end
        bosses = bosses + #(r.bosses or {})
        secs = secs + (r.dur or 0)
        for _, n in ipairs(r.who or {}) do part[n] = (part[n] or 0) + 1 end
        for n, d in pairs(r.deaths or {}) do deathsBy[n] = (deathsBy[n] or 0) + d end
    end
    local tw = math.floor((CONTENT_W - 12 - 3 * 10) / 4)
    local total = secs >= 3600 and ("%d h"):format(math.floor(secs / 3600 + 0.5)) or ("%d min"):format(math.floor(secs / 60))
    tile(6, y, tw, tostring(#runs), "cechovních výprav")
    tile(6 + (tw + 10), y, tw, ("%d %%"):format(math.floor(clean / #runs * 100 + 0.5)), "výprav bez úmrtí")
    tile(6 + (tw + 10) * 2, y, tw, tostring(bosses), "poražených bossů")
    tile(6 + (tw + 10) * 3, y, tw, total, "společně strávený čas")
    local dv = get("div", function()
        local d = CreateFrame("Frame", nil, content)
        d:SetSize(CONTENT_W - 12, 46)
        d.tex = d:CreateTexture(nil, "ARTWORK")
        d.tex:SetTexture(TEX .. "cech-oddelovac.tga")
        d.tex:SetSize(500, 62.5)
        d.tex:SetPoint("CENTER")
        return d
    end)
    dv:ClearAllPoints()
    dv:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -(y + 72 + 2))
    y = y + 72 + 2 + 46 + 4
    local recRows = {}
    for name, rec in pairs(g.records or {}) do recRows[#recRows + 1] = { name, shortDur(rec.dur), rec.dur } end
    table.sort(recRows, function(a, b) return a[3] < b[3] end)
    for i = #recRows, 6, -1 do recRows[i] = nil end
    local bw = math.floor((CONTENT_W - 12 - 2 * 12) / 3)
    board(g, 6, y, bw, 106, "Nejvíc výprav", boardRows(part), "Zatím žádná výprava.")
    board(g, 6 + bw + 12, y, bw, 104, "Návštěvníci hřbitova", boardRows(deathsBy), "Zatím nikdo neumřel.\nPoctivě!")
    board(g, 6 + (bw + 12) * 2, y, bw, 105, "Rekordní časy", recRows, "Zatím žádný rekord.")
    y = y + 234 + 16
    for i = #runs, 1, -1 do
        local c = runCard(g, runs[i])
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
        y = y + 122
        if #runs - i >= 40 then break end
    end
    return y + 6
end

-- souhrn cechu (čtyři dlaždice a ozdobný oddělovač) nad seznamem členů
local function memberSummary(g, y)
    local members, sum, n60, n, newMonth = 0, 0, 0, 0, 0
    local cutoff = time() - 30 * 86400
    for _, m in pairs(g.members or {}) do
        members = members + 1
        if m.lvl then n = n + 1; sum = sum + m.lvl; if m.lvl >= 60 then n60 = n60 + 1 end end
    end
    for _, e in ipairs(g.log or {}) do
        if e.k == "join" and (e.t or 0) >= cutoff then newMonth = newMonth + 1 end
    end
    local tw = math.floor((CONTENT_W - 12 - 3 * 10) / 4)
    tile(6, y, tw, tostring(members), "členů cechu")
    tile(6 + (tw + 10), y, tw, tostring(n60), "na úrovni 60")
    tile(6 + (tw + 10) * 2, y, tw, n > 0 and ("%.1f"):format(sum / n) or "?", "průměrná úroveň")
    tile(6 + (tw + 10) * 3, y, tw, "+" .. newMonth, "nových za 30 dní")
    local dv = get("div", function()
        local d = CreateFrame("Frame", nil, content)
        d:SetSize(CONTENT_W - 12, 46)
        d.tex = d:CreateTexture(nil, "ARTWORK")
        d.tex:SetTexture(TEX .. "cech-oddelovac.tga")
        d.tex:SetSize(500, 62.5)
        d.tex:SetPoint("CENTER")
        return d
    end)
    dv:ClearAllPoints()
    dv:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -(y + 72 + 2))
    return y + 72 + 2 + 46 + 4
end

local function renderClenove(g)
    local y = 6
    if next(g.members or {}) then y = memberSummary(g, y) end
    local arr = {}
    for name, m in pairs(g.members or {}) do arr[#arr + 1] = { name, m } end
    table.sort(arr, function(a, b)
        local ra, rb = tonumber(a[2].ri) or 99, tonumber(b[2].ri) or 99
        if ra ~= rb then return ra < rb end
        local la, lb = tonumber(a[2].lvl) or 0, tonumber(b[2].lvl) or 0
        if la ~= lb then return la > lb end
        return a[1] < b[1]
    end)
    if #arr == 0 then
        local c = get("emptyM", function()
            local f = card(content)
            f:SetSize(CONTENT_W - 12, 90)
            f.text = fs(f, 13, SEPIA[1], SEPIA[2], SEPIA[3])
            f.text:SetJustifyH("CENTER")
            f.text:SetWidth(CONTENT_W - 80)
            f.text:SetPoint("CENTER")
            return f
        end)
        c.text:SetText("Seznam členů se ještě nenačetl.\nZkus tlačítko Obnovit seznam.")
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -6)
        return 110
    end
    for _, it in ipairs(arr) do
        local r = memberRow(g, it[1], it[2])
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -y)
        y = y + 33
    end
    return y
end

-- stavy záložky v atlasu cech-zalozka.tga: 0 neaktivní, 1 aktivní, 2 najetí myší
local function tabLook(b)
    local on = b.id == tab
    local state = on and 1 or (b.hover and 2 or 0)
    b.bg:SetTexCoord(0, 0.9, state * 0.25, (state + 1) * 0.25)
    if on then b.label:SetTextColor(1, 0.97, 0.80) else b.label:SetTextColor(0.96, 0.85, 0.60) end
    b.label:SetPoint("CENTER", 0, on and 2 or 1)
end

local function updateTabs()
    for _, b in ipairs(frame.tabBtns) do tabLook(b) end
end

refresh = function()
    if not frame then return end
    local g = currentData()
    resetPools()
    updateTabs()
    frame.demoNote:SetShown(demo == true)
    local y
    if not g then
        frame.guildName:SetText("Bez cechu")
        frame.sub:SetText("")
        local c = get("emptyG", function()
            local f = card(content)
            f:SetSize(CONTENT_W - 12, 130)
            f.icon = f:CreateTexture(nil, "ARTWORK")
            f.icon:SetSize(48, 48)
            f.icon:SetPoint("TOP", 0, -16)
            f.text = fs(f, 13, SEPIA[1], SEPIA[2], SEPIA[3])
            f.text:SetJustifyH("CENTER")
            f.text:SetWidth(CONTENT_W - 80)
            f.text:SetPoint("TOP", f.icon, "BOTTOM", 0, -10)
            return f
        end)
        setIcon(c.icon, 2)
        c.text:SetText("Nejsi v žádném cechu, nebo se ještě nenačetl jeho seznam.\nKronika se začne psát hned, jak do cechu vstoupíš.\n\nNáhled vzhledu: /czq cech ukazka")
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", content, "TOPLEFT", 6, -6)
        y = 150
    else
        -- zdobné herní písmo Morpheus umí jen základní latinku; s háčky (č, ř, ě…) se použije naše písmo
        local gn = g.name or ""
        local gfont = (gn:find("[\196\197]") and CINZELDEC) or "Fonts\\MORPHEUS.ttf"
        frame.guildName:SetFont(gfont, 24, "OUTLINE")
        frame.guildName:SetText(gn)
        local n = 0
        for _ in pairs(g.members or {}) do n = n + 1 end
        frame.sub:SetText(("Členů: %d   ·   v kronice od %s"):format(n, g.created and longDate(g.created) or "?"))
        if tab == "sin" then y = renderSin(g) elseif tab == "vypravy" then y = renderVypravy(g) elseif tab == "clenove" then y = renderClenove(g) else y = renderLetopis(g) end
    end
    content:SetHeight(math.max(y + 12, 100))
    frame.copyBtn:SetShown(tab == "letopis" and g ~= nil)
end

-- okno s prostým textem letopisu ke zkopírování
local function makeButton(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(w, h)
    b.bg = b:CreateTexture(nil, "BACKGROUND")
    b.bg:SetAllPoints()
    b.bg:SetTexture(TEX .. "cech-zalozka.tga")
    local function look(state)   -- stavy v atlasu: 0 klid, 1 stisknuto, 2 najetí myší
        b.bg:SetTexCoord(0, 0.9, state * 0.25, (state + 1) * 0.25)
        b.label:SetPoint("CENTER", 0, state == 1 and 0 or 1)
        b.label:SetTextColor(1, state == 0 and 0.88 or 0.97, state == 0 and 0.62 or 0.80)
    end
    b.label = b:CreateFontString(nil, "OVERLAY")
    b.label:SetFont(CINZEL, 12, "OUTLINE")
    b.label:SetJustifyH("CENTER")
    b.label:SetText(text)
    look(0)
    b:SetScript("OnEnter", function(self) self.over = true; look(2) end)
    b:SetScript("OnLeave", function(self) self.over = false; look(0) end)
    b:SetScript("OnMouseDown", function() look(1) end)
    b:SetScript("OnMouseUp", function(self) look(self.over and 2 or 0) end)
    return b
end

local copyWin
local function showCopy()
    local g = currentData()
    if not g then return end
    if not copyWin then
        local f = CreateFrame("Frame", "WoWpoCeskuCechKopie", UIParent, "BackdropTemplate")
        copyWin = f
        f:SetSize(560, 420)
        f:SetPoint("CENTER")
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetToplevel(true)
        f:SetBackdrop({ bgFile = WHITE, edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 32,
            insets = { left = 11, right = 11, top = 11, bottom = 11 } })
        f:SetBackdropColor(0.10, 0.10, 0.14, 0.97)
        f:EnableMouse(true)
        f:SetMovable(true)
        f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving)
        f:SetScript("OnDragStop", f.StopMovingOrSizing)
        local t = f:CreateFontString(nil, "OVERLAY")
        t:SetFont(FONT, 15, "")
        t:SetTextColor(1, 0.82, 0)
        t:SetPoint("TOP", 0, -20)
        t:SetText("Letopis cechu ke zkopírování")
        local hint = f:CreateFontString(nil, "OVERLAY")
        hint:SetFont(FONT, 11, "")
        hint:SetTextColor(0.7, 0.7, 0.7)
        hint:SetPoint("TOP", t, "BOTTOM", 0, -6)
        hint:SetText("Klikni do textu, Ctrl+A označí vše, Ctrl+C zkopíruje. Pak ho vlož třeba na Discord.")
        local sf = CreateFrame("ScrollFrame", "WoWpoCeskuCechKopieScroll", f, "UIPanelScrollFrameTemplate")
        sf:SetPoint("TOPLEFT", 24, -64)
        sf:SetPoint("BOTTOMRIGHT", -40, 56)
        local eb = CreateFrame("EditBox", nil, sf)
        eb:SetMultiLine(true)
        eb:SetAutoFocus(false)
        eb:SetFont(FONT, 12, "")
        eb:SetWidth(480)
        eb:SetScript("OnEscapePressed", eb.ClearFocus)
        sf:SetScrollChild(eb)
        f.edit = eb
        local ok = makeButton(f, "Zavřít", 130, 36)
        ok:SetPoint("BOTTOMRIGHT", -20, 14)
        ok:SetScript("OnClick", function() f:Hide() end)
        tinsert(UISpecialFrames, "WoWpoCeskuCechKopie")
    end
    copyWin.edit:SetText(plainLetopis(g))
    copyWin.edit:SetCursorPosition(0)
    copyWin:Show()
    copyWin:Raise()
end

-- Okno z hotové grafiky: ozdobný rám (rohy + zrcadlené hrany), pergamen, ilustrace sálu, erby a stuha s názvem cechu
local WIN_W, WIN_H = 820, 760
local D = 0.75          -- zobrazená velikost = pixel textury * D
local CORNER_PX, EDGE_PX, STRIP_PX = 120, 75, 1024

local function buildChrome(f)
    local chrome = CreateFrame("Frame", nil, f)
    chrome:SetAllPoints()
    chrome:SetFrameLevel(f:GetFrameLevel() + 30)
    chrome:EnableMouse(false)
    local c = CORNER_PX * D
    local t = EDGE_PX * D
    local cu = CORNER_PX / 128
    local function corner(point, l, r, tp, bt)
        local x = chrome:CreateTexture(nil, "OVERLAY", nil, 2)
        x:SetTexture(TEX .. "cech-ram-roh.tga")
        x:SetSize(c, c)
        x:SetPoint(point)
        x:SetTexCoord(l, r, tp, bt)
    end
    corner("TOPLEFT", 0, cu, 0, cu)
    corner("TOPRIGHT", cu, 0, 0, cu)
    corner("BOTTOMLEFT", 0, cu, cu, 0)
    corner("BOTTOMRIGHT", cu, 0, cu, 0)
    local eh, ev = EDGE_PX / 128, 0
    local uW = (WIN_W - 2 * c) / (STRIP_PX * D)
    local uH = (WIN_H - 2 * c) / (STRIP_PX * D)
    local top = chrome:CreateTexture(nil, "OVERLAY", nil, 1)
    top:SetTexture(TEX .. "cech-ram-h.tga")
    top:SetPoint("TOPLEFT", c, 0)
    top:SetPoint("TOPRIGHT", -c, 0)
    top:SetHeight(t)
    top:SetTexCoord(0, uW, 0, eh)
    local bottom = chrome:CreateTexture(nil, "OVERLAY", nil, 1)
    bottom:SetTexture(TEX .. "cech-ram-h.tga")
    bottom:SetPoint("BOTTOMLEFT", c, 0)
    bottom:SetPoint("BOTTOMRIGHT", -c, 0)
    bottom:SetHeight(t)
    bottom:SetTexCoord(0, uW, eh, 0)
    local left = chrome:CreateTexture(nil, "OVERLAY", nil, 1)
    left:SetTexture(TEX .. "cech-ram-v.tga")
    left:SetPoint("TOPLEFT", 0, -c)
    left:SetPoint("BOTTOMLEFT", 0, c)
    left:SetWidth(t)
    left:SetTexCoord(0, eh, 0, uH)
    local right = chrome:CreateTexture(nil, "OVERLAY", nil, 1)
    right:SetTexture(TEX .. "cech-ram-v.tga")
    right:SetPoint("TOPRIGHT", 0, -c)
    right:SetPoint("BOTTOMRIGHT", 0, c)
    right:SetWidth(t)
    right:SetTexCoord(eh, 0, 0, uH)
    return chrome
end

local function build()
    local f = CreateFrame("Frame", "WoWpoCeskuCechKronika", UIParent, "BackdropTemplate")
    frame = f
    f:SetSize(WIN_W, WIN_H)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- pergamenové pozadí (uvnitř rámu, ořez textury podle poměru stran okna)
    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetPoint("TOPLEFT", 18, -18)
    bg:SetPoint("BOTTOMRIGHT", -18, 18)
    bg:SetTexture(TEX .. "cech-pozadi.tga")
    local aspect = (WIN_W - 36) / (WIN_H - 36)
    local vf = math.min(1, 1 / aspect)
    bg:SetTexCoord(0, 1, (1 - vf) / 2, 1 - (1 - vf) / 2)
    local function shade(point1, point2, w, h, a1, a2, orient)
        local s = f:CreateTexture(nil, "BACKGROUND", nil, 2)
        s:SetPoint(point1, f, point1, point1:find("LEFT") and 18 or -18, point1:find("TOP") and -18 or 18)
        s:SetPoint(point2, f, point2, point2:find("LEFT") and 18 or -18, point2:find("TOP") and -18 or 18)
        if w then s:SetWidth(w) end
        if h then s:SetHeight(h) end
        gradient(s, 0.25, 0.14, 0.06, a1, a2, orient)
    end
    shade("TOPLEFT", "BOTTOMLEFT", 60, nil, 0.38, 0, "HORIZONTAL")
    shade("TOPRIGHT", "BOTTOMRIGHT", 60, nil, 0, 0.38, "HORIZONTAL")
    shade("BOTTOMLEFT", "BOTTOMRIGHT", nil, 50, 0, 0.35, "VERTICAL")

    buildChrome(f)

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -6, -6)
    close:SetFrameLevel(f:GetFrameLevel() + 40)

    -- ilustrace sálu v ozdobném rámečku
    local pic = CreateFrame("Frame", nil, f, "BackdropTemplate")
    pic:SetSize(WIN_W - 120, 150)
    pic:SetPoint("TOP", f, "TOP", 0, -56)
    pic:SetBackdrop({ edgeFile = WHITE, edgeSize = 2 })
    pic:SetBackdropBorderColor(0.60, 0.42, 0.14, 1)
    local hall = pic:CreateTexture(nil, "BACKGROUND")
    hall:SetPoint("TOPLEFT", 2, -2)
    hall:SetPoint("BOTTOMRIGHT", -2, 2)
    hall:SetTexture(TEX .. "cech-hlavicka.tga")
    local pw, ph = WIN_W - 124, 146
    local vh = (pw / ph) < 4 and 1 or (4 / (pw / ph))
    hall:SetTexCoord(0, 1, (1 - vh) / 2, 1 - (1 - vh) / 2)
    local top = pic:CreateTexture(nil, "ARTWORK")
    top:SetPoint("TOPLEFT", 2, -2)
    top:SetPoint("TOPRIGHT", -2, -2)
    top:SetHeight(34)
    gradient(top, 0.04, 0.02, 0.01, 0.65, 0, "VERTICAL")
    local title = pic:CreateFontString(nil, "OVERLAY")
    title:SetFont(CINZEL, 15, "OUTLINE")
    title:SetTextColor(1, 0.88, 0.55)
    title:SetPoint("TOP", 0, -9)
    title:SetText("C E C H O V N Í   K R O N I K A")

    -- erby po stranách
    for _, side in ipairs({ -1, 1 }) do
        local erb = f:CreateTexture(nil, "ARTWORK", nil, 3)
        erb:SetTexture(TEX .. "cech-erb.tga")
        erb:SetSize(112, 112)
        erb:SetPoint("CENTER", pic, side < 0 and "LEFT" or "RIGHT", -side * 72, -8)
        if side > 0 then erb:SetTexCoord(1, 0, 0, 1) end
    end

    -- stuha s názvem cechu
    local ribbon = f:CreateTexture(nil, "ARTWORK", nil, 4)
    ribbon:SetTexture(TEX .. "cech-stuha.tga")
    ribbon:SetSize(440, 440 * 271 / 1024)
    ribbon:SetPoint("BOTTOM", pic, "BOTTOM", 0, -24)
    ribbon:SetTexCoord(0, 1, 0, 271 / 512)
    f.guildName = f:CreateFontString(nil, "OVERLAY", nil, 7)
    f.guildName:SetFont(FONT, 22, "OUTLINE")
    f.guildName:SetTextColor(1, 0.95, 0.78)
    f.guildName:SetPoint("CENTER", ribbon, "CENTER", 0, 11)   -- střed pásu stuhy je výš než střed obrázku (dole visí střapce)
    f.guildName:SetWidth(290)
    f.guildName:SetWordWrap(false)
    f.guildName:SetJustifyH("CENTER")
    f.sub = fs(f, 12, SEPIA[1], SEPIA[2], SEPIA[3])
    f.sub:SetJustifyH("CENTER")
    f.sub:SetPoint("TOP", pic, "BOTTOM", 0, -30)
    f.demoNote = fs(f, 11, 0.95, 0.35, 0.25, "OUTLINE")
    f.demoNote:SetPoint("BOTTOMRIGHT", pic, "BOTTOMRIGHT", -10, 6)
    f.demoNote:SetText("UKÁZKA – vymyšlená data")

    -- záložky
    f.tabBtns = {}
    local bw = 160
    for i, def in ipairs(tabs) do
        local b = CreateFrame("Button", nil, f)
        b.id = def[1]
        b:SetSize(bw, 44)
        b:SetPoint("TOP", f, "TOP", (i - (#tabs + 1) / 2) * (bw + 6), -255)
        b.bg = b:CreateTexture(nil, "BACKGROUND")
        b.bg:SetAllPoints()
        b.bg:SetTexture(TEX .. "cech-zalozka.tga")
        b.label = b:CreateFontString(nil, "OVERLAY")
        b.label:SetFont(CINZEL, 14, "OUTLINE")
        b.label:SetJustifyH("CENTER")
        b.label:SetPoint("CENTER", 0, 1)
        b.label:SetText(def[2])
        b:SetScript("OnEnter", function(self) self.hover = true; tabLook(self) end)
        b:SetScript("OnLeave", function(self) self.hover = false; tabLook(self) end)
        b:SetScript("OnClick", function()
            if tab ~= def[1] then
                tab = def[1]
                PlaySound(SOUNDKIT and SOUNDKIT.IG_ABILITY_PAGE_TURN or 836)
                refresh()
                scroll:SetVerticalScroll(0)
                f.contentFade:Stop(); content:SetAlpha(0); f.contentFade:Play()
            end
        end)
        f.tabBtns[i] = b
    end

    -- obsah
    scroll = CreateFrame("ScrollFrame", "WoWpoCeskuCechKronikaScroll", f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 62, -312)
    scroll:SetPoint("BOTTOMRIGHT", -84, 90)
    content = CreateFrame("Frame", nil, scroll)
    content:SetSize(CONTENT_W, 100)
    scroll:SetScrollChild(content)

    -- spodní lišta
    local refreshBtn = makeButton(f, "Obnovit seznam", 160, 40)
    refreshBtn:SetPoint("BOTTOMLEFT", 60, 55)
    refreshBtn:SetScript("OnClick", function()
        requestRoster()
        C_Timer.After(1.5, function() if not demo then pcall(snapshot) end refresh() end)
    end)
    f.copyBtn = makeButton(f, "Kopírovat letopis", 170, 40)
    f.copyBtn:SetPoint("LEFT", refreshBtn, "RIGHT", 6, 0)
    f.copyBtn:SetScript("OnClick", showCopy)
    local hint = fs(f, 11, SEPIA[1], SEPIA[2], SEPIA[3])
    hint:SetJustifyH("RIGHT")
    hint:SetPoint("BOTTOMRIGHT", -70, 68)
    hint:SetText("Kronika se plní sama z dění v cechu")

    -- plynulé zobrazení okna a obsahu
    f.fade = f:CreateAnimationGroup()
    local a = f.fade:CreateAnimation("Alpha")
    a:SetFromAlpha(0)
    a:SetToAlpha(1)
    a:SetDuration(0.2)
    a:SetSmoothing("OUT")
    f.fade:SetScript("OnFinished", function() f:SetAlpha(1) end)
    f.contentFade = content:CreateAnimationGroup()
    local c2 = f.contentFade:CreateAnimation("Alpha")
    c2:SetFromAlpha(0)
    c2:SetToAlpha(1)
    c2:SetDuration(0.18)
    f.contentFade:SetScript("OnFinished", function() content:SetAlpha(1) end)

    tinsert(UISpecialFrames, "WoWpoCeskuCechKronika")
    f:SetScript("OnShow", function()
        f:SetAlpha(0)
        f.fade:Stop()
        f.fade:Play()
        requestRoster()
        C_Timer.After(1.5, function() if not demo then pcall(snapshot) end refresh() end)
    end)
end

function WoWpoCesku_GuildChronicle(arg)
    arg = (arg or ""):lower()
    local wasDemo = demo
    demo = (arg == "ukazka" or arg == "demo") or nil
    -- čerstvě vytvořené okno je hned viditelné, takže při prvním otevření se nesmí „přepnout“ zpět na zavřené
    local fresh = not frame
    if fresh then build() end
    if not fresh and frame:IsShown() and not demo and arg == "" and not wasDemo then frame:Hide() return end
    if not frame:IsShown() then frame:Show() end
    frame:Raise()
    refresh()
end

-------------------------------------------------------------------------------
-- Události
-------------------------------------------------------------------------------
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("CHAT_MSG_SYSTEM")
ev:RegisterEvent("CHAT_MSG_ADDON")
ev:RegisterEvent("GUILD_ROSTER_UPDATE")
ev:RegisterEvent("PLAYER_GUILD_UPDATE")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ev:RegisterEvent("GROUP_ROSTER_UPDATE")
ev:SetScript("OnEvent", function(_, event, a1, a2, a3, a4)
    if event == "PLAYER_LOGIN" then
        if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX) end
        C_Timer.After(10, requestRoster)
    elseif event == "CHAT_MSG_SYSTEM" then
        pcall(onSystem, a1)
    elseif event == "CHAT_MSG_ADDON" then
        pcall(onAddon, a1, a2, a3, a4)
    elseif event == "GUILD_ROSTER_UPDATE" then
        if guildKey() then pcall(snapshot) end
    elseif event == "PLAYER_GUILD_UPDATE" then
        C_Timer.After(3, requestRoster)
    elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        C_Timer.After(2, function() pcall(onWorld) end)
    elseif event == "GROUP_ROSTER_UPDATE" then
        pcall(scanGroup)
    end
end)
