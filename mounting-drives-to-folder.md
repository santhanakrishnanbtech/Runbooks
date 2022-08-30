### Connect harddisk to the Server
##### List the devices
```shell
lsblk
```
##### Ready the drive
```shell
fdisk /dev/sdb
n
p
#default
#default
t
8e
w
```
##### Refresh connections 
```shell
partprobe
```
##### List drives
```shell
lsblk
```
##### Create a physical volume
```shell
pvcreate /dev/sdb1
```
##### Create a volume group
```shell
vgcreate [pv_name] [device_name]
vgcreate drive01 /dev/sdb1
```
##### Create a logical volume (map01 is volume name)
```shell
lvcreate -l100%FREE -n[lv_name] [pv_name]
lvcreate -l100%FREE -nmap01 drive01
```
##### List all logical volumes
```shell
lvs
```
##### Create a filesystem
###### Note: format of drive is xfs. For ext4 last step may vary.
```shell
mkfs.xfs /dev/drive01/map01
```
##### Get UUID
```shell
blkid
```
##### Mount to a directory
```shell
mkdir -p [server_mount_folder_name]
mkdir -p /share
```
##### Add fstab entry
###### Note: UUID can be obtained from 'blkid' output mapper line.
```shell
vim /etc/fstab
UUID="5ba27c5d-10f5-4bcb-82f6-f26f49d8df9e" /share xfs defaults 0 0
```
##### Refresh the mount entry
```shell
mount -a
```
##### Verify the mount
```shell
df -kh
```
### Adding second hardisk
##### List the volume groups
```shell
vgs
```
##### Extend new volume to existing volume
```shell
fdisk /dev/sdc
```
##### refresh
```shell
partprobe
```
##### Creating physical volume
```shell
pvcreate /dev/sdc1
```
##### List physical volumes
```shell
pvs
```
##### display volume group
```shell
vgdisplay
```
##### display logical volume
```shell
lvdisplay
```
##### scan physical volumes
```shell
pvscan
```
##### Extend volume
```shell
vgextend drive01 /dev/sdc1
```
##### Un mount the first volume
##### umount /dev/drive01/map01

##### Check free space in Volume group (check Free PE / Size for new drive added)
##### vgdisplay

##### Extend first drive with free space
```shell
lvextend -L+8000M /dev/drive01/map01
```
##### Resize the filesystem
```shell
xfs_growfs /dev/drive01/map01
```


