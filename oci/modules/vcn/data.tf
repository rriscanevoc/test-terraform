data "oci_core_vcn" "existing" {
  count  = var.vcn_id != null ? 1 : 0
  vcn_id = var.vcn_id
}

data "oci_core_subnet" "existing" {
  count     = var.subnet_id != null ? 1 : 0
  subnet_id = var.subnet_id
}
