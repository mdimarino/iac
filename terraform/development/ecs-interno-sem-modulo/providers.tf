provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.profile
  version                 = "~> 2.18.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket         = "zoom-dev-s3-terraform-state-storage"
    key            = "dev/projeto-exemplo-ecs-interno"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

