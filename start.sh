docker_image_name="t1"
docker_container_name="w1"

docker build -t ${docker_image_name} .
docker run -it -d --name ${docker_container_name} -p 8080:80 -p 443:443 ${docker_image_name}
docker ps

docker exec -it w1 bash