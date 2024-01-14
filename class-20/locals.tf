locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.rds-terraform-secret.secret_string
  )
}

locals {
  rds_secrets_random = jsondecode(
    aws_secretsmanager_secret_version.sversion.secret_string
  )

}
