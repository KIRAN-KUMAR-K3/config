# 🛠️ Server Automation Scripts – KIRAN-KUMAR-K3

[![Built for Linux](https://img.shields.io/badge/Built%20for-Linux-blue?logo=linux\&logoColor=white)](https://www.linux.org/)
[![Shell Script](https://img.shields.io/badge/Language-Bash-green?logo=gnu-bash\&logoColor=white)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/Python-Ready-yellow?logo=python\&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-orange.svg)](LICENSE)
[![Cybersecurity Tools](https://img.shields.io/badge/Category-Cybersecurity-red?logo=securityscorecard\&logoColor=white)]()

---

## 📖 Overview

This repository provides **automation scripts** to **install, configure, and manage** essential **cybersecurity and server tools** on **Linux systems**.

Each module is built for **quick deployment**, **reliability**, and **reproducibility**, reducing setup complexity for system administrators, cybersecurity analysts, and DevOps teams.

---

## 📁 Repository Structure

```
config/
├── Defender/                     # Microsoft Defender for Endpoint automation (RHEL/Ubuntu)
│   ├── MicrosoftDefenderATPOnboardingLinuxServer.py
│   ├── redhat-defender-installer.sh
│   ├── ubuntu-defender-installer.sh
│   └── README.md
│
├── openvas-setup/                # OpenVAS (Greenbone GVM) installation automation
│   ├── gvm-installer-and-setup.sh
│   └── README.md
│
├── packetfence-setup/            # PacketFence NAC installation automation
│   ├── packetfence-install.sh
│   └── README.md
│
└── README.md                     # Main documentation
```

---

## ⚙️ Included Automation Modules

### 🛡️ **Microsoft Defender for Endpoint (Linux)**

* **Location:** `Defender/`
* **Description:**
  Automates the installation and onboarding of **Microsoft Defender for Endpoint** on **RHEL (7/8/9)** and **Ubuntu (18.04–24.04)** systems.
* **Features:**

  * Auto-detects OS version and applies correct repository.
  * Installs and enables Defender real-time protection.
  * Includes health and full system scan commands.

**Usage Example:**

```bash
cd Defender
chmod +x redhat-defender-installer.sh
sudo ./redhat-defender-installer.sh
```

*or*

```bash
chmod +x ubuntu-defender-installer.sh
sudo ./ubuntu-defender-installer.sh
```

---

### 🧠 **OpenVAS (Greenbone GVM)**

* **Location:** `openvas-setup/`
* **Description:**
  Full automation script for installing and configuring **OpenVAS vulnerability scanner**.
* **Features:**

  * Cleans old installations.
  * Installs dependencies and services.
  * Starts GVM, creates admin account, and resets credentials if required.

**Usage Example:**

```bash
cd openvas-setup
chmod +x gvm-installer-and-setup.sh
./gvm-installer-and-setup.sh
```

---

### 🔐 **PacketFence NAC**

* **Location:** `packetfence-setup/`
* **Description:**
  Automates setup of **PacketFence Network Access Control** system on Debian-based distributions.
* **Features:**

  * Adds official PacketFence repository.
  * Imports GPG key and installs NAC components.
  * Runs configuration commands post-installation.

**Usage Example:**

```bash
cd packetfence-setup
chmod +x packetfence-install.sh
./packetfence-install.sh
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config
```

### 2️⃣ Choose a Tool to Install

Navigate to the tool folder you want to automate (e.g., Defender, OpenVAS, PacketFence).

### 3️⃣ Run the Installer

Make the script executable and run it as root:

```bash
chmod +x scriptname.sh
sudo ./scriptname.sh
```

---

## 🧰 Tools Covered

| Tool                                | Purpose                                   | Supported OS        |
| ----------------------------------- | ----------------------------------------- | ------------------- |
| 🛡️ Microsoft Defender for Endpoint | Endpoint protection and malware detection | Ubuntu / RHEL       |
| 🧠 OpenVAS (GVM)                    | Vulnerability scanning and analysis       | Debian / Kali Linux |
| 🔐 PacketFence NAC                  | Network access control system             | Debian / Ubuntu     |

---

## 👨‍💻 Author

**Kiran Kumar K**
Cybersecurity | Linux Automation | Ethical Hacking
📍 Mangalore, Karnataka, India
🔗 [GitHub – KIRAN-KUMAR-K3](https://github.com/KIRAN-KUMAR-K3)

---

## 🪪 License

This repository is licensed under the **MIT License**.
Feel free to use, modify, and distribute with attribution.

---

## 📚 References

* [Microsoft Defender for Endpoint on Linux](https://learn.microsoft.com/en-us/defender-endpoint/linux-install-manually)
* [OpenVAS / Greenbone Docs](https://greenbone.github.io/docs/latest/)
* [PacketFence Documentation](https://packetfence.org/documentation.html)

---

### 💡 Professional Note

> All scripts in this repository are designed for **secure enterprise deployments**.
> They include built-in checks, version detection, and minimal user intervention.
> Ideal for **DevSecOps**, **SOC automation**, and **cybersecurity research environments**.

---
