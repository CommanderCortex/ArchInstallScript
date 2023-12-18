#!/bin/sh

#Run this script after installing everything and booting into Arch

arch-chroot /mnt pacman -Syu
arch-chroot /mnt pacman -S alacritty sddm wayland plasma-desktop
arch-chroot /mnt systemctl enable sddm 
