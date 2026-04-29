#!/usr/bin/env bash
set -euo pipefail

# LIB_DIR doit être fourni par l'entrypoint (sysupdate)
# fallback pour dev si non défini
if [[ -z "${LIB_DIR:-}" ]]; then
    LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Load utils
source "$LIB_DIR/utils.sh"

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

    # Load package manager handler
    source "$LIB_DIR/pm_${PM}.sh"

    run_updates
}