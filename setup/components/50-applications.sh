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
