#!/bin/bash

# set up variables
isoname=/home/royalgraphx/Downloads/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso
required_files=/home/royalgraphx/Desktop/SideswipeOnQEMU/required_files
launch_file=/home/royalgraphx/Desktop/SideswipeOnQEMU/launch_scripts
android_dir=/home/royalgraphx/Desktop/sideswipe-vm
iso_mount=/tmp/iso
system_mount=/tmp/system

# mount the ISO to copy kernel and system image
mkdir $iso_mount
sudo mount $isoname $iso_mount

mkdir "$android_dir"
cp $iso_mount/kernel $iso_mount/initrd.img $iso_mount/ramdisk.img "$android_dir"
cd "$android_dir"


# create disk image and move over everything
qemu-img create -f raw android.img 30G
mkfs.ext4 android.img
mkdir /tmp/android
mount -o loop android.img /tmp/android
mkdir /tmp/android/data
cp $required_files/ramdisk.img "/tmp/android/"
cp $iso_mount/gearlock "/tmp/android/"
7z x /tmp/iso/system.sfs -o/tmp/android
umount $iso_mount

# move over that gxp file to fix graphics

mkdir $system_mount
cd /tmp/android
sudo truncate -s 5G system.img
sudo resize2fs system.img
sudo mount -o ro,norecovery,rw system.img /tmp/system
cp $required_files/Mesa21.3__Android_9.0_..gxp "$system_mount"
cp $required_files/QEMU_Virtio_Tablet.idc "$system_mount/usr/idc/"
cp $required_files/aida64.apk "$system_mount"
cp $required_files/AlsaMixer.apk "$system_mount"
cd ..

# clean up & add launch file

cd $android_dir
sudo cp $launch_file/launch.sh "$android_dir"
sudo cp $launch_file/chain.sh "$android_dir"
chmod +x launch.sh
chmod +x chain.sh

umount /tmp/system
umount /tmp/android

## launch the vm !

cd $android_dir
./chain.sh
