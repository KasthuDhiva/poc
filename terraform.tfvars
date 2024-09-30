# terraform.tfvars

jenkins_ami_id            = "ami-025335d54c92ff883"
sonarqube_ami_id          = "ami-00f105558d5fe2f26"
key_name                  = "poc4"
jenkins_security_group_id = "sg-0b6844dbd37d4dfdb"
sonarqube_security_group_id = "sg-0cb579992314469dc"
jenkins_instance_type     = "t3.medium"       # Specific instance type for Jenkins
sonarqube_instance_type   = "t2.medium"      # Specific instance type for SonarQube
