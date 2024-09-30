# ec2-instance/main.tf

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]  # Use the security group for the specific instance

  tags = {
    Name = var.instance_name
  }
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance."
  value       = aws_instance.ec2_instance.public_ip
}
