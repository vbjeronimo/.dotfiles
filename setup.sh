#!/bin/bash

set -euo pipefail

DOTFILES_REPO=https://github.com/vbjeronimo/.dotfiles.git

setup_pacman() {
    echo "[*] Starting pacman setup..."

    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
    sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

    echo "[*] Pacman setup complete!"
}

setup_base_system() {
    echo "[*] Starting base system setup..."

    sudo pacman -S --noconfirm --needed \
        base-devel \
        man-db \
        man-pages \
        texinfo

    if lscpu | grep "Vendor ID" | grep -q "AMD"; then
        echo "[**] Installing AMD microcode..."
        sudo pacman -S --noconfirm --needed amd-ucode
    elif lscpu | grep "Vendor ID" | grep -q "Intel"; then
        echo "[**] Installing Intel microcode..."
        sudo pacman -S --noconfirm --needed intel-ucode
    fi

    echo "[*] Base system setup complete!"
}

setup_desktop_environment() {
    echo "[*] Starting desktop environment setup..."

    # TODO: add a check for the video driver based on the GPU being used
    sudo pacman -S --noconfirm --needed \
        autorandr \
        feh \
        firefox \
        i3-wm \
        nvidia \
        obsidian \
        papirus-icon-theme \
        polybar \
        rofi \
        xorg-server \
        xorg-xinit \
        xorg-xrandr

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

setup_dotfiles() {
    local dotfiles_dir="$HOME"/.dotfiles

    echo "[*] Setting up dotfiles dir..."

    if ! [[ -d "$dotfiles_dir" ]];then
        echo "[**] Dotfiles dir not found. Cloning it..."

        git clone "$DOTFILES_REPO" "$dotfiles_dir"
        cd "$dotfiles_dir" || exit

        # this is a clever trick to force stow to create the symlinks that we need here
        # and then restoring the files to their original content once the symlinks exist
        stow --adopt */
        git restore .
    else
        echo "[**] Dotfiles already cloned. Restowing..."
        cd "$dotfiles_dir" || exit
        stow --restow */
    fi

    cd - > /dev/null || exit

    echo "[*] Dotfiles dir setup complete!"
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

echo "[*] Enabling sshd.service..."
sudo systemctl enable --now sshd.service

setup_pacman

sudo pacman -Syu --noconfirm

setup_base_system
setup_shell
setup_dev_environment
setup_desktop_environment
setup_syncthing
setup_dotfiles
create_home_dirs

# TODO: find a better way to setup the xbdkeymaps (it goes back to us after an update)
