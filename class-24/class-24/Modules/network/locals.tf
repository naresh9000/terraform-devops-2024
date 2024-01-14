locals {
  DeployedBy             = upper("Terraform")
  Owner                  = lower("devops-Dev-Team")
  Costcenter             = upper("INDIA-8080")
  TeamDL                 = lower("alphadev@phoenix.com")
  new_public_cidr_block  = distinct(var.public_cidr_block)
  new_private_cidr_block = distinct(var.private_cidr_block)
}
#distinct removes duplicates in the list and preserve the index order.
# toset removes duplicates in the list but dont preserve the index order. Good for for_each.
