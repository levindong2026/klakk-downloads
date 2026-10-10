# Install Klakk with Scoop on Windows

This is a **Klakk-maintained custom Scoop bucket**, separate from Scoop’s main and Extras catalogs. It installs the same official Windows 1.4.1 installer used on the website. It supports native x64 and ARM64 on Windows 10/11; 32-bit Windows and Scoop global installation are unsupported.

Find this bucket in [Scoop’s public app search](https://scoop.sh/#/apps?q=Klakk&o=false), with **All buckets** selected. To install, add the publisher bucket using the commands below.

The current Windows installer is **unsigned**. Scoop compares its SHA-256 with the publisher’s release checksum. This verifies the file against that release; it does not supply a publisher signature. Review the [published download and checksum](../../README.md#verify-the-download) before choosing to install.

## Install using an existing Scoop installation

Quit Klakk first. If you installed it manually or through another package manager, uninstall that copy through its existing method before switching. The manifest refuses a separately registered Klakk installation.

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoop downloads the original installer, checks its hash and runs it for the current Windows account inside Scoop’s version directory. The universal installer selects the native architecture. This is an installer-managed app, with a Windows uninstall registration, rather than a portable archive. Open **Klakk (Scoop)** in the Start menu; the app is not opened automatically during installation.

## Hear the first sound

In **General**, enable Klakk. In **Audio**, select one of the **14 sound packs**, set a comfortable volume and choose the **Output Device**. **System Default** uses the Windows default output. Type in another app to check playback. The [no-sound checklist](../../guides/klakk-no-sound.md#windows-check-playback-and-the-selected-output) covers the volume mixer, output and trial status.

The website Windows edition has a **three-day trial beginning at first launch**. Continued use costs **US$4.49 once for Windows**, plus applicable tax at Creem checkout. The website Mac edition and Mac App Store edition have separate purchases and licenses. Scoop does not supply a new free license or restart an existing trial. The Windows app processes keyboard events locally for playback and also makes usage/settings and licensing communications; see the [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

[Preview the sounds before installing](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en) · [Windows details](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en)

## Update or remove

Exit Klakk before either command. Keep one installation method; use Scoop to manage this copy rather than installing another copy over it.

```powershell
scoop update klakk
scoop uninstall klakk
```

Uninstall invokes the official native uninstaller and removes Scoop’s application shortcut and files. It retains settings and license data in `%LOCALAPPDATA%\Klakk`; removing the application is not a trial reset. If the Windows uninstall registration now belongs to a different installation, the manifest stops rather than invoking that other installation’s uninstaller.

## Verification and scope

Native x64 and ARM64 verification **passed on 2026-10-10** ([full verification run](https://github.com/levindong2026/klakk-downloads/actions/runs/38023378531)). The verification checks the official Scoop JSON schema, real install, native executable architecture, 14 packs, Start shortcut, foreign-install protections, same-version forced reinstall, retained settings and uninstall cleanup. It never opens the app. A forced reinstall tests the current lifecycle; it does not prove a future-version upgrade or audible playback on every device. These checks are QA, not customer downloads or installations.

Maintained by **Levin**, Klakk’s developer, with AI assistance. Application source remains private; this repository contains public distribution metadata and instructions. [日本語](README.ja.md) · [Scoop custom bucket documentation](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
