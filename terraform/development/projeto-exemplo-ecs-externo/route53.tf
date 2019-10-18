data "aws_route53_zone" "route53_zone" {
  name = "${var.route53_zone_name}."
}

resource "aws_route53_record" "route53_record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = var.application
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

