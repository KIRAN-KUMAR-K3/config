# 🛠️ Server Automation Scripts - KIRAN-KUMAR-K3

This repository contains automation scripts to install and configure essential cybersecurity and network tools like **OpenVAS (GVM)** and **PacketFence** on Debian-based systems (e.g., Kali Linux).

The scripts are organized by tool, making it easy to deploy, configure, and manage them efficiently.

---

## 📁 Folder Structure

| Folder              | Description                                                       |
|---------------------|-------------------------------------------------------------------|
| `openvas-setup/`    | Scripts for installing and configuring OpenVAS (Greenbone GVM)    |
| `packetfence-setup/`| Scripts for adding repository and installing PacketFence NAC      |

---

## 📦 Tools Covered

### ✅ OpenVAS (GVM)
- Location: [`openvas-setup/gvm-installer-and-setup.sh`](openvas-setup/gvm-installer-and-setup.sh)
- Description: Full automation script to uninstall old versions, clean the environment, install GVM, run setup, start services, and reset the admin password if needed.

### ✅ PacketFence
- Location: [`packetfence-setup/packetfence-install.sh`](packetfence-setup/packetfence-install.sh)
- Description: Script to add the official PacketFence repo, import the GPG key, update the system, and install the NAC tool.

---

## 🚀 Getting Started

To run any script:

```bash
# Clone the repo
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config

# Example: Run OpenVAS setup
cd openvas-setup
chmod +x gvm-installer-and-setup.sh
./gvm-installer-and-setup.sh

# Example: Run PacketFence install
cd ../packetfence-setup
chmod +x packetfence-install.sh
./packetfence-install.sh
