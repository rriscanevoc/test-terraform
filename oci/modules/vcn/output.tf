output "vcn_id" {
  description = "OCID de la VCN efectiva (existente o creada)"
  value = coalesce(
    try(data.oci_core_vcn.existing[0].id, null),
    try(oci_core_vcn.this[0].id, null)
  )
}

output "subnet_id" {
  description = "OCID de la subnet pública efectiva (existente o creada)"
  value = coalesce(
    try(data.oci_core_subnet.existing[0].id, null),
    try(oci_core_subnet.public[0].id, null)
  )
}