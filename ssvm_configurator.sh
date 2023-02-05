#!/bin/bash

# Vars

git_dir="$(pwd)"
con_env=$git_dir/config_env
sudo_user_home="$(echo /home/$SUDO_USER)"
android_workingdir=$git_dir/android
fetcher_workingdir=$git_dir/fetcher_env
required_files=$git_dir/required_files
ssvm_workingdir=$git_dir/ssvm
apks=$git_dir/apks

# Begin

clear
cat $required_files/ssvm_configurator
echo
echo
echo Welcome to the SSVM Configurator!
echo This section will create a custom launch.sh quickly!
echo This autoruns as apart of install and will return after completion!
echo No values can be left empty! If question isnt applicable, you must correct it manually later.
echo Version 2.0.0
echo
sleep 3


clear
echo Controller Section:
echo Please have controller connected prior to running script.
echo
sleep 1
echo Now printing all connected USB Devices:
echo
echo 3..
sleep 1
echo 2..
sleep 1
echo 1..
sleep 1
clear
echo "$(lsusb -v 2>/dev/null | grep '^Bus\|iSerial')"
echo
echo Enter the Vendor ID of the controller you want to use:
read vendor_id
echo
echo Enter the Product ID of the controller you want to use:
read product_id
echo
echo Entered device is: $vendor_id:$product_id
echo
sleep 3
clear



echo VM Resolution Section:
echo Corrects VM Display/Touch to native display resolution.
echo
echo Manually entering Height and Width resolution:
echo
echo Enter the Height for the display:
echo
read vm_height
echo
echo Enter the Width for display:
echo
read vm_width
echo
echo Selected VM resolution is: "$(echo $vm_height)"x$vm_width
echo
sleep 2
clear


echo VM Topology Section:
echo Maximize the power of the VM by automatically setting topology detected.
echo
echo Detected CPU Max Cores:
echo "$(nproc)"
# Calculation
host_cpu="$(nproc)"
threads=2
host_core_count=$((host_cpu / threads))
#
sleep 1
echo
echo Using Calculated CPU Topology:
echo 1 Socket, $host_core_count Cores, 2 Threads
echo
sleep 3
clear


echo VM RAM Section:
echo Set RAM amount.
echo
echo "$(cat /proc/meminfo | head -n 3 | numfmt --field 2 --from-unit=Ki --to=iec | sed 's/ kB//g')"
echo
echo Enter amount in GB:
read vm_ram
echo
sleep 2
clear

launch_temp=$con_env/launch_temp.sh
recovery_temp=$con_env/recovery_temp.sh
launch=$con_env/launch.sh
recovery=$con_env/recovery.sh

clear
echo Thanks for using the SSVM Configurator!
echo
echo Here are your custom settings:
echo
cpu_vendor="$(cat /proc/cpuinfo)"
if [[ $cpu_vendor =~ (GenuineIntel) ]]; then
echo Host CPU: GenuineIntel, Removing topoext flag.
else
echo Host CPU: AuthenticAMD, Keeping topoext flag.
fi
echo VM Topology: 1 Socket, $host_core_count Cores, 2 Threads
echo VM Resolution: "$(echo $vm_height)"x$vm_width
echo VM RAM Amount: $vm_ram
echo Controller Passthrough Config: USB Device $vendor_id:$product_id
echo
echo Writing to file...
echo

sed 's/VM_CORE_COUNT/'$(echo $host_core_count)'/g' $recovery_temp > $con_env/recovery.sh
sed -i 's/VM_HEIGHTRES/'$(echo $vm_height)'/g' $recovery
sed -i 's/VM_WIDTHRES/'$(echo $vm_width)'/g' $recovery
sed -i 's/VM_RAM/'$(echo $vm_ram)'/g' $recovery
sed -i 's/CONT_VENID/'$(echo $vendor_id)'/g' $recovery
sed -i 's/CONT_PRODID/'$(echo $product_id)'/g' $recovery
if [[ $cpu_vendor =~ (GenuineIntel) ]]; then
sed -i 's/,topoext//g' $launch
fi

cp -R $recovery $ssvm_workingdir/

echo recovery.sh written

sed 's/VM_CORE_COUNT/'$(echo $host_core_count)'/g' $launch_temp > $con_env/launch.sh
sed -i 's/VM_HEIGHTRES/'$(echo $vm_height)'/g' $launch
sed -i 's/VM_WIDTHRES/'$(echo $vm_width)'/g' $launch
sed -i 's/VM_RAM/'$(echo $vm_ram)'/g' $launch
sed -i 's/CONT_VENID/'$(echo $vendor_id)'/g' $launch
sed -i 's/CONT_PRODID/'$(echo $product_id)'/g' $launch
if [[ $cpu_vendor =~ (GenuineIntel) ]]; then
sed -i 's/,topoext//g' $launch
fi

cp -R $launch $ssvm_workingdir/

echo launch.sh written
echo
echo Complete! Continuing ...
sleep 2
clear

cd $git_dir
./ssvm_imager.sh