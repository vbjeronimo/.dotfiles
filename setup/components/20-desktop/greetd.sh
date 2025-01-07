#!/bin/bash

set -eu

echo "[*] Installing greetd"
sudo pacman -S --needed --noconfirm
    greetd-tuigreet \
    greetd

echo "[*] Making sure 'greetd.service' is enabled"
sudo systemctl enable greetd.service
