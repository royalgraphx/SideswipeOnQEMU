# SideswipeOnQEMU
                 
                         Current Branch: bleeding_edge
                         Last Commit: 01/30/23 - 4:32:15 PM
                         Branch Description: Nightly Builds / Latest SRC

# How to use
## the simplest explanation just on the quicks, incase you wanna try latest src

```
git clone --recursive https://github.com/royalgraphx/SideswipeOnQEMU.git --branch bleeding_edge
cd SideswipeOnQEMU

either of these two:
./preinstall_arch.sh
./preinstall_debian.sh
```

# notes and future plans

this branch was made to quickly push changes made in my test env, i assume you know the ins and outs of how to use everything here in the repo, so whenever i make changes i will push them here, the standard master/release branch is mainly for a known good build that all works, some debugging here and there is always done that changes things, so to constantly rewrite the readme is a no go, thanks for checking the branch out !

you can ping me in the following server for help.

https://discord.gg/B4CRB2bnsg

Future Plans:
- All Controllers supported by default, removes need for configuring passthrough
- Custom Android built from Source, Move away from BlissOS 11.13
- vhost-user-gpu support
- Virtual Machine Manager XML/Import Support for easier managing of usb-passthrough
