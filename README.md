# Klakk — keyboard sounds for Windows and Mac

Official downloads maintained by the Klakk developer. Klakk plays keyboard sounds while you type on your existing keyboard. It adds audio feedback; it does not change the feel or physical noise of your keys.

[日本語](README.ja.md) · [Website](https://tryklakk.com/en/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads) · [Try the sounds in your browser](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

## Download Klakk 1.4.1

| Platform | Requirements | Installer |
| --- | --- | --- |
| Windows | Windows 10 or 11, ARM64 or Intel/AMD x64; 32-bit Windows is unsupported | [Download Windows Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe) |
| Mac | macOS 14 or later, Apple silicon or Intel | [Download Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.1-23.dmg) |

[SHA-256 checksums](SHA256SUMS.txt). Prefer the main website? [Choose a download](https://tryklakk.com/en/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

If the main download host is unavailable, use the [official GitHub release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1): [Windows Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-Setup.exe) · [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-23.dmg). Both hosts provide the same files and checksums.

The full-featured trial lasts **3 days**. Continued use costs **US$4.49 once per platform**, with applicable tax handled at checkout. Mac and Windows are separate purchases. The direct-download editions use Creem checkout; the Mac App Store edition uses Apple's purchase flow.

## Install on Windows

1. Download `Klakk-1.4.1-Windows-Setup.exe`. One installer chooses the native ARM64 or x64 version automatically and includes its runtime.
2. The current Windows installer is **unsigned**. Review any Windows security warning and decide whether you trust the download before running it. The checksums below let you compare the file with this release; they do not substitute for publisher signing.
3. Run the installer, open Klakk, choose a sound pack and set a comfortable volume.
4. Type in another app to check playback. If you hear nothing, check playback is enabled, app/system volume and your audio output.

[Windows setup and troubleshooting](https://tryklakk.com/en/blog/windows-keyboard-sounds-arm64-x64-setup/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

## Install on Mac

1. Download and open `Klakk-1.4.1-23.dmg`.
2. Drag Klakk into Applications, then open the copy in Applications.
3. Follow Klakk's prompt to enable **System Settings → Privacy & Security → Input Monitoring**. Quit and reopen Klakk if macOS requests it.
4. Choose a sound pack and volume, then type in your usual writing app.

The DMG contains Klakk 1.4.1, build 23, signed with Developer ID and notarized by Apple. Input Monitoring lets the app react to keyboard events while you type in other apps. Read the [Mac privacy policy](https://tryklakk.com/en/privacy/) before granting access.

[Mac installation and troubleshooting](https://tryklakk.com/en/blog/mac-direct-download-install-guide/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

Already use Homebrew? The [Klakk-maintained Mac tap](https://github.com/levindong2026/homebrew-klakk) installs the same signed and notarized website edition. It passed installation checks on Apple silicon and Intel Macs. This is a publisher-maintained tap, separate from Homebrew's official cask catalog.

## Compare the 14 included sound packs

Both platforms include:

- Cherry MX Black, Blue, Brown and Red (PBT)
- Everglide Crystal Purple and Oreo
- Gateron Black Ink, Browns and Reds — Revolt
- Banana Split Lubed and Stock
- NovelKeys Cream
- Apex Pro TKL
- Razer Blackwidow Elite

[Listen before installing](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads). The browser preview plays only on that page; install the desktop app for sound while typing in other apps. Use headphones if you want to keep the added audio private.

## Verify the download

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `Klakk-1.4.1-Windows-Setup.exe` | 202233968 | `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454` |
| `Klakk-1.4.1-23.dmg` | 37897140 | `23c6b838f4e17e2ccddba1eb91927d0fe714403abcc512fca0545a013f5dfa51` |

On Windows, use PowerShell:

```powershell
Get-FileHash .\Klakk-1.4.1-Windows-Setup.exe -Algorithm SHA256
```

On Mac, use Terminal:

```sh
shasum -a 256 Klakk-1.4.1-23.dmg
```

## Support and repository contents

[Support](https://tryklakk.com/en/support/) · [Terms](https://tryklakk.com/en/terms/) · [Windows privacy](https://tryklakk.com/en/windows/privacy/)

This repository contains public download documentation, candidate package manifests and installer validation workflows. The application source remains private. GitHub's automatically generated “Source code” ZIP and tar.gz files contain repository files, not an installable app. To install Klakk, choose the `.exe` or `.dmg` release asset instead. Klakk remains subject to its product terms; publishing installers here does not grant an open-source license.

The files in `packaging/winget/` are a [draft candidate submission](https://github.com/microsoft/winget-pkgs/pull/448522) for the Windows Package Manager community repository. Their presence here does not mean Klakk is available through WinGet. Direct execution of the published installer passed on native x64 and ARM64 Windows. WinGet 1.29.380 validated the candidate manifests and installer hash on both architectures, but the install command timed out before installation could be confirmed. The separate unattended-runner timeout remains unresolved. Microsoft’s official validation for [submission #448522](https://github.com/microsoft/winget-pkgs/pull/448522) subsequently passed all ten checks, including Installation Validation and Installer Metadata Validation. The submission remains a draft pending the contributor’s CLA review and acceptance, and has not been merged into the catalog. These QA operations are not customer downloads or installations.
