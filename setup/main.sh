#!/bin/bash

set -e

BASE_DIR="/home/vitor/wip-dotfiles/setup/components"

DEFAULT_MOD="755"

if [[ "$#" -eq 0 ]]; then
    echo "usage: ..."
    exit 1
fi

command="$1"
shift

case "$command" in
    setup)
        echo "setup $@"
        ;;
    list)
        find "${BASE_DIR}" -type d -exec run-parts --test --regex '.*' {} \; \
            | tree --fromfile
        ;;
    enable)
        IFS=: read -r component target <<< "$1"
        IFS=, read -ra scripts <<< "$target"

        if [[ "${#scripts[@]}" -eq 0 ]]; then
            echo "Enabling all scripts in $component"
            chmod "$DEFAULT_MOD" "${BASE_DIR}"/*"${component}"/*.sh
        fi

        for script in "${scripts[@]}"; do
            echo "Enabling script '$script' in $component"
            chmod "$DEFAULT_MOD" "${BASE_DIR}"/*"${component}"/*${script}.sh
        done
        ;;
    disable)
        IFS=: read -r component target <<< "$1"
        IFS=, read -ra scripts <<< "$target"

        if [[ "${#scripts[@]}" -eq 0 ]]; then
            echo "Disabling all scripts in $component"
            chmod 644 "${BASE_DIR}"/*"${component}"/*.sh
        fi

        for script in "${scripts[@]}"; do
            echo "Disabling script '$script' in $component"
            chmod 644 "${BASE_DIR}"/*"${component}"/*${script}.sh
        done
        ;;
    new)
        echo "new $@"
        ;;
    edit)
        echo "edit $@"
        ;;
    delete)
        echo "delete $@"
        ;;
    show)
        echo "show $@"
        ;;
    *)
        echo "Error: unknown command: $command"
        exit 1
        ;;
esac
