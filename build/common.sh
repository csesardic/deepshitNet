#!/bin/bash
# common.sh - Shared functions for DeepShitNet build system

set -e

log() {
    echo "[$(date +%H:%M:%S)] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

check_root() {
    if [ "$EUID" -ne 0 ]; then
        error "This script must be run as root"
    fi
}

# Load architecture config
load_config() {
    local arch="$1"
    local config_file="config/${arch}.sh"

    if [ ! -f "$config_file" ]; then
        error "Config file not found: $config_file"
    fi

    source "$config_file"
    log "Loaded config for architecture: $arch"
}
