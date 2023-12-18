#!/bin/sh
#MADE BY www.github.com/CommanderCortex ALL RIGHTS RESERVED

clear
ip link #Shows all of our Network interfaces:
echo "lo is our loopback device"
echo "This Script assumes you're using Wifi, if you are using Ethernet cancel this script"

echo " "
echo "Wifi Setup:"
echo "Make sure this script is run as root or with sudo!"
echo ""
#-------------------------------------------------------------------------------------#
echo "Input Network Device Name (e.g <wlan0>):" #Sets up our Networking interface.
read INTERFACE #Saves the name of our interface in the $INTERFACE variable.
ip link set $INTERFACE up #Uses ip link to ensure our device is powered on.
#-------------------------------------------------------------------------------------#
iwctl device $INTERFACE set-property Powered on #Ensures our Device is Powered on
iwctl adapter phy0 set-property Powered on #Ensures our Adapter is Powered on
#-------------------------------------------------------------------------------------#
iwctl station $INTERFACE scan #Scans for networks in the area
iwctl station $INTERFACE get-networks #Displays all those networks
#-------------------------------------------------------------------------------------#
echo "Enter Network SSID:"
read SSID #Captures the desired SSID the user wants to connect to.
echo "Enter Password for $SSID"
read PASSWORD #Captues the Password for the Network.
#-------------------------------------------------------------------------------------#
iwctl --passphrase $PASSWORD station wlan0 connect $SSID #Connects to our Network with the given SSID & Password
iwctl station list
echo "Ensure your device reads 'Connected' then run 'ping archlinux.org' to ensure you're connected!"
#End of Script.
#If you face issues with your adapter then change <phy0> to the name of your adapter:
#To find your adapters name use iwctl adapter list
#If you're having issues with your network device not showing up in 'ip link' then 'lspci' to list your PCI devices, if its missing then you need to install the firmware for your network device



