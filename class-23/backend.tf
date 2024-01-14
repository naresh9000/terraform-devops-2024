terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "functions.tfstate"
    region = "ap-south-2"
  }
}
