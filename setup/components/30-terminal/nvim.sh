#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"

echo "[*] Running Neovim setup script"

if ! command -v nvim &> /dev/null; then
    echo "[*] Installing build dependencies"
    sudo apt-get install -y --no-upgrade \
        build-essential \
        cmake \
        curl \
        gettext \
        ninja-build \
        unzip

    if [[ ! -d /opt/neovim ]]; then
        echo "[*] Cloning Neovim into /opt/neovim (version $NEOVIM_VERSION)"
        sudo git clone https://github.com/neovim/neovim /opt/neovim
    fi

    echo "[*] Building Neovim from source"
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
sudo apt-get install -y --no-upgrade \
    fd-find \
    ripgrep
