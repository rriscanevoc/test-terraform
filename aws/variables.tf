variable "aws_access_key" {
  description = "AWS Access Key para usuario de terraform"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key para usuario de terraform"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Ambiente del proyecto"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "aws_region" {
  description = "Región donde se desplegarán los recursos"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  description = "Amazon Machine Images a utilizar"
  type        = string
  default     = "ami-0075013580f6322a1"
}

variable "instance_type" {
  description = "Tipo de instancia de AWS"
  type        = string
  default     = "t2.micro"
}

variable "cidr_block" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
}

variable "public_cidr_block" {
  description = "Bloque CIDR para la subred pública"
  type        = string
}

variable "private_cidr_block" {
  description = "Bloque CIDR para la subred privada"
  type        = string
}

variable "route_cidr_block" {
  description = "Bloque CIDR para la tabla de rutas"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ingress_rules" {
  description = "Lista de reglas de entrada para el security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rules" {
  description = "Lista de reglas de salida para el security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "acl_ingress_rules" {
  description = "Reglas de entrada para el Network ACL"
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      rule_no    = 100
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    }
  ]
}

variable "acl_egress_rules" {
  description = "Reglas de salida para el Network ACL"
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      rule_no    = 100
      protocol   = "-1"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}

variable "instances" {
  description = "Mapa de configuraciones para cada instancia EC2"
  type = map(object({
    ami_id        = string
    instance_type = string
  }))
  default = {}
}

variable "rds_instances" {
  description = "Mapa de configuraciones para cada RDS"
  type = map(object({
    engine         = string
    engine_version = string
    instance_class = string
    size           = number
    username       = string
    password       = string
  }))
  default = {}
}

variable "db_az_count" {
  description = "Cantidad de zonas de disponibilidad a aplicar en RDS"
  type        = number
  default     = 0
}