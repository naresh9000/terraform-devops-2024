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
