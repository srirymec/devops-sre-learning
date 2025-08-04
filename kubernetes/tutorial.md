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

<details>
<summary> 
 
## What is an Init Container?
</summary><br>

- Init Containers are containers that **start and run to completion** before starting the main containers in the pod. It acts as a preparatory step, allowing us to perform initialization tasks, configure prerequisites, or configure dependencies required by the application in the main containers.

 ![init-container-1](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/init-container-1.PNG)

 - Let's say we have an application that needs a secret to connect to an API. You can't hardcode this secret into the application or use Kubernetes secrets due to compliance reasons. In this case, **you can use an init container** to fetch the secret from a secret management service like Vault or AWS Secrets Manager and write it to a location in the pod where the application container can access it.

 ![init-container-2](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/init-container-2.PNG)

- This way when the application pod starts, it will have access to the secret to connect to the API.

- To put it simply, init containers can ensure your applications are always properly configured and initialized before they are started.

</details>
<details>
<summary> 
 
## What is a DaemonSet In Kubernetes?
</summary><br>

- The DaemonSet object is designed to **ensure that a single pod runs on each worker node**. This means you cannot scale daemonset pods in a node. And for some reason, if the daemonset pod gets deleted from the node, the daemonset controller creates it again.

- Let's look at an example. If there are 500 worker nodes and you deploy a daemonset, the daemonset controller will run one pod per worker node by default. That is a total of 500 pods. However, using **nodeSelector, nodeAffinity, Taints, and Tolerations**, you can restrict the daemonset to run on specific nodes.

- For example, in a cluster of 100 worker nodes, one might have 20 worker nodes labeled GPU enabled to run batch workloads. And you should run a pod on those 20 worker nodes. In this case, you can deploy the pod as a Daemonset using a node selector. We will look at it practically later in this guide.

- Another example is that you have a specific number of worker nodes dedicated to platform tools (ingress, monitoring, logging, etc.) and want to run Daemonset related to platform tools only on the nodes labeled as platform tools. In this case, you can use the nodeSelector to run the daemonset pods only on the worker nodes dedicated to platform tooling.

### Kubernetes DaemonSet Use Cases

- **Cluster Log Collection:** Running a log collector on every node to centralize Kubernetes logging data. Eg:   fluentd , logstash, fluentbit
- **Cluster Monitoring:** Deploy monitoring agents, such as Prometheus Node Exporter, on every node in the cluster to collect and expose node-level metrics. This way prometheus gets all the required worker node metrics.
- **Security and Compliance:** Running CIS Benchmarks on every node using tools like kube-bench. Also deploy security agents, such as intrusion detection systems or vulnerability scanners, on specific nodes that require additional security measures. For example, nodes that handle PCI, and PII-compliant data.
- **Storage Provisioning:** Running a storage plugin on every node to provide a shared storage system to the entire cluster.
- **Network Management:** Running a network plugin or firewall on every node to ensure consistent network policy enforcement. For example, the Calico CNI plugin runs as Daemonset on all the nodes.

### DaemonSet Example

Like other Kubernetes objects, `DaemonSet` also gets configured by using YAML files.

```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
  namespace: logging
  labels:
    app: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd
  template:
    metadata:
      labels:
        name: fluentd
    spec:
      containers:
      - name: fluentd-elasticsearch
        image: quay.io/fluentd_elasticsearch/fluentd:v2.5.2
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
```

Let's understand the manifest file.

- **`apiVersion`:** `apps/v1` for `DaemonSet`
- **`kind`:** `DaemonSet` such as Pod, Deployment, and Service
- **`metadata`:** Put the name of the `DaemonSet`, mention namespace, annotations, and labels. In our case `DaemonSet's` name is fluentd.
- **`spec.selector`:** The selector for the pods is managed by the `DaemonSet`. This value must be a label specified in the pod template. This value is immutable.
- **`spec.template`:** This is a required field that specifies a pod template for the `DaemonSet` to use. Along with all the required fields for containers. It has everything of pod schema except `apiVersion` and `kind`.

</details>


<details>
<summary> 
 
## Kubernetes - Service
</summary><br>

A service can be defined as a logical set of pods. It can be defined as an abstraction on the top of the pod which provides a single IP address and DNS name by which pods can be accessed.

