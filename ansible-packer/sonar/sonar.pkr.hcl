packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "source_ami" {
  default = "ami-005fc0f236362e99f"
}

variable "ssh_username" {
  default = "ubuntu"
}

source "amazon-ebs" "ubuntu_ami" {
  region        = var.region
  instance_type = var.instance_type
  source_ami    = var.source_ami
  ssh_username  = var.ssh_username
  ami_name      = "sonarqube-ami"
}

build {
  sources = ["source.amazon-ebs.ubuntu_ami"]

  # Use the Ansible provisioner to run the playbook
  provisioner "ansible" {
    playbook_file = "install_sonarqube.yml"
  }
}
