#!/bin/bash

set -e

echo "[*] Installing ranger"
sudo pacman -S --needed --noconfirm \
    ranger \
    w3m

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "ranger"
