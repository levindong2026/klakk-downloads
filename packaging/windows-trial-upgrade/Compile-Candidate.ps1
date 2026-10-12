param([Parameter(Mandatory)][string]$BundleDirectory, [Parameter(Mandatory)][string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$bundle = (Resolve-Path $BundleDirectory).Path
$output = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force $output | Out-Null
$compiler = Join-Path ${env:ProgramFiles(x86)} 'Inno Setup 6\ISCC.exe'
if (-not (Test-Path $compiler)) { throw 'Runner-provided Inno Setup 6 compiler unavailable; do not install paid tooling' }
$manifest = Get-Content (Join-Path $bundle 'candidate-manifest.json') -Raw | ConvertFrom-Json
$packaging = Join-Path $bundle 'packaging'
$payload = Join-Path $bundle 'production'
$specs = @(
  @{script='installer-universal.iss'; suffix='Windows-Setup'},
  @{script='installer-win-x64.iss'; suffix='win-x64-Setup'},
  @{script='installer-win-arm64.iss'; suffix='win-arm64-Setup'}
)
$records = @()
Push-Location $packaging
try {
  foreach ($spec in $specs) {
    $name = "Klakk-1.4.1-$($spec.suffix)-rev-2026-10-11.1"
    $log = Join-Path $output "$name-compile.log"
    & $compiler "/DPublishRoot=$payload" "/O$output" "/F$name" $spec.script *> $log
    if ($LASTEXITCODE -ne 0) { throw "Inno compile failed; see $name-compile.log" }
    $file = Get-Item (Join-Path $output "$name.exe")
    $records += [ordered]@{ name=$file.Name; bytes=$file.Length; sha256=(Get-FileHash $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant() }
  }
} finally { Pop-Location }
[ordered]@{ application_version='1.4.1'; release_revision='2026-10-11.1'; source_set_sha256=$manifest.source_set_sha256; compiler_version=(Get-Item $compiler).VersionInfo.FileVersion; installers=$records; publicly_released=$false; contains_qa_payload=$false } | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $output 'build-integrity.json') -Encoding utf8
Write-Host 'Three revision-distinct installers compiled from production bytes only.'
