output "instance_id" {
  description = "OCID de la instancia creada"
  value       = oci_core_instance.instance.id
}

output "public_ip" {
  description = "IP pública de la instancia"
  value       = oci_core_instance.instance.public_ip
}

output "private_ip" {
  description = "IP privada de la instancia"
  value       = oci_core_instance.instance.private_ip
}
