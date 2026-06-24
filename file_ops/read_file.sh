#!/bin/bash

# Exit if something bad happens
set -euo pipefail

if [ $# -lt 1 ]; then 
    echo "Missing file path argument. " >&2
    echo "Usage: $0 <file_path>" >&2
    exit 1
fi

FILE_PATH="$1"
MAX_LINES=${2:--1}

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File $FILE_PATH not found." >&2
    exit 1
fi

count=1

# Output numbered lines
echo "--- Reading File: \"$FILE_PATH\" --- "
while IFS= read -r line && { [ "$MAX_LINES" -eq -1 ] || [ "$count" -le "$MAX_LINES" ]; }; do
    echo "$count: $line"
    ((count++))
done < "$FILE_PATH"

echo "--- Finished ---"

