resource "aws_vpc" "vpc-virginia" {
  #   cidr_block = lookup(var.virginia_cidr, terraform.workspace)
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC-Virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc-virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-public-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc-virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "subnet-private-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-virginia.id
  tags = {
    Name = "igw vpc-${local.sufix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public CRT-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc-virginia.id
  tags = {
    Name = "sg-public-instance-${local.sufix}"
  }

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

}

# resource "aws_vpc_security_group_ingress_rule" "public_instance_ingress_rules" {
#   for_each = toset(var.ingress_ports_list)
#   security_group_id = aws_security_group.sg_public_instance.id
#   from_port         = each.value
#   to_port           = each.value
#   ip_protocol       = "tcp"
#   cidr_ipv4         = var.sg_ingress_cidr
#   description       = "Allow inbound traffic on port ${each.value}"
# }


resource "aws_vpc_security_group_egress_rule" "sg_public_instance_egress" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# resource "aws_vpc_security_group_ingress_rule" "sg_public_instance_ingress" {
#   description       = "SSH over internet"
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = var.sg_ingress_cidr
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }
