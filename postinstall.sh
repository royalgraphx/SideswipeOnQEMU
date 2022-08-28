#!/bin/bash

# set variables

git_dir=/home/royalgraphx/Desktop/SideswipeOnQEMU
qemu_dir=/home/royalgraphx/qemu-sideswipe

# build qemu
echo welcome to part 2 of the script!
echo building qemu...

cd $qemu_dir
mkdir build
cd build
../configure --enable-sdl --enable-opengl --enable-virglrenderer --enable-system --enable-modules --audio-drv-list=pa --target-list=x86_64-softmmu --enable-kvm --enable-gtk  --enable-libusb
make

# test build
./x86_64-softmmu/qemu-system-x86_64 --version
echo you better have gotten a result! - RoyalGraphX

# move onto the building of the vm
cd $git_dir
cd install_scripts
sudo ./android_install_qemu_sideswipe.sh
