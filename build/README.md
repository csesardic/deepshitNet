# DeepShitNet Build System

This directory contains the build system for **DeepShit OS** (based on Parrot OS).

**Current Version:** Steve 0.1a

## Design Principles

- Multi-architecture support from the start
- Parrot repositories as base
- Clear separation between common logic and architecture-specific config
- Easy to add new architectures later
- Version controlled and reproducible

## Package Structure (Steve 0.1a)

We are moving toward our own custom packages instead of just rebranding Parrot.

### Packages for Steve 0.1a

| Package              | Priority | Purpose                                   |
|----------------------|----------|-------------------------------------------|
| `deepshit-base`      | High     | Core meta-package                         |
| `deepshit-network`   | High     | Reticulum + mesh networking               |
| `deepshit-branding`  | High     | Visual identity + system naming           |
| `deepshit-steve`     | High     | Humor + basic diagnostics (`/usr/bin/steve`) |
| `deepshit-config`    | Medium   | Default system configuration              |
| `deepshit-boot`      | Medium   | Boot layout defaults and Pi boot config   |
| `deepshit-services`  | Low      | Local service discovery (.deep domains)   |
| `deepshit-admin`     | Low      | Admin/diagnostic tools                    |

## Current Status (Steve 0.1a)

- Basic multi-arch build system created
- `build.sh` performs `debootstrap` for aarch64
- Raspberry Pi 5 (aarch64) config implemented
- amd64 placeholder created
- Basic branding started
- `deepshit-config` now exists as a baseline package for system defaults
- `deepshit-boot` now owns boot config defaults and filesystem layout
- Rootfs builds now fail fast on package install errors and validate the core package set
- `build.sh` now assembles a Pi-style disk image after rootfs validation
- The arm64 build now installs Debian kernel/initramfs boot packages before image assembly

## How to Build (Raspberry Pi 5)

```bash
cd build
ARCH=aarch64 sudo ./build.sh
```

The current image assembly expects boot firmware and kernel assets to already exist
inside the built rootfs boot directory. If those assets are missing, the build fails
explicitly instead of producing a fake "bootable" image.

The current arm64 build installs:

- `linux-image-arm64`
- `initramfs-tools`
- `flash-kernel`

This covers the generic Debian kernel/initramfs side. The `deepshit-boot` package now
owns boot defaults like `config.txt`, `cmdline.txt`, and `/etc/fstab`, but it does
**not** fully solve Raspberry Pi 5 firmware integration yet.

## How to Add a New Architecture

1. Create `config/<arch>.sh`
2. Run with `ARCH=<newarch> sudo ./build.sh`

## Future Work

- Image generation (`image/pi5/`, `image/amd64/`)
- Cross-architecture chroot support
- Raspberry Pi firmware/kernel package integration
- Reduce dependency on upstream Parrot packages
