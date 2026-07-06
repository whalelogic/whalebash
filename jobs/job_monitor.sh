#!/bin/bash

# job_monitor.sh — List background jobs tracked via PID files.
# Shows job name, PID, and running status.
#
# Usage: ./job_monitor.sh [--kill <job_name>]

set -euo pipefail

PID_DIR="${WHALEBASH_PID_DIR:-${HOME}/.local/share/whalebash/pids}"

if [[ "$#" -ge 2 && "$1" == "--kill" ]]; then
    pid_file="${PID_DIR}/${2}.pid"
    if [[ ! -f "$pid_file" ]]; then
        echo "Error: no PID file for job '${2}'." >&2
        exit 1
    fi
    pid=$(<"$pid_file")
    kill "$pid" && rm -f "$pid_file"
    echo "Killed job '${2}' (PID $pid)."
    exit 0
fi

if [[ ! -d "$PID_DIR" ]] || [[ -z "$(ls -A "$PID_DIR" 2>/dev/null)" ]]; then
    echo "No tracked jobs found in $PID_DIR"
    exit 0
fi

printf "%-20s %-8s %s\n" "JOB" "PID" "STATUS"
printf "%-20s %-8s %s\n" "---" "---" "------"

for pid_file in "${PID_DIR}"/*.pid; do
    job_name="$(basename "$pid_file" .pid)"
    pid=$(<"$pid_file")
    if kill -0 "$pid" 2>/dev/null; then
        status="running"
    else
        status="stopped (stale PID file removed)"
        rm -f "$pid_file"
    fi
    printf "%-20s %-8s %s\n" "$job_name" "$pid" "$status"
done
