#!/bin/bash

set -eu

SUDO_USER=${SUDO_USER:-$USER}

echo "[*] Installing fish shell"
sudo pacman -S --needed --noconfirm \
    fish

if [[ "$(basename "$SHELL")" != "fish" ]]; then
    echo "[*] Setting up fish as the default shell for user '$SUDO_USER'"
    sudo chsh -s "$(which fish)" "$SUDO_USER"
else
    echo "[*] Fish is already set as the default shell for user '$SUDO_USER'. Skipping shell setup"
fi

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "fish"
