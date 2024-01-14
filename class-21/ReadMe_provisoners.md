#                   Provisioners                                 

1) provisioners are used to perform actions on the local machine or on a remote resource after it has been created or destroyed as last resort :laughing:
2) Provisioners in Terraform are typically used for tasks such as configuring instances, running scripts, or managing the state of a system after resource creation

**TYPES**
- file
- remote-exec
- local-exec

Note::
 it's better to use other Terraform features, such as user data(in ec2), cloud-init, or configuration management tools(ansible), for more robust and maintainable infrastructure configuration.

**Sample provisioner file**
```diff
resource "aws_instance" "web-1" {
  ami = var.imagename
  #ami = "ami-0d857ff0f5fc4e03b"
  #ami = "${data.aws_ami.my_ami.id}"
  #availability_zone = "us-east-1a"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo mkdir -p /tmp/folder1
        sudo mkdir -p /tmp/folder2
	EOF
  # Copies the file as the root user using SSH
  
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("pem_file.pem")
      host        = aws_instance.web-1.public_ip
    }
  }
}

```

```diff
//remote-exec//
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]
  } 
}


```
