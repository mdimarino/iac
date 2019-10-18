variable "billing" {
  description = "A área de cobrança do custo"
  type        = string
}

variable "environment" {
  description = "O ambiente que será usado"
  type        = string
}

variable "provisioner" {
  description = "O nome do provisionador usado para construir a infraestrutura"
  type        = string
  default     = "Terraform"
}

variable "domain_names" {
  description = "O nome do domínio cadastrado no Route53"
  type        = list(string)
}

variable "subject_alternative_names" {
  description = "Uma lista composta por listas, cada uma contendo os domínios alternativos a serem incluídos no certificado"
  type        = list(list(string))
}

variable "validation_method" {
  description = "O método de validação do certificado: DNS ou EMAIL"
  type        = string
  default     = "DNS"
}