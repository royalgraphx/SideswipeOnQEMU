# testing testi- oh damn it works...

echo Success!

working="$(pwd)"
echo Escaped SideswipeOnQEMU Setup Stage! Entering sideswipe-vm...
echo Currently at:$working

chmod 777 -R .
chown $SUDO_USER:$SUDO_USER recovery.sh
chown $SUDO_USER:$SUDO_USER launch.sh
chown $SUDO_USER:$SUDO_USER android.img
chown $SUDO_USER:$SUDO_USER initrd.img
chown $SUDO_USER:$SUDO_USER kernel
chown $SUDO_USER:$SUDO_USER ramdisk.img
./recovery.sh
