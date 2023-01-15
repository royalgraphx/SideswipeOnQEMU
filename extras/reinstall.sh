#!/bin/bash

# Set Vars
sudo_user_home="$(echo /home/$SUDO_USER)"
qemu_dir=$sudo_user_home/qemu-sideswipe
android_dir=$sudo_user_home/Desktop/sideswipe-vm

# sudo rm -rf $qemu_dir
sudo rm -rf $android_dir

echo $android_dir
echo Done!
sleep 1
clear
echo Begin Installation...
echo
sleep 1
echo Enter Distro Type:
echo Debian=0, Arch=1
read distro
if [[ $distro > 0 ]]; then
./preinstall_arch.sh
else
./preinstall_debian.sh
fi
