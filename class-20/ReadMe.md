#					Meta Arguments

**different types** 
```
provisioners,   for each,   count,  lifecycle,      provider, connection, variable,   output, locals,     depends_on
``` 

**We will be talking about..**
- create resource before destroying
- prevent destroy
- ignore changes
- How to deal with sensitive information in AWS
- generating Random passowords
- Saving passwords to secret manager

**Pre-requisites**
Create resources using the terraform
- VPC
- public/private subnets,IGW,NGW(private-subnets)
- route-table,route-table-association-subnet
- backend.tf for state file
- secuirty group
- s3-buckets for data backups and choose the        lifecycle based on the requirements

        
##  create Mysql data-base use of secrets manager.

Generate the random password in secrets-manager,
one can also enable the rotation of passwords..
```diff
resource "random_password" "password" {
  length           = 16
  special          = true
  min_special      = 3
  override_special = "!#$%&*()"
}

# Creating a AWS secret for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret" "secretmasterDB" {
  name = "Masteraccoundb"
}

# Creating a AWS secret versions for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = <<EOF
   {
    "username": "adminaccount",
    "password": "${random_password.password.result}"
   }
EOF
}

```

Create the Subnet group
```diff
resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1-public.id, aws_subnet.subnet2-public.id, aws_subnet.subnet3-public.id]

  tags = {
    Name = "RDS-Subnet-Group"
  }

}

```
**create the db-instance**
```diff
resource "aws_db_instance" "rds2" {
  allocated_storage = 20
  db_name           = "terraform_db_2"
  engine            = "mysql"
  #identifier             = "mydrs2"
  engine_version         = "8.0.33"
  instance_class         = "db.t3.micro"
  username               = local.rds_secrets_random.username
  password               = local.rds_secrets_random.password
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  publicly_accessible    = true
  depends_on             = [aws_db_subnet_group.default]
  lifecycle {
    prevent_destroy = true
  }
}

```
          terraform init
          terraform fmt;terraform validate
          terraform apply -auto-approve

**Note**
1) please note that while after apply the state file in s3 will load the username and passowrd as plain text,so it leads to breach of confidentiality,so implement the least privilege for the s3-state file bucket access..

2) Always s3 backup bukets gets replaced when any changes done to that databucket,so always use the lifecycle in the s3 bucket while creating i.e create before detsroy

3) apply lifecycle  -ignore changes(not sensitive info) if any user wants  to apply changes for created infra using the terraform by admin-user
for eg: adding tags,SG,adding subnets,adding route-tables