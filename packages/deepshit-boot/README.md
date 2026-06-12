# deepshit-boot

Boot integration package for DeepShit OS (Steve 0.1a).

## Components

- boot partition defaults such as `config.txt` and `cmdline.txt`
- `/etc/fstab` entries aligned with the DeepShit image layout
- a small post-install hook that ensures the boot config directory exists

## Purpose

This package keeps Raspberry Pi and boot-layout policy out of `build.sh` as much as
possible. The builder should assemble images; the package should define what boot
configuration belongs inside the OS.

It does not currently ship Raspberry Pi 5 firmware blobs. That remains a separate
integration task.
