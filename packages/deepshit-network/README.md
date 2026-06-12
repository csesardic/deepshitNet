# deepshit-network

Networking layer for DeepShit OS (Steve 0.1a).

## Components

- Reticulum mesh networking
- Sideband client support
- Helper commands:
  - `deep-status`
  - `deep-peers`
  - `deep-generate-identity`
  - `deep-mesh`

## Configuration

Default Reticulum config is installed to `/etc/reticulum/config`.

Node identity is stored in `/var/lib/deepshit/reticulum/`.

## Usage

After installation, run:

```bash
deep-status
```

The package creates `/var/lib/deepshit/reticulum/identity.id` during install when Reticulum is available.

## Systemd

A basic service file is provided:

```bash
systemctl enable --now deepshit-reticulum
```

## Current Scope

The current networking package provides:

- packaged Reticulum configuration in `/etc/reticulum/config`
- a systemd unit for the Reticulum daemon
- helper scripts for identity generation and local status checks

It does not yet provide multi-node routing, LoRa transport integration, or peer discovery beyond Reticulum defaults.
