# Docker Interview Questions

## :baby: beginner

<details>
<summary>What is Docker? What are you using it for?</summary><br>

 Docker is a software platform that enables developers to build, test, and deploy applications using containerization. It packages applications and their dependencies into standardized units called **containers**, which can run consistently across different computing environments. Essentially, Docker virtualizes the operating system, allowing you to run multiple applications in isolated containers on a single host, without the overhead of virtual machines. 
</details>

<details>
<summary>How containers are different from VMs?</summary><br>

The primary difference between containers and VMs is that containers allow you to virtualize
multiple workloads on the operating system while in the case of VMs the hardware is being virtualized to
run multiple machines each with its own OS.

![Container VS VM](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/container%20vs%20vms.jpg)

 | **Virtual Machines (VM)** | **Containers** |
|------------------------|------------|
| Virtual Machines imitate full-fledged hardware, including the guest OS, on top of a hypervisor. Each VM runs its own OS instance which is independent of the host OS. | Docker containers are lightweight and portable, and they share the host OS kernel. They run on top of the host OS and encapsulate the application and its dependencies. |
| VMs consume more resources since they need to imitate an entire operating system, including memory, disk space, and CPU. | In terms of resource utilization, Docker Containers are highly efficient since they share the host OS kernel and require fewer resources compared to VMs. |
| Comparatively, VMs offer stronger isolation since each VM runs its kernel and has its dedicated resources. Hence, VMs are more secure but also heavier. | Containers provide process-level isolation. This means that they share the same OS kernel but have separate filesystems and networking. This is achieved through namespaces and control groups. |
| VMs are less flexible compared to containers due to differences in underlying hardware and hypervisor configurations. However, they can be portable to some extent through disk images. | As long as Docker is installed in an environment, Containers can run consistently across different environments, development or production. This makes them highly portable. |
| VMs typically take longer to start because they need to boot an entire OS. This results in slower startup times compared to containers. | Containers spin up almost instantly since they utilize the host OS kernel. Hence, they are best suitable for microservices architectures and rapid scaling. |
| VMs are preferred for running legacy applications that have strict security requirements where strong isolation is necessary. | Docker Containers are best suited for microservices architectures, CI/CD pipelines, and applications that require rapid deployment and scaling. |
</details>

<details>
<summary>In which scenarios would you use containers and in which you would prefer to use VMs?</summary><br>

**You should choose VMs when:**
  * you need run an application which requires all the resources and functionalities of an OS
  * you need full isolation and security

**You should choose containers when:**
  * you need a lightweight solution that quickly starts
  * Running multiple versions or instances of a single application
</details>

<details>
<summary>Explain Docker architecture</summary><br>

 ![Docker architecture](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_architecture.jpg)

- **Docker Daemon**
  - Also known as `dockerd`, it manages Docker objects like containers, images, volumes, and networks.
  - Listens to Docker API requests.
  - Can communicate with other daemons to manage Docker services.

- **Docker Client**
  - Users interact with Docker using clients like the CLI.
  - Docker commands (e.g., `docker run`) are sent to `dockerd` for execution.
  - A single Docker client can communicate with multiple daemons.

- **Docker Desktop**
  - An easy-to-use application for accessing Docker on Windows, macOS, and Linux.
  - Allows users to perform all Docker-related functionalities.
  - Bundled with Docker daemon, client, Compose, Kubernetes, and more.

- **Docker Registries**
  - Registries store Docker images.
  - The most popular public registry is **Docker Hub**.
  - By default, Docker pulls images from Docker Hub.
  - `docker pull` or `docker run` commands fetch images from the registry.
  - `docker push` sends images to the registry.

- **Docker Objects**
  - Includes images, containers, networks, volumes, plugins, and others used throughout the Docker lifecycle.

- **Docker Images**
  - Read-only templates used to create containers.
  - Typically based on another image with added modifications.
  - Example: An image based on Ubuntu with Apache, your application, and custom configurations.
  - Can be custom-built using a `Dockerfile`.
  - Each instruction in a Dockerfile adds a layer to the image.
  - When rebuilding, only changed layers are rebuilt—making images lightweight and fast.

