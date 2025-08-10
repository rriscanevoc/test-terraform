# ------------------------
# Instancia EC2 pública
# ------------------------
/*resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "ssh-${var.environment}-${var.project_name}-${random_id.suffix.hex}"
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name        = "${var.environment}-${var.project_name}"
    Environment = var.environment
    Project     = var.project_name
  }
}*/

# ------------------------
# Lista de instancia EC2 pública
# ------------------------
resource "aws_instance" "varias_ec2" {

  for_each = var.instances

  ami                         = each.value.ami_id
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "ssh-${var.environment}-${each.key}-${random_id.suffix[each.key].hex}"
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  tags = {
    Name        = "${var.environment}-${each.key}"
    Environment = var.environment
    Project     = each.key
  }
}