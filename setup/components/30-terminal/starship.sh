#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing starship shell prompt"
pkg_install \
    starship

fish_drop_in_config="$HOME/.config/fish/conf.d/starship.fish"

echo "[*] Setting up shell config to use starship"
if [[ "$(basename "$SHELL")" == "fish" ]] && [[ ! -f "$fish_drop_in_config" ]]; then
    echo "  => Fish Shell detected!"

    echo "  => Writing starship '.fish' drop-in config"
    echo "starship init fish | source" > "$fish_drop_in_config"

    echo "  => Done!"
fi
