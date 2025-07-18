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

![Container VS VM](https://github.com/srirymec/devops-sre-learning/blob/main/docker/container%20vs%20vms.jpg)

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

![Docker architecture](https://github.com/srirymec/devops-sre-learning/blob/main/docker/docker_architecture.jpg)

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

![Docker hub](https://github.com/srirymec/devops-sre-learning/blob/main/docker/docker_hub_1.jpg)

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

![Container life cycle](https://github.com/srirymec/devops-sre-learning/blob/main/docker/containers_life_cycle.jpg)

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

This command displays the IDs, names, statuses, and other pertinent details of all containers that are currently running. It returns an empty list if no containers are in use.

### ▶️ Running a Docker Container

The primary command for starting and creating Docker containers is `docker run`. If the image isn't already available locally, Docker pulls it from a registry when you run this command. It then starts a fresh container instance by generating one based on that image.

With the help of this command, you can specify several options, including volume mounts, environment variables, port mappings, and more, to tailor the container's configuration to your requirements.

```bash
$ docker run -d -p 8080:80 nginx
```

In this case, the detached mode (`-d`) of the `docker run` command creates a new container based on the `"nginx"` image and runs it in the background. Additionally, it maps host port `8080` to container port `80` (`-p 8080:80`), granting access to the **NGINX** web server housed within the container.

### 🛑 Stopping a Docker Container

A container can be gracefully stopped by using the `docker stop` command, which signals the container's main process with a `SIGTERM`. This enables the container to finish any cleanup operations — such as saving state or cutting off network connections — before shutting down.

```bash
$ docker stop my_container
```
This command stops the `"my_container"` container that is currently operating. Docker waits for the container to gracefully end its life for a configurable duration (10 seconds by default). Docker will automatically terminate the container with a `SIGKILL` signal if it does not stop within this time limit.

### ⏸️ Pausing a Running Container

A running container's processes can be momentarily suspended, or its execution paused, with the `docker pause` command. This can be helpful for temporarily freeing up system resources, debugging, and troubleshooting problems.

```bash
$ docker pause my_container
```
This command stops the container `"my_container"` from running. The container uses no CPU or memory when it is paused because its processes are frozen. The container does, however, keep its resource allocation and configuration settings.

### ▶️ Resuming a Docker Container

When a container is paused, its processes can be carried out again by using the `docker unpause` command. By using this command, the container returns to its initial state and undoes the effects of the `docker pause` command.

```bash
$ docker unpause my_container
```
The above command resumes the paused container `"my_container"`'s execution and permits its processes to carry on as usual.

### 🔁 Restarting a Container

One easy way to quickly stop and restart an operating container is with the `docker restart` command. It is frequently used to force a container to reinitialize after experiencing problems or to apply changes to the configuration of a running container.

```bash
$ docker restart my_container
```

This command pauses and then resumes the execution of the container with the name `"my_container"`. The processes inside the container are stopped and then restarted upon restarting, enabling any modifications to take effect.

### 💻 Executing Commands in a Running Docker Container

To run a command inside an already-running container, use the `docker exec` command. It enables users to run arbitrary commands, like starting a shell session or carrying out a particular program, inside the environment of a container.

```bash
$ docker exec -it my_container bash
```
This command opens the `"my_container"` container that is currently running in an interactive shell session (`bash`). In order to enable interactive input/output, the `-it` flags allocate a pseudo-TTY and maintain STDIN open even when it is not attached.

### 🗑️ Removing a Docker Container

To remove a Docker container or containers, you can use the `docker rm` command. The container(s) whose ID or name you wish to remove can be specified. This command only removes stopped containers by default; to forcefully remove running containers, you can use the `-f` or `--force` flag.

```bash
$ docker rm my_container
```

The above command deletes the container with the name `"my_container"`. Unless the `-f` flag is used to force removal, the container must stop running before being removed.

### 🚮 Pruning Stopped Containers

To clear up disk space on the Docker host, you can use the `docker container prune` command to remove all stopped containers. It is a practical method of clearing out empty containers and recovering resources.

```bash
$ docker container prune
```

Docker asks for confirmation before continuing, but you can ignore this prompt by passing it with the `-f` or `--force` flag.

```bash
$ docker container prune -f
```

### 🚀 Removing all Containers(Running or stopped)

If you want to remove all Docker containers together, you can chain two commands — `docker ps -aq`, which is used to obtain a list of all container IDs, and combine it with the `docker rm` command to remove all containers, including running containers.

```bash
$ docker rm $(docker ps -aq)
```
The above command removes every container on the Docker host, regardless of whether it is running or stopped.

</details>
