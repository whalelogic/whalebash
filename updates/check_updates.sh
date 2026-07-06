#!/bin/bash

# check_updates.sh — Check for available system package updates.
# Supports apt, dnf, and pacman. Detects automatically unless overridden.
#
# Usage: ./check_updates.sh

set -euo pipefail

PKG_MANAGER="${WHALEBASH_PKG_MANAGER:-auto}"

detect_pkg_manager() {
    for pm in apt dnf pacman; do
        command -v "$pm" &>/dev/null && { echo "$pm"; return; }
    done
    echo "unknown"
}

[[ "$PKG_MANAGER" == "auto" ]] && PKG_MANAGER="$(detect_pkg_manager)"

echo "=== Update Check (${PKG_MANAGER}) ==="

case "$PKG_MANAGER" in
    apt)
        sudo apt update -qq 2>/dev/null
        count=$(apt list --upgradable 2>/dev/null | grep -c upgradable || true)
        echo "Upgradable packages: $count"
        apt list --upgradable 2>/dev/null | grep -v "^Listing" || true
        ;;
    dnf)
        echo "Available updates:"
        dnf check-update --quiet || true
        ;;
    pacman)
        sudo pacman -Sy --noconfirm &>/dev/null
        updates=$(pacman -Qu 2>/dev/null || true)
        count=$(echo "$updates" | grep -c . || true)
        echo "Upgradable packages: $count"
        echo "$updates"
        ;;
    *)
        echo "Error: unsupported or undetected package manager." >&2
        echo "Set WHALEBASH_PKG_MANAGER in config/config.env (apt | dnf | pacman)." >&2
        exit 1
        ;;
esac
