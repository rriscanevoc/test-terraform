output "ec2_instances" {
  value = {
    for k, ec2 in aws_instance.varias_ec2 :
    k => {
      id         = ec2.id
      name       = ec2.tags["Name"]
      public_ip  = ec2.public_ip
      private_ip = ec2.private_ip
    }
  }
}
