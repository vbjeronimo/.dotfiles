#!/bin/bash

set -e

TMP_DIR="/tmp/setup"
mkdir -p "$TMP_DIR"

echo "[*] Setting up system essentials"
sudo apt-get install -y --no-upgrade \
    curl \
    ssh

echo "[*] Setting up desktop environment"
sudo apt-get install -y --no-upgrade \
    alacritty \
    rofi \
    sway \
    waybar

echo "[*] Setting up shell environment"
sudo apt-get install -y --no-upgrade \
    exa \
    tmux \

echo "[*] Installing fonts (at $TMP_DIR/fonts)"
mkdir -p ~/.local/share/fonts/FiraMono
mkdir -p "$TMP_DIR"/fonts
curl -o "${TMP_DIR}/fonts/FiraMono.tar.xz" -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.tar.xz
tar xf "${TMP_DIR}/fonts/FiraMono.tar.xz" -C ~/.local/share/fonts/FiraMono
