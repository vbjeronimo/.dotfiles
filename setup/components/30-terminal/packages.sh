#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing terminal essentials"
pkg_install \
    bat \
    exa \
    fzf

echo "[*] Installing Lazygit"
pkg_install \
    lazygit

echo "[*] Installing ranger"
pkg_install \
    ranger \
    w3m
