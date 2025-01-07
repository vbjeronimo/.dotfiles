#!/bin/bash

set -e

GO_VERSION="1.22.3"

echo "[*] Setting up environment for Go development"
if ! command -vq go; then
    echo "[*] Downloading and installing Go"

    TEMP_TAR="$(mktemp)"
    wget -O "$TEMP_TAR" https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf "$TEMP_TAR"
    rm -f "$TEMP_TAR"

    # Just to make sure that the installation went well
    go version
fi
