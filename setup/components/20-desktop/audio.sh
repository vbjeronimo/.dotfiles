#!/bin/bash

set -eu

echo "[*] Installing audio-related packages"
sudo pacman -S --needed --noconfirm \
    pavucontrol \
    playerctl
