# 🛡️ Microsoft Defender for Endpoint on Linux — Automated Installer

[![Built for Linux](https://img.shields.io/badge/Built%20for-Linux-blue?logo=linux\&logoColor=white)](https://www.linux.org/)
[![Shell Script](https://img.shields.io/badge/Language-Bash-green?logo=gnu-bash\&logoColor=white)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Tested on Ubuntu](https://img.shields.io/badge/Tested%20on-Ubuntu%2024.04-orange?logo=ubuntu\&logoColor=white)](https://ubuntu.com/)
[![Tested on RHEL](https://img.shields.io/badge/Tested%20on-RHEL%208/9-red?logo=redhat\&logoColor=white)](https://www.redhat.com/)

---

This repository provides **automated installation scripts** for deploying **Microsoft Defender for Endpoint (MDE)** on **Linux systems**, including **Red Hat Enterprise Linux (RHEL)** and **Ubuntu**.

Developed for cybersecurity professionals, DevOps engineers, and system administrators — these scripts simplify setup by automatically configuring repositories, installing dependencies, and enabling Defender protection services across multiple Linux distributions.

---

## 📦 Repository Structure

```
Defender/
├── MicrosoftDefenderATPOnboardingLinuxServer.py   # Official Microsoft onboarding script
├── redhat-defender-installer.sh                   # Auto-installer for RHEL/CentOS/Rocky
├── ubuntu-defender-installer.sh                   # Auto-installer for Ubuntu 18.04–24.04
└── README.md                                      # Documentation
```

---

## ⚙️ Key Features

* 🧩 **Cross-Platform Support** – Works seamlessly across RHEL, CentOS, Rocky Linux, and Ubuntu.
* 🔍 **Automatic Version Detection** – Detects OS version to configure the correct Microsoft repository.
* 🔐 **Secure Repository Configuration** – Imports trusted Microsoft GPG keys automatically.
* 🩺 **Full Health Validation** – Runs Defender health and real-time protection checks post-install.
* ⚡ **Quick Deployment** – End-to-end automation in a single script execution.

---

## 🧩 Supported Versions

| Distribution                 | Versions Supported            | Status      |
| ---------------------------- | ----------------------------- | ----------- |
| **Ubuntu**                   | 18.04 / 20.04 / 22.04 / 24.04 | ✅ Supported |
| **Red Hat / CentOS / Rocky** | 7 / 8 / 9                     | ✅ Supported |

---

## 🚀 Installation Guide

### 🔹 On Red Hat Enterprise Linux / CentOS / Rocky Linux

```bash
chmod +x redhat-defender-installer.sh
sudo ./redhat-defender-installer.sh
```

The script will:

* Detect your RHEL version
* Configure Microsoft repositories dynamically
* Install dependencies and Defender (`mdatp`)
* Enable and verify real-time protection

---

### 🔹 On Ubuntu

```bash
chmod +x ubuntu-defender-installer.sh
sudo ./ubuntu-defender-installer.sh
```

This will:

* Install required dependencies (`curl`, `gnupg`, etc.)
* Add the correct Microsoft repository for your Ubuntu version
* Install and configure Microsoft Defender for Endpoint

---

## 🧾 Post-Installation Checks

Run the following commands to confirm installation and status:

```bash
mdatp status
mdatp health
mdatp scan full
```

**Example Output:**

```
Microsoft Defender for Endpoint on Linux
Real-time protection: enabled
Engine version: 1.1.23060.2
Signature version: 1.395.1512.0
Last update: 2025-10-09
```

---

## 📁 File Overview

| File                                           | Description                                                       |
| ---------------------------------------------- | ----------------------------------------------------------------- |
| `redhat-defender-installer.sh`                 | Installs Defender for Endpoint on RHEL/CentOS/Rocky               |
| `ubuntu-defender-installer.sh`                 | Installs Defender for Endpoint on Ubuntu (auto-version detection) |
| `MicrosoftDefenderATPOnboardingLinuxServer.py` | Official onboarding script provided by Microsoft                  |
| `README.md`                                    | Documentation for setup and usage                                 |

---

## 👨‍💻 Author

**Kiran Kumar K**
Cybersecurity | Linux Automation | Ethical Hacking
📍 Mangalore, Karnataka, India
🔗 [GitHub – KIRAN-KUMAR-K3](https://github.com/KIRAN-KUMAR-K3)

---

## 🪪 License

This project is licensed under the **MIT License**.
You are free to use, modify, and distribute it with appropriate attribution.

---

## 📚 References

* [Microsoft Defender for Endpoint on Linux (Official Docs)](https://learn.microsoft.com/en-us/defender-endpoint/linux-install-manually)

---

### 🧠 Professional Note

> These automation scripts are optimized for enterprise-grade deployments.
> Ensure your environment has valid **Microsoft Defender onboarding credentials** before running.
> Recommended for SOC, SecOps, and infrastructure security teams managing hybrid Linux environments.

---
