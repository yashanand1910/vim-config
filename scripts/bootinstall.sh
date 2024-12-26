#!/bin/bash
set -eux
efibootmgr -c -d /dev/nvme0n1 -p 1 -L "Gentoo" -l "\EFI\Linux\kernel.efi" -u "root=PARTUUID=96598d3b-53b5-4a79-814a-26ae5ffbb909 initrd=\EFI\Linux\initramfs.img"
