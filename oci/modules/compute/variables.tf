variable "environment" {
  description = "Nombre del entorno"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "name" {
  description = "Nombre para la instancia"
  type        = string
}

variable "compartment_ocid" {
  type        = string
  description = "OCID del compartimento donde se crearán los recursos"
}

variable "availability_domain" {
  description = "Dominio de disponibilidad para la instancia"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet donde se lanzará la instancia"
  type        = string
}

variable "image_id" {
  description = "OCID de la imagen para la instancia"
  type        = string
}

variable "shape" {
  description = "Shape de la instancia"
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "ocpus" {
  description = "Número de OCPUs para la instancia"
  type        = number
  default     = 1

  validation {
    condition     = var.ocpus >= 1
    error_message = "El número mínimo de OCPUs debe ser 1"
  }
}

variable "memory_in_gbs" {
  description = "Cantidad de memoria RAM en GB"
  type        = number
  default     = 4

  validation {
    condition     = var.memory_in_gbs >= 1
    error_message = "La memoria mínima debe ser 1 GB"
  }
}

variable "boot_volume_size_in_gbs" {
  description = "Tamaño del volumen de arranque en GB"
  type        = number
  default     = 50

  validation {
    condition     = var.boot_volume_size_in_gbs >= 50
    error_message = "El tamaño mínimo del volumen debe ser 50 GB"
  }
}

variable "assign_public_ip" {
  description = "Asignar IP pública a la instancia"
  type        = bool
  default     = true
}

variable "network_security_group_ids" {
  description = "Lista de IDs de grupos de seguridad de red"
  type        = list(string)
  default     = []
}