### Example service yaml

```
apiVersion: v1
kind: Service
metadata:
   name: appname
   labels:
      k8s-app: appname
spec:
   type: NodePort
   ports:
   - port: 8080
      nodePort: 31999
      name: omninginx
   selector:
      k8s-app: appname
      component: nginx
      env: env_name
```
</details>

<details>
<summary> 
 
## Kubernetes - Replication Controller
</summary><br>

Replication Controller is one of the key features of Kubernetes, which is responsible for managing the pod lifecycle. It is responsible for making sure that the specified number of pod replicas are running at any point of time. 

```
apiVersion: v1
kind: ReplicationController --------------------------> 1
metadata:
   name: Tomcat-ReplicationController --------------------------> 2
spec:
   replicas: 3 ------------------------> 3
   template:
      metadata:
         name: Tomcat-ReplicationController
      labels:
         app: App
         component: neo4j
      spec:
         containers:
         - name: Tomcat- -----------------------> 4
         image: tomcat: 8.0
         ports:
            - containerPort: 7474 ------------------------> 5
```

- **1. Kind: ReplicationController** → In the above code, we have defined the kind as replication controller which tells the kubectl that the yaml file is going to be used for creating the replication controller.

- **2. name: Tomcat-ReplicationController** → This helps in identifying the name with which the replication controller will be created. If we run the kubctl, get rc < Tomcat-ReplicationController > it will show the replication controller details.

- **3. replicas: 3** → This helps the replication controller to understand that it needs to maintain three replicas of a pod at any point of time in the pod lifecycle.

- **4. name: Tomcat** → In the spec section, we have defined the name as tomcat which will tell the replication controller that the container present inside the pods is tomcat.

- **5. containerPort: 7474** → It helps in making sure that all the nodes in the cluster where the pod is running the container inside the pod will be exposed on the same port 7474.

</details>

<details>
<summary> 
 
## Kubernetes - Replica Sets
</summary><br>

- Replica Set ensures how many replica of pod should be running. It can be considered as a replacement of replication controller. 
- The key difference between the replica set and the replication controller is, the replication controller only supports equality-based selector whereas the replica set supports set-based selector.

```
apiVersion: extensions/v1beta1 --------------------->1
kind: ReplicaSet --------------------------> 2
metadata:
   name: Tomcat-ReplicaSet
spec:
   replicas: 3
   selector:
      matchLables:
         tier: Backend ------------------> 3
      matchExpression:
{ key: tier, operation: In, values: [Backend]} --------------> 4
template:
   metadata:
      lables:
         app: Tomcat-ReplicaSet
         tier: Backend
      labels:
         app: App
         component: neo4j
   spec:
      containers:
      - name: Tomcat
      image: tomcat: 8.0
      ports:
      - containerPort: 7474
```

- **1. apiVersion: extensions/v1beta1** → In the above code, the API version is the advanced beta version of Kubernetes which supports the concept of replica set.

- **2. kind: ReplicaSet** → We have defined the kind as the replica set which helps kubectl to understand that the file is used to create a replica set.

- **3. tier: Backend** → We have defined the label tier as backend which creates a matching selector.

- **4. {key: tier, operation: In, values: [Backend]}** → This will help matchExpression to understand the matching condition we have defined and in the operation which is used by **matchlabel** to find details.

</details>

<details>
<summary> 
 
## Kubernetes - Deployments
</summary><br>

- A Deployment provides declarative updates for Pods and ReplicaSets.
- You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. 

### Changing the Deployment

- **Updating** − The user can update the ongoing deployment before it is completed. In this, the existing deployment will be settled and new deployment will be created.

- **Deleting** − The user can pause/cancel the deployment by deleting it before it is completed. Recreating the same deployment will resume it.

- **Rollback** − We can roll back the deployment or the deployment in progress. The user can create or update the deployment by using **DeploymentSpec.PodTemplateSpec = oldRC.PodTemplateSpec**.


### Example deployment yaml

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
   name: Tomcat-ReplicaSet
spec:
   replicas: 3
   template:
      metadata:
         lables:
            app: Tomcat-ReplicaSet
            tier: Backend
   spec:
      containers:
         - name: Tomcatimage:
            tomcat: 8.0
            ports:
               - containerPort: 7474
