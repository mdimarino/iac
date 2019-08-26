output "website_endpoint" {
  value     = module.s3-static-website.website_endpoint
  description = "A URL do bucket"
}