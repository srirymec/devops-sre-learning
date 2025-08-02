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

**K8 Cluster Components**

![k8-cluster-components](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/K8s-cluster-components.jpg)

**K8 Architecture**

![k8-architecture](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/K8s-Architecture.jpg)

A Kubernetes cluster consists of a **control plane** plus a set of worker machines, called **nodes**, that run containerized applications. Every cluster needs at least one worker node in order to run Pods.

The worker node(s) host the Pods that are the components of the application workload. The control plane manages the worker nodes and the Pods in the cluster. In production environments, the control plane usually runs across multiple computers and a cluster usually runs multiple nodes, providing fault-tolerance and high availability.

- ***Control plane components***

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


- ***Node components***

  - **kubelet:**

    An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

  - **kube-proxy (optional):**

     kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

  - **Container runtime:**

     A fundamental component that empowers Kubernetes to run containers effectively. Kubernetes supports container runtimes such as containerd, CRI-O, and any other             implementation of the Kubernetes CRI (Container Runtime Interface).

</details>

<details>
<summary> 
 
 ## Kubernetes Terminologies
 </summary><br>

Kubernetes’ Terminology: Terminology which helps to understand each objects in Kubernetes cluster to 
deploy and manage containers.

- **Service:** The Service operator requests existing IP addresses and information from the endpoint operator and will 
manages network connectivity based on labels. A Service is used to communicate between pods, namespaces, and outside 
the cluster.
- **Endpoints:** An endpoint is a resource that gets IP addresses of one or more pods dynamically assigned to it, along with a 
port.
- **Labels:** To easily manage thousands of Pods across of many nodes could be difficult. To make management easier, we can 
use labels, arbitrary string which becomes part of the objects metadata. These can then be used when checking or changing 
the state of objects.
- **Taints:** Nodes can have taints to discourage or stop pods to be assigned or placed on that node. 
- **Toleration:** Tolerations allow the scheduler to schedule pods with matching taints. Tolerations allow scheduling but 
don't guarantee scheduling: the scheduler also evaluates other parameters as part of its function. Taints and tolerations 
work together to ensure that pods are not scheduled onto inappropriate nodes.
- **Affinity:** In Kubernetes, affinity is a set of rules that give hints to the scheduler about where to place pods.
- **Annotation:** A key-value pair that is used to attach arbitrary non-identifying metadata to objects.
- **cgroup (control group):** A group of Linux processes with optional resource isolation, accounting and limits.
cgroup is a Linux kernel feature that limits, accounts for, and isolates the resource usage (CPU, memory, disk I/O, network)
for a collection of processes.
- **Cluster:** A set of worker machines, called nodes, that run containerized applications. Every cluster has at least one worker 
node.
- **DaemonSet:** Ensures a copy of a Pod is running across a set of nodes in a cluster. Used to deploy system daemons such as 
log collectors and monitoring agents that typically must run on every Node.
- **Ephemeral Container:** A Container type that you can temporarily run inside a Pod. If you want to investigate a Pod 
that's running with problems, you can add an ephemeral container to that Pod and carry out diagnostics. Ephemeral 
containers have no resource or scheduling guarantees, and you should not use them to run any part of the workload itself.
- **Init Container:** One or more initialization containers that must run to completion before any app containers run. 
Initialization (init) containers are like regular app containers, with one difference: init containers must run to completion 
before any app containers can start. Init containers run in series: each init container must run to completion before the 
next init container begins.
- **Kubectl:** Command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API. You 
can use kubectl to create, inspect, update, and delete Kubernetes objects.
- **LimitRange:** Provides constraints to limit resource consumption per Containers or Pods in a namespace. LimitRange
limits the quantity of objects that can be created by type, as well as the amount of compute resources that may be 
requested/consumed by individual Containers or Pods in a namespace.
- **Logging:** Logs are the list of events that are logged by cluster or application. Application and systems logs can help you 
understand what is happening inside your cluster. The logs are particularly useful for debugging problems and monitoring 
cluster activity.
- **Namespace:** An abstraction used by Kubernetes to support isolation of groups of resources within a single cluster. 
Namespaces are used to organize objects in a cluster and provide a way to divide cluster resources. Names of resources 
need to be unique within a namespace, but not across namespaces. Namespace-based scoping is applicable only for 
namespaced objects (e.g., Deployments, Services, etc) and not for cluster-wide objects (e.g., StorageClass, Nodes, 
PersistentVolumes, etc).
- **Node:** A node is a worker machine in Kubernetes. A worker node may be a VM or physical machine, depending on the 
cluster. It has local daemons or services necessary to run Pods and is managed by the control plane. 
- **RBAC (Role-Based Access Control):** Manages authorization decisions, allowing admins to dynamically configure 
access policies through the Kubernetes API. RBAC utilizes roles, which contain permission rules, and role bindings, which 
grant the permissions defined in a role to a set of users.
 </details>

<details>
<summary> 
 
## Kubernetes Namespace
</summary><br>

Namespace provides an additional qualification to a resource name. This is helpful when multiple teams are using the same cluster and there is a potential of name collision. It can be as a virtual wall between multiple clusters.

Following are some of the important functionalities of a Namespace in Kubernetes −

- Namespaces help pod-to-pod communication using the same namespace.

- Namespaces are virtual clusters that can sit on top of the same physical cluster.

- They provide logical separation between the teams and their environments.

### Create a Namespace

`kubectl create f namespace.yml `

### Using Namespace in Service - Example

