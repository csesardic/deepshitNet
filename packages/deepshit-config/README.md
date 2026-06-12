# deepshit-config

Default system configuration package for DeepShit OS (Steve 0.1a).

## Components

- `/etc/deepshit/defaults.conf`
- `/etc/default/deepshit`

## Purpose

This package provides a small, non-visual configuration baseline for DeepShit OS so
`deepshit-base` can depend on a real package instead of a placeholder.

The current scope is intentionally small:

- package a central config directory
- define a few default runtime toggles
- leave branding and networking to their dedicated packages
