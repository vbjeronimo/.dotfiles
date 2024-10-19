#!/bin/bash

set -e

echo "[*] Starting pre-setup script"

echo "[*] Updating apt cache"
sudo apt-get update

echo "[*] Installing essential packages"
sudo apt-get upgrade -y --no-upgrade \
    curl \
    git \
    stow
