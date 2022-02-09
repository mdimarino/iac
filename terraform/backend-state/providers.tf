provider "aws" {
  region  = var.region
  profile = var.profile

  shared_credentials_file = "~/.aws/credentials"

  version = "~> 2.57.0"
}

terraform {
  required_version = ">= 0.12.0"
}
