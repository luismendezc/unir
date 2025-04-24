packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "source_ami" {
  default = "ami-0a0bfc6462a1bba50"
}

variable "instance_type" {
  default = "t2.micro"
}

source "amazon-ebs" "ubuntu_node_pm2" {
  region                      = var.aws_region
  source_ami                  = var.source_ami
  instance_type               = var.instance_type
  ssh_username                = "ubuntu"
  ami_name                    = "nodejs-nginx-pm2-{{timestamp}}"
  associate_public_ip_address = true
}

build {
  sources = ["source.amazon-ebs.ubuntu_node_pm2"]

  provisioner "shell" {
    script = "setup.sh"
  }
}
