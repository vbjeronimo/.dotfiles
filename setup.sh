#!/bin/bash

set -euo pipefail

setup_pacman() {
    echo "[*] Starting pacman setup..."

    sed -i 's/#Color/Color/' /etc/pacman.conf
    sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
    sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

    echo "[*] Pacman setup complete!"
}

setup_base_system() {
    echo "[*] Starting base system setup..."

    pacman -S --noconfirm --needed \
        base-devel \
        man-db \
        man-pages \
        texinfo

    if lscpu | grep "Vendor ID" | grep -q "AMD"; then
        echo "[**] Installing AMD microcode..."
        pacman -S --noconfirm --needed amd-ucode
    elif lscpu | grep "Vendor ID" | grep -q "Intel"; then
        echo "[**] Installing Intel microcode..."
        pacman -S --noconfirm --needed intel-ucode
    fi

    # TODO: check if there's anything else to setup the microcode

    echo "[*] Base system setup complete!"
}

setup_desktop_environment() {
    echo "[*] Starting desktop environment setup..."

    # TODO: add a check for the video driver based on the GPU being used
    pacman -S --noconfirm --needed \
        autorandr \
        feh \
        i3-wm \
        nvidia \
        xorg-server \
        xorg-xinit \
        xorg-xrandr

    echo "[*] Desktop environment setup complete!"
}

setup_shell() {
    local default_shell="bash"
    local shell_packages=(
        bat
        exa
        tmux
    )
    local fonts=(
        otf-commit-mono-nerd
    )

    echo "[*] Starting shell setup..."

    echo "[**] Installing packages..."
    pacman -S --noconfirm --needed \
        "$default_shell" \
        "${shell_packages[@]}" \
        "${fonts[@]}" \
        starship

    echo "[**] Changing default shell to $default_shell for user $SUDO_USER..."
    chsh -s $(which "$default_shell") "$SUDO_USER"

    echo "[**] Shell setup complete!"
}

setup_syncthing() {
    echo "[*] Starting syncthing setup..."

    sudo pacman -S --noconfirm --needed \
        syncthing

    echo "[**] Enabling and starting syncthing service..."
    sudo systemctl enable --now syncthing@"${SUDO_USER}.service"

    echo "[**] Syncthing setup complete!"
}

echo "[*] Enabling sshd.service..."
systemctl enable --now sshd.service

setup_pacman

setup_base_system

pacman -Syu --noconfirm

pacman -S --noconfirm --needed \
    alacritty \
    bat \
    firefox \
    git \
    neovim \
    obsidian \
    papirus-icon-theme \
    pass \
    rofi \
    stow \
    tmux \
    xclip

(cd /home/"$SUDO_USER"; \
    sudo -u "${SUDO_USER}" mkdir -p \
        documents \
        downloads \
        obsidian \
        pictures/screenshots \
        pictures/wallpapers \
        projects
)

setup_shell
setup_desktop_environment
setup_syncthing

# TODO: find a better way to setup the xbdkeymaps (it goes back to us after an update)
