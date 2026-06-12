# DeepShitNet Status

**Current Version:** Steve 0.1a

## What is DeepShit OS?

A **Parrot-based mesh-network appliance OS** focused on decentralized, resilient, and invisible networking. The goal is to create something that can run on devices like the Raspberry Pi 5 and provide a hidden parallel network layer.

This is currently positioned as an appliance-style OS rather than a general-purpose desktop distribution.

## Completed (Steve 0.1a)

### Packages
- [x] `deepshit-branding`
- [x] `deepshit-steve`
- [x] `deepshit-base`
- [x] `deepshit-network` packaging baseline
- [x] `deepshit-config` packaging baseline
- [x] `deepshit-boot` packaging baseline

### Build System
- [x] Multi-architecture aware build system
- [x] Initial `debootstrap` support for aarch64
- [x] Custom package builds now use `dpkg-buildpackage`
- [x] Rootfs installs fail fast and validate the core package set
- [x] Build script assembles a Pi-style disk image from the validated rootfs
- [x] Arm64 rootfs now installs Debian kernel/initramfs boot packages

### Networking Baseline
- [x] Packaged Reticulum config installs to `/etc/reticulum/config`
- [x] `deepshit-reticulum.service` uses `/usr/bin/python3`
- [x] Package install creates `/var/lib/deepshit/reticulum/`
- [x] Package install generates `identity.id` when dependencies are available
- [x] `deep-status` and `deep-mesh` now agree on the identity file path

## Steve 0.2 Target

**Goal:** First bootable system that actually feels like DeepShit OS.

- Build system installs custom packages into the rootfs automatically
- `deepshit-base` is installed by default
- `deepshit-branding` is installed by default
- `deepshit-steve` is installed by default
- First bootable Raspberry Pi 5 image

## In Progress

- Reticulum + Sideband beyond single-node bootstrap
- Cross-architecture rootfs builds
- Expand `deepshit-config` beyond placeholder system defaults
- Raspberry Pi firmware and kernel integration for genuinely bootable images

## Not Yet Implemented

- Mesh routing and relay functionality
- LoRa or Meshtastic transport integration
- `.deep` service discovery
- Peer-to-peer messaging
- Custom package repository
- Automatic updates
- Full diagnostics suite

## Future Features

- `deepshit-tools` package (`deep-status`, `deep-peers`, `deep-route`, `deep-version`)
- `.deep` local service discovery
- Node-to-node messaging
- DeepShit package repository
- Raspberry Pi 5 image builder
- x86_64 support
- Community node management tools

## Project Maturity (humorous)

- A few days ago: **0/10** (Pure chaos)
- Today: **4/10** (Network package is packaged properly)

The jump from 4/10 to 6/10 tends to happen much faster once the foundations exist.

## Design Goals

- Multi-architecture support from the beginning
- Custom packages (not just rebranding)
- Easy to fork and extend
- Strong chaotic branding (Steve, `.deep`, seagull mascot)

## Repository Structure

```text
deepshitNet/
|-- build/
|-- packages/
|-- branding/
|-- configs/
`-- STATUS.md
```
