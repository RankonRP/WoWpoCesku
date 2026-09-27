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
        if ($parts) { [void]$sb.AppendLine("[$id]={" + ($parts -join ",") + "},") }
    }
    [void]$sb.AppendLine("}")
    [IO.File]::WriteAllText($DataLuaPath, $sb.ToString(), $Utf8NoBom)
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

function Invoke-Translate($fields) {
    if ($Settings.prekladac -eq "claude") { return Invoke-ClaudeTranslate $fields }
    $out = [ordered]@{}
    foreach ($k in $fields.Keys) { $out[$k] = Invoke-GoogleTranslate $fields[$k] }
    return $out
}

# ----------------------------------------------------------------------------
# Zpráva z addonu
#   CZQ#<id>#<detail|progress|reward>
#   ##title
#   ...
#   ##text
#   ...
# ----------------------------------------------------------------------------
function ConvertFrom-Payload([string]$s) {
    $lines = ($s -replace "`r`n", "`n" -replace "`r", "`n") -split "`n"
    $m = [regex]::Match($lines[0].Trim(), '^CZQ#(\d+)#(\w+)$')
    if (-not $m.Success -or $lines.Count -lt 2) { return $null }
    $q = @{ id = $m.Groups[1].Value; part = $m.Groups[2].Value; fields = [ordered]@{} }
    $cur = $null
    $buf = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines[1..($lines.Count - 1)]) {
        if ($line -match '^##(title|text|objectives|progress|reward)\s*$') {
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
    $body = @{ id = [int]$q.id; client = $Settings.klient_id; fields = $q.fields } | ConvertTo-Json -Depth 3
    $bytes = [Text.Encoding]::UTF8.GetBytes($body)
    try {
        $req = [Net.HttpWebRequest]::Create("$SbernaUrl/submit")
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
        $a = ($h.Keys | Sort-Object | ForEach-Object { "$_=$($h[$_])" }) -join "`n"
        $b = if ($local) { ($local.Keys | Sort-Object | ForEach-Object { "$_=$($local[$_])" }) -join "`n" } else { "" }
        if ($a -ne $b) { $script:Cache[$id] = $h; $changed++ }
    }
    if ($changed -gt 0) { Save-Cache; Write-DataLua }
    if ($etag) { [IO.File]::WriteAllText($EtagPath, $etag, $Utf8NoBom) }
    return $changed
}

function Invoke-Quest([string]$clip) {
    $q = ConvertFrom-Payload $clip
    if (-not $q) { return }

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
    if (-not $clip.StartsWith("CZQ#")) { return }
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
    # Stáhnout nové překlady od ostatních hráčů
    $statusLabel.Text = "Kontroluji nové překlady na GitHubu…"
    [Windows.Forms.Application]::DoEvents()
    try {
        $n = Update-FromGitHub
        $statusLabel.Text = if ($n -gt 0) { "Staženo $n nových/lepších překladů. Ve hře napiš /reload." } else { "Překlady jsou aktuální. Čekám na quest ze hry…" }
        if ($n -gt 0) { Show-Welcome }
    } catch {
        $statusLabel.Text = "Nové překlady se nepodařilo stáhnout (offline?). Čekám na quest ze hry…"
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
        if ($n -gt 0) { $statusLabel.Text = "$(Get-Date -Format 'HH:mm') – staženo $n nových překladů. Ve hře napiš /reload." }
    } catch {
        # offline – zkusí se to za hodinu znovu
    } finally {
        $script:Busy = $false
    }
})

[void]$form.ShowDialog()
$timer.Stop()
$syncTimer.Stop()
