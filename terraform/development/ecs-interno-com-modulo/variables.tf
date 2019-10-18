variable "region" {
  description = "A região que será usada"
  type        = string
}

variable "profile" {
  description = "O profile que será usado"
  type        = string
}

variable "vpc_id" {
  description = "O id da VPC onde os containers serão criados"
  type        = string
}

variable "aws_account_id" {
  description = "O ID da conta da AWS"
  type        = string
}

variable "route53_zone_id" {
  description = "O ID da zona no Route53"
  type        = string
}

variable "route53_zone_name" {
  description = "O nome da zona no Route53"
  type        = string
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