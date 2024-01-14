data "aws_vpc" "devops-vpc" {
  id = "vpc-095217145f7fcf1eb"

}

data "aws_subnet" "devops-subnet-public1-ap-south-2a" {
  count             = 1
  availability_zone = "ap-south-2a"
  vpc_id            = "vpc-095217145f7fcf1eb"

  tags = {
    Name = "devops-subnet-public1-ap-south-2a"
  }

}

data "aws_security_group" "devops" {
  name   = "devops"
  id     = "sg-02e042587cb2d7453"
  vpc_id = "vpc-095217145f7fcf1eb"

}

data "aws_key_pair" "devops" {
  key_name = var.key_name

}
# please add the resource block to add any resources here

# resource "aws_instance" "web-1" {
#   ami                         = "ami-06fe902e167e67d33"
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = data.aws_subnet.devops-subnet-public1-ap-south-2a[0].id
#   vpc_security_group_ids      = ["${data.aws_security_group.devops.id}"]
#   associate_public_ip_address = true
#   tags = {
#     Name = "web-1"
#     env  = "dev"
#   }


# }
