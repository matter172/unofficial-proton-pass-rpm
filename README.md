# Unofficial Proton Pass RPM Repository

An unofficial DNF/YUM repository for [Proton Pass](https://proton.me/pass) on Fedora and Red Hat-based distributions. The repository checks for new releases every night and publishes them automatically via GitHub Actions.

> **Note:** This is an unofficial, community-maintained repository. It is not affiliated with or endorsed by Proton AG.

## Quick Setup

```bash
curl -fsSL https://raw.githubusercontent.com/matter172/unofficial-proton-pass-rpm/refs/heads/main/setup.sh | sudo bash
```

Then install Proton Pass:

```bash
sudo dnf install proton-pass
```

## Updating

Once the repository is configured, updates are delivered through the normal DNF update mechanism:

```bash
sudo dnf upgrade proton-pass
```

## Available versions

All retained versions are listed on the [Releases](https://github.com/matter172/unofficial-proton-pass-rpm/releases) page. By default the 5 most recent versions are kept; older releases are pruned automatically when a new one is published.

## How it works

A GitHub Actions workflow runs every night at midnight UTC. It checks Proton's official release manifest, and if a new version is available:

1. Downloads the RPM from Proton's servers
2. Verifies the SHA512 checksum against Proton's published manifest
3. Creates a GitHub Release and attaches the RPM as a release asset
4. Prunes releases beyond the configured retention limit
5. Downloads all retained release assets, regenerates repository metadata with `createrepo_c`, and deploys everything to GitHub Pages

RPM binaries are never committed to git — they are stored as GitHub Release assets and served via Pages.

## Supported distributions

Any RPM-based distribution with `dnf`:

- Fedora (latest stable + 1 previous release)
- RHEL / CentOS Stream / AlmaLinux / Rocky Linux 9+

Other RPM-based distros may work but are untested.

## Manually removing the repository

```bash
sudo rm /etc/yum.repos.d/proton-pass-unofficial.repo
sudo dnf clean all
```

## Security

- The RPM is sourced directly from Proton's official download endpoint (`proton.me`)
- The SHA512 checksum is verified against Proton's published manifest before the file is published
- GPG check is disabled (`gpgcheck=0`) because Proton does not publish a GPG-signed repo — the checksum verification in the workflow serves as the integrity check

If you prefer to verify manually, Proton's manifest (including checksums) is available at:
`https://proton.me/download/PassDesktop/linux/x64/version.json`
