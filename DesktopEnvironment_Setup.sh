#!bin/sh

#Run this script after installing everything and booting into Arch

sudo pacman -Syu
sudo pacman -S sddm wayland plasma-desktop
sudo systemctl enable sddm --now 
