#!/bin/bash

set -e

echo "[*] Installing Wayland"
sudo pacman -S --needed --noconfirm \
    xorg-xwayland \
    wev \
    wayland \

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

HOME=""
if [[ -n "$SUDO_USER" ]]; then
    HOME="/home/${SUDO_USER}"
else
    HOME="/home/${USER}"
fi

wallpapers_dir="${HOME}/pictures/wallpapers"
default_wallpaper_url="https://w.wallhaven.cc/full/13/wallhaven-13zzg9.png"
wallpaper_name="${default_wallpaper_url##*/}"
wallpaper_path="${wallpapers_dir}/${wallpaper_name}"

echo "[*] Pulling default wallpaper from '$default_wallpaper_url'"
mkdir -p "$wallpapers_dir"
curl -Lo "$wallpaper_path" "$default_wallpaper_url"

echo "[*] Setting wallpaper '$wallpaper_path' as active"
ln -rs "$wallpaper_path" "${wallpapers_dir}/active"
