#!/bin/bash

echo "Setup an EFI File for Booting in Hyper-V"
lsblk
echo "Enter our root partition here - e.g. </dev/sda3> | use our /mnt Partition will either be /dev/sda3 or /dev/nvme0n1p3"
read DEVICE #Gets the input of our Device so we can grab the UUID (Unique Identifier) of the device
uuid=$(blkid --match-tag UUID | grep $DEVICE) && uuid1="${uuid#*=}" #Grabs the Exact UUID of our device using blkid (Block ID)
echo $uuid1 #Prints Back the UUID of our Device

arch-chroot /mnt pacman -S efibootmgr --noconfirm #Installs efibootmgr (Efi Boot Manager) - This allows us to install a bootloader for Hyper-V to boot
arch-chroot /mnt efibootmgr --disk /dev/sda --part 1 --create --label "Linux Kernel" --loader /vmlinuz-linux --verbose \ --unicode 'root=PARTUUID=$uuid1 rw initrd=\initramfs-linux.img' 
#The command above creates a label in our EFI File names Linux Kernel which tells the boot loader to boot into linux from our UUID we set before.
echo "Efi Boot Manager Enabled via EFI File for Hyper-V | Will power off in 3s Just start the VM normally after device powers off"
sleep 3
poweroff