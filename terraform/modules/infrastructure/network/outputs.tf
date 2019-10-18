output "vpc-id" {
  value       = aws_vpc.vpc.id
  description = "O ID da vpc"
}

output "vpc-name" {
  value       = var.vpc-name
  description = "O nome da vpc"
}

output "private-zone-id" {
  value       = aws_route53_zone.vpc_route53_zone.zone_id
  description = "O ID da zona privada da vpc"
}

output "vpc-cidr-block" {
  value       = var.vpc-cidr-block
  description = "O CIDR da vpc"
}

output "public-subnet-cidr-blocks" {
  value       = var.public-subnet-cidr-blocks
  description = "Os intervalos de IPs usados nas subnets públicas"
}

output "private-subnet-cidr-blocks" {
  value       = var.private-subnet-cidr-blocks
  description = "Os intervalos de IPs usados nas subnets privadas"
}

output "availability-zones" {
  value       = var.availability-zones
  description = "As zonas de disponibilidade da região"
}