#!/bin/bash
# mount the ISO to copy kernel and system image
isoname=/home/royalgraphx/Downloads/android_x86_64-a12_r27-03.04.22-01-mesa22-ksu-gapps-treble-libndk-sleep-sd-libva.iso
android_dir=/home/royalgraphx/Desktop/android-12

iso_mount=/tmp/iso
mkdir $iso_mount
sudo mount $isoname $iso_mount

mkdir "$android_dir"
cp $iso_mount/kernel $iso_mount/initrd.img "$android_dir"
cd "$android_dir"
# create disk image
qemu-img create -f raw android.img 14G
mkfs.ext4 android.img
mkdir /tmp/android
mount -o loop android.img /tmp/android
mkdir /tmp/android/data
7z x /tmp/iso/system.sfs -o/tmp/android

umount $iso_mount
umount /tmp/android
