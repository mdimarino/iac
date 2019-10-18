data "aws_acm_certificate" "acm_certificate" {
  domain   = var.route53_zone_name
  statuses = ["ISSUED"]
}

