#!/bin/bash

# set variables
git_dir=$HOME/Desktop/SideswipeOnQEMU

# install required dependencies
sudo pacman -Syu

sudo pacman -S git glib2 dtc pixman zlib ninja libaio bluez-libs capstone brltty bzip2 libcap-ng libcurl-gnutls gtk3 libjpeg-turbo ncurses numactl libsasl sdl2 libseccomp snappy libssh libusb vte3 lzo valgrind libnfs libiscsi binwalk p7zip qemu-tools android-tools base-devel libepoxy libdrm mesa libx11 virglrenderer libpulse qemu-desktop

# adding user to kvm group, and setting udev rule
sudo usermod -a -G kvm,libvirt $(whoami)
sudo cp $git_dir/99-kvm.rules "/lib/udev/rules.d/"

# set udev rule for controller passthrough
sudo cp $git_dir/xinput.rules "/etc/udev/rules.d/"

# move over qemu src to home for easy access
cp -a $git_dir/qemu-sideswipe/ "$HOME"

cd $git_dir
chmod +x postinstall.sh
./postinstall.sh