- **Docker Containers**
  - A container is a running instance of a Docker image.
  - You can create, run, stop, move, or delete containers.
  - Container behavior depends on the image and startup configurations.
  - Unsaved changes (not persisted via volumes) are lost when a container is removed or stopped.

- **Docker Networks**
  - Enable communication between containers.
  - Containers are isolated by default.
  - Virtual networks allow safe communication between containers.
  - Networks can be simple (bridge) or complex (custom drivers).
  - Essential for multi-container applications.

- **Docker Storage**
  - Traditional applications rely on host storage.
  - Docker uses **volumes** to manage storage outside of the container.
  - Volumes ensure data persists even if containers are stopped or deleted.
  - You can bind-mount directories from the host or use named volumes.
  - Volumes separate data from the container lifecycle, ensuring durability and manageability.
</details>

<details>
<summary>Describe in detail what happens when you run `docker run hello-world`?</summary><br>

- Docker CLI passes your request to Docker daemon.
- Docker daemon downloads the image from Docker Hub
- Docker daemon creates a new container by using the image it downloaded
- Docker daemon redirects output from container to Docker CLI which redirects it to the standard output
</details>

<details>
<summary>How do you run a container?</summary><br>

 The primary command for starting and creating Docker containers is `docker run`. If the image isn't already available locally, Docker pulls it from a registry when you run this command. It then starts a fresh container instance by generating one based on that image.

With the help of this command, you can specify several options, including volume mounts, environment variables, port mappings, and more, to tailor the container's configuration to your requirements.

```bash
$ docker run -d -p 8080:80 nginx
```
![docker run](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_3.jpg)

In this case, the detached mode (`-d`) of the `docker run` command creates a new container based on the `"nginx"` image and runs it in the background. Additionally, it maps host port `8080` to container port `80` (`-p 8080:80`), granting access to the **NGINX** web server housed within the container.
</details>

<details>
<summary>What best practices are you familiar related to working with containers?</summary><br>

- 🐳 Image Design & Management
  - Use minimal base images (e.g., alpine, distroless) -> Reduces attack surface and image size.
  - Multi-stage builds -> Compile/build in one stage and copy only needed artifacts to the final image.
  - Pin image versions -> Avoid using latest; instead, use specific tags to prevent unexpected changes.
  - Keep images small -> Avoid installing unnecessary packages. Clean up apt-get caches, etc.
  - Layer caching awareness -> Place least frequently changed layers on top of Dockerfile to optimize builds.

- 🔐 Security Best Practices
  - Scan images for vulnerabilities
→ Use tools like Trivy, Clair, or Docker Scout in your CI pipeline.
  - Run containers as non-root
→ Add a user in Dockerfile and drop unnecessary Linux capabilities.
  - Read-only file systems
→ Set filesystem to read-only except where writable volumes are needed.
  - Avoid secrets in images or ENV
→ Use Kubernetes Secrets or external secret management (e.g., Vault, AWS Secrets Manager).

- ⚙️ Container Runtime Configurations
  - Limit resource usage
→ Set memory (memory) and CPU (cpu) limits in Docker or Kubernetes.
  - Health checks
→ Use HEALTHCHECK in Docker and livenessProbe/readinessProbe in Kubernetes.
  - Log to stdout/stderr
→ Allow logs to be captured by container orchestrators like Kubernetes.

- 📦Container Orchestration (Kubernetes)
  - Immutable infrastructure
→ Avoid modifying running containers. Replace them with new builds.
  - Use deployments and services
→ Ensure proper rolling updates and service discovery.
  - Namespace separation
→ Use namespaces for multitenancy or separating environments.
  - Use ConfigMaps and Secrets
→ Externalize configuration and sensitive data cleanly.

- 🚀 CI/CD Integration
  - Automate image builds and pushes
→ Use CI/CD tools like GitHub Actions, GitLab CI, or Google Cloud Build.
  - Tag with git commit or version
→ Enables better traceability.
  - Use a trusted registry
→ Push to secured registries like Docker Hub (with signed images), ECR, GCR, etc.

