resource "aws_instance" "private-servers" {
  depends_on    = [aws_nat_gateway.ngw]
  count         = length(var.private_subnet_cidrs)
  ami           = lookup(var.ami, var.aws_region)
  instance_type = var.instance_type
  subnet_id     = element(aws_subnet.private-subnet.*.id, count.index)
  key_name      = var.key_name
  #maximum we can keep per server=5 security groups
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh_http_https.id}", "${aws_security_group.allow_ssh_http_https.id}"]
  associate_public_ip_address = true
  user_data                   = <<-EOF
		#! /bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
        echo "<h1>${var.vpc_name}-privateServer-${count.index + 1}</h1>" | sudo tee /var/www/html/index.html

	EOF
  tags = {
    Name = "${var.vpc_name}-privateServer-${count.index + 1}"
  }

}
