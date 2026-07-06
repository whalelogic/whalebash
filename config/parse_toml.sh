#!/bin/bash

# parse_toml.sh — Read a value from a TOML file by key.
# Handles simple key = "value" and key = value (no nested tables).
#
# Usage: ./parse_toml.sh <file.toml> <key>
#        ./parse_toml.sh <file.toml>          # prints all key=value pairs

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <file.toml> [key]" >&2
    exit 1
fi

TOML_FILE="$1"
KEY="${2:-}"

if [[ ! -f "$TOML_FILE" ]]; then
    echo "Error: file not found: $TOML_FILE" >&2
    exit 1
fi

# Strip comments and blank lines, then parse key = value lines
parse_all() {
    grep -E '^\s*[^#[[:space:]][^=]+=.+' "$TOML_FILE" \
        | sed 's/[[:space:]]*=[[:space:]]*/=/' \
        | sed 's/^[[:space:]]*//' \
        | sed 's/"//g'
}

if [[ -z "$KEY" ]]; then
    parse_all
else
    parse_all | grep "^${KEY}=" | cut -d'=' -f2-
fi
