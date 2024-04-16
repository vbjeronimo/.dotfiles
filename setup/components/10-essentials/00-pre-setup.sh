#!/bin/bash

set -e

echo "[*] Updating apt cache"
sudo apt-get update

echo "[*] Updating all packages"
sudo apt-get upgrade -y
