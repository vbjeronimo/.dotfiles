#!/bin/bash

set -e

echo "[*] Installing misc packages"
sudo pacman -S --needed --noconfirm \
    brightnessctl \
    bluetoothctl \
    dunst \
    flameshot \
    network-manager-applet \
    papirus-icon-theme
