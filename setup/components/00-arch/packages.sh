#!/bin/bash

set -eu

echo "[*] Updating and upgrading the system"
sudo pacman -Syu --noconfirm

echo "[*] Installing man pages"
sudo pacman -S --needed --noconfirm \
    man-db \
    man-pages \
    texinfo

echo "[*] Installing system essentials"
sudo pacman -S --needed --noconfirm \
    base-devel \
    curl \
    git \
    openssh \
    sed \
    unzip \
    wget \
    zip
