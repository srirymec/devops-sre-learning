# Docker Interview Questions

## :baby: beginner

<details>
<summary>What is Docker? What are you using it for?</summary><br><b>
</b></details>

<details>
<summary>How containers are different from VMs?</summary><br><b>

The primary difference between containers and VMs is that containers allow you to virtualize
multiple workloads on the operating system while in the case of VMs the hardware is being virtualized to
run multiple machines each with its own OS.
</b></details>

<details>
<summary>In which scenarios would you use containers and in which you would prefer to use VMs?</summary><br><b>

You should choose VMs when:
  * you need run an application which requires all the resources and functionalities of an OS
  * you need full isolation and security

You should choose containers when:
  * you need a lightweight solution that quickly starts
  * Running multiple versions or instances of a single application
</b></details>

<details>
<summary>Explain Docker architecture</summary><br><b>
</b></details>

<details>
<summary>Describe in detail what happens when you run `docker run hello-world`?</summary><br><b>

Docker CLI passes your request to Docker daemon.
Docker daemon downloads the image from Docker Hub
Docker daemon creates a new container by using the image it downloaded
Docker daemon redirects output from container to Docker CLI which redirects it to the standard output
</b></details>

<details>
<summary>How do you run a container?</summary><br><b>
</b></details>

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
