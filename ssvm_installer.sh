#!/bin/bash

# Vars

git_dir="$(pwd)"
ssvm_workingdir=$git_dir/ssvm
install_dir=$HOME/Desktop/sideswipe-vm

# Begin

clear
cat $required_files/ssvm_installer
echo
echo
echo Welcome to SSVM Installer !
echo Moving to Desktop ...
echo

mv $ssvm_workingdir $install_dir

echo
echo "Complete! 'First Run' Booting ..."

cd $install_dir
./chain.sh