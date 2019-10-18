data "aws_route53_zone" "route53_zone" {
  count = length(var.domain_names)

  name         = "${var.domain_names[count.index]}."
  private_zone = false
}

resource "aws_route53_record" "route53_record" {
  count = length(var.domain_names)

  name    = aws_acm_certificate.acm_certificate[count.index].domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.acm_certificate[count.index].domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.route53_zone[count.index].id
  records = [aws_acm_certificate.acm_certificate[count.index].domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  count = length(var.domain_names)

  certificate_arn         = aws_acm_certificate.acm_certificate[count.index].arn
  validation_record_fqdns = [aws_route53_record.route53_record[count.index].fqdn]

  timeouts {
    create = "15m"
  }
}