resource "aws_sqs_queue" "sqs_queue" {
  name = var.application

  tags = {
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

