### NGINX RUNBOOK

> nginx.service: Failed to set a watch for PID file /run/nginx.pid: No space left on device
```
sudo mkdir /etc/systemd/system/nginx.service.d
printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" | \
sudo tee /etc/systemd/system/nginx.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart nginx
```
> Failed to add /run/systemd/ask-password to directory watch: No space left on device
```
sudo -i
echo 1048576 > /proc/sys/fs/inotify/max_user_watches
exit
echo "fs.inotify.max_user_watches=1048576" >> nano /etc/sysctl.conf
```
