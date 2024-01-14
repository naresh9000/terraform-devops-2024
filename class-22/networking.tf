resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}"
  }

}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.igw_name}"
  }


}

resource "aws_subnet" "public-subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-publicSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-privateSubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "${var.vpc_name}-publicRouteTable"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.vpc_name}-privateRouteTable"
  }
}

resource "aws_route_table_association" "public-subnet-association" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)

}

resource "aws_route_table_association" "private-subnet-association" {
  count          = length(var.private_subnet_cidrs)
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)

}

