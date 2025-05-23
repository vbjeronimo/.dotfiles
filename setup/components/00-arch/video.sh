#!/bin/bash

set -eu

echo "[*] Installing video driver"
if lspci -v | grep "VGA" | grep -q "NVIDIA"; then
    echo "[*] Installing Nvidia video driver"
    sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings
elif lspci -v | grep "VGA" | grep -q "AMD"; then
    echo "[*] Installing AMD video driver"
    sudo pacman -S --needed --noconfirm xf86-video-amdgpu
elif lspci -v | grep "VGA" | grep -q "Intel"; then
    echo "[*] Installing Intel video driver"
    sudo pacman -S --needed --noconfirm xf86-video-intel
else
    echo "[*] ERROR: Could not find the correct video driver to install"
    exit 1
fi
