provider "aws" {
  region  = var.region
  profile = var.profile
  version = "~> 2.25"
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "terraform-estado-remoto"
    key            = "development/simple-queue/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-trava-estado"
  }
}

module "simple-queue" {
  source = "../../modules/simple-queue"

  region         = var.region
  aws_account_id = var.aws_account_id
  billing        = "infrastructure"
  environment    = "development"
  application    = "dev-simple-queue"
}