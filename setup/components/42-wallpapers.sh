#!/bin/bash

set -e

source "${ENGI_DIR}/options.env"

ACTIVE_WALLPAPER="${WALLPAPERS_DIR}/active"

echo "[*] Starting script to import wallpapers"

sudo apt install -y --no-upgrade feh

if [[ ! -d "$WALLPAPERS_SOURCE" ]]; then
    echo "[WARN] Could not find the wallpapers source dir '$WALLPAPERS_SOURCE'. Skipping wallpaper setup..."
    exit 0
fi

if [[ ! -d "$WALLPAPERS_DIR" ]]; then
    echo "Copying wallpapers dir from $WALLPAPERS_SOURCE to $WALLPAPERS_DIR"
    mkdir -p "$WALLPAPERS_DIR"
    cp -r "${WALLPAPERS_SOURCE}"/* "$WALLPAPERS_DIR"
fi

if [[ ! -e "$ACTIVE_WALLPAPER" ]]; then
    echo "[*] Setting random wallpaper"

    # Resolution of the primary monitor
    current_resolution="$(xrandr | grep primary | awk '{print $4}' | cut -d '+' -f 1)"

    wallpaper_paths=($(find "$WALLPAPERS_DIR" -name "*$current_resolution*"))
    if [[ "${#wallpaper_paths[@]}" -eq 0 ]]; then
        wallpaper_paths=($(find "$WALLPAPERS_DIR"))
    fi
    random_index="$((RANDOM % ${#wallpaper_paths[@]}))"
    chosen_wallpaper="${wallpaper_paths[$random_index]}"

    echo "Wallpaper paths:"
    for path in "${wallpaper_paths[@]}"; do
        echo "  - $path"
    done
    echo "Chosen wallpaper: $chosen_wallpaper"

    ln -s "$chosen_wallpaper" "$ACTIVE_WALLPAPER"
    feh --bg-fill "$ACTIVE_WALLPAPER"
fi
