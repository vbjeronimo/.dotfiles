#!/bin/bash

set -eu

echo "[*] Setting up environment for bash development"
sudo pacman -S --needed --noconfirm \
    shellcheck
