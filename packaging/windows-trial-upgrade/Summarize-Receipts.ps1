param([Parameter(Mandatory)][string]$ReportDirectory,[Parameter(Mandatory)][ValidateSet('X64','Arm64')][string]$ExpectedArchitecture)
$ErrorActionPreference = 'Stop'
$root = [IO.Path]::GetFullPath($ReportDirectory)
New-Item -ItemType Directory -Force $root | Out-Null
$rows = @()
foreach ($language in @('en','ja','de','ar')) {
  $path = Join-Path $root "$language/qa-run-summary.json"
  if (Test-Path $path) {
    $receipt = Get-Content $path -Raw | ConvertFrom-Json
    $rows += [ordered]@{language=$language; fixture_completed=$receipt.fixture_completed; native_focus_complete=$receipt.native_focus_complete; native_pointer_effect_complete=$receipt.native_pointer_effect_complete; screenshots_require_actual_visual_review=$true}
  } else { $rows += [ordered]@{language=$language; fixture_completed=$null; native_focus_complete=$null; native_pointer_effect_complete=$null; screenshots_require_actual_visual_review=$true} }
}
$installerPath = Join-Path $root 'installer/native-installer-report.json'
$installer = if (Test-Path $installerPath) {(Get-Content $installerPath -Raw | ConvertFrom-Json).status} else {'unavailable'}
$summary = [ordered]@{
  architecture=$ExpectedArchitecture; public_version='1.4.1'; release_revision='2026-10-11.1'; language_fixtures=$rows;
  installer_status=$installer; screenshots_visually_reviewed=$false; physical_typing_verified=$null;
  actual_login_execution_verified=$null; native_startup_settings_toggle_verified=$null;
  paid_conversion_effect=$null; release_accepted=$false; publicly_released=$false
}
$summary | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $root 'native-summary.json') -Encoding utf8
if ($env:GITHUB_STEP_SUMMARY) {
  @(
    "### Windows $ExpectedArchitecture candidate receipts",
    "Installer fixture: $installer. Fixtures are synthetic and are not customer installs.",
    '| Language | Fixture completed | Foreground focus | Native pointer effect |',
    '|---|---|---|---|'
  ) | Add-Content $env:GITHUB_STEP_SUMMARY
  foreach ($row in $rows) {
    $cells = foreach ($key in @('fixture_completed','native_focus_complete','native_pointer_effect_complete')) { if ($null -eq $row[$key]) {'unavailable'} else {$row[$key].ToString()} }
    "| $($row.language) | $($cells[0]) | $($cells[1]) | $($cells[2]) |" | Add-Content $env:GITHUB_STEP_SUMMARY
  }
  'Screenshots await visual review. Physical typing, real login execution and the native startup settings toggle remain unverified. No release accepted or published by this workflow.' | Add-Content $env:GITHUB_STEP_SUMMARY
}
