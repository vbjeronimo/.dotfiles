#!/bin/bash

set -e

ENGI_DIR=${ENGI_DIR:-$(dirname $0)}
BASE_DIR="${ENGI_DIR}/components"

if [[ "$#" -eq 0 ]]; then
    echo "usage: ..."
    exit 1
fi

command="$1"
shift

case "$command" in
    setup)
        if [[ "$#" -eq 0 ]]; then
            echo "Running all component scripts"
            find "${BASE_DIR}" -type d -exec run-parts --regex '.*' {} \;
        else
            for arg in "$@"; do
                IFS=: read -r component target <<< "$arg"
                IFS=, read -ra scripts <<< "$target"

                if [[ "${#scripts[@]}" -eq 0 ]]; then
                    echo "Running all scripts for $component"
                    if find "$BASE_DIR" -name "$component" -type f; then
                        bash -c "${BASE_DIR}"/*"${component}.sh"
                    else
                        run-parts --exit-on-error --regex '.*' "${BASE_DIR}"/*"${component}"
                    fi
                else
                    echo "Running $component:$target"
                    for script in "${scripts[@]}"; do
                        bash -c "${BASE_DIR}"/*"${component}/"/*"${script}.sh"
                    done
                fi

            done
        fi
        ;;
    list)
        if [[ "$#" -eq 0 ]]; then
            find "${BASE_DIR}" -type d -exec run-parts --test --regex '.*' {} \; | tree -a --fromfile
        else
            find "${BASE_DIR}"/*"$1" -type d -exec run-parts --test --regex '.*' {} \; | tree -a --fromfile
        fi
        ;;
    enable)
        IFS=: read -r component target <<< "$1"
        IFS=, read -ra scripts <<< "$target"

        if [[ "${#scripts[@]}" -eq 0 ]]; then
            echo "Enabling all scripts in $component"
            if find "$BASE_DIR" -name "$component" -type f; then
                chmod u+x "${BASE_DIR}"/*"${component}.sh"
            else
                chmod u+x "${BASE_DIR}"/*"${component}"/*.sh
            fi
        fi

        for script in "${scripts[@]}"; do
            echo "Enabling script '$script' in $component"
            chmod u+x "${BASE_DIR}"/*"${component}"/*${script}.sh
        done
        ;;
    disable)
        IFS=: read -r component target <<< "$1"
        IFS=, read -ra scripts <<< "$target"

        if [[ "${#scripts[@]}" -eq 0 ]]; then
            echo "Disabling all scripts in $component"
            if find "$BASE_DIR" -name "$component" -type f; then
                chmod a-x "${BASE_DIR}"/*"${component}.sh"
            else
                chmod a-x "${BASE_DIR}"/*"${component}"/*.sh
            fi
        fi

        for script in "${scripts[@]}"; do
            echo "Disabling script '$script' in $component"
            chmod a-x "${BASE_DIR}"/*"${component}"/*${script}.sh
        done
        ;;
    show)
        IFS=: read -r component target <<< "$1"
        IFS=, read -ra scripts <<< "$target"

        cat "${BASE_DIR}"/*"${component}"/*${script}.sh
        ;;
    *)
        echo "Error: unknown command: $command"
        exit 1
        ;;
esac
