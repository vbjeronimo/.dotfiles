#!/bin/bash

set -e

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing greetd"
pkg_install \
    greetd-tuigreet \
    greetd

echo "[*] Making sure 'greetd.service' is enabled"
sudo systemctl enable greetd.service
