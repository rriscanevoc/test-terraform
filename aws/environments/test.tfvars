environment = "test"

project_name = "terraform"

ami_id = "ami-0075013580f6322a1"

instance_type = "t2.micro"

cidr_block = "10.0.0.0/16"

private_cidr_block = "10.0.1.0/24"

public_cidr_block = "10.0.2.0/24"

route_cidr_block = "0.0.0.0/0"

db_az_count = 0

instances = {
  App_test_1 = {
    ami_id        = "ami-0075013580f6322a1"
    instance_type = "t2.micro"
  }

  App_test_2 = {
    ami_id        = "ami-0075013580f6322a1"
    instance_type = "t2.small"
  }
}
