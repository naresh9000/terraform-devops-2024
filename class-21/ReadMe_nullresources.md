# Null-Resources

Issue::
 the order of resource execution is generally determined by dependencies between resources.
For avoiding potential circular dependencies we use the **"null_resource"** for "**provisioners**" using the "**triggers**" and "**depends_on**"

**first**
create the ec2-instance using the terraform

**second**
create the null resource with provisioners using triggers and depends_on
```diff
resource "null_resource" "ec2_provisioners" {
  triggers = {
    instance_id = aws_instance.web-1.id
  }
  depends_on = [aws_instance.web-1]
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("devops.pem")
      host        = aws_instance.web-1.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "/tmp/script.sh"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("devops.pem")
      host        = aws_instance.web-1.public_ip
    }

  }


}


```

- terraform init
- terraform fmt;terraform validate
- terraform apply -auto-approve
- terraform state list
    under the state list null resource will also be there but exactly its not a resource,which is used for provisioning the ec2

Note--
- terraform taint <null-resource-from-state-list> 
- terraform apply

by using these commands only it recretes the null resources but not the entire ec2-instance,as it will ask resource is tainted it must be replaced..