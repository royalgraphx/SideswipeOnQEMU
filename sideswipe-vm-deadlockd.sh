#!/bin/bash

# Variables

# Welcome to the sideswipe-vm-deadlockd script
# this is the automation for installing mesa drivers.
# Version 1.0.0

sudo_user_home="$(echo /home/$SUDO_USER)"
android_dir=$sudo_user_home/Desktop/sideswipe-vm
git_dir="$(pwd)"
required_files=$git_dir/required_files
system_mount=/tmp/system
android_mount=/tmp/android

clear
echo
echo Printing PATHs:
echo $sudo_user_home
echo $android_dir
echo $git_dir
echo $required_files
echo $system_mount
echo $android_mount

# CD & Mount android.img from sideswipe-vm

cd $android_dir
mount -o ro,norecovery,rw android.img $android_mount

# Mount System.img
cd /tmp/android
mount -o ro,norecovery,rw system.img $system_mount

# Copy & Overwrite MESA

cp -r $required_files/system/lib/* "$system_mount/lib"
echo $system_mount/lib - Modified Successfully!

cp -r $required_files/system/lib64/* "$system_mount/lib64"
echo $system_mount/lib64 - Modified Successfully!

cp -r $required_files/system/vendor/* "$system_mount/vendor"
echo $system_mount/vendor - Modified Successfully!

# Flush mounted imgs and clear PATHs
cd $git_dir
./umount.sh