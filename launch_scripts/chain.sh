# testing testi- oh damn it works...

echo Success! Press Escape when prompted to enter recovery!
echo Make sure you install Mesa GXP, located in /system/Mesa...gxp

working="$(pwd)"

echo Currently at:$working

chmod 777 -R .
chown $SUDO_USER:$SUDO_USER firstlaunch.sh
./firstlaunch.sh
