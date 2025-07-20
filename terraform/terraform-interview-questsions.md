# Terraform Interview Questions

## :star: Advanced/Scenario based

<details>
<summary>Explain "Remote State". When would you use it and how?</summary><br><b>
</b></details>

<details>
<summary>Explain "State Locking"</summary><br><b>
</b></details>

<details>
<summary>How can you migrate the state file from your local to remote or to a different location in your remote without effecting the infrastructure?</summary><br>
  
- Manually move the state file to desired location
- Modify the code for the remote backend to point to the new location
  ```
    terraform { 
      backend "s3" { 
      bucket         = "tfstate-bucket" 
      key            = "terraform.tfstate" 
      region         = "us-east-1" 
      dynamodb_table = "tfstate-lock" 
      } 
    }
  ```
- Run **terraform init** so it's pointing to the new remote backend.
</details>

<details>
<summary>How to delete a specific virtual machine from a resource group that contains other virtual machines?</summary><br>
  
- Use terraform destroy with target option.
  ```terraform destroy -target=aws_instance.my_ec2 ```
</details>

## :baby: Beginner

<details>
<summary>Can you explain what is Terraform? How it works?</summary><br><b>

Read [here](https://www.terraform.io/intro/index.html#what-is-terraform-)
</b></details>

<details>
<summary>What benefits infrastructure-as-code has?</summary><br><b>

- fully automated process of provisioning, modifying and deleting your infrastructure
- version control for your infrastructure which allows you to quickly rollback to previous versions
- validate infrastructure quality and stability with automated tests and code reviews
- makes infrastructure tasks less repetitive
</b></details>

<details>
<summary>Why Terraform and not other technologies? (e.g. Ansible, Puppet, CloufFormation)</summary><br><b>

A common *wrong* answer is to say that Ansible and Puppet are configuration management tools
and Terraform is a provisioning tool. While technically true, it doesn't mean Ansible and Puppet can't
be used for provisioning infrastructure. Also, it doesn't explain why Terraform should be used over
CloudFormation if at all.

The benefits of Terraform over the other tools:

  * It follows the immutable infrastructure approach which has benefits like avoiding a configuration drift over time
  * Ansible and Puppet are more procedural (you mention what to execute in each step) and Terraform is declarative since you describe the overall desired state and not per resource or task. You can give the example of going from 1 to 2 servers in each tool. In Terraform you specify 2, in Ansible and puppet you have to only provision 1 additional server so you need to explicitly make sure you provision only another one server.
</b></details>

<details>
<summary>Explain what is "Terraform configuration"</summary><br>

A Terraform configuration is a set of files that define the desired state of your infrastructure, including resources like virtual machines, networks, and databases. These files, written in HashiCorp Configuration Language (HCL), describe what infrastructure you want, not how to build it, allowing Terraform to handle the provisioning process. 

**Key Components of a Terraform Configuration:**

- **Provider Block:**
Specifies the cloud provider (e.g., AWS, Azure, Google Cloud) or service Terraform will interact with. 
- **Resource Block:**
Defines the specific infrastructure components you want to create or manage, such as EC2 instances, databases, or storage volumes. 
- **Variables:**
Allow you to parameterize your configuration, making it reusable across different environments or deployments. 
- **Outputs:**
Define values that can be accessed after the infrastructure is provisioned, like a public IP address or a database endpoint. 
- **Modules:**
Reusable collections of resources that encapsulate common infrastructure patterns, promoting code organization and best practices. 
- **State Files:**
Terraform maintains a state file that tracks the current state of your infrastructure, ensuring that future changes are applied correctly. 
- **Declarative Approach:**
Terraform configurations are declarative, meaning you describe the desired end state of your infrastructure rather than writing a series of commands to create each resource. This approach simplifies infrastructure management and allows Terraform to optimize the provisioning process.

</details>

<details>
<summary>Explain each of the following:

  * Provider
  * Resource
  * Provisioner

</summary><br>

- **Provider:**
  - A provider is the foundation of infrastructure management. It's the entity (often a cloud platform or virtualization system) that owns and controls the underlying infrastructure.
  - It provides an API or interface that allows users to request and manage resources.
  - Examples include:
      - **Cloud Providers:** AWS, Azure, Google Cloud, DigitalOcean, etc.
      - **Virtualization Platforms:** VMware, VirtualBox.
      - **Configuration Management Systems:** Chef, Puppet, Ansible. 
- **Resource:**
  - A resource is a specific piece of infrastructure that is created and managed through a provider.
  - It represents a tangible or virtual component of your infrastructure.
  - Examples include:
      - **Compute Instances:** Virtual machines, containers.
      - **Networking:** Virtual networks, load balancers, firewalls.
      - **Storage:** Block storage volumes, object storage buckets.
      - **Databases:** Managed database instances.
  - Resources are defined and configured within your infrastructure code (e.g., Terraform configuration, CloudFormation templates). 
- **Provisioner:**
  - A provisioner is a mechanism used to configure or set up resources after they have been created by a provider.
  - It typically involves running scripts, installing software, or configuring settings on the newly created resource.
  - Provisioners are often used to automate the installation and configuration of applications, databases, or other software on the infrastructure.
  - Examples include:
      - **Terraform Provisioners:** Shell, Puppet, Chef, Ansible.
      - **CloudInit:** Used for initial configuration of cloud instances.
      - **Ansible Playbooks:** Executed on remote hosts for configuration management.
  - Provisioners can be used to perform tasks like:
  - Installing web servers (e.g., Apache, Nginx).
  - Configuring databases (e.g., MySQL, PostgreSQL).
  - Deploying application code.
  - Setting up monitoring agents. 
</details>

<details>
<summary>What <code>terraform.tfstate</code> file is used for?</summary><br><b> 

It keeps track of the IDs of created resources so that Terraform knows what it is managing.
</b></details>

<details>
<summary>Explain what the following commands do:

  * <code>terraform init</code>
  * <code>terraform plan</code>
  * <code>terraform validate</code>
  * <code>terraform apply</code>
</summary><br><b>

<code>terraform init</code> scans your code to figure which providers are you using and download them.
<code>terraform plan</code> will let you see what terraform is about to do before actually doing it.
<code>terraform apply</code> will provision the resources specified in the .tf files.
</b></details>

<details>
<summary>How to write down a variable which changes by an external source or during <code>terraform apply</code>?</summary><br><b>

You use it this way: <code>variable “my_var” {}</code>
</b></details>

<details>
<summary>Give an example of several Terraform best practices</summary><br>

Several Terraform best practices include using `remote state with locking`, `organizing code into modules`, `using input variables and outputs`, `implementing CI/CD pipelines`, and testing thoroughly. These practices enhance collaboration, code reusability, maintainability, and security in infrastructure automation. 

- **Remote State Management & Locking:**

Local state files are prone to errors, especially in team environments. Remote state, stored in a central location (like S3, Azure Blob Storage, or Terraform Cloud), enables collaboration and prevents state corruption due to concurrent access. State locking prevents multiple users from making changes simultaneously, ensuring consistency.

```
    terraform {
      backend "s3" {
        bucket = "your-terraform-state-bucket"
        key    = "path/to/your/terraform.tfstate"
        region = "your-aws-region"
        encrypt = true
        lock_table = "your-dynamodb-lock-table"
      }
    }
```

- **Modularization:**

Breaking down your infrastructure into reusable modules improves code organization, reduces redundancy, and enhances maintainability. Modules encapsulate specific infrastructure components and can be reused across different projects or environments.

```
    # Example module structure
    modules/network/main.tf
    modules/network/variables.tf
    modules/network/outputs.tf
```
</details>

<details>
<summary>Explain how implicit and explicit dependencies work in Terraform</summary><br>

Implicit dependencies are automatically detected by Terraform when one resource references another resource's attributes. Explicit dependencies are manually defined using the `depends_on` meta-argument when the relationship isn't directly apparent from attribute references. 

**Implicit dependency:**

- Terraform automatically infers dependencies when one resource uses the output of another resource. 
- For example, if a virtual machine instance references a virtual network's ID, Terraform understands that the virtual network must be created before the instance. 
- This is because the virtual network's ID is an attribute of the virtual network resource, and the instance needs that ID to be created. 
- Terraform handles these implicit dependencies by creating a dependency graph and ensuring resources are created or updated in the correct order. 

- **Explicit dependency:**

```
resource "aws_instance" "server" {
  # ... server configuration ...
}

resource "aws_instance" "client" {
  depends_on = [aws_instance.server]
  # ... client configuration ...
}
```
</details>

<details>
<summary>What is <code>local-exec</code> and <code>remote-exec</code> in the context of provisioners?</summary><br>

In Terraform, **provisioners** are used to execute scripts or commands on **local or remote machines** as part of the resource lifecycle (typically after creation).

---

### ✅ `local-exec` Provisioner

- Executes a **command on the machine running Terraform** (e.g., developer laptop or CI/CD runner).
- Useful for:
  - Running local scripts or shell commands
  - Calling CLI tools (`aws`, `gcloud`, `kubectl`, etc.)
  - Sending notifications (Slack, email)
  - Writing output to a file

#### Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ip_list.txt"
  }
}
```

### ✅ `remote-exec` Provisioner

- Executes **commands on the remote machine** (e.g., EC2, VM) over SSH (Linux) or WinRM (Windows).
- Useful for:
  - Installing software
  - Bootstrapping the instance
  - Configuring services after provisioning

#### Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y"
    ]
  }
}
```

