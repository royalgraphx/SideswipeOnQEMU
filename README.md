# SideswipeOnQEMU
Assortment of information, scripts, and data for running RL Sideswipe on QEMU 5.1.0 running Android


Getting started
===============

To get started with SideswipeOnQEMU, you'll need to clone the repository into a directory, preferably on Desktop.

To initialize your local repository using git, use the following coommand:
```
git clone --recursive https://github.com/royalgraphx/SideswipeOnQEMU.git
```

Make sure you download the following ISO and store it somewhere, again preferably in Downloads.

* [**BlissOS 11.13 Download**](https://sourceforge.net/projects/blissos-x86/files/Official/bleeding_edge/Generic%20builds%20-%20Pie/11.13/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso/download)

----------------

Configure Controller Passthrough
=================

Step 1.
The preinstall.sh contains code to move two files, but we need to modify xinput.rules to passthrough our controller correctly

```sh
  # Bus 001 Device 008: ID 054c:0ce6 Sony Corp. Wireless Controller
SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0666"
SUBSYSTEM=="usb_device", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0666"
```

It's already preconfigured to work right away with PS5 DualSense Controllers. To set this to yours, you'll run a command in
your terminal and use the ID 0000:0000 to fill in the vendor and product ID. Find your controller and take note of the ID.

```bash
# lsusb

Bus 001 Device 004: ID 0b05:1939 ASUSTek Computer, Inc. AURA LED Controller
Bus 001 Device 018: ID 054c:0ce6 Sony Corp. Wireless Controller  <--- This is what I want to passthrough
Bus 001 Device 002: ID 05ac:1392 Apple, Inc. Apple Watch charger
```

Step 2.
Change the launch.sh in /launch_scripts to use the controller
You have different ways of using the controller, heres what to replace, and an alternate line if it doesn't work
right away, often times the reboot is needed after running the first setup to get everything working perfectly.


```bash
-usb -device usb-ehci,id=ehci -device usb-host,bus=ehci.0,hostbus=1,hostport=4
```
Alternative Method using hardcoded values:

```bash
-usb -device usb-tablet,bus=usb-bus.0 -device usb-host,vendorid=0x054c,productid=0x0ce6
```
-----------------------------------------------------------------------------




Configure preinstall.sh
=================
There is one single variable, please replace the username to yours, or specify the specific path to the cloned repo folder.
```bash
git_dir=/home/royalgraphx/Desktop/SideswipeOnQEMU
```
-----------------------------------------------------------------------------




Configure postinstall.sh
=================
There are two variables to change, please replace the username to yours, or specify the specific path to the mentioned folder.
```bash
git_dir=/home/royalgraphx/Desktop/SideswipeOnQEMU
qemu_dir=/home/royalgraphx/qemu-sideswipe
```
-----------------------------------------------------------------------------



Configure install_scripts/android_install_qemu_sideswipe.sh
=================
There are several variables to change, please verify each of these carefully, you do not want this section to fail.
```sh
isoname=/home/royalgraphx/Downloads/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso
required_files=/home/royalgraphx/Desktop/SideswipeOnQEMU/required_files
launch_file=/home/royalgraphx/Desktop/SideswipeOnQEMU/launch_scripts
android_dir=/home/royalgraphx/Desktop/sideswipe-vm        <--- ONLY CHANGE USERNAME. UNLESS YOU FIX EVERYTHING ELSE TO REFERENCE A DIFFRENT ANDROID DIR
```

DO NOT MODIFY THESE
```red
iso_mount=/tmp/iso
system_mount=/tmp/system
```
-----------------------------------------------------------------------------



Configure launch_scripts/launch.sh
=================
There are several variables in the launch script, this is how you customize the VM. A breakdown of what can be configured is below. 

These changes are required to get the script to work.
```bash
cd /home/royalgraphx/qemu-sideswipe/build/x86_64-softmmu    <--- you should only have to change the username.
-smp 12       <--- How many threads you can assign, 8 cores 16 threads so I dedicated 12.
-drive file=/home/royalgraphx/Desktop/sideswipe-vm/android.img      <--- you should only have to change the username.
-m 25G        <--- This is the amount of RAM the VM will passthrough.
-device AC97  <--- this specifies audio, if not working, try -soundhw all
-kernel /home/royalgraphx/Desktop/sideswipe-vm/kernel      <--- should only change username.
-initrd /home/royalgraphx/Desktop/sideswipe-vm/initrd.img  <--- should only change username.
```

Set Resolution, just modify the values.
```bash
-device virtio-vga,xres=1920,yres=1080
"root=/dev/ram0 quiet GRALLOC=gbm video=1920x1080 SRC=/"
```
-----------------------------------------------------------------------------

First Run, Must Configure Mesa 21 GXP
=================
Currently we have a custom build of QEMU that is using VirGL as a display adapter, but our current build doesn't come with drivers
right away, and without doing this next step, it wouldn't boot at all. So please, make sure to remember to enter GearLock recovery
and install the Mesa package located in /system/ then make sure to do a full reboot. You can close the QEMU window, terminal to
sideswipe-vm and ./launch.sh inside of it to start the VM whenever you want.

<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock1.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock2.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock3.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock4.png?raw=true">
</div>

-----------------------------------------------------------------------------

Recommended way to install APK's
=================
The modified ramdisk allows us to start adb on the VM once we connect to VirtWifi.
Open Terminal from the installed apps in android and do the following:
<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/adb.png?raw=true">
</div>

You can now open a fresh terminal window on your linux host machine and do the following commands in the dir where the apk is at:
```bash
adb connect localhost:5555
adb install <apk file>
```

If you experience the following error about multiple devices, try this:
```bash
adb -s localhost:5555 install <apk file>
```
-----------------------------------------------------------------------------

PROFIT !
=================
<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/profit.png?raw=true">
</div>
-----------------------------------------------------------------------------
the changes made to qemu, system, and any other changes are specific to this repo.
i wish no redistribution takes place. the scripts work because everything is condensed and made
to work, the many workarounds and things I had to try for over a month to get this to work, was
incredibly laborious and i'd like everything to stay here. no forks, no implementation outside 
of this enviroment, its specifically made to improve the lifes of those seeking to play Sideswipe.
I have literally not tested any other games, if they work, great, but I broke things in order for
them to work in sideswipe, and who knows how that affect other games or whatever you try outside of
what I just mentioned above. thank you for attempting this if you did, and im here to help.

you can ping me in the following server.

https://discord.gg/4wTSynAZgM
