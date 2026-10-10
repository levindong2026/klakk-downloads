param(
  [Parameter(Mandatory)][ValidateSet('X64', 'Arm64')][string]$ExpectedArchitecture,
  [Parameter(Mandatory)][string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
$architecture = [Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
if ($architecture -ne $ExpectedArchitecture) { throw "Wrong extraction host: $architecture" }
$registry = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
if (Test-Path $registry) { throw 'Refusing to touch an existing Klakk installation' }
$sourceUrl = 'https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe'
$sourceHash = '7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454'
$setup = Join-Path $env:RUNNER_TEMP 'klakk-formal-source.exe'
Invoke-WebRequest $sourceUrl -OutFile $setup
if ((Get-Item $setup).Length -ne 202233968 -or (Get-FileHash $setup -Algorithm SHA256).Hash.ToLowerInvariant() -ne $sourceHash) {
  throw 'Published source installer integrity mismatch'
}
$installRoot = Join-Path $env:RUNNER_TEMP 'klakk-formal-extraction'
if (Test-Path $installRoot) { throw 'Extraction directory must be fresh' }
New-Item -ItemType Directory -Path $OutputDirectory -ErrorAction Stop | Out-Null
$payload = Join-Path $OutputDirectory 'payload'
New-Item -ItemType Directory -Path $payload | Out-Null
try {
  $arguments = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS `"/DIR=$installRoot`""
  $install = Start-Process $setup -ArgumentList $arguments -Wait -PassThru
  if ($install.ExitCode -ne 0) { throw "Source installation failed: $($install.ExitCode)" }
  $entry = Get-ItemProperty $registry
  if ($entry.DisplayVersion -ne '1.4.1' -or $entry.Publisher -ne 'Klakk' -or $entry.InstallLocation.TrimEnd('\') -ne $installRoot) {
    throw 'Source installation metadata mismatch'
  }
  if (Get-Process -Name 'Klakk.Windows' -ErrorAction SilentlyContinue) { throw 'The application must not be launched during extraction' }
  $files = @(Get-ChildItem $installRoot -Recurse -File -Force | Where-Object {
    # Only installer-generated root files are removed. Every payload file is preserved.
    -not ($_.DirectoryName -eq $installRoot -and $_.Name -match '^unins\d+\.(exe|dat|msg)$')
  })
  if ($files.Count -lt 15) { throw 'Unexpectedly small payload file set' }
  $manifestFiles = foreach ($file in $files) {
    $relative = [IO.Path]::GetRelativePath($installRoot, $file.FullName)
    $destination = Join-Path $payload $relative
    New-Item -ItemType Directory -Force -Path ([IO.Path]::GetDirectoryName($destination)) | Out-Null
    Copy-Item -LiteralPath $file.FullName -Destination $destination
    [ordered]@{ path = $relative.Replace('\', '/'); bytes = $file.Length; sha256 = (Get-FileHash $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant() }
  }
  $exe = [IO.File]::ReadAllBytes((Join-Path $payload 'Klakk.Windows.exe'))
  $pe = [BitConverter]::ToInt32($exe, 0x3c)
  $machine = [BitConverter]::ToUInt16($exe, $pe + 4)
  $expectedMachine = if ($architecture -eq 'Arm64') { 0xaa64 } else { 0x8664 }
  if ($machine -ne $expectedMachine) { throw 'Source payload is not native to this host' }
  if (@(Get-ChildItem (Join-Path $payload 'SoundPacks') -Recurse -Filter config.json).Count -ne 14) { throw 'Source payload does not contain 14 sound packs' }
  [ordered]@{
    architecture = $architecture
    source_url = $sourceUrl
    source_sha256 = $sourceHash
    source_bytes = 202233968
    application_version = '1.4.1'
    files = @($manifestFiles | Sort-Object path)
    qa_only = $true
    application_launched = $false
  } | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $OutputDirectory 'payload-manifest.json') -Encoding utf8
} finally {
  $uninstallers = @(Get-ChildItem $installRoot -Filter 'unins*.exe' -ErrorAction SilentlyContinue)
  if ($uninstallers.Count -eq 1) {
    $uninstall = Start-Process $uninstallers[0].FullName -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -Wait -PassThru
    if ($uninstall.ExitCode -ne 0) { throw 'Source uninstall failed' }
  }
}
if (Test-Path $registry) { throw 'Source uninstall entry was not removed' }
Write-Host "Copied the complete $architecture payload from the verified official installer. No app launch or analytics event."
