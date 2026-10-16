# Klakk — keyboard sounds for Windows and Mac

Official downloads maintained by the Klakk developer. Klakk plays keyboard sounds while you type on your existing keyboard. It adds audio feedback; it does not change the feel or physical noise of your keys.

[日本語](README.ja.md) · [Website](https://tryklakk.com/en/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads) · [Try the sounds in your browser](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

Prefer a short video? [Watch the 44-second English sound preview](https://www.youtube.com/watch?v=rkSXD7r3Dy4) for edited samples of Gateron Red, Cherry MX Blue and Banana Split Stock. The browser demo lets you try all 14 sound packs.

Installed but silent? Use the [Windows and Mac no-sound checklist](guides/klakk-no-sound.md) to check playback, output, permissions and trial activation.

Recording with OBS? Use the [playback, capture and recording-track checklist](guides/keyboard-sounds-obs.md) to find where keyboard sounds stop.

Deciding whether to buy? Read [what free apps, optional paid packs and Klakk’s platform license include](docs/keyboard-sounds-worth-paying-for.md), then listen before choosing.

Want to understand the preview levels? Read the [original preview-file measurements and reproducible method](docs/keyboard-sound-preview-measurements.md), including the limits of comparing sounds at the same system volume.

## Current website revision — 2026-10-11.1

The Mac and Windows website editions are still **1.4.1** (Mac build **23**). Use these revision-specific files for the latest direct-download update: default launch at login for fresh installations, a dismissible trial reminder with an Unlock action, and Restore Purchase beside Check activation. Existing startup-off choices are preserved. The trial is still three days from first launch; US$4.49 once per platform plus applicable tax, with separate platform and App Store licenses.

| Platform | Current file |
| --- | --- |
| Windows automatic x64/ARM64 | [Download Windows Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup-r20261011.1.exe) |
| Windows x64, smaller installer | [Download x64 Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-x64-Setup-r20261011.1.exe) |
| Windows ARM64, smaller installer | [Download ARM64 Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-arm64-Setup-r20261011.1.exe) |
| Mac, Apple silicon or Intel | [Download Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.1-23-r20261011.1.dmg) |

[Current GitHub mirror and exact SHA-256 checksums](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1). Windows installers remain unsigned. The Mac application is notarized and stapled; its signed DMG container is not separately notarized. The installed app requires macOS14+ or Windows10/11 on x64/ARM64.

The older files below, their checksums and package-manager pins remain unchanged. They are earlier 1.4.1 files, not this internal revision. Website sound previews and all 14 included packs remain available.

## Earlier 1.4.1 files and installation reference

| Platform | Requirements | Installer |
| --- | --- | --- |
| Windows | Windows 10 or 11, ARM64 or Intel/AMD x64; 32-bit Windows is unsupported | [Download Windows Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe) |
| Mac | macOS 14 or later, Apple silicon or Intel | [Download Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.1-23.dmg) |

[SHA-256 checksums](SHA256SUMS.txt). Prefer the main website? [Choose a download](https://tryklakk.com/en/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

If the main download host is unavailable, use the [official GitHub release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1): [Windows Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-Setup.exe) · [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-23.dmg). Both hosts provide the same files and checksums.

<details>
<summary>Smaller Windows downloads if you know your processor type</summary>

For **64-bit Windows 10/11**, check **Settings → System → About → System type**. If unsure, choose the universal Windows Setup above; it selects the native architecture automatically.

| Processor | Optional 1.4.1 installer | Download size |
| --- | --- | ---: |
| Intel / AMD x64 | [Download x64 Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-x64-Setup.exe) | 105.4 MB |
| ARM64 | [Download ARM64 Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-arm64-Setup.exe) | 99.1 MB |

Each carries the same **Klakk 1.4.1 application, runtime and 14 sound packs** for one processor type. They require a smaller download than the 202.2 MB universal installer; the installed app files are unchanged. These Windows installers remain **unsigned**.

Use the [separate native-installer checksum file](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/SHA256SUMS-windows-native.txt) for these two files. The [native runner validation](https://github.com/levindong2026/klakk-downloads/actions/runs/38068672800) checked all 382 payload files, installation, reinstallation, wrong-architecture refusal and uninstall. Klakk was not launched during QA; the checks establish packaging integrity, not customer installations or performance.

[Windows requirements and setup](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads&utm_content=native_installer_options_en).

</details>

The full-featured trial lasts **3 days**. Continued use costs **US$4.49 once per platform**, with applicable tax handled at checkout. Mac and Windows are separate purchases. The direct-download editions use Creem checkout; the Mac App Store edition uses Apple's purchase flow.

## Install on Windows

1. Download `Klakk-1.4.1-Windows-Setup.exe`. One installer chooses the native ARM64 or x64 version automatically and includes its runtime.
2. The current Windows installer is **unsigned**. Review any Windows security warning and decide whether you trust the download before running it. The checksums below let you compare the file with this release; they do not substitute for publisher signing.
3. Run the installer and open Klakk. In **General**, turn on **Enable Klakk**. In **Audio**, choose a sound pack, set a comfortable volume and select your **Output Device**. **System Default** uses the Windows default output.
4. Type in another app to check playback. If you hear nothing, use the [no-sound checklist](guides/klakk-no-sound.md#windows-check-playback-and-the-selected-output), including the Windows volume mixer and trial or purchased status.

[Windows setup and troubleshooting](https://tryklakk.com/en/blog/windows-keyboard-sounds-arm64-x64-setup/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

Already use Scoop? The [Klakk-maintained Windows bucket](packaging/scoop/README.md) installs website version 1.4.1 with native x64 and ARM64 support. Installation, same-version reinstall and uninstall passed on both architectures. This custom source is separate from Scoop’s main and Extras catalogs.

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

Check the saved file against the row for the installer you chose. Compare its byte count and the entire SHA-256 value before opening it. A completed download or a matching filename alone does not perform this comparison.

Before opening a Windows installer, use the [source, signature and security-alert checklist](docs/windows-download-verification.md) alongside the file comparison below.

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `Klakk-1.4.1-Windows-Setup.exe` | 202233968 | `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454` |
| `Klakk-1.4.1-23.dmg` | 37897140 | `23c6b838f4e17e2ccddba1eb91927d0fe714403abcc512fca0545a013f5dfa51` |
| `Klakk-1.4.1-Windows-x64-Setup.exe` | 105364092 | `78cab2a64966ffa8d1c30e5d341980d2858e090ecd5f950a0faeea9ef163eb10` |
| `Klakk-1.4.1-Windows-arm64-Setup.exe` | 99090001 | `60bc18171d8b11988ea170b58fe5e038d8f7f6c1132e83b98a7d2f413b333a78` |

On Windows, use PowerShell:

Open it in the folder where you saved the installer. These commands read the file and print its byte count and hash; they do not run the installer.

```powershell
(Get-Item -LiteralPath '.\Klakk-1.4.1-Windows-Setup.exe').Length
Get-FileHash -LiteralPath '.\Klakk-1.4.1-Windows-Setup.exe' -Algorithm SHA256 | Format-List Algorithm,Hash
```

The first command prints the byte count. The second prints the complete hash. For an optional x64 or ARM64 installer, or a file your browser renamed, replace the filename with the file you saved and compare its result with the matching row above. Renaming a file does not change its hash.

On Mac, use Terminal:

Run these commands in the folder where you saved the DMG, or replace the filename with its full path.

```sh
stat -f '%z' 'Klakk-1.4.1-23.dmg'
shasum -a 256 'Klakk-1.4.1-23.dmg'
```

The first Mac command prints the byte count; the second prints the SHA-256 and filename. Compare the byte count and the entire hash with the matching row in the table. Uppercase and lowercase hexadecimal letters represent the same hash. If it differs, obtain the file again from the official release before running it. A matching checksum does not replace publisher signing. See Microsoft's [Get-FileHash documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-5.1). These verification instructions are maintained by Levin, the Klakk developer, with AI-assisted writing.

## Support and repository contents

[Support](https://tryklakk.com/en/support/) · [Terms](https://tryklakk.com/en/terms/) · [Windows privacy](https://tryklakk.com/en/windows/privacy/)

This repository contains public download documentation, candidate package manifests and installer validation workflows. The application source remains private. GitHub's automatically generated “Source code” ZIP and tar.gz files contain repository files, not an installable app. To install Klakk, choose the `.exe` or `.dmg` release asset instead. Klakk remains subject to its product terms; publishing installers here does not grant an open-source license.

The files in `packaging/winget/` are a [candidate submission](https://github.com/microsoft/winget-pkgs/pull/448522) for the Windows Package Manager community repository. Their presence here does not mean Klakk is available through WinGet. Direct execution of the published installer passed on native x64 and ARM64 Windows. WinGet 1.29.380 validated the candidate manifests and installer hash on both architectures, but the install command timed out before installation could be confirmed. The separate unattended-runner timeout remains unresolved. Microsoft’s official validation for [submission #448522](https://github.com/microsoft/winget-pkgs/pull/448522) subsequently passed all ten checks, including Installation Validation and Installer Metadata Validation. The CLA check has also passed, and the submission is ready for moderator review. It has not been merged into the catalog. These QA operations are not customer downloads or installations.

The [Chocolatey package](packaging/chocolatey/README.md) for Windows 1.4.1 passed build, installation and explicit uninstall on native x64 and ARM64 Windows using Chocolatey CLI 2.7.4. It was submitted to the Chocolatey Community Repository on 2026-10-09 and [approved by a moderator on 2026-10-12](https://community.chocolatey.org/packages/klakk/1.4.1), as displayed on the public package page verified on 2026-10-16. That page lists `choco install klakk` as its community installation command. The approved package still pins the earlier `Klakk-1.4.1-Windows-Setup.exe`, SHA-256 `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454`. It does not install website revision 2026-10-11.1; use the separate current-revision downloads above for that update.
