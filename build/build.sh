#!/bin/bash
# build.sh - DeepShitNet Build System (Steve 0.1a)

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
DEBS_DIR="${WORK_DIR}/debs"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR" "$ROOTFS_DIR" "$DEBS_DIR"

# Step 1: Run debootstrap
log "Running debootstrap..."
debootstrap --arch="$DEBARCH" --variant="$VARIANT" "$SUITE" "$ROOTFS_DIR" "$PARROT_MIRROR" || error "debootstrap failed"

# Step 2: Build custom packages
log "Building custom DeepShit packages..."
for pkgdir in "${SCRIPT_DIR}/../packages/"*/ ; do
    pkgname=$(basename "$pkgdir")
    if [ -d "$pkgdir/debian" ]; then
        log "Building package: $pkgname"
        (cd "$pkgdir" && dpkg-deb --build . "$DEBS_DIR/${pkgname}.deb") || true
    fi
done

# Step 3: Install custom packages into rootfs
log "Installing custom packages into rootfs..."
cp "$DEBS_DIR"/*.deb "$ROOTFS_DIR/tmp/" 2>/dev/null || true

chroot "$ROOTFS_DIR" /bin/bash -c '
    apt-get update || true
    dpkg -i /tmp/*.deb 2>/dev/null || true
    apt-get install -f -y || true
' || true

log "Build completed for $ARCH"
log "Rootfs: $ROOTFS_DIR"
log "Custom packages should now be installed."
