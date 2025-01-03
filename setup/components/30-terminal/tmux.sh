#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"

echo "[*] Running tmux install script"

if ! command -v tmux &> /dev/null; then
    echo "[*] Installing tmux from source (version ${TMUX_VERSION})"

    echo "[*] Installing run dependencies"
    sudo apt-get install -y --no-upgrade \
        libevent \
        ncurses || true

    echo "[*] Installing build dependencies"
    sudo apt-get install -y --no-upgrade \
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
fi
