# Create a script "mac.sh" and add below line
# Run it in every clone on first boot 
# REF: https://jaylacroix.com/fixing-ubuntu-18-04-virtual-machines-that-fight-over-the-same-ip-address/

#!/bin/bash
sudo rm /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo truncate -s 0 /etc/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
sudo reboot
