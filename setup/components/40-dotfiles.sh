#!/bin/bash

set -eu

source "${ENGI_DIR}/options.env"

STOW_TARGET="$HOME"

echo "[*] Starting script to setup dotfiles"

if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "[*] Skipping dotfiles setup since there's no .dotfiles dir at $DOTFILES_DIR"
    exit 1
fi

echo "[*] Stowing dotfiles from $DOTFILES_DIR"

mkdir -p "$DOTFILES_BACKUP_DIR"

for dir_name in "${CONFIGS_TO_STOW[@]}"; do
    echo "  ==> Stowing $dir_name"

    config_dir="${DOTFILES_DIR}/${dir_name}"

    files_to_backup=($(find "${config_dir}" -mindepth 1 -maxdepth 1 -type f))
    dirs_to_backup=($(find "${config_dir}" -mindepth 1 -type d -name "*${dir_name}"))

    paths_to_backup=()
    for file in "${files_to_backup[@]}"; do
        paths_to_backup+=(${file/${config_dir}\//${STOW_TARGET}\/})
    done
    for dir in "${dirs_to_backup[@]}"; do
        paths_to_backup+=(${dir/${config_dir}\//${STOW_TARGET}\/})
    done

    backup_dir="${DOTFILES_BACKUP_DIR}/${dir_name}"
    for path in "${paths_to_backup[@]}"; do
        if [[ -e "$path" ]] && [[ ! -h "$path" ]]; then
            backup_path=${path/${STOW_TARGET}\//${backup_dir}\/}
            mkdir -p "$backup_path"
            echo "    --> path '$path' exists and it's not a symlink"
            echo "    --> backing up '$path' to '$backup_path'"
            mv "$path" "$backup_path"
        elif [[ -h "$path" ]]; then
            echo "    --> path '$path' is a symlink, removing it"
            rm "$path"
        fi
    done

    stow --dir="${DOTFILES_DIR}" --target="${STOW_TARGET}" "$dir_name"
done
