#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing GDM"
pkg_install \
    gdm

echo "[*] Making sure 'gdm.service' is enabled"
sudo systemctl enable gdm.service
