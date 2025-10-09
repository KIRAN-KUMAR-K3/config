# 🛠️ Server Automation Scripts – KIRAN-KUMAR-K3

[![Built for Linux](https://img.shields.io/badge/Built%20for-Linux-blue?logo=linux\&logoColor=white)](https://www.linux.org/)
[![Shell Script](https://img.shields.io/badge/Language-Bash-green?logo=gnu-bash\&logoColor=white)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/Python-Ready-yellow?logo=python\&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-orange.svg)](LICENSE)
[![Cybersecurity Tools](https://img.shields.io/badge/Category-Cybersecurity-red?logo=securityscorecard\&logoColor=white)]()

---

## 📖 Overview

This repository provides **automation scripts** to **install, configure, and manage** essential **cybersecurity, trading, and networking tools** on **Linux systems**.

Each module is optimized for **speed, reliability, and reproducibility**, enabling **system administrators, DevOps engineers, and cybersecurity analysts** to deploy tools effortlessly in both personal and enterprise environments.

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
├── MT4-MT5-setup/                # MetaTrader 4 / MetaTrader 5 installation automation
│   ├── mt4-mt5-setup.sh
│   └── README.md
│
└── README.md                     # Main documentation
```

---

## ⚙️ Included Automation Modules

### 🛡️ **Microsoft Defender for Endpoint (Linux)**

* **Location:** `Defender/`
* **Description:**
  Automates installation and onboarding of **Microsoft Defender for Endpoint** on **RHEL (7/8/9)** and **Ubuntu (18.04–24.04)**.
* **Features:**

  * Auto-detects OS version and sets correct repositories.
  * Installs dependencies and enables real-time protection.
  * Runs post-install Defender health and status checks.

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
  Automates full installation and configuration of **OpenVAS**, the Greenbone Vulnerability Management (GVM) suite.
* **Features:**

  * Cleans up old installations.
  * Installs required packages and services.
  * Starts GVM, creates admin user, and resets credentials if needed.

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
  Automates setup of **PacketFence Network Access Control (NAC)** on Debian-based Linux distributions.
* **Features:**

  * Adds official repository and imports GPG keys.
  * Installs all necessary NAC components.
  * Performs basic configuration steps post-install.

**Usage Example:**

```bash
cd packetfence-setup
chmod +x packetfence-install.sh
./packetfence-install.sh
```

---

### 💹 **MT4 / MT5 Installation Automation (Linux)**

* **Location:** `MT4-MT5-setup/`
* **Description:**
  Automates installation of **MetaTrader 4** and **MetaTrader 5** trading platforms on Linux using **Wine** and **Winetricks**.
* **Features:**

  * Installs all dependencies required for Wine.
  * Configures Wine environment for stable MT4/MT5 performance.
  * Downloads and installs the official MetaTrader installer automatically.
  * Compatible with Ubuntu, Debian, and Kali Linux.

**Usage Example:**

```bash
cd MT4-MT5-setup
chmod +x mt4-mt5-setup.sh
./mt4-mt5-setup.sh
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config
```

### 2️⃣ Navigate to the Desired Tool

Example:

```bash
cd Defender
# or
cd openvas-setup
# or
cd MT4-MT5-setup
```

### 3️⃣ Run the Installation Script

```bash
chmod +x scriptname.sh
sudo ./scriptname.sh
```

---

## 🧰 Tools Covered

| Tool                                | Purpose                                 | Supported OS        |
| ----------------------------------- | --------------------------------------- | ------------------- |
| 🛡️ Microsoft Defender for Endpoint | Endpoint protection and malware defense | Ubuntu / RHEL       |
| 🧠 OpenVAS (GVM)                    | Vulnerability assessment and scanning   | Debian / Kali Linux |
| 🔐 PacketFence NAC                  | Network access control system           | Debian / Ubuntu     |
| 💹 MetaTrader 4 & 5                 | Financial trading and automation setup  | Ubuntu / Debian     |

---

## 👨‍💻 Author

**Kiran Kumar K**
Cybersecurity | Linux Automation | Ethical Hacking
📍 Mangalore, Karnataka, India
🔗 [GitHub – KIRAN-KUMAR-K3](https://github.com/KIRAN-KUMAR-K3)

---

## 🪪 License

This project is licensed under the **MIT License**.
You are free to use, modify, and distribute with attribution.

---

## 📚 References

* [Microsoft Defender for Endpoint on Linux](https://learn.microsoft.com/en-us/defender-endpoint/linux-install-manually)
* [Greenbone OpenVAS Docs](https://greenbone.github.io/docs/latest/)
* [PacketFence Documentation](https://packetfence.org/documentation.html)
* [MetaTrader Official Site](https://www.metatrader5.com/en/terminal/help/start_advanced/install_linux)

---

### 💡 Professional Note

> All scripts are tested and optimized for **enterprise and personal Linux environments**.
> They include error handling, environment checks, and automated configurations for smoother deployment.
> Ideal for **SOC automation**, **DevSecOps**, **system hardening**, and **financial platform setup** on Linux.

---
