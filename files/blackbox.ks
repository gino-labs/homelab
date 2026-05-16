# Command Section
bootloader --location=mbr
cdrom
clearpart --drives=nvme0n1
text
eula --agreed
firewall --user-system-defaults
reboot
ignoredisk --only-use=nvme0n1
keyboard --vckeymap=us --xlayouts='us'
lang en_US.UTF-8
network --bootproto=dhcp --device=eno1
network --bootproto=static --device=br0\
    --ip=172.18.83.1 \
    --netmask=255.255.255.0 \
    --hostname=blackbox.home.arpa \
    --bridgeslaves=enp1s0,enp7s0,enp8s0 \
    --onboot=yes \
    --activate

part --ondisk=nvme0n1 --fstype=esp --label=BB_EFI --recommended /boot/efi
part --ondisk=nvme0n1 --fstype=xfs --label=BB_BOOT --recommended /boot
part --ondisk=nvme0n1 --fstype=lvmpv --grow pv.1
volgroup bb pv.1
logvol / --fstype=xfs --vgname=bb --name=root --grow --percent=50 
logvol /home --fstype=xfs --vgname=bb --name=home --grow --percent=12 
logvol /var --fstype=xfs --vgname=bb --name=var --grow --percent=12 
logvol /tmp --fstype=xfs --vgname=bb --name=tmp --grow --percent=3 
logvol /var/log --fstype=xfs --vgname=bb --name=log --grow --percent=5 
logvol swap --fstype=swap --vgname=bb --name=swap --size=8192

rootpw --iscrypted $6$fdkJXqP4ClBQPyhI$xYE6CodfD6ltHMFVzaGtKid3QOe6cIjl7fTzIKFCEctcc5EZWTFNCgUBZbgAFh6GHDQlJbVbGA/4ZMn3vbwFo0
selinux --enforcing
skipx

# repo --install (EPEL, Ookla speedtest)
# sshkey
# syspurpose
# timesource
# timezone
# user
zerombr

%packages
@^minimal-environment

%post --erroronfail --interpreter=/usr/bin/python3 --log=/root/ks.log

###

%end