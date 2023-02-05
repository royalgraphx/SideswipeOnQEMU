#!/bin/sudo bash

# Vars

git_dir="$(pwd)"
required_files=required_files
ssvm_workingdir=$git_dir/ssvm
sudo_user_home="$(echo /home/$SUDO_USER)"
install_dir=$sudo_user_home/Desktop/sideswipe-vm


# Begin

clear
cat $git_dir/$required_files/ssvm_installer
echo
echo
echo Welcome to SSVM Installer !
echo Moving to Desktop ...
echo

echo DEBUG: 'Show Paths'
echo $ssvm_workingdir
echo $install_dir
echo

mv $ssvm_workingdir $install_dir

echo
echo "Complete! 'First Run' Booting ..."

cd $install_dir
sudo ./chain.sh