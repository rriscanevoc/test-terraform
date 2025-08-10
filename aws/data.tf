# Buscar la VPC por nombre
/*data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Buscar la Subnet por nombre y VPC ID
data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}*/

data "aws_availability_zones" "available" {
  state = "available"
}
