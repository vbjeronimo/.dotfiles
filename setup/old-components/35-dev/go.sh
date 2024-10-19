#!/bin/bash

set -e

source "${ENGI_DIR}/options.env"

echo "[*] Setting up environment for Go development"

if ! command -v go; then
    echo "[*] Downloading and installing Go"

    TEMP_TAR="$(mktemp)"
    wget -O "$TEMP_TAR" https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf "$TEMP_TAR"
    rm -f "$TEMP_TAR"

    # Just to make sure that the installation went well
    go version
fi
