terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = "acesskey"
  secret_key = "secretkey"
  region     = "ap-south-2"
}
