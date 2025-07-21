# Docker Tutorial

<b> CLICK ON EACH QUESTION FOR THE ANSWER </b>

<details>
<summary> 
 
 ## What is Docker? 
 </summary><br>

Docker is a software platform that allows you to build, test, and deploy applications quickly. Docker packages software into standardized units called containers that have everything the software needs to run including libraries, system tools, code, and runtime. 

</details>
<details>
<summary> 
 
## Why Docker?
 </summary><br>

- **Portability:** Docker facilitates the developers in packaging their applications with all dependencies into a single lightweight containers.

- **Reproducibility:** Encapsulating the applications with their dependencies within a container it ensures in software setups remaining consistent across the development, testing and production environments.

- **Efficiency:** Docker, through its container-based architecture it optimizes the resource utilization.

- **Scalability:** Docker's scalability features facilitated the developers in making easier of their applications handling at time of workloads increment.
</details>
<details>
<summary> 
 
## Docker containers vs Virtual Machines
 </summary><br>

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
<summary> 
 
## Docker Architecture
</summary><br>

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
<summary> 
 
 ## Docker hub 
 </summary><br>

Docker Hub is a cloud-based repository service that allows users to store, share, and manage Docker container images.

![Docker hub](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_hub_1.jpg)

</details>
<details>
<summary> 
 
## Docker Images
</summary><br>

Docker images are self-contained templates that are used to build containers. They make use of a tiered file system to store data effectively.

</details>
<details>
<summary> 
 
## Docker Containers
</summary><br>

A Docker container is a runtime instance of a Docker image. They can be created by instantiating the image.

</details>
<details>
<summary> 
 
## Docker - Container lifecycle
</summary><br>

There are five essential phases in the Docker container lifecycle: **created**, **started**, **paused**, **exited**, and **dead**.

![Container life cycle](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/containers_life_cycle.jpg)

### 📦 Docker Container Lifecycle States

---

#### 🟢 The Created State

The **"created"** state is the first stage. When a container is created with the `docker create` command or a comparable API call, it reaches this phase. The container is not yet running when it is in the "created" state, but it does exist as a static entity with all of its configuration settings defined.

At this point, Docker reserves the storage volumes and network interfaces that the container needs, but the processes inside the container have not yet begun.

---

#### ▶️ The Started State

The **"started"** or **"running"** state is the next stage of the lifecycle. When a container is started with the `docker start` command or an equivalent API call, it enters this stage.

When a container is in the "started" state, its processes are launched and it starts running the service or application that is specified in its image. While they carry out their assigned tasks, containers in this state actively use **CPU, memory, and other system resources**.

---

#### ⏸️ The Paused State

Throughout their lifecycle, containers may also go into a **"paused"** state. When a container is paused with the `docker pause` command, its processes are suspended, thereby stopping its execution.

A container that is paused keeps its resource allotments and configuration settings but is not in use. This state helps with **resource conservation and debugging** by momentarily stopping container execution without completely stopping it.

---

#### 🛑 The Exited State

A container in the **"exited"** state has finished executing and has left its primary process. Containers can enter this state when they finish the tasks they are intended to complete or when they run into errors that force them to terminate.

A container that has been "exited" stays stopped, keeping its resources and configuration settings but ceasing to run any processes. In this condition, containers can be completely deleted with the `docker rm` command or restarted with the `docker start` command.

---

#### 💀 The Dead State

A container that is in the **"dead"** state has either experienced an **irreversible error** or been abruptly terminated. Critical errors in the containerized application, problems with the host system underneath, or manual intervention can all cause containers to enter this state.

When a container is in the "dead" state, it is not in use and the Docker daemon usually releases or reclaims its resources. To free up system resources, containers in this state need to be deleted using the `docker rm` command since they cannot be restarted.

</details>
<details>
<summary> 
 
## Important Docker Container Commands
</summary><br>

### 📋 Listing All Docker Containers

The Docker host's running containers can be listed using the `docker ps` command. You can use the `-a` or `--all` flag to show all containers, including stopped ones, as it only shows running containers by default.

```bash
$ docker ps
```
![docker ps](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_2.jpg)

This command displays the IDs, names, statuses, and other pertinent details of all containers that are currently running. It returns an empty list if no containers are in use.

### ▶️ Running a Docker Container

The primary command for starting and creating Docker containers is `docker run`. If the image isn't already available locally, Docker pulls it from a registry when you run this command. It then starts a fresh container instance by generating one based on that image.

With the help of this command, you can specify several options, including volume mounts, environment variables, port mappings, and more, to tailor the container's configuration to your requirements.

```bash
$ docker run -d -p 8080:80 nginx
```
![docker run](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_3.jpg)

In this case, the detached mode (`-d`) of the `docker run` command creates a new container based on the `"nginx"` image and runs it in the background. Additionally, it maps host port `8080` to container port `80` (`-p 8080:80`), granting access to the **NGINX** web server housed within the container.

