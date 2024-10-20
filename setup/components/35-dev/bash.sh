#!/bin/bash

set -eu

source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Setting up environment for bash development"
pkg_install \
    shellcheck
