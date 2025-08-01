# Kubernetes Cheat Sheet
A categorized list of essential Kubernetes commands that every DevOps Engineer should know for interviews and hands-on tasks.

![Kubernetes Cheat sheet](https://github.com/srirymec/devops-sre-learning/blob/main/kubernetes/images/k8-cheat-sheet-new.jpg)

---

## 1. Cluster Info

| Task                        | Command                                 |
|-----------------------------|------------------------------------------|
| Check cluster info          | `kubectl cluster-info`                   |
| Get node details            | `kubectl get nodes -o wide`              |
| Get Kubernetes config path  | `echo $KUBECONFIG`                       |

---

## 2. Namespace Management

| Task                          | Command                                |
|-------------------------------|-----------------------------------------|
| Get all namespaces            | `kubectl get ns`                        |
| Create a namespace            | `kubectl create ns dev`                 |
| Set default namespace         | `kubectl config set-context --current --namespace=dev` |

---

## 3. Pod Management

| Task                            | Command                                 |
|----------------------------------|------------------------------------------|
| List all pods                   | `kubectl get pods`                       |
| List pods in all namespaces     | `kubectl get pods --all-namespaces`      |
| Describe a pod                  | `kubectl describe pod <pod-name>`        |
| Delete a pod                    | `kubectl delete pod <pod-name>`          |
| Exec into a running pod        | `kubectl exec -it <pod-name> -- /bin/bash` |
| View pod logs                  | `kubectl logs <pod-name>`                |
| Tail logs                      | `kubectl logs -f <pod-name>`             |

---

## 4. Deployment Management

| Task                           | Command                                               |
|--------------------------------|--------------------------------------------------------|
| Create a deployment            | `kubectl create deployment nginx --image=nginx`        |
| List deployments               | `kubectl get deployments`                             |
| Scale a deployment             | `kubectl scale deployment nginx --replicas=3`         |
| Update deployment image        | `kubectl set image deployment/nginx nginx=nginx:1.20` |
| Rollback deployment            | `kubectl rollout undo deployment nginx`               |
| View rollout history           | `kubectl rollout history deployment nginx`            |

---

## 5. Service Management

| Task                           | Command                                                    |
|--------------------------------|-------------------------------------------------------------|
| Expose deployment as service   | `kubectl expose deployment nginx --port=80 --type=LoadBalancer` |
| Get service details            | `kubectl get svc`                                           |
| Describe service               | `kubectl describe svc <svc-name>`                           |

---

## 6. YAML Management

| Task                        | Command                                             |
|-----------------------------|------------------------------------------------------|
| Apply from YAML             | `kubectl apply -f <file>.yaml`                      |
| Delete from YAML            | `kubectl delete -f <file>.yaml`                     |
| Dry-run (test config)       | `kubectl apply -f <file>.yaml --dry-run=client`     |
| Edit resource               | `kubectl edit deployment <name>`                    |
| Generate YAML for resource  | `kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx.yaml` |

---

## 7. ConfigMaps & Secrets

| Task                            | Command                                                      |
|----------------------------------|---------------------------------------------------------------|
| Create ConfigMap                | `kubectl create configmap my-config --from-literal=key1=val1` |
| View ConfigMaps                 | `kubectl get configmaps`                                      |
| Create Secret                   | `kubectl create secret generic my-secret --from-literal=pwd=123` |
| View Secrets                    | `kubectl get secrets`                                         |

---

## 8. Resource Status & Monitoring

| Task                    | Command                            |
|-------------------------|-------------------------------------|
| Get resource usage      | `kubectl top pod` (metrics-server)  |
| View events             | `kubectl get events`                |
| Describe resource       | `kubectl describe <resource> <name>`|

---

## 9. Cleanup

| Task                   | Command                             |
|------------------------|--------------------------------------|
| Delete all resources   | `kubectl delete all --all`           |
| Delete namespace       | `kubectl delete ns <name>`           |

---

## 10. Miscellaneous

| Task                                | Command                                        |
|-------------------------------------|------------------------------------------------|
| View contexts                       | `kubectl config get-contexts`                  |
| Switch context                      | `kubectl config use-context <context-name>`    |
| View current context                | `kubectl config current-context`               |
| Port-forward pod                    | `kubectl port-forward pod/<pod-name> 8080:80`  |

---

## Bonus: Helpful Aliases

```bash
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kdp='kubectl describe pod'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
