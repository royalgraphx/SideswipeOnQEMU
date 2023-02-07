#!/bin/bash
# Automation for retrieval of BlissRoms Bliss 11.13 ISO & Rocket League Sideswipe APK for use in SSVM/SideswipeOnQEMU.
# No harm intended on Mediafire, moving to a better hosting solution soon.
# ~ RoyalGraphX

# Vars

git_dir="$(pwd)"
sudo_user_home="$(echo /home/$SUDO_USER)"
android_workingdir=$git_dir/android
fetcher_workingdir=$git_dir/fetcher_env
required_files=$git_dir/required_files
ssvm_workingdir=$git_dir/ssvm
apks=$git_dir/apks

# Begin

clear
cat $required_files/fetch

echo
echo "Currently two versions of Android are supported, please make a selection."
echo "Enter the Version of Android to use:"
echo "Android (9), Android (12):"
read android_ver
echo "$android_ver" >> "$ssvm_workingdir/android_ver"

echo
if [[ $android_ver =~ (9) ]]; then
echo "Fetching Android 9"
cd $fetcher_workingdir
curl -O "https://www.mediafire.com/file/g7qh0l4z6lqj6hk/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso/file"
grep -o 'http[s]*://download[^/][^\\]*' -m 1 file > url
sed 's/"           id="downloadButton"//g' url > url_strip
wget -nc "$(cat url_strip)"
rm -rf url
rm -rf file
rm -rf url_strip
fi


if [[ $android_ver =~ (12) ]]; then
echo "Fetching Android 12"
cd $fetcher_workingdir
curl -O "https://www.mediafire.com/file/6z9hnojqf3xh1oi/Bliss-v15.8.4-x86_64-OFFICIAL-foss-20230201.iso/file"
grep -o 'http[s]*://download[^/][^\\]*' -m 1 file > url
sed 's/"           id="downloadButton"//g' url > url_strip
wget -nc "$(cat url_strip)"
rm -rf url
rm -rf file
rm -rf url_strip
fi
echo
echo Complete! Continuing ...

echo Fetching Sideswipe APK ...
echo
cd $apks
curl -O "https://www.mediafire.com/file/wh5jxvukwufauol/RL2D.apk/file"
grep -o 'http[s]*://download[^/][^\\]*' -m 1 file > url
sed 's/"           id="downloadButton"//g' url > url_strip
wget -nc "$(cat url_strip)"
rm -rf url
rm -rf file
rm -rf url_strip
echo
echo Complete! Continuing ...
echo
echo "APK's haven't been packaged yet! Take a moment to add any in:" $apks/
echo Feel free to exit this script now and do so...
echo
sleep 8

cd $git_dir
./ssvm_configurator.sh