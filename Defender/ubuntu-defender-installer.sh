#!/usr/bin/env bash
# ubuntu-defender-installer.sh
# Universal script to install & onboard Microsoft Defender for Endpoint (mdatp)
# Works with Ubuntu 18.04 / 20.04 / 22.04 / 24.04

set -e
set -o pipefail

log() { echo -e "[`date '+%Y-%m-%d %H:%M:%S'`] $*"; }

#----------------------#
#  ROOT CHECK          #
#----------------------#
if [[ $EUID -ne 0 ]]; then
    log "❌ Please run this script as root (use sudo)."
    exit 1
fi

#----------------------#
#  DETECT UBUNTU VER   #
#----------------------#
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    UBUNTU_VERSION=${VERSION_ID%%.*}
else
    log "❌ Unsupported system. This script works only on Ubuntu."
    exit 1
fi

log "🔹 Detected Ubuntu version: $UBUNTU_VERSION"

#----------------------#
#  INSTALL PREREQS     #
#----------------------#
log "🔹 Installing prerequisites..."
apt update -y
apt install -y curl gnupg gpg apt-transport-https libplist-utils ca-certificates

#----------------------#
#  SET REPO URL        #
#----------------------#
BASE_URL="https://packages.microsoft.com/config/ubuntu"

case "$UBUNTU_VERSION" in
    18|20|22|24)
        REPO_URL="$BASE_URL/${UBUNTU_VERSION}.04/prod.list"
        ;;
    *)
        log "⚠️ Unsupported Ubuntu version ($UBUNTU_VERSION). Using Ubuntu 22.04 repo as fallback."
        REPO_URL="$BASE_URL/22.04/prod.list"
        ;;
esac

#----------------------#
#  ADD MICROSOFT REPO  #
#----------------------#
log "🔹 Adding Microsoft package repository..."
curl -fsSL "$REPO_URL" -o /etc/apt/sources.list.d/microsoft-prod.list

#----------------------#
#  IMPORT GPG KEY      #
#----------------------#
log "🔹 Importing Microsoft GPG key..."
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | tee /usr/share/keyrings/microsoft-prod.gpg > /dev/null

#----------------------#
#  UPDATE & INSTALL    #
#----------------------#
log "🔹 Updating package lists..."
apt update -y

log "🔹 Installing Microsoft Defender (mdatp)..."
apt install -y mdatp || {
    log "⚠️ Defender installation failed. Check repo accessibility."
    exit 2
}

#----------------------#
#  ENABLE + START      #
#----------------------#
log "🔹 Enabling & starting mdatp service..."
systemctl enable --now mdatp || service mdatp start || true

#----------------------#
#  VERIFY INSTALL      #
#----------------------#
if ! command -v mdatp >/dev/null 2>&1; then
    log "❌ mdatp command not found. Installation incomplete."
    exit 3
fi

#----------------------#
#  CONFIGURE DEFENDER  #
#----------------------#
log "🔹 Enabling real-time protection..."
mdatp config real-time-protection --value enabled || true

#----------------------#
#  RUN ONBOARD SCRIPT  #
#----------------------#
ONBOARD_SCRIPT="MicrosoftDefenderATPOnboardingLinuxServer.py"
if [[ -f "$ONBOARD_SCRIPT" ]]; then
    log "🔹 Running onboarding script..."
    python3 "$ONBOARD_SCRIPT" || log "⚠️ Onboarding script encountered issues; review output."
else
    log "⚠️ Onboarding file '$ONBOARD_SCRIPT' not found in current directory."
fi

#----------------------#
#  VERIFY + SCAN       #
#----------------------#
log "🔹 Checking Defender status..."
mdatp status || true

log "🔹 Checking Defender health..."
mdatp health || true

log "🔹 Starting full system scan (this may take time)..."
mdatp scan full || log "⚠️ Full scan skipped or failed."

#----------------------#
#  DONE                #
#----------------------#
log "✅ Microsoft Defender for Endpoint installation & onboarding completed successfully."
log "ℹ️ Check Microsoft 365 Defender portal to confirm device onboarding."
