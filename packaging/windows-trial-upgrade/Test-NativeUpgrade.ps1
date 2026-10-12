param(
  [Parameter(Mandatory)][ValidateSet('X64','Arm64')][string]$ExpectedArchitecture,
  [Parameter(Mandatory)][string]$BundleDirectory,
  [Parameter(Mandatory)][string]$InstallerDirectory,
  [Parameter(Mandatory)][string]$ReportDirectory
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:GITHUB_ACTIONS -ne 'true' -or $env:GITHUB_REPOSITORY -ne 'levindong2026/klakk-downloads' -or $env:GITHUB_REPOSITORY_VISIBILITY -ne 'public') { throw 'Only a disposable authorized public GitHub-hosted runner is supported' }
$architecture = [Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
if ($architecture -ne $ExpectedArchitecture) { throw 'Native runner architecture mismatch' }
$arch = if ($architecture -eq 'Arm64') {'arm64'} else {'x64'}
$bundle = (Resolve-Path $BundleDirectory).Path
$installers = (Resolve-Path $InstallerDirectory).Path
$reports = [IO.Path]::GetFullPath($ReportDirectory)
New-Item -ItemType Directory -Force $reports | Out-Null
$runKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
$uninstallKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
$data = Join-Path $env:LOCALAPPDATA 'Klakk'
$manifest = Get-Content (Join-Path $bundle 'candidate-manifest.json') -Raw | ConvertFrom-Json
$build = Get-Content (Join-Path $installers 'build-integrity.json') -Raw | ConvertFrom-Json
function Read-Run {
  $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Software\Microsoft\Windows\CurrentVersion\Run')
  if ($null -eq $key) { return $null }
  try { return $key.GetValue('Klakk', $null, [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames) } finally { $key.Dispose() }
}
function Set-FixtureRun([string]$value) {
  New-Item $runKey -Force | Out-Null
  New-ItemProperty $runKey -Name Klakk -Value $value -PropertyType String -Force | Out-Null
}
function Remove-FixtureRun { Remove-ItemProperty $runKey -Name Klakk -ErrorAction SilentlyContinue }
if ((Test-Path $data) -or (Test-Path $uninstallKey) -or $null -ne (Read-Run) -or (Get-Process -Name 'Klakk.Windows' -ErrorAction SilentlyContinue)) { throw 'Refusing to touch prior Klakk data/install/startup/process state' }
if ($build.application_version -ne '1.4.1' -or $build.release_revision -ne '2026-10-11.1' -or $build.source_set_sha256 -ne $manifest.source_set_sha256 -or @($build.installers).Count -ne 3) { throw 'Unexpected candidate build identity' }
foreach ($record in $build.installers) {
  if ($record.name -notmatch '^Klakk-1\.4\.1-(Windows|win-x64|win-arm64)-Setup-rev-2026-10-11\.1\.exe$' -or $record.sha256 -notmatch '^[a-f0-9]{64}$') { throw 'Invalid revision-distinct installer record' }
  $path = Join-Path $installers $record.name
  if ((Get-Item $path).Length -ne $record.bytes -or (Get-FileHash $path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $record.sha256) { throw 'Transferred installer mismatch' }
}
$checks = [Collections.Generic.List[object]]::new()
$success = $false
$currentRoot = $null
$smokeRuns = 0
function Add-Check([string]$name,[bool]$passed) {
  $checks.Add([ordered]@{name=$name; passed=$passed})
  if (-not $passed) { throw "Native installer check failed: $name" }
}
function Install-Fixture([string]$setup,[string]$root) {
  $process = Start-Process -FilePath $setup -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS `"/DIR=$root`"" -Wait -PassThru
  Add-Check 'silent_install_success' ($process.ExitCode -eq 0)
  if (Get-Process -Name 'Klakk.Windows' -ErrorAction SilentlyContinue) { throw 'Installer unexpectedly launched ordinary app' }
  if (-not (Test-Path $uninstallKey)) { throw 'Per-user uninstall entry missing' }
  $entry = Get-ItemProperty $uninstallKey
  Add-Check 'public_version_still_1.4.1' ($entry.DisplayVersion -eq '1.4.1')
  $prefix = "production/win-$arch/"
  foreach ($item in $manifest.files | Where-Object { $_.path.StartsWith($prefix) }) {
    $file = Join-Path $root $item.path.Substring($prefix.Length)
    if (-not (Test-Path -LiteralPath $file) -or (Get-Item -LiteralPath $file).Length -ne $item.bytes -or (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant() -ne $item.sha256) { throw 'Installed native production byte mismatch' }
  }
  Add-Check 'native_production_payload_byte_identical' $true
  Add-Check 'fourteen_packs_installed' (@(Get-ChildItem (Join-Path $root 'SoundPacks') -Recurse -Filter config.json).Count -eq 14)
}
function Uninstall-Fixture([string]$root) {
  $files = @(Get-ChildItem $root -Filter 'unins*.exe' -ErrorAction SilentlyContinue)
  if ($files.Count -ne 1) { throw 'Expected exactly one owned uninstaller' }
  $p = Start-Process $files[0].FullName -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -Wait -PassThru
  Add-Check 'uninstall_success' ($p.ExitCode -eq 0 -and -not (Test-Path $uninstallKey) -and -not (Test-Path (Join-Path $root 'Klakk.Windows.exe')))
}
function Smoke-Fixture([string]$root,[string]$label) {
  # This release entry uses startupCheck: telemetry is disabled and the reviewed
  # final source returns before heartbeat/update/license/billing network paths.
  $exe = Join-Path $root 'Klakk.Windows.exe'
  $stderr = Join-Path $reports "$label-release-smoke-stderr.txt"
  $process = Start-Process $exe -ArgumentList '--smoke-test' -Wait -PassThru -RedirectStandardError $stderr
  Add-Check 'release_isolated_smoke_success' ($process.ExitCode -eq 0)
  Add-Check 'smoke_created_no_analytics_outbox' (-not (Test-Path (Join-Path $data 'analytics-pending.json')))
  $script:smokeRuns++
}
try {
  $wrong = if ($arch -eq 'arm64') {'x64'} else {'arm64'}
  $wrongSetup = Join-Path $installers "Klakk-1.4.1-win-$wrong-Setup-rev-2026-10-11.1.exe"
  $currentRoot = Join-Path $env:RUNNER_TEMP 'Klakk-Upgrade-Fixture-WrongArch'
  if (Test-Path $currentRoot) { throw 'Wrong-architecture fixture directory must be new' }
  $refused = Start-Process $wrongSetup -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS `"/DIR=$currentRoot`"" -Wait -PassThru
  Add-Check 'wrong_architecture_installer_refused' ($refused.ExitCode -ne 0 -and -not (Test-Path $currentRoot) -and -not (Test-Path $uninstallKey) -and $null -eq (Read-Run))
  $currentRoot = $null
  $targets = @('Windows', "win-$arch")
  foreach ($target in $targets) {
    $setup = Join-Path $installers "Klakk-1.4.1-$target-Setup-rev-2026-10-11.1.exe"
    $currentRoot = Join-Path $env:RUNNER_TEMP "Klakk-Upgrade-Fixture-$target"
    if (Test-Path $currentRoot) { throw 'Fixture installation directory must be new' }
    Install-Fixture $setup $currentRoot
    $owned = '"' + (Join-Path $currentRoot 'Klakk.Windows.exe') + '" --background'
    Add-Check 'fresh_silent_setup_registers_startup' ((Read-Run) -eq $owned)
    Add-Check 'silent_setup_does_not_create_first_launch_identity' (-not (Test-Path $data))
    Smoke-Fixture $currentRoot $target
    $prefsPath = Join-Path $data 'preferences.json'
    $prefs = Get-Content $prefsPath -Raw | ConvertFrom-Json
    Add-Check 'fresh_preferences_default_on' ($prefs.LaunchAtLogin -eq $true)
    $identity = Join-Path $data 'installation.json'
    $identityHash = (Get-FileHash $identity -Algorithm SHA256).Hash
    # Explicit saved OFF represents a preexisting user preference. This fixture
    # does not claim a native click on the startup settings switch or actual login.
    $prefs.LaunchAtLogin = $false
    $prefs | ConvertTo-Json -Depth 30 | Set-Content $prefsPath -Encoding utf8
    Remove-FixtureRun
    Install-Fixture $setup $currentRoot
    Add-Check 'upgrade_explicit_off_not_registered' ($null -eq (Read-Run))
    Smoke-Fixture $currentRoot "$target-off"
    Add-Check 'upgrade_explicit_off_preserved' ((Get-Content $prefsPath -Raw | ConvertFrom-Json).LaunchAtLogin -eq $false -and $null -eq (Read-Run))
    Add-Check 'upgrade_identity_preserved_private_hash_only' ((Get-FileHash $identity -Algorithm SHA256).Hash -eq $identityHash)
    Uninstall-Fixture $currentRoot
    Add-Check 'uninstall_preserves_existing_preferences_identity' ((Test-Path $prefsPath) -and (Test-Path $identity) -and (Get-FileHash $identity -Algorithm SHA256).Hash -eq $identityHash)
    Install-Fixture $setup $currentRoot
    Add-Check 'reinstall_keeps_explicit_off_identity' ($null -eq (Read-Run) -and (Get-Content $prefsPath -Raw | ConvertFrom-Json).LaunchAtLogin -eq $false -and (Get-FileHash $identity -Algorithm SHA256).Hash -eq $identityHash)
    Set-FixtureRun $owned
    Uninstall-Fixture $currentRoot
    Add-Check 'uninstall_deletes_owned_quoted_run_only' ($null -eq (Read-Run))
    foreach ($foreign in @(
      '"C:\Klakk-QA-Scoop\apps\klakk\current\Klakk.Windows.exe" --background',
      '"C:\Klakk-QA-Portable\Klakk.Windows.exe" --background',
      ('"' + (Join-Path $currentRoot 'Klakk.Windows.exe.other') + '" --background'),
      ((Join-Path $currentRoot 'Klakk.Windows.exe') + ' --background')
    )) {
      # Ambiguous unquoted commands containing spaces must be retained, while a
      # clearly owned unquoted no-space path is legitimately removed.
      Install-Fixture $setup $currentRoot
      Set-FixtureRun $foreign
      Uninstall-Fixture $currentRoot
      $ownUnquoted = $foreign -eq ((Join-Path $currentRoot 'Klakk.Windows.exe') + ' --background') -and (Join-Path $currentRoot 'Klakk.Windows.exe') -notmatch ' '
      Add-Check 'uninstall_run_path_ownership_boundary' $(if ($ownUnquoted) { $null -eq (Read-Run) } else { (Read-Run) -eq $foreign })
      Remove-FixtureRun
    }
    Remove-Item $data -Recurse -Force
    if (Test-Path $currentRoot) { Remove-Item $currentRoot -Recurse -Force }
    $currentRoot = $null
  }
  $success = $true
} finally {
  # Only remove fixtures created after a clean-state guard on this disposable VM.
  if ($currentRoot -and (Test-Path $currentRoot)) {
    $uninstaller = @(Get-ChildItem $currentRoot -Filter 'unins*.exe' -ErrorAction SilentlyContinue)
    if ($uninstaller.Count -eq 1) { Start-Process $uninstaller[0].FullName -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -Wait | Out-Null }
    Remove-Item $currentRoot -Recurse -Force -ErrorAction SilentlyContinue
  }
  Remove-FixtureRun
  if (Test-Path $data) { Remove-Item $data -Recurse -Force }
  [ordered]@{
    status=$(if ($success) {'native_installer_fixture_completed'} else {'failed'});
    architecture=$architecture; public_version='1.4.1'; release_revision='2026-10-11.1'; checks=@($checks.ToArray());
    ordinary_app_launch=$false; isolated_release_smoke_runs=$smokeRuns;
    smoke_telemetry_disabled_by_reviewed_source=$true; production_network_calls_observed=$null;
    production_network_isolation_source_review_required=$true; secrets_or_installation_files_uploaded=$false;
    physical_keyboard_tested=$false; real_login_execution_verified=$null; native_startup_toggle_click_verified=$null;
    existing_explicit_on_silent_reinstall_before_normal_launch_verified=$null;
    publicly_released=$false; customer_installs_verified=$null; release_accepted=$false
  } | ConvertTo-Json -Depth 12 | Set-Content (Join-Path $reports 'native-installer-report.json') -Encoding utf8
}
Write-Host 'Native installer fixtures completed. Login, startup-toggle UI and physical typing remain separate unknown gates.'
