#!/bin/bash

# Vars

git_dir="$(pwd)"
required_files=required_files
ssvm_workingdir=$git_dir/ssvm
sudo_user_home="$(echo /home/$SUDO_USER)"
install_dir=$sudo_user_home/Desktop/SSVM


# Begin

clear
cat $git_dir/$required_files/ssvm_installer
echo
echo
echo Welcome to SSVM Installer !
echo Moving to Desktop ...
echo

echo DEBUG: 'Show Paths'
echo This is the SSVM Working Directory: $ssvm_workingdir
echo This is the installation Directory: $install_dir
echo

mv $ssvm_workingdir $install_dir

echo
echo "Complete! 'First Run' Booting ..."

cd $install_dir
sudo ./chain.sh