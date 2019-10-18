provider "aws" {
  region  = var.region
  profile = var.profile

  shared_credentials_file = "~/.aws/credentials"

  version = "~> 2.28.1"
}

terraform {
  required_version = ">= 0.12.0"
}
