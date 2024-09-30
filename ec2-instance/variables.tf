# ec2-instance/variables.tf

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "key_name" {
  description = "The key pair to use for the instance."
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to assign to the instance."
  type        = string
}

variable "instance_name" {
  description = "The name to assign to the instance."
  type        = string
}
