# ------------------------
# VPC Principal
# ------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-${var.environment}-${var.project_name}"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Subred Pública
# ------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = local.a_z[0]

  tags = {
    Name        = "${var.environment}-${var.project_name}-public"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Subred Privada
# ------------------------
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_block
  availability_zone = local.a_z[0]

  tags = {
    Name        = "${var.environment}-${var.project_name}-private"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Internet Gateway
# ------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-${var.project_name}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Tabla de rutas para la Subred Pública
# ------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.environment}-${var.project_name}-public-rtb"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Asociación de tabla de rutas a la Subred Pública
# ------------------------
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

#-------------------------
# Subnet privada de DB
#-------------------------
resource "aws_subnet" "rds_private" {
  for_each = { for idx, az in local.db_az : idx => az }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.private_cidr_block, 4, each.key)
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${var.project_name}-${each.key}"
    Environment = var.environment
    Project     = var.project_name
  }
}

#-------------------------
# Subnet privada de DB
#-------------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-${var.project_name}-db-subnets"
  subnet_ids = [for s in aws_subnet.rds_private : s.id]

  tags = {
    Name        = "${var.environment}-${var.project_name}-rds-subnet-group"
    Environment = var.environment
    Project     = var.project_name
  }
}