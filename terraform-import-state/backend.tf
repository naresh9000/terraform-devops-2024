terraform {
  backend "s3" {
    bucket         = "devops-state-store"
    key            = "ec2.tfstate"
    region         = "ap-south-2"
    encrypt        = true
    dynamodb_table = "terraform-dynamodb-locking"
  }
}
