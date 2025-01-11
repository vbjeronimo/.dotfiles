#!/bin/bash

set -eu

user=${SUDO_USER:-$USER}

echo "[*] Installing fish shell"
sudo pacman -S --needed --noconfirm \
    fish

user_shell="$(grep -- "^${user}:" /etc/passwd | rev | cut -d ':' -f 1 | rev)"

echo "[*] Detected '$user_shell' as the default shell for user '$user'"
if [[ "$user_shell" != "/usr/bin/fish" ]]; then
    echo "[*] Setting up fish as the default shell for user '$user'"
    sudo chsh -s "$(which fish)" "$user"
else
    echo "[*] Fish is already set as the default shell for user '$user'. Skipping shell setup"
fi

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "fish"
