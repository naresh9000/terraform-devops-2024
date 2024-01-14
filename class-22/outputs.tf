output "Network-details" {
  value = {
    vpc_id              = aws_vpc.default.id
    internet_gateway_id = aws_internet_gateway.default.id
    public-subnet_ids   = aws_subnet.public-subnet.*.id
    private-subnet_ids  = aws_subnet.private-subnet.*.id
    public-route-table  = aws_route_table.public-route-table.id
    private-route-table = aws_route_table.private-route-table.id
    #public-sg           = aws_security_group.sg.id
    # private-sg          = aws_security_group.private-sg.id
    # nat-gateway         = aws_nat_gateway.nat-gateway.id
    # eip                 = aws_eip.eip.id
    # eip_association     = aws_eip_association.eip-association.id
    private-subnet_cidr = aws_subnet.private-subnet.*.cidr_block
    public-subnet_cidr  = aws_subnet.public-subnet.*.cidr_block
    # private-subnet_az   = aws_subnet.private-subnet.*.availability_zone
    # public-subnet_az    = aws_subnet.public-subnet.*.availability_zone
    private-subnet_name = aws_subnet.private-subnet.*.tags.Name
    public-subnet_name  = aws_subnet.public-subnet.*.tags.Name



  }
}
