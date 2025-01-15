#!/bin/sh
#Made By CommanderCortex: www.github.com/CommanderCortex
echo "Welcome to CommanderCortex's Script for installing Arch Linux"
wait 2
echo "Getting Devices:"
lsblk #Runs the List Block Command (Block here just refers to all Storage devices, Each storage device is setup in memory as a Block)
# This command will often create an output that displays the connected "Storage Devices":
# hda, sda or nvme0n1    
# HDA is a referance to HARD DRIVE 'A'
# SDA is a referance to SATA DRIVE 'A'
# NVME0N1 is a Referance to Non-Volitile-Memory-Express Drive '0' North bridge slot '1' --- North bridge is just a location on the Motherboard
echo "Part 1 - Disk Setup!"
sleep 3
echo "Select your desired Device: (Most modern laptops and computers will either be 'sda' or 'nvme0n1/n2')"
read DEVICE_ID #Gets the desired storage from the users input using the Read command then stores that text in the $Device_ID Variable.
echo "$DEVICE_ID will be used for setup"
echo "READ ME: Please Create 3 Partitions, Partition  1 Size=300M, Partition 2 Size=RAM Size, Partition  3 Size=Rest of Disk, Then Write the changes & quit"
#It is important to use the above format for creating the optimal Partition Table for Linux
echo "Executing cfdisk in 5s"
sleep 5
cfdisk /dev/$DEVICE_ID #Opens cfdisk and targets our storage device that we set before
X=$DEVICE_ID
X+='1' #These 2 lines adds a 1 to our device name, e.g sda + 1; so /dev/sda1 > this just points to the device labeled sda and the 1 is our partition number.
mkfs.fat -F 32 /dev/$X #Formats our 1st partition in the Fat32 Format so our BIOS/UEFI can read our bootloader files.
echo "Fat32 Partition setup for boot on Device: $X"
Y=$DEVICE_ID
Y+='2' #These 2 lines adds a 2 to our device name, e.g sda + 2; so /dev/sda2 > this just points to the device labeled sda and the 2 is our partition number.
mkswap /dev/$Y #Creates a Swap Partition on our Device;
swapon /dev/$Y #Turns our Swap Partition on, to verify; run 'lsblk' we should now see [SWAP] next to our Devices Second Partition
echo "Swap Partition Enabled! on $Y"
Z=$DEVICE_ID
Z+='3' #These 2 lines adds a 3 to our device name, e.g sda + 3; so /dev/sda3 > this just points to the device labeled sda and the 3 is our partition number.
echo "Select Filesystem type: | Type 'ext4' if unsure"
read FILETYPE #Gets the filesytem the user wants to use for their root (Home) partition
mkfs.$FILETYPE /dev/$Z #Creates the desired filesystem
echo "/mnt Partition setup completed [OKAY]"

echo "Starting mount process for installation to work"

mount /dev/$Z /mnt #Allows us to mount our root (Home) Partition (/mnt) to the device labeled /dev/sda3 & or /dev/nvme0n1p3
#This creates a link called /mnt (Path to our link) that Linux can use to store files there
#Basicly where identifing the Street as Sata Drive 'a' & the house on the Street '3' as a partion on the Drive then giving it an Address at '/mnt' (Short for Mount)
echo "Mounted 'mnt' Partition! [OKAY]"
echo "Select Boot Directory: | Type '/mnt/boot/efi'"
read BOOTDIRECTORY #Select where our Efi (Boot) Files will be located, By Default all UEFI BIOS systems will look for those files under /boot/efi
mount --mkdir /dev/$X $BOOTDIRECTORY #Creates a Directory & Mounts it where we set it before, e.g: /dev/sda1 & or /dev/nvme0n1p1 >> /mnt/boot/efi

# The above simply mounts our SSD / HDD with a link (Path to boot files) "/boot/efi" that our BIOS can see

echo "Disk Setup Complete!"
sleep 1

echo "Part 2 - Installing Arch Linux!"
sleep 3

#Installs the Linux Kernel, Base (Includes things like Pacman, Pacman is a package manager similar to the App Store - Just a Linux variation on it) 
#& Finally our Firmware files that allow the (OS) Operating System to interact with our Hardware throught the BIOS
pacstrap -K /mnt base base-devel linux linux-firmware vim nano sudo archlinux-keyring wget libnewt --noconfirm --needed # '--' is just a flag and allows these to install.
#Without asking the user for confirmation

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
#The above used the 'cp' Copy command to coppy our 'mirrorlist' a list of servers close by for downloading at efficient speeds.

sleep 1
echo "Generation of our 'fstab' file:"
genfstab -U /mnt >> /mnt/etc/fstab
#genfstab is a Bash script that is used to automatically detect all mounts under a given mountpoint, its output can then be redirected into a file, usually /etc/fstab.
#the fstab file contains test like this:
#PARTION: /dev/sda1    UUID=(Unique Identifier)    /mnt/boot/efi --trim --removable
#this allows our BIOS to read each partion and their 'link' (pathway to files) on boot without having to re specify those in memory etc.

echo "-- 'fstab' file created!"
echo "Building our Initial RamDisk:"
sleep 1
arch-chroot /mnt mkinitcpio -P
#mkinitcpio is a Bash script used to create an initial ramdisk environment:
#The initial ramdisk is in essence a very small environment (early userspace) which loads various kernel modules
#and sets up necessary things before handing over control to init. This makes it possible to have, for example,
#encrypted root file systems and root file systems on a software RAID array.
#mkinitcpio allows for easy extension with custom hooks, has autodetection at runtime, and many other features.

#Add parallel downloading
sed -i 's/^#Para/Para/' /etc/pacman.conf

#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy --noconfirm

PKGS=(
'grub'
'vim'
'git'
'networkmanager'
'iwd'
'neofetch'
'sudo'
'alacritty'
'sddm'
'sddm-kcm'
'wayland'
'alsa-util'
'alsa-plugins'
'dolphin'
'firefox'
'bluedevil'
'plasma-desktop'
'code'
'dosfstools'
'zip'
'zip'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    arch-chroot /mnt pacman -S "$PKG" --noconfirm --needed
done


echo "Part 3 - Bootloader Setup!"
sleep 3
echo "Setting up Grub for EFI!"
echo "Specify your efi directory | Type '/boot/efi' if unsure!"
read EFIDIRECTORY #Gets where we want to install our bootloader | UEFI Devices always look for an EFI File under /boot/efi
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=$EFIDIRECTORY --bootloader-id=grub_uefi --removable
#Installs our Grub Bootloader, --target specifies our Architecture. --efi-directory is where we install it too. --bootloader-id is the Identifier we assign to our Bootloader.
# --removable allows the device to be removed from the computer; Without this flag if you unplug the drive you will not be able to boot into grub without reinstalling it.
sleep 1
echo "Setting up our Grub Config!"
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg #Creates a grub.cfg file which we can edit and configure to customise our Boot Process
#Note: grub.cfg is required and stores all the information about where the Kernel is and how to boot into it.

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
cat <<EOF > /etc/sddm.conf
[Theme]
Current=Nordic
EOF
#Add any services here that you install to start on boot

#Defines the name of our Host Machine:
echo "Type a new computer name:"
read nameofmachine
$nameofmachine > /etc/hostname

#Sets our timezone
echo "Select your timezone e.g; Pacific/Auckland"
read TIMEZONE
timedatectl --no-ask-password set-timezone $TIMEZONE

# Set keymaps
localectl --no-ask-password set-keymap us

echo "Arch install complete and will reboot in 3s please remove all USB installers on next boot"
wait 3
reboot
