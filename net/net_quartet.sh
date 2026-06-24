#!/bin/bash

# This script gathers and displays the "net quartet" or network configuration details of the system, including:
# IP address
# Subnet mask
# Gateway
# DNS servers

PUBLIC_IP=$(curl -s https://ifconfig.me)
echo "Public IP: $PUBLIC_IP"

SUBNET_MASK=$(ip addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f2)
echo "Subnet Mask: $SUBNET_MASK"

GATEWAY=$(ip route | grep default | awk '{print $3}')
echo "Gateway: $GATEWAY"

DNS_SERVERS=$(nmcli dev show | grep 'IP4.DNS' | awk '{print $2}')
echo "DNS Servers: $DNS_SERVERS"


