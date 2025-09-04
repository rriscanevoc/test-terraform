
# -------------------------------
# Archivo de seguridad principal
# -------------------------------
# -------------------------------
# Clave SSH autorizada
# -------------------------------

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  lifecycle {
    prevent_destroy = true
  }
}

# -------------------------------
# Guardar llave privada en archivo local
# -------------------------------
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/${var.environment}-${var.project_name}.pem"
  file_permission = "0600"

  lifecycle {
    ignore_changes = [content]
  }
}

output "ssh_private_key_path" {
  description = "Ruta del PEM de la clave privada SSH"
  value       = local_file.private_key.filename
  sensitive   = true
}