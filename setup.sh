#!/bin/bash

set -euo pipefail

setup_desktop_environment() {
    echo "[*] Starting desktop environment setup..."

    # TODO: add a check for the video driver based on the GPU being used
    sudo pacman -S --noconfirm --needed \
        autorandr \
        feh \
        firefox \
        i3-wm \
        obsidian \
        papirus-icon-theme \
        rofi \

    echo "[*] Desktop environment setup complete!"
}

setup_shell() {
    local default_shell="bash"
    local shell_packages=(
        alacritty
        bat
        exa
        git
        pass
        starship
        stow
        tmux
        xclip
    )
    local fonts=(
        otf-commit-mono-nerd
    )

    echo "[*] Starting shell setup..."

    echo "[**] Installing packages..."
    sudo pacman -S --noconfirm --needed \
        "$default_shell" \
        "${shell_packages[@]}" \
        "${fonts[@]}"

    if [[ "$SHELL" != "$(which "$default_shell")" ]]; then
        echo "[**] Changing default shell to $default_shell for user $USER..."
        sudo chsh -s "$(which "$default_shell")" "$USER"
    fi

    echo "[**] Shell setup complete!"
}

setup_dev_environment() {
    echo "[*] Setting up dev environment..."

    sudo pacman -S --noconfirm --needed \
        fd \
        go \
        lazygit \
        neovim \
        npm \
        ripgrep

    echo "[*] Dev environment setup complete!"
}

setup_syncthing() {
    echo "[*] Starting syncthing setup..."

    sudo pacman -S --noconfirm --needed syncthing

    echo "[**] Enabling and starting syncthing service..."
    sudo systemctl enable --now syncthing@"${USER}.service"

    echo "[**] Syncthing setup complete!"
}

create_home_dirs() {
    echo "[*] Creating home directories..."

    cd ~ || exit

    mkdir -p \
        documents \
        downloads \
        pictures/screenshots \
        pictures/wallpapers \
        projects \
        second-brain \

    cd - > /dev/null || exit

    echo "[*] Home directories created!"
}

install_apps() {
    echo "[*] Installing apps..."

    yay -S --noconfirm --needed \
        discord \
        spotify

    echo "[*] Apps installed!"
}

echo "[*] Enabling sshd.service..."
sudo systemctl enable --now sshd.service

sudo pacman -Syu --noconfirm

setup_shell
setup_dev_environment
setup_desktop_environment
setup_syncthing
create_home_dirs
install_apps
