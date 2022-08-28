#!/bin/bash

# set variables
git_dir=/home/royalgraphx/Desktop/SideswipeOnQEMU

# install required dependencies
sudo apt-get update
sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
sudo apt-get install git-email
sudo apt-get install libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev
sudo apt-get install libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev
sudo apt-get install libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev
sudo apt-get install librbd-dev librdmacm-dev
sudo apt-get install libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev
sudo apt-get install libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev
sudo apt-get install valgrind xfslibs-dev
sudo apt-get install libnfs-dev libiscsi-dev
sudo apt-get install binwalk p7zip-full
sudo apt-get install qemu-utils adb
sudo apt-get install libusb-1.0-0-dev
sudo apt-get install git-email libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev valgrind xfslibs-dev libnfs-dev libiscsi-dev build-essential libepoxy-dev libdrm-dev libgbm-dev libx11-dev libvirglrenderer-dev libpulse-dev libsdl2-dev libgtk-3-dev

# adding user to kvm group, and setting udev rule
sudo adduser $USER kvm
sudo cp $git_dir/99-kvm.rules "/lib/udev/rules.d/"

# set udev rule for controller passthrough
sudo cp $git_dir/xinput.rules "/etc/udev/rules.d/"

# move over qemu src to home for easy access
cp -a $git_dir/qemu-sideswipe/ "/home/royalgraphx/"

cd $git_dir
chmod +x postinstall.sh
./postinstall.sh