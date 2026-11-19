# Proton Pass licensing notice

The RPM packages distributed through this repository's
[GitHub Releases](https://github.com/matter172/unofficial-proton-pass-rpm/releases)
and its GitHub Pages DNF repository contain **Proton Pass for Linux**, a program
by Proton AG.

## License

Proton Pass is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, version 3 (GPL-3.0).

Proton Pass is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

The full license text is at <https://www.gnu.org/licenses/gpl-3.0.html>, and in
the upstream repository's
[LICENSE](https://github.com/ProtonMail/WebClients/blob/main/LICENSE) file.

## Corresponding source

The complete source code for Proton Pass desktop is published by Proton AG at:

<https://github.com/ProtonMail/WebClients/tree/main/applications/pass-desktop>

Proton tags its releases in that repository as `proton-pass@<version>`. Each
GitHub Release in this repository links to the source for that exact version:
the tagged commit when the tag exists, or otherwise the `pass-desktop` directory
along with the Proton Pass version number.

## Unmodified redistribution

The packages are **unmodified**. Each RPM is the official build downloaded from
Proton's servers (`proton.me/download/...`). Before it is published, its SHA512
checksum is checked against Proton's release manifest at
<https://proton.me/download/PassDesktop/linux/x64/version.json>. No files are
added, removed, patched or re-signed. See the README section
"Verify a package yourself" to check this on your own machine.

## Trademarks

"Proton" and "Proton Pass" are trademarks of Proton AG. This project is not
affiliated with or endorsed by Proton AG. Those names are used only to identify
the software being redistributed.

## This repository's own files

The scripts, workflow and documentation in this repository (everything except
the redistributed Proton Pass packages) are licensed under the MIT License. See
[LICENSE](LICENSE).
