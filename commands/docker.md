## Docker Commands

#### Index
- [Remove all the docker images](#remove-all-the-docker-images)
- [Stop all running  containers](#remove-all-the-docker-images)
- [Kill Container](#kill-container)

##### *Kill Container*
```shell
docker kill <containerId>
```
##### *Remove all the docker images*
```shell
docker image rm $(docker images | awk '{print $3}')
```
##### *Stop all running containers*
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```


