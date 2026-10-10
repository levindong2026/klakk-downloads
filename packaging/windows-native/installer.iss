#ifndef PayloadRoot
  #error PayloadRoot is required
#endif
#ifndef OutputRoot
  #error OutputRoot is required
#endif
#ifndef NativeArch
  #error NativeArch is required
#endif
#if NativeArch == "x64"
  #define AllowedArchitectures "x64compatible and not arm64"
#elif NativeArch == "arm64"
  #define AllowedArchitectures "arm64"
#else
  #error Unsupported architecture
#endif

; Packaging-only candidate. Payload files come from the hash-pinned official
; universal installer, never from the older application candidate ZIPs.
[Setup]
AppId={{398236E7-8E2E-4998-934F-5E54AFA110E1}
AppName=Klakk
AppVersion=1.4.1
AppPublisher=Klakk
AppPublisherURL=https://tryklakk.com/
DefaultDirName={localappdata}\Programs\Klakk
DefaultGroupName=Klakk
PrivilegesRequired=lowest
ArchitecturesAllowed={#AllowedArchitectures}
MinVersion=10.0
OutputDir={#OutputRoot}
OutputBaseFilename=Klakk-1.4.1-Windows-{#NativeArch}-Setup
SetupIconFile=klakk.ico
UninstallDisplayIcon={app}\Klakk.Windows.exe
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
RestartApplications=no
AppMutex=Local\Klakk.Windows.398236E7-8E2E-4998-934F-5E54AFA110E1

[Files]
Source: "{#PayloadRoot}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Klakk"; Filename: "{app}\Klakk.Windows.exe"

[Run]
Filename: "{app}\Klakk.Windows.exe"; Description: "Launch Klakk"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then
    RegDeleteValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Run', 'Klakk');
end;
