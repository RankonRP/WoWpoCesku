# Propojí složku WoWpoCesku do WoW (Interface\AddOns) pomocí "junction" odkazu.
# Soubory zůstávají tady – Pomocník zapisuje překlady a hra je rovnou vidí.

Add-Type -AssemblyName System.Windows.Forms
$source = Join-Path $PSScriptRoot "WoWpoCesku"

Write-Host "Vyber složku hry WoW Forever (např. ...\World of Warcraft\_classic_beta_ – u beta verze Forever)" -ForegroundColor Yellow
Write-Host "nebo rovnou její podsložku Interface\AddOns." -ForegroundColor Yellow

$dlg = New-Object System.Windows.Forms.FolderBrowserDialog
$dlg.Description = "Vyber složku WoW Forever (s podsložkou Interface) nebo přímo Interface\AddOns"
if ($dlg.ShowDialog() -ne "OK") { Write-Host "Zrušeno."; exit }
$picked = $dlg.SelectedPath

if ((Split-Path $picked -Leaf) -ieq "AddOns") {
    $addons = $picked
} elseif ((Split-Path $picked -Leaf) -ieq "Interface") {
    $addons = Join-Path $picked "AddOns"
} else {
    $addons = Join-Path $picked "Interface\AddOns"
}
New-Item -ItemType Directory -Force $addons | Out-Null

$target = Join-Path $addons "WoWpoCesku"
if (Test-Path $target) {
    Write-Host "Ve WoW už složka WoWpoCesku existuje: $target" -ForegroundColor Red
    Write-Host "Pokud je to stará kopie, smaž ji a spusť instalaci znovu."
    exit
}

New-Item -ItemType Junction -Path $target -Target $source | Out-Null
Write-Host ""
Write-Host "Hotovo! Addon je propojený:" -ForegroundColor Green
Write-Host "  $target  ->  $source"
Write-Host ""
Write-Host "Ve hře zapni addon WoWpoCesku (tlačítko AddOns na obrazovce výběru postavy)."
