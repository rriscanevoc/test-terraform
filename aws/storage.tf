# -------------------------------
# Lista de instancias RDS
# -------------------------------
resource "aws_db_instance" "rds" {
  for_each = var.rds_instances

  identifier             = "${var.environment}-${each.key}"
  engine                 = each.value.engine
  engine_version         = each.value.engine_version
  instance_class         = each.value.instance_class
  allocated_storage      = each.value.size
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  username               = each.value.username
  password               = each.value.password
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name        = "${var.environment}-${each.key}"
    Environment = var.environment
    Project     = var.project_name
  }
}
