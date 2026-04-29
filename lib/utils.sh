#!/usr/bin/env bash

LOG_FILE="/var/log/sysupdate.log"
JSON_LOG="/var/log/sysupdate.json"

parse_args() {
    VERBOSE=false
    DRY_RUN=false
    CHECK_MODE=false

    for arg in "$@"; do
        case $arg in
            --verbose) VERBOSE=true ;;
            --dry-run) DRY_RUN=true ;;
            --check) CHECK_MODE=true ;;
        esac
    done
}

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Run with sudo"
        exit 1
    fi
}

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

log_json() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date -Iseconds)

    echo "{\"time\":\"$timestamp\",\"level\":\"$level\",\"message\":\"$message\"}" \
        | tee -a "$JSON_LOG" >/dev/null
}


run_cmd() {
    log "▶ $*"
    log_json "info" "$*"

    if [ "$DRY_RUN" = true ]; then
        log "⚠️ DRY RUN"
        log_json "warn" "Skipped command"
        return 0
    fi

    if [ "$VERBOSE" = true ]; then
        # Affiche ET log
        if "$@" 2>&1 | tee -a "$LOG_FILE"; then
            log "✅ OK"
            log_json "success" "$*"
        else
            log "❌ FAILED"
            log_json "error" "$*"
            exit 1
        fi
    else
        # Log seulement + feedback minimal
        if "$@" >> "$LOG_FILE" 2>&1; then
            echo "✔ Done"
            log_json "success" "$*"
        else
            echo "✖ Failed"
            log_json "error" "$*"
            exit 1
        fi
    fi
}