```
apiVersion: v1
kind: Service
metadata:
   name: elasticsearch
   namespace: elk
   labels:
      component: elasticsearch
spec:
   type: LoadBalancer
   selector:
      component: elasticsearch
   ports:
   - name: http
      port: 9200
      protocol: TCP
   - name: transport
      port: 9300
      protocol: TCP
```
</details>

<details>
<summary> 
 
## Kubernetes Pod
</summary><br>

- Pods are the **smallest deployable units** in Kubernetes.
- Pods are **ephemeral** in nature; they can be created, deleted, and updated.
- A pod can have **more than one container**; there is no limit to how many containers you can run inside a pod.
- Each pod gets a **unique IP address.**
- Pods communicate with each other using the IP address.
- Containers inside a pod connect using **localhost** on different ports.
- Containers running inside a pod should have different port numbers to avoid port clashes.
- You can set CPU and memory resources for each container running inside the pod.
- Containers inside a pod **share the same volume mount.**
- All the containers inside a pod are scheduled on the same node; It cannot span multiple nodes.
- If there is more than one container, during the pod startup all the main containers start in parallel. Whereas the init containers inside the pod run in sequence.

![k8-pod](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/k8-pod.PNG)

**Containers inside the Kubernetes pod share the following,**

- **Network namespace** - All containers inside a pod communicate via localhost.
- **IPC namespace** - All containers use a shared interprocess communication namespace.
- **UTS namespace** - All containers share the same hostname.

**What is not shared between containers inside a pod?**

- By default, the **PID namespace** is not shared however kubernetes provide options to enable process sharing between containers inside the pod using `shareProcessNamespace` Option.
- The mount namespace is not shared between containers. Each container has its own private filesystem and directories. However, the **pod mount volumes** are shared between containers.
 
### Kubernetes Pod YAML (Object Definition)

Here is an example Pod YAML that creates an Nginx web server pod. This YAML is nothing but a declarative desired state of a pod.

```
apiVersion: v1
kind: Pod
metadata:
  name: web-server-pod
  labels:
    app: web-server
    environment: production
  annotations:
    description: This pod runs the web server
spec:
  containers:
  - name: web-server
    image: nginx:latest
    ports:
    - containerPort: 80
```

Let's take a look at the Kubernetes pod object.

| Parameter   | Description |
|-------------|-------------|
| `apiVersion` | The API version of the pod. In our case, it's `v1`. |
| `kind`       | Kind of the object. It's `Pod`. |
| `metadata`   | Metadata is used to uniquely identify and describe the pod:<br>• **labels** – Set of key-value pairs to represent the pod. This is similar to tagging in cloud environments. Every object must be labeled with standard labels. It helps in grouping the objects.<br>• **name** – Name of the pod.<br>• **namespace** – Namespace for the pod.<br>• **annotations** – Additional data in key-value format. |
| `spec`       | Under the `spec` section, we declare the desired state of the pod. These are the specifications of the containers we want to run inside the pod. |
| `containers` | Under `containers`, we declare the desired state of the containers inside the pod: the container image, exposed port, etc. |

### Creating the Pod

Create a file named `nginx.yaml` with the following contents.

```
apiVersion: v1
kind: Pod
metadata:
  name: web-server-pod
  labels:
    app: web-server
    environment: production
  annotations:
    description: This pod runs the web server
spec:
  containers:
  - name: web-server
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

Now, to deploy the manifest, you need to execute the following kubectl command with the file name.

`kubectl create -f nginx.yaml`

Once the pod is deployed you will see the pod **Running** status as shown below. In our example, we have only one container inside the pod. So it shows `1/1` ready and running.

![k8-pod-1](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/k8-pod-1.PNG)
 
### Describe a Pod

If you want to know all the **details of the running pod**, you can describe the pod using kubectl.

`kubectl describe pod web-server-pod`

In the following output, you can see all the details about the pod. Its IP address, namespace, container details, QoS class, etc.

![k8-pod-2](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/k8-pod-2.PNG)
 
### Access Pod Shell

There are many use cases where you need terminal access to the pod. One main use case is debugging and troubleshooting.

You can access the shell of web-server-pod using the following command.

`kubectl exec -it web-server-pod -- /bin/sh`

In the following output, I am executing whoami command inside the pod.

![k8-pod-3](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/k8-pod-3.PNG)
 
### Pod Lifecycle

Following are the pod lifecycle phases.

- **1. Pending:** It means the pod creation request is successful, however, the scheduling is in process. For example, it is in the process of downloading the container image.
- **2. Running:** The pod is successfully running and operating as expected. For example, the pod is service client requests.
- **3. Succeeded:** All containers inside the pod have been successfully terminated. For example, the successful completion of a CronJob object.
- **4. Failed:** All pods are terminated but at least one container has terminated in failure. For example, the application running inside the pod is unable to start due to a config issue and the container exits with a non-zero exit code.
- **5. Unknown:** Unknown status of the pod. For example, the cluster is unable to monitor the status of the pod.
 
### Pod Associated Objects

When it comes to running applications on Kubernetes, we don't run an individual pod. Because Kubernetes is all about **scaling and maintaining** the availability of pods.
Kubernetes has different types of objects associated with pods for different use cases.

The following are important pod-associated objects.

- **1. Replicaset:** To maintain a stable set of Pods replicas running at any given time.
- **2. Deployment:** To run stateless applications like web servers, APIs, etc
- **3. StatefulSets:** To run stateful applications like distributed databases.
- **4. Daemonsets:** To run agents on all the Kubernetes nodes.
- **5. Jobs:** For batch processing
- **6. CronJobs:** Scheduled Jobs

</details>


