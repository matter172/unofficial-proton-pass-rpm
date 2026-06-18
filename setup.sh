#!/bin/bash
set -e

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "❌ Error: Please run this script as root or using sudo." >&2
  exit 1
fi

REPO_FILE="/etc/yum.repos.d/proton-pass-unofficial.repo"

echo "⚙️ Configuring Proton Pass Unofficial Repository..."

# Write the repository configuration
cat << 'EOF' > "$REPO_FILE"
[proton-pass-unofficial]
name=Proton Pass Unofficial (GitHub Pages)
baseurl=https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPO_NAME/x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
metadata_expire=1h
EOF

chmod 644 "$REPO_FILE"

echo "🔄 Refreshing package manager cache..."
dnf clean expire-cache && dnf makecache

echo "✅ Success! Install Proton Pass now by running: sudo dnf install proton-pass"
