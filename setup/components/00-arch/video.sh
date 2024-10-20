#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing video driver"
if lspci -v | grep "VGA" | grep "Intel"; then
    echo "[*] Installing xf86-video-intel"
    pkg_install xf86-video-intel
else
    echo "[*] ERROR: Could not find the correct video driver to install"
    exit 1
fi
