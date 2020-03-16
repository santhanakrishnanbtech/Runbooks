### Docker Commands

##### Remove all `docker images`
```shell
docker image rm $(docker images | awk '{print $3}')
```
##### Stop all running containers
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```

