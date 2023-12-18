#!/bin/bash

# systemctl enable creates a flag that starts services at boot
# the --now flag starts the service staright away
echo -e "\nEnabling essential services"

systemctl enable NetworkManager.service #Example: Enables our Network Manager on boot.
systemctl enable bluetooth
systemctl enable iwd 

#Add any services here that you install to start on boot
