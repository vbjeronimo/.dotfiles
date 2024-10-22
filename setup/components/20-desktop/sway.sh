#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing Wayland"
pkg_install \
    wev \
    wayland

echo "[*] Installing Sway"
pkg_install \
    swaybg \
    swayidle \
    swaylock \
    sway \
    wmenu

echo "[*] Installing Waybar"
pkg_install \
    waybar
