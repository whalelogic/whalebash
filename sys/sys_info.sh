#!/bin/bash

# sys_info.sh — General system information summary.
#
# Usage: ./sys_info.sh

set -euo pipefail

echo "=== System Info ==="
printf "%-16s %s\n" "Hostname:"    "$(hostname)"
printf "%-16s %s\n" "OS:"          "$(grep -oP '(?<=PRETTY_NAME=").*(?=")' /etc/os-release 2>/dev/null || uname -s)"
printf "%-16s %s\n" "Kernel:"      "$(uname -r)"
printf "%-16s %s\n" "Arch:"        "$(uname -m)"
printf "%-16s %s\n" "User:"        "${USER}"
printf "%-16s %s\n" "Shell:"       "${SHELL}"
printf "%-16s %s\n" "Uptime:"      "$(uptime -p 2>/dev/null || uptime)"

echo ""
echo "=== CPU ==="
cpu_model=$(grep -m1 'model name' /proc/cpuinfo | cut -d':' -f2 | xargs)
cpu_cores=$(grep -c '^processor' /proc/cpuinfo)
load=$(cut -d' ' -f1-3 /proc/loadavg)
printf "%-16s %s\n" "Model:"       "$cpu_model"
printf "%-16s %s\n" "Cores:"       "$cpu_cores"
printf "%-16s %s\n" "Load avg:"    "$load"
