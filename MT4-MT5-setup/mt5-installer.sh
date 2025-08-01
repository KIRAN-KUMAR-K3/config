#!/bin/bash

# MetaTrader 5 Auto-Installer for Linux Lite / Ubuntu-based systems

echo "=== Updating system packages ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing Wine (64-bit and 32-bit) ==="
sudo dpkg --add-architecture i386
sudo apt install -y wine64 wine32 wine32-preloader wine-stable

# Optional: Check Wine version
echo "Wine version:"
wine --version

echo "=== Installing dependencies (winetricks and wget) ==="
sudo apt install -y winetricks wget cabextract

echo "=== Downloading MetaTrader 5 installation script ==="
wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5ubuntu.sh -O mt5installer.sh

echo "=== Making installer script executable ==="
chmod +x mt5installer.sh

echo "=== Running MetaTrader 5 installation script ==="
./mt5installer.sh

echo "=== Installation Complete ==="
echo "You can launch MetaTrader 5 from your application menu or Wine fol
