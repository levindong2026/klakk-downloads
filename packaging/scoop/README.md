# Install Klakk with Scoop on Windows

This is a **Klakk-maintained custom Scoop bucket**, separate from Scoop’s main and Extras catalogs. It installs the official Windows app version **1.4.2** on x64 and ARM64 with Windows 10/11. 32-bit Windows and Scoop global installation are unsupported.

Both architectures use the same **116.9 MB** [official installer](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.2). Setup selects the native build for your PC. The previous architecture-specific 1.4.1 packages remain available in their original release.

Find this bucket in [Scoop’s public app search](https://scoop.sh/#/apps?q=Klakk&o=false), with **All buckets** selected. To install, add the publisher bucket using the commands below.

The current Windows installer is **unsigned**. Scoop compares its SHA-256 with the publisher’s release checksum. This verifies the file against that release; it does not supply a publisher signature. Review the [published download and checksum](../../README.md#verify-the-download) before choosing to install.

## Install using an existing Scoop installation

Quit Klakk first. If you installed it manually or through another package manager, uninstall that copy through its existing method before switching. The manifest refuses a separately registered Klakk installation.

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoop downloads the official universal installer, checks its hash and runs it for the current Windows account inside Scoop’s version directory. The manifest rejects an architecture override that does not match the native Windows architecture. This is an installer-managed app, with a Windows uninstall registration, rather than a portable archive. Open **Klakk (Scoop)** in the Start menu; the app is not opened automatically during installation.

## What changes in 1.4.2

The [1.4.2 release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.2) uses Pancake checkout. A new Windows purchase supports up to three Windows devices. After a purchase, you can copy its recovery code from **About**.

## Hear the first sound

In **General**, enable Klakk. In **Audio**, select one of the **14 sound packs**, set a comfortable volume and choose the **Output Device**. **System Default** uses the Windows default output. Type in another app to check playback. The [no-sound checklist](../../guides/klakk-no-sound.md#windows-check-playback-and-the-selected-output) covers the volume mixer, output and trial status.

The website Windows edition has a **three-day trial beginning at first launch**. Continued use costs **US$6.99 once for Windows**, plus applicable tax at Pancake checkout. A new Windows license supports up to three Windows devices. The website Mac edition and Mac App Store edition have separate purchases and licenses. Scoop does not supply a new free license or restart an existing trial. The Windows app processes keyboard events locally for playback and also makes usage and licensing communications. Typed text and raw key events are not uploaded; see the [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

[Preview the sounds before installing](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en) · [Windows details](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en)

## Update or remove

Exit Klakk before either command. Keep one installation method; use Scoop to manage this copy rather than installing another copy over it.

```powershell
scoop update klakk
scoop uninstall klakk
```

Uninstall invokes the official uninstaller and removes Scoop’s application shortcut and files. It retains settings and license data in `%LOCALAPPDATA%\Klakk`; removing the application is not a trial reset. If the Windows uninstall registration now belongs to a different installation, the manifest stops rather than invoking that other installation’s uninstaller.

## Verification and scope

The [Scoop verification workflow](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml) checks the official manifest schema, an upgrade from the previous published bucket version, a clean install and uninstall on native x64 and ARM64. It checks the installer SHA-256 and size, the installed executable architecture, the 14 sound packs and Start shortcut. It also checks protections for other installations and that a test marker in the app-data directory is retained.

The [23 October 2026 run](https://github.com/levindong2026/klakk-downloads/actions/runs/39960328980) tested the previous 1.4.1 revision. Scoop package tests do not establish audible playback, complete settings retention or payment.

Maintained by **Levin**, Klakk’s developer, with AI assistance. Application source remains private; this repository contains public distribution metadata and instructions. [日本語](README.ja.md) · [Scoop custom bucket documentation](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
