#!/usr/bin/env bash
set -e -u -x
uname -msr
sudo yum –y update
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum list available --disablerepo='*' --enablerepo=elrepo-kernel
sudo yum --enablerepo=elrepo-kernel install kernel-lt -y
#sudo vim /etc/default/grub
sudo -s -- <<EOF
sed -i 's/GRUB_DEFAULT=[^ ]*/GRUB_DEFAULT=0/g' /etc/default/grub
EOF
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
