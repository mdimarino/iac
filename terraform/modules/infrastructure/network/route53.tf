resource "aws_route53_zone" "vpc_route53_zone" {
  
  name = var.vpc-name

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  tags = {
    Name        = var.vpc-name
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}