### 🛑 Stopping a Docker Container

A container can be gracefully stopped by using the `docker stop` command, which signals the container's main process with a `SIGTERM`. This enables the container to finish any cleanup operations — such as saving state or cutting off network connections — before shutting down.

```bash
$ docker stop my_container
```
![docker stop](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_4.jpg)

This command stops the `"my_container"` container that is currently operating. Docker waits for the container to gracefully end its life for a configurable duration (10 seconds by default). Docker will automatically terminate the container with a `SIGKILL` signal if it does not stop within this time limit.

### ⏸️ Pausing a Running Container

A running container's processes can be momentarily suspended, or its execution paused, with the `docker pause` command. This can be helpful for temporarily freeing up system resources, debugging, and troubleshooting problems.

```bash
$ docker pause my_container
```
![docker pause](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_5.jpg)

This command stops the container `"my_container"` from running. The container uses no CPU or memory when it is paused because its processes are frozen. The container does, however, keep its resource allocation and configuration settings.

### ▶️ Resuming a Docker Container

When a container is paused, its processes can be carried out again by using the `docker unpause` command. By using this command, the container returns to its initial state and undoes the effects of the `docker pause` command.

```bash
$ docker unpause my_container
```
![docker unpause](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_6.jpg)

The above command resumes the paused container `"my_container"`'s execution and permits its processes to carry on as usual.

### 🔁 Restarting a Container

One easy way to quickly stop and restart an operating container is with the `docker restart` command. It is frequently used to force a container to reinitialize after experiencing problems or to apply changes to the configuration of a running container.

```bash
$ docker restart my_container
```
![docker restart](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_7.jpg)

This command pauses and then resumes the execution of the container with the name `"my_container"`. The processes inside the container are stopped and then restarted upon restarting, enabling any modifications to take effect.

### 💻 Executing Commands in a Running Docker Container

To run a command inside an already-running container, use the `docker exec` command. It enables users to run arbitrary commands, like starting a shell session or carrying out a particular program, inside the environment of a container.

```bash
$ docker exec -it my_container bash
```
![docker exec](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_8.jpg)

This command opens the `"my_container"` container that is currently running in an interactive shell session (`bash`). In order to enable interactive input/output, the `-it` flags allocate a pseudo-TTY and maintain STDIN open even when it is not attached.

### 🗑️ Removing a Docker Container

To remove a Docker container or containers, you can use the `docker rm` command. The container(s) whose ID or name you wish to remove can be specified. This command only removes stopped containers by default; to forcefully remove running containers, you can use the `-f` or `--force` flag.

```bash
$ docker rm my_container
```
![docker rm](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_9.jpg)

The above command deletes the container with the name `"my_container"`. Unless the `-f` flag is used to force removal, the container must stop running before being removed.

### 🚮 Pruning Stopped Containers

To clear up disk space on the Docker host, you can use the `docker container prune` command to remove all stopped containers. It is a practical method of clearing out empty containers and recovering resources.

```bash
$ docker container prune
```
![docker prune](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_10.jpg)

Docker asks for confirmation before continuing, but you can ignore this prompt by passing it with the `-f` or `--force` flag.

```bash
$ docker container prune -f
```

### 🚀 Removing all Containers(Running or stopped)

If you want to remove all Docker containers together, you can chain two commands — `docker ps -aq`, which is used to obtain a list of all container IDs, and combine it with the `docker rm` command to remove all containers, including running containers.

