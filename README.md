# SideswipeOnQEMU

Current Branch: wx86_64
                           
# Table of Contents!

- 
-
-

# Installing WSL2

# Cloning SideswipeOnQEMU

Welcome To WSL2!

To get started, you'll need to clone the repository into a directory, preferably on Desktop.
To do this, in WSL type out:

```
sudo apt-get update
sudo apt-get install git
mkdir $HOME/Desktop
cd $HOME/Desktop
git clone --recursive https://github.com/royalgraphx/SideswipeOnQEMU.git --branch wx86_64
cd SideswipeOnQEMU
```

Make sure you download the following ISO and store it in as its required to install Android

```
SideswipeOnQEMU/iso
```

* [**BlissOS 11.13 Download**](https://www.mediafire.com/file/g7qh0l4z6lqj6hk/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso/file)

You can do this by opening explorer and finding the Linux sidepanel option, then navigate to home/user/Desktop/SideswipeOnQEMU/iso

# Configure Controller Passthrough

lsusb example command output:
```bash
Bus 001 Device 006: ID 0b05:1939 ASUSTek Computer, Inc. AURA LED Controller
Bus 001 Device 004: ID 054c:0ce6 Sony Corp. Wireless Controller  <--- This is what I want to passthrough
Bus 001 Device 002: ID 05ac:1392 Apple, Inc. Apple Watch charger
```

My controller says ID 054c:0ce6 in lsusb, so

- Step 2.
Change the launch.sh in ``SideswipeOnQEMU/launch_scripts/launch.sh`` to use the controller

```bash
-usb -device usb-tablet,bus=usb-bus.0 -device usb-host,vendorid=0x054c,productid=0x0ce6
```

# Configure Android QEMU Install Script

```
SideswipeOnQEMU/install_scripts/android_install_qemu_sideswipe.sh
```

You can change the size of the Hard Disk for the Android VM ! Edit the following lines; 14GB is minimum.

```
# create disk image and move over everything
qemu-img create -f raw android.img 30G
```

for more advanced users, if for some reason you need a bigger system partition, thats changeable here
```
sudo truncate -s 5G system.img
```

# Configure Launch Script

```
SideswipeOnQEMU/launch_scripts/launch.sh
```

There are several variables in the launch script, this is how you customize the VM. A breakdown of what can be configured is below. 

Some changes are required to get the script to work, such as the amount of threads, and RAM to dedicate. It will fail if you don't have it correct.

```bash
-smp 4       <--- How many threads you can assign, I have 8 cores 16 threads so I dedicated 12.
-m 4G        <--- This is the amount of RAM the VM will passthrough.


-device AC97  <--- this specifies audio, if not working, try -soundhw all
```

- To Set Resolution, just modify the following values.
```bash
-device virtio-vga,xres=1920,yres=1080
"root=/dev/ram0 quiet GRALLOC=gbm video=1920x1080 SRC=/"
```

# First Run

You've made it! it seems as though you've now completed setting everything up, so lets get started!

Launch a terminal window inside of SideswipeOnQEMU directory, and proceed with the following command:

```
./preinstall.sh
```

This might take a while! it's going to extract the qemu src code and then build it, which takes a bit.
Once QEMU is built, the ISO is going to be expanded to retrieve files needed for the android.img that will
appear inside of sideswipe-vm on your desktop, thats your virtual hard disk that QEMU uses. Once it's complete
it'll autostart the android VM ! 


```
You must press escape when promted to enter recovery. when promted with this screen, choose option 2
```
<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock0.png?raw=true">
</div>

Currently we have a custom build of QEMU that is using VirGL as a display adapter, but our current build doesn't come with drivers
right away, and without doing this next step, it wouldn't boot at all. So please install the Mesa package located in /system/ 
then make sure to do a reboot.

<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock1.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock2.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock3.png?raw=true">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/GearLock4.png?raw=true">
</div>

Once that's done installing, press escape until you can see the reboot option. Use Arrow Key Right and Enter to select it.

You'll then reboot into Android!

# Setting up Wifi

By default, we use VirtWifi to passthrough connectivity to the VM, make sure to go to settings and connect to it!

<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/VirtWifi.png?raw=true">
</div>

# ADB To Install APKs

The modified ramdisk allows us to start adb on the VM once we connect to VirtWifi.
Open Terminal from the installed apps in android and do the following:
<div align="center">
<img src="https://github.com/royalgraphx/SideswipeOnQEMU/blob/main/img/adb.png?raw=true">
</div>

You can now open a fresh terminal window on your ***linux host machine*** and do the following commands in the dir where the apk is at:
```bash
adb connect localhost:5555
adb install <apk file>
```

If you experience the following error about multiple devices, try this:
```bash
adb -s localhost:5555 install <apk file>
```


# PROFIT

Season 4
<div align="center">
<img src="">
</div>

Season 5
<div align="center">
<img src="">
</div>

# QEMU Shortcuts

Please note that you must be in fullscreen mode for Touch Input to work correctly!

```
Ctrl + Alt + G = Lock Mouse In/Out VM
Ctrl + Alt + F = Fullscreen Toggle
```

# Starting the VM

simply run:
```
cd $HOME/Desktop/sideswipe-vm
./launch.sh
```

# Known Issues

Audio
```
```

Video
```
```

Touch
```
```

# Extra Goodies

# post notes and future plans

you can ping me in the following server.

https://discord.gg/B4CRB2bnsg

Future Plans:
-
-
-

