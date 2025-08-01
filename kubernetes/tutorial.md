# Kubernetes Tutorial

## Prerequisites for this Kubernetes Tutorial

- Have good understanding of Container concept & Container Management Tool like Docker or Podman.
- Understanding of distributed system.
- Understanding of REST API
- Basic understanding of YAML

<details>
<summary> 
 
 ## Docker VS Kubernetes
 </summary><br>

 - Docker is containerization platform, whereas Kubernetes is container orchestration platform.
 - Containers are **Ephermal(Short lived)** in nature. If the container 1 takes all the resources of the host VM, nth container may not get the sufficient memory and may die.

   ![docker-on-host-vm](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/docker1.jpg)

| Topic              | Docker                                                                                     | Kubernetes                                                                                  |
|--------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| **Function**        | Docker is a tool that packages applications into containers for consistent behavior.       | Kubernetes automates the deployment, scaling, and management of containerized applications.  |
| **Key Features**    | - **Containerization**: Packages apps into standardized units.                            | - **Container Orchestration**: Manages containers across multiple machines.                 |
|                    | - **Portability**: Containers run on any system with Docker support.                        | - **Scaling**: Dynamically adjusts resources based on demand.                               |
|                    | - **Resource Efficiency**: Containers share the host OS kernel.                            | - **Self-Healing**: Automatically restarts failed containers and redeploys them.             |
|                    | - **Development Focus**: Tools for building, testing, and deploying containers.            | - **Automation**: Automates operational tasks like deployment and scaling.                  |
| **When to Use**     | Ideal for developing, testing, and deploying individual applications or services.         | Best for complex, large-scale applications with many containers and high availability needs. |
| **Scope**           | Focuses on individual containers and their development.                                    | Focuses on orchestrating and managing clusters of containers.                               |
| **Complexity**      | Simpler to set up and use, focused on single-container applications.                       | More complex, requires knowledge of container orchestration and cluster management.        |
| **Use Cases**       | Used for developing and testing applications.                                              | Used for deploying and managing applications in production, especially at scale.            |


</details>

<details>
<summary> 
 
 ## Features of Kubernetes
 </summary><br>
 
According to the Kubernetes.io website, Features of Kubernetes are:
- **Automated rollouts and rollbacks:** Kubernetes progressively rolls out changes to your application or its 
configuration, while monitoring application health to ensure it doesn't kill all your instances at the same time. If 
something goes wrong, Kubernetes will rollback the change for you. Take advantage of a growing ecosystem of 
deployment solutions.
- **Service discovery and load balancing:** No need to modify your application to use an unfamiliar service discovery 
mechanism. Kubernetes gives Pods their own IP addresses and a single DNS name for a set of Pods and can loadbalance across them.
- **Storage orchestration:** Automatically mount the storage system of your choice, whether from local storage, a public 
cloud provider such as AWS or GCP, or a network storage system such as NFS, iSCSI, Ceph, Cinder.
- **Self-healing:** Restarts containers that fail, replaces and reschedules containers when nodes die, kills containers that 
don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.
Secret and configuration management: Deploy and update secrets and application configuration without 
rebuilding your image and without exposing secrets in your stack configuration.
- **Automatic bin packing:** Automatically places containers based on their resource requirements and other 
constraints, while not sacrificing availability. Mix critical and best-effort workloads in order to drive up utilization and 
save even more resources.
- **Batch execution:** In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers 
that fail, if desired.
- **Horizontal scaling:** Scale your application up and down with a simple command, with a UI, or automatically based 
on CPU usage.
- **IPv4/IPv6 dual-stack:** Allocation of IPv4 and IPv6 addresses to Pods and Services
- **Designed for extensibility:** Add features to your Kubernetes cluster without changing upstream source code.

</details>

<details>
<summary> 
 
 ## Kubernetes architecture
 </summary><br>

</details>
