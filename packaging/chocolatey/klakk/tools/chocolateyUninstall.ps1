$ErrorActionPreference = 'Stop'

$productCode = '{398236E7-8E2E-4998-934F-5E54AFA110E1}_is1'
$entries = @(Get-UninstallRegistryKey -SoftwareName 'Klakk version *' | Where-Object { $_.PSChildName -eq $productCode })
if ($entries.Count -gt 1) {
    throw 'Multiple Klakk uninstall entries found; remove the application using Windows Installed apps.'
}
if ($entries.Count -eq 0) {
    Write-Warning 'No Klakk uninstall entry was found for this Windows account. No native uninstaller was invoked.'
    return
}

$uninstaller = $entries[0].UninstallString.Trim('"')
if (-not (Test-Path -LiteralPath $uninstaller -PathType Leaf)) {
    throw "Klakk uninstaller is missing: $uninstaller"
}

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    file           = $uninstaller
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
    validExitCodes = @(0)
}
Uninstall-ChocolateyPackage @packageArgs
