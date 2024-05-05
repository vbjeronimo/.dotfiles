#!/bin/bash

set -e

echo "[*] Starting script to install and setup applications"

if ! command syncthing &> /dev/null; then
    echo "[*] Installing and setting up syncthing"
    sudo apt-get install -y --no-upgrade \
        syncthing \
        syncthingtray

    systemctl --user enable --now syncthing.service
fi
