#!/bin/bash

set -e

# Helper function that only installs missing packages, without asking
# for confirmation.
#
# @arg List of packages to install
pkg_install() {
    local args=($@)

    sudo pacman -S --noconfirm --needed $@
}
