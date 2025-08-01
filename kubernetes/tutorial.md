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

A Kubernetes cluster consists of a **control plane** plus a set of worker machines, called **nodes**, that run containerized applications. Every cluster needs at least one worker node in order to run Pods.

The worker node(s) host the Pods that are the components of the application workload. The control plane manages the worker nodes and the Pods in the cluster. In production environments, the control plane usually runs across multiple computers and a cluster usually runs multiple nodes, providing fault-tolerance and high availability.

- Control plane components

  - **kube-apiserver:**
    The API server is a component of the Kubernetes control plane that exposes the Kubernetes API.

  - **etcd:**
    Consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.

  - **kube-scheduler:**
    Control plane component that watches for newly created Pods with no assigned node, and selects a node for them to run on.

  - **kube-controller-manager:**
    Control plane component that runs controller processes.
    
    There are many different types of controllers. Some examples of them are:

    - **Node controller:** Responsible for noticing and responding when nodes go down.
    - **Job controller:** Watches for Job objects that represent one-off tasks, then creates Pods to run those tasks to completion.
    - **EndpointSlice controller:** Populates EndpointSlice objects (to provide a link between Services and Pods).
    - **ServiceAccount controller:** Create default ServiceAccounts for new namespaces.

  - **cloud-controller-manager:**

    A Kubernetes control plane component that embeds cloud-specific control logic. The cloud controller manager lets you link your cluster into your cloud provider's API,      and separates out the components that interact with that cloud platform from components that only interact with your cluster.


- Node components

  - **kubelet:**

    An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

  - **kube-proxy (optional):**

     kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

  - **Container runtime:**

     A fundamental component that empowers Kubernetes to run containers effectively. Kubernetes supports container runtimes such as containerd, CRI-O, and any other             implementation of the Kubernetes CRI (Container Runtime Interface).


</details>
