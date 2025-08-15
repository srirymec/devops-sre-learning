# Kubernetes Interview Questions

## Kubernetes Fundamentals and Architecture

### 1. What is Kubernetes and why is it used?
**Answer:**  
Kubernetes (K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It solves the challenges of managing large, distributed applications across multiple servers by providing features like automated scheduling, self-healing, rolling updates, and service discovery.

---

### 2. Explain the core components of Kubernetes architecture.
**Answer:**  
Kubernetes architecture consists of two main parts:

#### Control Plane (Master Node):
- **Kube-apiserver:** The front-end of the Kubernetes control plane, exposing the Kubernetes API. All communication with the cluster goes through the API server.
- **etcd:** A highly available, distributed key-value store that stores all cluster data (configurations, state, metadata).
- **Kube-scheduler:** Selects a node for newly created Pods based on resource requirements, constraints, and other policies.
- **Kube-controller-manager:** Runs controller processes that regulate the cluster's state (e.g., Node Controller, Replication Controller, Endpoints Controller, Service Account & Token Controllers).

#### Worker Nodes:
- **Kubelet:** An agent that runs on each node in the cluster, ensuring containers are running in a Pod. It communicates with the control plane.
- **Kube-proxy:** A network proxy that runs on each node, maintaining network rules on nodes and enabling network communication to your Pods from inside or outside of the cluster.
- **Container Runtime:** (e.g., containerd, CRI-O, Docker) - The software responsible for running containers.

---

### 3. What is a Pod in Kubernetes? Why is it the smallest deployable unit?
**Answer:**  
A Pod is the smallest deployable unit in Kubernetes. It represents a single instance of a running process in your cluster. It's the smallest unit because containers within a Pod share the same network namespace, IP address, and storage, making them tightly coupled and allowing them to communicate via `localhost`.

---

### 4. What is the relationship between Kubernetes and Docker?
**Answer:**  
Docker is a containerization platform that enables you to package and run applications in isolated environments called containers.  
Kubernetes is a container orchestration platform that manages and automates the deployment, scaling, and operation of Docker containers (or any other OCI-compliant container runtime) across a cluster of machines.  
**Analogy:** Docker builds the house (container), Kubernetes manages the neighborhood (cluster).

---

### 5. Explain Namespaces in Kubernetes. When would you use them?
**Answer:**  
Namespaces provide a mechanism for isolating groups of resources within a single Kubernetes cluster. They are essentially virtual clusters within a physical cluster. You would use them for:

- **Resource isolation:** Separating resources for different teams, projects, or environments (e.g., dev, staging, prod).
- **Access control:** Applying RBAC policies at a namespace level to restrict user access.
- **Resource quotas:** Setting resource limits (CPU, memory) per namespace.

---

### 6. What are Labels and Selectors in Kubernetes?
**Answer:**  
- **Labels:** Key-value pairs that are attached to Kubernetes objects (e.g., Pods, Services, Deployments). They are used to organize, identify, and categorize objects.
- **Selectors:** Used to filter objects based on their labels. Services use selectors to identify the Pods they should route traffic to, and Deployments use them to manage their associated Pods.

---

### 7. What is a Service in Kubernetes? Why is it needed?
**Answer:**  
A **Service** is an abstraction that defines a logical set of Pods and a policy by which to access them. It provides a **stable network endpoint** (a fixed IP address and DNS name) for a group of Pods, even as Pods are created, deleted, or rescheduled.  
This is crucial because Pods are ephemeral and their IP addresses can change.

---

### 8. Differentiate between ClusterIP, NodePort, and LoadBalancer Service types.
**Answer:**

- **ClusterIP:**  
  Exposes the Service on an internal IP in the cluster. Only reachable from within the cluster. *(Default type)*

- **NodePort:**  
  Exposes the Service on each Node's IP at a static port. Accessible externally via `NodeIP:NodePort`.

- **LoadBalancer:**  
  Exposes the Service externally using a cloud provider's load balancer. Automatically provisions and routes traffic.

- **ExternalName:**  
  Maps the Service to a DNS name instead of a cluster IP or NodePort. Useful for services external to the cluster.

---

### 9. What is a Deployment in Kubernetes?
**Answer:**  
A **Deployment** is a higher-level abstraction that manages the lifecycle of Pods and ReplicaSets. It provides **declarative updates** to Pods, ensuring that the desired number of replicas are running and supports features like **rolling updates**, **rollbacks**, and **self-healing**.

---

### 10. Explain the difference between a ReplicaSet and a Deployment.
**Answer:**

- **ReplicaSet:**  
  Ensures a specified number of identical Pod replicas are running at all times. It’s a low-level controller primarily used by Deployments.

- **Deployment:**  
  A higher-level object that manages ReplicaSets. It provides declarative updates, rolling updates, rollbacks, and versioning.

---

### 11. What is a StatefulSet and when would you use it?
**Answer:**  
A **StatefulSet** is a workload API object used to manage **stateful applications**. It provides:

- Stable, unique network identifiers.
- Stable, persistent storage.
- Ordered, graceful deployment and scaling.
- Ordered, graceful deletion.

**Use case examples:** Databases (e.g., MySQL, PostgreSQL), Kafka, or any application needing persistent identity and storage.

---

### 12. What is a DaemonSet and when would you use it?
**Answer:**  
A **DaemonSet** ensures that a copy of a Pod runs on all (or a subset of) nodes in a cluster. Typically used for cluster-level services like:

- Logging agents (e.g., Fluentd, Logstash)
- Monitoring agents (e.g., Prometheus Node Exporter)
- Storage daemons (e.g., Ceph)

---

### 13. Explain ConfigMaps and Secrets. What's the difference?
**Answer:**

- **ConfigMaps:**  
  Used to store **non-sensitive** configuration data as key-value pairs.

- **Secrets:**  
  Used to store **sensitive** data such as passwords, API keys, and tokens. Handled securely by Kubernetes.

**Difference:**  
The primary difference is **sensitivity** and **security handling** — Secrets are encrypted or encoded (Base64) and are treated more securely than ConfigMaps.

---

### 14. What is Ingress in Kubernetes? How does it differ from a LoadBalancer Service?
**Answer:**

- **Ingress:**  
  An API object that manages external access to services, typically for HTTP/HTTPS. Supports:
  - URL-based routing
  - Name-based virtual hosting
  - SSL/TLS termination

  Requires an **Ingress Controller** to work (e.g., Nginx, Traefik).

- **LoadBalancer Service:**  
  Provisions a Layer 4 (TCP/UDP) load balancer through the cloud provider.

**Difference:**  
Ingress works at **Layer 7 (Application Layer)** and supports advanced routing rules, while LoadBalancer works at **Layer 4 (Transport Layer)** and exposes Services directly.

---

### 15. How does Kubernetes handle storage orchestration?
**Answer:**  
Kubernetes provides a storage orchestration system using:

- **PersistentVolume (PV):**  
  A piece of storage in the cluster provisioned by an admin or dynamically.

- **PersistentVolumeClaim (PVC):**  
  A request for storage by a user, specifying size and access modes.

- **StorageClass:**  
  Defines storage types (e.g., "fast", "slow") and allows dynamic provisioning of PVs when a PVC requests a specific class.

