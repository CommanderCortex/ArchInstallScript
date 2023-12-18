#!/bin/bash

# systemctl enable creates a flag that starts services at boot
# the --now flag starts the service staright away

systemctl enable NetworkManager --now #Example: Enables our Network Manager on boot.
systemctl enable iwd --now
#Add any services here that you install to start on boot
