#!/bin/bash

# systemctl enable creates a flag that starts services at boot
# the --now flag starts the service staright away
echo -e "\nEnabling essential services"

arch-chroot /mnt systemctl enable NetworkManager.service #Example: Enables our Network Manager on boot.
echo "Network Manager enabled!"
arch-chroot /mnt systemctl enable iwd 
echo "Iwd Enabled!"
arch-chroot /mnt systemctl enable sddm 
#Add any services here that you install to start on boot

reboot
