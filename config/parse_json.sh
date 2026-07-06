#!/bin/bash

# parse_json.sh — Extract a value from a JSON file using jq.
#
# Usage: ./parse_json.sh <file.json> <jq_filter>
#        ./parse_json.sh <file.json> .name
#        ./parse_json.sh <file.json> '.servers[0].host'

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <file.json> <jq_filter>" >&2
    echo "Example: $0 config.json .database.host" >&2
    exit 1
fi

JSON_FILE="$1"
FILTER="$2"

if [[ ! -f "$JSON_FILE" ]]; then
    echo "Error: file not found: $JSON_FILE" >&2
    exit 1
fi

if ! command -v jq &>/dev/null; then
    echo "Error: jq is not installed. Install via your package manager." >&2
    exit 1
fi

jq -r "$FILTER" "$JSON_FILE"
