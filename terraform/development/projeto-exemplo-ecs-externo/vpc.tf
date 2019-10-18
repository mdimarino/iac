data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = var.vpc_id

  tags = {
    Name = "*-public-*"
  }
}

data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = var.vpc_id

  tags = {
    Name = "*-private-*"
  }
}

