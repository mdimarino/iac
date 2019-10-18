output "vpc-id" {
  value       = module.network.vpc-id
  description = "O ID da vpc"
}

output "vpc-name" {
  value       = module.network.vpc-name
  description = "O nome da vpc"
}

output "private-zone-id" {
  value       = module.network.private-zone-id
  description = "O ID da zona privada da vpc"
}

output "vpc-cidr-block" {
  value       = module.network.vpc-cidr-block
  description = "O CIDR da vpc"
}

output "public-subnet-cidr-blocks" {
  value       = module.network.public-subnet-cidr-blocks
  description = "Os intervalos de IPs usados nas subnets públicas"
}

output "private-subnet-cidr-blocks" {
  value       = module.network.private-subnet-cidr-blocks
  description = "Os intervalos de IPs usados nas subnets privadas"
}

output "availability-zones" {
  value       = module.network.availability-zones
  description = "As zonas de disponibilidade da região"
}