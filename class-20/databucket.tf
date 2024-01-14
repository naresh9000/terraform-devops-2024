resource "aws_s3_bucket" "bucket001devops1" {
  bucket = "bucket001devops1"

  tags = {
    Name        = "bucket001devops1"
    Environment = "dev"
  }
  lifecycle {
    create_before_destroy = false
  }
}
resource "aws_s3_bucket" "bucket002devops2" {
  bucket = "bucket002devops2"

  tags = {
    Name        = "bucket002devops2"
    Environment = "dev"
  }
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_s3_bucket" "bucket003devops3" {
  bucket = "bucket003devops3"

  tags = {
    Name        = "bucket003devops3"
    Environment = "dev"
  }
  lifecycle {
    create_before_destroy = false
  }

}
