module "dev_route53_1" {
  source     = "../Modules/route53"
  domainname = "dailytrendingupdate.com"
  nlb_id     = module.dev_elb_1.elb_id
  dns_name   = module.dev_elb_1.elb_dns_name
  zone_id    = module.dev_elb_1.elb_zone_id
  recordname = "devops"
}
