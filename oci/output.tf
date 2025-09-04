/*output "instances" {
  description = "Información de las instancias creadas"
  value = {
    for k, instance in module.instances : k => {
      id         = instance.instance_id
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}

output "vcn_id" {
  description = "ID de la VCN"
  value       = module.vcn.vcn_id
}

output "subnet_id" {
  description = "ID de la subnet pública"
  value       = module.vcn.subnet_id
}*/