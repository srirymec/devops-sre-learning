# Terraform Interview Questions

<a name="terraform-advanced"></a>
#### :star: Advanced/Scenario based

<details>
<summary>Explain "Remote State". When would you use it and how?</summary><br><b>
</b></details>

<details>
<summary>Explain "State Locking"</summary><br><b>
</b></details>

<details>
<summary>How can you migrate the state file from your local to remote or to a different location in your remote without effecting the infrastructure?</summary><br>
  
- Manually move the state file to desirec location
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
- Run **terraform init -migrate-state** so it's pointing to the new remote backend.
</details>

<details>
<summary>How to delete a specific virtual machine from a resource group that contains other virtual machines?</summary><br>
  
- Use terraform destroy with target option.
  ```terraform destroy -target=aws_instance.my_ec2 ```
</details>

<a name="terraform-beginner"></a>
#### :baby: Beginner

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
<summary>Explain what is "Terraform configuration"</summary><br><b>
</b></details>

<details>
<summary>Explain each of the following:

  * Provider
  * Resource
  * Provisioner
</b></details>

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
<summary>Give an example of several Terraform best practices</summary><br><b>
</b></details>

<details>
<summary>Explain how implicit and explicit dependencies work in Terraform</summary><br><b>
</b></details>

<details>
<summary>What is <code>local-exec</code> and <code>remote-exec</code> in the context of provisioners?</summary><br><b>
</b></details>

<details>
<summary>What is a "tainted resource"?</summary><br><b>

It's a resource which was successfully created but failed during provisioning. Terraform will fail and mark this resource as "tainted".
</b></details>

<details>
<summary>What <code>terraform taint</code> does?</summary><br><b>
</b></details>

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
