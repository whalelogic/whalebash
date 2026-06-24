#!/bin/bash

TARGET="www.howtogo.dev"

GATEWAY=$(ip route show default | awk '/default/ {print $3}')
echo "Default Gateway (Router): $GATEWAY"

echo "--- Starting Direct Trace ---"
traceroute -n "$TARGET"

if command -v proxychains4 &> /dev/null; then
    echo "--- Starting Proxy Trace ---"
    proxychains4 traceroute -n "$TARGET"
else
    echo "Error: proxychains4 not found. Install via 'sudo dnf install proxychains-ng'."
fi
