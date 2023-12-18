#!/bin/sh
#Made By CommanderCortex: www.github.com/CommanderCortex
#
echo "Welcome to Cortex's Disk Management utility for seting up Arch Linux"
echo " "
lsblk
echo " "
echo "Select your desired Device: (Most modern laptops and computers will either be 'sda' or 'nvme0n1/n2')"
read DEVICE_ID
echo "$DEVICE_ID will be used for setup"
echo "READ ME: Please Create 3 partions, Partion 1 Size=300M, Partition 2 Size=RAM Size, Partion 3 Size=Rest of Disk, Then Write the changes & quit"
echo "Executing Cfdisk in 10s"
sleep 10
cfdisk /dev/$DEVICE_ID
X=$DEVICE_ID
X+='1'
mkfs.fat -F 32 /dev/$X
echo "Fat32 Partion setup for boot on Device: $X"
Y=$DEVICE_ID
Y+='2'
mkswap /dev/$Y
swapon /dev/$Y
echo "Swap Partion Enabled! on $Y"
Z=$DEVICE_ID
Z+='3'
echo "Select Filesystem type: | Type 'ext4' if unsure"
read FILETYPE
mkfs.$FILETYPE /dev/$Z
echo "/mnt Partion setup completed [OKAY]"

echo "Starting mount process for installation to work"

mount /dev/$Z /mnt
echo "Mounted 'mnt' Partion! [OKAY]"
echo "Select Boot Directory: | Type '/mnt/boot/efi'"
read BOOTDIRECTORY
mount --mkdir /dev/$X $BOOTDIRECTORY

echo "Disk Setup Complete!"
sleep 3
