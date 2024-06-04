#!/bin/bash

set -e

source "${ENGI_DIR}/secret.env"

echo "[*] Starting script to install and setup applications"

if ! command -v syncthing &> /dev/null; then
    echo "[*] Installing and setting up syncthing"
    sudo apt-get install -y --no-upgrade \
        syncthing \
        syncthingtray

    systemctl --user enable --now syncthing.service
fi

if ! command -v pass &> /dev/null; then
    echo "[*] Installing and setting up pass"
    sudo apt-get install -y --no-upgrade \
        git \
        gnupg \
        pass

    echo "[*] Cloning the password store repo to $PASSWORD_STORE_DIR"
    git clone "$PASSWORD_STORE_URL" "$PASSWORD_STORE_DIR"

    echo "[*] Importing GPG keys from $GPG_KEYS_DIR"
    gpg --import --batch --yes "$GPG_KEYS_DIR"/public.gpg
    gpg --import --batch --yes --passphrase "$GPG_KEY_PASSWORD" "$GPG_KEYS_DIR"/private.gpg
    gpg --import-ownertrust --batch --yes "$GPG_KEYS_DIR"/trust.gpg
fi

if ! command -v spotify &> /dev/null; then
    echo "[*] Installing and setting up Spotify"
    sudo mkdir -p /etc/apt/keyrings
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update && sudo apt install spotify-client

    # The spotify package is currently broken and installs files owned by uid 1000, fix it
    dpkg -L spotify-client | sudo xargs chown --no-dereference root:root
fi
