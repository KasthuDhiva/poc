terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Call the security group modules
module "jenkins_sg" {
  source = "./jenkins_sg"
}

module "sonar_sg" {
  source = "./sonar_sg"
}

module "jenkins_packer" {
  source = "./ansible-packer/jenkins"
}

module "sonar_packer" {
  source = "./ansible-packer/sonar"
}

module "jenkins" {
  source = "./ec2-instance"

  ami_id                   = var.jenkins_ami_id  
  instance_type            = var.jenkins_instance_type
  key_name                 = var.key_name
  security_group_id        = var.jenkins_security_group_id # Use the created Jenkins security group here
  instance_name            = "Jenkins-Instance"
}

module "sonarqube" {
  source = "./ec2-instance"

  ami_id                   = var.sonarqube_ami_id
  instance_type            = var.sonarqube_instance_type
  key_name                 = var.key_name
  security_group_id        = var.sonarqube_security_group_id  # Use the created SonarQube security group here
  instance_name            = "SonarQube-Instance"
}

# Create Ansible inventory file for Jenkins and SonarQube
resource "local_file" "inventory_ini" {
  content = <<EOT
[Jenkins]
jenkins_server ansible_host=${module.jenkins.ec2_public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/kasthuri/poc4.pem

[Sonarqube]
sonarqube_server ansible_host=${module.sonarqube.ec2_public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/kasthuri/poc4.pem
EOT

  filename = "${path.module}/playbook/inventory.ini"
}
# Run Ansible Playbook after generating the inventory file
resource "null_resource" "run_sonarqube_playbooks" {
  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook -i ${path.module}/playbook/inventory.ini ${path.module}/playbook/sonarqube_setup.yml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
    EOT
  }

  depends_on = [local_file.inventory_ini]  # Ensure inventory is created before running playbooks
}

resource "null_resource" "run_jenkins_playbooks" {
  provisioner "local-exec" {
    command = <<-EOT
      bash -c "ansible-playbook -i ${path.module}/playbook/inventory.ini ${path.module}/playbook/jenkins_setup.yml -e 'ansible_ssh_common_args=\"-o StrictHostKeyChecking=no\"'"
    EOT
  }
  depends_on = [local_file.inventory_ini, null_resource.run_sonarqube_playbooks]
}
