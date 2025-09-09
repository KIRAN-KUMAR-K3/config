#!/bin/bash

# Script to install Microsoft Defender on Ubuntu Linux
# Tested for Ubuntu 20.04 / 22.04
# Run this as root or with sudo

set -e

echo "=== Updating system ==="
sudo apt-get update -y
sudo apt-get upgrade -y

echo "=== Installing required dependencies ==="
sudo apt-get install -y curl libplist-utils gnupg apt-transport-https

echo "=== Adding Microsoft package repository ==="
curl -o microsoft.list https://packages.microsoft.com/config/ubuntu/24.04/prod.list
sudo mv microsoft.list /etc/apt/sources.list.d/microsoft-prod.list

echo "=== Adding Microsoft GPG key ==="
curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

echo "=== Updating package list with Microsoft repo ==="
sudo apt-get update -y

echo "=== Installing Microsoft Defender (mdatp) ==="
sudo apt-get install -y mdatp

echo "=== Checking Microsoft Defender Health ==="
mdatp health

echo "=== Testing Microsoft Defender Connectivity ==="
mdatp connectivity test

echo "=== Installation Completed Successfully ==="
echo "Run 'mdatp health' anytime to check Defender status."
