# Exemplos de subredes usando CIDR 172.16.

# Cada subrede terá 4091 endereços para hosts.
# A AWS reserva os IPs .1(VPC router), .2(Amazon-provided DNS) e .3(uso futuro).
# Netmask: 255.255.240.0 = 20

# zona a publica 01 172.16.0.0/20 - 172.16.0.4 a 172.16.15.254
# zona a privada 01 172.16.16.0/20 - 172.16.16.4 a 172.16.31.254

# zona b publica 02 172.16.32.0/20 - 172.16.32.4 a 172.16.47.254
# zona b privada 02 172.16.48.0/20 - 172.16.48.4 a 172.16.63.254

# zona c publica 03 172.16.64.0/20 - 172.16.64.4 a 172.16.79.254
# zona c privada 03 172.16.80.0/20 - 172.16.80.4 a 172.16.95.254

# zona d publica 04 172.16.96.0/20 - 172.16.96.4 a 172.16.111.254
# zona d privada 04 172.16.112.0/20 - 172.16.112.4 a 172.16.127.254

# zona e publica 05 172.16.128.0/20 - 172.16.128.4 a 172.16.143.254
# zona e privada 05 172.16.144.0/20 - 172.16.144.4 a 172.16.159.254

# zona f publica 06 172.16.160.0/20 - 172.16.160.4 a 172.16.175.254
# zona f privada 06 172.16.176.0/20 - 172.16.176.4 a 172.16.191.254

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc-name
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  domain_name         = var.vpc-name
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name        = "${var.vpc-name}-dhcp-options"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.vpc_dhcp_options.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.vpc-name}-igw"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public-subnet-cidr-blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public-subnet-cidr-blocks, count.index)
  availability_zone       = element(var.availability-zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.vpc-name}-public-subnet-0${count.index + 1}"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private-subnet-cidr-blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private-subnet-cidr-blocks, count.index)
  availability_zone       = element(var.availability-zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.vpc-name}-private-subnet-0${count.index + 1}"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_eip" "nat_eips" {
  count = length(var.public-subnet-cidr-blocks)
  vpc   = true

  tags = {
    Name        = "${var.vpc-name}-nat-gateway-ip-0${count.index + 1}"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_nat_gateway" "nat_gateways" {
  count         = length(var.public-subnet-cidr-blocks)
  allocation_id = element(aws_eip.nat_eips.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = {
    Name        = "${var.vpc-name}-nat-gateway-0${count.index + 1}"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route_tables" {
  count  = length(var.private-subnet-cidr-blocks)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.vpc-name}-private-route-0${count.index + 1}"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private-subnet-cidr-blocks)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_tables.*.id, count.index)
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private-subnet-cidr-blocks)
  route_table_id         = element(aws_route_table.private_route_tables.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gateways.*.id, count.index)
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name        = "${var.vpc-name}-public-route"
    Environment = var.environment
    Billing     = var.billing
    Provisioner = var.provisioner
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public-subnet-cidr-blocks)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_default_route_table.default_route_table.default_route_table_id
}

resource "aws_route" "public_route_to_igw" {
  route_table_id         = aws_default_route_table.default_route_table.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
