provider "aws" {
  region  = var.region
  profile = var.profile
  shared_credentials_file = var.credentials
  version = ">= 2.33.0"
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "terraform-estado-remoto"
    key            = "development/infrastructure/network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-trava-estado"
  }
}

module "network" {
  source = "../../../modules/infrastructure/network"

  billing        = "infrastructure"
  environment    = "development"
  application    = "infrastructure"
  vpc-name       = "vpc-dimarino-dev"
  vpc-cidr-block = "172.16.0.0/16"

    public-subnet-cidr-blocks = ["172.16.0.0/20",
      "172.16.32.0/20",
      "172.16.64.0/20",
      "172.16.96.0/20",
      "172.16.128.0/20",
      "172.16.160.0/20"]

    private-subnet-cidr-blocks = ["172.16.16.0/20",
      "172.16.48.0/20",
      "172.16.80.0/20",
      "172.16.112.0/20",
      "172.16.144.0/20",
      "172.16.176.0/20"]

    availability-zones = ["us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1e",
      "us-east-1f"]

  enable-nat-gateways = false

}
