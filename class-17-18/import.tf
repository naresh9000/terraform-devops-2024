# here import-test-vpc is the name of the VPC locally but not remotely
resource "aws_vpc" "import-test-vpc" {
  cidr_block = "20.0.0.0/18"
  tags = {
    Name = "import-test-vpc"
  }
}

resource "aws_instance" "import-instance" {
  ami                    = "ami-06fe902e167e67d33"
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = "subnet-06f1c7a80293efafa"
  vpc_security_group_ids = ["sg-033e0db1ff0f6ce9b"]

}