```

### Create Deployment

`kubectl create f Deployment.yaml -record`

```
deployment "Deployment" created Successfully.
```

### Fetch the Deployment

`kubectl get deployments`

```
NAME           DESIRED     CURRENT     UP-TO-DATE     AVILABLE    AGE
Deployment        3           3           3              3        20s
```

### Check the Status of Deployment

`kubectl rollout status deployment/Deployment`

### Updating the Deployment

`kubectl set image deployment/Deployment tomcat=tomcat:6.0`

### Rolling Back to Previous Deployment

`kubectl rollout undo deployment/Deployment to-revision=2`

</details>

<details>
<summary> 
 
## Kubernetes - Volumes
</summary><br>

In Kubernetes, a volume can be thought of as a directory which is accessible to the containers in a pod.

### Persistent Volume and Persistent Volume Claim

- **Persistent Volume (PV)** − Its a piece of network storage that has been provisioned by the administrator. Its a resource in the cluster which is independent of any individual pod that uses the PV.

- **Persistent Volume Claim (PVC)** − The storage requested by Kubernetes for its pods is known as PVC. The user does not need to know the underlying provisioning. The claims must be created in the same namespace where the pod is created.

### Creating Persistent Volume

```
kind: PersistentVolume ---------> 1
apiVersion: v1
metadata:
   name: pv0001 ------------------> 2
   labels:
      type: local
spec:
   capacity: -----------------------> 3
      storage: 10Gi ----------------------> 4
   accessModes:
      - ReadWriteOnce -------------------> 5
      hostPath:
         path: "/tmp/data01" --------------------------> 6
```

In the above code, we have defined −

- **kind: PersistentVolume** → We have defined the kind as PersistentVolume which tells kubernetes that the yaml file being used is to create the Persistent Volume.
- **name: pv0001** → Name of PersistentVolume that we are creating.
- **capacity:** → This spec will define the capacity of PV that we are trying to create.
- **storage: 10Gi** → This tells the underlying infrastructure that we are trying to claim 10Gi space on the defined path.
- **ReadWriteOnce** → This tells the access rights of the volume that we are creating.
- **path: "/tmp/data01"** → This definition tells the machine that we are trying to create volume under this path on the underlying infrastructure.

### Creating PV

```
kubectl create f local-01.yaml

persistentvolume "pv0001" created
```

### Checking PV

```
kubectl get pv

NAME        CAPACITY      ACCESSMODES       STATUS       CLAIM      REASON     AGE
pv0001        10Gi            RWO         Available
```

### Describing PV

```
kubectl describe pv pv0001
```

### Creating Persistent Volume Claim

```
kind: PersistentVolumeClaim --------------> 1
apiVersion: v1
metadata:
   name: myclaim-1 --------------------> 2
spec:
   accessModes:
      - ReadWriteOnce ------------------------> 3
   resources:
      requests:
         storage: 3Gi ---------------------> 4
```

In the above code, we have defined −

- **kind: PersistentVolumeClaim** → It instructs the underlying infrastructure that we are trying to claim a specified amount of space.
- **name: myclaim-1** → Name of the claim that we are trying to create.
- **ReadWriteOnce** → This specifies the mode of the claim that we are trying to create.
- **storage: 3Gi** → This will tell kubernetes about the amount of space we are trying to claim.

### Creating PVC

```
kubectl create f myclaim-1

persistentvolumeclaim "myclaim-1" created
```

### Getting Details About PVC

```
kubectl get pvc

NAME        STATUS   VOLUME   CAPACITY   ACCESSMODES   AGE
myclaim-1   Bound    pv0001     10Gi         RWO       7s
```

### Describe PVC

```
kubectl describe pv pv0001
```

### Using PV and PVC with POD

```
kind: Pod
apiVersion: v1
metadata:
   name: mypod
   labels:
      name: frontendhttp
spec:
   containers:
   - name: myfrontend
      image: nginx
      ports:
      - containerPort: 80
         name: "http-server"
      volumeMounts: ----------------------------> 1
      - mountPath: "/usr/share/tomcat/html"
         name: mypd
   volumes: -----------------------> 2
      - name: mypd
         persistentVolumeClaim: ------------------------->3
         claimName: myclaim-1
