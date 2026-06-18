#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root or with sudo." >&2
  exit 1
fi

if ! command -v dnf &>/dev/null; then
  echo "❌ This script requires dnf. Only Fedora/RHEL-based distributions are supported." >&2
  exit 1
fi

REPO_FILE="/etc/yum.repos.d/proton-pass-unofficial.repo"

if [ -f "$REPO_FILE" ]; then
  echo "✅ Repository already configured at $REPO_FILE"
  exit 0
fi

echo "⚙️  Configuring Proton Pass Unofficial Repository..."

cat << 'EOF' > "$REPO_FILE"
[proton-pass-unofficial]
name=Proton Pass Unofficial (GitHub Pages)
baseurl=https://matter172.github.io/unofficial-proton-pass-rpm/x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
metadata_expire=1h
EOF

chmod 644 "$REPO_FILE"

echo "✅ Repository configured. Run the following to install Proton Pass:"
echo ""
echo "   sudo dnf install proton-pass"
