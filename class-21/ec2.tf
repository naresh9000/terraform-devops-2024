resource "aws_instance" "web-1" {

  #ami = "ami-06fe902e167e67d33"
  #ami = "${data.aws_ami.my_ami.id}"
  ami                         = "ami-06fe902e167e67d33"
  availability_zone           = "ap-south-2a"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = [aws_security_group.allow_all.id]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "naresh"
    CostCenter = "ABCD"
  }
  lifecycle {
    create_before_destroy = false
  }

  user_data = <<-EOF
		  #!/bin/bash
      sudo apt-get update
		  sudo apt-get install -y nginx
      echo "<h1>Deployed via terraform on test-server-1</h1>" | sudo tee /var/www/html/index.html
	EOF
}



