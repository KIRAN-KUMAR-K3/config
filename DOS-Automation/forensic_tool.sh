#!/bin/bash

# configuration - base paths
DOS_LOG_DIR="/mnt/firewall-logs/Firewall-Logs/Firewall"
MAC_LOG_DIR="/mnt/firewall-logs/Firewall-Logs/Mac_IP"
RAD_LOG_DIR="/mnt/radius-logs/primary-radius"

# --- Interactive Input ---
echo "=========================================================="
echo "    NETWORK FORENSIC CORRELATION TOOL (Sophos/Radius)     "
echo "=========================================================="

read -p "Enter Target Date (Format DD.MM.YY, e.g., 23.12.25): " TARGET_DATE

# Validate Date Format
if [[ ! $TARGET_DATE =~ ^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$ ]]; then
    echo "Error: Invalid date format. Use DD.MM.YY"
    exit 1
fi

read -p "Enter Source IP(s) separated by space: " -a SRC_IPS

REPORT_FILE="Forensic_Report_$TARGET_DATE.txt"
echo "Forensic Report Generated on $(date)" > "$REPORT_FILE"
echo "Target Date: $TARGET_DATE" >> "$REPORT_FILE"
echo "----------------------------------------------------------" >> "$REPORT_FILE"

echo -e "\n[i] Processing logs... please wait."

for IP in "${SRC_IPS[@]}"; do
    echo -e "\n>>> Analyzing IP: $IP" | tee -a "$REPORT_FILE"
    
    # 1. FIREWALL TRAFFIC ANALYSIS
    echo "    1. Traffic Analysis (Top 5 Destinations):" | tee -a "$REPORT_FILE"
    DOS_FILE="$DOS_LOG_DIR/DoS_Attack.$TARGET_DATE.gz"
    if [ -f "$DOS_FILE" ]; then
        # Extracts dst_ip, counts them, and gets top 5
        TRAFFIC=$(zgrep "src_ip=$IP" "$DOS_FILE" | awk -F'dst_ip=' '{print $2}' | awk '{print $1}' | sort | uniq -c | sort -rn | head -n 5)
        if [ ! -z "$TRAFFIC" ]; then
            echo "$TRAFFIC" | sed 's/^/       /' | tee -a "$REPORT_FILE"
        else
            echo "       No DoS traffic found for this IP." | tee -a "$REPORT_FILE"
        fi
    else
        echo "       Error: DoS log file missing ($DOS_FILE)" | tee -a "$REPORT_FILE"
    fi

    # 2. MAC ADDRESS LOOKUP
    echo "    2. Hardware MAC History:" | tee -a "$REPORT_FILE"
    MAC_FILE="$MAC_LOG_DIR/$TARGET_DATE.hourly.gz"
    MAC_ADDRS=()
    if [ -f "$MAC_FILE" ]; then
        MATCHES=$(zgrep "$IP" "$MAC_FILE")
        if [ ! -z "$MATCHES" ]; then
            echo "$MATCHES" | awk '{printf "       [%s] MAC: %s\n", $1, $3}' | tee -a "$REPORT_FILE"
            MAC_ADDRS=($(echo "$MATCHES" | awk '{print $3}' | sort -u))
        else
            echo "       No MAC assignment found in hourly logs." | tee -a "$REPORT_FILE"
        fi
    fi

    # 3. RADIUS IDENTITY LOOKUP
    echo "    3. Identified Users (Radius):" | tee -a "$REPORT_FILE"
    RAD_FILE="$RAD_LOG_DIR/radius.log.$TARGET_DATE.gz"
    if [ -f "$RAD_FILE" ] && [ ${#MAC_ADDRS[@]} -gt 0 ]; then
        FOUND_USER=0
        for MAC in "${MAC_ADDRS[@]}"; do
            # Greps for the MAC in Radius Login OK entries
            USER_INFO=$(zgrep -i "cli $MAC" "$RAD_FILE" | grep "Login OK" | tail -n 1)
            if [ ! -z "$USER_INFO" ]; then
                EMAIL=$(echo "$USER_INFO" | awk -F'[' '{print $2}' | awk -F']' '{print $1}')
                echo "       MATCH: $EMAIL (MAC: $MAC)" | tee -a "$REPORT_FILE"
                FOUND_USER=1
            fi
        done
        [ $FOUND_USER -eq 0 ] && echo "       No Radius identity found for these MACs." | tee -a "$REPORT_FILE"
    else
        echo "       Identity check skipped (No MAC or Log missing)." | tee -a "$REPORT_FILE"
    fi
    echo "----------------------------------------------------------" >> "$REPORT_FILE"
done

echo -e "\n[OK] Analysis Complete."
echo "[OK] Full report saved to: $REPORT_FILE"
