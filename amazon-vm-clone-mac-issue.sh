#!/usr/bin/env bash

set -e -x -u

location="/etc/sysconfig/network-scripts"

cat > $location/ifcfg-eth0 << "EOF"
BOOTPROTO=none
DEVICE=eth0
HWADDR=00:0c:29:6b:8e:f6
NM_CONTROLLED=no
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
IPADDR=
PREFIX=24
DNS1=10.0.0.2
DNS2=8.8.8.8
DNS3=8.8.4.4
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
EOF

read -p "Enter the IP address : " IP
sudo sed -i 's/IPADDR=/IPADDR='$IP'/g' $location/ifcfg-eth0

oldmac=$(grep HWADDR "$location"/ifcfg-eth0|cut -c 8-)
newmac=$(ifconfig eth0|grep ether|awk '{print $2}')
sudo sed -i 's/HWADDR='$oldmac'/HWADDR='$newmac'/g' $location/ifcfg-eth0

rm -rf /etc/issue
cp /root/issue /etc/issue
sudo sed -i 's/ADDRESS      :/ADDRESS      : '$IP'/g' /etc/issue
sudo echo -e "\n" >> /etc/issue

sudo systemctl restart network
