#!/bin/bash

# Vars

working="$(pwd)"
sudo_user_home="$(echo /home/$SUDO_USER)"
git_dir=$sudo_user_home/SideswipeOnQEMU
required_files=required_files
alt=$sudo_user_home/branches/SideswipeOnQEMU/required_files
install_dir=$sudo_user_home/Desktop/sideswipe-vm

# Begin

clear
cat $git_dir/$required_files/ssvm
echo
echo
echo Escaped SideswipeOnQEMU Setup Stage! Entering SSVM...
echo
echo Debug: 'Show Paths'
echo
echo Currently at: $working/
echo Sudo User: $SUDO_USER
echo Sudo User Home: $sudo_user_home/
echo Git Directory: $git_dir/
echo Install Directory: $install_dir/
echo

chmod 777 -R .
chown $SUDO_USER:$SUDO_USER android_ver
chown $SUDO_USER:$SUDO_USER data.img
chown $SUDO_USER:$SUDO_USER initrd.img
chown $SUDO_USER:$SUDO_USER kernel
chown $SUDO_USER:$SUDO_USER launch.sh
chown $SUDO_USER:$SUDO_USER ramdisk.img
chown $SUDO_USER:$SUDO_USER recovery.sh
chown $SUDO_USER:$SUDO_USER rl2d.img
chown $SUDO_USER:$SUDO_USER ssvm_smbios
chown $SUDO_USER:$SUDO_USER system.img

./recovery.sh
