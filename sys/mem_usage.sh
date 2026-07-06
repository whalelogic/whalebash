#!/bin/bash

# mem_usage.sh — Display memory usage statistics.
#
# Usage: ./mem_usage.sh

set -euo pipefail

WARN_PCT="${WHALEBASH_MEM_WARN_PCT:-80}"

# Parse /proc/meminfo for portable, tool-independent results
mem_total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
mem_free=$(awk '/^MemFree:/ {print $2}' /proc/meminfo)
mem_available=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
mem_buffers=$(awk '/^Buffers:/ {print $2}' /proc/meminfo)
mem_cached=$(awk '/^Cached:/ {print $2}' /proc/meminfo)
swap_total=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
swap_free=$(awk '/^SwapFree:/ {print $2}' /proc/meminfo)

mem_used=$(( mem_total - mem_available ))
mem_used_pct=$(( mem_used * 100 / mem_total ))
swap_used=$(( swap_total - swap_free ))

to_mb() { echo $(( ${1} / 1024 )); }

echo "=== Memory Usage ==="
printf "%-12s %8s MB\n" "Total:"     "$(to_mb "$mem_total")"
printf "%-12s %8s MB\n" "Used:"      "$(to_mb "$mem_used")"
printf "%-12s %8s MB\n" "Free:"      "$(to_mb "$mem_free")"
printf "%-12s %8s MB\n" "Available:" "$(to_mb "$mem_available")"
printf "%-12s %8s MB\n" "Buffers:"   "$(to_mb "$mem_buffers")"
printf "%-12s %8s MB\n" "Cached:"    "$(to_mb "$mem_cached")"
printf "%-12s %8s%%\n"  "Usage:"     "$mem_used_pct"

if [[ "$swap_total" -gt 0 ]]; then
    swap_used_pct=$(( swap_used * 100 / swap_total ))
    echo ""
    echo "=== Swap ==="
    printf "%-12s %8s MB\n" "Total:"  "$(to_mb "$swap_total")"
    printf "%-12s %8s MB\n" "Used:"   "$(to_mb "$swap_used")"
    printf "%-12s %8s%%\n"  "Usage:"  "$swap_used_pct"
fi

if [[ "$mem_used_pct" -ge "$WARN_PCT" ]]; then
    echo "" >&2
    echo "Warning: memory usage is at ${mem_used_pct}% (threshold: ${WARN_PCT}%)" >&2
fi