- 🔍 Monitoring & Observability
  - Use sidecars or agents for monitoring/logging
→ Example: Fluentd, Promtail, Datadog Agent.
  - Expose metrics endpoints
→ Prometheus-compatible metrics endpoints using /metrics.
 
</details>

<details>
<summary>What `docker commit` does?. When will you use it?</summary><br>

 The `docker commit` command allows users to create a new Docker image based on the contents of a container. The new image comprises the base image and a layer containing modifications made inside the container.

The `docker commit` command uses the following syntax:

```
docker commit [options] [container-id-or-name] [image-name]:[tag]
```

The `[tag]` part of the command is optional. If you create an image without a tag, Docker defaults to `latest`.
</details>

<details>
<summary>How would you transfer data from one container into another?</summary><br>

 # 📦 Methods for Transferring Data Between Docker Containers

---

## 🔹 Docker Volumes

- **Concept:**  
  Docker volumes provide a mechanism for persistent data storage and sharing between containers.

- **How it works:**  
  When a volume is mounted to a container, changes made within the container’s volume directory are reflected on the host and in other containers that share the same volume.

- **Example:**
  ```
  docker run -d -v myvolume:/app/data my_container_image  # Create a volume and mount it to a container
  docker run -d -v myvolume:/app/data another_container_image  # Mount the same volume to another container
  ```

---

## 🔹 `docker cp` Command

- **Concept:**  
  The `docker cp` command allows copying files and directories between a container and the host or between containers.

- **How it works:**  
  It can copy files from the container to the host, or from the host to the container.

- **Example:**
  ```
  docker cp my_container:/app/data/file.txt .  # Copy file.txt from container to the current directory on the host
  docker cp file.txt my_container:/app/data/  # Copy file.txt from the host to the container's /app/data directory
  ```

---

## 🔹 Network Communication

- **Concept:**  
  Containers can communicate with each other over a network if they are part of the same network or if they are exposed to each other through exposed ports.

- **How it works:**  
  Applications within the containers can use standard network protocols (like HTTP, TCP sockets, etc.) to exchange data.

- **Example:**
  ```
  - A web application container can send data to a database container through a REST API.
  - Containers can use message queues (like RabbitMQ or Kafka) to exchange data.
  ```

---

## 🔹 Named Volumes

- **Concept:**  
  Named volumes offer a way to manage and share data between containers, especially in `docker-compose`.

- **How it works:**  
  You define named volumes in your `docker-compose.yml` and mount them to containers.

- **Example:**
 ```
        version: "3.8"
        services:
          web:
            image: nginx:latest
            ports:
              - "8080:80"
            volumes:
              - my_web_data:/usr/share/nginx/html  # Named volume for website content
          db:
            image: postgres:latest
            volumes:
              - my_db_data:/var/lib/postgresql/data  # Named volume for database data
        volumes:
          my_web_data:
          my_db_data:
 ```

</details>

<details>
<summary>What happens to data of the container when a container exits?</summary><br>

 When a container starts, it uses the files and configuration provided by the image. Each container is able to create, modify, and delete files and does so without affecting any other containers. **When the container is deleted, these file changes are also deleted.**

While this ephemeral nature of containers is great, it poses a challenge when you want to persist the data. For example, if you restart a database container, you might not want to start with an empty database. So, how do you persist files?

## Container volumes

Volumes are a storage mechanism that provide the ability to persist data beyond the lifecycle of an individual container. Think of it like providing a shortcut or symlink from inside the container to outside the container.

As an example, imagine you create a volume named `log-data`.

```
docker volume create log-data
```

When starting a container with the following command, the volume will be mounted (or attached) into the container at `/logs`:

```
docker run -d -p 80:80 -v log-data:/logs docker/welcome-to-docker
```

If the volume `log-data` doesn't exist, Docker will automatically create it for you.

When the container runs, all files it writes into the `/logs` folder will be saved in this volume, outside of the container. If you delete the container and start a new container using the same volume, the files will still be there.

</details>

