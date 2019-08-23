output "website_endpoint" {
  value     = "http://${aws_s3_bucket.s3_bucket.website_endpoint}/"
}