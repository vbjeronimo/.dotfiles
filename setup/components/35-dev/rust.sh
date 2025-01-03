#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Setting up environment for Rust development"
pkg_install \
    rustup

echo "[*] Setting the default version of cargo"
rustup default stable
