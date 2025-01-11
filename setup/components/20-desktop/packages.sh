#!/bin/bash

set -e

echo "[*] Installing misc packages"
sudo pacman -S --needed --noconfirm \
    brightnessctl \
    dunst \
    firefox \
    flameshot \
    network-manager-applet \
    rofi \
    papirus-icon-theme

    # bluetoothctl \
