param(
  [Parameter(Mandatory)][ValidateSet('X64', 'Arm64')][string]$ExpectedArchitecture,
  [Parameter(Mandatory)][string]$CandidateDirectory,
  [Parameter(Mandatory)][string]$ReportFile
)
$ErrorActionPreference = 'Stop'
$architecture = [Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
if ($architecture -ne $ExpectedArchitecture) { throw "Wrong test host: $architecture" }
$arch = if ($architecture -eq 'Arm64') { 'arm64' } else { 'x64' }
$wrongArch = if ($arch -eq 'arm64') { 'x64' } else { 'arm64' }
$registry = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
if (Test-Path $registry) { throw 'Refusing to touch an existing Klakk installation' }
$candidate = Join-Path $CandidateDirectory "Klakk-1.4.1-Windows-$arch-Setup.exe"
$wrongCandidate = Join-Path $CandidateDirectory "Klakk-1.4.1-Windows-$wrongArch-Setup.exe"
$manifest = Get-Content (Join-Path $CandidateDirectory "$arch-payload-manifest.json") -Raw | ConvertFrom-Json
$build = Get-Content (Join-Path $CandidateDirectory 'build-integrity.json') -Raw | ConvertFrom-Json
foreach ($file in @($build.installers)) {
  $path = Join-Path $CandidateDirectory $file.name
  if ((Get-Item $path).Length -ne $file.bytes -or (Get-FileHash $path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $file.sha256) {
    throw 'Transferred candidate integrity mismatch'
  }
}
if ($manifest.architecture -ne $architecture -or $manifest.source_sha256 -ne '7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454') { throw 'Unexpected payload provenance' }
$wrongRoot = Join-Path $env:RUNNER_TEMP 'klakk-wrong-architecture'
$wrong = Start-Process $wrongCandidate -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS `"/DIR=$wrongRoot`"" -Wait -PassThru
if ($wrong.ExitCode -eq 0 -or (Test-Path $wrongRoot) -or (Test-Path $registry)) { throw 'Wrong architecture was not rejected cleanly' }
$installRoot = Join-Path $env:RUNNER_TEMP 'klakk-native-candidate'
function Confirm-Payload {
  $entry = Get-ItemProperty $registry
  if ($entry.DisplayName -ne 'Klakk version 1.4.1' -or $entry.DisplayVersion -ne '1.4.1' -or $entry.Publisher -ne 'Klakk' -or $entry.InstallLocation.TrimEnd('\') -ne $installRoot) { throw 'Candidate registry metadata mismatch' }
  $actualFiles = @(Get-ChildItem $installRoot -Recurse -File -Force | Where-Object {
    -not ($_.DirectoryName -eq $installRoot -and $_.Name -match '^unins\d+\.(exe|dat|msg)$')
  })
  if ($actualFiles.Count -ne $manifest.files.Count) { throw 'Candidate changed the payload file set' }
  foreach ($file in $manifest.files) {
    $path = Join-Path $installRoot $file.path
    if (-not (Test-Path -LiteralPath $path) -or (Get-Item -LiteralPath $path).Length -ne $file.bytes -or (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $file.sha256) {
      throw "Candidate changed a payload file: $($file.path)"
    }
  }
  $exe = [IO.File]::ReadAllBytes((Join-Path $installRoot 'Klakk.Windows.exe'))
  $pe = [BitConverter]::ToInt32($exe, 0x3c)
  $machine = [BitConverter]::ToUInt16($exe, $pe + 4)
  $expectedMachine = if ($architecture -eq 'Arm64') { 0xaa64 } else { 0x8664 }
  if ($machine -ne $expectedMachine) { throw 'Candidate installed the wrong executable architecture' }
  if (@(Get-ChildItem (Join-Path $installRoot 'SoundPacks') -Recurse -Filter config.json).Count -ne 14) { throw 'Candidate lost sound packs' }
  if (Get-Process -Name 'Klakk.Windows' -ErrorAction SilentlyContinue) { throw 'The test must not launch the app' }
}
try {
  foreach ($attempt in 1..2) {
    $install = Start-Process $candidate -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS `"/DIR=$installRoot`"" -Wait -PassThru
    if ($install.ExitCode -ne 0) { throw "Candidate installation $attempt failed: $($install.ExitCode)" }
    Confirm-Payload
  }
} finally {
  $uninstallers = @(Get-ChildItem $installRoot -Filter 'unins*.exe' -ErrorAction SilentlyContinue)
  if ($uninstallers.Count -eq 1) {
    $uninstall = Start-Process $uninstallers[0].FullName -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -Wait -PassThru
    if ($uninstall.ExitCode -ne 0) { throw 'Candidate uninstall failed' }
  }
}
if ((Test-Path $registry) -or (Test-Path (Join-Path $installRoot 'Klakk.Windows.exe'))) { throw 'Candidate uninstall was incomplete' }
$bytes = (Get-Item $candidate).Length
if ($bytes -ge $manifest.source_bytes) { throw 'No download size improvement' }
[ordered]@{
  architecture = $architecture
  application_version = '1.4.1'
  source_bytes = $manifest.source_bytes
  candidate_bytes = $bytes
  candidate_sha256 = (Get-FileHash $candidate -Algorithm SHA256).Hash.ToLowerInvariant()
  bytes_saved = $manifest.source_bytes - $bytes
  reduction_percent = [math]::Round(100 * (1 - $bytes / $manifest.source_bytes), 2)
  all_payload_files_byte_identical = $true
  payload_file_count = $manifest.files.Count
  wrong_architecture_rejected = $true
  install_and_same_version_reinstall_passed = $true
  uninstall_passed = $true
  application_launched = $false
  qa_only = $true
  publicly_released = $false
  customer_installations_verified = $null
} | ConvertTo-Json -Depth 8 | Set-Content $ReportFile -Encoding utf8
Write-Host "Verified $architecture packaging only. No app start, license request, purchase or analytics event."
