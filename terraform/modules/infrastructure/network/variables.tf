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

variable "provisioner" {
  description = "O nome do provisionador usado para construir a infraestrutura"
  type        = string
  default     = "Terraform"
}

variable "vpc-name" {
  description = "O nome da vpc que será usado"
  type        = string
}

variable "vpc-cidr-block" {
  description = "O CIDR da vpc"
  type        = string
}

variable "public-subnet-cidr-blocks" {
  description = "Os intervalos de IPs usados nas subnets públicas"
  type        = list(string)
}

variable "private-subnet-cidr-blocks" {
  description = "Os intervalos de IPs usados nas subnets privadas"
  type        = list(string)
}

variable "availability-zones" {
  description = "As zonas de disponibilidade da região"
  type        = list(string)
}