### Docker Commands
##### Stop all running containers
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```
