#!/bin/sudo bash

# Vars

working="$(pwd)"

# Begin 

echo Escaped SideswipeOnQEMU Setup Stage! Entering sideswipe-vm...
echo Currently at:$working
chmod 777 -R .
chown $SUDO_USER:$SUDO_USER recovery.sh
chown $SUDO_USER:$SUDO_USER launch.sh
chown $SUDO_USER:$SUDO_USER system.img
chown $SUDO_USER:$SUDO_USER initrd.img
chown $SUDO_USER:$SUDO_USER ramdisk.img
chown $SUDO_USER:$SUDO_USER kernel
./recovery.sh
