#!/bin/bash

set -eu

echo "[*] Installing Wayland"
sudo pacman -S --needed --noconfirm \
    wev \
    wayland

echo "[*] Installing Sway"
sudo pacman -S --needed --noconfirm \
    swaybg \
    swayidle \
    swaylock \
    sway \
    wmenu

echo "[*] Installing Waybar"
sudo pacman -S --needed --noconfirm \
    waybar

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "sway" \
    "waybar"
