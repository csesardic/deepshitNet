# DeepShitNet Build System

This directory contains the build system for **DeepShit OS** (based on Parrot OS).

**Current Version:** Steve 0.1a

## Design Principles

- Multi-architecture support from the start
- Parrot repositories as base
- Clear separation between common logic and architecture-specific config
- Easy to add new architectures later
- Version controlled and reproducible

## Current Status (Steve 0.1a)

- Basic multi-arch build system created
- `build.sh` now performs actual `debootstrap` for aarch64
- Raspberry Pi 5 (aarch64) config implemented
- amd64 placeholder created for future PC support
- Basic branding files added (`os-release`, `hostname`)
- Version naming: Steve 0.1a

## How to Build (Raspberry Pi 5)

```bash
cd build
ARCH=aarch64 sudo ./build.sh
```

This will create a root filesystem in `/tmp/deepshit-build-aarch64/rootfs`

## How to Add a New Architecture

1. Create `config/<arch>.sh` (copy from `aarch64.sh` as template)
2. Adjust variables as needed
3. Run with `ARCH=<newarch> sudo ./build.sh`

## Folder Structure

```
build/
├── build.sh
├── common.sh
├── config/
│   ├── aarch64.sh
│   └── amd64.sh
└── README.md

branding/
configs/deepshit/
```

## Notes

- Run as root (required for debootstrap)
- Currently generates a root filesystem
- Full image generation for Raspberry Pi 5 will be added later
- Wallpaper and more branding assets will be added in branding/
