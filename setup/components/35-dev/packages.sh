#!/bin/bash

set -e

echo "[*] Starting script to install dev packages"

sudo pacman -S --needed --noconfirm \
    npm
