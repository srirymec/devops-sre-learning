# Ansible Tutorial

CLICK ON EACH QUESTION FOR THE ANSWER

<details>
<summary> 

## Installing Ansible
</summary><br>

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

</details>

<details>
<summary> 
 
 ## Ansible Commands
 </summary><br>

 | Command                                                                                                    | Description                                                                 |
|------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `ansible-doc -l`                                                                                           | To list all the modules.                                                   |
| `ansible-doc -l \| grep copy`                                                                               | Use grep to find a specific module. `copy` module in this example     |
| `ansible-doc copy`                                                                                         | To view the documentation of the `copy` module.                         |
| `ansible target -m setup`                                                                                  | To get the information about network, machine, or metadata of infra using setup module. |
| `ansible target -m yum -a "name=httpd state=latest" --become`                                               | Install `httpd` package using the os package module `yum`. Use `--become` to execute with sudo privileges. |
| `ansible target -m yum -a "name=httpd state=removed" --become`                                              | Remove the httpd package.                                                  |
| `ansible target -m lineinfile -a "path='/etc/httpd/conf/httpd.conf' regexp='^Listen ' insertafter='^#Listen ' line=' Listen 8080' state=present" --become` | Modify a single line using the lineinfile module.                           |
| `ansible target -m service -a "name=httpd enabled=yes state=started" --become`                              | Using the service module to start the httpd service on the nodes.           |

</details>

<details>
<summary> 
 
 ## Ansible Playbook
 </summary><br>

- To run any playbook use the below command,<br/>
 `ansible-playbook <playbook.yml>`
- To check the syntax,<br/>
  `ansible-playbook <playbook.yml> --syntax-check`

**playbook.yml**<br/>

Install and configure apache server<br/>
Takes variable - http_port (Default value - 8080)
```
---
- name: Installing and configuring webserver on target nodes
  hosts: target
  become: yes
  vars:
    http_port: 8080
  tasks:
    - name: Installing apache web server
      yum:
        update_cache: yes
        name: httpd
        state: latest
    - name: Copy the index.html file
      copy:
        src: index.html
        dest: /var/www/html/
    - name: Start the httpd service
      service:
        name: httpd
        state: started
        enabled: yes
    - name: Changing the apache web server port number
      lineinfile:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^Listen '
        insertafter: '^#Listen '
        line: 'Listen {{ http_port }}'
      when: http_port is defined
      notify: Restart Apache
  handlers:
    - name: Restart Apache
      service:
        name: httpd
        state: restarted

```

</details>





