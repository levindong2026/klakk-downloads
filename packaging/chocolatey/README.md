# Klakk Chocolatey package

The current [Chocolatey Community Repository package](https://community.chocolatey.org/packages/klakk/1.4.4) is **1.4.4**, approved on **2026-11-19**. For the direct download and purchase details, see the [official Windows page](https://tryklakk.com/en/windows/). The Windows edition has a three-day trial from first launch. A new Windows license costs US$6.99 once, plus applicable tax.

The current package pins the official `Klakk-1.4.4-Windows-Setup.exe` from the [Windows 1.4.4 release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.4) and verifies SHA-256 `65413b1048ff189186cfc683ed00feb6bc7e39f711930bb24e5a0a1eff54e406`.

This developer-maintained package for the Windows direct edition, version 1.4.1, was submitted to the Chocolatey Community Repository on **2026-10-09**. The [public package page](https://community.chocolatey.org/packages/klakk/1.4.1), verified on **2026-10-16**, states that a moderator approved it on **2026-10-12**. It lists `choco install klakk` as the community installation command.

The historical 1.4.1 package pins the earlier official `Klakk-1.4.1-Windows-Setup.exe`, SHA-256 `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454`, from the [original 1.4.1 release](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1). It does **not** install website revision **2026-10-11.1**. That historical revision remains available as a [separate archived download](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1); its different installer and checksum must not be substituted for this package's pinned file.

The package contains metadata and two PowerShell installer scripts. It downloads the official universal installer from `downloads.tryklakk.com` and verifies its pinned SHA-256. It does not contain the application source or installer binary.

Klakk is proprietary software. The Windows 1.4.4 installer pinned by the Chocolatey package is unsigned. Installation is per Windows account; use the same account to install and uninstall. See the [product terms](https://tryklakk.com/en/terms/) and [Windows privacy policy](https://tryklakk.com/en/windows/privacy/).

## Build and test

Use a disposable Windows test machine with the official free Chocolatey CLI. From `packaging/chocolatey/klakk`:

The **1.4.4** metadata package was packed on **2026-11-17** with the official Chocolatey CLI **2.7.5**. Its package contents, CRCs, metadata and scripts were verified against the reviewed source. The package was submitted once on **2026-11-17** and approved on **2026-11-19**. Chocolatey’s [automated verification](https://gist.github.com/choco-bot/8cb8ed4f120d4087eed5826548ac4459) passed installation and removal on Windows Server 2019 on **2026-11-17**. We have not separately verified the Chocolatey 1.4.4 package’s installation, upgrade or removal on native x64 and ARM64 Windows runners.

The earlier candidate package **1.4.1.20261016** targeted website revision **2026-10-11.1**; its application version remained **1.4.1**. An authorized upload attempt on 2026-10-16 returned HTTP 403 without an acceptance receipt; the candidate is **not confirmed submitted and is not approved**. On 2026-10-16, [run 38885819724](https://github.com/levindong2026/klakk-downloads/actions/runs/38885819724) passed clean installation and normal upgrade from the approved 1.4.1 package on native x64 and ARM64 Windows runners with Chocolatey CLI 2.7.4. It checked the current installed executable hashes, native architecture, 14 sound packs, synthetic data preservation, startup registration choices and explicit uninstall; its process observer recorded no Klakk starts. These are hosted-runner packaging tests, not customer downloads or installations. The historical **1.4.1** package described above remains unchanged.

```powershell
choco pack .\klakk.nuspec
choco install klakk --version 1.4.4 --source . --yes
choco uninstall klakk --yes --skip-autouninstaller
```

The uninstall command disables Chocolatey's automatic fallback for this test so that the package's own removal script is exercised. Silent installation does not start Klakk. These are QA operations, not customer growth.

The existing manual [candidate validation workflow](../../.github/workflows/chocolatey-package-validation.yml) still pins the earlier **1.4.1.20261016** candidate. Do not run it as 1.4.4 validation without first updating and reviewing its version, installer and expected-result bindings. Its earlier native x64 and ARM64 packaging checks did not upload a package to the community repository. Build success and installation tests do not establish community approval, real users or completed customer downloads.

On 2026-10-08, [run 37859312707](https://github.com/levindong2026/klakk-downloads/actions/runs/37859312707) passed on both architectures with Chocolatey CLI 2.7.4. It verified the package contents, official installer checksum, per-user registry version 1.4.1, native executable architecture, 14 sound packs, no running app after silent installation, and removal through the explicit uninstall script. The tested package was retained as a workflow artifact. This was hosted-runner QA, not a physical playback test or community approval.

## Submission requirements

Chocolatey's official [package rules](https://docs.chocolatey.org/en-us/create/create-packages/) allow trial software when the description explains its activation and trial conditions. [Moderation](https://docs.chocolatey.org/en-us/community-repository/moderation/) still applies. Check both approved packages and the moderation queue for duplicates before submission. Submission requires a publisher account and its API key; keep that key out of repository files, logs and screenshots.
