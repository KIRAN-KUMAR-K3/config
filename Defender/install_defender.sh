#!/usr/bin/env bash
# install-mdatp-ubuntu.sh
# Installs Microsoft Defender (mdatp) on Ubuntu (20.04 / 22.04 / 24.04 etc.)
# Run as root: sudo ./install-mdatp-ubuntu.sh
set -euo pipefail

# ---- helper funcs ----
err() { echo "ERROR: $*" >&2; exit 1; }
info() { echo "INFO: $*"; }

# must be root
if [ "$EUID" -ne 0 ]; then
  err "This script must be run as root. Use sudo."
fi

# ensure we are on Debian/Ubuntu family
if [ -r /etc/os-release ]; then
  . /etc/os-release
else
  err "/etc/os-release not found. Unsupported OS."
fi

if [ "${ID,,}" != "ubuntu" ] && [ "${ID_LIKE,,}" != *"debian"* ]; then
  echo "Warning: This script is intended for Ubuntu/Debian. Continuing anyway..."
fi

# pick a VERSION_ID (e.g. 20.04, 22.04, 24.04)
VERSION_ID="${VERSION_ID:-$(lsb_release -rs 2>/dev/null || echo "")}"
if [ -z "${VERSION_ID}" ]; then
  # fallback: try /etc/os-release
  VERSION_ID="${VERSION_ID:-${VERSION_ID}}"
fi

info "Detected OS: $PRETTY_NAME (version: ${VERSION_ID:-unknown})"

# install prerequisites
info "Installing prerequisites (curl, ca-certificates, apt-transport-https, lsb-release, gnupg)..."
apt-get update -y
apt-get install -y --no-install-recommends \
  curl ca-certificates apt-transport-https lsb-release gnupg lsb-release

# download Microsoft repo package for detected version
TMP_DEB="/tmp/packages-microsoft-prod.deb"
REPO_URL="https://packages.microsoft.com/config/ubuntu/${VERSION_ID}/packages-microsoft-prod.deb"

info "Trying to download repository package for Ubuntu ${VERSION_ID} from packages.microsoft.com..."
if curl -fsSL -o "${TMP_DEB}" "${REPO_URL}"; then
  info "Downloaded ${REPO_URL}"
else
  info "Repo for ${VERSION_ID} not available. Will attempt fallback to ubuntu/22.04."
  REPO_URL="https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb"
  if curl -fsSL -o "${TMP_DEB}" "${REPO_URL}"; then
    info "Downloaded fallback repo package (22.04)"
  else
    err "Unable to download packages-microsoft-prod.deb (both primary and fallback failed). Check network or packages.microsoft.com."
  fi
fi

# install the repo package (this adds repo + GPG key)
info "Installing repo package..."
dpkg -i "${TMP_DEB}" || {
  info "dpkg failed; attempting to fix dependencies..."
  apt-get -f install -y
  dpkg -i "${TMP_DEB}" || err "dpkg install failed."
}

# cleanup the temp deb
rm -f "${TMP_DEB}"

# update apt and install mdatp
info "Updating apt and installing mdatp..."
apt-get update -y
apt-get install -y mdatp

# start/enable service (try systemctl first, then service)
info "Enabling and starting the mdatp service (if present)..."
if command -v systemctl >/dev/null 2>&1; then
  # enable/start but do not fail the script if systemctl fails (service might have a different handling)
  systemctl daemon-reload || true
  systemctl enable --now mdatp 2>/dev/null || service mdatp start 2>/dev/null || true
else
  service mdatp start 2>/dev/null || true
fi

# short health checks
info "mdatp binary path: $(command -v mdatp || echo 'not found')"

if command -v mdatp >/dev/null 2>&1; then
  info "mdatp version:"
  mdatp version || true

  info "mdatp health (summary):"
  mdatp health || true

  info "mdatp connectivity test:"
  mdatp connectivity test || true
else
  err "mdatp command not found after installation. Installation may have failed."
fi

cat <<'EOF'

DONE: mdatp should be installed. Next steps:
  * If you have an onboarding script from the Microsoft Defender portal (python .py inside the zip),
    run: sudo python3 MicrosoftDefenderATPOnboardingLinuxServer.py
  * OR use Microsoft's installer script to automate install+onboard (example below).
  * Check device status in Microsoft Defender portal (it can take a few minutes).

Troubleshooting tips:
  * Check service status: sudo service mdatp status  OR sudo systemctl status mdatp
  * Check agent logs and create diagnostics: sudo mdatp diagnostic create
  * If service fails, ensure systemd is present and working (mdatp depends on systemd). See Microsoft docs.
EOF
