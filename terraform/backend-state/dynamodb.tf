resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "terraform-trava-estado"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Tabela de trava do estado do Terraform"
    Environment = var.environment
    Billing     = var.billing
  }
}
