terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "rds-meta-args.tfstate"
    region = "ap-south-2"
  }
}
