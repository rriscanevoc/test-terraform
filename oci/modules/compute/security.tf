# -------------------------------
# Generación de llave SSH
# -------------------------------
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# -------------------------------
# Crear directorio para llaves
# -------------------------------
resource "local_file" "ssh_directory" {
  filename        = "${path.module}/keys/.keep"
  content         = ""
  file_permission = "0600"

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/keys"
  }
}

# -------------------------------
# Guardar llave privada en archivo local
# -------------------------------
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/keys/${var.environment}-${var.project}-${var.name}.pem"
  file_permission = "0600"

  depends_on = [local_file.ssh_directory]
}
