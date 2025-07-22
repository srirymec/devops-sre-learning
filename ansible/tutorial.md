# Ansible Tutorial

## Installing Ansible

Ansible is installed only on the Controller nodes.

### Ansible installation on controller nodes

- Below commands used to install ansible on the controller node<br/>

  ```
  Yum update -y <br/>
  Yum install -y epel-release <br/>
  Yum install -y ansible
  ```
- check the ansible installed version. <br/>
  `ansible-version`
- Edit the file `/etc/ansible/ansible.cfg` and uncomment the line `inventory=/etc/ansible/hosts`
- Edit the `/etc/ansible/hosts` file and add the worker node details <br/>
  ```
  [target]
  <ip-address-of node1>
  <ip-address-of node2>
  <ip-address-of node3>

  ```

### Configuration on the worker nodes - Client-server setup

On all the worker nodes (hosts) perform following steps for client-server setup

- Open `/etc/ssh/sshd_config` file and make `passwordAuthentication` to `yes`
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

### Check the connectivity

`ansible ping -m target`






