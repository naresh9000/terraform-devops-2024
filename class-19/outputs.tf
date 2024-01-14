output "vpc_id" {
  value = aws_vpc.default.id
}

output "subnet1-id" {
  value = aws_subnet.subnet1-public.id
}

output "subnet2-id" {
  value = aws_subnet.subnet2-public.id
}

output "subnet3-id" {
  value = aws_subnet.subnet3-public.id
}

output "sg" {
  value = aws_security_group.allow-all.id
}
