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
