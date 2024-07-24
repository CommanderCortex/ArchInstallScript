You can also download the ISO File under releases, and attatch it to a VM or flash it to a second USB drive to copy the files over to your live ArchISO, 
this is useful if you want an easy way to setup wifi with the Wifi.sh script and then just run the Setup.sh script; Otherwise Follow the steps below.

Super Simple Arch Linux install instructions.

If you're connecting over Wifi then please setup your network using the following Guide: Note i will be using wlan0 here as it's the most common interface, change if needed for your system.
1. type 'ip link' to show your network devices.
2. type 'ip link <Device> set up | Replace <Device> with the name of your network device Such as wlan0, DO NOT use 'lo' as this is our loopback device.
3. type 'iwctl' followed by 'device list' when you see the iwd# prompt.
4. type 'device wlan0 set-property Powered on' | still inside our iwd# prompt.
5. type 'adapter phy0 set-property Powered on' | NOTE: Change phy0 to match your adapter name.
6. type 'station wlan0 scan && station device get-networks && exit'.
7. Now back in our shell type: 'iwctl --passphrase <Network_Password> station wlan0 connect <Network_Name> | Replace <> with your network Information.

Now follow the same as below:

If you're connected over Ethernet use the Following:

Test our internet connection:
'ping archlinux.org' - Tip: use ctrl + c, to halt any running Command or Script.
if you get host name not resolved, then you're not connnect to the internet follow step one and two of the wifi setup if you're using ethernet to make sure your ethernet adapter is setup, if you're using wifi go back and restart, you did something wrong and or didn't read what i've written down.

To get the scripts running on our Live Arch ISO follow these commands:
'pacman -Sy git'
'git clone https://github.com/CommanderCortex/ArchInstallScript'
'cd ArchInstallScript'
'chmod +x *.sh' | Note this allows us to run scripts, chmod +x scriptname.sh

Tip: Vim;
Vim is a terminal based text editor, to open a text file use 'vim NameOfTextFile' | you can also create a file with vim using the same command.
Once in vim the use the 'i' key to enter input mode. to exit press 'esc' then 'shit + :' the type 'wq' to save and exit, Note: 'w' refers to write & 'q' refers to quit.

You can edit the scripts to follow your own preferances. I've added a bunch of Comments (#) that should help explain what each line is doing.

For use as a server & or no gui & or you want your own desktop environment, delete the Edit the Desktop environment Script to fit your needs.

Then run the ./Setup.sh Script

Then type reboot again. 
Arch will be fully setup in a blank state with a simple GUI.

If you're setting this up in Hyper-V for testing purposes or you want to edit the script file for your computer, Hyper-V is a useful place to test things. Onec you've finished the ./Setup.sh script boot back into the Arch installer,
& from here use these commands 'mount /dev/sda3 /mnt' then 'mount /dev/sda1 /mnt/boot/efi' then run the Hyper-V script in the Utils folder. This will setup the bootloader for Hyper-V to be able to boot.

Updating & Installing Packages:
1. To update the system use 'sudo pacman -Syu' and or 'sudo pacman -Syyu'
2. To install a packages use 'sudo pacman -S (Package Name)' | e.g. 'sudo pacman -S firefox'
3. To find packages use the offical Repo found here: https://archlinux.org/packages/
4. For Community based Packages use paru found here: https://github.com/Morganamilo/paru
