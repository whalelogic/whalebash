#!/bin/bash

# parse_yaml.sh — Extract a value from a YAML file.
# Uses 'yq' if available, otherwise falls back to python3.
#
# Usage: ./parse_yaml.sh <file.yaml> <key_path>
#        ./parse_yaml.sh config.yaml .database.host
#        ./parse_yaml.sh config.yaml .servers[0].port

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <file.yaml> <key_path>" >&2
    echo "Example: $0 config.yaml .database.host" >&2
    exit 1
fi

YAML_FILE="$1"
KEY_PATH="$2"

if [[ ! -f "$YAML_FILE" ]]; then
    echo "Error: file not found: $YAML_FILE" >&2
    exit 1
fi

if command -v yq &>/dev/null; then
    yq -r "$KEY_PATH" "$YAML_FILE"
elif command -v python3 &>/dev/null; then
    python3 - "$YAML_FILE" "$KEY_PATH" <<'EOF'
import sys, re

def get_value(data, path):
    # Resolve dot-notation path against a simple key:value YAML structure
    keys = [k for k in re.split(r'\.|\[(\d+)\]', path.lstrip('.')) if k]
    for key in keys:
        if isinstance(data, list):
            data = data[int(key)]
        elif isinstance(data, dict):
            data = data.get(key)
        else:
            return None
    return data

try:
    import yaml
    with open(sys.argv[1]) as f:
        data = yaml.safe_load(f)
    result = get_value(data, sys.argv[2])
    print(result if result is not None else "")
except ImportError:
    print("Error: python3 'yaml' module not available. Install yq or PyYAML.", file=sys.stderr)
    sys.exit(1)
EOF
else
    echo "Error: neither 'yq' nor 'python3' is available." >&2
    exit 1
fi