<details>
<summary>Explain what each of the following commands do:

  * docker run
  * docker rm
  * docker ps
  * docker build
  * docker commit
    
</summary><br>

- **docker run**
  The primary command for starting and creating Docker containers is `docker run`. If the image isn't already available locally, Docker pulls it from a registry when you run this command. It then starts a fresh container instance by generating one based on that image.

With the help of this command, you can specify several options, including volume mounts, environment variables, port mappings, and more, to tailor the container's configuration to your requirements.

```bash
$ docker run -d -p 8080:80 nginx
```
![docker run](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_3.jpg)

In this case, the detached mode (`-d`) of the `docker run` command creates a new container based on the `"nginx"` image and runs it in the background. Additionally, it maps host port `8080` to container port `80` (`-p 8080:80`), granting access to the **NGINX** web server housed within the container.

- **docker rm**
To remove a Docker container or containers, you can use the `docker rm` command. The container(s) whose ID or name you wish to remove can be specified. This command only removes stopped containers by default; to forcefully remove running containers, you can use the `-f` or `--force` flag.

```bash
$ docker rm my_container
```
![docker rm](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_9.jpg)

The above command deletes the container with the name `"my_container"`. Unless the `-f` flag is used to force removal, the container must stop running before being removed.

If you want to remove all Docker containers together, you can chain two commands — `docker ps -aq`, which is used to obtain a list of all container IDs, and combine it with the `docker rm` command to remove all containers, including running containers.

```bash
$ docker rm $(docker ps -aq)
```
![docker rm1](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_11.jpg)

The above command removes every container on the Docker host, regardless of whether it is running or stopped.

- **docker ps**
  The Docker host's running containers can be listed using the `docker ps` command. You can use the `-a` or `--all` flag to show all containers, including stopped ones, as it only shows running containers by default.

```bash
$ docker ps
```
![docker ps](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_2.jpg)

This command displays the IDs, names, statuses, and other pertinent details of all containers that are currently running. It returns an empty list if no containers are in use.

- **docker build**
  The docker build command is used to build a Docker image from a Dockerfile and a context.

  ```bash
  $ docker build -t my-app:latest .
  ```
  Assuming the Docker file is in the current directory.
  
- **docker commit**
  The `docker commit` command allows users to create a new Docker image based on the contents of a container. The new image comprises the base image and a layer containing modifications made inside the container.

The `docker commit` command uses the following syntax:

```
docker commit [options] [container-id-or-name] [image-name]:[tag]
```

The `[tag]` part of the command is optional. If you create an image without a tag, Docker defaults to `latest`.
</details>

<details>
<summary>How do you remove old, non running, containers?</summary><br>

 To clear up disk space on the Docker host, you can use the `docker container prune` command to remove all stopped containers. It is a practical method of clearing out empty containers and recovering resources.

```bash
$ docker container prune
```
![docker prune](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_10.jpg)

Docker asks for confirmation before continuing, but you can ignore this prompt by passing it with the `-f` or `--force` flag.

```bash
$ docker container prune -f
```
</details>

#### Dockerfile

<details>
<summary>What is Dockerfile</summary><br>

A Dockerfile is a plain text document that contains a series of instructions used to automatically build a Docker image. Each instruction in a Dockerfile represents a step in the image creation process, such as specifying a base image, copying files, installing dependencies, or setting environment variables. 

### 📄 Dockerfile Instructions

| Instruction   | Description                                             |
|---------------|---------------------------------------------------------|
| `ADD`         | Add local or remote files and directories.              |
| `ARG`         | Use build-time variables.                               |
| `CMD`         | Specify default commands.                               |
| `COPY`        | Copy files and directories.                             |
| `ENTRYPOINT`  | Specify default executable.                             |
| `ENV`         | Set environment variables.                              |
| `EXPOSE`      | Describe which ports your application is listening on.  |
| `FROM`        | Create a new build stage from a base image.             |
| `RUN`         | Execute build commands.                                 |
| `WORKDIR`     | Specify/Change working directory.                       |
| `USER`        | Set user and group ID.                                  |

