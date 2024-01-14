terraform {
  backend "s3" {
    bucket  = "devops-state-store"
    key     = "workspace.tfstate"
    region  = "ap-south-2"
    encrypt = false

  }
}
