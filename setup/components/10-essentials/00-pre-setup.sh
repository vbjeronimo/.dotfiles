#!/bin/bash

set -e

echo "[*] Starting pre-setup script"

echo "[*] Updating apt cache"
sudo apt-get update

echo "[*] Updating all packages"
sudo apt-get upgrade -y --no-upgrade \
    curl \
    git \
    stow
