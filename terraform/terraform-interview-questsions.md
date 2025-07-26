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

<details>
<summary>How to delete 3rd server only in the list of 5 servers created by terraform</summary><br>

### Scenario 1: Servers created using count

```
resource "aws_instance" "example" {
  count         = 5
  ami           = "ami-xxxxxx"
  instance_type = "t2.micro"
}

```

In this case, Terraform creates 5 instances:

aws_instance.example[0]

aws_instance.example[1]

aws_instance.example[2] ← this is the 3rd one

aws_instance.example[3]

aws_instance.example[4]

**Option A:** Manually taint & destroy just that one
```
terraform destroy -target=aws_instance.example[2]
```
This destroys the instance, but Terraform will recreate it on the next apply unless the count is reduced or indexed differently.

**Option B:** Replace count with for_each for more control

Instead of using `count`, switch to `for_each` so you can skip specific instances.

```
locals {
  server_ids = [1, 2, 3, 4, 5]
  filtered_servers = [for id in local.server_ids : id if id != 3]
}

resource "aws_instance" "example" {
  for_each      = toset(local.filtered_servers)
  ami           = "ami-xxxxxx"
  instance_type = "t2.micro"
  tags = {
    Name = "server-${each.key}"
  }
}

```

Now the server with ID 3 is skipped/deleted.

Then run:

```
terraform apply
```

Terraform will destroy only the one matching the removed key (3).

### Scenario 2: Servers created using for_each (already)

If you're already using for_each, simply remove the key that corresponds to the 3rd server.

**Summary**
|  Approach	  |    Pros    |  	Cons  |
| ----------- | ---------- | --------- |
| destroy -target=resource[index] |	Fast, targeted	| Will be recreated unless logic changes |
| for_each with conditional exclude	| Proper Terraform way	| Requires some refactoring |
| Reduce count (from 5 to 4)	| Simple	| Deletes the last server, not index 2 |

</details>
<details>
  
<summary>Creating 5 servers with different instance types - foreach and count</summary><br>

To create Multiple AWS resources with different set of configurations - like using Count & ForEach together

**variables.tf**
```
variable "configuration" {
  description = "The total configuration, List of Objects/Dictionary"
  default = [{}]
}

```

**dev-variables.tfvars**
```
configuration = [
  {
    "application_name" : "GritfyApp-dev",
    "ami" : "ami-09e67e426f25ce0d7",
    "no_of_instances" : "2",
    "instance_type" : "t2.medium",
    "subnet_id" : "subnet-0f4f294d8404946eb",
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c","sg-0d8749c35f7439f3e"]
  },
  {
    "application_name" : "GrityWeb-dev",
    "ami" : "ami-0747bdcabd34c712a",
    "instance_type" : "t2.medium",
    "no_of_instances" : "1"
    "subnet_id" : "subnet-0f4f294d8404946eb"
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c"]
  },
  {
    "application_name" : "OpsGrit-dev",
    "ami" : "ami-0747bdcabd34c712a",
    "instance_type" : "t3.micro",
    "no_of_instances" : "3"
    "subnet_id" : "subnet-0f4f294d8404946eb"
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c"]
  }
  
]
```

**main.tf**
```
provider "aws" {
  region = "us-east-1"
  profile = "personal"

}

locals {
  serverconfig = [
    for srv in var.configuration : [
      for i in range(1, srv.no_of_instances+1) : {
        instance_name = "${srv.application_name}-${i}"
        instance_type = srv.instance_type
        subnet_id   = srv.subnet_id
        ami = srv.ami
        security_groups = srv.vpc_security_group_ids
      }
    ]
  ]
}

// We need to Flatten it before using it
locals {
  instances = flatten(local.serverconfig)
}

resource "aws_instance" "web" {

  for_each = {for server in local.instances: server.instance_name =>  server}
  
  ami           = each.value.ami
  instance_type = each.value.instance_type
  vpc_security_group_ids = each.value.security_groups
  user_data = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the remote server"
echo -e "******" >> /home/ubuntu/.ssh/authorized_keys

echo "Changing the hostname to ${each.value.instance_name}"
hostname ${each.value.instance_name}
echo "${each.value.instance_name}" > /etc/hostname

EOF
  subnet_id = each.value.subnet_id
  tags = {
    Name = "${each.value.instance_name}"
  }
}

output "instances" {
  value       = "${aws_instance.web}"
  description = "All Machine details"
}
```

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
<summary>What are output variables and what <code>terraform output</code> does?</summary><br>

Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

**Output values have several uses:**

- A child module can use outputs to expose a subset of its resource attributes to a parent module.
- A root module can use outputs to print certain values in the CLI output after running `terraform apply`.
- When using remote state, root module outputs can be accessed by other configurations via a terraform_remote_state data source.

**Declaring an Output Value**

```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}

```
</details>

<details>
<summary>Explain Modules</summary>

A Terraform module is a collection of standard configuration files in a dedicated directory. Terraform modules encapsulate groups of resources dedicated to one task, reducing the amount of code you have to develop for similar infrastructure components.

A typical module can look like this:

```
.
├── main.tf
├── outputs.tf
├── README.md
└── variables.tf
```
</details>

<details>
<summary>What is the Terraform Registry?</summary><br><b>
</b></details>
