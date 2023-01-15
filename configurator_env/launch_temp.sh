#!/bin/bash

# Set Vars

qemu_sideswipe=$HOME/qemu-sideswipe/build/x86_64-softmmu
sideswipe_vm=$HOME/Desktop/sideswipe-vm

cd $qemu_sideswipe

./qemu-system-x86_64 -enable-kvm -cpu host,topoext -smp sockets=1,cores=VM_CORE_COUNT,threads=2 \
-name "SideswipeOnQEMU" \
-drive file=$sideswipe_vm/android.img,format=raw,cache=writeback,if=virtio \
-m VM_RAMG \
-display sdl,gl=on,show-cursor=on \
-device virtio-vga,xres=VM_HEIGHTRES,yres=VM_WIDTHRES \
-net nic,model=virtio-net-pci \
-net user,hostfwd=tcp::5555-:5555 \
-machine vmport=off \
-device virtio-tablet-pci \
-device virtio-keyboard-pci \
-device AC97 \
-machine q35 \
-kernel $sideswipe_vm/kernel -append "root=/dev/ram0 quiet GRALLOC=gbm video=VM_HEIGHTRESxVM_WIDTHRES SRC=/" \
-initrd $sideswipe_vm/initrd.img \
-usb \
-device usb-host,vendorid=0xCONT_VENID,productid=0xCONT_PRODID
