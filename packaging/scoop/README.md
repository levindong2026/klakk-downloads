# Install Klakk with Scoop on Windows

This is a **Klakk-maintained custom Scoop bucket**, separate from Scoop’s main and Extras catalogs. It installs the official Windows app version **1.4.4** on supported Windows 10 and 11 PCs with native x64 or ARM64. 32-bit Windows and Scoop global installation are unsupported.

The installer includes .NET 10. On Windows 10, [check .NET 10 support for your edition and version](https://learn.microsoft.com/en-us/dotnet/core/install/windows#supported-versions) before installing. The installer cannot install Klakk in [Windows S mode](https://support.microsoft.com/en-us/windows/experience/platform-variants/switching-out-of-s-mode-in-windows).

Both architectures use the same **116.9 MB** [official installer](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.4). Setup selects the native build for your PC. The previous architecture-specific 1.4.1 packages remain available in their original release.

Find this bucket in [Scoop’s public app search](https://scoop.sh/#/apps?q=Klakk&o=false), with **All buckets** selected. To install, add the publisher bucket using the commands below.

The current Windows installer is **unsigned**. Scoop compares its SHA-256 with the publisher’s release checksum. This verifies the file against that release; it does not supply a publisher signature. Review the [published download and checksum](../../README.md#verify-the-download) before choosing to install.

## Install using an existing Scoop installation

Quit Klakk first. If you installed it manually or through another package manager, uninstall that copy through its existing method before switching. The manifest refuses a separately registered Klakk installation.

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoop downloads the official universal installer, checks its hash and runs it for the current Windows account inside Scoop’s version directory. The manifest rejects an architecture override that does not match the native Windows architecture. This is an installer-managed app, with a Windows uninstall registration, rather than a portable archive. Open **Klakk (Scoop)** in the Start menu; the app is not opened automatically during installation.

## Purchases and updates in 1.4.4

In [1.4.4](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.4), an update-required purchase response provides a **Download Update** button to the official Windows page. For this Scoop-managed copy, follow the Scoop update steps below. New purchases still open Creem checkout through tryklakk.com and return to Klakk for activation. Existing Pancake and Creem licenses remain supported. A new Windows purchase supports up to three Windows devices.

## Hear the first sound

In **General**, enable Klakk. In **Audio**, select one of the **14 sound packs**, set a comfortable volume and choose the **Output Device**. **System Default** uses the Windows default output. Type in another app to check playback. The [no-sound checklist](https://tryklakk.com/en/blog/windows-keyboard-sounds-arm64-x64-setup/#if-klakk-has-no-sound) covers the volume mixer, output and trial status.

The website Windows edition has a **three-day trial beginning at first launch**. Continued use costs **US$6.99 once for Windows**, plus applicable tax at Creem checkout. A new Windows license supports up to three Windows devices. The website Mac edition and Mac App Store edition have separate purchases and licenses. Scoop does not supply a new free license or restart an existing trial. The Windows app processes keyboard events locally for playback and also makes usage and licensing communications. Typed text and raw key events are not uploaded; see the [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

[Preview the sounds before installing](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en) · [Windows details](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en)

## Update or remove

Exit Klakk before updating or removing it. Continue to manage this copy through Scoop.

To update Klakk, refresh Scoop and its bucket definitions first, then update the app.

```powershell
scoop update
scoop update klakk
```

To remove Klakk, run this command separately.

```powershell
scoop uninstall klakk
```

Uninstall invokes the official uninstaller and removes Scoop’s application shortcut and files. It retains settings and license data in `%LOCALAPPDATA%\Klakk`; removing the application is not a trial reset. If the Windows uninstall registration now belongs to a different installation, the manifest stops rather than invoking that other installation’s uninstaller.

## Verification and scope

The [Scoop verification workflow](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml) checks the official manifest schema, an upgrade from the previous published bucket version, a clean install and uninstall on native x64 and ARM64. It checks the installer SHA-256 and size, the installed executable architecture, the 14 sound packs and Start shortcut. It also checks protections for other installations and that a test marker in the app-data directory is retained.

The [22 November 2026 run](https://github.com/levindong2026/klakk-downloads/actions/runs/45019558379) verified a Scoop upgrade from 1.4.3 to 1.4.4, a clean install, a forced reinstall and an uninstall on native Windows x64 and ARM64 runners. It checked app-data marker retention and uninstall cleanup without launching Klakk.

The [5 November 2026 run](https://github.com/levindong2026/klakk-downloads/actions/runs/42089446872) verified a normal upgrade from the previous Scoop revision, a clean install, a forced reinstall and an uninstall for 1.4.2 on native x64 and ARM64 without launching Klakk or making a payment.

The [23 October 2026 run](https://github.com/levindong2026/klakk-downloads/actions/runs/39960328980) tested the previous 1.4.1 revision. Scoop package tests do not establish audible playback, complete settings retention or payment.

Maintained by **Levin**, Klakk’s developer, with AI assistance. Application source remains private; this repository contains public distribution metadata and instructions. [日本語](README.ja.md) · [Scoop custom bucket documentation](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
