## RTNETLINK answers: File exists
#### ERROR Log:-
`systemctl status network.service`<br/>
`network.service - LSB: Bring up/down networking`
`   Loaded: loaded (/etc/rc.d/init.d/network)`<br/>
`   Active: failed (Result: exit-code) since Fri 2015-01-16 22:30:46 GMT; 38s ago`<br/>
`  Process: 4857 ExecStart=/etc/rc.d/init.d/network start (code=exited, status=1/FAILURE)`<br/>

`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>
`Jan 16 22:30:46 localhost.localdomain network[4857]: RTNETLINK answers: File exists`<br/>

#### Solution: -
`ip addr show <compare MAC Address> vi /etc/sysconfig/network-scripts/ifcfg-eth0`

`systemctl disable NetworkManager.service`<br/>

##### _Change MAC address in ifcfg-eth0 to the MAC allocated in the system_

<br/>
Reboot the hosts once.
