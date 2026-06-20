output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.instance_campmgmt.id
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.instance_campmgmt.private_ip
}

output "aws_region" {
  description = "The AWS region where resources are deployed"
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the existing VPC"
  value       = var.vpc_id
}

output "subnet_id" {
  description = "ID of the existing Subnet"
  value       = var.subnet_id
}

output "instance_name" {
  description = "The name of the EC2 instance"
  value       = var.instance_name
}

output "instance_owner" {
  description = "The owner of the EC2 instance"
  value       = var.owner_name
}
