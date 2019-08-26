provider "aws" {
  region  = var.region
  profile = var.profile
  version = "~> 2.25"
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "terraform-estado-remoto"
    key            = "development/s3-static-website/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-trava-estado"
  }
}

module "s3-static-website" {
  source = "../../modules/s3-static-website"

  billing     = "infrastructure"
  environment = "development"
  application = var.application
}