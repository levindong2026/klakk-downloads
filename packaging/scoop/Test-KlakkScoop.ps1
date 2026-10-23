$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$packageVersion = '1.4.1.20261011.1'
$legacyVersion = '1.4.1'
$legacyCommit = '32d9bec233ab6f23ea0c1a9b96ea7239e72d9759'
$native = [Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
if ($native -ne $env:EXPECTED_ARCHITECTURE) { throw "Unexpected runner: $native" }
$schema = Join-Path $env:RUNNER_TEMP 'scoop-schema.json'
Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Scoop/e6aa3b366bdee8ed138c1e0f7b85192ebdd35d0f/schema.json' -OutFile $schema
if (-not (Get-Content './bucket/klakk.json' -Raw | Test-Json -SchemaFile $schema)) { throw 'Official Scoop manifest schema failed' }
$manifest = Get-Content './bucket/klakk.json' -Raw | ConvertFrom-Json
if ($manifest.version -ne $packageVersion) { throw 'Candidate package revision mismatch' }
$architectureKey = if ($native -eq 'Arm64') { 'arm64' } else { '64bit' }
$releaseArchitecture = if ($native -eq 'Arm64') { 'arm64' } else { 'x64' }
$expectedDownloadUrl = "https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1-r20261011.1/Klakk-1.4.1-Windows-$releaseArchitecture-Setup-r20261011.1.exe"
if ($manifest.architecture.$architectureKey.url -ne $expectedDownloadUrl) { throw 'Scoop did not select the native release asset' }
$expectedDownloadBytes = if ($native -eq 'Arm64') { 58015675 } else { 61060213 }
$env:SCOOP = Join-Path $env:RUNNER_TEMP 'Klakk Scoop QA'
$bootstrap = Join-Path $env:RUNNER_TEMP 'scoop-install.ps1'
Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Install/1e2f334083d609986d8c8bc9e31ae8e87c39fab4/install.ps1' -OutFile $bootstrap
& $bootstrap -RunAsAdmin -ScoopDir $env:SCOOP
$scoop = Join-Path $env:SCOOP 'shims\scoop.ps1'
if (-not (Test-Path $scoop)) { throw 'Scoop bootstrap failed' }

function Run-Scoop {
    param([string[]] $Arguments, [switch] $ExpectFailure, [string] $ExpectedMessage)
    $output = @(& pwsh -NoProfile -File $scoop @Arguments 2>&1)
    $code = $LASTEXITCODE
    $output | Write-Output
    if ($ExpectFailure) {
        if ($code -eq 0) { throw "Scoop unexpectedly accepted: $Arguments" }
        if (-not $ExpectedMessage -or ($output -join "`n") -notmatch [regex]::Escape($ExpectedMessage)) { throw "Scoop failed for a different reason: $Arguments" }
    } elseif ($code -ne 0) { throw "Scoop failed ($code): $Arguments" }
}

# Use the real public repository URL, then select the exact candidate for QA.
Run-Scoop -Arguments @('update')
Run-Scoop -Arguments @('bucket', 'add', 'klakk', 'https://github.com/levindong2026/klakk-downloads')
$candidate = (& git -C $env:GITHUB_WORKSPACE rev-parse HEAD).Trim()
$bucketPath = Join-Path $env:SCOOP 'buckets\klakk'
function Select-BucketCommit {
    param([string] $Commit)
    & git -C $bucketPath fetch origin $Commit --depth=1
    if ($LASTEXITCODE -ne 0) { throw 'Bucket commit fetch failed' }
    & git -C $bucketPath checkout --detach $Commit
    if ($LASTEXITCODE -ne 0) { throw 'Bucket commit checkout failed' }
    if ((& git -C $bucketPath rev-parse HEAD).Trim() -ne $Commit) { throw 'Scoop tested a different bucket commit' }
}
Select-BucketCommit $candidate
$scoopRoot = Join-Path $env:SCOOP 'apps\scoop\current'
$scoopCommit = (& git -C $scoopRoot rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Unable to identify actual Scoop core' }
Write-Host "Actual Scoop core commit: $scoopCommit"
. (Join-Path $scoopRoot 'lib\versions.ps1')
if ((Compare-Version $legacyVersion $packageVersion) -ne 1 -or
    (Compare-Version $packageVersion $legacyVersion) -ne -1 -or
    (Compare-Version $packageVersion $packageVersion) -ne 0 -or
    (Compare-Version $packageVersion '1.4.2') -ne 1 -or
    (Compare-Version $packageVersion '1.4.1.20261012.1') -ne 1) { throw 'Actual Scoop version ordering failed' }
Write-Host "Actual Scoop version ordering passed: $legacyVersion < $packageVersion < 1.4.2."
Write-Host "Candidate commit: $candidate"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
if (Test-Path $key) { throw 'QA runner already has Klakk; refusing to touch it' }
$outside = Join-Path $env:RUNNER_TEMP 'Other Klakk Installation'
function Set-PackagePaths {
    param([string] $PackageVersion)
    $script:appDir = Join-Path $env:SCOOP "apps\klakk\$PackageVersion"
    $script:app = Join-Path $script:appDir 'Klakk.Windows.exe'
}
Set-PackagePaths $packageVersion
$shortcut = Join-Path ([Environment]::GetFolderPath('StartMenu')) 'Programs\Scoop Apps\Klakk (Scoop).lnk'

# An unrelated registration must be left intact by the actual install command.
New-Item $key -Force | Out-Null
New-ItemProperty $key -Name UninstallString -Value "`"$outside\unins000.exe`"" -Force | Out-Null
Run-Scoop -Arguments @('install', 'klakk/klakk') -ExpectFailure -ExpectedMessage 'Another Klakk installation is registered'
if ((Get-ItemProperty $key).UninstallString -ne "`"$outside\unins000.exe`"" -or (Test-Path $app) -or (Test-Path $shortcut)) { throw 'Install ownership guard failed' }
Remove-Item $key -Force

# Retained settings are tested with a QA-only marker, never an application launch.
$data = Join-Path $env:LOCALAPPDATA 'Klakk'
$marker = Join-Path $data 'scoop-qa-retention.txt'
New-Item $data -ItemType Directory -Force | Out-Null
Set-Content $marker 'QA only; no activation or telemetry' -Encoding utf8

function Assert-Installed {
    param([string] $ExpectedPackageVersion)
    $receipt = Join-Path $appDir 'scoop-manifest.json'
    if (-not (Test-Path $receipt)) { $receipt = Join-Path $appDir 'manifest.json' }
    if ((Get-Content $receipt -Raw | ConvertFrom-Json).version -ne $ExpectedPackageVersion) { throw 'Scoop package receipt mismatch' }
    $currentPath = Join-Path $env:SCOOP 'apps\klakk\current'
    $currentTarget = (Get-Item -LiteralPath $currentPath).ResolveLinkTarget($true)
    if (-not $currentTarget -or [IO.Path]::GetFullPath($currentTarget.FullName).TrimEnd('\') -ine [IO.Path]::GetFullPath($appDir).TrimEnd('\')) { throw 'Scoop current points to a different package directory' }
    $currentReceipt = Join-Path $currentPath 'scoop-manifest.json'
    if (-not (Test-Path $currentReceipt)) { $currentReceipt = Join-Path $currentPath 'manifest.json' }
    if ((Get-Content $currentReceipt -Raw | ConvertFrom-Json).version -ne $ExpectedPackageVersion) { throw 'Scoop current package receipt mismatch' }
    $entry = Get-ItemProperty $key
    if ($entry.DisplayVersion -ne '1.4.1' -or $entry.Publisher -ne 'Klakk') { throw 'Native installer metadata mismatch' }
    $script:observedDisplayVersion = $entry.DisplayVersion
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

# Install the previously published package, then test a normal revision update.
Select-BucketCommit $legacyCommit
Set-PackagePaths $legacyVersion
Run-Scoop -Arguments @('install', 'klakk/klakk')
Assert-Installed $legacyVersion
Select-BucketCommit $candidate
Set-PackagePaths $packageVersion
Run-Scoop -Arguments @('update', 'klakk')
Assert-Installed $packageVersion
if ((& git -C $bucketPath rev-parse HEAD).Trim() -ne $candidate) { throw 'Update changed the candidate bucket' }
$cachedInstallers = @(Get-ChildItem (Join-Path $env:SCOOP 'cache') -File -Filter "klakk#$packageVersion#*.exe")
if ($cachedInstallers.Count -ne 1 -or $cachedInstallers[0].Length -ne $expectedDownloadBytes) { throw 'Scoop downloaded an unexpected installer size' }
$currentCacheHash = (Get-FileHash $cachedInstallers[0].FullName -Algorithm SHA256).Hash.ToLowerInvariant()
if ($currentCacheHash -ne $manifest.architecture.$architectureKey.hash) { throw 'Current revision cache digest mismatch' }
Write-Host "Verified normal update: $legacyVersion -> $packageVersion, App DisplayVersion remains 1.4.1."
Write-Host "Verified native download: $expectedDownloadUrl ($expectedDownloadBytes bytes)."

# The actual uninstall command must refuse a registration now owned elsewhere.
$registered = (Get-ItemProperty $key).UninstallString
Set-ItemProperty $key -Name UninstallString -Value "`"$outside\unins000.exe`""
Run-Scoop -Arguments @('uninstall', 'klakk') -ExpectFailure -ExpectedMessage 'The registered Klakk belongs to another installation'
if ((Get-ItemProperty $key).UninstallString -ne "`"$outside\unins000.exe`"" -or -not (Test-Path $app) -or -not (Test-Path $shortcut)) { throw 'Uninstall ownership guard failed' }
Set-ItemProperty $key -Name UninstallString -Value $registered

# A forced reinstall exercises Scoop's uninstall/install update lifecycle.
Run-Scoop -Arguments @('update', 'klakk', '--force')
Assert-Installed $packageVersion
Run-Scoop -Arguments @('uninstall', 'klakk')
if ((Test-Path $app) -or (Test-Path $key) -or (Test-Path $shortcut)) { throw 'Scoop uninstall left registered application files or shortcut' }
if (-not (Test-Path $marker)) { throw 'Scoop uninstall removed retained app data' }
# A clean current-revision install must also work after upgrade/removal.
Run-Scoop -Arguments @('install', 'klakk/klakk')
Assert-Installed $packageVersion
Run-Scoop -Arguments @('uninstall', 'klakk')
if ((Test-Path $app) -or (Test-Path $key) -or (Test-Path $shortcut)) { throw 'Clean revision uninstall left registered application files or shortcut' }
if (-not (Test-Path $marker)) { throw 'Clean revision uninstall removed retained app data' }
$runKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
$startupValue = (Get-ItemProperty -LiteralPath $runKey -Name Klakk -ErrorAction SilentlyContinue).Klakk
if ($startupValue -and ($startupValue.Contains($appDir) -or $startupValue.Contains((Join-Path $env:SCOOP 'apps\klakk\current')))) { throw 'Uninstall left a startup entry pointing to this removed Scoop application' }
Write-Host "Verified ${native}: normal revision upgrade, clean native install, 14 packs, Start shortcut, protected foreign install/uninstall, forced reinstall and cleanup."
Write-Host 'No application was started. No purchase, first-run event or audio-latency measurement was performed. These are QA downloads, not customer growth.'
$qaEvidence = [ordered]@{
    candidate = $candidate; scoop_core_commit = $scoopCommit; architecture = $native
    legacy_package_version = $legacyVersion; package_version = $packageVersion
    windows_display_version = $observedDisplayVersion; installer_sha256 = $currentCacheHash
    installer_bytes = $cachedInstallers[0].Length; normal_upgrade = $true; clean_install = $true
    foreign_install_and_uninstall_guards = $true; forced_reinstall = $true
    retained_app_data_marker = $true; app_process_absent_at_checkpoints = $true
    uninstall_cleanup_and_no_owned_startup_orphan = $true; customer_growth = $false
}
Write-Host "::notice title=Klakk Scoop QA evidence::$($qaEvidence | ConvertTo-Json -Compress)"
@"
## Klakk publisher Scoop bucket — $native
- Candidate: $candidate
- Actual Scoop core: $scoopCommit
- App 1.4.1; package $legacyVersion -> $packageVersion by normal update.
- Native installer SHA-256 checked by Scoop.
- Installed native PE and 14 sound packs; Start shortcut checked.
- Existing foreign registration blocked during install and uninstall.
- Normal old-to-revision upgrade, clean current install, same-version forced reinstall and uninstall cleanup passed.
- App-data retention passed; app was never launched.
- QA operations only; not customer downloads/installations.
"@ | Add-Content $env:GITHUB_STEP_SUMMARY
