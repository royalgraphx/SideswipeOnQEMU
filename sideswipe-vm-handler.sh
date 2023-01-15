#!/bin/bash

# set variables

sudo_user_home="$(echo /home/$SUDO_USER)"
git_dir="$(pwd)"
qemu_dir=$sudo_user_home/qemu-sideswipe
isoname=$git_dir/iso/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso
required_files=$git_dir/required_files
launch_file=$git_dir/launch_scripts
android_dir=$sudo_user_home/Desktop/sideswipe-vm
iso_mount=/tmp/iso
system_mount=/tmp/system


# DEBUG version only

echo Welcome to the SideswipeOnQEMU sideswipe-vm Handler!
echo For debugging reasons, the found paths will now be printed.
echo
echo This is the current Git directory: $git_dir
echo This is the qemu-sideswipe directory: $qemu_dir
echo This is the ISO Path: $isoname
echo This is the Required Files Path: $required_files
echo This is the Launch Scripts location: $launch_file
echo This is the sideswipe-vm directory: $android_dir
echo This is the tmp path: $iso_mount
echo This is the sys path: $system_mount
echo

# exit

# First, we'll run fetch.sh to retreive the isoname

cd iso/
chmod +x fetch.sh
./fetch.sh
cd ..

# Begin VM Creation

# Mount the ISO to copy Kernel and System image

mkdir $iso_mount
sudo mount $isoname $iso_mount

# Create sideswipe-vm folder on Desktop for user.

mkdir "$android_dir"

# Copy over files

cp $iso_mount/kernel $iso_mount/initrd.img $iso_mount/ramdisk.img "$android_dir"

# Create Disk Image and move over everything

cd "$android_dir"

qemu-img create -f raw android.img 30G
mkfs.ext4 android.img

mkdir /tmp/android
mount -o loop android.img /tmp/android

mkdir /tmp/android/data
cp $required_files/ramdisk.img "/tmp/android/"
cp $iso_mount/gearlock "/tmp/android/"

7z x /tmp/iso/system.sfs -o/tmp/android

umount $iso_mount

# Move over files required by Gearlock Recovery for MESA drivers

mkdir $system_mount

cd /tmp/android
sudo truncate -s 5G system.img
sudo resize2fs system.img
sudo mount -o ro,norecovery,rw system.img /tmp/system

cp $required_files/Mesa21.3__Android_9.0_..gxp "$system_mount"
cp $required_files/QEMU_Virtio_Tablet.idc "$system_mount/usr/idc/"
cp $required_files/aida64.apk "$system_mount"

cd ..

# Cleanup & Add launch.sh file to start the VM

cd $android_dir

sudo cp $launch_file/recovery.sh "$android_dir"
sudo cp $launch_file/launch.sh "$android_dir"
sudo cp $launch_file/chain.sh "$android_dir"

chmod +x launch.sh
chmod +x chain.sh

umount /tmp/system
umount /tmp/android


# call on ssvmdeadlockd to patch mesa on the fly
cd $git_dir
sudo ./sideswipe-vm-deadlockd.sh

## Handoff & Launch VM !

cd $android_dir
./chain.sh

# We're now out of the SideswipeOnQEMU and qemu-sideswipe folder. Final Product is now on Desktop.
