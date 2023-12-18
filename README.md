Super Simple Arch Linux install instructions

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

Test our internet connection:
'ping archlinux.org' - Tip: use ctrl + c, to halt any running Command or Script.
if you get host name not resolved, then you're not connnect to the internet follow step one and two of the wifi setup if you're using ethernet to make sure your ethernet adapter is setup, if you're using wifi go back and restart, you did something wrong and or didn't read what i've written down.

To get the scripts running on our Live Arch ISO follow these commands:
'pacman -Sy git'
'git clone https://github.com/CommanderCortex/archscripts'
'cd archscripts'
'chmod +x *.sh'

Tip: Vim;
Vim is a terminal based text editor, to open a file type 'vim <textfile>' | you can also create a file with vim using the same command
Once in vim the use the 'i' key to enter input mode. to exit press 'esc' then 'shit + :' the type 'wq' to save and exit, Note: 'w' refers to write & 'q' refers to quit.

You can edit the scripts to follow your own preferances. I've added a bunch of Comments (#) that should help explain what each line is doing.

For use as a server & or no gui & or you want your own desktop environment, delete the Edit the Desktop environment Script to fit your needs.

Then run the ./Setup.sh Script

Once the computer reboots, press ctrl+alt+f4, login with the root user & password we set. Then type cd .., followed by vim /etc/sudoers. Then go-to line 108 by using 'shit+:' typing '108' then pressing enter
Once there delete the # before %wheel. Exit with 'qa!' not 'qa' like mentioned before. (qa! allows us to edit read only files)

Then type reboot again. 
Arch will be fully setup in a black state with a simple GUI
