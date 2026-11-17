$ErrorActionPreference = 'Stop'

if (-not [Environment]::Is64BitOperatingSystem) {
    throw 'Klakk requires 64-bit Windows (x64 or ARM64).'
}
$nativeArchitecture = if ($env:PROCESSOR_ARCHITEW6432) { $env:PROCESSOR_ARCHITEW6432 } else { $env:PROCESSOR_ARCHITECTURE }
if ($nativeArchitecture -notin @('AMD64', 'ARM64')) {
    throw "Unsupported Windows architecture: $nativeArchitecture"
}
$windowsVersion = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
if ($windowsVersion.CurrentMajorVersionNumber -lt 10) {
    throw 'Klakk requires Windows 10 or later.'
}

Write-Warning 'The Klakk 1.4.4 installer is unsigned. This package checks the official download SHA-256 before installing.'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    url            = 'https://downloads.tryklakk.com/Klakk-1.4.4-Windows-Setup.exe'
    checksum       = '65413b1048ff189186cfc683ed00feb6bc7e39f711930bb24e5a0a1eff54e406'
    checksumType   = 'sha256'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
