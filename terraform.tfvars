# terraform.tfvars

jenkins_ami_id            = "ami-0f2a30afdea6fd3be"
sonarqube_ami_id          = "ami-0485a52b08596e97e"
key_name                  = "poc4"
jenkins_security_group_id = "sg-0a0d22bf23cb0664c"
sonarqube_security_group_id = "sg-033ec86ca04d0367c"
jenkins_instance_type     = "t3.medium"       # Specific instance type for Jenkins
sonarqube_instance_type   = "t2.medium"      # Specific instance type for SonarQube
