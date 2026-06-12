# Pi 5 firmware overlay

Place Raspberry Pi 5 boot firmware files in this directory when the configured
APT repositories do not provide all required assets for a bootable image.

The build copies these files into the boot partition after package installation
and before image assembly.

Typical examples include Raspberry Pi bootloader and board-specific firmware
artifacts such as `.elf`, `.dat`, and `.dtb` files.

This directory is intentionally kept out of package contents so firmware source
selection stays part of the build pipeline rather than the OS packages.
