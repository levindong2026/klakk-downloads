param(
  [Parameter(Mandatory=$true)][string]$BinaryPath,
  [Parameter(Mandatory=$true)][string]$OutputDirectory,
  [ValidateSet("en","ja","zh-Hans","ko","de","fr","es","pt","ru","hi","ar")][string]$Language = "en"
)
$ErrorActionPreference = 'Stop'
$qaBinary = (Resolve-Path $BinaryPath).Path
$qaAssembly = Join-Path (Split-Path $qaBinary) 'Klakk.Windows.dll'
if (-not (Test-Path $qaAssembly)) { throw 'Managed QA assembly missing' }
$qaHex = [BitConverter]::ToString([IO.File]::ReadAllBytes($qaAssembly))
$qaMarker = [BitConverter]::ToString([Text.Encoding]::Unicode.GetBytes('--trial-tip-smoke'))
if (-not $qaHex.Contains($qaMarker)) { throw 'Refusing to run a release assembly as QA; marker absent' }
$qaOutput = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $qaOutput | Out-Null
$qaArguments = '--trial-tip-smoke --qa-language ' + $Language + ' --qa-output "' + $qaOutput + '"'
$qaProcess = Start-Process -FilePath $qaBinary -ArgumentList $qaArguments -PassThru -Wait -RedirectStandardError (Join-Path $qaOutput 'stderr.txt')
$qaReportPath = Join-Path $qaOutput 'trial-tip-smoke-report.json'
if (-not (Test-Path $qaReportPath)) { throw 'Native fixture produced no receipt; inspect stderr' }
$qaReport = Get-Content -Raw $qaReportPath | ConvertFrom-Json
if ($qaProcess.ExitCode -ne 0 -or $qaReport.status -ne 'native_fixture_completed') { throw 'Native fixture failed; inspect receipt' }
if (-not $qaReport.fixture -or $qaReport.production_network -or $qaReport.network_attempts -ne 0 -or $qaReport.physical_keyboard_tested) {
  throw 'Fixture isolation/coverage receipt is invalid'
}
$qaSummary = [ordered]@{
  binary_sha256 = (Get-FileHash $qaBinary -Algorithm SHA256).Hash
  assembly_sha256 = (Get-FileHash $qaAssembly -Algorithm SHA256).Hash
  fixture_completed = $true
  native_focus_complete = ($qaReport.focus_status -eq 'passed')
  native_pointer_effect_complete = ($qaReport.pointer_status -eq 'sent_native_input')
  physical_keyboard_tested = $false
  real_hour_wait_tested = $false
  release_accepted = $false
}
$qaSummary | ConvertTo-Json | Set-Content -Encoding UTF8 (Join-Path $qaOutput 'qa-run-summary.json')
if (-not $qaSummary.native_focus_complete -or -not $qaSummary.native_pointer_effect_complete) {
  Write-Warning 'Some native interaction gates are unavailable; fixture completion does not establish release acceptance.'
}
Write-Host 'Fixture completed. Review native focus/pointer gates, screenshots, and separate installer/physical-key acceptance.'
