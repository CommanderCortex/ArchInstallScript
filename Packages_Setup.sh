#!/bin/sh
#

echo "Installing Arch Linux!"

pacstrap -K /mnt base linux linux-firmware grub vim networkmanager iwd neofetch 

sleep 2
echo "Generation of our 'fstab' file:"
genftsab -U /mnt >> /mnt/etc/ftsab
echo "-- 'fstab' file created!"
echo "Building our Initial RamDisk:"
sleep 2
arch-chroot /mnt mkinitcpio -P 

