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

log "Configured for Raspberry Pi 5 (aarch64)"
