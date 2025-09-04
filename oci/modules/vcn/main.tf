# -------------------------------
# Red Virtual (VCN)
# -------------------------------
resource "oci_core_virtual_network" "vcn" {

  count = var.vcn_id == null && var.vcn_cidr != null ? 1 : 0

  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn_cidr
  display_name   = "vcn-${var.environment}-${var.project}"
  dns_label      = "vcn"
}

# -------------------------------
# Subnet Pública
# -------------------------------
resource "oci_core_subnet" "public_subnet" {

  count = var.subnet_id == null && var.subnet_cidr != null ? 1 : 0

  compartment_id             = var.compartment_ocid
  vcn_id                     = var.vcn_id != null ? var.vcn_id : oci_core_virtual_network.vcn[0].id
  cidr_block                 = var.subnet_cidr
  display_name               = "${var.environment}-${var.project}-public"
  prohibit_public_ip_on_vnic = false
  availability_domain        = var.availability_domain
  route_table_id             = oci_core_route_table.public_rt[0].id
  dns_label                  = "pubsub"
  security_list_ids          = [oci_core_security_list.security_list.id]

  freeform_tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# -------------------------------
# Internet Gateway
# -------------------------------
resource "oci_core_internet_gateway" "igw" {

  count = var.vcn_id == null && var.vcn_cidr != null ? 1 : 0

  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "ig-${var.environment}-${var.project}"
  enabled        = true
}

# -------------------------------
# Tabla de Rutas
# -------------------------------
resource "oci_core_route_table" "public_rt" {

  count = var.vcn_id == null && var.vcn_cidr != null ? 1 : 0

  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "${var.environment}-${var.project}-public-rt"

  route_rules {
    network_entity_id = oci_core_internet_gateway.igw[0].id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}