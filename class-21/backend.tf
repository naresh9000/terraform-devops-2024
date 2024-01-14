terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "provisioner-null-resources.tfstate"
    region = "ap-south-2"
  }
}
