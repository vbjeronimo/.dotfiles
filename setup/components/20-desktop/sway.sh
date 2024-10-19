#!/bin/bash

set -e

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Making sure Wayland is installed"
pkg_install \
    wayland

echo "[*] Installing Sway"
pkg_install \
    swaybg \
    swayidle \
    swaylock \
    sway
