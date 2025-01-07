#!/bin/bash

set -e

echo "[*] Setting up environment for Rust development"
sudo pacman -S --needed --noconfirm \
    rustup

echo "[*] Setting the default version of cargo"
rustup default stable
