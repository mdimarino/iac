resource "aws_acm_certificate" "acm_certificate" {
  count = length(var.domain_names)

  domain_name               = var.domain_names[count.index]
  subject_alternative_names = var.subject_alternative_names[count.index]
  validation_method         = "DNS"

  tags = {
    Name        = var.domain_names[count.index]
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }

  lifecycle {
    create_before_destroy = true
  }
}
