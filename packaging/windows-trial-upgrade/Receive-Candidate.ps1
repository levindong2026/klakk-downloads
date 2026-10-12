param(
  [Parameter(Mandatory)][ValidatePattern('^[1-9][0-9]*$')][string]$ReleaseId,
  [Parameter(Mandatory)][ValidatePattern('^[1-9][0-9]*$')][string]$AssetId,
  [Parameter(Mandatory)][ValidatePattern('^[a-fA-F0-9]{64}$')][string]$ExpectedSha256,
  [Parameter(Mandatory)][ValidatePattern('^[a-fA-F0-9]{64}$')][string]$ExpectedSourceSetSha256,
  [Parameter(Mandatory)][string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
if ($env:GITHUB_REPOSITORY -ne 'levindong2026/klakk-downloads' -or $env:GITHUB_REPOSITORY_VISIBILITY -ne 'public' -or $env:GITHUB_ACTIONS -ne 'true') {
  throw 'Only the authorized public downloads repository runner is supported'
}
if ([string]::IsNullOrWhiteSpace($env:GH_TOKEN)) { throw 'contents:read workflow token missing' }
$destination = [IO.Path]::GetFullPath($OutputDirectory)
if (Test-Path $destination) { throw 'Extraction destination must be new' }
New-Item -ItemType Directory $destination | Out-Null
$api = 'https://api.github.com/repos/levindong2026/klakk-downloads'
$headers = @{ Authorization = "Bearer $env:GH_TOKEN"; Accept = 'application/vnd.github+json'; 'X-GitHub-Api-Version' = '2026-03-10' }
$release = Invoke-RestMethod -Uri "$api/releases/$ReleaseId" -Headers $headers
if (-not $release.draft -or [string]$release.id -ne $ReleaseId) { throw 'Candidate must remain in the specified unpublished draft release' }
$asset = @($release.assets | Where-Object { [string]$_.id -eq $AssetId })
if ($asset.Count -ne 1 -or $asset[0].state -ne 'uploaded' -or $asset[0].name -notmatch '\.zip$' -or $asset[0].size -le 0) { throw 'Specified uploaded ZIP asset absent from draft' }
if ($asset[0].PSObject.Properties.Name -contains 'digest' -and $asset[0].digest -and $asset[0].digest -ne "sha256:$($ExpectedSha256.ToLowerInvariant())") { throw 'GitHub asset digest differs from the external lock' }
$zipPath = Join-Path $destination 'candidate.zip'
$headers.Accept = 'application/octet-stream'
Invoke-WebRequest -Uri "$api/releases/assets/$AssetId" -Headers $headers -OutFile $zipPath
if ((Get-FileHash $zipPath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $ExpectedSha256.ToLowerInvariant() -or (Get-Item $zipPath).Length -ne $asset[0].size) { throw 'Candidate ZIP integrity mismatch' }
$bundle = Join-Path $destination 'bundle'
New-Item -ItemType Directory $bundle | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [IO.Compression.ZipFile]::OpenRead($zipPath)
try {
  $paths = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
  foreach ($entry in $zip.Entries) {
    $name = $entry.FullName
    if ($name -match '\\|(^/)|(^[a-zA-Z]:)|(^|/)\.\.(/|$)' -or $name -match '(?i)\.(pdb|cs|csproj|sln|vb|fs|env|pem|pfx|key)$' -or $name -match '(?i)(^|/)(installation|preferences|analytics-pending|credentials|secrets)(\.|/)') { throw 'Disallowed path/source/secret file in candidate ZIP' }
    if ($name.EndsWith('/')) { continue }
    if (-not $paths.Add($name)) { throw 'Duplicate or case-colliding ZIP path' }
    $allowed = $name -eq 'candidate-manifest.json' -or $name -match '^packaging/(installer-(common|universal|win-x64|win-arm64)\.iss|Klakk\.Windows/Resources/klakk\.ico)$' -or $name -match '^(production|qa)/win-(x64|arm64)/.+\.(exe|dll|json|wav|txt|backup|original)$'
    if (-not $allowed) { throw 'ZIP contains a file outside the compiled payload / exact Inno packaging allowlist' }
    if ($entry.Length -gt 512MB) { throw 'Unexpected individual file size' }
  }
  if ($paths.Count -gt 4000) { throw 'Unexpected candidate file count' }
} finally { $zip.Dispose() }
[IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $bundle)
$manifest = Get-Content (Join-Path $bundle 'candidate-manifest.json') -Raw | ConvertFrom-Json
if ($manifest.schema_version -ne 1 -or $manifest.application_version -ne '1.4.1' -or $manifest.release_revision -ne '2026-10-11.1' -or $manifest.source_set_sha256 -ne $ExpectedSourceSetSha256.ToLowerInvariant()) { throw 'Manifest revision/source provenance mismatch' }
$manifestPaths = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($item in $manifest.files) {
  if (-not $paths.Contains($item.path) -or $item.path -eq 'candidate-manifest.json' -or -not $manifestPaths.Add($item.path) -or $item.sha256 -notmatch '^[a-f0-9]{64}$' -or $item.bytes -le 0) { throw 'Invalid manifest entry' }
  $file = Join-Path $bundle $item.path
  if ((Get-Item -LiteralPath $file).Length -ne $item.bytes -or (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant() -ne $item.sha256) { throw 'Extracted candidate file differs from locked manifest' }
}
if ($manifestPaths.Count -ne $paths.Count - 1) { throw 'Candidate file set is not exactly the manifest file set' }
foreach ($role in @('production','qa')) {
  foreach ($arch in @('x64','arm64')) {
    $root = Join-Path $bundle "$role/win-$arch"
    $exe = Join-Path $root 'Klakk.Windows.exe'
    $dll = Join-Path $root 'Klakk.Windows.dll'
    if (-not (Test-Path $exe) -or ($role -eq 'qa' -and -not (Test-Path $dll))) { throw 'Both production native executables and QA executable/assembly pairs are required' }
    $bytes = [IO.File]::ReadAllBytes($exe); $pe = [BitConverter]::ToInt32($bytes, 0x3c)
    if ($pe -lt 0 -or $pe -gt $bytes.Length - 6) { throw 'Invalid PE executable' }
    $machine = [BitConverter]::ToUInt16($bytes, $pe + 4)
    $expected = if ($arch -eq 'arm64') { 0xaa64 } else { 0x8664 }
    if ($machine -ne $expected) { throw 'Executable architecture mismatch' }
    $markerFile = if ($role -eq 'qa') { $dll } else { $exe }
    $assemblyHex = [BitConverter]::ToString([IO.File]::ReadAllBytes($markerFile))
    $marker = [BitConverter]::ToString([Text.Encoding]::Unicode.GetBytes('--trial-tip-smoke'))
    $utf8Marker = [BitConverter]::ToString([Text.Encoding]::UTF8.GetBytes('--trial-tip-smoke'))
    $hasQaMarker = $assemblyHex.Contains($marker) -or $assemblyHex.Contains($utf8Marker)
    if (($role -eq 'qa') -ne $hasQaMarker) { throw 'QA/production compiled separation mismatch' }
    if (@(Get-ChildItem (Join-Path $root 'SoundPacks') -Recurse -Filter config.json).Count -ne 14) { throw 'Payload does not contain exactly 14 sound packs' }
  }
}
[ordered]@{ release_id=$ReleaseId; asset_id=$AssetId; zip_sha256=$ExpectedSha256.ToLowerInvariant(); source_set_sha256=$manifest.source_set_sha256; application_version='1.4.1'; release_revision='2026-10-11.1'; draft=$true; publicly_released=$false; all_manifest_bytes_verified=$true; application_source_uploaded=$false } | ConvertTo-Json | Set-Content (Join-Path $destination 'candidate-receipt.json') -Encoding utf8
Write-Host 'SHA-locked draft candidate received and validated; no app executed.'
