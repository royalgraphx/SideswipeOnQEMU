#!/bin/sudo bash

# Vars

git_dir="$(pwd)"
sudo_user_home="$(echo /home/$SUDO_USER)"
android_workingdir=$git_dir/android
fetcher_workingdir=$git_dir/fetcher_env
required_files=$git_dir/required_files
ssvm_workingdir=$git_dir/ssvm
apks=$git_dir/apks
android_ver=$(cat "$ssvm_workingdir/android_ver")
a9iso="$fetcher_workingdir/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso"
a12iso="$fetcher_workingdir/Bliss-v15.8.4-x86_64-OFFICIAL-foss-20230201.iso"
qemu_dir=$sudo_user_home/qemu-sideswipe
iso_mount=/tmp/iso
system_mount=/tmp/system
rl2d_mount=/tmp/rl2d
mesa=$git_dir/mesa

# Begin

clear
cat $required_files/ssvm_imager
echo
echo
echo Welcome to SSVM Imager section!
echo Building SSVM ...
echo Detected Configured Android Version: $android_ver
echo

sleep 3

if [[ $android_ver =~ (9) ]]; then
echo For debugging reasons, the found paths will now be printed.
echo
echo This is the current Git directory: $git_dir
echo This is the qemu-sideswipe directory: $qemu_dir
echo This is the ISO Path: $a9iso
echo This is the Required Files Path: $required_files
echo This is the SSVM directory: $ssvm_workingdir
echo This is the current android working directory: $android_workingdir
echo This is the tmp iso mount path: $iso_mount
echo This is the sys path: $system_mount
echo

# Mount the ISO to pull required files

mkdir $iso_mount
sudo mount -o ro,rw  $a9iso $iso_mount
cp $iso_mount/kernel $iso_mount/initrd.img $iso_mount/ramdisk.img "$ssvm_workingdir"
cp $iso_mount/system.sfs "$android_workingdir"
sudo umount $iso_mount

# Convert sfs to img
cd $android_workingdir
7z x system.sfs system.img
cd $git_dir
mv $android_workingdir/system.img $ssvm_workingdir
rm -rf $android_workingdir/system.sfs

# Patch Android 9 System
mkdir $system_mount
sudo mount -o ro,rw $ssvm_workingdir/system.img $system_mount
cp $required_files/QEMU_Virtio_Tablet.idc "$system_mount/usr/idc/"
echo $system_mount/user/idc - Modified Successfully!
cp -r $mesa/system/lib/* "$system_mount/lib"
echo $system_mount/lib - Modified Successfully!
cp -r $mesa/system/lib64/* "$system_mount/lib64"
echo $system_mount/lib64 - Modified Successfully!
cp -r $mesa/system/vendor/* "$system_mount/vendor"
echo $system_mount/vendor - Modified Successfully!
sudo umount $system_mount

# Create Data image
qemu-img create -f raw $ssvm_workingdir/data.img 20G
mkfs.ext4 $ssvm_workingdir/data.img
fi

if [[ $android_ver =~ (12) ]]; then
echo For debugging reasons, the found paths will now be printed.
echo
echo This is the current Git directory: $git_dir
echo This is the qemu-sideswipe directory: $qemu_dir
echo This is the ISO Path: $a12iso
echo This is the Required Files Path: $required_files
echo This is the SSVM directory: $ssvm_workingdir
echo This is the current android working directory: $android_workingdir
echo This is the tmp iso mount path: $iso_mount
echo This is the sys path: $system_mount
echo

# Mount the ISO to pull required files

mkdir $iso_mount
sudo mount -o ro,rw  $a12iso $iso_mount
cp $iso_mount/kernel $iso_mount/initrd.img "$ssvm_workingdir"
cp $iso_mount/system.sfs "$android_workingdir"
sudo umount $iso_mount

# Convert sfs to img
cd $android_workingdir
7z x system.sfs system.img
cd $git_dir
mv $android_workingdir/system.img $ssvm_workingdir
rm -rf $android_workingdir/system.sfs

# Patch Android 12 System
mkdir $system_mount
sudo mount -o ro,rw $ssvm_workingdir/system.img $system_mount
cp $required_files/QEMU_Virtio_Tablet.idc "$system_mount/usr/idc/"
sudo umount $system_mount

# Create Data image
qemu-img create -f raw $ssvm_workingdir/data.img 20G
mkfs.ext4 $ssvm_workingdir/data.img
fi

# Copy SMBIOS Information to SSVM

cp $required_files/ssvm_smbios $ssvm_workingdir

echo
echo Complete! Continuing ...
echo
echo "Packaging contents of: $apks"
echo "Current default size is (4GB), leaving 3GB free for your own APKs."
echo

# Create rl2d.img to hold files in /apks

sudo qemu-img create -f raw $ssvm_workingdir/rl2d.img 2G
sudo mkfs.vfat $ssvm_workingdir/rl2d.img
mkdir $rl2d_mount
echo "Mounting ..."
sudo mount -o rw $ssvm_workingdir/rl2d.img $rl2d_mount
sudo cp -a $apks/* $rl2d_mount/.
sudo umount $rl2d_mount

echo
echo Complete! Continuing ...

cd $git_dir
./ssvm_installer.sh