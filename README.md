If you're connected over Wifi then please setup your network using the following Guide: Note i will be using wlan0 here as it's the most common interface, change if needed for your system.
1. type 'ip link' to show your network devices
2. type 'ip link <Device> set up | Replace <Device> with the name of your network device Such as wlan0, DO NOT use 'lo' as this is our loopback device
3. type 'iwctl' followed by 'device list' when you see the iwd# prompt
4. type 'device wlan0 set-property Powered on' | still inside our iwd# prompt
5. type 'adapter phy0 set-property Powered on' | NOTE: Change phy0 to match your adapter name
6. type 'station wlan0 scan && station device get-networks && exit'
7. Now back in our shell type: 'iwctl --passphrase <Network Password> station wlan0 connect <Network Name> | Replace <> with your network Information

Now follow the same as below:

If you're connected over Ethernet use the Following:

'ping archlinux.org' - Tip: use ctrl + c, to halt any running Command or Script.

To get the scripts running on our Live Arch ISO follow these commands:
'pacman -Sy git'
'git clone https://github.com/CommanderCortex/archscripts'
'cd archscripts'
'chmod +x *.sh'

Then run the scripts in the following Order
1. Disks_Setup
2. Packages_Setup
3. Grub_Setup
4. Services_Setup
5. Accounts_Setup
