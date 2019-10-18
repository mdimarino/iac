resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/ecs/${var.application}"
  retention_in_days = 30

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

