packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "jenkins-ami"
  instance_type = "t2.micro"
  region        = "us-east-1" # Use the variable here
  source_ami    = "ami-005fc0f236362e99f"
  ssh_username   = "ubuntu"
}


build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file = "./install_jenkins.yml"
  }
}
