# aarch64.sh - Configuration for Raspberry Pi 5 (aarch64)

ARCH="aarch64"
DEBARCH="arm64"
QEMU_ARCH="aarch64"

# Parrot OS repositories
PARROT_MIRROR="http://deb.parrotsec.org/parrot"
PARROT_KEY="https://deb.parrotsec.org/parrot/misc/parrotsec.gpg"

# Target settings
SUITE="lts"
VARIANT="minbase"

# Packages to include
BASE_PACKAGES="parrot-core parrot-tools parrot-interface parrot-desktop parrot-network"
BOOT_PACKAGES="linux-image-arm64 initramfs-tools flash-kernel"

# Image layout
IMAGE_NAME="deepshit-steve-0.1a-aarch64.img"
IMAGE_SIZE_MB="4096"
BOOT_PARTITION_SIZE_MB="256"
BOOT_FILESYSTEM_LABEL="DEEPSHIT_BOOT"
ROOT_FILESYSTEM_LABEL="DEEPSHIT_ROOT"

log "Configured for Raspberry Pi 5 (aarch64)"
