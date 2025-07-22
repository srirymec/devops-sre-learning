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

**Variables in playbook:** <br/>

- To `define` variables in playbook one must use `vars` keyword.
- To `read` variables in the playbook one must use `vars_prompt` keyword.
- To `pass` variables from the command prompt: `--extra-vars` or `-e` option
- `check-mode` attribute in playbook.yml defines to check for any changes or not during the execution<br/>
  `ansible-playbook playbook.yml --check` (Checks for the changes)<br/>
  `ansible-playbook playbook.yml --diff` (Checks for the difference)

</details>

<details>
<summary> 
 
 ## Jinja templating
 </summary><br>

- Ansible uses jinja templates for dynamic expressions and access to the variables.
- Jinja template extension is `.j2`

**httpd.conf.j2**
```
#
#
Listen "{{ http_port }}"
```

**playbook.yml**
```
---
- name: Installing and configuring webserver on target nodes
  hosts: target
  become: yes
  vars:
    my_doc_root: /var/www/html
    http_port: 8080
  tasks:
  - block:
    - name: Installing apache web server
      yum:
        update_cache: yes
        name: httpd
        state: present
    - name: Starting apache web server
      yum:
        name: httpd
        state: started
        enabled: yes
    when: "ansible_os_family == 'RedHat' and ansible_facts['distribution'] == 'CentOS'"
  - name: Changing the apache web service port number
    template: "src='httpd.conf.j2' dest='/etc/httpd/conf/httpd.conf'"
    notify:
    - Restart Apache
  - name: Create HTML file in target
    copy:
      src: index.html
      dest: {{ my_doc_root}}
    notify:
    - Restart Apache
  handlers:
    - name: Restart Apache
      service:
        name: httpd
        state: restarted
```

</details>

<details>
<summary> 
 
 ## Ansible Vault
 </summary><br>

Ansible Vault uses **AES256 symmetric encryption** to encrypt the playbook<br/>

### Encrypting the playbooks

| Command                                         | Description                                                                 |
|-------------------------------------------------|-----------------------------------------------------------------------------|
| `ansible vault create playbook.yml`             | Creating an encrypted playbook, prompts for a `password` for encryption.      |
| `ansible vault view playbook.yml`               | View the encrypted playbook, prompts for the `password` used during encryption.|
| `ansible vault edit playbook.yml`               | Prompts for the `password twice` and validates the key.                       |
| `ansible vault encrypt playbook.yml`            | Encrypting an existing playbook. Prompts for the `password` for encryption.   |
| `ansible vault decrypt playbook.yml`            | Decrypt the encrypted playbook. Prompts for the `password` used during encryption.|
| `ansible vault rekey playbook.yml`              | To change the encryption password.                                          |

### Running the encrypted playbooks

| Command                                         | Description                                                                 |
|-------------------------------------------------|-----------------------------------------------------------------------------|
| `ansible-playbook playbook.yml --ask-vault-pass` |  This will prompt for vault password to run the playbook.     |
| `ansible-playbook playbook.yml --vault-password-file="<path-to-vault-pass-file>"` | The vault password is saved in the file and path to that file is provided  |
| `ansible-playbook playbook.yml `               | You could set the path of vault-pass file in ansible.cfg and then run  playbook as usual                 |

### Encrypt_string

`ansbile vault encrypt_string <String to be encrypted>`

`ansbile vault encrypt_string "Hello" --name my_text` (**my_text** is a variable in playbook)<br/>

This gives the encrypted string, substitute in the **my_text** variable.

### Ansible vault IDs:

When we need to provide more than one vault password for executing a playbook, we need to use **vault ID**.

</details>



