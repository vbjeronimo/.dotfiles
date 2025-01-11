#!/bin/bash

set -e

HOME=""
if [[ -n "$SUDO_USER" ]]; then
    HOME="/home/${SUDO_USER}"
else
    HOME="/home/${USER}"
fi

CONFIGS_DIR="${HOME}/.config"
DOTFILES_DIR="$(git rev-parse --show-toplevel)"
DOTFILES_BACKUP_DIR="${HOME}/.config/backup"

STOW_TARGET="${STOW_TARGET:-$HOME}"

if ! command -v stow > /dev/null; then
    echo "[*] Installing stow"
    sudo pacman -S --needed --noconfirm stow
fi

##
# Stows arbitrary directories from the dotfiles dir into the config dir
#
# @arg configs_to_stow  The names of the dotfiles dirs to stow, separated
#                       by spaces (not a Bash array)
# @pre The configs dir and the dotfiles dirs to stow exist
# @post The dotfiles listed as arguments to this function have been
#       successfully stowed to the config dir, and any pre-existing
#       dotfiles at the destination have been backed up
##
lib_dotfiles_stow_config() {
    local configs_to_stow=("$@")

    if [[ ! -d "$CONFIGS_DIR" ]]; then
        echo "[*] Error: No config directory at '$CONFIGS_DIR'. Exiting..."
        exit 1
    fi

    if [[ ! -d "$DOTFILES_DIR" ]]; then
        echo "[*] Error: No dotfiles directory at '$DOTFILES_DIR'. Exiting..."
        exit 1
    fi

    echo "[*] Stowing dotfiles from $DOTFILES_DIR"

    mkdir -p "$DOTFILES_BACKUP_DIR"

    for dir_name in "${configs_to_stow[@]}"; do
        echo "  ==> Stowing $dir_name"

        local dot_dir="${DOTFILES_DIR}/${dir_name}"
        if [[ ! -d "$dot_dir" ]]; then
            echo "Error: No config dir '$dir_name' at dotfiles dir '$DOTFILES_DIR'. Exiting..."
            exit 1
        fi

        local backup_dir="${DOTFILES_BACKUP_DIR}/${dir_name}"
        mkdir -p "$backup_dir"

        local config_dir="${CONFIGS_DIR}/${dir_name}"
        if [[ -e "$config_dir" ]] && [[ ! -L "$config_dir" ]]; then
            echo "    --> config dir '$config_dir' exists and it's not a symlink"
            echo "    --> backing up '$config_dir' to '$backup_dir'"

            rm -r "$backup_dir" >& /dev/null || true
            mv "$config_dir" "$backup_dir"
        elif [[ -L "$config_dir" ]]; then
            echo "    --> config dir '$config_dir' is a symlink, removing it"
            rm "$config_dir"
        fi

        stow --dir="${DOTFILES_DIR}" --target="${STOW_TARGET}" "$dir_name"
    done
}
