# Modules
modules are a way to organize and reuse Terraform configurations,Encapsulation,Reuse,Input and Output Variables,Versioning


In AWS when creating the networking components we re-use the modules
Create the sub-folder Modules,dev,prod .
Under Modules: create the Compute,ELB,IAM,NAT,Network,SG,Route53,VPC and Subnets,etc as modules
in each module i have defined the respectice variable.tf,resources.tf,outputs.tf,locals.tf

For example::
```
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

resource "aws_instance" "example" {
  count = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

In this example, the module takes an input variable instance_count and creates that number of EC2 instances. You can then use this module in another Terraform configuration by calling it with specific values for the input variables.

```
# main configuration using the module
module "example_instance" {
    # in the source specify the module path from root terraform project and customize the input for the all the varibles declared.Hence here only one varaible is "instance_count"
    # we can call the module locally or remotely(http url)

  source         = "./path/to/module"
  instance_count = 3
}

```
Note::
Also please go through the different functions like(distint,toset,set, dynamic,for_each ) which are used used extensively for complex understanding of terraform.

**Using terraform console**
One can check the functions are resulting the rigth response while deploying the infra on aws
for example:
terraform console
>distinct(["10.90.1.0/24", "10.90.2.0/24", "10.90.3.0/24","10.90.2.0/24"])
response:
tolist([
  "10.90.1.0/24",
  "10.90.2.0/24",
  "10.90.3.0/24",
])




