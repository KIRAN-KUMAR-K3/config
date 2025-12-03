# 📘 **Azure AD Joining & Device Migration – Complete Guide**

This document provides a comprehensive guide for joining Windows devices (Windows 10/11) to **Azure Active Directory (Microsoft Entra ID)**, transferring local user data, configuring Remote Desktop (RDP), and performing post-migration tasks.

---

# 🏷️ **1. Azure AD Join Process (For Already Installed Windows 10/11)**

This process applies to machines where Windows OS is already installed and needs to be enrolled into Microsoft Entra ID.

---

## 🔹 **Step 1 — Open Settings**

Navigate to:

```
Settings → Accounts → Access work or school
```

---

## 🔹 **Step 2 — Connect to Azure AD (Microsoft Entra ID)**

1. Click **Connect**
2. Select **Join this device to Microsoft Entra ID**

---

## 🔹 **Step 3 — Sign In**

* Enter the Azure AD email address that has permission to join the machine.
* Authenticate using user credentials.
* Complete **Multi-Factor Authentication (MFA)** if prompted.

---

## 🔹 **Step 4 — Restart the Device**

Once the join completes, restart the device (even if not prompted).

---

## 🔹 **Step 5 — First Login (Performed by User)**

On the login screen:

* Click **Other User**
* Enter Azure AD credentials:

```
Username: username@iisc.ac.in
Password: XXXXXXXXX
```

Windows will create a new Azure AD user profile during the first login.

---

## 📝 **Notes**

* Requires **Windows 10/11 Pro, Enterprise, or Education**
* Stable **internet connection** is mandatory
* Joining requires Azure AD permission for the admin account

---

# 🧑‍💻 **2. Managing Local Administrators Group**

---

## ✔️ **Check Local Administrators**

```cmd
net localgroup Administrators
```

---

## ✔️ **Remove Azure AD User from Local Admin Group**

```cmd
net localgroup "Administrators" /Delete "AzureAD\adjoin.digits@iisc.ac.in"
```

---

## ✔️ **Sign in as Local User to Manage Permissions**

Login format:

```
Username: local\username
Password: (local user password)
```

---

# 📂 **3. Transfer Data from Local User to Azure AD User**

### **Requirements:**

* Local admin access
* Both accounts available on the device

---

## 🔹 **Step 1 — Ensure Machine Is Azure AD Joined**

```
Settings → Accounts → Access work or school → Connect → Join this device to Entra ID
```

---

## 🔹 **Step 2 — Sign In with Azure AD Account**

1. Sign out of local account
2. Login with the Azure AD account
3. Windows creates a **new user profile**
4. Log out once profile initialization completes

---

## 🔹 **Step 3 — Log In to Local Account**

```
Username: local\username
Password: local_password
```

---

## 🔹 **Step 4 — Manually Copy User Data**

From:

```
C:\Users\LocalUser
```

To:

```
C:\Users\AzureADUser
```

Copy only:

* Desktop
* Documents
* Downloads
* Pictures
* Music
* Favorites

> ❗ **Do NOT copy the entire profile folder. Only copy data.**

---

## 🔹 **Step 5 — Test After Migration**

Login with Azure AD user and verify:

* Data availability
* App access
* Shortcuts & settings
* OneDrive & Outlook setup

---

## 🔹 **Step 6 — Cleanup**

Once confirmed:

* Backup & remove old local profile
* Remove local account from

  ```
  Settings → Accounts → Other Users
  ```

---

# 🖥️ **4. RDP Setup After Azure AD Join**

---

## 🔹 **Step 1 — Login with Local Admin**

```
Username: local\username
Password: local_password
```

---

## 🔹 **Step 2 — Enable Remote Desktop**

```
Settings → System → Remote Desktop → Enable
```

---

## 🔹 **Step 3 — Allow Azure AD User to Use RDP**

```cmd
net localgroup "Remote Desktop Users" /add "AzureAD\username@iisc.ac.in"
```

> ✔ Machine **must** be Azure AD joined for this to work.

---

# 👤 **5. Creating a Local Administrator Account (Windows 11)**

1. **Settings** → Accounts → Other users
2. **Add account**
3. Click *I don't have this person’s sign-in information*
4. Click *Add a user without a Microsoft account*
5. Enter username + password
6. Click account → **Change account type → Administrator**

---

# 🚫 **6. Disable Existing Local User Account**

1. Press **Win + X → Computer Management**
2. Navigate to:

   ```
   System Tools → Local Users and Groups → Users
   ```
3. Right-click user → **Properties**
4. Check **Account is disabled**

---

# 🖥️ **7. Differences After Device Joins Azure AD**

---

## ✔️ **Login Behavior Changes**

Login format:

```
username@iisc.ac.in
password
```

> First login **requires internet**.

---

## ✔️ **Data Access Changes**

* Local data does **not** automatically move
* Admin must manually migrate data

---

## ✔️ **Permissions Changes**

* Standard users cannot install software
* Many system settings require admin approval

---

# ⚙️ **8. Pre-Requisites**

---

## ✔️ Windows Edition Requirements

* Windows 10/11 **Pro**
* Windows 10/11 **Enterprise**
* Windows 10/11 **Education**

---

## ✔️ System Requirements

* Admin email must have AD join permissions
* Must log in using **local admin** to join machine
* Stable internet connection required

---

## ✔️ User Requirements

* Must have Azure AD account
* Device must have continuous internet

---

# ⏱️ **9. Estimated Time Per Device**

| Task                            | Time                 |
| ------------------------------- | -------------------- |
| Join device to Azure AD         | 10–15 minutes        |
| First login & profile creation  | 5–10 minutes         |
| Data migration                  | Depends on data size |
| **Total (excluding data copy)** | **20–30 minutes**    |

---

# 🔍 **10. Useful Commands**

---

### ✔ Get System UUID

```powershell
Get-CimInstance -ClassName Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID
```

---

### ✔ Check Local Admin Group

```cmd
net localgroup administrators
```

---

### ✔ Remove Azure AD Admin

```cmd
net localgroup "Administrators" /Delete "AzureAD\mailid"
```

---

### ✔ Allow RDP Access for Azure AD Account

```cmd
net localgroup "Remote Desktop Users" /add "AzureAD\username@iisc.ac.in"
```

