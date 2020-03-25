docker build --rm -t test-dparadig .    
docker container rm dparadig -f  
docker container run --publish 23:22 --detach --name dparadig test-dparadig
docker exec -ti dparadig /bin/bash    