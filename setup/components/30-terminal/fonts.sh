#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"

FONTS_DIR="${HOME}/.local/share/fonts"
mkdir -p "$FONTS_DIR"

install_nerd_font() {
    local font=$1

    mkdir "${FONTS_DIR}/${font}"
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz" \
        | tar xJ -C "${HOME}/.local/share/fonts/${font}"
}

echo "[*] Installing Nerd Fonts"
for font in "${NERD_FONTS[@]}"; do
    echo "[*] Checking if font $font is already installed..."

    if [[ -z "$(find "$FONTS_DIR" -name "$font")" ]]; then
        echo "[*] Installing $font Nerd Font"
        install_nerd_font "$font"
    elif [[ -z "$(find ${HOME}/.local/share/fonts/${font} -mindepth 1)" ]]; then
        echo "[*] Directory for $font exists but it's empty. Deleting dir and installing font"
        rm -r "${FONTS_DIR}/${font}"
        install_nerd_font "$font"
    else
        echo "[*] Font ${font} Nerd Font is already installed. Skipping..."
    fi
done
