#!/bin/bash

set -eu

echo "[*] Installing greetd"
sudo pacman -S --needed --noconfirm \
    greetd-tuigreet \
    greetd

echo "[*] Making sure 'greetd.service' is enabled"
sudo systemctl enable greetd.service

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

STOW_TARGET="/"
export STOW_TARGET
source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "greetd"
