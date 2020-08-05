#!/usr/bin/env bash
set -x -e

# login as root
# create mac.sh in /root/mac.sh
# chmod +x /root/mac.sh
# echo "@reboot root /bin/bash /root/mac.sh" >> /etc/crontab
# shutdown and start cloning
# when main machine restarted remember to write the crontab line

# changing network mac address
cd /etc/sysconfig/network-scripts/
oldmac=$(grep HWADDR ifcfg-eth0|cut -c 8-)
newmac=$(ifconfig eth0|grep ether|awk '{print $2}')
sudo sed -i 's/HWADDR='$oldmac'/HWADDR='$newmac'/g' ifcfg-eth0
sudo systemctl restart network

# removing the cron entry
cd
/bin/cat /etc/crontab | /bin/grep -v mac > /etc/crontab.tmp
/bin/rm -f /etc/crontab
/bin/mv /etc/crontab.tmp /etc/crontab

# changing the banner
rm -rf /etc/issue
cp /root/issue /etc/issue
IP=$(ifconfig eth0 | awk '/inet / {print $2}')
sudo sed -i 's/ADDRESS      :/ADDRESS      : '$IP'/g' /etc/issue
sudo echo -e "\n" >> /etc/issue
sudo reboot
#rm -f $0
