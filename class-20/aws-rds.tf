resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1-public.id, aws_subnet.subnet2-public.id, aws_subnet.subnet3-public.id]

  tags = {
    Name = "RDS-Subnet-Group"
  }

}

# resource "aws_db_instance" "rds-1" {
#   allocated_storage      = 20
#   db_name                = "terraform_db-1"
#   engine                 = "mysql"
#   identifier             = "mydrs1"
#   engine_version         = "8.0.33"
#   instance_class         = "db.t3.micro"
#   username               = local.db_creds.username
#   password               = local.db_creds.password
#   skip_final_snapshot    = true
#   db_subnet_group_name   = aws_db_subnet_group.default.name
#   vpc_security_group_ids = [aws_security_group.allow_all.id]
#   publicly_accessible    = true
#   depends_on             = [aws_db_subnet_group.default]
#   lifecycle {
#     prevent_destroy = true
#   } 
# }


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
    prevent_destroy = false
  }
}
