output "URL_da_aplicação" {
  value = "http://${var.application}.${var.route53_zone_name}"
}

