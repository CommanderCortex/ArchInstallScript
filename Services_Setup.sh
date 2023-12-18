#!/bin/bash

# systemctl enable creates a flag that starts services at boot
# the --now flag starts the service staright away
echo -e "\nEnabling essential services"

arch-chroot /mnt systemctl enable NetworkManager.service #Example: Enables our Network Manager on boot.
arch-chroot /mnt systemctl enable bluetooth
arch-chroot /mnt systemctl enable iwd 

#Add any services here that you install to start on boot
