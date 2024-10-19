#!/bin/bash

set -e

echo "[*] Running script to install terminal packages"

sudo apt-get install -y --no-upgrade \
    bat \
    exa \
    fzf

# Install packages for ranger
sudo apt-get install -y --no-upgrade \
    ranger \
    w3m
