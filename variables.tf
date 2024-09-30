# variables.tf

variable "jenkins_ami_id" {
  description = "AMI ID for Jenkins EC2 instance."
  type        = string
}

variable "sonarqube_ami_id" {
  description = "AMI ID for SonarQube EC2 instance."
  type        = string
}

variable "jenkins_instance_type" {
  description = "Instance type for Jenkins EC2."
  type        = string
}

variable "sonarqube_instance_type" {
  description = "Instance type for SonarQube EC2."
  type        = string
}

variable "key_name" {
  description = "Key pair name for both instances."
  type        = string
}

variable "jenkins_security_group_id" {
  description = "Security group ID for Jenkins EC2."
  type        = string
}

variable "sonarqube_security_group_id" {
  description = "Security group ID for SonarQube EC2."
  type        = string
}
