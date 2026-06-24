#!/bin/bash

# Script reads file arg line by line and prints to console. 
#
# Usage: ./read_lines.sh <file>

while IFS= read -r line; do 
    echo "$line"
    if [[ "$line" == "exit" ]]; then
        break
    fi
done < "$1"


