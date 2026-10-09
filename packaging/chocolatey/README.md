# Klakk Chocolatey candidate

This is a developer-maintained candidate package for the Windows direct edition, version 1.4.1. It was submitted to the Chocolatey Community Repository on **2026-10-09**. Automated validation, installation verification and package scanning have passed. It is **ready for human review and remains unlisted until a moderator approves it**. Do not advertise `choco install klakk` as a working community installation command until an approved public package is verified.

The package contains metadata and two PowerShell installer scripts. It downloads the official universal installer from `downloads.tryklakk.com` and verifies its pinned SHA-256. It does not contain the application source or installer binary.

Klakk is proprietary software with a three-day trial from first launch. Continued use requires a Windows license, US$4.49 once plus applicable taxes. The current installer is unsigned. Installation is per Windows account; use the same account to install and uninstall. See the [product terms](https://tryklakk.com/en/terms/) and [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

## Build and test

Use a disposable Windows test machine with the official free Chocolatey CLI. From `packaging/chocolatey/klakk`:

```powershell
choco pack .\klakk.nuspec
choco install klakk --version 1.4.1 --source . --yes
choco uninstall klakk --yes --skip-autouninstaller
```

The uninstall command disables Chocolatey's automatic fallback for this test so that the package's own removal script is exercised. Silent installation does not start Klakk. These are QA operations, not customer growth.

The manual [candidate validation workflow](../../.github/workflows/chocolatey-package-validation.yml) builds and inspects the package, then tests installation and explicit uninstall on native x64 and ARM64 Windows runners. No upload to the community repository is performed by the workflow. Build success and installation tests do not establish community approval, real users or completed customer downloads.

On 2026-10-08, [run 37859312707](https://github.com/levindong2026/klakk-downloads/actions/runs/37859312707) passed on both architectures with Chocolatey CLI 2.7.4. It verified the package contents, official installer checksum, per-user registry version 1.4.1, native executable architecture, 14 sound packs, no running app after silent installation, and removal through the explicit uninstall script. The tested package was retained as a workflow artifact. This was hosted-runner QA, not a physical playback test or community approval.

## Submission requirements

Chocolatey's official [package rules](https://docs.chocolatey.org/en-us/create/create-packages/) allow trial software when the description explains its activation and trial conditions. [Moderation](https://docs.chocolatey.org/en-us/community-repository/moderation/) still applies. Check both approved packages and the moderation queue for duplicates before submission. Submission requires a publisher account and its API key; keep that key out of repository files, logs and screenshots.
