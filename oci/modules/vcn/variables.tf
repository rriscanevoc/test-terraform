variable "compartment_ocid" {
  type        = string
  description = "OCID del compartimento donde se crearán los recursos"
}

variable "environment" {
  description = "Nombre del entorno (ej: dev, staging, prod)"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "vcn_cidr" {
  description = "Bloque CIDR para la VCN"
  type        = string
  default     = null
}

variable "subnet_cidr" {
  description = "Bloque CIDR para la subred pública"
  type        = string
  default     = null
}

variable "vcn_id" {
  description = "ID de VCN existente. Si se proporciona, no se creará una nueva VCN"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "ID de subnet existente. Si se proporciona, no se creará una nueva subnet"
  type        = string
  default     = null
}

variable "availability_domain" {
  description = "Dominio de disponibilidad para la subnet"
  type        = string
}