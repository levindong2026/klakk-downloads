# Windows packaging candidates — not a public release

The official Windows 1.4.1 installer contains both native architectures and is 202,233,968 bytes. This experiment checks whether optional, smaller x64 and ARM64 installers can carry **exactly the same application files**. The existing universal download, its checksum and every package-manager manifest remain unchanged.

The workflow installs the SHA-256-pinned official universal package on fresh native x64 and ARM64 runners, copies every payload file except the root installer-generated uninstaller files, then uninstalls it. It does not rebuild the application or use the older `*-candidate.zip` archives. The application source is not in this repository.

Inno Setup packages each complete native payload using the same application ID, version, per-user destination, privilege level, compression, launch option and uninstall behavior. See the vendor's [architecture settings](https://jrsoftware.org/ishelp/topic_setup_architecturesallowed.htm), [compression documentation](https://jrsoftware.org/ishelp/topic_setup_compression.htm) and [license](https://jrsoftware.org/files/is/license.txt). The build uses the compiler already included in the GitHub Windows runner; it does not purchase a license or install an additional service.

Before any public release, each native runner must verify:

- The transferred candidate's full size and SHA-256.
- Clean refusal of the other architecture, without creating an installation.
- Installation and same-version reinstallation with the existing 1.4.1 identity.
- Exact size and SHA-256 of every installed payload file, native executable machine type and all 14 sound packs.
- Successful uninstall and removal of the per-user uninstall entry.
- A smaller file than the existing universal installer.

The scripts never launch Klakk or send a licensing, first-run or purchase request. CI file transfers and installations are QA, not customers or growth. A passing result would establish packaging correctness and file-size reduction within these runners; it would not prove physical-hardware behavior, a higher conversion rate, customer downloads or customer installations.

Actions artifacts are temporary **candidates**. No release upload or website modification is automated by this workflow. The report retains `publicly_released: false` until a separately verified release is made. Current public instructions continue to use the existing universal installer.
