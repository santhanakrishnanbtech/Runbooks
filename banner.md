### Banner
```shell
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
yum -y install figlet
cat >> ~/.bashrc <<EOF
HOSTNAME=\$(hostname)
echo 
\$(figlet -w 150 -f slant "    \$HOSTNAME" > /etc/motd)
ADDRESS=\$(ip addr show | grep inet | grep "ens\|eth" | awk '{ print \$2 }' | cut -d "/" -f -1)
DOMAIN=\$(grep \$ADDRESS /etc/hosts | awk '{ print \$3 }' | cut -d "." -f 2)
echo -en "\n\033[1;34m ADDRESS :\033[0m \$ADDRESS \t \033[1;34m DOMAIN :\033[0m \$DOMAIN\n" >> /etc/motd
EOF
```
