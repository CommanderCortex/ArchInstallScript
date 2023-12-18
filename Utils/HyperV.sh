#!/bin/bash

echo "Finds the ID of our Root Partition"
echo "Enter device location e.g. </dev/sda3> | if you followed the setup process in SetupDisks.sh it will be /dev/sda3 by default"
read DEVICE
uuid=$(blkid --match-tag UUID | grep $DEVICE) && uuid1="${uuid#*=}"
echo $uuid1

arch-chroot /mnt pacman -S efibootmgr --noconfirm
arch-chroot /mnt efibootmgr --disk /dev/sda --part 1 --create --label "Linux Kernel" --loader /vmlinuz-linux --verbose \ --unicode 'root=PARTUUID=$uuid1 rw initrd=\initramfs-linux.img' 

echo "Reboot now with 'reboot'"

