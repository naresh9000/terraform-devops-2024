resource "aws_instance" "web-1" {

  #ami = "ami-06fe902e167e67d33"
  #ami = "${data.aws_ami.my_ami.id}"
  ami                         = var.ami_id
  availability_zone           = "ap-south-2a"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.terraform_remote_state.base-infra-state.outputs.subnet1-id
  vpc_security_group_ids      = [data.terraform_remote_state.base-infra-state.outputs.sg]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y nginx jq unzip
        echo "<h1>Deployed via terraform on test-server-1</h1>" | sudo tee /var/www/html/index.html
		EOF
}

resource "aws_instance" "web-2" {

  #ami = "ami-06fe902e167e67d33"
  #ami = "${data.aws_ami.my_ami.id}"
  ami                         = var.ami_id
  availability_zone           = "ap-south-2b"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.terraform_remote_state.base-infra-state.outputs.subnet2-id
  vpc_security_group_ids      = [data.terraform_remote_state.base-infra-state.outputs.sg]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-2"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y nginx jq unzip
        echo "<h1>Deployed via terraform on test-server-2</h1>" | sudo tee /var/www/html/index.html
		EOF
}



