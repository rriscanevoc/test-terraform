# -------------------------------
# Red Virtual (VCN)
# -------------------------------
module "vcn" {
  source = "./modules/vcn"

  compartment_ocid    = var.compartment_ocid
  environment         = var.environment
  project             = var.project_name
  vcn_id              = var.vcn_id
  subnet_id           = var.subnet_id
  vcn_cidr            = var.vcn_cidr
  subnet_cidr         = var.subnet_cidr
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
}