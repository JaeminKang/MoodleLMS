docker_image_name="kangjm2/moodle"
docker_container_name="w1"

docker stop ${docker_container_name}
docker rm ${docker_container_name}
docker rmi ${docker_image_name}