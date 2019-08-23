resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3-terraform-remote-state
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "Estado remoto do Terraform"
    Environment = "${var.environment}"
    Billing     = "${var.billing}"
  }
}
