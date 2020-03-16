> ##### Docker Commands
Stop all running containers
```
docker stop $(docker ps | grep -ai up | awk '{ print $1}')
```
