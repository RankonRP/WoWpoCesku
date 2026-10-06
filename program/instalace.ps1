# Propojí složku WoWpoCesku do WoW (Interface\AddOns) pomocí "junction" odkazu.
# Soubory zůstávají tady – Pomocník zapisuje překlady a hra je rovnou vidí.

Add-Type -AssemblyName System.Windows.Forms
$Root = Split-Path $PSScriptRoot -Parent   # hlavní složka projektu (skript je ve složce program\)
$source = Join-Path $Root "WoWpoCesku"

# Složka hry = ta, ve které je .flavor.info nebo Wow*.exe (např. ...\World of Warcraft\_classic_beta_)
function Test-GameFolder([string]$path) {
    if (-not (Test-Path $path -PathType Container)) { return $false }
    if (Test-Path (Join-Path $path ".flavor.info")) { return $true }
    return [bool](Get-ChildItem $path -Filter "Wow*.exe" -File -ErrorAction SilentlyContinue | Select-Object -First 1)
}

function Get-FlavorName([string]$path) {
    $f = Join-Path $path ".flavor.info"
    if (Test-Path $f) { return ((Get-Content $f) | Select-Object -Last 1).Trim() }
    return "?"
}

Write-Host "Vyber složku, kde máš nainstalovaný World of Warcraft." -ForegroundColor Yellow
Write-Host "(Stačí hlavní složka 'World of Warcraft' – správnou verzi hry najdu sám.)" -ForegroundColor Yellow

$dlg = New-Object System.Windows.Forms.FolderBrowserDialog
$dlg.Description = "Vyber složku World of Warcraft (nebo přímo _classic_beta_)"
if ($dlg.ShowDialog() -ne "OK") { Write-Host "Zrušeno."; exit }
$picked = $dlg.SelectedPath

# Když uživatel vybral Interface nebo AddOns, vrať se nahoru ke složce hry
$candidate = $picked
while ($candidate -and (Split-Path $candidate -Leaf) -in @("AddOns", "Interface")) { $candidate = Split-Path $candidate -Parent }

if (Test-GameFolder $candidate) {
    $game = $candidate
} else {
    # Hlavní složka WoW: najdi v ní verze hry (_classic_beta_, _classic_era_, _retail_ …)
    $flavors = @(Get-ChildItem $candidate -Directory -ErrorAction SilentlyContinue | Where-Object { Test-GameFolder $_.FullName })
    if ($flavors.Count -eq 0) {
        Write-Host ""
        Write-Host "Ve vybrané složce jsem nenašel WoW:" -ForegroundColor Red
        Write-Host "  $picked"
        Write-Host "Vyber složku 'World of Warcraft' (obsahuje podsložku jako _classic_beta_) a spusť instalaci znovu."
        exit
    }
    if ($flavors.Count -eq 1) {
        $game = $flavors[0].FullName
    } else {
        # Víc verzí hry – Forever beta má přednost, jinak se zeptat
        $beta = $flavors | Where-Object { $_.Name -eq "_classic_beta_" } | Select-Object -First 1
        if ($beta) {
            $game = $beta.FullName
        } else {
            Write-Host ""
            Write-Host "Našel jsem víc verzí hry:" -ForegroundColor Yellow
            for ($i = 0; $i -lt $flavors.Count; $i++) { Write-Host ("  {0}) {1}  ({2})" -f ($i + 1), $flavors[$i].Name, (Get-FlavorName $flavors[$i].FullName)) }
            $n = Read-Host "Napiš číslo verze, do které se má addon nainstalovat"
            if (-not ($n -as [int]) -or [int]$n -lt 1 -or [int]$n -gt $flavors.Count) { Write-Host "Neplatná volba."; exit }
            $game = $flavors[[int]$n - 1].FullName
        }
    }
}

Write-Host ""
Write-Host "Složka hry: $game  ($(Get-FlavorName $game))" -ForegroundColor Cyan

# Zapamatovat složku hry pro Pomocníka (čte z ní mezipaměť questů)
$settingsPath = Join-Path $Root "nastaveni\nastaveni.json"
if (-not (Test-Path (Split-Path $settingsPath))) { [void](New-Item -ItemType Directory -Force (Split-Path $settingsPath)) }
$examplePath = Join-Path $Root "nastaveni\nastaveni.example.json"
if (-not (Test-Path $settingsPath) -and (Test-Path $examplePath)) { Copy-Item $examplePath $settingsPath }
if (Test-Path $settingsPath) {
    $s = Get-Content $settingsPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($s.PSObject.Properties["slozka_hry"]) { $s.slozka_hry = $game } else { $s | Add-Member -NotePropertyName slozka_hry -NotePropertyValue $game }
    [IO.File]::WriteAllText($settingsPath, ($s | ConvertTo-Json), (New-Object System.Text.UTF8Encoding $false))
}

$addons = Join-Path $game "Interface\AddOns"
New-Item -ItemType Directory -Force $addons | Out-Null

$target = Join-Path $addons "WoWpoCesku"
if (Test-Path $target) {
    $item = Get-Item $target -Force
    if ($item.LinkType -eq "Junction" -and "$($item.Target)" -eq $source) {
        Write-Host "Addon už je nainstalovaný a propojený správně." -ForegroundColor Green
        exit
    }
    Write-Host "Ve hře už složka WoWpoCesku existuje: $target" -ForegroundColor Red
    Write-Host "Pokud je to stará kopie, smaž ji a spusť instalaci znovu."
    exit
}

New-Item -ItemType Junction -Path $target -Target $source | Out-Null
Write-Host ""
Write-Host "Hotovo! Addon je propojený:" -ForegroundColor Green
Write-Host "  $target"
Write-Host ""
Write-Host "Spusť hru – na výběru postavy vlevo dole je tlačítko AddOns, kde musí být WoWpoCesku zaškrtnutý."
