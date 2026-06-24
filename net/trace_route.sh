#!/bin/bash

PUBLIC_IP=$(curl -s https://ifconfig.me)

TARGET="www.howtogo.dev"

echo "Public IP: $PUBLIC_IP"

GATEWAY=$(ip route | grep default | awk '{print $3}')
echo "Gateway: $GATEWAY"

echo "Starting trace-------"

traceroute -n $TARGET


