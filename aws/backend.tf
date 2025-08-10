terraform {
  backend "s3" {
    bucket  = "terraform-state-ccxc" # Nombre de tu bucket S3
    region  = "us-west-2"
    key     = "" # Se pasa con -backend-config
    encrypt = true
  }
}