# I. Kubernetes Fundamentals and Architecture

## 1. What is Kubernetes and why is it used?
**Answer:**  
Kubernetes (K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It solves the challenges of managing large, distributed applications across multiple servers by providing features like automated scheduling, self-healing, rolling updates, and service discovery.

---

## 2. Explain the core components of Kubernetes architecture.
**Answer:**  
Kubernetes architecture consists of two main parts:

### Control Plane (Master Node):
- **Kube-apiserver:** The front-end of the Kubernetes control plane, exposing the Kubernetes API. All communication with the cluster goes through the API server.
- **etcd:** A highly available, distributed key-value store that stores all cluster data (configurations, state, metadata).
- **Kube-scheduler:** Selects a node for newly created Pods based on resource requirements, constraints, and other policies.
- **Kube-controller-manager:** Runs controller processes that regulate the cluster's state (e.g., Node Controller, Replication Controller, Endpoints Controller, Service Account & Token Controllers).

### Worker Nodes:
- **Kubelet:** An agent that runs on each node in the cluster, ensuring containers are running in a Pod. It communicates with the control plane.
- **Kube-proxy:** A network proxy that runs on each node, maintaining network rules on nodes and enabling network communication to your Pods from inside or outside of the cluster.
- **Container Runtime:** (e.g., containerd, CRI-O, Docker) - The software responsible for running containers.

---

## 3. What is a Pod in Kubernetes? Why is it the smallest deployable unit?
**Answer:**  
A Pod is the smallest deployable unit in Kubernetes. It represents a single instance of a running process in your cluster. It's the smallest unit because containers within a Pod share the same network namespace, IP address, and storage, making them tightly coupled and allowing them to communicate via `localhost`.

---

## 4. What is the relationship between Kubernetes and Docker?
**Answer:**  
Docker is a containerization platform that enables you to package and run applications in isolated environments called containers.  
Kubernetes is a container orchestration platform that manages and automates the deployment, scaling, and operation of Docker containers (or any other OCI-compliant container runtime) across a cluster of machines.  
**Analogy:** Docker builds the house (container), Kubernetes manages the neighborhood (cluster).

---

## 5. Explain Namespaces in Kubernetes. When would you use them?
**Answer:**  
Namespaces provide a mechanism for isolating groups of resources within a single Kubernetes cluster. They are essentially virtual clusters within a physical cluster. You would use them for:

- **Resource isolation:** Separating resources for different teams, projects, or environments (e.g., dev, staging, prod).
- **Access control:** Applying RBAC policies at a namespace level to restrict user access.
- **Resource quotas:** Setting resource limits (CPU, memory) per namespace.

---

## 6. What are Labels and Selectors in Kubernetes?
**Answer:**  
- **Labels:** Key-value pairs that are attached to Kubernetes objects (e.g., Pods, Services, Deployments). They are used to organize, identify, and categorize objects.
- **Selectors:** Used to filter objects based on their labels. Services use selectors to identify the Pods they should route traffic to, and Deployments use them to manage their associated Pods.

---

## 7. What is a Service in Kubernetes? Why is it needed?
**Answer:**  
A **Service** is an abstraction that defines a logical set of Pods and a policy by which to access them. It provides a **stable network endpoint** (a fixed IP address and DNS name) for a group of Pods, even as Pods are created, deleted, or rescheduled.  
This is crucial because Pods are ephemeral and their IP addresses can change.

---

## 8. Differentiate between ClusterIP, NodePort, and LoadBalancer Service types.
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

## 9. What is a Deployment in Kubernetes?
**Answer:**  
A **Deployment** is a higher-level abstraction that manages the lifecycle of Pods and ReplicaSets. It provides **declarative updates** to Pods, ensuring that the desired number of replicas are running and supports features like **rolling updates**, **rollbacks**, and **self-healing**.

---

## 10. Explain the difference between a ReplicaSet and a Deployment.
**Answer:**

- **ReplicaSet:**  
  Ensures a specified number of identical Pod replicas are running at all times. It’s a low-level controller primarily used by Deployments.

- **Deployment:**  
  A higher-level object that manages ReplicaSets. It provides declarative updates, rolling updates, rollbacks, and versioning.

---

## 11. What is a StatefulSet and when would you use it?
**Answer:**  
A **StatefulSet** is a workload API object used to manage **stateful applications**. It provides:

- Stable, unique network identifiers.
- Stable, persistent storage.
- Ordered, graceful deployment and scaling.
- Ordered, graceful deletion.

**Use case examples:** Databases (e.g., MySQL, PostgreSQL), Kafka, or any application needing persistent identity and storage.

---

## 12. What is a DaemonSet and when would you use it?
**Answer:**  
A **DaemonSet** ensures that a copy of a Pod runs on all (or a subset of) nodes in a cluster. Typically used for cluster-level services like:

- Logging agents (e.g., Fluentd, Logstash)
- Monitoring agents (e.g., Prometheus Node Exporter)
- Storage daemons (e.g., Ceph)

---

## 13. Explain ConfigMaps and Secrets. What's the difference?
**Answer:**

- **ConfigMaps:**  
  Used to store **non-sensitive** configuration data as key-value pairs.

- **Secrets:**  
  Used to store **sensitive** data such as passwords, API keys, and tokens. Handled securely by Kubernetes.

**Difference:**  
The primary difference is **sensitivity** and **security handling** — Secrets are encrypted or encoded (Base64) and are treated more securely than ConfigMaps.

---

## 14. What is Ingress in Kubernetes? How does it differ from a LoadBalancer Service?
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

## 15. How does Kubernetes handle storage orchestration?
**Answer:**  
Kubernetes provides a storage orchestration system using:

- **PersistentVolume (PV):**  
  A piece of storage in the cluster provisioned by an admin or dynamically.

- **PersistentVolumeClaim (PVC):**  
  A request for storage by a user, specifying size and access modes.

- **StorageClass:**  
  Defines storage types (e.g., "fast", "slow") and allows dynamic provisioning of PVs when a PVC requests a specific class.

# II. Networking in Kubernetes

## 16. Explain the Kubernetes networking model.
**Answer:**  
Kubernetes enforces a "flat" networking model where:

- All Pods can communicate with all other Pods **without NAT**.
- All Nodes can communicate with all Pods **without NAT**.
- The IP that a Pod sees itself as is the **same IP** that others see it as.

This model relies on a **Container Network Interface (CNI)** plugin (e.g., **Calico**, **Flannel**, **Cilium**) to implement the actual network fabric.

---

## 17. How does Pod-to-Pod communication work within the same node?
**Answer:**  
Pods on the same node communicate via the **CNI bridge**.  
The CNI plugin creates a **virtual Ethernet pair** for each Pod:

- One end is in the Pod’s network namespace.
- The other end is connected to a **bridge** on the node.

---

## 18. How does Pod-to-Pod communication work across different nodes?
**Answer:**  
Pods on different nodes communicate via the **overlay network** created by the CNI plugin.

- The CNI plugin **encapsulates Pod traffic** (e.g., using **VXLAN**, **IPIP**) and **routes** it between nodes.
- This ensures that Pods have consistent, routable IPs across the cluster.

---

## 19. What are Network Policies in Kubernetes? When would you use them?
**Answer:**  
**Network Policies** are Kubernetes resources that define rules for how Pods are allowed to communicate with each other and other endpoints.  
They provide **network segmentation and security** by restricting traffic flow.

You would use Network Policies to:

- Isolate different application tiers (e.g., frontend, backend, database).
- Restrict access to sensitive services.
- Implement **micro-segmentation** within the cluster.

---

## 20. How does Kubernetes handle DNS for services and pods?
**Answer:**  
Kubernetes uses an internal DNS service, typically **CoreDNS**, to provide **service discovery**.

- **Pods:**  
  Each Pod gets a DNS A record in the format:  
  `pod-ip-address.namespace.pod.cluster.local`

- **Services:**  
  Each Service gets a DNS A record in the format:  
  `service-name.namespace.svc.cluster.local`

  - **Headless Services** also get A records for their individual Pods.

# III. Deployment and Scaling

## 21. Describe the process of a rolling update in Kubernetes.
**Answer:**  
A rolling update gradually updates application instances with a new version without downtime.  
When you update a Deployment, Kubernetes:

- Creates new Pods with the new image.
- Waits for them to become healthy.
- Slowly terminates old Pods.

This ensures continuous availability during the update process.

---

## 22. How do you perform a rollback of a Deployment?
**Answer:**  
You can use the following command to rollback a Deployment:

```bash
kubectl rollout undo deployment <deployment-name>
```

To specify a particular revision to roll back to, use:

```
kubectl rollout undo deployment <deployment-name> --to-revision=<revision-number>
```

## 23. What is Horizontal Pod Autoscaling (HPA)? How does it work?

**Answer:**  
**Horizontal Pod Autoscaling (HPA)** automatically scales the number of Pod replicas in a Deployment or ReplicaSet based on:

- Observed **CPU utilization**
- **Memory utilization**
- **Custom metrics**

HPA periodically checks the metrics and adjusts the **replicas** field of the target resource.

---

## 24. What is Vertical Pod Autoscaling (VPA)?

**Answer:**  
**Vertical Pod Autoscaling (VPA)** automatically adjusts the **CPU** and **memory** requests and limits for containers in a Pod based on historical usage.  
It helps optimize resource allocation and prevents:

- **Over-provisioning**
- **Under-provisioning**

**Note:** VPA is still in **beta** and has implications for Pod rescheduling.

---

## 25. What is Cluster Autoscaler?

**Answer:**  
**Cluster Autoscaler** automatically adjusts the number of nodes in your Kubernetes cluster based on:

- **Resource requests**
- **Actual usage**

If Pods cannot be scheduled due to insufficient resources, Cluster Autoscaler **adds** new nodes.  
If nodes are underutilized, it **removes** them.

## 26. How would you troubleshoot a failed Deployment?

**Answer:**

**1.** Check the deployment status:
```
kubectl get deployments

```
**2.** Describe the deployment to check events and conditions:
```
kubectl describe deployment <deployment-name>

```
**3.** Check associated ReplicaSets:
```
kubectl get replicasets

```
**4.** Check Pod status using a label:
```
kubectl get pods -l app=<label>

```
**5.** Describe the Pod to view events, container status, and volumes:
```
kubectl describe pod <pod-name>

```
**6.** Check the application logs:
```
kubectl logs <pod-name>

```
**7.** Debug inside the container:
```
kubectl exec -it <pod-name> -- /bin/sh

```
**8.** Check **kube-apiserver** and **kube-scheduler** logs if no Pods are scheduling.
**9.** Check **kubelet** logs on the node if Pods are stuck in a pending state.

## 27. Explain Liveness and Readiness Probes. Why are they important?

**Answer:**  

- **Liveness Probe:**  
  Determines if a container is running and healthy. If the liveness probe fails, Kubernetes will restart the container. This prevents deadlocked containers from perpetually consuming resources.

- **Readiness Probe:**  
  Determines if a container is ready to serve traffic. If the readiness probe fails, Kubernetes will remove the Pod's IP from the Service endpoints, preventing traffic from being routed to an unready Pod.  
  This ensures no traffic is sent to applications that are still starting up or experiencing issues.

**Importance:**  
These probes enable Kubernetes to **self-heal**, managing application availability and reliability.

---

## 28. What is a CronJob in Kubernetes? Give an example use case.

**Answer:**  
A **CronJob** creates Jobs on a repeating schedule, much like a Unix cron job. They are used for performing scheduled tasks.

### Example Use Cases:
- Running a **daily database backup**.
- Generating **weekly reports**.
- **Cleaning up old logs** periodically.

