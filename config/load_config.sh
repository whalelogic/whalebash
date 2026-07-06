#!/bin/bash

# load_config.sh — Source config.env and validate required variables.
#
# Usage:  source config/load_config.sh [config_file]
#   or    . config/load_config.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${1:-${SCRIPT_DIR}/config.env}"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: config file not found: $CONFIG_FILE" >&2
    exit 1
fi

# shellcheck source=/dev/null
source "$CONFIG_FILE"

# Create runtime directories if they don't exist
mkdir -p "${WHALEBASH_LOG_DIR:-/tmp/whalebash/logs}"
mkdir -p "${WHALEBASH_PID_DIR:-/tmp/whalebash/pids}"

echo "Config loaded from: $CONFIG_FILE"
