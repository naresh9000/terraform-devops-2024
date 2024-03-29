vpc_name             = "functions-vpc"
vpc_cidr             = "25.0.0.0/16"
public_subnet_cidrs  = ["25.0.0.0/24", "25.0.1.0/24", "25.0.2.0/24"]
private_subnet_cidrs = ["25.0.3.0/24", "25.0.4.0/24", "25.0.5.0/24"]
azs                  = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
igw_name             = "functions_igw"
#sg                   = "functions-sg"
#ingress              = []
#egress               = []
instance_type = "t3.micro"
key_name      = "devops"
aws_region    = "ap-south-2"
ami = {
  ap-south-1 = "ami-03f4878755434977f"
  ap-south-2 = "ami-0bbc2f7f6287d5ca6"
}
