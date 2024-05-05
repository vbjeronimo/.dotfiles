#!/bin/bash

set -e

echo "[*] Running script to install desktop environment packages"

sudo apt install -y --no-upgrade \
    alacritty \
    dunst \
    i3
