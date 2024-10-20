#!/bin/bash

set -e

source "${ENGI_DIR}/options.env"

echo "[*] Setting defualt keyboard layout for the console ($KEYBOARD_LAYOUT)"
if grep -q "^KEYMAP" < /etc/vconsole.conf; then
    sudo sed -i "s/^KEYMAP=.*/KEYMAP=$KEYBOARD_LAYOUT"
else
    sudo /bin/bash -c 'echo "KEYMAP=${KEYBOARD_LAYOUT}" >> /etc/vconsole.conf'
fi
