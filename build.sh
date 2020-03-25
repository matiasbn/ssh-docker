docker build --rm -t sshdocker .    
docker container rm ssh-docker -f  
docker container run --publish 23:22 --detach --name ssh-docker sshdocker
docker exec -ti ssh-docker /bin/bash    