## Docker Commands
|Index|
|:---|
|[Remove all the images](#remove-all-the-docker-images).|



































##### Remove all the docker images
```shell
docker image rm $(docker images | awk '{print $3}')
```
##### Stop all running containers  `docker ps`
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```

