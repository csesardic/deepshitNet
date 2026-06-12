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
deep-generate-identity
deep-status
```

## Systemd

A basic service file is provided:

```bash
systemctl enable --now deepshit-reticulum
```
