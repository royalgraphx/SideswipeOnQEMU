cd $HOME/qemu-sideswipe/build/x86_64-softmmu

./qemu-system-x86_64 -enable-kvm -cpu host,topoext -smp sockets=1,cores=8,threads=2 \
-drive file=$HOME/Desktop/sideswipe-vm/android.img,format=raw,cache=writeback,if=virtio \
-m 28G \
-usb \
-device usb-tablet,bus=usb-bus.0 \
-device usb-host,vendorid=0x054c,productid=0x0ce6 \
-display sdl,gl=on,show-cursor=on \
-device virtio-vga,xres=1920,yres=1080 \
-net nic,model=virtio-net-pci \
-net user,hostfwd=tcp::5555-:5555 \
-machine vmport=off \
-device virtio-tablet-pci \
-device virtio-keyboard-pci \
-soundhw all \
-machine q35 \
-kernel $HOME/Desktop/sideswipe-vm/kernel -append "root=/dev/ram0 quiet GRALLOC=gbm video=1920x1080 SRC=/" \
-initrd $HOME/Desktop/sideswipe-vm/initrd.img
