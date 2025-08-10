# ------------------------
# Security Group para la instancia EC2
# ------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-${var.project_name}-sg"
  description = "Permitir SSH"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }


  tags = {
    Name        = "${var.environment}-${var.project_name}-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Network ACL para la subred pública
# ------------------------
resource "aws_network_acl" "public_acl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public.id]

  dynamic "ingress" {
    for_each = var.acl_ingress_rules
    content {
      rule_no    = ingress.value.rule_no
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.acl_egress_rules
    content {
      rule_no    = egress.value.rule_no
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = {
    Name        = "${var.environment}-${var.project_name}-public-acl"
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------
# Generación de clave SSH
# ------------------------
resource "tls_private_key" "ssh" {
  for_each = var.instances

  algorithm = "RSA"
  rsa_bits  = 4096
}

# ------------------------
# Creación de Key Pair
# ------------------------
resource "aws_key_pair" "generated_key" {
  for_each = var.instances

  key_name   = "ssh-${var.environment}-${each.key}-${random_id.suffix[each.key].hex}"
  public_key = tls_private_key.ssh[each.key].public_key_openssh

  lifecycle {
    ignore_changes = [public_key]
  }
  depends_on = [tls_private_key.ssh]
}

# ------------------------
# Guardar la clave privada en disco local
# ------------------------
resource "local_file" "private_key_pem" {
  for_each = var.instances

  content         = tls_private_key.ssh[each.key].private_key_pem
  filename        = "${path.module}/${var.environment}-${each.key}.pem"
  file_permission = "0600"
}

# ------------------------
# Sufijo para el nombre de la llave
# ------------------------
resource "random_id" "suffix" {
  for_each    = var.instances
  byte_length = 4
}


resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-${var.project_name}-rds-sg"
  description = "Security Group para RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Permitir acceso a RDS desde las instancias EC2"
    from_port   = 3306 # cambia según el motor: 5432 para PostgreSQL, 1521 para Oracle, etc.
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [
      aws_security_group.ec2_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-${var.project_name}-rds-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}