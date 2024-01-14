resource "aws_route" "nat_route" {
  route_table_id            = var.private_rt_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.natgw.id
  depends_on                = [aws_nat_gateway.natgw]
}