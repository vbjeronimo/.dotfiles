#!/bin/bash

set -eu

NEOVIM_VERSION="v0.9.5"

echo "[*] Installing Neovim from source (version $NEOVIM_VERSION)"
if ! command -v nvim > /dev/null; then
    echo "[*] Installing build dependencies"
    sudo pacman -S --needed --noconfirm \
    	base-devel \
	cmake \
	curl \
	ninja \
	unzip

    if [[ ! -d /opt/neovim ]]; then
        echo "[*] Cloning neovim repo into /opt/neovim"
        sudo git clone https://github.com/neovim/neovim /opt/neovim
    fi

    echo "[*] Building Neovim"
    (
        sudo chown "$USER:$USER" -R /opt/neovim
        cd /opt/neovim
        git checkout "$NEOVIM_VERSION"
        make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
    )
else
    echo "[*] Neovim already installed. Nothing to do"
fi

echo "[*] Installing lazy dependencies"
sudo pacman -S --needed --noconfirm \
    lua \
    luarocks

echo "[*] Installing Telescope dependencies"
sudo pacman -S --needed --noconfirm \
    fd \
    ripgrep

lib_dir="$(cd $(dirname "$0") && cd ../../lib && pwd)"

source "${lib_dir}/dotfiles.sh"
lib_dotfiles_stow_config \
    "nvim"