```

In the above code, we have defined −

- **volumeMounts:** → This is the path in the container on which the mounting will take place.
- **Volume:** → This definition defines the volume definition that we are going to claim.
- **persistentVolumeClaim:** → Under this, we define the volume name which we are going to use in the defined pod.

  
</details>

<details>
<summary> 
 
## Helm Package Management in Kubernetes
</summary><br>



</details>

<details>
<summary> 
 
## Role-Based Access Control (RBAC) in Kubernetes
</summary><br>

**RBAC** is a security mechanism that helps us manage user permissions based on their roles. It ensures that only authorized users can access or modify resources in Kubernetes. It operates on four key components:

- **Role** − Defines what actions can be performed on which resources.
- **RoleBinding** − Assigns a Role to a user or group.
- **ClusterRole** − A Role that applies cluster-wide.
- **ClusterRoleBinding** − Grants ClusterRoles to users or groups.

Without RBAC, any user with access to the cluster can delete pods, modify configurations, or even shut down services. Thats a security nightmare!

With RBAC, we can:

- Restrict access to sensitive data.
- Prevent accidental or malicious actions.
- Organize permissions based on team responsibilities.

### Step 1: Enabling RBAC

RBAC is enabled by default in most modern Kubernetes distributions. To verify its status, run:

`kubectl api-versions | grep rbac.authorization.k8s.io`

If RBAC is enabled, well see the following output:

```
rbac.authorization.k8s.io/v1
```

If not, you can simply enable it in your Kubernetes API server using the **--authorization-mode=RBAC** flag.

### Step 2: Creating a Role

A Role in Kubernetes defines permissions within a specific namespace. Suppose we want to grant our developer team permission to list and get pods in the development namespace.

#### Create the Namespace

Before defining the Role, well first ensure that the development namespace exists:

```
$ kubectl create namespace development

namespace/development created
```

#### Create the Role Definition

**role.yaml**
```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: developer-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

Apply the role:

```
$ kubectl apply -f role.yaml

role.rbac.authorization.k8s.io/developer-role created

```

### Step 3: Binding a Role to a User

A RoleBinding links a Role to a user or group. Let's assign our developer-role to a user named alice.

**rolebinding.yaml**

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-rolebinding
  namespace: development
subjects:
- kind: User
  name: alice
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
```

Apply the RoleBinding:

```
$ kubectl apply -f rolebinding.yaml

role.rbac.authorization.k8s.io/developer-role created
```

### Step 4: Creating a ClusterRole

If we need a role to apply across all namespaces, we can simply create a ClusterRole instead. For instance, let's allow Alice to view all pods in the cluster.

**clusterrole.yaml**

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-viewer
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

Apply the ClusterRole:

```
$ kubectl apply -f clusterrole.yaml

clusterrole.rbac.authorization.k8s.io/cluster-viewer created
```

### Step 5: Binding a ClusterRole

Since this role applies cluster-wide, we can use a ClusterRoleBinding to grant Alice these permissions.

**clusterrolebinding.yaml**
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-viewer-binding
subjects:
- kind: User
  name: alice
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-viewer
  apiGroup: rbac.authorization.k8s.io
```

Apply the ClusterRoleBinding:

```
$ kubectl apply -f clusterrolebinding.yaml

clusterrolebinding.rbac.authorization.k8s.io/cluster-viewer-binding created
```

Now, Alice can list pods in any namespace.

### Step 6: Verifying RBAC Permissions

To confirm Alice's permissions, use **kubectl auth can-i:**

```
kubectl auth can-i list pods --namespace=development --as=alice
```

If permissions are set correctly, well see the following output:

```
yes
```

If Alice tries an unauthorized action, like deleting a pod:

```
kubectl auth can-i delete pods --namespace=development --as=alice
```

The output will be:

```
no
```

### Step 7: Managing and Auditing RBAC

#### Listing Existing Roles

To see all roles in a namespace:

```
$ kubectl get roles -n development

NAME             CREATED AT
developer-role   2025-03-06T17:13:24Z
```

For ClusterRoles:

