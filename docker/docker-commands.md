
### Docker Build & Run  ![Docker](https://img.shields.io/badge/Docker-Build-blue?style=for-the-badge)

| Command                                                        | Description                                                   |
|----------------------------------------------------------------|---------------------------------------------------------------|
| `docker build -t image-name .`                                  | Create an image using this directory’s Dockerfile.             |
| `docker run -p 8080:80 image-name`                              | Run “image-name” mapping port 8080 to 80.                      |
| `docker run -d -p 8080:80 image-name`                           | Run “image-name” mapping port 8080 to 80, but in detached mode.|
| `docker ps`                                                    | See a list of all running containers.                         |
| `docker stop <hash>`                                            | Gracefully stop the specified container.                      |
| `docker ps -a`                                                 | See a list of all containers, even the ones not running.      |
| `docker kill <hash>`                                            | Force shutdown of the specified container.                    |
| `docker rm <hash>`                                              | Remove the specified container from this machine.             |
| `docker rm $(docker ps -a -q)`                                  | Remove all containers from this machine.                      |
| `docker images -a`                                              | Show all images on this machine.                              |
| `docker rmi <imagename>`                                        | LEGACY: Remove the specified image from this machine.         |
| `docker rmi $(docker images -q)`                                | LEGACY: Remove all images from this machine.                  |
| `docker images -q \| xargs docker rmi –f`                      | LEGACY: Remove all images with dependencies.                  |
| `docker login`                                                 | Log in this CLI session using your Docker credentials.        |
| `docker tag <image> username/repository:tag`                    | Tag for upload to registry.                                   |
| `docker push username/repository:tag`                           | Upload tagged image to registry.                              |
| `docker run username/repository:tag`                            | Run image from a registry.                                    |
| `docker volume ls`                                             | List Docker volumes.                                          |
| `docker network ls`                                            | List Docker networks.                                         |
| `docker exec -it <containerId> bash`                            | Access an already running container and perform operations inside it. |

*********************************************

### Docker Compose  ![Docker](https://img.shields.io/badge/Docker-Compose-blue?style=for-the-badge)

- Build Docker Images using Docker Compose file

| Command                                      | Description                                             |
|----------------------------------------------|---------------------------------------------------------|
| `docker-compose build`                       | Build Docker Images using the Docker Compose file.      |
| `docker-compose up`                          | Run Docker Containers.                                  |
| `docker-compose up -d`                       | Run Docker Containers in background mode.               |
| `docker-compose up --build`                  | Build images before starting containers.                |
| `docker-compose up --force-recreate`         | Recreate containers from existing images.               |
| `docker-compose down`                        | Stop and remove containers, volumes, networks, and images.|
| `docker-compose ps -a`                       | List containers.                                        |
| `docker-compose logs`                        | Display log output.                                     |



******************************************************

### Docker Swarm  ![Docker](https://img.shields.io/badge/Docker-Swarm-blue?style=for-the-badge)


| Command                                                                                                         | Description                                                   |
|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| `docker swarm init`                                                                                             | Initialize Docker Swarm.                                      |
| `docker swarm join --token SWMTKN-1-3pu6hszjas19xyp7ghgosyx9k8atbfcr8p2is99znpy26u2lkl-1awxwuwd3z9j1z3puu7rcgdbx <manager/worker>:2377` | Join a Docker Cluster.                |
| `docker node ls`                                                                                                 | List Docker nodes in the Swarm Cluster.                       |
| `docker stack ls`                                                                                                 | List all running applications on this Docker host.            |
| `docker stack deploy -c <composefile> <STACK_NAME>`                                                              | Run the specified Compose file.                               |
| `docker stack services <appname>`                                                                                 | List the services associated with an app.                     |
| `docker stack ps <appname>`                                                                                       | List the running containers associated with an app.           |
| `docker stack rm <STACK_NAME>` alias `dstr='docker stack rm'`                                                    | Tear down an application.                                     |
| `docker service ls` alias `dsls='docker service ls'`                                                             | Docker Swarm Service list.                                    |
| `docker service ps <service_name>` alias `dsp='docker service ps'`                                                | List the tasks of one or more services.                       |
| `docker service logs` alias `dsl='docker service logs'`                                                          | Docker Swarm Service logs.                                    |
| `docker service rm` alias `dsr='docker service rm'`                                                              | Remove specific Docker Swarm service.                         |
| `docker system prune` alias `sprune='docker system prune'`                                                        | Remove unused Containers, Images, Networks, etc.              |
| `docker volume prune` alias `vprune='docker volume prune'`                                                        | Remove unused volumes.                                        |
| `docker secret create <SECRET_NAME> <SECRET_PATH>`                                                                | Create a secret.                                              |
| `docker config create <CONFIG_NAME> <CONFIG_FILE_PATH>`                                                           | Create a config.                                              |
| `docker rm -vf $(docker ps -a -q)`                                                                                | Delete all containers, including their volumes.               |
| `docker rmi -f $(docker images -a -q)`                                                                            | Delete all images. (Remember, you should remove all the containers before removing all the images from which those containers were created.)                                         |
| <pre> `$images = docker images -a -q` <br/> `foreach ($image in $images) { docker image rm $image -f }` </pre> | In case you are working on Windows (Powershell) |
| `docker rmi $(docker images -a)` | To delete all images |
|  `docker rm $(docker ps -a -f status=exited -q)`  |  To delete containers which are in exited state |
|  `docker rm $(docker ps -a -f status=created -q)`   |  To delete containers which are in created state (**NOTE:** Remove all the containers then remove the images)|
| `docker run -it --entrypoint bash <image-name>` |  Docker run bash shell of image  |
|  ` docker --help `  |  List all docker commands  |
