#!/bin/bash

set -e

echo "[*] Running script to install desktop environment packages"

sudo apt install -y --no-upgrade \
    alacritty \
    arandr \
    autorandr \
    brightnessctl \
    budgie-network-manager-applet \
    dunst \
    feh \
    flameshot \
    i3 \
    papirus-icon-theme \
    pavucontrol \
    playerctl \
    polybar \
    rofi

# Open VPN stuff
sudo apt install -y --no-upgrade \
    network-manager-openvpn \
    openvpn
