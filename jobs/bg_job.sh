#!/bin/bash

# bg_job.sh — Run a command in the background and save its PID.
#
# Usage: ./bg_job.sh <job_name> <command> [args...]
#   job_name  — short label used for the PID file (~/.local/share/whalebash/pids/<name>.pid)
#   command   — the command to run in the background

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <job_name> <command> [args...]" >&2
    exit 1
fi

JOB_NAME="$1"; shift
PID_DIR="${WHALEBASH_PID_DIR:-${HOME}/.local/share/whalebash/pids}"
PID_FILE="${PID_DIR}/${JOB_NAME}.pid"

mkdir -p "$PID_DIR"

# Warn if a job with this name is already running
if [[ -f "$PID_FILE" ]]; then
    old_pid=$(<"$PID_FILE")
    if kill -0 "$old_pid" 2>/dev/null; then
        echo "Warning: job '$JOB_NAME' already running (PID $old_pid)." >&2
        exit 1
    fi
fi

"$@" &
JOB_PID=$!
echo "$JOB_PID" > "$PID_FILE"

echo "Started '$JOB_NAME' (PID $JOB_PID) — PID file: $PID_FILE"
