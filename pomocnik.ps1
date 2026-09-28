# Pomocník WoWpoCesku
# Hlídá schránku. Když v ní najde quest zkopírovaný z addonu (začíná "CZQ#"),
# přeloží ho, ukáže v okně a uloží do preklady.json + WoWpoCesku\Data.lua.

Add-Type -AssemblyName System.Windows.Forms, System.Drawing
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Root         = $PSScriptRoot
$SettingsPath = Join-Path $Root "nastaveni.json"
$CachePath    = Join-Path $Root "preklady.json"
$GlossaryPath = Join-Path $Root "slovnicek.txt"
$DataLuaPath  = Join-Path $Root "WoWpoCesku\Data.lua"
$Utf8NoBom    = New-Object System.Text.UTF8Encoding $false
$FieldOrder   = @("title", "text", "objectives", "progress", "reward")
$FieldLabels  = @{ title = "Název"; text = "Popis"; objectives = "Úkol"; progress = "Průběh"; reward = "Odměna" }

# ----------------------------------------------------------------------------
# Nastavení a cache
# ----------------------------------------------------------------------------
function Read-JsonFile($path) {
    if (Test-Path $path) { return (Get-Content $path -Raw -Encoding UTF8 | ConvertFrom-Json) }
    return $null
}

# nastaveni.json se nenahrává na GitHub (obsahuje API klíč) -> při prvním spuštění vznikne ze vzoru
$ExamplePath = Join-Path $Root "nastaveni.example.json"
if (-not (Test-Path $SettingsPath) -and (Test-Path $ExamplePath)) { Copy-Item $ExamplePath $SettingsPath }
$Settings = Read-JsonFile $SettingsPath
if (-not $Settings) { $Settings = [pscustomobject]@{ prekladac = "google"; claude_api_klic = ""; claude_model = "claude-haiku-4-5" } }

function Save-Settings { [IO.File]::WriteAllText($SettingsPath, ($Settings | ConvertTo-Json), $Utf8NoBom) }
function Set-Setting($name, $value) {
    if ($Settings.PSObject.Properties[$name]) { $Settings.$name = $value }
    else { $Settings | Add-Member -NotePropertyName $name -NotePropertyValue $value }
}

# Společná databáze: sběrna nových questů a aktuální překlady na GitHubu
$SbernaUrl      = "https://wowpocesku-sberna.wowpocesku-sberna.workers.dev"
$RemoteCacheUrl = "https://raw.githubusercontent.com/RankonRP/WoWpoCesku/main/preklady.json"
$EtagPath       = Join-Path $Root ".preklady.etag"

