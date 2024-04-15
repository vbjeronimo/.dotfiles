#!/bin/bash

set -e

SETUP_DIR="$(readlink -f "$(dirname "$0")")"

TEST_ARG=""

for opt in "$@"; do
    case "$opt" in
        -t | --test)
            TEST_ARG="--test"
            ;;
    esac
done

echo "[*] Starting main setup script"
run-parts \
    --exit-on-error \
    --regex '.*' \
    "${SETUP_DIR}/components"
