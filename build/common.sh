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

require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        error "Required command not found: $1"
    fi
}

assert_native_arch() {
    local host_arch
    host_arch="$(dpkg --print-architecture)"

    if [ "$host_arch" != "$DEBARCH" ]; then
        error "Cross-architecture builds are not configured yet (host: $host_arch, target: $DEBARCH)"
    fi
}

detect_boot_dir() {
    local rootfs_dir="$1"

    if [ -d "$rootfs_dir/boot/firmware" ]; then
        echo "/boot/firmware"
        return 0
    fi

    if [ -d "$rootfs_dir/boot" ]; then
        echo "/boot"
        return 0
    fi

    error "Unable to determine boot directory inside $rootfs_dir"
}

dir_has_nonhidden_files() {
    local target_dir="$1"

    if [ ! -d "$target_dir" ]; then
        return 1
    fi

    find "$target_dir" -mindepth 1 -type f ! -name 'README.md' ! -name '.gitkeep' | grep -q .
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
