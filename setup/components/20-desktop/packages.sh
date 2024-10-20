#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing audio-related packages"
pkg_install \
    pavucontrol \
    playerctl

echo "[*] Installing VPN-related packages"
pkg_install \
    networkmanager-openvpn \
    openvpn

echo "[*] Installing misc packages"
pkg_install \
    brightnessctl \
    papirus-icon-theme
