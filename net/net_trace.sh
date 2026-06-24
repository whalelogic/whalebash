#!/bin/bash

# Define Target
TARGET="www.howtogo.dev"

# 1. Identify Gateway
GATEWAY=$(ip route show default | awk '/default/ {print $3}')
echo "Default Gateway (Router): $GATEWAY"

# 2. Direct Trace
echo "--- Starting Direct Trace ---"
traceroute -n "$TARGET"

# 3. Proxy Trace
# Requires proxychains4 to be installed and configured on Fedora
if command -v proxychains4 &> /dev/null; then
    echo "--- Starting Proxy Trace ---"
    proxychains4 traceroute -n "$TARGET"
else
    echo "Error: proxychains4 not found. Install via 'sudo dnf install proxychains-ng'."
fi
