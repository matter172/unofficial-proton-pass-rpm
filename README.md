# Unofficial Proton Pass RPM Repository

An unofficial DNF/YUM repository for [Proton Pass](https://proton.me/pass) on Fedora and Red Hat-based distributions. The repository checks for new releases every night and publishes them automatically via GitHub Actions.

> **Note:** This is an unofficial, community-maintained repository. It is not affiliated with or endorsed by Proton AG.

## Setup

Only x86_64 is supported. Add the repository by downloading its [`.repo` file](proton-pass-unofficial.repo) into `/etc/yum.repos.d/`. Pick the command that matches your system:

```bash
# Fedora 41+ (dnf5)
sudo dnf config-manager addrepo --from-repofile=https://raw.githubusercontent.com/matter172/unofficial-proton-pass-rpm/refs/heads/main/proton-pass-unofficial.repo

# RHEL / CentOS Stream / AlmaLinux / Rocky (dnf4, needs dnf-plugins-core)
sudo dnf config-manager --add-repo https://raw.githubusercontent.com/matter172/unofficial-proton-pass-rpm/refs/heads/main/proton-pass-unofficial.repo

# Any distribution, including Silverblue / Atomic desktops
sudo curl -fsSL -o /etc/yum.repos.d/proton-pass-unofficial.repo https://raw.githubusercontent.com/matter172/unofficial-proton-pass-rpm/refs/heads/main/proton-pass-unofficial.repo
```

The file is seven lines long, so read it first if you like. It points DNF at this repository's GitHub Pages site.

Then install Proton Pass:

```bash
sudo dnf install proton-pass
```

### Optional: setup script

[`setup.sh`](setup.sh) writes the same `.repo` file and prints the right install command for your system (`dnf` or `rpm-ostree`). It runs as root, so **read it before running it**:

```bash
curl -fsSLO https://raw.githubusercontent.com/matter172/unofficial-proton-pass-rpm/refs/heads/main/setup.sh
less setup.sh
sudo bash setup.sh
```

The script is safe to re-run; it rewrites the repo config with the latest settings.

### Fedora Silverblue / Atomic desktops

On Silverblue, Kinoite and the other rpm-ostree based Atomic desktops, add the repository with the `curl` command above (or the setup script), then install Proton Pass by layering it instead of using `dnf`:

```bash
sudo rpm-ostree install proton-pass
```

Reboot to start using it, or add `--apply-live` to use it without rebooting.

## Updating

Once the repository is configured, updates are delivered through the normal DNF update mechanism:

```bash
sudo dnf upgrade proton-pass
```

On Silverblue / Atomic desktops, layered packages are updated along with the rest of the system:

```bash
sudo rpm-ostree upgrade
```

## Available versions

All retained versions are listed on the [Releases](https://github.com/matter172/unofficial-proton-pass-rpm/releases) page. By default the 5 most recent versions are kept; older releases are pruned automatically when a new one is published.

## How it works

A GitHub Actions workflow runs every night at midnight UTC. It checks Proton's official release manifest, and if a new **stable** version is available (beta builds in the manifest are ignored):

1. Downloads the RPM from Proton's servers
2. Verifies the SHA512 checksum against Proton's published manifest
3. Creates a GitHub Release and attaches the unmodified RPM, with release notes listing the SHA512 from Proton's manifest, the matching upstream source and the GPL-3.0 license
4. Prunes releases beyond the configured retention limit
5. Downloads all retained release assets, regenerates repository metadata with `createrepo_c`, and deploys everything to GitHub Pages

RPM binaries are never committed to git — they are stored as GitHub Release assets and served via Pages.

## Supported distributions

Any RPM-based distribution with `dnf` or `rpm-ostree`:

- Fedora (latest stable + 1 previous release)
- Fedora Silverblue, Kinoite and other Atomic desktops
- RHEL / CentOS Stream / AlmaLinux / Rocky Linux 9+

Other RPM-based distros may work but are untested.

## Manually removing the repository

```bash
sudo rm /etc/yum.repos.d/proton-pass-unofficial.repo
sudo dnf clean all
```

On Silverblue / Atomic desktops, remove the layered package first, then delete the repo file:

```bash
sudo rpm-ostree uninstall proton-pass
sudo rm /etc/yum.repos.d/proton-pass-unofficial.repo
```

## Security

- The RPM is sourced directly from Proton's official download endpoint (`proton.me`)
- The SHA512 checksum is verified against Proton's published manifest before the file is published
- GPG check is disabled (`gpgcheck=0`) because Proton does not publish a GPG-signed repo — the checksum verification in the workflow serves as the integrity check

If you prefer to verify manually, Proton's manifest (including checksums) is available at:
`https://proton.me/download/PassDesktop/linux/x64/version.json`

## Licensing and source

- **Proton Pass packages:** the RPMs are Proton AG's unmodified official builds, redistributed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html). See [COPYING-PROTON-PASS.md](COPYING-PROTON-PASS.md).
- **Source code:** Proton Pass desktop is developed in [ProtonMail/WebClients — `applications/pass-desktop`](https://github.com/ProtonMail/WebClients/tree/main/applications/pass-desktop). Proton tags releases there as `proton-pass@<version>`. Each [release](https://github.com/matter172/unofficial-proton-pass-rpm/releases) here links to the matching source: the tag and commit when Proton has published that tag, otherwise the `pass-desktop` directory plus the Proton Pass version number.
- **This repository:** the scripts, workflow and documentation are licensed under the MIT License. See [LICENSE](LICENSE).

### Trademarks

"Proton" and "Proton Pass" are trademarks of Proton AG. This project is not affiliated with or endorsed by Proton AG.
