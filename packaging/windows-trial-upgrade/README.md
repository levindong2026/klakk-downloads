# Compiled-only native candidate plan — 2026-10-11.1

Status: private review candidate. This actor has not copied to public Git, created/uploaded a release, dispatched CI, run a native app, or accepted a release. Only packaging/test code here is eligible for public review; private Windows application code remains in its private repository.

The approved payload contains public version 1.4.1 with internal revision 2026-10-11.1. Existing published 1.4.1 download bytes/hashes must remain immutable. New candidate installers have `-rev-2026-10-11.1` filenames. Root owns version routing and publication after all actual gates.

## Layout root must create before dispatch

ZIP has no enclosing directory and contains only:

```
candidate-manifest.json
production/win-x64/       # self-contained default production compiled payload, no PDB
production/win-arm64/     # self-contained default production compiled payload, no PDB
qa/win-x64/               # separately compiled BILLING_QA fixture payload, no PDB
qa/win-arm64/             # separately compiled BILLING_QA fixture payload, no PDB
packaging/installer-common.iss
packaging/installer-universal.iss
packaging/installer-win-x64.iss
packaging/installer-win-arm64.iss
packaging/Klakk.Windows/Resources/klakk.ico
```

The four `.iss` files and icon are packaging sources copied verbatim from the private `windows/` paths, **not application C# source**. The common installer latest SHA is in the private source manifest; the other three files were unchanged. Compile-Candidate passes absolute PublishRoot, output directory and revision-distinct filename to Inno; it does not mutate packaging code or source assets.

No `.cs`, `.csproj`, source ZIP, PDB, application preferences/installation identity/outbox, email/license/keys/credential files enter this ZIP. The downloader verifies ZIP traversal/duplicate/case collisions, tight root/extension limits, exact file manifest, both PE architectures, QA marker absent in the production single-file EXE and present in the QA managed DLL, and 14 packs in every payload. These binary checks support packaging provenance; they do not replace private source review or prove every embedded secret absent. Root must inspect the local bundle before upload.

Manifest shape (fill real bytes/hashes, no placeholders at dispatch):

```json
{
  "schema_version": 1,
  "application_version": "1.4.1",
  "release_revision": "2026-10-11.1",
  "source_set_sha256": "<current independently approved private source-set digest>",
  "files": [
    { "path": "production/win-x64/Klakk.Windows.exe", "bytes": 123456, "sha256": "<real exact SHA-256>" }
  ]
}
```

Every file except the manifest itself must be listed exactly once. No absolute source paths or raw installation identifiers belong in this public manifest. Lock SHA of the completed ZIP independently. Root then uploads it once to a new/existing unpublished draft release and records actual release ID, asset ID, uploaded state, size and SHA before dispatch; this workflow has no upload/create/publish API permissions. Never substitute a guessed ID, browser URL or draft count for actual receipt.

Root should copy only the `.ps1` scripts to `packaging/windows-trial-upgrade/` and the workflow to `.github/workflows/windows-trial-upgrade-candidates.yml` in the official public downloads repo. No application source or private source-manifest file is needed in public Git. The script manifest here is only the private review lock.

## What the prepared workflow does

- Manual dispatch only. Public official-repo guard, standard `windows-latest` and `windows-11-arm` runners, `contents:read`, no paid/larger/self-hosted runner, no private CI.
- Existing exact draft release/asset ID plus external ZIP and source-set SHA are required inputs. API token is the workflow's read-only GITHUB_TOKEN and is not written into files/logs. It downloads only its specified uploaded ZIP using GitHub's authenticated binary release-asset endpoint.
- Compile universal, native x64 and native ARM64 installers from production bytes. QA binaries never enter installers. Version remains 1.4.1, filenames carry the internal revision. Exact build bytes/hashes are recorded.
- Each native host receives the same externally locked ZIP, verifies native PE/source provenance, installs the official free .NET 10 SDK with actions/setup-dotnet@v4, and requires an actual Microsoft.WindowsDesktop.App 10 runtime before framework-dependent QA. Missing runtime is an explicit unavailable failure, without an alternate paid or unverified download. It then runs the isolated actual tip fixture in EN/JA/DE/AR. Each produces four native WinForms render PNGs and precise focus/pointer/event receipts. A missing desktop foreground/native pointer gate remains unavailable, rather than a pass.
- Test wrong-architecture refusal, actual fresh silent per-user startup registration and fresh default preference ON, saved explicit OFF across upgrade/reinstall, identity preservation without publishing identity or its hash, owned quoted Run removal, and foreign Scoop/portable/sibling/ambiguous unquoted Run retention.
- Ordinary launch is prohibited. The only production-byte launch is `--smoke-test`, whose newly reviewed startupCheck guards prevent heartbeat/update/quiet license/billing requests and disable telemetry. This still creates a **local QA** first-launch preference/installation file on the disposable runner. It is not a real customer first run or install; all such files remain local and are deleted without artifact upload. QA tip launch has in-memory telemetry and HTTP rejection, requiring zero attempts. No checkout is invoked.
- Artifacts contain compiled installer candidates, build logs/integrity and sanitized fixture reports/PNG only. Native QA temporary data and license/installation files are excluded. Workflow cannot mark release accepted or publish assets.

## Honest remaining gates

Prepared scripts have not run natively yet. Mac host has no PowerShell parser/runtime; local review cannot claim Windows execution. The workflow first parses public harness files with the native PowerShell parser before any payload runs. Runtime receipts cannot prove physical keyboard eligibility (synthetic counters), an hour waited in real time, Task Manager startup approval, actual login execution, accessibility switch interaction, all hardware/audio devices or a paid conversion effect. The smoke fixture's saved OFF seed is not a native startup-switch click. Existing saved ON + silent reinstall before ordinary app launch remains a documented conservative-installer edge, not an accepted guarantee.

Every summary therefore keeps `release_accepted=false`, unknown gates null/unavailable, and PNG visual review outstanding. Root must inspect actual EN/JA/DE/AR PNGs and receipts, require relevant focus/pointer gates or preserve unavailability, and complete any missing physical/native/login acceptance before release. Public Actions success alone is not product acceptance or customer growth.

## Current official source receipts, 2026-10-12 UTC

- [GitHub release asset endpoint](https://docs.github.com/en/rest/releases/assets): binary Accept header, 200/302 and Contents read permission. Current official example uses API version 2026-03-10. No API mutation is in the workflow.
- [GitHub standard runner reference](https://docs.github.com/en/actions/reference/runners/github-hosted-runners): official public standard Windows x64 and ARM64 labels, free unlimited public standard execution; private runner allowance differs. Account/platform availability is still determined by the actual queued job.
- [Inno compiler CLI](https://jrsoftware.org/ishelp/topic_compilercmdline.htm): output-dir/output-filename options override script defaults. Use runner-provided Inno only; absence is an explicit failure, not permission to buy tooling or bypass security.

No growth metrics, SEO results, install counts or conversion claims are produced by these fixtures.