```
$ kubectl get clusterroles

NAME                                                                   CREATED AT
admin                                                                  2025-02-25T10:07:12Z
argocd-application-controller                                          2025-02-27T11:38:34Z
argocd-applicationset-controller                                       2025-02-27T11:38:34Z
argocd-server                                                          2025-02-27T11:38:34Z
calico-cni-plugin                                                      2025-02-26T13:55:30Z
calico-kube-controllers                                                2025-02-26T13:55:30Z
calico-node                                                            2025-02-26T13:55:30Z
cluster-admin                                                          2025-02-25T10:07:11Z
cluster-viewer                                                         2025-03-06T17:25:05Z
edit                                                                   2025-02-25T10:07:12Z
kubeadm:get-nodes                                                      2025-02-25T10:07:18Z
system:aggregate-to-admin                                              2025-02-25T10:07:12Z
system:aggregate-to-edit                                               2025-02-25T10:07:12Z
system:aggregate-to-view                                               2025-02-25T10:07:12Z
system:auth-delegator                                                  2025-02-25T10:07:13Z
system:basic-user                                                      2025-02-25T10:07:12Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2025-02-25T10:07:13Z
system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   2025-02-25T10:07:13Z
system:certificates.k8s.io:kube-apiserver-client-approver              2025-02-25T10:07:13Z
system:certificates.k8s.io:kube-apiserver-client-kubelet-approver      2025-02-25T10:07:14Z
system:certificates.k8s.io:kubelet-serving-approver                    2025-02-25T10:07:13Z
system:certificates.k8s.io:legacy-unknown-approver                     2025-02-25T10:07:13Z
system:controller:attachdetach-controller                              2025-02-25T10:07:14Z
system:controller:certificate-controller                               2025-02-25T10:07:15Z
system:controller:clusterrole-aggregation-controller                   2025-02-25T10:07:14Z
system:controller:cronjob-controller                                   2025-02-25T10:07:14Z
system:controller:daemon-set-controller                                2025-02-25T10:07:14Z
```

#### Checking RoleBindings

To view RoleBindings in a namespace:

```
$ kubectl get rolebindings -n development

NAME                    ROLE                  AGE
developer-rolebinding   Role/developer-role   13m
```

For ClusterRoleBindings:

```
$ kubectl get clusterrolebindings

NAME                                                            ROLE                                                                               AGE
argocd-application-controller                                   ClusterRole/argocd-application-controller                                          7d5h
argocd-applicationset-controller                                ClusterRole/argocd-applicationset-controller                                       7d5h
argocd-server                                                   ClusterRole/argocd-server                                                          7d5h
calico-cni-plugin                                               ClusterRole/calico-cni-plugin                                                      8d
calico-kube-controllers                                         ClusterRole/calico-kube-controllers                                                8d
calico-node                                                     ClusterRole/calico-node                                                            8d
cluster-admin                                                   ClusterRole/cluster-admin                                                          9d
cluster-viewer-binding                                          ClusterRole/cluster-viewer                                                         9m52s
kubeadm:cluster-admins                                          ClusterRole/cluster-admin                                                          9d
kubeadm:get-nodes                                               ClusterRole/kubeadm:get-nodes                                                      9d
kubeadm:kubelet-bootstrap                                       ClusterRole/system:node-bootstrapper                                               9d
```

#### Deleting a Role or RoleBinding

To delete a Role:

```
$ kubectl delete role developer-role -n development

role.rbac.authorization.k8s.io "developer-role" deleted
```

To remove a RoleBinding:

```
$ kubectl delete rolebinding developer-rolebinding -n development

rolebinding.rbac.authorization.k8s.io "developer-rolebinding" deleted
```

</details>

<details>
<summary> 
 
## Logging and Monitoring with Prometheus and Grafana
</summary><br>



</details>

<details>
<summary> 
 
## Service Mesh with Istio in Kubernetes
</summary><br>



</details>

<details>
<summary> 
 
## Backup and Disaster Recovery in Kubernetes
</summary><br>



</details>

<details>
<summary> 
 
## Managing ConfigMaps and Secrets in Kubernetes
</summary><br>



</details>

<details>
<summary> 
 
## Kubernetes - Implementing Blue-Green Deployments
</summary><br>



</details>

