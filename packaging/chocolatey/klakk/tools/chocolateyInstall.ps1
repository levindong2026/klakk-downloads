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

Write-Warning 'The Klakk 1.4.1 installer is unsigned. This package checks the official download SHA-256 before installing.'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    url            = 'https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe'
    checksum       = '7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454'
    checksumType   = 'sha256'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
