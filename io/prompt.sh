#!/bin/bash

# prompt.sh — Interactive prompt with optional default and validation.
# Source this file to use prompt() in other scripts, or run directly.
#
# Usage (sourced):  source io/prompt.sh
#                   prompt "Enter hostname" "localhost" hostname
#                   echo "Got: $hostname"
#
# Usage (direct):   ./prompt.sh "Enter hostname" "localhost"

# prompt <message> [default] [var_name]
#   Reads user input; uses default if empty; stores in var_name (or REPLY).
prompt() {
    local message="$1"
    local default="${2:-}"
    local var_name="${3:-REPLY}"

    local display="$message"
    [[ -n "$default" ]] && display+=" [$default]"
    display+=": "

    read -rp "$display" input
    local value="${input:-$default}"

    if [[ -z "$value" ]]; then
        echo "Error: a value is required." >&2
        return 1
    fi

    printf -v "$var_name" '%s' "$value"
}

# prompt_confirm <message> — Returns 0 for yes, 1 for no.
prompt_confirm() {
    local message="${1:-Continue?}"
    read -rp "${message} [y/N]: " input
    [[ "${input,,}" == "y" || "${input,,}" == "yes" ]]
}

# Allow direct invocation: ./prompt.sh "message" [default]
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    prompt "${1:-Enter value}" "${2:-}" REPLY
    echo "$REPLY"
fi
