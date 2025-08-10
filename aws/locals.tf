locals {
  a_z = slice(data.aws_availability_zones.available.names, 0, 1)
}

locals {
  db_az = length(data.aws_availability_zones.available.names) > 0 ? slice(data.aws_availability_zones.available.names, 0, var.db_az_count) : []
}
