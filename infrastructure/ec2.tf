data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}


resource "aws_instance" "terra_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  
  tags = {
    Name = "${var.env}-instance"
  }
  
  resource "aws_default_vpc" "default" {}
}

resource "aws_security_group" "terra_security" {
  name        = "${var.env}-security-group"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_8080" {
  security_group_id = aws_security_group.terra_security.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_443" {
  security_group_id = aws_security_group.terra_security.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_80" {
  security_group_id = aws_security_group.terra_security.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_22" {
  security_group_id = aws_security_group.terra_security.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terra_security.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all por
}
