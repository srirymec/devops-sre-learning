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
<summary>What best practices are you familiar related to working with containers?</summary><br><b>
</b></details>

<details>
<summary>What `docker commit` does?. When will you use it?</summary><br><b>
</b></details>

<details>
<summary>How would you transfer data from one container into another?</summary><br><b>
</b></details>

<details>
<summary>What happens to data of the container when a container exists?</summary><br><b>
</b></details>

<details>
<summary>Explain what each of the following commands do:

  * docker run
  * docker rm
  * docker ps
  * docker build
  * docker commit</summary><br><b>
</b></details>

<details>
<summary>How do you remove old, non running, containers?</summary><br><b>
</b></details>

##### Dockerfile

<details>
<summary>What is Dockerfile</summary><br><b>
</b></details>

<details>
<summary>What is the difference between ADD and COPY in Dockerfile?</summary><br><b>
</b></details>

<details>
<summary>What is the difference between CMD and RUN in Dockerfile?</summary><br><b>
</b></details>

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
