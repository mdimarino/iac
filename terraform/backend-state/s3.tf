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

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}