variable "region" {
  description = "A região que será usada"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "O profile que será usado"
  type        = string
  default     = "zoom-dev"
}

variable "billing" {
  description = "A área de cobrança do custo"
  type        = string
}

variable "environment" {
  description = "O ambiente que será usado"
  type        = string
}

variable "application" {
  description = "O nome da aplicação"
  type        = string
}

variable "application_port" {
  description = "A porta TCP que a aplicação ouve"
  type        = string
}

variable "alb_port" {
  description = "A porta TCP que balanceador de carga ouve"
  type        = string
}

variable "ecr_name" {
  description = "O nome do repositório de imagens docker"
  type        = string
}

variable "ecr_uri" {
  description = "A URI do repositório de imagens docker"
  type        = string
  default     = "695242031986.dkr.ecr.us-east-1.amazonaws.com"
}

variable "ecs_name" {
  description = "O nome do cluster de imagens ECS"
  type        = string
}

variable "vpc_id" {
  description = "O id da VPC onde os containers serão criados"
  type        = string
  default     = "vpc-08352c84e0be267d1"
}

variable "target_group_health_check_path" {
  description = "O PATH da a ser testado para garantir a conectividade"
  type        = string
}

variable "container_cpu" {
  description = "O número de unidades de CPU do container"
  type        = string
}

variable "container_memory" {
  description = "A quantidade de memória do container em megabytes"
  type        = string
}

variable "container_desired_count" {
  description = "A quantidade de containers criados"
  type        = string
}

variable "aws_account_id" {
  description = "O ID da conta da AWS"
  type        = string
  default     = "695242031986"
}

variable "route53_zone_id" {
  description = "O ID da zona no Route53"
  type        = string
  default     = "Z2XUJSID89UI21"
}

variable "route53_zone_name" {
  description = "O nome da zona no Route53"
  type        = string
  default     = "vpc-zoom-dev"
}

variable "git_repo" {
  description = "A URL do repositório git"
  type        = string
}

variable "git_repo_branch" {
  description = "O branch do repositório git"
  type        = string
}

variable "docker_tag" {
  description = "A tag da imagem docker"
  type        = string
  default     = "latest"
}

variable "provisioner" {
  description = "O nome do provisionador usado para construir a infraestrutura"
  type        = string
  default     = "Terraform"
}

