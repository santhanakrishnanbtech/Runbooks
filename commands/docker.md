## Docker Commands
|Index|
|:---|
| [Remove all the images](#remove-all-the-docker-images).|
| [Stop all running containers](#stop-all-running-containers).|

##### *Remove all the docker images*
```shell
docker image rm $(docker images | awk '{print $3}')
```
##### *Stop all running containers*
```shell
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```

- [ ] \(Optional) Open a followup issue
- [ ] Open a pull request
