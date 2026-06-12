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

### Build System
- [x] Multi-architecture aware build system
- [x] Initial `debootstrap` support for aarch64

## Steve 0.2 Target

**Goal:** First bootable system that actually feels like DeepShit OS.

- Build system installs custom packages into the rootfs automatically
- `deepshit-base` is installed by default
- `deepshit-branding` is installed by default
- `deepshit-steve` is installed by default
- First bootable Raspberry Pi 5 image

## In Progress

- `deepshit-network` — Reticulum + Sideband integration

## Not Yet Implemented

- Mesh routing and relay functionality
- .deep service discovery
- Peer-to-peer messaging
- Custom package repository
- Automatic updates
- Full diagnostics suite

## Future Features

- `deepshit-tools` package (`deep-status`, `deep-peers`, `deep-route`, `deep-version`)
- .deep local service discovery
- Node-to-node messaging
- DeepShit package repository
- Raspberry Pi 5 image builder
- x86_64 support
- Community node management tools

## Project Maturity (humorous)

- A few days ago: **0/10** (Pure chaos)
- Today: **3/10** (Actual distro skeleton)

The jump from 3/10 to 6/10 tends to happen much faster once the foundations exist.

## Design Goals

- Multi-architecture support from the beginning
- Custom packages (not just rebranding)
- Easy to fork and extend
- Strong chaotic branding (Steve, .deep, seagull mascot)

## Repository Structure

```
deepshitNet/
├── build/
├── packages/
├── branding/
├── configs/
└── STATUS.md
```
