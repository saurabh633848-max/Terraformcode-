terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "instance_campmgmt" {
  ami                         = var.instance_vm_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  tags = {
    Name  = var.instance_name
    Username = var.username
  }
}
