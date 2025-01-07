#!/bin/bash

set -eu

echo "[*] Installing kitty (terminal emulator)"
sudo pacman -S --needed --noconfirm \
    kitty

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "kitty"
