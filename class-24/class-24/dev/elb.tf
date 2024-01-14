module "dev_elb_1" {
  source          = "../Modules/elb"
  env             = module.dev_vpc_1.environment
  nlbname         = "devb29-nlb"
  subnets         = module.dev_vpc_1.public_subnets_id
  tgname          = "devb29-nlb-tg"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_compute_1.private_servers

}
