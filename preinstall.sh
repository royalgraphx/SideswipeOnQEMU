#!/bin/bash

# set variables
git_dir=$HOME/Desktop/SideswipeOnQEMU

# install required dependencies
sudo apt-get update
sudo apt-get install --force-yes git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build git-email libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev valgrind xfslibs-dev libnfs-dev libiscsi-dev binwalk p7zip-full qemu-utils adb libusb-1.0-0-dev build-essential libepoxy-dev libdrm-dev libgbm-dev libx11-dev libvirglrenderer-dev libpulse-dev libsdl2-dev libgtk-3-dev

# adding user to kvm group, and setting udev rule
sudo adduser $USER kvm
sudo cp $git_dir/99-kvm.rules "/lib/udev/rules.d/"

# set udev rule for controller passthrough
sudo cp $git_dir/xinput.rules "/etc/udev/rules.d/"

# move over qemu src to home for easy access
cp -a $git_dir/qemu-sideswipe/ "$HOME"

cd $git_dir
chmod +x postinstall.sh
./postinstall.sh
