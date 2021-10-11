#! /usr/bin/env bash

set -e


install_5_8_system(){
    apt update 

    dkms remove sgx/1.41 --all
    rm -rf /var/lib/dpkg/lock*
    rm -rf /var/cache/apt/archives/lock 
    apt dist-upgrade --fix-missing -y

    apt install -y linux-headers-5.8.0-59-generic linux-image-5.8.0-59-generic
}


fixed_system_version(){

cp -f /etc/default/grub /etc/default/grub.bak
cat >/etc/default/grub <<EOF
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.8.0-59-generic"
#GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console
EOF
}

install_5_8_system
fixed_system_version

apt autoremove -y 
update-grub

reboot