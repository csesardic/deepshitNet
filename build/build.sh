#!/bin/bash
# build.sh - DeepShitNet Build System (Steve 0.1a)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH="${ARCH:-aarch64}"
VERSION="Steve 0.1a"

source "${SCRIPT_DIR}/common.sh"
load_config "$ARCH"

check_root
require_command debootstrap
require_command dpkg-buildpackage
require_command dpkg-query
require_command apt-get
require_command chroot
require_command truncate
require_command sfdisk
require_command losetup
require_command partprobe
require_command mkfs.vfat
require_command mkfs.ext4
require_command mount
require_command umount
require_command mountpoint
require_command sync
assert_native_arch

log "Building DeepShitNet $VERSION for $ARCH"

WORK_DIR="/tmp/deepshit-build-${ARCH}"
ROOTFS_DIR="${WORK_DIR}/rootfs"
DEBS_DIR="${WORK_DIR}/debs"
IMAGE_DIR="${WORK_DIR}/image"
IMAGE_PATH="${IMAGE_DIR}/${IMAGE_NAME}"
ROOT_MNT="${WORK_DIR}/mnt-root"
LOOP_DEVICE=""
TARGET_BOOT_DIR=""

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR" "$ROOTFS_DIR" "$DEBS_DIR" "$IMAGE_DIR" "$ROOT_MNT"

cleanup_image_mounts() {
    set +e

    if [ -n "$TARGET_BOOT_DIR" ] && mountpoint -q "${ROOT_MNT}${TARGET_BOOT_DIR}" 2>/dev/null; then
        umount "${ROOT_MNT}${TARGET_BOOT_DIR}"
    fi

    if mountpoint -q "$ROOT_MNT" 2>/dev/null; then
        umount "$ROOT_MNT"
    fi

    if [ -n "$LOOP_DEVICE" ]; then
        losetup -d "$LOOP_DEVICE"
    fi
}

trap cleanup_image_mounts EXIT

# Step 1: Run debootstrap
log "Running debootstrap..."
debootstrap --arch="$DEBARCH" --variant="$VARIANT" "$SUITE" "$ROOTFS_DIR" "$PARROT_MIRROR" || error "debootstrap failed"

# Step 2: Build custom packages
log "Building custom DeepShit packages..."
for pkgdir in "${SCRIPT_DIR}/../packages/"*/ ; do
    pkgname=$(basename "$pkgdir")
    if [ -f "$pkgdir/debian/control" ]; then
        log "Building package: $pkgname"
        (
            cd "$pkgdir"
            dpkg-buildpackage -us -uc -b
        ) || error "failed to build package: $pkgname"

        find "${SCRIPT_DIR}/../packages" -maxdepth 1 -type f -name "${pkgname}_*.deb" -exec mv -f {} "$DEBS_DIR/" \;
    fi
done

# Step 3: Install custom packages into rootfs
log "Installing custom packages into rootfs..."
mkdir -p "$ROOTFS_DIR/tmp"

deb_count=0
for deb in "$DEBS_DIR"/*.deb; do
    if [ -f "$deb" ]; then
        cp "$deb" "$ROOTFS_DIR/tmp/"
        deb_count=$((deb_count + 1))
    fi
done

if [ "$deb_count" -eq 0 ]; then
    error "No built .deb packages found in $DEBS_DIR"
fi

chroot "$ROOTFS_DIR" /bin/bash -c '
    set -e
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y '"$BASE_PACKAGES"'
    apt-get install -y '"$BOOT_PACKAGES"'
    for pkg in '"$FIRMWARE_PACKAGES"'; do
        if apt-cache show "$pkg" >/dev/null 2>&1; then
            apt-get install -y "$pkg"
        else
            echo "Firmware package unavailable in configured repositories: $pkg" >&2
        fi
    done
    apt-get install -y /tmp/*.deb
'

log "Validating installed package set..."
for pkg in deepshit-branding deepshit-steve deepshit-network deepshit-config deepshit-boot deepshit-base; do
    chroot "$ROOTFS_DIR" dpkg-query -W -f='"'"'${Status}'"'"' "$pkg" | grep -q "install ok installed" \
        || error "package validation failed for $pkg"
done

for pkg in $BOOT_PACKAGES; do
    chroot "$ROOTFS_DIR" dpkg-query -W -f='"'"'${Status}'"'"' "$pkg" | grep -q "install ok installed" \
        || error "boot package validation failed for $pkg"
done

rm -f "$ROOTFS_DIR"/tmp/*.deb

# Step 4: Prepare rootfs for image generation
TARGET_BOOT_DIR="$(detect_boot_dir "$ROOTFS_DIR")"
BOOT_SOURCE_DIR="${ROOTFS_DIR}${TARGET_BOOT_DIR}"

if [ -n "${FIRMWARE_OVERLAY_DIR:-}" ] && dir_has_nonhidden_files "$FIRMWARE_OVERLAY_DIR"; then
    log "Applying Raspberry Pi firmware overlay from $FIRMWARE_OVERLAY_DIR..."
    cp -a "${FIRMWARE_OVERLAY_DIR}/." "$BOOT_SOURCE_DIR/"
fi

if ! find "$BOOT_SOURCE_DIR" -maxdepth 1 -type f \( -name '*.elf' -o -name '*.dat' -o -name '*.dtb' \) | grep -q .; then
    error "Firmware validation failed: no Raspberry Pi firmware assets found in ${BOOT_SOURCE_DIR}"
fi

if ! find "$BOOT_SOURCE_DIR" -maxdepth 1 -type f ! -name 'config.txt' ! -name 'cmdline.txt' | grep -q .; then
    error "Boot asset validation failed: no firmware or kernel files found in ${BOOT_SOURCE_DIR}"
fi

# Step 5: Create disk image
log "Creating disk image at $IMAGE_PATH..."
truncate -s "${IMAGE_SIZE_MB}M" "$IMAGE_PATH"

BOOT_SIZE_SECTORS=$((BOOT_PARTITION_SIZE_MB * 2048))
ROOT_START_SECTOR=$((2048 + BOOT_SIZE_SECTORS))

sfdisk "$IMAGE_PATH" <<EOF
label: dos
unit: sectors

1 : start=2048, size=${BOOT_SIZE_SECTORS}, type=c, bootable
2 : start=${ROOT_START_SECTOR}, type=83
EOF

LOOP_DEVICE="$(losetup --find --show --partscan "$IMAGE_PATH")"
partprobe "$LOOP_DEVICE"

mkfs.vfat -F 32 -n "$BOOT_FILESYSTEM_LABEL" "${LOOP_DEVICE}p1"
mkfs.ext4 -F -L "$ROOT_FILESYSTEM_LABEL" "${LOOP_DEVICE}p2"

mount "${LOOP_DEVICE}p2" "$ROOT_MNT"
cp -a "${ROOTFS_DIR}/." "$ROOT_MNT/"

mkdir -p "${ROOT_MNT}${TARGET_BOOT_DIR}"
mount "${LOOP_DEVICE}p1" "${ROOT_MNT}${TARGET_BOOT_DIR}"
cp -a "${BOOT_SOURCE_DIR}/." "${ROOT_MNT}${TARGET_BOOT_DIR}/"
sync

cleanup_image_mounts
trap - EXIT

log "Build completed for $ARCH"
log "Rootfs: $ROOTFS_DIR"
log "Rootfs package installation validated."
log "Disk image: $IMAGE_PATH"
