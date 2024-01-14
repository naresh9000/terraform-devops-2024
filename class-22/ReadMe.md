#           Terraform Functions

We shall talk about
- count
- list
- length
- lookup
- element
- condition
- *squad syntax

1) length , count ,list 
 It's often used when you need to create multiple similar resources with the same configuration.
 it counts from list provided in terraform.tfvars

 resource "aws_subnet" "private-subnet" {
    # length =determines the no of elements in the list
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
    # element:element function is used to select a single element from a list or map based on its index or key
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-privateSubnet-${count.index + 1}"
  }
 }
here count.index + 1 is used to create unique names for each instance based on the current index.

2) *Squad syntax
we can get all info using the "*" rather using the index based
    for ex-1::
    outputs "Network-details"
    {
        Value = {
            private-subnet_name = aws_subnet.private-subnet.*.tags.Name
    public-subnet_name  = aws_subnet.public-subnet.*.tags.Name
        }
    }
    for ex-2::
        resource "aws_route_table_association" "public-subnet-association" {
        count          = length(var.public_subnet_cidrs)
        route_table_id = aws_route_table.public-route-table.id
        subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
}


3) Use of dynamic block and for-each
Dynamic blocks in Terraform allow you to generate and manage multiple repeated nested configurations 
dynamically. This is particularly useful when you have a list of similar configurations, and you want
to avoid duplicating code.

for ex:: using dynamic blocks for security groups

#use of for each and dynamic blocks for security group rules
variable "security_group_rules" {
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ,
    {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ,
    {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ,
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  ]


}

resource "aws_security_group" "allow_ssh_http_https" {
  name        = "allow_ssh_http_https"
  description = "ALLOW SSH,HTTP,HTTPS TRAFFIC"
  vpc_id      = aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.security_group_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_group_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}
