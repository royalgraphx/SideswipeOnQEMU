#!/bin/bash

# Clean up handoff

rm -rf chain.sh

# Set Vars

sudo_user_home="$(echo /home/$SUDO_USER)"
qemu_sideswipe=$sudo_user_home/qemu-sideswipe/build/x86_64-softmmu
git_dir=$sudo_user_home/SideswipeOnQEMU
required_files=required_files
alt=$sudo_user_home/branches/SideswipeOnQEMU/required_files
ssvm=$sudo_user_home/Desktop/SSVM
uuid="$(uuidgen)"

# Begin

# Debug

clear
echo
cat recovery
echo
echo
echo Welcome to SSVM Recovery! This is used in first launch.
echo
echo Debug: 'Show Paths'
echo Sudo User: $SUDO_USER
echo Sudo User Home: $sudo_user_home
echo SSVM Directory: $ssvm
echo qemu-sideswipe Directory: $qemu_sideswipe
echo Current Generated UUID: $uuid
echo

# Debug

cd $qemu_sideswipe

./qemu-system-x86_64 -enable-kvm -cpu host,svm,vme,migratable=off,check=false,hypervisor=false,topoext -smp sockets=1,cores=VM_CORE_COUNT,threads=2  \
-name "SideswipeOnQEMU" \
-smbios file=$ssvm/ssvm_smbios \
-uuid $uuid \
-device AC97 \
-m VM_RAMG \
-usb \
-display sdl,gl=on,show-cursor=on \
-device virtio-vga,xres=VM_HEIGHTRES,yres=VM_WIDTHRES \
-machine q35,vmport=off \
-device virtio-tablet-pci \
-device virtio-keyboard-pci \
-serial mon:stdio \
-device usb-host,vendorid=0xCONT_VENID,productid=0xCONT_PRODID \
-device usb-storage,drive=rl2d \
-drive file=$ssvm/rl2d.img,id=rl2d,format=raw,if=none \
-drive index=0,if=virtio,id=system,file=$ssvm/system.img,format=raw,cache=writeback \
-drive index=1,if=virtio,id=ramdisk,file=$ssvm/ramdisk.img,format=raw,cache=writeback \
-drive index=2,if=virtio,id=data,file=$ssvm/data.img,format=raw,cache=writeback \
-initrd $ssvm/initrd.img \
-kernel $ssvm/kernel \
-append "root=/dev/ram0 console=ttyS0 androidboot.selinux=permissive cpufreq.default_governor=performance cpuidle.governor=performance RAMDISK=vdb DATA=vdc" \