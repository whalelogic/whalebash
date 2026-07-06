#!/bin/bash

# disk_usage.sh — Display disk space for all mounted filesystems.
#
# Usage: ./disk_usage.sh [mount_point]

set -euo pipefail

WARN_PCT="${WHALEBASH_DISK_WARN_PCT:-80}"
MOUNT="${1:-}"

echo "=== Disk Usage ==="
printf "%-30s %8s %8s %8s %6s\n" "Mount" "Total" "Used" "Avail" "Use%"
printf "%-30s %8s %8s %8s %6s\n" "-----" "-----" "----" "-----" "----"

warned=false

while IFS= read -r line; do
    mount=$(echo "$line" | awk '{print $6}')
    total=$(echo "$line" | awk '{print $2}')
    used=$(echo "$line" | awk '{print $3}')
    avail=$(echo "$line" | awk '{print $4}')
    pct=$(echo "$line" | awk '{print $5}' | tr -d '%')

    printf "%-30s %8s %8s %8s %5s%%\n" "$mount" "$total" "$used" "$avail" "$pct"

    if [[ "$pct" -ge "$WARN_PCT" ]] 2>/dev/null; then
        warned=true
    fi
done < <(df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs \
            ${MOUNT:+"$MOUNT"} | tail -n +2)

if $warned; then
    echo "" >&2
    echo "Warning: one or more filesystems exceed ${WARN_PCT}% usage." >&2
fi
