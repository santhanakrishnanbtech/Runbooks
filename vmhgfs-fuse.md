# 01. Create a directory /share
# 02. Create a file mount.service

```shell
[Unit]
Description=Load VMware shared folders
Requires=vmware-vmblock-fuse.service
After=vmware-vmblock-fuse.service
ConditionPathExists=.host:/S
ConditionVirtualization=vmware

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/vmhgfs-fuse -o allow_other -o auto_unmount .host:/S /share

[Install]
WantedBy=multi-user.target
```

# 03. sudo systemctl daemon-reload
# 04. sudo systemctl enable mount.service
