module "dev_compute_1" {
  source = "../Modules/compute"
  env    = module.dev_vpc_1.environment
  amis = {
    ap-south-2 = "ami-0bbc2f7f6287d5ca6" # ubuntu 22.04 LTS
    ap-south-2 = "ami-0bbc2f7f6287d5ca6" # ubuntu 22.04 LTS
  }
  aws_region           = var.aws_region
  instance_type        = "t3.micro"
  key_name             = "devops"
  iam_instance_profile = module.dev_iam_1.instprofile
  public_subnets       = module.dev_vpc_1.public_subnets_id
  private_subnets      = module.dev_vpc_1.private_subnets_id
  sg_id                = module.dev_sg_1.sg_id
  vpc_name             = module.dev_vpc_1.vpc_name
}

module "dev_iam_1" {
  source              = "../Modules/iam"
  env                 = module.dev_vpc_1.environment
  rolename            = "devopsb29testrole"
  instanceprofilename = "devopsb29instprofile"
}

#create  the role and  attach to the ec2 instance
