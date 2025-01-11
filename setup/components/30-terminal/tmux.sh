#!/bin/bash

set -e

TMUX_VERSION="3.4"

echo "[*] Installing tmux (version ${TMUX_VERSION})"
if ! command -v tmux > /dev/null; then
    sudo pacman -S --needed --noconfirm tmux
    echo "[*] Tmux installed!"
else
    echo "[*] Tmux is already installed. Nothing to do"
fi

if [[ ! -e ~/.tmux/plugins/tpm ]]; then
    echo "[*] Installing Tmux Package Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "[*] TPM is already installed. Nothing to do"
fi

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "tmux"
