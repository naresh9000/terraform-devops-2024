data "aws_secretsmanager_secret_version" "rds-terraform-secret" {
  secret_id = "rds-terraform"

}

