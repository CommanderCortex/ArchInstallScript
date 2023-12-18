#!/bin/sh
#Made By CommanderCortex: www.github.com/CommanderCortex
echo "Welcome to CommanderCortex's Script for installing Arch Linux"
wait 2
echo "Getting Devices:"
lsblk
echo "Part 1 - Disk Setup!"
sleep 3
echo "Select your desired Device: (Most modern laptops and computers will either be 'sda' or 'nvme0n1/n2')"
read DEVICE_ID
echo "$DEVICE_ID will be used for setup"
echo "READ ME: Please Create 3 Partitions, Partition  1 Size=300M, Partition 2 Size=RAM Size, Partition  3 Size=Rest of Disk, Then Write the changes & quit"
echo "Executing cfdisk in 5s"
sleep 5
cfdisk /dev/$DEVICE_ID
X=$DEVICE_ID
X+='1'
mkfs.fat -F 32 /dev/$X
echo "Fat32 Partition setup for boot on Device: $X"
Y=$DEVICE_ID
Y+='2'
mkswap /dev/$Y
swapon /dev/$Y
echo "Swap Partition Enabled! on $Y"
Z=$DEVICE_ID
Z+='3'
echo "Select Filesystem type: | Type 'ext4' if unsure"
read FILETYPE
mkfs.$FILETYPE /dev/$Z
echo "/mnt Partition setup completed [OKAY]"

echo "Starting mount process for installation to work"

mount /dev/$Z /mnt
echo "Mounted 'mnt' Partition! [OKAY]"
echo "Select Boot Directory: | Type '/mnt/boot/efi'"
read BOOTDIRECTORY
mount --mkdir /dev/$X $BOOTDIRECTORY

echo "Disk Setup Complete!"
sleep 1

echo "Part 2 - Installing Arch Linux!"
sleep 3

pacstrap -K /mnt base linux linux-firmware grub vim networkmanager iwd neofetch sudo alacritty sddm wayland plasma-desktop

sleep 1
echo "Generation of our 'fstab' file:"
genfstab -U /mnt >> /mnt/etc/fstab
echo "-- 'fstab' file created!"
echo "Building our Initial RamDisk:"
sleep 1
arch-chroot /mnt mkinitcpio -P

echo "Part 3 - Bootloader Setup!"
sleep 3
echo "Setting up Grub for EFI!"
echo "Specify your efi directory | Type '/boot/efi' if unsure!"
read EFIDIRECTORY
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=$EFIDIRECTORY --bootloader-id=grub_uefi --removable
sleep 1
echo "Setting up our Grub Config!"
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

echo "Part 4 - Account Management!"
sleep 3
#Starts our setup for the Systems Root Password And a local user account.
echo "Starting setup of Root Password & Local User Account"
echo "We need sudo installed, I will install it with the following:"
arch-chroot /mnt pacman -S <> --noconfirm # Arch-Chroot allows us to run commands within our new install of Arch. The --noconfirm flag skips the Do you want to install this package yes/no:
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

echo "Part 5 - Services Setup!"
# systemctl enable creates a flag that starts services at boot
# the --now flag starts the service staright away
echo -e "\nEnabling essential services"

arch-chroot /mnt systemctl enable NetworkManager.service #Example: Enables our Network Manager on boot.
echo "Network Manager enabled!"
arch-chroot /mnt systemctl enable iwd
echo "Iwd Enabled!"
arch-chroot /mnt systemctl enable sddm
#Add any services here that you install to start on boot

echo "Arch install complete and will reboot in 3s please remove all USB installers on next boot"
wait 3
reboot