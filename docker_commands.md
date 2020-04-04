## Docker Commands

#### Index
- [Docker Copy](#docker-copy)
- [Docker image backup](#docker-image-backup)
- [Image Remove](#image-remove)
- [Kill Container](#kill-container)
- [Docker Login](#docker-login)
- [Remove all the docker containers](#remove-all-the-docker-containers)
- [Remove all the docker images](#remove-all-the-docker-images)
- [Shared Volumes](#shared-volumes)
- [Stop all running  containers](#stop-all-running-containers)

### *Docker Copy*

Copy a file from the host to container
```shell
docker cp ./filename <contianerId>:/var/www/html
```
### *Docker Image Backup*

Backup your docker custom images to ducker hub repository
```shell
docker commit <containerId> <accountId><imageName>
docker images
docker run -it -d <imageName>
docker push <accountId><imageName>
```
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
### *Docker Login*

Login to your personnal repository
```shell
docker login
```
### *Remove all the docker containers*

Remove all the docker images at the same time
```shell
docker rm -f $(docker ps -a -q)
```
### *Remove all the docker images*

Remove all the docker images at the same time
```shell
docker image rm $(docker images | awk '{print $3}')
```
### *Shared Volumes*
```shell
docker volume create <volumeName>
docker volume ls
docker run -it --mount source=<volumeName>,target=/app -d <image Name>
```
### *Stop all running containers*
Stop all running containers at the same time
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```


