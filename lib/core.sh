#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/utils.sh"

detect_pm() {
    command -v apt >/dev/null && echo "apt" && return
    command -v dnf >/dev/null && echo "dnf" && return
    command -v yum >/dev/null && echo "yum" && return
    command -v pacman >/dev/null && echo "pacman" && return

    log_json "error" "No package manager found"
    exit 1
}

main() {
    parse_args "$@"
    require_root

    PM=$(detect_pm)
    log_json "info" "Using package manager: $PM"

    source "$(dirname "$0")/pm_${PM}.sh"
    run_updates
}

