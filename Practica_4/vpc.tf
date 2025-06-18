resource "aws_vpc" "vpc-virgina" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_VIRGINA"
    env  = "dev"
  }
}

resource "aws_vpc" "vpc-ohio" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC_OHIO"
    env  = "dev"
  }
  provider = aws.ohio
}
