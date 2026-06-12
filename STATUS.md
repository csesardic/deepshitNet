# DeepShitNet Status

**Current Version:** Steve 0.1a

## Overview

DeepShitNet is an underground decentralized mesh network and OS built on top of Parrot OS repositories, designed to be multi-architecture and easily forkable.

## Completed (Steve 0.1a)

### Packages
- [x] `deepshit-branding` — Finished (os-release, hostname, motd, wallpaper support)
- [x] `deepshit-steve` — Finished (`/usr/bin/steve` command with exit codes)
- [x] `deepshit-base` — Finished (meta-package)

### Build System
- [x] Basic multi-architecture build system (`build/`)
- [x] `build.sh` with debootstrap support for aarch64
- [x] Architecture configs (`aarch64.sh` + `amd64.sh` placeholder)

## In Progress

- `deepshit-network` — Started (Reticulum + Sideband integration via postinst)

## Next Steps

- Improve `deepshit-network` (default configs, helper scripts)
- Add wallpaper to `deepshit-branding`
- Improve build system to actually install custom packages
- Start working on image generation for Raspberry Pi 5

## Design Goals

- Multi-architecture support from day one
- Custom packages instead of just rebranding
- Easy to fork and extend
- Strong branding and humor (Steve, .deep, seagull)

## Repository Structure

```
deepshitNet/
├── build/           # Build system
├── packages/        # Custom .deb packages
├── branding/        # Wallpapers and assets
├── configs/         # System configs
└── STATUS.md
```
