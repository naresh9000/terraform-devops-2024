terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "modules-devops.tfstate"
    region = "ap-south-2"
    # dynamodb_table = "devopsb27-terraform-locking"
    # encrypt        = true
  }
}
