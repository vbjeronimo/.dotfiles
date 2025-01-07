#!/bin/bash

set -e

echo "[*] Installing VPN-related packages"
sudo pacman -S --needed --noconfirm \
    networkmanager-openvpn \
    openvpn
