variable "aws_region" {
  description = "The AWS region where resources are deployed"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "instance_vm_id" {
  description = "EC2 Instance AMI ID"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}
variable "subnet_id" {
  description = "ID of the existing Subnet"
  type        = string
}

variable "username" {
  description = "Username for the EC2 instance or related resources"
  type        = string
}

variable "owner_name" {
  description = "The owner of the EC2 instance"
  type        = string
}
