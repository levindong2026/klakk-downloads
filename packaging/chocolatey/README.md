# Klakk Chocolatey package

This developer-maintained package for the Windows direct edition, version 1.4.1, was submitted to the Chocolatey Community Repository on **2026-10-09**. The [public package page](https://community.chocolatey.org/packages/klakk/1.4.1), verified on **2026-10-16**, states that a moderator approved it on **2026-10-12**. It lists `choco install klakk` as the community installation command.

The approved package pins the earlier official `Klakk-1.4.1-Windows-Setup.exe`, SHA-256 `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454`, from the [original 1.4.1 release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1). It does **not** install website revision **2026-10-11.1**. That newer revision is a [separate direct download](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1); its different installer and checksum must not be substituted for this package's pinned file.

The package contains metadata and two PowerShell installer scripts. It downloads the official universal installer from `downloads.tryklakk.com` and verifies its pinned SHA-256. It does not contain the application source or installer binary.

Klakk is proprietary software with a three-day trial from first launch. Continued use requires a Windows license, US$4.49 once plus applicable taxes. The current installer is unsigned. Installation is per Windows account; use the same account to install and uninstall. See the [product terms](https://tryklakk.com/en/terms/) and [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

## Build and test

Use a disposable Windows test machine with the official free Chocolatey CLI. From `packaging/chocolatey/klakk`:

Current source prepares candidate package **1.4.1.20261016** for website revision **2026-10-11.1**; the application version remains **1.4.1**. This candidate has **not been submitted or approved**. Its clean-install and old-package-upgrade checks on both architectures still require a successful run of the candidate validation workflow. The approved **1.4.1** package described above remains unchanged.

```powershell
choco pack .\klakk.nuspec
choco install klakk --version 1.4.1.20261016 --source . --yes
choco uninstall klakk --yes --skip-autouninstaller
```

The uninstall command disables Chocolatey's automatic fallback for this test so that the package's own removal script is exercised. Silent installation does not start Klakk. These are QA operations, not customer growth.

The manual [candidate validation workflow](../../.github/workflows/chocolatey-package-validation.yml) builds and inspects the package, then tests installation and explicit uninstall on native x64 and ARM64 Windows runners. No upload to the community repository is performed by the workflow. Build success and installation tests do not establish community approval, real users or completed customer downloads.

On 2026-10-08, [run 37859312707](https://github.com/levindong2026/klakk-downloads/actions/runs/37859312707) passed on both architectures with Chocolatey CLI 2.7.4. It verified the package contents, official installer checksum, per-user registry version 1.4.1, native executable architecture, 14 sound packs, no running app after silent installation, and removal through the explicit uninstall script. The tested package was retained as a workflow artifact. This was hosted-runner QA, not a physical playback test or community approval.

## Submission requirements

Chocolatey's official [package rules](https://docs.chocolatey.org/en-us/create/create-packages/) allow trial software when the description explains its activation and trial conditions. [Moderation](https://docs.chocolatey.org/en-us/community-repository/moderation/) still applies. Check both approved packages and the moderation queue for duplicates before submission. Submission requires a publisher account and its API key; keep that key out of repository files, logs and screenshots.
