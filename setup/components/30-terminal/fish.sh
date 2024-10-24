#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

non_root_user=$USER

echo "[*] Installing the fish shell"
pkg_install \
    fish

if [[ "$(basename "$SHELL")" != "fish" ]]; then
    echo "[*] Setting up fish as the default shell"
    sudo chsh -s $(which fish) $non_root_user
else
    echo "[*] Fish is already set as the default shell. Skipping shell setup"
fi
