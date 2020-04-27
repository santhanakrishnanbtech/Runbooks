### Banner
```shell
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
yum -y install figlet
cat >> ~/.bashrc <<EOF
HOSTNAME=\$(hostname)
\$(figlet -w 150 -f slant \$HOSTNAME > /etc/motd)
ADDRESS=$(ip addr show | grep inet | grep "ens\|eth" | awk '{ print $2 }' | cut -d "/" -f -1)
DOMAIN=$(cat /etc/hosts | grep $ADDRESS | awk '{ print $3 }' | cut -d "." -f 2)
echo -en "\033[1;34mADDRESS :\033[0m $ADDRESS\t\033[1;34mDOMAIN :\033[0m $DOMAIN"
EOF
```
