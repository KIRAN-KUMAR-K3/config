# Microsoft Defender for Endpoint on Linux – Installation Script

This repository provides an **automated installation script** to set up Microsoft Defender for Endpoint (MDE) on Linux systems.  
The script simplifies the deployment process, ensuring that Defender is properly installed and ready to be onboarded to your Microsoft 365 Defender portal.

---

## 📌 Features
- Automates the installation of Microsoft Defender for Endpoint on Linux.
- Ensures required dependencies are installed.
- Provides a seamless onboarding workflow.

---

## ⚙️ Supported Platforms
- Kali Linux  
- Ubuntu  
- Debian-based distributions  
- (Other modern Linux distros may also work with minor adjustments.)

---

## 🚀 Installation Steps

### 1. Clone the Repository
```bash
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config/Defender
chmod +x install_defender.sh
````

### 2. Run the Installer

```bash
./install_defender.sh
```

This will install Microsoft Defender on your system.

---

## 🔒 Onboarding to Microsoft 365 Defender

Once Defender is installed, you need to onboard the device to your **Microsoft 365 Defender Security portal**:

1. Log in to your Microsoft 365 Defender Security portal:
   👉 [https://security.microsoft.com](https://security.microsoft.com)

2. Navigate to:
   **Settings → Endpoints → Device onboarding → Linux**

3. Download the **Linux onboarding package (ZIP)**.

4. Extract the ZIP file – you will see a Python script like:

   ```
   MicrosoftDefenderATPOnboardingLinuxServer.py
   ```

5. Run the onboarding script with root:

   ```bash
   sudo python3 MicrosoftDefenderATPOnboardingLinuxServer.py
   ```

6. Wait a few minutes for the device to register.

7. Verify Defender health:

   ```bash
   mdatp health
   ```

   ✅ You should see:

   ```
   "healthy": true
   ```

---

## 🛠️ Troubleshooting

* If `mdatp` is not found, ensure the Defender service is installed and running.
* Re-run the onboarding script if the device does not appear in the portal.
* Check logs in `/var/log/microsoft/mdatp/` for detailed error messages.

---

## 📜 License

This project is released under the MIT License.
You are free to modify and use it as per your needs.

---

## 📚 Resources

* [Microsoft Defender for Endpoint on Linux – Official Documentation](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/linux-install-manually)

---

## 👨‍💻 Author

**Kiran Kumar K**
🔗 [GitHub](https://github.com/KIRAN-KUMAR-K3) | [LinkedIn](https://www.linkedin.com/in/kiran-kumark3)

