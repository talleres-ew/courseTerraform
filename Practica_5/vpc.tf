resource "aws_vpc" "vpc-virgina" {
  cidr_block = var.virgina_cidr
  tags = {
    Name = "VPC_VIRGINA"
    env  = "dev"
  }
}

resource "aws_vpc" "vpc-ohio" {
  cidr_block = var.ohio_cidr
  tags = {
    Name = "VPC_OHIO"
    env  = "dev"
  }
  provider = aws.ohio
}
