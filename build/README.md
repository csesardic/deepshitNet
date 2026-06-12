# DeepShitNet Build System

This directory contains the build system for **DeepShit OS** (based on Parrot OS).

The goal is to have a clean, modular, and multi-architecture build system that can be easily forked and extended.

## Design Principles

- Multi-architecture support from the start
- Parrot repositories as base
- Clear separation between common logic and architecture-specific config
- Easy to add new architectures later
- Version controlled and reproducible

## Current Status

- Basic structure created
- `build.sh` skeleton ready
- `aarch64` (Raspberry Pi 5) config started
- `amd64` placeholder created
- Uses `debootstrap` + Parrot repos

## How to Build (Raspberry Pi 5)

```bash
cd build
ARCH=aarch64 ./build.sh
```

## How to Add a New Architecture

1. Create `config/<arch>.sh` (e.g. `amd64.sh`)
2. Define the required variables (see `config/aarch64.sh` for reference)
3. Run with `ARCH=<newarch> ./build.sh`

## Folder Structure

```
build/
├── build.sh          # Main build script
├── common.sh         # Shared functions
├── config/
│   ├── aarch64.sh
│   └── amd64.sh
└── README.md
```

## Future Plans

- Root filesystem generation (current)
- Full bootable image generation for Raspberry Pi 5
- Support for x86_64 PCs
- Custom package building
- Automated CI builds
