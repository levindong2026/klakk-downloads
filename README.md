# Klakk — keyboard sounds for Windows and Mac

Official downloads maintained by the Klakk developer. Klakk plays keyboard sounds while you type on your existing keyboard. It adds audio feedback; it does not change the feel or physical noise of your keys.

Klakk at **tryklakk.com** and Klack at **tryklack.com** are separate products. A Klack purchase does not activate Klakk. [Compare Klakk and Klack before buying](https://tryklakk.com/en/blog/klakk-vs-klack-keyboard-sound-apps/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads&utm_content=product_identity_en).

This identity note is maintained by Levin, Klakk's developer, with AI assistance.

[日本語](README.ja.md) · [Website](https://tryklakk.com/en/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads) · [Try the sounds in your browser](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

## Download Klakk 1.4.2

| Platform | Requirements | Official file | GitHub mirror |
| --- | --- | --- | --- |
| Windows | Windows 10 or 11, native x64 or ARM64 | [Windows Setup](https://downloads.tryklakk.com/Klakk-1.4.2-Windows-Setup.exe) · 116.9 MB | [Windows Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.2/Klakk-1.4.2-Windows-Setup.exe) |
| Mac | macOS 14 or later, Apple silicon or Intel | [Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.2-24.dmg) · 38.0 MB | [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.2/Klakk-1.4.2-24.dmg) |
| Mac ZIP | Same Mac website edition, build 24 | [Mac ZIP](https://downloads.tryklakk.com/Klakk-1.4.2-24.zip) · 36.0 MB | [Mac ZIP](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.2/Klakk-1.4.2-24.zip) |

[Release notes](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.2) · [1.4.2 SHA-256 checksums](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.2/SHA256SUMS.txt) · [Website download guide](https://tryklakk.com/en/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

The full-featured trial lasts **3 days from first launch**. The Mac and Windows website editions are separate one-time purchases at **US$6.99 each, plus applicable tax**. New website-edition purchases use Pancake checkout in the app. Each new Pancake license covers up to **3 devices on the same platform**. The Mac App Store edition uses Apple's purchase flow and has a separate license.

## Listen before installing

Compare all 14 included packs by clicking or tapping their preview buttons. Each button previews a single A-key sample. Use the keyboard demo on the same page to explore other keys, then choose a Mac or Windows trial from that page.

Prefer a short video? [Watch the 44-second English sound preview](https://www.youtube.com/watch?v=rkSXD7r3Dy4) for edited samples of Gateron Red, Cherry MX Blue and Banana Split Stock. The browser demo lets you try all 14 sound packs.

For a longer listen, [watch seven included Klakk sound packs in 80 seconds](https://github.com/user-attachments/assets/e095b634-fb1b-476f-81ec-f9c5aa0a7c3c). Each uses the same edited website-preview sequence; this is not live app playback or a latency test. [Read the complete copyright, MIT license and provenance notice for the seven recordings](docs/klakk-seven-included-sounds-en-NOTICE.txt). [Sequence guide and trial details](docs/seven-keyboard-sounds.md).

Installed but silent? The [Windows and Mac no-sound checklist for 1.4.1](guides/klakk-no-sound.md) covers playback, output, permissions and trial activation.

Recording with OBS? Use the [playback, capture and recording-track checklist](guides/keyboard-sounds-obs.md) to find where keyboard sounds stop.

Deciding whether to buy? Read [what free apps, optional paid packs and Klakk’s platform license include](docs/keyboard-sounds-worth-paying-for.md), then listen before choosing.

Want to understand the preview levels? Read the [original preview-file measurements and reproducible method](docs/keyboard-sound-preview-measurements.md), including the limits of comparing sounds at the same system volume.

## Install on Windows

1. Download `Klakk-1.4.2-Windows-Setup.exe`. One installer chooses the native ARM64 or x64 version automatically and includes its runtime.
2. The current Windows installer is **unsigned**. Review any Windows security warning and decide whether you trust the download before running it. The checksums below let you compare the file with this release; they do not substitute for publisher signing.
3. Run the installer and open Klakk. In **General**, turn on **Enable Klakk**. In **Audio**, choose a sound pack, set a comfortable volume and select your **Output Device**. **System Default** uses the Windows default output.
4. Type in another app to check playback. If you hear nothing, check the Windows volume mixer and the trial or license status, then follow the setup guide below.

[Windows setup and troubleshooting](https://tryklakk.com/en/blog/windows-keyboard-sounds-arm64-x64-setup/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

Already use Scoop? The [Klakk-maintained Windows bucket](packaging/scoop/README.md) installs website version 1.4.2 from the same universal installer. [Package checks](https://github.com/levindong2026/klakk-downloads/actions/runs/42089446872) passed on native x64 and ARM64 Windows. This custom source is separate from Scoop’s main and Extras catalogs.

## Install on Mac

1. Download and open `Klakk-1.4.2-24.dmg`.
2. Drag Klakk into Applications, then open the copy in Applications.
3. Follow Klakk's prompt to enable **System Settings → Privacy & Security → Input Monitoring**. Quit and reopen Klakk if macOS requests it.
4. Choose a sound pack and volume, then type in your usual writing app.

The DMG contains Klakk 1.4.2, build 24, signed with Developer ID and notarized by Apple. Input Monitoring lets the app react to keyboard events while you type in other apps. Read the [Mac privacy policy](https://tryklakk.com/en/privacy/) before granting access.

[Mac installation and troubleshooting](https://tryklakk.com/en/blog/mac-direct-download-install-guide/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads).

Already use Homebrew? The [Klakk-maintained Mac tap](https://github.com/levindong2026/homebrew-klakk) installs the same signed and notarized website edition. [Homebrew checks](https://github.com/levindong2026/homebrew-klakk/actions/runs/42089541789) passed on Apple silicon and Intel Macs. This is a publisher-maintained tap, separate from Homebrew's official cask catalog.

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

The [Windows 1.4.1 verification checklist](docs/windows-download-verification.md) is an older reference. For 1.4.2, use the current checksums and commands below.

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `Klakk-1.4.2-Windows-Setup.exe` | 116935383 | `f76c9717f5c8c127ae638d3826db1e890295455dedf26700dfae8f7021ed96a8` |
| `Klakk-1.4.2-24.dmg` | 37967353 | `625608969133c6930cbdd3d52082c58104e189f04832b9834dc186e360f0b601` |
| `Klakk-1.4.2-24.zip` | 36011674 | `1a706fc7043ec72dc3e9ad5dfa32d4e9d748342327ed2bce5c7a17f51921531e` |

On Windows, use PowerShell:

Open it in the folder where you saved the installer. These commands read the file and print its byte count and hash; they do not run the installer.

```powershell
(Get-Item -LiteralPath '.\Klakk-1.4.2-Windows-Setup.exe').Length
Get-FileHash -LiteralPath '.\Klakk-1.4.2-Windows-Setup.exe' -Algorithm SHA256 | Format-List Algorithm,Hash
```

The first command prints the byte count. The second prints the complete hash. If your browser renamed the installer, use the filename it saved and compare the result with the matching row above. Renaming a file does not change its hash.

On Mac, use Terminal:

Run these commands in the folder where you saved the DMG. For the Mac ZIP, substitute its filename and compare against the ZIP row.

```sh
stat -f '%z' 'Klakk-1.4.2-24.dmg'
shasum -a 256 'Klakk-1.4.2-24.dmg'
```

The first Mac command prints the byte count; the second prints the SHA-256 and filename. Compare the byte count and the entire hash with the matching row in the table. Uppercase and lowercase hexadecimal letters represent the same hash. If it differs, obtain the file again from the official release before running it. A matching checksum does not replace publisher signing. See Microsoft's [Get-FileHash documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-5.1). These verification instructions are maintained by Levin, the Klakk developer, with AI-assisted writing.

## Support and repository contents

[Support](https://tryklakk.com/en/support/) · [Terms](https://tryklakk.com/en/terms/) · [Windows privacy](https://tryklakk.com/en/windows/privacy/)

This repository contains public download documentation, candidate package manifests and installer validation workflows. The application source remains private. GitHub's automatically generated “Source code” ZIP and tar.gz files contain repository files, not an installable app. To install Klakk, choose the named `.exe`, `.dmg` or Mac app `.zip` release asset instead. Klakk remains subject to its product terms; publishing installers here does not grant an open-source license.

The [WinGet 1.4.2 submission](https://github.com/microsoft/winget-pkgs/pull/453697) is open and has not been merged into the community catalog. The public [Chocolatey listing](https://community.chocolatey.org/packages/klakk/1.4.1) still provides Windows 1.4.1. For Windows 1.4.2 use the direct download or the Klakk-maintained Scoop bucket above.

## Download Klakk 1.4.1

These files are historical. For a new installation or update, use 1.4.2 above.

The later 1.4.1 website revision (2026-10-11.1) and its exact file hashes are listed in the [revision archive](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1). The files below are the earlier 1.4.1 release.

| Platform | Requirements | Installer |
| --- | --- | --- |
| Windows | Windows 10 or 11, ARM64 or Intel/AMD x64; 32-bit Windows is unsupported | [Download Windows Setup](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe) |
| Mac | macOS 14 or later, Apple silicon or Intel | [Download Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.1-23.dmg) |

[Historical 1.4.1 SHA-256 checksums](SHA256SUMS.txt).

The [1.4.1 GitHub archive](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1) also contains [Windows Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-Setup.exe) · [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-23.dmg). Both archives provide the same files and checksums.

<details>
<summary>Archived 1.4.1 Windows installers by architecture</summary>

For **64-bit Windows 10/11**, check **Settings → System → About → System type**. If unsure, choose the universal Windows Setup in this archive; it selects the native architecture automatically.

| Processor | Optional 1.4.1 installer | Download size |
| --- | --- | ---: |
| Intel / AMD x64 | [Download x64 Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-x64-Setup.exe) | 105.4 MB |
| ARM64 | [Download ARM64 Setup](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-arm64-Setup.exe) | 99.1 MB |

Each carries the same **Klakk 1.4.1 application, runtime and 14 sound packs** for one processor type. They require a smaller download than the 202.2 MB universal installer; the installed app files are unchanged. These Windows installers remain **unsigned**.

Use the [separate native-installer checksum file](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/SHA256SUMS-windows-native.txt) for these two files. The [native runner validation](https://github.com/levindong2026/klakk-downloads/actions/runs/38068672800) checked all 382 payload files, installation, reinstallation, wrong-architecture refusal and uninstall. Klakk was not launched during QA; the checks establish packaging integrity, not customer installations or performance.

[Windows requirements and setup](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads&utm_content=native_installer_options_en).

</details>

### Earlier 1.4.1 checksums

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `Klakk-1.4.1-Windows-Setup.exe` | 202233968 | `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454` |
| `Klakk-1.4.1-23.dmg` | 37897140 | `23c6b838f4e17e2ccddba1eb91927d0fe714403abcc512fca0545a013f5dfa51` |
| `Klakk-1.4.1-Windows-x64-Setup.exe` | 105364092 | `78cab2a64966ffa8d1c30e5d341980d2858e090ecd5f950a0faeea9ef163eb10` |
| `Klakk-1.4.1-Windows-arm64-Setup.exe` | 99090001 | `60bc18171d8b11988ea170b58fe5e038d8f7f6c1132e83b98a7d2f413b333a78` |
