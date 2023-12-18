#!/bin/bash

echo "Finds the ID of our Root Partition"
echo "Enter device location e.g. </dev/sda3> | if you followed the setup process in SetupDisks.sh it will be /dev/sda3 by default"
read DEVICE
blkid $DEVICE
echo "Type our PARTUUID here:"
read UUID

arch-chroot /mnt pacman -S efibootmgr --noconfirm
arch-chroot /mnt efibootmgr --disk /dev/sda --part 1 --create --label "Linux Kernel" --loader /vmlinuz-linux --verbose \ --unicode 'root=PARTUUID=$UUID rw initrd=\initramfs-linux.img' 

echo "Reboot now with 'reboot'"