</details>

<details>
<summary>What is a "tainted resource"?</summary><br>

In **Terraform**, a **tainted resource** is a resource that has been **marked for destruction and recreation** during the next `terraform apply`. This is typically done when the resource is still in the Terraform state file, but something about it is considered invalid, broken, or outdated.

---

### 🔧 Why Use a Tainted Resource?

You might taint a resource when:
- The resource is **unhealthy**, misconfigured, or failed after creation.
- You want to **force its recreation** without deleting it manually.
- A **partial change** happened outside Terraform and you need to refresh it.

---

### 🛠️ How to Taint and Untaint

#### ✅ Taint a resource:
```bash
terraform taint <resource_type>.<resource_name>
```

**Example**
```
terraform taint aws_instance.web_server
```

#### ✅ Untaint a resource:
```
terraform untaint <resource_type>.<resource_name>
```
**Example**
```
terraform taint aws_instance.web_server
```
</details>

<details>
<summary>What <code>terraform taint</code> does?</summary><br>

  The `terraform taint` command is used to manually mark a Terraform-managed resource for recreation during the next `terraform apply`. When you taint a resource, the resource is marked as tainted.

  At the next `terraform appy`, the resource will be deleted and created.
</details>

<details>
<summary>What types of variables are supported in Terraform?</summary><br><b>

String
Integer
Map
List
</b></details>

<details>
<summary>What are output variables and what <code>terraform output</code> does?</summary><br><b>
</b></details>

<details>
<summary>Explain Modules</summary>
</b></details>

<details>
<summary>What is the Terraform Registry?</summary><br><b>
</b></details>
