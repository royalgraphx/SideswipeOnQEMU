#!/bin/bash

# Set Vars

sudo_user_home="$(echo /home/$SUDO_USER)"
qemu_sideswipe=$sudo_user_home/qemu-sideswipe/build/x86_64-softmmu
sideswipe_vm=$sudo_user_home/Desktop/sideswipe-vm

cd $qemu_sideswipe

./qemu-system-x86_64 -enable-kvm -cpu host -smp 4 \
-name "SideswipeOnQEMU" \
-drive file=$sideswipe_vm/android.img,format=raw,cache=none,if=virtio \
-m 4G \
-display sdl,gl=on,show-cursor=on \
-device virtio-vga,xres=1280,yres=720 \
-net nic,model=virtio-net-pci \
-net user,hostfwd=tcp::5555-:5555 \
-machine vmport=off \
-device virtio-tablet-pci \
-device virtio-keyboard-pci \
-device AC97 \
-machine q35 \
-kernel $sideswipe_vm/kernel -append "root=/dev/ram0 quiet GRALLOC=gbm video=1280x720 SRC=/" \
-initrd $sideswipe_vm/initrd.img \
-usb \
-device usb-host,vendorid=0x054c,productid=0x0ce6
