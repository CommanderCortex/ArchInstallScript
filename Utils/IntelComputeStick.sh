#Reload wifi drivers fast, only in case of buggy firmware for the Intel Compute Stick

sudo rfkill block wlan && sudo rfkill unblock wlan
sudo modprobe -r iwlwifi && sudo modprobe iwlwifi
