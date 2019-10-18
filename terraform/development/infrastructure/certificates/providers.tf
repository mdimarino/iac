provider "aws" {
  region  = var.region
  profile = var.profile
  version = "~> 2.28.1"
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "terraform-estado-remoto"
    key            = "development/infrastructure/certificates/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-trava-estado"
  }
}

module "certificates" {
  source = "../../../modules/infrastructure/certificates"

  billing                   = "infrastructure"
  environment               = "development"
  domain_names              = ["di.marino.nom.br", "dimarino.net.br", "marcello.dimarino.nom.br"]
  subject_alternative_names = [["*.di.marino.nom.br"], ["*.dimarino.net.br"], ["*.marcello.dimarino.nom.br"]]
}