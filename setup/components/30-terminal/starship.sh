#!/bin/bash

set -eu

echo "[*] Installing starship shell prompt"
sudo pacman -S --needed --noconfirm \
    starship

user=${SUDO_USER:-$USER}
HOME="/home/${user}"

fish_drop_in_config="$HOME/.config/fish/conf.d/starship.fish"
user_shell="$(grep -- "^${user}:" /etc/passwd | rev | cut -d ':' -f 1 | rev)"

echo "[*] Setting up shell config to use starship"
if [[ "$user_shell" =~ "fish" ]] && [[ ! -f "$fish_drop_in_config" ]]; then
    echo "  => Fish Shell detected!"

    echo "  => Writing starship '.fish' drop-in config"

    mkdir -p "$(dirname "$fish_drop_in_config")"
    echo "starship init fish | source" > "$fish_drop_in_config"

    echo "  => Done!"
else
    echo "[*] Nothing to do"
fi