```bash
$ docker rm $(docker ps -aq)
```
![docker rm1](https://github.com/srirymec/devops-sre-learning/blob/main/docker/images/docker_containers_11.jpg)

The above command removes every container on the Docker host, regardless of whether it is running or stopped.

</details>
<details>
<summary> 
 
 ## Docker Compose
 </summary><br>

Docker Compose is a tool specifically designed to simplify the management of multi-container Docker applications. It uses a YAML file in which the definition of services, networks, and volumes that an application requires is described.

Basically, through the `docker-compose.yml` file, we define the configuration for each container: build context, environment variables, ports to be exposed, and the relationship between services. Running all the defined services can be done by one command, the `docker-compose up` command, ensuring they work together accordingly.

### Docker Compose File Mechanism (YAML)

```
version: '3.8'
services:
   web:
      image: nginx:latest
      ports:
         - "80:80"
      volumes:
         - web-data:/var/www/html
      networks:
         - webnet

   database:
      image: mysql:latest
      environment:
         MYSQL_ROOT_PASSWORD: example
      volumes:
         - db-data:/var/lib/mysql
      networks:
         - webnet

networks:
   webnet:
      driver: bridge

volumes:
   web-data:
   db-data:
```

#### Key Elements of YAML File

- **Version**  
  This defines the format of the Docker Compose file so that it ensures compatibility with different Docker Compose features.

- **Services**  
  Contains lists of all services (containers) composing the application.

- **Networks**  
  It will specify custom networks for inter-container communication and may specify the configuration options and network drivers.

- **Volumes**  
  Declares shared volumes that are used to allow persistent storage.

### Docker Compose Services

Services in Docker Compose represent the containers comprising the user's application. Each service is defined in the `services` section of the `docker-compose.yml` file and has its configuration such as a Docker image to use, variables within the environment, ports, volumes, and network settings.

```
services:
   app:
      image: myapp:latest
      build: .
      ports:
         - "8080:80"
      volumes:
         - app-data:/usr/src/app
      environment:
         - NODE_ENV=production
      depends_on:
         - db

   db:
      image: postgres:latest
      environment:
         POSTGRES_PASSWORD: example
```

#### Key Service Configuration Options

- **Image**  
  Specifies the Docker image that should be used for the service.

- **Build**  
  Specifies the directory for a build context, allowing the specification to make an image or not pull from a registry.

- **Ports**  
  Maps host ports to the container.

- **Volumes**  
  Attaches volumes to your service for persistent storage.

- **Environment**  
  Specifies environment variables for the service.

- **Depends_on**  
  Defines service dependencies so they are started in the appropriate order.

### Docker Compose Networks

Docker Compose networks allow for communication between services. By default, Docker Compose defines a single network for all services described under `docker-compose.yml`. However, you can define your custom networks to better control inter-service communication.

```
networks:
   frontend:
      driver: bridge
   backend:
      driver: bridge

services:
   web:
      networks:
         - frontend

   api:
      networks:
         - frontend
         - backend

   db:
      networks:
         - backend
```

#### Best Network Configuration Options

- **driver**  
  Specifies the driver to be used in the network (e.g., `bridge`, `overlay`).

- **driver_opts**  
  Options for the network driver.

- **ipam**  
  Specifies the IP address management configurations like subnets and IP ranges.

### Docker Compose Volumes

Docker Compose uses **volumes** to persist data created or consumed by Docker containers. The `volumes` section in the `docker-compose.yml` file defines all the volumes attached to services for storing data in a way that its lifecycle exists outside of the container.

```
volumes:
   db-data:
   app-data:
      external: true

services:
   database:
      image: postgres:latest
      volumes:
         - db-data:/var/lib/postgresql/data

   app:
      image: myapp:latest
      volumes:
         - app-data:/usr/src/app
```

#### Key Volume Configuration Options

- **external**  
  Indicates whether the volume is created outside Docker Compose.

- **driver**  
  Specifies the volume driver to use.

- **driver_opts**  
  Options to configure the volume driver.

### Docker Compose Environment Variables

Environment variables can be used in Docker Compose to pass configuration settings into services. These can be defined within a service's configuration as part of the `environment` section or loaded from an external file.

```
services:
   web:
      image: myapp:latest
      environment:
         - NODE_ENV=production
         - API_KEY=12345

   database:
      image: postgres:latest
      env_file:
         - .env
```
In **.env** file −

```
POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypassword
POSTGRES_DB=mydatabase
```

#### Basic Ways to Set Environment Variables

- **Inline**  
  Register environment variables within your service definition.

- **env_file**  
  This command allows environment variables to be loaded from an external file.

### Example docker-compose.yml for setting up a MySQL database

```
version: '3.8'

services:
  db:
    image: mysql:8.0
    container_name: mysql_container
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_root_password
      MYSQL_DATABASE: your_database_name
      MYSQL_USER: your_user
      MYSQL_PASSWORD: your_user_password
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```
</details>
<details>
<summary> 
 
 ## Docker File
 </summary><br>

A Dockerfile is a document that contains a series of instructions used to automatically build a Docker image. Each instruction in a Dockerfile represents a step in the image creation process, such as specifying a base image, copying files, installing dependencies, or setting environment variables. 

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

#### Using default docker file name

Dockerfile
```
FROM python:3.11-slim
COPY app.py /app/app.py
WORKDIR /app
CMD ["python", "app.py"]

```

**To build the image from the above docker we use docker build commabd**

```
docker build -t my-python-app .

```

#### Using custom docker file name

MyDockerfile
```
FROM python:3.11-slim
COPY app.py /app/app.py
WORKDIR /app
CMD ["python", "app.py"]<img width="268" height="108" alt="image" src="https://github.com/user-attachments/assets/8452d685-4160-4c65-b5cd-96cd2d641a09" />

```

**To build the image from the above docker we use docker build commabd**

```
docker build -t my-python-app -f MyDockerfile .

```

#### Passing build time arguments

Dockerfile
```
ARG VERSION=1.0.0 (Default value)
FROM centos
CMD echo "Version is $VERSION"

```

**To build the image from the above docker we use docker build commabd**

```
docker build -t my-python-app --build-arg VERSION=1.2.3 .

```

</details>

 ## Topic Name
 </summary><br>


</details>
