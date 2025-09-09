# Microsoft Defender for Endpoint on Ubuntu

This repository provides an automated script to install and configure **Microsoft Defender for Endpoint (MDE)** on Ubuntu servers.  
The script ensures all dependencies, repositories, and configurations are handled seamlessly.

## 🚀 Quick Setup
```bash
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config/Defender
chmod +x install_defender.sh
./install_defender.sh
````

## 🔍 Verification

After installation, validate Defender’s status and connectivity:

```bash
mdatp health
mdatp connectivity test
```

## 🖥 Supported Versions

* Ubuntu 20.04 LTS
* Ubuntu 22.04 LTS

## 📚 Resources

* [Microsoft Defender for Endpoint on Linux – Official Documentation](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/linux-install-manually)

---

👤 **Maintainer**: [Kiran Kumar K](https://github.com/KIRAN-KUMAR-K3)

