## Docker Commands

#### Index
- [Image Remove](#image-remove)
- [Kill Container](#kill-container)
- [Remove all the docker images](#remove-all-the-docker-images)
- [Stop all running  containers](#remove-all-the-docker-images)


### *Image Remove*
Removes image from the docker machine.
```
docker image rm <imageID>
docker rmi <imageId>
```
### *Kill Container*

To kill container which are non responsive
```shell
docker kill <containerId>
```
### *Remove all the docker images*

Remove all the docker images at the same time
```shell
docker image rm $(docker images | awk '{print $3}')
```
### *Stop all running containers*
Stop all running containers at the same time
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```


