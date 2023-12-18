#!/bin/bash

echo "Grub Setup for EFI!"
echo "Specify your efi directory | Type '/boot/efi' if unsure!"
read EFIDIRECTORY
arch-chroot grub-install --target=x86_64-efi --efi-directory=$EFIDIRECTORY --bootloader-id=grub_uefi --removable
sleep 1
echo "Seting up our Grub Config:"
arch-chroot grub-mkconfig -o /boot/grub/grub.cfg
