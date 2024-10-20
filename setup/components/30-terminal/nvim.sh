#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"
source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing Neovim from source (verison $NEOVIM_VERSION)"
if ! command -vq nvim; then
    echo "[*] Installing build dependencies"
    pkg_install \
        build-essential \
        cmake \
        curl \
        gettext \
        ninja-build \
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
        cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
    )
else
    echo "[*] Neovim already installed. Nothing to do"
fi

echo "[*] Installing Telescope dependencies"
pkg_install \
    fd \
    ripgrep
