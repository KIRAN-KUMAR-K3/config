#!/bin/bash

# GVM (OpenVAS) Installer and Setup Script
# Author: Kiran Kumar K
# Tested on: Kali Linux 2023+

echo -e "\n[+] Stopping any existing GVM services..."
sudo gvm-stop
sudo systemctl stop ospd-openvas gvmd gsad

echo -e "\n[+] Removing previous installations..."
sudo apt purge gvm* openvas* gvmd* gsad* ospd* -y
sudo rm -rf /var/lib/gvm /var/lib/openvas /var/log/gvm /etc/gvm /etc/openvas
sudo rm -rf /usr/local/sbin/gvmd /usr/local/sbin/gsad
sudo apt autoremove -y
sudo apt autoclean

echo -e "\n[+] Updating system and installing GVM..."
sudo apt update && sudo apt upgrade -y
sudo apt install gvm -y

echo -e "\n[+] Running initial GVM setup..."
sudo gvm-setup

echo -e "\n[+] Starting GVM services..."
sudo gvm-start

echo -e "\n[+] Checking GVM setup status..."
sudo gvm-check-setup

# Optional admin password reset
read -p $'\nDo you want to reset the GVM admin password? (y/n): ' reset_pass
if [[ "$reset_pass" == "y" || "$reset_pass" == "Y" ]]; then
    read -sp "Enter new admin password: " new_pass
    echo
    sudo runuser -u _gvm -- gvmd --user=admin --new-password="$new_pass"
    echo "[+] Password reset completed."
fi

echo -e "\n✅ GVM installation and setup completed successfully."
echo "🌐 Access GVM Web UI at: https://127.0.0.1:9392 (username: admin)"
