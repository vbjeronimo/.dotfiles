#!/bin/bash

set -e

echo "[*] Running script to install desktop environment packages"

sudo apt install -y --no-upgrade \
    alacritty \
    arandr \
    dunst \
    i3 \
    feh \
    papirus-icon-theme \
    rofi
