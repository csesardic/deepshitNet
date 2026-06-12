#!/bin/bash
# build.sh - Main build script for DeepShitNet (Steve 0.1a)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ARCH="${ARCH:-aarch64}"
VERSION="Steve 0.1a"

source "${SCRIPT_DIR}/common.sh"
load_config "$ARCH"

check_root

log "Building DeepShitNet $VERSION for $ARCH"

WORK_DIR="/tmp/deepshit-build-${ARCH}"
ROOTFS_DIR="${WORK_DIR}/rootfs"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR" "$ROOTFS_DIR"

log "Running debootstrap for $DEBARCH..."

debootstrap \
    --arch="$DEBARCH" \
    --variant="$VARIANT" \
    --include="${BASE_PACKAGES}" \
    "$SUITE" \
    "$ROOTFS_DIR" \
    "$PARROT_MIRROR" || error "debootstrap failed"

log "Configuring system..."

# Set hostname
echo "deepshit-steve" > "$ROOTFS_DIR/etc/hostname"

# Basic os-release
cat > "$ROOTFS_DIR/etc/os-release" << EOF
PRETTY_NAME="DeepShit OS $VERSION"
NAME="DeepShit OS"
ID=deepshit
ID_LIKE=debian
VERSION="$VERSION"
VERSION_CODENAME=steve
HOME_URL="https://github.com/csesardic/deepshitNet"
EOF

log "Build completed successfully for $ARCH"
log "Rootfs location: $ROOTFS_DIR"
