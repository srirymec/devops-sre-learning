# Ansible Tutorial

## Installing Ansible

Ansible is installed only on the Controller nodes.

**Below commands used to install ansible on the controller node**

```
Yum update -y <br/>
Yum install -y epel-release <br/>
Yum install -y ansible
```

**Client-Server setup:** On all the worker nodes (hosts) perform following steps to setup client-server arch

- On all the worker nodes/hosts, open `/etc/ssh/sshd_config` file and make `passwordAuthentication` to `yes`
- Restart the sshd <br/>
  `systemctl restart sshd`
- On controller node execute the below command to generate ssh key for establishing ssh connection between controller and worker nodes <br/>
  `ssh-keygen`
- Cat the content of the id_rsa.pub <br/>
  `cat ~/.ssh/id_rsa.pub`
- Copy the key content on the worker nodes by running the below command <br/>
  `cat >>  ~/.ssh/authorized_keys`
- Confirm the connectivity by running the below command on the controller node <br/>
  `ssh root@<ip-of-worker-node>`






