terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "modules-devops-terraform-cloud.tfstate"
    region = "ap-south-2"
    # dynamodb_table = "devopsb27-terraform-locking"
    # encrypt        = true
  }
}
