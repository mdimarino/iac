variable "region" {
  description = "A região que será usada"
  type        = string
}

variable "aws_account_id" {
  description = "O id da conta na AWS"
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

variable "provisioner" {
  description = "O nome do provisionador usado para construir a infraestrutura"
  type        = string
  default     = "Terraform"
}

variable "sqs_delay_seconds" {
  description = "O tempo em segundos que a entrega de todas as mensagens na fila será atrasada"
  type        = number
  default     = 0
}

variable "sqs_max_message_size" {
  description = "O limite de quantos bytes uma mensagem pode conter antes que o Amazon SQS a rejeite"
  type        = number
  default     = 262144 # 256Kb
}

variable "sqs_message_retention_seconds" {
  description = "O número de segundos que o Amazon SQS retém uma mensagem"
  type        = number
  default     = 345600 # 4 dias
}

variable "sqs_receive_wait_time_seconds" {
  description = "A hora em que uma chamada ReceiveMessage aguardará uma mensagem chegar (pesquisa longa) antes de retornar"
  type        = number
  default     = 0
}

variable "sqs_visibility_timeout_seconds" {
  description = "O tempo limite de visibilidade da fila"
  type        = number
  default     = 30
}