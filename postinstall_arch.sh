#!/bin/bash

# set variables

git_dir="$(pwd)"
qemu_dir=$HOME/qemu-sideswipe

# build qemu

echo Building qemu-sideswipe...

cd $qemu_dir

mkdir build
cd build
../configure --enable-sdl --enable-opengl --enable-virglrenderer --enable-system --enable-modules --audio-drv-list=pa --target-list=x86_64-softmmu --enable-kvm --enable-gtk  --enable-libusb
make

# test build

./x86_64-softmmu/qemu-system-x86_64 --version
echo You should have gotten a VERSION result! - RoyalGraphX

# move onto the building of the vm

cd $git_dir
./sideswipe-vm-handler.sh
