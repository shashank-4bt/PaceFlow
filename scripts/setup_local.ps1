# PaceFlow local setup helper (Windows PowerShell)
# Usage:
#   .\scripts\setup_local.ps1
#   .\scripts\setup_local.ps1 -MapsApiKey "AIza..." -PrintSha
#   .\scripts\setup_local.ps1 -FlutterFire
#   .\scripts\setup_local.ps1 -BuildDebug

param(
  [string]$MapsApiKey = "",
  [switch]$PrintSha,
  [switch]$FlutterFire,
  [switch]$BuildDebug
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$flutterSdk = "C:\flutter"
$androidSdk = "C:\AndroidSDK"
$env:PATH = "$flutterSdk\bin;$androidSdk\platform-tools;$env:PATH"
$env:ANDROID_HOME = $androidSdk
$env:ANDROID_SDK_ROOT = $androidSdk

Write-Host "== PaceFlow local setup ==" -ForegroundColor Cyan
Write-Host "Project: $root"

$localProps = Join-Path $root "android\local.properties"
$lines = @()
if (Test-Path $localProps) {
  $lines = @(Get-Content $localProps)
}

function Set-Prop([string[]]$src, [string]$key, [string]$value) {
  $found = $false
  $out = foreach ($line in $src) {
    if ($line -match ("^\s*" + [regex]::Escape($key) + "\s*=")) {
      $found = $true
      "$key=$value"
    } else {
      $line
    }
  }
  if (-not $found) { $out += "$key=$value" }
  return ,$out
}

$lines = Set-Prop $lines "sdk.dir" "C:\\AndroidSDK"
$lines = Set-Prop $lines "flutter.sdk" "C:\\flutter"

if ($MapsApiKey) {
  $lines = Set-Prop $lines "MAPS_API_KEY" $MapsApiKey
  Write-Host "MAPS_API_KEY written to android/local.properties" -ForegroundColor Green
} elseif (-not ($lines | Where-Object { $_ -match '^\s*MAPS_API_KEY\s*=' })) {
  $lines = Set-Prop $lines "MAPS_API_KEY" "YOUR_GOOGLE_MAPS_API_KEY"
  Write-Host "MAPS_API_KEY placeholder added — replace with a real Maps SDK key." -ForegroundColor Yellow
}

$lines | Set-Content -Path $localProps -Encoding UTF8

Write-Host "Running flutter pub get..."
flutter pub get | Out-Host

if ($PrintSha) {
  Write-Host "`n== Debug keystore fingerprints (add in Firebase Console) ==" -ForegroundColor Cyan
  $debugKeystore = Join-Path $env:USERPROFILE ".android\debug.keystore"
  if (Test-Path $debugKeystore) {
    keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>&1 |
      Select-String "SHA1:|SHA-256:" | ForEach-Object { $_.Line }
  } else {
    Write-Host "Debug keystore not found at $debugKeystore" -ForegroundColor Yellow
  }
}

if ($FlutterFire) {
  Write-Host "`nActivating FlutterFire CLI..." -ForegroundColor Cyan
  dart pub global activate flutterfire_cli | Out-Host
  $env:PATH = "$env:LOCALAPPDATA\Pub\Cache\bin;$env:PATH"
  Write-Host "Launching flutterfire configure..." -ForegroundColor Cyan
  flutterfire configure --platforms=android
}

if ($BuildDebug) {
  Write-Host "`nBuilding debug APK..." -ForegroundColor Cyan
  flutter build apk --debug | Out-Host
}

Write-Host "`nDone. Next:" -ForegroundColor Green
Write-Host "  1. Set a real MAPS_API_KEY in android/local.properties"
Write-Host "  2. .\scripts\setup_local.ps1 -FlutterFire -PrintSha"
Write-Host "  3. firebase deploy --only firestore:rules,firestore:indexes,storage"
Write-Host "  4. flutter emulators --launch Pixel_8_Pro; flutter run"
Write-Host "Docs: docs/FIREBASE_SETUP.md | docs/RESUME_CHECKPOINT.md"
