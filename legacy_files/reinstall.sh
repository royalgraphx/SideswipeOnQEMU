#!/bin/bash

# Set Vars
sudo_user_home="$(echo /home/$SUDO_USER)"
qemu_dir=$sudo_user_home/qemu-sideswipe
android_dir=$sudo_user_home/Desktop/sideswipe-vm

clear
echo Delete qemu-sideswipe?
echo No=0, Yes=1
read qemu
if [[ $qemu > 0 ]]; then
sudo rm -rf $qemu_dir
else
echo Sounds good, keeping current build.
fi
sudo rm -rf $android_dir
echo
echo Done!
sleep 3

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
