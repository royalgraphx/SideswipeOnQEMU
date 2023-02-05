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
echo Arch based install selected, installing dependencies via pacman ...
echo
sleep 3

sudo pacman -Syu
sudo pacman -S --needed git glib2 dtc pixman zlib ninja libaio bluez-libs capstone brltty bzip2 libcap-ng libcurl-gnutls gtk3 libjpeg-turbo ncurses numactl libsasl sdl2 libseccomp snappy libssh libusb vte3 lzo valgrind libnfs libiscsi binwalk p7zip qemu-tools android-tools base-devel libepoxy libdrm mesa libx11 virglrenderer libpulse qemu
sudo usermod -a -G kvm,libvirt $(whoami)
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

sleep 3
cd $git_dir
./fetch.sh