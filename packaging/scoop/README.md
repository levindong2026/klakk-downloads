# Install Klakk with Scoop on Windows

This is a **Klakk-maintained custom Scoop bucket**, separate from Scoop’s main and Extras catalogs. It installs the official Windows app version **1.4.1**, internal revision **2026-10-11.1**, for your native architecture. The app version remains 1.4.1; the internal revision identifies the updated release files. It supports x64 and ARM64 on Windows 10/11; 32-bit Windows and Scoop global installation are unsupported.

Scoop selects the **61.1 MB x64** or **58.0 MB ARM64** package instead of downloading both architectures in the 116.9 MB universal installer. These packages carry the same app version and internal revision as the current website download; only the selected architecture is downloaded. File sizes use decimal MB, not a measured download-time or installation-speed claim. The original 1.4.1 files remain available; using an older channel package does not establish that the current website download is broken.

Find this bucket in [Scoop’s public app search](https://scoop.sh/#/apps?q=Klakk&o=false), with **All buckets** selected. To install, add the publisher bucket using the commands below.

The current Windows installer is **unsigned**. Scoop compares its SHA-256 with the publisher’s release checksum. This verifies the file against that release; it does not supply a publisher signature. Review the [published download and checksum](../../README.md#verify-the-download) before choosing to install.

## Install using an existing Scoop installation

Quit Klakk first. If you installed it manually or through another package manager, uninstall that copy through its existing method before switching. The manifest refuses a separately registered Klakk installation.

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoop downloads the architecture-specific official installer, checks its hash and runs it for the current Windows account inside Scoop’s version directory. The manifest rejects an architecture override that does not match the native Windows architecture. This is an installer-managed app, with a Windows uninstall registration, rather than a portable archive. Open **Klakk (Scoop)** in the Start menu; the app is not opened automatically during installation.

## What this app revision changes

The [published revision notes](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1) describe launch at login enabled by default for fresh installations, with an existing off choice preserved. You can turn it off in settings. During the three-day trial, a dismissible reminder offers to open the purchase screen; Restore Purchase appears beside Check activation. These are published app changes, not a new Scoop installation or upgrade test.

## Hear the first sound

In **General**, enable Klakk. In **Audio**, select one of the **14 sound packs**, set a comfortable volume and choose the **Output Device**. **System Default** uses the Windows default output. Type in another app to check playback. The [no-sound checklist](../../guides/klakk-no-sound.md#windows-check-playback-and-the-selected-output) covers the volume mixer, output and trial status.

The website Windows edition has a **three-day trial beginning at first launch**. Continued use costs **US$4.49 once for Windows**, plus applicable tax at Creem checkout. The website Mac edition and Mac App Store edition have separate purchases and licenses. Scoop does not supply a new free license or restart an existing trial. The Windows app processes keyboard events locally for playback and also makes usage and licensing communications. Typed text and raw key events are not uploaded; see the [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

[Preview the sounds before installing](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en) · [Windows details](https://tryklakk.com/en/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_en)

## Update or remove

Exit Klakk before either command. Keep one installation method; use Scoop to manage this copy rather than installing another copy over it.

```powershell
scoop update klakk
scoop uninstall klakk
```

Uninstall invokes the official native uninstaller and removes Scoop’s application shortcut and files. It retains settings and license data in `%LOCALAPPDATA%\Klakk`; removing the application is not a trial reset. If the Windows uninstall registration now belongs to a different installation, the manifest stops rather than invoking that other installation’s uninstaller.

## Verification and scope

The [Scoop verification workflow](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml) defines separate native x64 and ARM64 checks for the official Scoop JSON schema, selected release file and size, installation, native executable architecture, 14 packs, Start shortcut, foreign-install protections, same-version forced reinstall, retained settings and uninstall cleanup. The [previous successful native run](https://github.com/levindong2026/klakk-downloads/actions/runs/38083232203) checked the original 1.4.1 architecture-specific packages. It did not open the app and does not establish this revision’s Scoop upgrade path or audible playback. Any new validation must be reported with its actual package and scenario scope. QA downloads and installations are not customer downloads or installations.

Maintained by **Levin**, Klakk’s developer, with AI assistance. Application source remains private; this repository contains public distribution metadata and instructions. [日本語](README.ja.md) · [Scoop custom bucket documentation](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
