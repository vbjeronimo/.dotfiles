#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"
source "${ENGI_DIR}/lib/pkg.sh"

echo "[*] Installing tmux from source (version ${TMUX_VERSION})"
if ! command -vq tmux; then

    echo "[*] Installing runtime dependencies"
    pkg_install \
        libevent \
        ncurses

    echo "[*] Installing build dependencies"
    pkg_install \
        bison \
        build-essential \
        libevent-dev \
        ncurses-dev \
        pkg-config

    if [[ -d /opt/tmux-* ]]; then
        echo "[*] Removing previous tmux tarballs"
        sudo rm -rv /opt/tmux-*
    fi

    echo "[*] Pulling tarball and building tmux"
    curl -L "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz" \
        | sudo tar xz -C /opt

    (
        cd /opt/tmux-*
        sudo ./configure
        sudo make &> /dev/null && sudo make install &> /dev/null
    )

    echo "[*] Tmux installed!"
else
    echo "[*] Tmux is already installed. Nothing to do"
fi

if [[ ! -e ~/.tmux/plugins/tpm ]]; then
    echo "[*] Installing Tmux Package Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "[*] TPM is already installed. Nothing to do"
f
