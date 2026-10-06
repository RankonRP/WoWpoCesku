# Vyrobí zip addonu pro CurseForge: jen složka WoWpoCesku (bez Pomocníka a vývojových souborů).
# Spuštění: powershell -ExecutionPolicy Bypass -File tools\balicek.ps1
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$Root = Split-Path $PSScriptRoot -Parent
$Src  = Join-Path $Root "WoWpoCesku"
$Ver  = (Get-Content (Join-Path $Root "program\verze.txt") -Raw).Trim()
$OutDir = Join-Path $Root "zaloha"
if (-not (Test-Path $OutDir)) { [void](New-Item -ItemType Directory $OutDir) }
$Zip = Join-Path $OutDir "WoWpoCesku-$Ver.zip"
if (Test-Path $Zip) { Remove-Item $Zip -Force }

$fs = [System.IO.File]::Open($Zip, 'Create')
$za = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
$base = (Get-Item $Src).Parent.FullName.TrimEnd('\') + '\'
$count = 0
foreach ($f in Get-ChildItem $Src -Recurse -File) {
    $name = $f.FullName.Substring($base.Length).Replace('\', '/')   # lomítka dopředu, jak CurseForge čeká
    [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($za, $f.FullName, $name, [System.IO.Compression.CompressionLevel]::Optimal)
    $count++
}
$za.Dispose(); $fs.Dispose()
"{0}: {1} souborů, {2:N1} MB" -f $Zip, $count, ((Get-Item $Zip).Length / 1MB)
