#!/bin/bash

# fetch.sh

# Welcome to the ISO Section of the autodeploy script! Created by RoyalGraphX on Jan 14, 2023
# Automation for retrieval of BlissRom for use in sideswipe-vm/SideswipeOnQEMU.
# No harm intended on Mediafire, moving to a better hosting solution soon.
# ~ RoyalGraphX

curl -O "https://www.mediafire.com/file/g7qh0l4z6lqj6hk/Bliss-v11.13--OFFICIAL-20201113-1525_x86_64_k-k4.19.122-ax86-ga-rmi_m-20.1.0-llvm90_dgc-t3_gms_intelhd.iso/file"
grep -o 'http[s]*://download[^/][^\\]*' -m 1 file > url
sed 's/"           id="downloadButton"//g' url > url_strip
wget -nc "$(cat url_strip)"
echo Complete! Continuing ...
