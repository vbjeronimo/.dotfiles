#!/bin/bash

set -e

echo "[*] Running script to install desktop environment packages"

sudo apt install -y --no-upgrade \
    alacritty \
    arandr \
    autorandr \
    dunst \
    feh \
    i3 \
    papirus-icon-theme \
    rofi
