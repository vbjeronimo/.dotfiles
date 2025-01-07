#!/bin/bash

set -eu

echo "[*] Installing starship shell prompt"
sudo pacman -S --needed --noconfirm \
    starship

fish_drop_in_config="$HOME/.config/fish/conf.d/starship.fish"

echo "[*] Setting up shell config to use starship"
if [[ "$(basename "$SHELL")" == "fish" ]] && [[ ! -f "$fish_drop_in_config" ]]; then
    echo "  => Fish Shell detected!"

    echo "  => Writing starship '.fish' drop-in config"
    echo "starship init fish | source" > "$fish_drop_in_config"

    echo "  => Done!"
fi
