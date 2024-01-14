terraform {
  backend "s3" {
    bucket  = "devops-state-store"
    key     = "dev/aws-terraform.tfstate"
    region  = "ap-south-2"
    encrypt = false

  }
}
