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
| `deepshit-services`  | Low      | Local service discovery (.deep domains)   |
| `deepshit-admin`     | Low      | Admin/diagnostic tools                    |

## Current Status (Steve 0.1a)

- Basic multi-arch build system created
- `build.sh` performs `debootstrap` for aarch64
- Raspberry Pi 5 (aarch64) config implemented
- amd64 placeholder created
- Basic branding started

## How to Build (Raspberry Pi 5)

```bash
cd build
ARCH=aarch64 sudo ./build.sh
```

## How to Add a New Architecture

1. Create `config/<arch>.sh`
2. Run with `ARCH=<newarch> sudo ./build.sh`

## Future Work

- Full custom package building (.deb)
- Image generation (`image/pi5/`, `image/amd64/`)
- Reduce dependency on upstream Parrot packages
