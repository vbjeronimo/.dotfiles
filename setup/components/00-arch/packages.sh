#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Updating and upgrading the system"
sudo pacman -Syu

echo "[*] Installing man pages"
pkg_install
    man-db \
    man-pages \
    texinfo

echo "[*] Installing system essentials"
pkg_install
    base-devel \
    curl \
    git \
    openssh \
    sed \
    unzip \
    wget \
    zip
