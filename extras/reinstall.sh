#!/bin/bash

# Set Vars
sudo_user_home="$(echo /home/$SUDO_USER)"
qemu_dir=$sudo_user_home/qemu-sideswipe
android_dir=$sudo_user_home/Desktop/sideswipe-vm

# sudo rm -rf $qemu_dir
sudo rm -rf $android_dir

echo Done!
