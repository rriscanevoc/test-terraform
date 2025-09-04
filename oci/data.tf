# --------------------------------------
# Obtiene los dominios de disponibilidad disponibles para el compartimento especificado
# --------------------------------------
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

# --------------------------------------
# Obtiene las imágenes de Ubuntu compatibles con ARM para lanzar instancias
# --------------------------------------
/*data "oci_core_images" "ubuntu" {
  # Apunta al compartment raíz (tu tenancy) donde están las imágenes públicas
  compartment_id = var.tenancy_ocid

  # Filtra por imagenes cuyo display_name empiece por "Canonical-Ubuntu-22.04"
  display_name             = "^Canonical-Ubuntu-22.04.*"
  regex                    = true

  # Sistema operativo
  operating_system         = "Canonical Ubuntu"

  # Versión del SO (22.04)
  operating_system_version = "22.04"

  # Sólo imágenes disponibles para tu shape (opcional, pero recomendado)
  shape                    = var.instance_shape

  # Solo imágenes en estado usable
  state                    = "AVAILABLE"

  # Orden descendente por fecha de creación
  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}*/

