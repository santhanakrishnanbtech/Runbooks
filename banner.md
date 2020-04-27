### Banner
```shell
$ rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
$ yum -y install figlet
$ cat >> ~/.bashrc <<EOF
HOSTNAME=$(hostname)
$(figlet -w 150 -f slant $HOSTNAME > /etc/motd)
EOF
```
