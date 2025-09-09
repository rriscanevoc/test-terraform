variable "tenancy_ocid" {
  type        = string
  description = "OCID del Tenancy de OCI"
}

variable "user_ocid" {
  type        = string
  description = "OCID del usuario de OCI"
}

variable "fingerprint" {
  type        = string
  description = "Fingerprint de la clave pública"
}

variable "path_apikey" {
  type        = string
  description = "Ruta absoluta al archivo .pem"
}

variable "oci_region" {
  type        = string
  description = "Región donde se desplegará la infraestructura"
  default     = "us-phoenix-1"
}

variable "environment" {
  description = "Ambiente del proyecto"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "compartment_ocid" {
  type        = string
  description = "compartimento donde se desplegarán los recursos"
}

variable "vcn_cidr" {
  description = "Bloque CIDR para la VCN"
  type        = string
  default     = null
  validation {
    condition     = var.vcn_cidr != null || var.vcn_id != null
    error_message = "Debe proporcionar vcn_id o vcn_cidr (al menos uno)."
  }
}

variable "subnet_cidr" {
  description = "Bloque CIDR para la subred pública "
  type        = string
  default     = null
  validation {
    condition     = var.subnet_cidr != null || var.subnet_id != null
    error_message = "Debe proporcionar subnet_id o subnet_cidr (al menos uno)."
  }
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

/*variable "route_destination" {
  type        = string
  description = "Destino para las reglas de ruteo "
  default     = "0.0.0.0/0"
}

variable "route_destination_type" {
  type        = string
  description = "Tipo de destino en la tabla de ruteo"
  default     = "CIDR_BLOCK"
}*/

variable "instances" {
  description = "Mapa de configuraciones para cada instancia"
  type = map(object({
    image_id      = string
    shape         = string
    ocpus         = number
    memory_in_gbs = number
  }))
  default = {}

  validation {
    condition     = length(var.instances) > 0
    error_message = "Debe definir al menos una instancia"
  }
}
