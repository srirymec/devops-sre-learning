# Docker Cheat Sheet
Image and Containers Basic
| Command                           | What It Does                                                | Why It Matters                                |
| --------------------------------- | ----------------------------------------------------------- | --------------------------------------------- |
| `docker --version`                | Shows the installed Docker version.                         | Verify Docker is installed properly.          |
| `docker info`                     | Displays system-wide info (images, containers, etc.)        | Useful for debugging or audits.               |
| `docker pull <image>`             | Downloads an image from Docker Hub (or registry).           | Used before running a container.              |
| `docker images`                   | Lists all local images.                                     | Inventory of available base images.           |
| `docker rmi <image>`              | Removes an image.                                           | Saves space, cleans up old versions.          |
| `docker build -t <tag> .`         | Builds an image from a Dockerfile in the current directory. | Used in CI/CD to create deployable artifacts. |
| `docker tag <image> <repo>:<tag>` | Tags an image with a custom name.                           | Prepares for pushing to a registry.           |
| `docker push <repo>:<tag>`        | Uploads image to a registry (Docker Hub, ECR, GCR).         | Key part of deployment pipelines.             |

Working with Containers
| Command                                  | What It Does                                    | Why It Matters                               |
| ---------------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| `docker run -it <image>`                 | Runs a container in interactive mode.           | Great for testing or debugging.              |
| `docker run -d <image>`                  | Runs a container in detached (background) mode. | Used for services that need to keep running. |
| `docker run -p 8080:80 <image>`          | Maps host port 8080 to container port 80.       | Exposes container services to the outside.   |
| `docker run -v /host:/container <image>` | Mounts a volume (host dir into container).      | Needed for data persistence/config.          |
| `docker ps`                              | Shows running containers.                       | Quick status check.                          |
| `docker ps -a`                           | Shows all containers (running + stopped).       | Auditing and clean-up.                       |
| `docker stop <container>`                | Gracefully stops a running container.           | Shutdown service without kill.               |
| `docker kill <container>`                | Forcefully stops a container.                   | When stop doesn't work.                      |
| `docker start <container>`               | Starts a stopped container.                     | Restarting apps without rebuild.             |
| `docker rm <container>`                  | Removes a stopped container.                    | Cleanup old resources.                       |
| `docker exec -it <container> /bin/bash`  | Opens shell access to a container.              | Debug inside container environment.          |

Inspecting and Debugging
| Command                      | What It Does                                  | Why It Matters                            |
| ---------------------------- | --------------------------------------------- | ----------------------------------------- |
| `docker logs <container>`    | Shows logs of a container.                    | Helps diagnose issues.                    |
| `docker inspect <container>` | Detailed JSON output of container properties. | Networking, mount points, etc.            |
| `docker stats`               | Real-time performance metrics (CPU, memory).  | Monitoring resource usage.                |
| `docker events`              | Streams real-time Docker events.              | Useful for debugging automation triggers. |

Volumes and Networks
| Command                        | What It Does                           | Why It Matters                                   |
| ------------------------------ | -------------------------------------- | ------------------------------------------------ |
| `docker volume create <name>`  | Creates a Docker volume.               | Needed for persistent storage.                   |
| `docker volume ls`             | Lists all volumes.                     | Volume inventory.                                |
| `docker network ls`            | Lists all Docker networks.             | Useful in microservices setup.                   |
| `docker network create <name>` | Creates a user-defined bridge network. | Allows custom network config between containers. |

Docker Compose for multi-container apps
| Command                | What It Does                                         | Why It Matters                         |
| ---------------------- | ---------------------------------------------------- | -------------------------------------- |
| `docker-compose up`    | Starts all services defined in `docker-compose.yml`. | Spins up the entire app stack.         |
| `docker-compose up -d` | Starts in background mode.                           | Common in staging/prod envs.           |
| `docker-compose down`  | Stops and removes all containers/networks/volumes.   | Clean teardown.                        |
| `docker-compose build` | Builds images from Dockerfiles defined in compose.   | Used in CI to build and test services. |

other useful commands
| Command                              | What It Does                                 | Why It Matters                  |
| ------------------------------------ | -------------------------------------------- | ------------------------------- |
| `docker system df`                   | Shows disk usage by Docker.                  | Helps find unused resources.    |
| `docker system prune`                | Cleans up unused containers/images/networks. | Frees up disk space.            |
| `docker cp <container>:/file ./host` | Copies file from container to host.          | Backup or debugging artifacts.  |
| `docker login`                       | Logs into a container registry.              | Required before pushing images. |

