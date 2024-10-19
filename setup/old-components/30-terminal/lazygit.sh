#!/bin/bash

set -e

echo "[*] Starting script to install lazygit"

if ! command -v lazygit &> /dev/null; then
    lazygit_version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    sudo curl -Lo /opt/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
    sudo tar xf /opt/lazygit.tar.gz -C /opt
    sudo install /opt/lazygit /usr/local/bin
    sudo rm /opt/lazygit.tar.gz
else
    echo "[*] Lazygit is already installed. Nothing to do"
fi
