resource "aws_s3_bucket" "devops-state-store" {
  bucket = "devops-state-store"

  tags = {
    Name        = "devops-state-store"
    Environment = "dev"
  }
}
