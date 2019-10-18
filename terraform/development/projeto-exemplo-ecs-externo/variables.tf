variable "region" {
  description = "A região que será usada"
  type        = string
}

variable "profile" {
  description = "O profile que será usado"
  type        = string
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
  type        = number
}

variable "alb_port" {
  description = "A porta TCP que balanceador de carga ouve"
  type        = number
}

variable "ecr_name" {
  description = "O nome do repositório de imagens docker"
  type        = string
}

variable "ecr_uri" {
  description = "A URI do repositório de imagens docker"
  type        = string
}

variable "ecs_name" {
  description = "O nome do cluster ECS"
  type        = string
}

variable "vpc_id" {
  description = "O id da VPC onde os containers serão criados"
  type        = string
}

variable "target_group_health_check_path" {
  description = "O PATH da a ser testado para garantir a conectividade"
  type        = string
}

variable "container_cpu" {
  description = "O número de unidades de CPU do container"
  type        = number
}

variable "container_memory" {
  description = "A quantidade de memória do container em megabytes"
  type        = number
}

variable "container_desired_count" {
  description = "A quantidade de containers criados"
  type        = number
}

variable "aws_account_id" {
  description = "O ID da conta da AWS"
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

variable "provisioner" {
  description = "O nome do provisionador usado para construir a infraestrutura"
  type        = string
  default     = "Terraform"
}

variable "appautoscaling_max_capacity" {
  description = "O número máximo de tasks rodando quando escalar para cima"
  type        = number
}

variable "appautoscaling_min_capacity" {
  description = "O número mínimo de tasks rodando quando escalar para baixo"
  type        = number
}

variable "CPU_target_value" {
  description = "O percentual de consumo de CPU para decidir se vai escalar para cima ou para baixo"
  type        = number
}

variable "CPU_scale_in_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para cima, antes que outra escalada possa ser iniciada"
  type        = number
}

variable "CPU_scale_out_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para baixo, antes que outra escalada possa ser iniciada"
  type        = number
}

variable "Memory_target_value" {
  description = "O percentual de consumo de memória para decidir se vai escalar para cima ou para baixo"
  type        = number
}

variable "Memory_scale_in_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para cima, antes que outra escalada possa ser iniciada"
  type        = number
}

variable "Memory_scale_out_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para baixo, antes que outra escalada possa ser iniciada"
  type        = number
}

variable "Requests_target_value" {
  description = "A quantidade de requisições no ALB para decidir se vai escalar para cima ou para baixo"
  type        = number
}

variable "Requests_scale_in_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para cima, antes que outra escalada possa ser iniciada"
  type        = number
}

variable "Requests_scale_out_cooldown" {
  description = "A quantidade de tempo, em segundos, após a conclusão de uma escalada para baixo, antes que outra escalada possa ser iniciada"
  type        = number
}
