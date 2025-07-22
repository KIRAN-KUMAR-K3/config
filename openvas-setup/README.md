# 🛡️ OpenVAS (GVM) Setup Script

This folder contains an automation script to install, configure, and launch **OpenVAS (Greenbone Vulnerability Manager)** on Debian-based systems like **Kali Linux**.

---

## 📄 Script

- `gvm-installer-and-setup.sh`:  
  Automates the following tasks:
  - Stops and removes any previous GVM/OpenVAS installations
  - Cleans up configuration and data files
  - Installs the latest GVM packages
  - Runs full setup and starts services
  - Optionally resets the `admin` password

---

## 🧪 Usage

```bash
chmod +x gvm-installer-and-setup.sh
./gvm-installer-and-setup.sh
````

> 🔐 Optionally prompts for a new GVM admin password during setup.

---

## 🌐 Web Access

Once complete, access the GVM Web UI:

```
https://127.0.0.1:9392
Username: admin
```


