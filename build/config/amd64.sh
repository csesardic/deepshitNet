# amd64.sh - Placeholder configuration for x86_64 PCs

ARCH="amd64"
DEBARCH="amd64"
QEMU_ARCH="x86_64"

# Parrot OS repositories
PARROT_MIRROR="http://deb.parrotsec.org/parrot"
PARROT_KEY="https://deb.parrotsec.org/parrot/misc/parrotsec.gpg"

SUITE="lts"
VARIANT="minbase"

BASE_PACKAGES="parrot-core parrot-tools"

log "Configured for amd64 (placeholder - not fully implemented yet)"
