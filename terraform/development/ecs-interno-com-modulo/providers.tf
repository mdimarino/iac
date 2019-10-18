provider "aws" {
  region  = var.region
  profile = var.profile
  version = "~> 2.25"
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "terraform-estado-remoto"
    key    = "development/ecs-interno/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "terraform-estado-remoto"
    key            = "development/ecs-interno/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-trava-estado"
  }
}

module "ecs-interno" {
  source = "../../modules/ecs-interno"

  region                         = var.region
  vpc_id                         = data.terraform_remote_state.network.vpc.id
  aws_account_id                 = var.aws_account_id
  route53_zone_id                = data.terraform_remote_state.network.vpc_route53_zone.zone_id
  route53_zone_name              = data.terraform_remote_state.network.vpc-name
  git_repo                       = var.git_repo
  git_repo_branch                = var.git_repo_branch
  docker_tag                     = var.docker_tag
  billing                        = "infrastructure"
  environment                    = "development"
  application                    = "spring-boot-hello"
  application_port               = 8080
  alb_port                       = 80
  ecr_name                       = "spring-boot-hello"
  ecr_uri                        = ""
  ecs_name                       = "spring-boot-hello"
  target_group_health_check_path = "/"
  container_cpu                  = 256
  container_memory               = 512
  container_desired_count        = 2
  appautoscaling_max_capacity    = 4
  appautoscaling_min_capacity    = 1
  CPU_target_value               = 70
  CPU_scale_in_cooldown          = 30
  CPU_scale_out_cooldown         = 30
  Memory_target_value            = 60
  Memory_scale_in_cooldown       = 10
  Memory_scale_out_cooldown      = 10
  Requests_target_value          = 100
  Requests_scale_in_cooldown     = 30
  Requests_scale_out_cooldown    = 30
}