### Example Docker file
```
FROM python:3.11-slim
COPY app.py /app/app.py
WORKDIR /app
CMD ["python", "app.py"]

```
</details>

<details>
<summary>What is the difference between ADD and COPY in Dockerfile?</summary><br>

Both `COPY` and `ADD` are Dockerfile instructions used to transfer files and directories from the build context into a Docker image. However, they differ in their capabilities:

- COPY:
  - Functionality: COPY is a straightforward instruction used to copy local files or directories from the host machine (the build context) into the Docker image at a specified destination.
  - Simplicity: It only performs a direct copy operation, making it more predictable and easier to understand.
  - Syntax: ```COPY <source> <destination>```

- ADD:
  - Functionality: ADD is more versatile than COPY, offering additional features beyond simple file copying.
  - Remote URLs: It can download files from remote URLs directly into the image.
  - Archive Extraction: It can automatically extract compressed archives (like .tar, .tar.gz, .zip) if the source is a local compressed file.
  - Syntax: ```ADD <source> <destination>```

**Key Differences Summarized:**

# 📋 Comparison: `COPY` vs `ADD` in Dockerfile

| Feature               | `COPY`                            | `ADD`                                                  |
|------------------------|------------------------------------|---------------------------------------------------------|
| Local Files/Dirs       | Yes                                | Yes                                                     |
| Remote URLs            | No                                 | Yes (downloads content)                                 |
| Automatic Extraction   | No (copies archives as-is)         | Yes (extracts local archives)                           |
| Complexity             | Simpler and more predictable       | More complex due to added functionalities               |
| Best Practice          | Preferred for most local file copies | Use only when needing URL download or archive extraction |


</details>

<details>
<summary>What is the difference between CMD and RUN in Dockerfile?</summary><br>

The primary difference between `RUN` and `CMD` in a Dockerfile lies in when and how they are executed: 

- RUN:
  - Execution Time: `RUN` instructions are executed during the build process of the Docker image. Each `RUN` command creates a new layer in the image, committing the changes made by the command.
  - Purpose: Used for executing commands required to set up the image, such as installing packages, compiling code, or creating directories.
  - Example: ```RUN apt-get update && apt-get install -y my-package```

- CMD:
  - Execution Time: `CMD` instructions define the default command or parameters that will be executed when a Docker container is started from the image.
  - Purpose: Used to specify the main process or application that the container should run by default. It can also provide default arguments for an `ENTRYPOINT` instruction.
  - Overriding: The `CMD` instruction can be easily overridden by providing a different command or arguments when running the container using `docker run`.
  - Example: ```CMD ["nginx", "-g", "daemon off;"]``` (to start Nginx) or ```CMD ["echo", "Hello World"]``` (as a default message).

In summary:
- `RUN` builds the image by executing commands and creating layers.
- `CMD` defines the default command to run when a container starts, and this default can be easily overridden.
</details>

<details>
<summary>Explain what is Docker compose and what is it used for</summary><br><b>
</b></details>

<details>
<summary>What are the differences between Docker compose, Docker swarm and Kubernetes?</summary><br><b>
</b></details>

<details>
<summary>Explain Docker interlock</summary><br><b>
</b></details>

<details>
<summary>What is the difference between Docker Hub and Docker cloud?</summary><br><b>

Docker Hub is a native Docker registry service which allows you to run pull
and push commands to install and deploy Docker images from the Docker Hub.

Docker Cloud is built on top of the Docker Hub so Docker Cloud provides
you with more options/features compared to Docker Hub. One example is
Swarm management which means you can create new swarms in Docker Cloud.
</b></details>

<details>
<summary>Where Docker images are stored?</summary><br><b>
</b></details>

<details>
<summary>Explain image layers</summary><br><b>
</b></details>

<a name="docker-advanced"></a>
## :star: Advanced

<details>
<summary>How do you manage persistent storage in Docker?</summary><br><b>
</b></details>

<details>
<summary>How can you connect from the inside of your container to the localhost of your host, where the container runs?</summary><br><b>
</b></details>

<details>
<summary>How do you copy files from Docker container to the host and vice versa?</summary><br><b>
</b></details>
