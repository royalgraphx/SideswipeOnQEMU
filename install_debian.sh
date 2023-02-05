#!/bin/bash

# set variables
git_dir="$(pwd)"
ssqemu_dir=$HOME/qemu-sideswipe
required_files=$git_dir/required_files

clear
cat $required_files/ssonqm
echo
echo
echo Welcome to SideswipeOnQEMU! Thanks for installing.
echo Debian based install selected, installing dependencies via APT ...
echo
echo "!! WARNING !! Debian Based Installs are known to perform slower than their Arch counterpart. Please consider switching..."
echo
sleep 3

sudo apt-get update
sudo apt-get install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build git-email libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev valgrind xfslibs-dev libnfs-dev libiscsi-dev binwalk p7zip-full qemu-utils adb libusb-1.0-0-dev build-essential libepoxy-dev libdrm-dev libgbm-dev libx11-dev libvirglrenderer-dev libpulse-dev libsdl2-dev libgtk-3-dev
sudo adduser $USER kvm
sudo cp $git_dir/rules/99-kvm.rules "/lib/udev/rules.d/"
sudo cp $git_dir/rules/xinput.rules "/etc/udev/rules.d/"

echo
echo Would you like to build qemu-sideswipe locally?
echo "Yes is default. Override? (y/N)": && read build_local
 
if [[ $build_local =~ (y) ]]; then
echo
echo Fetching prebuilt qemu-sideswipe ...
echo Exception: Not implemented yet! Testing if exists ...
echo 
if [ -d "$ssqemu_dir" ]; then
    echo "$ssqemu_dir does exist. Updating ..."
    sleep 2
    cd $ssqemu_dir
    cd build
    echo
    ./x86_64-softmmu/qemu-system-x86_64 --version
    echo "if you didn't get a result, This was the place an error occured."
    echo
    sleep 3
fi
if [ ! -d "$ssqemu_dir" ]; then
    echo "$ssqemu_dir does NOT exist ..."
    echo "Please allow qemu-sideswipe to build locally."
    echo "Exiting ..."
    sleep 3
    exit
fi
else
echo Fetching Source...
git clone --recursive https://github.com/royalgraphx/qemu-sideswipe.git
cp -a $git_dir/qemu-sideswipe/ "$HOME"
cd $ssqemu_dir
echo Building qemu-sideswipe locally ...
mkdir build
cd build
../configure --enable-sdl --enable-opengl --enable-virglrenderer --enable-system --enable-modules --audio-drv-list=pa --target-list=x86_64-softmmu --enable-kvm --enable-gtk  --enable-libusb
make -j$(nproc)
echo Testing executable...
./x86_64-softmmu/qemu-system-x86_64 --version
echo "if you didn't get a result, This was the place an error occured."
fi

sleep 5
cd $git_dir
./fetch.sh