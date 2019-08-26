resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.application
  acl           = "private"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = <<-JSON
  {
    "Id": "Policy1553611963961",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1553611962425",
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*",
        "Principal": "*"
      }
    ]
  }
JSON

}

resource "aws_s3_bucket_object" "index_html" {
  bucket       = aws_s3_bucket.s3_bucket.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/plain"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./index.html")
}

resource "aws_s3_bucket_object" "error_html" {
  bucket       = aws_s3_bucket.s3_bucket.id
  key          = "error.html"
  source       = "./error.html"
  content_type = "text/plain"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./error.html")
}
