resource "aws_s3_bucket" "s3_alb_logs" {
  bucket        = "s3-alb-logs-${var.application}"
  acl           = "private"
  force_destroy = true

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_s3_bucket_policy" "s3_alb_logs" {
  bucket = aws_s3_bucket.s3_alb_logs.id

  policy = <<-JSON
  {
    "Id": "Policy1553464378195",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1553464375711",
        "Action": [
          "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.s3_alb_logs.id}/AWSLogs/${var.aws_account_id}/*",
        "Principal": {
          "AWS": [
            "127311923021"
          ]
        }
      }
    ]
  }
JSON

}

