# -------------------------------
# Instancia Compute en OCI
# -------------------------------
module "instances" {
  source   = "./modules/compute"
  for_each = var.instances

  compartment_ocid    = var.compartment_ocid
  environment         = var.environment
  project             = var.project_name
  name                = each.key
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  subnet_id           = module.vcn.subnet_id
  image_id            = each.value.image_id
  shape               = each.value.shape
  ocpus               = each.value.ocpus
  memory_in_gbs       = each.value.memory_in_gbs
}
