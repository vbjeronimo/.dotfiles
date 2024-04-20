#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"

echo "[*] Running Neovim setup script"

if command -v nvim &> /dev/null; then
    echo "[*] Nothing to do"
    exit 0
fi

echo "[*] Installing Neovim from source"

echo "[*] Installing build dependencies"
sudo apt-get install -y --no-upgrade \
    build-essential \
    cmake \
    curl \
    gettext \
    ninja-build \
    unzip

echo "[*] Cloning and building Neovim (version $NEOVIM_VERSION)"
sudo git clone https://github.com/neovim/neovim /opt/neovim
(
    cd /opt/neovim
    git checkout "$NEOVIM_VERSION"
    sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make installcd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
)

echo "[*] Installing Telescope dependencies"
sudo apt-get install -y --no-upgrade \
    fd-find \
    ripgrep
