#!/bin/sh

#Starts our setup for the Systems Root Password And a local user account.
echo "Starting setup of Root Password & Local User Account"
echo "We need sudo installed, I will install it with the following:"
arch-chroot /mnt pacman -S sudo --noconfirm # Arch-Chroot allows us to run commands within our new install of Arch. The --noconfirm flag skips the Do you want to install this package yes/no:
echo "Now we will set the root Password:"
arch-chroot /mnt passwd #passwd is a linux built-in command for setting the root password.
echo "Once we have done that we can setup a local user account with admin rights to use the sudo command"
echo "Specify a username: | Note: All local accounts must be in Lowercase form! e.g. 'chris' or 'user'"
read LOCALUSER
arch-chroot /mnt useradd -m -G wheel $LOCALUSER 
echo "Local user $LOCALUSER Added!"
echo "Set password for $LOCALUSER"
arch-chroot /mnt passwd $LOCALUSER
echo "Account setup for use!"
# Remove no password sudo rights
arch-chroot /mnt sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

./DesktopEnvironment_Setup.sh
