# Install OS instead of upgrade
install
eula --agreed
firstboot --disable

# System authorization information
auth --enableshadow --passalgo=sha512

# Root password
rootpw --iscrypted $6$5LJqIN.y2PbMrY5e$6kugMUNV7i3Fl8OA1DNXXM9hY6JDVR/VJBQAuTQlkDqP8zYpEuEIS.z8ZDPUEnLiYB0W/bakJy0WmYGaHm/Eg1

# System language
lang en_US.UTF-8

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'

# System timezone
timezone Etc/GMT --isUtc --nontp

# System services
#services --disabled="chronyd"
selinux --disabled
firewall --disabled
services --enabled=NetworkManager,sshd

# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
zerombr

# Partition clearing information
ignoredisk --only-use=sda
clearpart --all --initlabel

# Disk partitioning information
part swap --fstype="swap" --ondisk=sda --size=2048
part /boot --fstype="xfs" --ondisk=sda --size=1024 --label=boot
part pv.01 --fstype="lvmpv" --ondisk=sda --size=17407 --grow
volgroup centos --pesize=4096 pv.01
logvol /  --fstype="xfs" --size=17404 --label="root" --name=root --vgname=centos

# Network information
network  --bootproto=dhcp --device=eth0 --onboot=on --ipv6=auto
network  --hostname=localhost.localdomain

# Use network installation
url --url="http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/"
# Repo
repo --name=base --baseurl=http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/

# Software packages to install
%packages
@^minimal
@core
#kexec-tools
# Use eth0 naming
-biosdevname
%end

# Add-ons for Anaconda which expand the functionality of the installer
#%addon com_redhat_kdump --enable --reserve-mb='auto'
#%end

# Reboot after installation
reboot