# Náhodné ID instalace (sběrna podle něj pozná, že stejný quest poslali různí hráči)
if (-not $Settings.klient_id) {
    $bytes = New-Object byte[] 16
    [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    Set-Setting "klient_id" (($bytes | ForEach-Object { $_.ToString("x2") }) -join "")
    Save-Settings
}

# Cache: id questu (string) -> hashtable polí. Pole "en_*" drží anglický originál.
# Pro velký soubor se používá JavaScriptSerializer (ConvertFrom-Json v PS 5.1 má limit ~2 MB).
Add-Type -AssemblyName System.Web.Extensions
$Json = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$Json.MaxJsonLength = [int]::MaxValue

$script:Cache = @{}
if (Test-Path $CachePath) {
    $raw = $Json.DeserializeObject([IO.File]::ReadAllText($CachePath, [Text.Encoding]::UTF8))
    foreach ($id in $raw.Keys) {
        $h = @{}
        foreach ($k in $raw[$id].Keys) { $h[$k] = [string]$raw[$id][$k] }
        $script:Cache[$id] = $h
    }
}

# Jeden quest = jeden řádek, aby šel soubor snadno prohledávat a opravovat
function Save-Cache {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append("{`n")
    $ids = @($script:Cache.Keys | Sort-Object { [int]$_ })
    for ($i = 0; $i -lt $ids.Count; $i++) {
        $entry = New-Object 'System.Collections.Generic.SortedDictionary[string,string]'
        foreach ($k in $script:Cache[$ids[$i]].Keys) { $entry[$k] = $script:Cache[$ids[$i]][$k] }
        $comma = if ($i -lt $ids.Count - 1) { "," } else { "" }
        [void]$sb.Append("  `"$($ids[$i])`": $($Json.Serialize($entry))$comma`n")
    }
    [void]$sb.Append("}`n")
    [IO.File]::WriteAllText($CachePath, $sb.ToString(), $Utf8NoBom)
}

function ConvertTo-LuaString([string]$s) {
    '"' + ($s -replace '\\', '\\' -replace '"', '\"' -replace "`r", '' -replace "`n", '\n') + '"'
}

function Write-DataLua {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v preklady.json.")
    [void]$sb.AppendLine("WoWpoCesku_Data = {")
    foreach ($id in ($script:Cache.Keys | Sort-Object { [int]$_ })) {
        $parts = foreach ($f in $FieldOrder) {
            $v = $script:Cache[$id][$f]
            if ($v) { "$f=$(ConvertTo-LuaString $v)" }
        }
        if ($script:Cache[$id]["en_title"]) { $parts = @($parts) + "en=$(ConvertTo-LuaString $script:Cache[$id]["en_title"])" }
        # eo = anglický text úkolu (addon podle něj překládá úkoly v přehledu a deníku)
        if ($script:Cache[$id]["en_objectives"] -and $script:Cache[$id]["objectives"]) { $parts = @($parts) + "eo=$(ConvertTo-LuaString $script:Cache[$id]["en_objectives"])" }
        if ($parts) { [void]$sb.AppendLine("[$id]={" + ($parts -join ",") + "},") }
    }
    [void]$sb.AppendLine("}")
    [IO.File]::WriteAllText($DataLuaPath, $sb.ToString(), $Utf8NoBom)
}

# ----------------------------------------------------------------------------
# Rozhovory s NPC: klíč = anglický text se sjednocenými mezerami (addon ho počítá stejně)
# rozhovory.json: { "<anglický text>": { cs, en, npc, src } } -> WoWpoCesku\DataRozhovory.lua
# ----------------------------------------------------------------------------
$GossipPath      = Join-Path $Root "rozhovory.json"
$GossipLuaPath   = Join-Path $Root "WoWpoCesku\DataRozhovory.lua"
$RemoteGossipUrl = "https://raw.githubusercontent.com/RankonRP/WoWpoCesku/main/rozhovory.json"
$GossipEtagPath  = Join-Path $Root ".rozhovory.etag"

function Get-GossipKey([string]$s) { ($s -replace '\s+', ' ').Trim() }

function ConvertFrom-GossipJson([string]$text) {
    $result = @{}
    $raw = $Json.DeserializeObject($text)
    if ($raw) {
        foreach ($k in $raw.Keys) {
            $h = @{}
            foreach ($f in $raw[$k].Keys) { $h[$f] = [string]$raw[$k][$f] }
            $result[$k] = $h
        }
    }
    return $result
}

$script:Gossip = @{}
if (Test-Path $GossipPath) { $script:Gossip = ConvertFrom-GossipJson ([IO.File]::ReadAllText($GossipPath, [Text.Encoding]::UTF8)) }

function Save-Gossip {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append("{`n")
    $keys = @($script:Gossip.Keys | Sort-Object)
    for ($i = 0; $i -lt $keys.Count; $i++) {
        $entry = New-Object 'System.Collections.Generic.SortedDictionary[string,string]'
        foreach ($f in $script:Gossip[$keys[$i]].Keys) { $entry[$f] = $script:Gossip[$keys[$i]][$f] }
        $comma = if ($i -lt $keys.Count - 1) { "," } else { "" }
        [void]$sb.Append("  $($Json.Serialize($keys[$i])): $($Json.Serialize($entry))$comma`n")
    }
    [void]$sb.Append("}`n")
    [IO.File]::WriteAllText($GossipPath, $sb.ToString(), $Utf8NoBom)
}

function Write-GossipLua {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v rozhovory.json.")
    [void]$sb.AppendLine("WoWpoCesku_Gossip = {")
    foreach ($k in ($script:Gossip.Keys | Sort-Object)) {
        $cs = $script:Gossip[$k]["cs"]
        if ($cs) { [void]$sb.AppendLine("[$(ConvertTo-LuaString $k)]=$(ConvertTo-LuaString $cs),") }
    }
    [void]$sb.AppendLine("}")
    [IO.File]::WriteAllText($GossipLuaPath, $sb.ToString(), $Utf8NoBom)
}

# ----------------------------------------------------------------------------
# Překladače
# ----------------------------------------------------------------------------
function New-WebClient {
    $wc = New-Object System.Net.WebClient
    $wc.Encoding = [Text.Encoding]::UTF8
    $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
    return $wc
}

function Get-WebErrorText($err) {
    $ex = $err.Exception
    while ($ex -and -not ($ex -is [System.Net.WebException])) { $ex = $ex.InnerException }
    if ($ex -and $ex.Response) {
        $reader = New-Object IO.StreamReader($ex.Response.GetResponseStream(), [Text.Encoding]::UTF8)
        return "$($ex.Message) $($reader.ReadToEnd())"
    }
    return $err.Exception.Message
}

function Invoke-GoogleTranslate([string]$text) {
    if ([string]::IsNullOrWhiteSpace($text)) { return $text }
    $wc = New-WebClient
    $wc.Headers.Add("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8")
    $resp = $wc.UploadString("https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=en&tl=cs",
        "q=" + [Uri]::EscapeDataString($text))
    $j = $resp | ConvertFrom-Json
    $first = @($j)[0]
    if ($first -is [array]) { $first = $first[0] }
    return [string]$first
}

function Invoke-ClaudeTranslate($fields) {
    $key = $Settings.claude_api_klic
    if (-not $key) { $key = $env:ANTHROPIC_API_KEY }
    if (-not $key) { throw "Chybí Claude API klíč – doplň ho do nastaveni.json (claude_api_klic)." }
    $model = if ($Settings.claude_model) { $Settings.claude_model } else { "claude-haiku-4-5" }
    $glossary = if (Test-Path $GlossaryPath) { Get-Content $GlossaryPath -Raw -Encoding UTF8 } else { "" }

    $system = @"
Překládáš texty questů z World of Warcraft z angličtiny do češtiny.
Dostaneš JSON objekt, kde každá hodnota je text k překladu. Vrať POUZE JSON objekt se stejnými klíči a přeloženými hodnotami, bez dalšího textu a bez markdownu.
Zachovej zástupný znak {N} (jméno hráče), zalomení řádků a čísla. Překládej přirozeně a čtivě, drž styl fantasy příběhu.
Řiď se tímto slovníčkem a pravidly:
$glossary
"@
    $body = @{
        model      = $model
        max_tokens = 4096
        system     = $system
        messages   = @(@{ role = "user"; content = ($fields | ConvertTo-Json -Depth 3) })
    } | ConvertTo-Json -Depth 6

    $wc = New-WebClient
    $wc.Headers.Add("x-api-key", $key)
    $wc.Headers.Add("anthropic-version", "2023-06-01")
    $wc.Headers.Add("Content-Type", "application/json")
    $resp = $wc.UploadString("https://api.anthropic.com/v1/messages", $body) | ConvertFrom-Json
    $txt = $resp.content[0].text.Trim()
    $txt = $txt -replace '^```(json)?\s*', '' -replace '\s*```$', ''
    $obj = $txt | ConvertFrom-Json
    $out = [ordered]@{}
    foreach ($k in $fields.Keys) { $out[$k] = [string]$obj.$k }
    return $out
}

# Automatické úpravy strojového překladu (pravidla.json – stejná logika jako tools/pravidla.js)
$RulesPath = Join-Path $Root "pravidla.json"
$script:Rules = @()
function Initialize-Rules {
    $script:Rules = @()
    if (-not (Test-Path $RulesPath)) { return }
    $r = Get-Content $RulesPath -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($p in $r.slova.PSObject.Properties) {
        $from = [string]$p.Name; $to = [string]$p.Value
        $variants = @(
            @(($from.Substring(0, 1).ToUpper() + $from.Substring(1)), ($to.Substring(0, 1).ToUpper() + $to.Substring(1))),
            @(($from.Substring(0, 1).ToLower() + $from.Substring(1)), ($to.Substring(0, 1).ToLower() + $to.Substring(1)))
        )
        foreach ($v in $variants) {
            $script:Rules += , @([regex]::new('(?<!\p{L})' + [regex]::Escape($v[0]) + '(?!\p{L})'), $v[1].Replace('$', '$$'))
        }
    }
    foreach ($x in $r.regexy) { $script:Rules += , @([regex]::new([string]$x.hledat), [string]$x.nahradit) }
}
function Invoke-Rules([string]$t) {
    if (-not $t) { return $t }
    foreach ($rule in $script:Rules) { $t = $rule[0].Replace($t, $rule[1]) }
    return $t
}
try { Initialize-Rules } catch { $script:Rules = @() }

function Invoke-Translate($fields) {
    if ($Settings.prekladac -eq "claude") { $out = Invoke-ClaudeTranslate $fields }
    else {
        $out = [ordered]@{}
        foreach ($k in $fields.Keys) { $out[$k] = Invoke-GoogleTranslate $fields[$k] }
    }
    foreach ($k in @($out.Keys)) { $out[$k] = Invoke-Rules $out[$k] }
    return $out
}

# ----------------------------------------------------------------------------
# Zpráva z addonu
#   CZQ#<id>#<detail|progress|reward>[#oprava]    quest
#   CZG#<id NPC>                                   rozhovor s NPC
#   ##title
#   ...
#   ##text   (u rozhovoru ##gossip)
#   ...
# ----------------------------------------------------------------------------
function ConvertFrom-Payload([string]$s) {
    $lines = ($s -replace "`r`n", "`n" -replace "`r", "`n") -split "`n"
    $m = [regex]::Match($lines[0].Trim(), '^CZ([QG])#(\d+)(?:#(\w+))?(#oprava)?$')
    if (-not $m.Success -or $lines.Count -lt 2) { return $null }
    $q = @{
        kind   = $(if ($m.Groups[1].Value -eq "G") { "gossip" } else { "quest" })
        id     = $m.Groups[2].Value
        part   = $m.Groups[3].Value
        oprava = $m.Groups[4].Success
        fields = [ordered]@{}
    }
    $cur = $null
    $buf = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines[1..($lines.Count - 1)]) {
        if ($line -match '^##(title|text|objectives|progress|reward|gossip)\s*$') {
            if ($cur) { $q.fields[$cur] = ($buf -join "`n").Trim() }
            $cur = $Matches[1]
            $buf.Clear()
        } else {
            $buf.Add($line)
        }
    }
    if ($cur) { $q.fields[$cur] = ($buf -join "`n").Trim() }
    return $q
}

# ----------------------------------------------------------------------------
# Okno
# ----------------------------------------------------------------------------
[Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object Windows.Forms.Form
$form.Text = "WoWpoČesku – Pomocník"
$form.Size = New-Object Drawing.Size(500, 620)
$form.StartPosition = "Manual"
$form.Location = New-Object Drawing.Point(([Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - 520), 60)
$form.TopMost = $true
$form.BackColor = [Drawing.Color]::FromArgb(20, 20, 26)

$statusLabel = New-Object Windows.Forms.Label
$statusLabel.Dock = "Bottom"
$statusLabel.Height = 28
$statusLabel.Padding = New-Object Windows.Forms.Padding(8, 6, 8, 0)
$statusLabel.ForeColor = [Drawing.Color]::FromArgb(160, 160, 170)
$statusLabel.Font = New-Object Drawing.Font("Segoe UI", 9)

$topBar = New-Object Windows.Forms.Panel
$topBar.Dock = "Top"
$topBar.Height = 32
$topBar.BackColor = [Drawing.Color]::FromArgb(30, 30, 38)

$chkTop = New-Object Windows.Forms.CheckBox
$chkTop.Text = "Vždy navrchu"
$chkTop.Checked = $true
$chkTop.ForeColor = [Drawing.Color]::White
$chkTop.Location = New-Object Drawing.Point(8, 7)
$chkTop.AutoSize = $true
$chkTop.Add_CheckedChanged({ $form.TopMost = $chkTop.Checked })
$topBar.Controls.Add($chkTop)

$modeLabel = New-Object Windows.Forms.Label
$modeLabel.AutoSize = $true
$modeLabel.ForeColor = [Drawing.Color]::FromArgb(255, 209, 0)
$modeLabel.Location = New-Object Drawing.Point(140, 8)
$modeLabel.Text = "Překladač: " + $(if ($Settings.prekladac -eq "claude") { "Claude ($($Settings.claude_model))" } else { "Google (zdarma)" })
$topBar.Controls.Add($modeLabel)

# Opravit právě zobrazený quest
$btnFix = New-Object Windows.Forms.Button
$btnFix.Text = "Opravit"
$btnFix.Size = New-Object Drawing.Size(80, 24)
$btnFix.Location = New-Object Drawing.Point(395, 4)
$btnFix.Anchor = "Top, Right"
$btnFix.ForeColor = [Drawing.Color]::White
$btnFix.Enabled = $false
$btnFix.Add_Click({
    if ($script:CurrentQ -and -not $script:Busy) {
        $script:Busy = $true
        try { Show-FixDialog $script:CurrentQ $script:CurrentEntry } finally { $script:Busy = $false }
    }
})
$topBar.Controls.Add($btnFix)

$box = New-Object Windows.Forms.RichTextBox
$box.Dock = "Fill"
$box.ReadOnly = $true
$box.BorderStyle = "None"
$box.BackColor = [Drawing.Color]::FromArgb(20, 20, 26)
$box.ForeColor = [Drawing.Color]::FromArgb(240, 235, 220)
$box.Font = New-Object Drawing.Font("Segoe UI", 12)
$box.Padding = New-Object Windows.Forms.Padding(10)

$form.Controls.Add($box)
$form.Controls.Add($topBar)
$form.Controls.Add($statusLabel)

function Add-BoxText([string]$text, [Drawing.Color]$color, [float]$size = 12, [bool]$bold = $false) {
    $box.SelectionStart = $box.TextLength
    $box.SelectionColor = $color
    $style = if ($bold) { [Drawing.FontStyle]::Bold } else { [Drawing.FontStyle]::Regular }
    $box.SelectionFont = New-Object Drawing.Font("Segoe UI", $size, $style)
    $box.AppendText($text)
}

$Gold  = [Drawing.Color]::FromArgb(255, 209, 0)
$CText = [Drawing.Color]::FromArgb(240, 235, 220)
$Grey  = [Drawing.Color]::FromArgb(140, 140, 150)
$Red   = [Drawing.Color]::FromArgb(255, 110, 110)

function Show-Welcome {
    $box.Clear()
    Add-BoxText "WoWpoČesku – Pomocník`n`n" $Gold 16 $true
    Add-BoxText "1. Ve hře otevři quest.`n2. Když ještě není přeložený, addon označí text – zmáčkni Ctrl+C.`n3. Překlad se ukáže tady.`n4. Po /reload ve hře ho uvidíš česky i v addonu.`n`n" $CText 11
    Add-BoxText "Přeložených questů: $($script:Cache.Count)" $Grey 10
}

function Show-Quest($q, $entry) {
    $script:CurrentQ = $q
    $script:CurrentEntry = $entry
    $btnFix.Enabled = $true
    $box.Clear()
    $name = if ($entry["title"]) { $entry["title"] } else { $q.fields["title"] }
    Add-BoxText (($name -replace '\{N\}', 'hrdino' -replace '\{C\}', '(tvá třída)' -replace '\{R\}', '(tvá rasa)') + "`n") $Gold 16 $true
    Add-BoxText "Quest #$($q.id)`n`n" $Grey 9
    foreach ($f in $FieldOrder) {
        if ($f -eq "title" -or -not $q.fields.Contains($f)) { continue }
        if ($FieldLabels[$f] -and $f -ne "text") { Add-BoxText "$($FieldLabels[$f]):`n" $Gold 12 $true }
        Add-BoxText ((($entry[$f]) -replace '\{N\}', 'hrdino' -replace '\{C\}', '(tvá třída)' -replace '\{R\}', '(tvá rasa)') + "`n`n") $CText 12
    }
    $box.SelectionStart = 0
    $box.ScrollToCaret()
}

function Get-Simple([string]$s) { ($s -replace '[\s\p{P}]', '').ToLowerInvariant() }

# ----------------------------------------------------------------------------
# Společná databáze
# ----------------------------------------------------------------------------
function Send-ToSberna($q) {
    if (-not $Settings.prispivat) { return $false }
    return Invoke-SbernaPost "/submit" @{ id = [int]$q.id; client = $Settings.klient_id; fields = $q.fields }
}

# Oprava překladu jednoho pole -> sběrna (schvaluje správce projektu)
function Send-Fix($id, $field, $en, $cs) {
    if (-not $Settings.prispivat) { return $false }
    return Invoke-SbernaPost "/fix" @{ id = [int]$id; client = $Settings.klient_id; field = $field; en = $en; cs = $cs }
}

function Invoke-SbernaPost([string]$path, $data) {
    $bytes = [Text.Encoding]::UTF8.GetBytes(($data | ConvertTo-Json -Depth 3))
    try {
        $req = [Net.HttpWebRequest]::Create("$SbernaUrl$path")
        $req.Method = "POST"
        $req.ContentType = "application/json; charset=utf-8"
        $req.Timeout = 5000
        $req.ContentLength = $bytes.Length
        $stream = $req.GetRequestStream()
        $stream.Write($bytes, 0, $bytes.Length)
        $stream.Close()
        $req.GetResponse().Close()
        return $true
    } catch {
        return $false
    }
}

# Stáhne preklady.json z GitHubu a převezme nové/lepší překlady. Vrací počet změněných questů.
function Update-FromGitHub {
    $req = [Net.HttpWebRequest]::Create($RemoteCacheUrl)
    $req.Timeout = 20000
    $req.UserAgent = "WoWpoCesku-Pomocnik"
    if (Test-Path $EtagPath) { $req.Headers.Add("If-None-Match", ([IO.File]::ReadAllText($EtagPath)).Trim()) }
    try {
        $resp = $req.GetResponse()
    } catch [System.Net.WebException] {
        if ($_.Exception.Response -and [int]$_.Exception.Response.StatusCode -eq 304) { return 0 }
        throw
    }
    $reader = New-Object IO.StreamReader($resp.GetResponseStream(), [Text.Encoding]::UTF8)
    $text = $reader.ReadToEnd()
    $etag = $resp.Headers["ETag"]
    $resp.Close()

    $remote = $Json.DeserializeObject($text)
    $changed = 0
    foreach ($id in $remote.Keys) {
        $h = @{}
        foreach ($k in $remote[$id].Keys) { $h[$k] = [string]$remote[$id][$k] }
        $local = $script:Cache[$id]
        # Lokální překlad z novějšího textu ve hře (jiný anglický originál) ponech, dokud ho nezpracuje sběrna
        $sameSource = $local -and (Get-Simple $local["en_title"]) -eq (Get-Simple $h["en_title"]) -and (Get-Simple $local["en_text"]) -eq (Get-Simple $h["en_text"])
        $useRemote = (-not $local) -or $local["pre"] -eq "1" -or $sameSource
        if (-not $useRemote) { continue }
        # Vlastní oprava čeká na schválení -> nepřepisovat, dokud GitHub nemá stejný text (= schváleno)
        if ($local -and $local["opraveno"] -eq "1") {
            $approved = $true
            foreach ($f in $FieldOrder) { if ($local[$f] -and $local[$f] -ne $h[$f]) { $approved = $false } }
            if (-not $approved) { continue }
        }
        $a = ($h.Keys | Sort-Object | ForEach-Object { "$_=$($h[$_])" }) -join "`n"
        $b = if ($local) { ($local.Keys | Sort-Object | ForEach-Object { "$_=$($local[$_])" }) -join "`n" } else { "" }
        if ($a -ne $b) { $script:Cache[$id] = $h; $changed++ }
    }
    if ($changed -gt 0) { Save-Cache; Write-DataLua }
    if ($etag) { [IO.File]::WriteAllText($EtagPath, $etag, $Utf8NoBom) }
    return $changed
}

# Stáhne rozhovory.json z GitHubu (překlady rozhovorů od ostatních). Vrací počet změn.
function Update-GossipFromGitHub {
    $req = [Net.HttpWebRequest]::Create($RemoteGossipUrl)
    $req.Timeout = 20000
    $req.UserAgent = "WoWpoCesku-Pomocnik"
    if (Test-Path $GossipEtagPath) { $req.Headers.Add("If-None-Match", ([IO.File]::ReadAllText($GossipEtagPath)).Trim()) }
    try {
        $resp = $req.GetResponse()
    } catch [System.Net.WebException] {
        $code = if ($_.Exception.Response) { [int]$_.Exception.Response.StatusCode } else { 0 }
        if ($code -eq 304 -or $code -eq 404) { return 0 }   # beze změny / na GitHubu ještě není
        throw
    }
    $reader = New-Object IO.StreamReader($resp.GetResponseStream(), [Text.Encoding]::UTF8)
    $remote = ConvertFrom-GossipJson $reader.ReadToEnd()
    $etag = $resp.Headers["ETag"]
    $resp.Close()
    $changed = 0
    foreach ($k in $remote.Keys) {
        $local = $script:Gossip[$k]
        if (-not $local -or $local["cs"] -ne $remote[$k]["cs"]) { $script:Gossip[$k] = $remote[$k]; $changed++ }
    }
    if ($changed -gt 0) { Save-Gossip; Write-GossipLua }
    if ($etag) { [IO.File]::WriteAllText($GossipEtagPath, $etag, $Utf8NoBom) }
    return $changed
}

# ----------------------------------------------------------------------------
# Automatické aktualizace addonu a Pomocníka z GitHubu
# (ve vývojové kopii s .git se nepoužívají – tam se aktualizuje přes git)
# ----------------------------------------------------------------------------
$VersionPath      = Join-Path $Root "verze.txt"
$RemoteVersionUrl = "https://raw.githubusercontent.com/RankonRP/WoWpoCesku/main/verze.txt"
$UpdateZipUrl     = "https://codeload.github.com/RankonRP/WoWpoCesku/zip/refs/heads/main"

function Get-LocalVersion {
    if (Test-Path $VersionPath) { return ([IO.File]::ReadAllLines($VersionPath)[0]).Trim() }
    return "0.0.0"
}

# Vrací @{ version; restartGame } když je na GitHubu novější verze, jinak $null
function Test-AppUpdate {
    if (Test-Path (Join-Path $Root ".git")) { return $null }
    $wc = New-WebClient
    $lines = $wc.DownloadString("$RemoteVersionUrl`?t=$([DateTime]::UtcNow.Ticks)") -split "`r?`n"
    $remote = $lines[0].Trim()
    if ([version]$remote -gt [version](Get-LocalVersion)) {
        return @{ version = $remote; restartGame = ($lines -contains "restartovat-hru") }
    }
    return $null
}

function Install-AppUpdate {
    $tmp = Join-Path $env:TEMP ("wowpocesku-" + [guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $tmp | Out-Null
    $zip = Join-Path $tmp "update.zip"
    (New-WebClient).DownloadFile($UpdateZipUrl, $zip)
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [IO.Compression.ZipFile]::ExtractToDirectory($zip, $tmp)
    $src = (Get-ChildItem $tmp -Directory | Select-Object -First 1).FullName

    # Data a nastavení hráče nepřepisovat (překlady se stahují zvlášť), jen doplnit, když chybí
    $dataFiles = @("preklady.json", "rozhovory.json", "nastaveni.json", "WoWpoCesku\Data.lua", "WoWpoCesku\DataRozhovory.lua")
    $skipDirs = @("sberna", "tools", ".github")
    foreach ($f in Get-ChildItem $src -Recurse -File) {
        $rel = $f.FullName.Substring($src.Length + 1)
        if ($skipDirs -contains $rel.Split('\')[0]) { continue }
        $dest = Join-Path $Root $rel
        if (($dataFiles -contains $rel) -and (Test-Path $dest)) { continue }
        New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
        Copy-Item $f.FullName $dest -Force
    }
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
}

function Restart-Helper {
    Start-Process powershell.exe -ArgumentList '-NoProfile', '-STA', '-ExecutionPolicy', 'Bypass', '-WindowStyle', 'Hidden', '-File', "`"$(Join-Path $Root 'pomocnik.ps1')`""
    $form.Close()
}

# ----------------------------------------------------------------------------
# Mezipaměť questů hry (Cache\WDB\enUS\questcache.wdb) – stejná logika jako tools/wdb.js.
# Hra si do ní ukládá název, úkol a zadání každého questu, o kterém ví (i bez otevření),
# takže Pomocník nové questy najde a pošle sám, bez Ctrl+C.
# ----------------------------------------------------------------------------
if (-not ("WdbReader" -as [type])) {
    Add-Type -Language CSharp -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Text;
public static class WdbReader {
    static readonly int[] Bits = { 9, 12, 12, 9, 10, 8, 10, 8, 11 };
    public static Dictionary<string, string[]> Read(string path) {
        var b = System.IO.File.ReadAllBytes(path);
        var res = new Dictionary<string, string[]>();
        if (b.Length < 24 || b[0] != 'T' || b[1] != 'S' || b[2] != 'Q' || b[3] != 'W') return res;
        int o = 24;
        while (o + 8 <= b.Length) {
            int id = BitConverter.ToInt32(b, o), len = BitConverter.ToInt32(b, o + 4);
            if (len <= 0 || o + 8 + len > b.Length) break;
            var r = Parse(b, o + 8, len);
            if (r != null) res[id.ToString()] = r;
            o += 8 + len;
        }
        return res;
    }
    static string[] Parse(byte[] b, int start, int len) {
        var utf8 = new UTF8Encoding(false, true);
        for (int p = 0; p + 12 < len; p++) {
            var L = new int[9]; int bit = 0;
            for (int k = 0; k < 9; k++) {
                int v = 0;
                for (int i = 0; i < Bits[k]; i++, bit++) v = (v << 1) | ((b[start + p + (bit >> 3)] >> (7 - (bit & 7))) & 1);
                L[k] = v;
            }
            if (L[0] < 2 || L[0] > 300) continue;
            int s = start + p + 12, total = 0;
            foreach (var x in L) total += x;
            if (s + total > start + len) continue;
            var strs = new string[9]; int oo = s; bool ok = true;
            for (int k = 0; k < 9; k++) {
                strs[k] = "";
                if (L[k] > 0) {
                    try { strs[k] = utf8.GetString(b, oo, L[k]); } catch { ok = false; break; }
                    if (!Printable(strs[k])) { ok = false; break; }
                }
                oo += L[k];
            }
            if (!ok) continue;
            char c0 = strs[0][0];
            if (!(char.IsLetterOrDigit(c0) || c0 == '"' || c0 == '\'' || c0 == '(' || c0 == '[')) continue;
            return new[] { strs[0], strs[1], strs[2] };
        }
        return null;
    }
    static bool Printable(string s) {
        foreach (char c in s) if ((c < 32 && c != '\n' && c != '\r' && c != '\t') || c == '�') return false;
        return true;
    }
}
'@
}

# Zástupné znaky serveru -> naše značky
function ConvertFrom-ServerText([string]$t) {
    $t = $t -replace "`r`n?", "`n" -replace '\$[Bb]', "`n" -replace '\$[Nn]', '{N}' -replace '\$[Cc]', '{C}' -replace '\$[Rr]', '{R}'
    $t = $t -replace '\$[Gg]\s*([^:;]*):([^;]*);', '$1/$2'
    return $t.Trim()
}

# Složka hry (…\World of Warcraft\_classic_beta_): z nastavení, jinak ji najít podle propojeného addonu
function Find-GameFolder {
    if ($Settings.slozka_hry -and (Test-Path (Join-Path $Settings.slozka_hry "Cache"))) { return $Settings.slozka_hry }
    $bases = foreach ($d in (Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue)) {
        foreach ($sub in "World of Warcraft", "Program Files (x86)\World of Warcraft", "Program Files\World of Warcraft", "Games\World of Warcraft", "Hry\World of Warcraft") {
            Join-Path $d.Root $sub
        }
    }
    foreach ($base in $bases) {
        if (-not (Test-Path $base)) { continue }
        foreach ($flavor in Get-ChildItem $base -Directory -Filter "_*_" -ErrorAction SilentlyContinue) {
            $link = Join-Path $flavor.FullName "Interface\AddOns\WoWpoCesku"
            if (Test-Path $link) {
                Set-Setting "slozka_hry" $flavor.FullName
                Save-Settings
                return $flavor.FullName
            }
        }
    }
    return $null
}

# Projde mezipaměť: nové questy pošle do sběrny (max $maxSend) a pár rovnou přeloží (max $maxTranslate).
# Vrací @{ translated; sent; left } nebo $null, když se mezipaměť od minula nezměnila.
function Import-GameCache([int]$maxTranslate = 20, [int]$maxSend = 100) {
    $game = Find-GameFolder
    if (-not $game) { return $null }
    $file = Join-Path $game "Cache\WDB\enUS\questcache.wdb"
    if (-not (Test-Path $file)) { return $null }
    $stamp = [string](Get-Item $file).LastWriteTimeUtc.Ticks
    if ($Settings.cache_cas -eq $stamp) { return $null }

    $sentPath = Join-Path $Root ".cache-odeslano"
    $sent = New-Object 'System.Collections.Generic.HashSet[string]'
    if (Test-Path $sentPath) { foreach ($l in [IO.File]::ReadAllLines($sentPath)) { [void]$sent.Add($l) } }

    $quests = [WdbReader]::Read($file)
    $translated = 0; $sentN = 0; $left = 0
    foreach ($id in $quests.Keys) {
        $raw = $quests[$id]
        $fields = [ordered]@{ title = (ConvertFrom-ServerText $raw[0]); objectives = (ConvertFrom-ServerText $raw[1]); text = (ConvertFrom-ServerText $raw[2]) }
        $entry = $script:Cache[$id]
        $missing = [ordered]@{}
        foreach ($k in $fields.Keys) { if ($fields[$k] -and (-not $entry -or -not $entry[$k])) { $missing[$k] = $fields[$k] } }
        if ($missing.Count -eq 0) { continue }

        if ($Settings.prispivat -and -not $sent.Contains($id) -and $sentN -lt $maxSend) {
            $body = [ordered]@{}
            foreach ($k in $fields.Keys) { if ($fields[$k]) { $body[$k] = $fields[$k] } }
            if (Invoke-SbernaPost "/submit" @{ id = [int]$id; client = $Settings.klient_id; fields = $body }) { [void]$sent.Add($id); $sentN++ }
        }
        if ($translated -lt $maxTranslate) {
            $tr = Invoke-Translate $missing
            if (-not $entry) { $entry = @{}; $script:Cache[$id] = $entry }
            foreach ($k in $missing.Keys) { $entry[$k] = $tr[$k]; $entry["en_$k"] = $missing[$k] }
            if (-not $entry["src"]) { $entry["src"] = "cache" }
            $translated++
        } else {
            $left++
        }
    }
    if ($translated -gt 0) { Save-Cache; Write-DataLua }
    [IO.File]::WriteAllLines($sentPath, [string[]]@($sent), $Utf8NoBom)
    # Když zbylo nepřeložené, příště se mezipaměť projde znovu
    if ($left -eq 0) { Set-Setting "cache_cas" $stamp; Save-Settings }
    return @{ translated = $translated; sent = $sentN; left = $left }
}

function Show-Gossip($q, [string]$cs) {
    $script:CurrentQ = $null
    $btnFix.Enabled = $false
    $box.Clear()
    Add-BoxText ($q.fields["title"] + "`n") $Gold 16 $true
    Add-BoxText $(if ([int]$q.id -eq 1) { "Kniha / dopis`n`n" } else { "Rozhovor s NPC #$($q.id)`n`n" }) $Grey 9
    Add-BoxText (($cs -replace '\{N\}', 'hrdino' -replace '\{C\}', '(tvá třída)' -replace '\{R\}', '(tvá rasa)') + "`n") $CText 12
    $box.SelectionStart = 0
    $box.ScrollToCaret()
}

function Invoke-Gossip($q) {
    $en = $q.fields["gossip"]
    if (-not $en) { return }
    $key = Get-GossipKey $en
    $entry = $script:Gossip[$key]
    if ($entry -and $entry["cs"]) {
        $statusLabel.Text = "Z uložených překladů. (Pokud ho addon neukazuje, napiš ve hře /reload.)"
    } else {
        $statusLabel.Text = "Překládám rozhovor…"
        [Windows.Forms.Application]::DoEvents()
        $tr = Invoke-Translate ([ordered]@{ gossip = $en })
        $entry = @{ cs = $tr["gossip"]; en = $en; npc = [string]$q.id; src = "lokalne" }
        $script:Gossip[$key] = $entry
        Save-Gossip
        Write-GossipLua
        $sent = ""
        if ([int]$q.id -gt 0 -and $Settings.prispivat -and (Invoke-SbernaPost "/submit" @{ id = [int]$q.id; client = $Settings.klient_id; fields = @{ gossip = $en } })) {
            $sent = " Odesláno do společné sbírky."
        }
        $statusLabel.Text = "Uloženo ($($script:Gossip.Count) rozhovorů). Ve hře napiš /reload.$sent"
    }
    Show-Gossip $q $entry["cs"]
}

function Invoke-Quest([string]$clip) {
    $q = ConvertFrom-Payload $clip
    if (-not $q) { return }
    if ($q.kind -eq "gossip") { Invoke-Gossip $q; return }

    $entry = $script:Cache[$q.id]
    if (-not $entry) { $entry = @{}; $script:Cache[$q.id] = $entry }

    $missing = [ordered]@{}
    foreach ($k in $q.fields.Keys) {
        if (-not $q.fields[$k]) { continue }
        # Chybí překlad, nebo se anglický text ve hře liší od toho, ze kterého se překládalo
        if (-not $entry[$k] -or (Get-Simple $entry["en_$k"]) -ne (Get-Simple $q.fields[$k])) { $missing[$k] = $q.fields[$k] }
    }

    if ($missing.Count -gt 0) {
        $statusLabel.Text = "Překládám quest #$($q.id)…"
        [Windows.Forms.Application]::DoEvents()
        $tr = Invoke-Translate $missing
        foreach ($k in $missing.Keys) {
            $entry[$k] = $tr[$k]
            $entry["en_$k"] = $missing[$k]
        }
        Save-Cache
        Write-DataLua
        $sent = if (Send-ToSberna $q) { " Odesláno do společné sbírky." } else { "" }
        $statusLabel.Text = "Uloženo ($($script:Cache.Count) questů). Ve hře napiš /reload.$sent"
    } else {
        $statusLabel.Text = "Z uložených překladů. (Pokud ho addon neukazuje, napiš ve hře /reload.)"
    }
    Show-Quest $q $entry
    if ($q.oprava) { Show-FixDialog $q $entry }
}

# ----------------------------------------------------------------------------
# Oprava překladu
# ----------------------------------------------------------------------------
function Show-FixDialog($q, $entry) {
    $dlg = New-Object Windows.Forms.Form
    $dlg.Text = "Opravit překlad – quest #$($q.id)"
    $dlg.Size = New-Object Drawing.Size(720, 700)
    $dlg.StartPosition = "CenterScreen"
    $dlg.TopMost = $true
    $dlg.BackColor = [Drawing.Color]::FromArgb(20, 20, 26)
    $dlg.ForeColor = $CText
    $dlg.Font = New-Object Drawing.Font("Segoe UI", 10)

    $flow = New-Object Windows.Forms.FlowLayoutPanel
    $flow.Dock = "Fill"
    $flow.FlowDirection = "TopDown"
    $flow.WrapContents = $false
    $flow.AutoScroll = $true
    $flow.Padding = New-Object Windows.Forms.Padding(12)

    $info = New-Object Windows.Forms.Label
    $info.AutoSize = $true
    $info.MaximumSize = New-Object Drawing.Size(650, 0)
    $info.ForeColor = $Grey
    $info.Text = "Uprav český text. Značky {N}, {C} a {R} nech – hra za ně dosadí jméno, třídu a rasu postavy. " +
        "Oprava se hned uloží u tebe a pošle se ke schválení, aby ji dostali i ostatní."
    $flow.Controls.Add($info)

    $boxes = [ordered]@{}
    foreach ($f in $FieldOrder) {
        if (-not $q.fields.Contains($f)) { continue }
        $lbl = New-Object Windows.Forms.Label
        $lbl.AutoSize = $true
        $lbl.ForeColor = $Gold
        $lbl.Font = New-Object Drawing.Font("Segoe UI", 11, [Drawing.FontStyle]::Bold)
        $lbl.Margin = New-Object Windows.Forms.Padding(0, 14, 0, 4)
        $lbl.Text = $FieldLabels[$f]
        $flow.Controls.Add($lbl)

        $lines = [Math]::Max(1, [Math]::Ceiling($q.fields[$f].Length / 85) + ($q.fields[$f] -split "`n").Count - 1)
        $en = New-Object Windows.Forms.TextBox
        $en.Multiline = $true
        $en.ReadOnly = $true
        $en.ScrollBars = "Vertical"
        $en.Width = 650
        $en.Height = [Math]::Min(110, 10 + 19 * $lines)
        $en.BackColor = [Drawing.Color]::FromArgb(32, 32, 40)
        $en.ForeColor = $Grey
        $en.BorderStyle = "None"
        $en.Text = $q.fields[$f] -replace "`r?`n", "`r`n"
        $flow.Controls.Add($en)

        $cs = New-Object Windows.Forms.TextBox
        $cs.Multiline = $true
        $cs.AcceptsReturn = $true
        $cs.ScrollBars = "Vertical"
        $cs.Width = 650
        $cs.Height = [Math]::Min(170, 16 + 22 * $lines)
        $cs.BackColor = [Drawing.Color]::FromArgb(40, 40, 50)
        $cs.ForeColor = $CText
        $cs.Font = New-Object Drawing.Font("Segoe UI", 11)
        $cs.Text = ([string]$entry[$f]) -replace "`r?`n", "`r`n"
        $flow.Controls.Add($cs)
        $boxes[$f] = $cs
    }

    $buttons = New-Object Windows.Forms.FlowLayoutPanel
    $buttons.Dock = "Bottom"
    $buttons.Height = 48
    $buttons.FlowDirection = "RightToLeft"
    $buttons.Padding = New-Object Windows.Forms.Padding(8)
    $save = New-Object Windows.Forms.Button
    $save.Text = "Uložit opravu"
    $save.AutoSize = $true
    $save.BackColor = [Drawing.Color]::FromArgb(60, 110, 60)
    $save.ForeColor = [Drawing.Color]::White
    $save.DialogResult = "OK"
    $cancel = New-Object Windows.Forms.Button
    $cancel.Text = "Zrušit"
    $cancel.AutoSize = $true
    $cancel.ForeColor = [Drawing.Color]::White
    $cancel.DialogResult = "Cancel"
    $buttons.Controls.Add($save)
    $buttons.Controls.Add($cancel)

    $dlg.Controls.Add($flow)
    $dlg.Controls.Add($buttons)
    $dlg.CancelButton = $cancel

    if ($dlg.ShowDialog($form) -ne "OK") { $statusLabel.Text = "Oprava zrušena."; return }

    $changed = @()
    foreach ($f in $boxes.Keys) {
        $new = ($boxes[$f].Text -replace "`r`n", "`n").Trim()
        if ($new -and $new -ne $entry[$f]) {
            $entry[$f] = $new
            $entry["en_$f"] = $q.fields[$f]
            $changed += $f
        }
    }
    if (-not $changed) { $statusLabel.Text = "Beze změny."; return }

    $entry["opraveno"] = "1"
    Save-Cache
    Write-DataLua
    $sent = 0
    foreach ($f in $changed) { if (Send-Fix $q.id $f $q.fields[$f] $entry[$f]) { $sent++ } }
    Show-Quest $q $entry
    $statusLabel.Text = "Oprava uložena – ve hře napiš /reload." + $(if ($sent) { " Odesláno ke schválení." } else { "" })
}

# ----------------------------------------------------------------------------
# Hlídání schránky
# ----------------------------------------------------------------------------
$script:LastClip = ""
$script:Busy = $false

$timer = New-Object Windows.Forms.Timer
$timer.Interval = 300
$timer.Add_Tick({
    if ($script:Busy) { return }
    try { $clip = [Windows.Forms.Clipboard]::GetText() } catch { return }
    if (-not $clip -or $clip -eq $script:LastClip) { return }
    $script:LastClip = $clip
    if (-not ($clip.StartsWith("CZQ#") -or $clip.StartsWith("CZG#"))) { return }
    $script:Busy = $true
    try {
        Invoke-Quest $clip
    } catch {
        $msg = Get-WebErrorText $_
        $box.Clear()
        Add-BoxText "Překlad se nepovedl`n`n" $Red 14 $true
        Add-BoxText $msg $CText 10
        $statusLabel.Text = "Chyba – zkus quest zkopírovat znovu."
        $script:LastClip = ""
    } finally {
        $script:Busy = $false
    }
})

# Při startu přegeneruj Data.lua (propíšou se ruční opravy v preklady.json)
try { Write-DataLua } catch { }
try { Write-GossipLua } catch { }
Show-Welcome
$statusLabel.Text = "Čekám na quest ze hry…"
$timer.Start()

$form.Add_Shown({
    # První spuštění: zeptat se na přispívání do společné databáze
    if ($null -eq $Settings.prispivat) {
        $answer = [Windows.Forms.MessageBox]::Show($form,
            "Chceš pomáhat s překladem pro ostatní hráče?`n`n" +
            "Když narazíš na nepřeložený quest, Pomocník pošle jeho ANGLICKÝ text do společné sbírky. " +
            "Nic osobního se neposílá – jméno, třída a rasa postavy jsou nahrazené značkami.`n`n" +
            "Přeložené questy pak dostanou všichni hráči.`n`n" +
            "Volbu můžeš kdykoli změnit v souboru nastaveni.json (prispivat).",
            "WoWpoČesku – společná databáze", "YesNo", "Question")
        Set-Setting "prispivat" ($answer -eq "Yes")
        Save-Settings
    }
    # Nová verze addonu / Pomocníka?
    $statusLabel.Text = "Kontroluji novou verzi…"
    [Windows.Forms.Application]::DoEvents()
    try {
        $upd = Test-AppUpdate
        if ($upd) {
            $answer = [Windows.Forms.MessageBox]::Show($form,
                "Je k dispozici nová verze WoWpoČesku $($upd.version) (máš $(Get-LocalVersion)).`n`nAktualizovat teď? Trvá to pár vteřin, tvoje překlady a nastavení zůstanou.",
                "WoWpoČesku – aktualizace", "YesNo", "Question")
            if ($answer -eq "Yes") {
                $statusLabel.Text = "Stahuji novou verzi…"
                [Windows.Forms.Application]::DoEvents()
                Install-AppUpdate
                $inGame = if ($upd.restartGame) { "Pokud máš spuštěnou hru, RESTARTUJ ji (/reload tentokrát nestačí)." } else { "Pokud máš spuštěnou hru, napiš ve hře /reload." }
                [void][Windows.Forms.MessageBox]::Show($form, "Aktualizováno na verzi $($upd.version).`n`n$inGame`n`nPomocník se teď sám restartuje.", "WoWpoČesku – hotovo", "OK", "Information")
                Restart-Helper
                return
            }
        }
    } catch {
        # offline nebo GitHub nedostupný – aktualizace se zkusí příště
    }

    # Stáhnout nové překlady od ostatních hráčů
    $statusLabel.Text = "Kontroluji nové překlady na GitHubu…"
    [Windows.Forms.Application]::DoEvents()
    try {
        $n = Update-FromGitHub
        try { $n += Update-GossipFromGitHub } catch { }
        $statusLabel.Text = if ($n -gt 0) { "Staženo $n nových/lepších překladů. Ve hře napiš /reload." } else { "Překlady jsou aktuální. Čekám na quest ze hry…" }
        if ($n -gt 0) { Show-Welcome }
    } catch {
        $statusLabel.Text = "Nové překlady se nepodařilo stáhnout (offline?). Čekám na quest ze hry…"
    }

    # Nové questy z mezipaměti hry (bez Ctrl+C)
    $prev = $statusLabel.Text
    try {
        $statusLabel.Text = "Hledám nové questy v mezipaměti hry…"
        [Windows.Forms.Application]::DoEvents()
        $c = Import-GameCache
        if ($c -and ($c.translated -gt 0 -or $c.sent -gt 0)) {
            $statusLabel.Text = "Z mezipaměti hry: přeloženo $($c.translated), odesláno $($c.sent) questů. Ve hře napiš /reload."
            Show-Welcome
        } else {
            $statusLabel.Text = $prev
        }
    } catch {
        $statusLabel.Text = $prev
    }
    $syncTimer.Start()
})

# Každou hodinu zkontrolovat nové překlady (i když Pomocník běží celý den).
# Když nic nového není, nic se nemění – zobrazený quest ani stavový řádek se nepřepíšou.
$syncTimer = New-Object Windows.Forms.Timer
$syncTimer.Interval = 60 * 60 * 1000
$syncTimer.Add_Tick({
    if ($script:Busy) { return }
    $script:Busy = $true
    try {
        $n = Update-FromGitHub
        try { $n += Update-GossipFromGitHub } catch { }
        if ($n -gt 0) { $statusLabel.Text = "$(Get-Date -Format 'HH:mm') – staženo $n nových překladů. Ve hře napiš /reload." }
        try {
            $c = Import-GameCache
            if ($c -and ($c.translated -gt 0 -or $c.sent -gt 0)) {
                $statusLabel.Text = "$(Get-Date -Format 'HH:mm') – z mezipaměti hry přeloženo $($c.translated), odesláno $($c.sent) questů. Ve hře napiš /reload."
            }
        } catch { }
        # Nová verze programu jen oznámit (instalace proběhne při dalším spuštění Pomocníka)
        try {
            $upd = Test-AppUpdate
            if ($upd) { $statusLabel.Text = "Je nová verze $($upd.version) – zavři a znovu spusť Pomocníka." }
        } catch { }
    } catch {
        # offline – zkusí se to za hodinu znovu
    } finally {
        $script:Busy = $false
    }
})

[void]$form.ShowDialog()
$timer.Stop()
$syncTimer.Stop()
