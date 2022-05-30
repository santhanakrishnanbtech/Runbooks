# set static ip to ubuntu server
#!/usr/bin/env bash

# variables
IP_ADDRESSES=$(ip r | grep kernel | awk '{print $9}')
IP_GATEWAY=$(ip r | grep default | awk '{print $3}')
IP_DEVICE=$(ip r | grep kernel | awk '{print $3}')

# Write to server
configure() {
  cat <<EOF > ./netplan.yml #/etc/netplan/00-installer-config.yaml
network:
    version: 2
    ethernets:
        id0:
            match:
                name: $IP_DEVICE
            dhcp4: false
            addresses:
                - $IP_ADDRESSES
            gateway4: $IP_GATEWAY
EOF
}
# Function invocation
configure
