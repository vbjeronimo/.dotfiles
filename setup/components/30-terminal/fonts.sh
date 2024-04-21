#!/bin/bash

set -e

source "${ENGI_DIR}/options.env"

echo "[*] Running fonts setup script"

mkdir -p "${HOME}/.local/share/fonts"
for font in "${NERD_FONTS[@]}"; do
    echo "[*] Checking if font ${font} is already installed..."

    if ! ls "${HOME}/.local/share/fonts" | grep -qw "$font"; then
        echo "[*] Installing ${font} Nerd Font"

        mkdir "${HOME}/.local/share/fonts/${font}"
        curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz" \
            | tar xJ -C "${HOME}/.local/share/fonts/${font}"
    else
        echo "[*] Font ${font} Nerd Font is already installed. Skipping..."
    fi
done
