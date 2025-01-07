#!/bin/bash

set -e

echo "[*] Installing terminal essentials"
sudo pacman -S --needed --noconfirm \
    bat \
    exa \
    fzf

echo "[*] Installing Lazygit"
sudo pacman -S --needed --noconfirm \
    lazygit
