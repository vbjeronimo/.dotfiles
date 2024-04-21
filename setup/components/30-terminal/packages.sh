#!/bin/bash

set -e

echo "[*] Running script to install terminal packages"

sudo apt-get install -y --no-upgrade \
    bat \
    exa
