$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$native = [Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
if ($native -ne $env:EXPECTED_ARCHITECTURE) { throw "Unexpected runner: $native" }
$schema = Join-Path $env:RUNNER_TEMP 'scoop-schema.json'
Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Scoop/e6aa3b366bdee8ed138c1e0f7b85192ebdd35d0f/schema.json' -OutFile $schema
if (-not (Get-Content './bucket/klakk.json' -Raw | Test-Json -SchemaFile $schema)) { throw 'Official Scoop manifest schema failed' }
$env:SCOOP = Join-Path $env:RUNNER_TEMP 'Klakk Scoop QA'
$bootstrap = Join-Path $env:RUNNER_TEMP 'scoop-install.ps1'
Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Install/1e2f334083d609986d8c8bc9e31ae8e87c39fab4/install.ps1' -OutFile $bootstrap
& $bootstrap -RunAsAdmin -ScoopDir $env:SCOOP
$scoop = Join-Path $env:SCOOP 'shims\scoop.ps1'
if (-not (Test-Path $scoop)) { throw 'Scoop bootstrap failed' }

function Run-Scoop {
    param([string[]] $Arguments, [switch] $ExpectFailure)
    & pwsh -NoProfile -File $scoop @Arguments
    $code = $LASTEXITCODE
    if ($ExpectFailure) {
        if ($code -eq 0) { throw "Scoop unexpectedly accepted: $Arguments" }
    } elseif ($code -ne 0) { throw "Scoop failed ($code): $Arguments" }
}

# Use the real public repository URL, then select the exact candidate for QA.
Run-Scoop -Arguments @('update')
Run-Scoop -Arguments @('bucket', 'add', 'klakk', 'https://github.com/levindong2026/klakk-downloads')
$candidate = (& git -C $env:GITHUB_WORKSPACE rev-parse HEAD).Trim()
$bucketPath = Join-Path $env:SCOOP 'buckets\klakk'
& git -C $bucketPath fetch origin $candidate --depth=1
if ($LASTEXITCODE -ne 0) { throw 'Candidate fetch failed' }
& git -C $bucketPath checkout --detach $candidate
if ($LASTEXITCODE -ne 0) { throw 'Candidate checkout failed' }
$bucketCommit = (& git -C $bucketPath rev-parse HEAD).Trim()
if ($candidate -ne $bucketCommit) { throw 'Scoop tested a different candidate' }
Write-Host "Candidate commit: $candidate"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
if (Test-Path $key) { throw 'QA runner already has Klakk; refusing to touch it' }
$outside = Join-Path $env:RUNNER_TEMP 'Other Klakk Installation'
$appDir = Join-Path $env:SCOOP 'apps\klakk\1.4.1'
$app = Join-Path $appDir 'Klakk.Windows.exe'
$shortcut = Join-Path ([Environment]::GetFolderPath('StartMenu')) 'Programs\Scoop Apps\Klakk (Scoop).lnk'

# An unrelated registration must be left intact by the actual install command.
New-Item $key -Force | Out-Null
New-ItemProperty $key -Name UninstallString -Value "`"$outside\unins000.exe`"" -Force | Out-Null
Run-Scoop -Arguments @('install', 'klakk/klakk') -ExpectFailure
if ((Get-ItemProperty $key).UninstallString -ne "`"$outside\unins000.exe`"" -or (Test-Path $app) -or (Test-Path $shortcut)) { throw 'Install ownership guard failed' }
Remove-Item $key -Force

# Retained settings are tested with a QA-only marker, never an application launch.
$data = Join-Path $env:LOCALAPPDATA 'Klakk'
$marker = Join-Path $data 'scoop-qa-retention.txt'
New-Item $data -ItemType Directory -Force | Out-Null
Set-Content $marker 'QA only; no activation or telemetry' -Encoding utf8

function Assert-Installed {
    $entry = Get-ItemProperty $key
    if ($entry.DisplayVersion -ne '1.4.1' -or $entry.Publisher -ne 'Klakk') { throw 'Native installer metadata mismatch' }
    if ($entry.UninstallString.Trim('"') -ne (Join-Path $appDir 'unins000.exe')) { throw 'Native install escaped Scoop directory' }
    $bytes = [IO.File]::ReadAllBytes($app)
    $pe = [BitConverter]::ToInt32($bytes, 0x3c)
    $machine = [BitConverter]::ToUInt16($bytes, $pe + 4)
    $expectedMachine = if ($native -eq 'Arm64') { 0xaa64 } else { 0x8664 }
    if ($machine -ne $expectedMachine) { throw 'Native PE architecture mismatch' }
    $packs = @(Get-ChildItem (Join-Path $appDir 'SoundPacks') -Recurse -Filter config.json)
    if ($packs.Count -ne 14) { throw "Unexpected sound pack count: $($packs.Count)" }
    if (-not (Test-Path $shortcut)) { throw 'Scoop shortcut missing' }
    $target = (New-Object -ComObject WScript.Shell).CreateShortcut($shortcut).TargetPath
    $expectedTarget = Join-Path $env:SCOOP 'apps\klakk\current\Klakk.Windows.exe'
    if ($target -ne $expectedTarget) { throw 'Shortcut target mismatch' }
    if (-not (Test-Path $marker)) { throw 'Existing app data was removed' }
    if (Get-Process 'Klakk.Windows' -ErrorAction SilentlyContinue) { throw 'Installation launched the app' }
}

Run-Scoop -Arguments @('install', 'klakk/klakk')
Assert-Installed

# The actual uninstall command must refuse a registration now owned elsewhere.
$registered = (Get-ItemProperty $key).UninstallString
Set-ItemProperty $key -Name UninstallString -Value "`"$outside\unins000.exe`""
Run-Scoop -Arguments @('uninstall', 'klakk') -ExpectFailure
if ((Get-ItemProperty $key).UninstallString -ne "`"$outside\unins000.exe`"" -or -not (Test-Path $app) -or -not (Test-Path $shortcut)) { throw 'Uninstall ownership guard failed' }
Set-ItemProperty $key -Name UninstallString -Value $registered

# A forced reinstall exercises Scoop's uninstall/install update lifecycle.
Run-Scoop -Arguments @('update', 'klakk', '--force')
Assert-Installed
Run-Scoop -Arguments @('uninstall', 'klakk')
if ((Test-Path $app) -or (Test-Path $key) -or (Test-Path $shortcut)) { throw 'Scoop uninstall left registered application files or shortcut' }
if (-not (Test-Path $marker)) { throw 'Scoop uninstall removed retained app data' }
Write-Host "Verified ${native}: Scoop native install, 14 packs, Start shortcut, protected foreign install/uninstall, forced reinstall and cleanup."
Write-Host 'No application was started. No purchase, first-run event or audio-latency measurement was performed. These are QA downloads, not customer growth.'
@"
## Klakk publisher Scoop bucket — $native
- Candidate: $candidate
- Native installer SHA-256 checked by Scoop.
- Installed native PE and 14 sound packs; Start shortcut checked.
- Existing foreign registration blocked during install and uninstall.
- Same-version forced reinstall and uninstall cleanup passed.
- App-data retention passed; app was never launched.
- QA operations only; not customer downloads/installations.
"@ | Add-Content $env:GITHUB_STEP_SUMMARY
