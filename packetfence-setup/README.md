# 🌐 PacketFence Installation Script

This folder contains a script to automate the repository setup and installation of **PacketFence**, an open-source network access control (NAC) system.

---

## 📄 Script

- `packetfence-install.sh`:  
  Performs the following:
  - Adds the official PacketFence Debian repository
  - Imports the GPG key
  - Updates the package list
  - Installs PacketFence using APT

---

## 🧪 Usage

```bash
chmod +x packetfence-install.sh
./packetfence-install.sh
````

> ⚠️ Ensure you're running this on a **Debian 12 (Bookworm)** or compatible system.

---

## 🧠 Note

After installation, refer to the official documentation for:

* Web interface access
* Configuration steps
* Network interface binding

📚 [https://packetfence.org/documentation/](https://packetfence.org/documentation/)

---
