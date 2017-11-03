#!/usr/bin/bash

# Download an official NetInstall release that we will customize
curl -o /tmp/CentOS-7-x86_64-NetInstall-1708.iso http://mirrors.gigenet.com/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-1708.iso

# Create directories
mkdir -p /tmp/loop
mkdir -p /tmp/remaster

# Mount the downloaded ISO as a file system
mount -o loop /tmp/CentOS-7-x86_64-NetInstall-1708.iso /tmp/loop

# Use rsync to copy
yum -y install rsync
rsync -av /tmp/loop/ /tmp/remaster/

# Unmount the ISO
umount /tmp/loop

# Copy in your custom menu that launches your custom kickstart by default
curl -o /tmp/remaster/isolinux/isolinux.cfg https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/kickstart/isolinux.cfg

# Create a custom ISO
yum -y install genisoimage
cd /tmp/remaster
genisoimage -l -r -J -V "CentOS-7-x86_64-CUSTOM" -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o /tmp/CentOS-7-x86_64-CUSTOM.iso .
ls -alF /tmp/CentOS-7-x86_64*
